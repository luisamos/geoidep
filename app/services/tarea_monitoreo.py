"""Estado del proceso de monitoreo en segundo plano, respaldado en base de datos.

El estado vive en una única fila (``id = 1``) de la tabla ``ide.estado_monitoreo``
para que sea **consistente entre los workers de gunicorn**. Antes vivía en una
variable en memoria por-proceso: con ``--workers 3`` cada worker tenía su propia
copia y el polling a ``/principal/estado`` devolvía valores distintos según el
worker que atendía la petición, haciendo que la UI parpadeara entre el botón
"Ejecutar monitoreo" y la ejecución en curso.

Las escrituras usan una conexión independiente (``db.engine``), nunca
``db.session``: el hilo de monitoreo mantiene cambios pendientes en
``db.session`` que sólo se commitean al final de la corrida, así que usar esa
misma sesión para guardar el progreso los commitearía a destiempo.
"""
from __future__ import annotations

import json
import logging

from sqlalchemy import and_, case, func, or_, select, update
from sqlalchemy.dialects.postgresql import insert as pg_insert

from app.extensions import db
from app.models.estado_monitoreo import EstadoMonitoreo

# Una corrida sin actividad durante este tiempo se considera interrumpida
# (worker caído, reinicio a mitad de proceso). Permite relanzar y evita que la
# UI quede "en ejecución" para siempre. El umbral es holgado frente al peor
# caso de un recurso lento (timeout 30 s x 3 reintentos x reintento sin SSL).
UMBRAL_OBSOLETO_MIN = 10

_TABLA = EstadoMonitoreo.__table__

_ESTADO_IDLE = {
    'estado': 'idle',
    'tipo': 'todos',
    'iniciado_por': None,
    'inicio': None,
    'fin': None,
    'total': 0,
    'verificados': 0,
    'porcentaje': 0,
    'resultado': None,
    'error': None,
    'duracion_segundos': None,
}


def _limite_actividad():
    """Instante (en el reloj de la BD) antes del cual una corrida se considera
    sin actividad reciente."""
    return func.now() - func.make_interval(0, 0, 0, 0, 0, UMBRAL_OBSOLETO_MIN)


def asegurar_estado_monitoreo() -> None:
    """Crea la tabla y la fila id=1 si no existen (idempotente).

    Se invoca al crear la app. ``checkfirst`` + ``ON CONFLICT DO NOTHING``
    lo hacen seguro aunque los 3 workers arranquen a la vez. Debe llamarse
    dentro de un app_context.
    """
    seed = (
        pg_insert(_TABLA)
        .values(id=1, estado='idle')
        .on_conflict_do_nothing(index_elements=['id'])
    )
    try:
        with db.engine.begin() as conn:
            _TABLA.create(conn, checkfirst=True)
            conn.execute(seed)
    except Exception:
        logging.exception("No se pudo asegurar la tabla %s", _TABLA.fullname)


class _EstadoTarea:
    """Estado del proceso de monitoreo, respaldado en la fila id=1 de la BD."""

    # ------------------------------------------------------------------
    # Lectura del estado
    # ------------------------------------------------------------------

    def to_dict(self) -> dict:
        c = _TABLA.c
        sql = select(
            c.estado, c.tipo, c.iniciado_por, c.inicio, c.fin,
            c.total, c.verificados, c.resultado, c.error,
            and_(
                c.estado == 'ejecutando',
                c.actualizado_en < _limite_actividad(),
            ).label('obsoleto'),
            case(
                (
                    c.inicio.isnot(None),
                    func.round(func.extract('epoch', func.coalesce(c.fin, func.now()) - c.inicio)),
                ),
                else_=None,
            ).label('duracion_segundos'),
        ).where(c.id == 1)
        try:
            with db.engine.connect() as conn:
                fila = conn.execute(sql).mappings().first()
        except Exception:
            logging.exception("No se pudo leer el estado del monitoreo")
            return dict(_ESTADO_IDLE)

        if fila is None:
            return dict(_ESTADO_IDLE)

        estado = fila['estado']
        error = fila['error']
        # Una corrida "ejecutando" sin actividad reciente se reporta como error
        # para que el frontend deje de mostrar "en ejecución" y permita relanzar.
        if fila['obsoleto']:
            estado = 'error'
            error = error or 'Proceso interrumpido (sin actividad reciente).'

        total = fila['total'] or 0
        verificados = fila['verificados'] or 0
        porcentaje = round(verificados * 100 / total) if total > 0 else 0

        resultado = None
        if fila['resultado']:
            try:
                resultado = json.loads(fila['resultado'])
            except (ValueError, TypeError):
                resultado = None

        duracion = fila['duracion_segundos']

        return {
            'estado': estado,
            'tipo': fila['tipo'] or 'todos',
            'iniciado_por': fila['iniciado_por'],
            'inicio': fila['inicio'].isoformat() if fila['inicio'] else None,
            'fin': fila['fin'].isoformat() if fila['fin'] else None,
            'total': total,
            'verificados': verificados,
            'porcentaje': porcentaje,
            'resultado': resultado,
            'error': error,
            'duracion_segundos': int(duracion) if duracion is not None else None,
        }

    def esta_ejecutando(self) -> bool:
        c = _TABLA.c
        sql = select(
            and_(
                c.estado == 'ejecutando',
                c.actualizado_en >= _limite_actividad(),
            ).label('activo'),
        ).where(c.id == 1)
        try:
            with db.engine.connect() as conn:
                fila = conn.execute(sql).first()
        except Exception:
            logging.exception("No se pudo consultar si el monitoreo está en ejecución")
            return False
        return bool(fila[0]) if fila else False

    # ------------------------------------------------------------------
    # Mutaciones (conexión independiente de db.session)
    # ------------------------------------------------------------------

    def iniciar(self, tipo: str, total: int, usuario: str) -> bool:
        """Marca la tarea como iniciada de forma atómica entre workers.

        El UPDATE condicional es el guard cross-proceso: sólo una petición gana
        la carrera. Retorna ``False`` si ya hay una corrida vigente.
        """
        c = _TABLA.c
        sql = (
            update(_TABLA)
            .where(
                c.id == 1,
                or_(
                    c.estado != 'ejecutando',
                    c.actualizado_en < _limite_actividad(),
                ),
            )
            .values(
                estado='ejecutando',
                tipo=tipo,
                iniciado_por=usuario,
                inicio=func.now(),
                fin=None,
                actualizado_en=func.now(),
                total=total,
                verificados=0,
                resultado=None,
                error=None,
            )
        )
        try:
            with db.engine.begin() as conn:
                resultado = conn.execute(sql)
            return resultado.rowcount == 1
        except Exception:
            logging.exception("No se pudo iniciar la tarea de monitoreo")
            return False

    def actualizar_progreso(self, verificados: int) -> None:
        sql = (
            update(_TABLA)
            .where(_TABLA.c.id == 1)
            .values(verificados=verificados, actualizado_en=func.now())
        )
        try:
            with db.engine.begin() as conn:
                conn.execute(sql)
        except Exception:
            logging.exception("No se pudo actualizar el progreso del monitoreo")

    def completar(self, resultado: dict) -> None:
        sql = (
            update(_TABLA)
            .where(_TABLA.c.id == 1)
            .values(
                estado='completado',
                fin=func.now(),
                actualizado_en=func.now(),
                resultado=json.dumps(resultado),
                verificados=_TABLA.c.total,
            )
        )
        try:
            with db.engine.begin() as conn:
                conn.execute(sql)
        except Exception:
            logging.exception("No se pudo marcar el monitoreo como completado")

    def marcar_error(self, error: str) -> None:
        sql = (
            update(_TABLA)
            .where(_TABLA.c.id == 1)
            .values(estado='error', fin=func.now(), actualizado_en=func.now(), error=error)
        )
        try:
            with db.engine.begin() as conn:
                conn.execute(sql)
        except Exception:
            logging.exception("No se pudo marcar el error del monitoreo")


# Instancia global. El estado real vive en la BD, así que es seguro compartirla
# entre todos los workers/threads de la app.
tarea = _EstadoTarea()
