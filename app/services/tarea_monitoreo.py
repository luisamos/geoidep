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
from typing import Optional

from sqlalchemy import text

from app.config import SCHEMA_IDE
from app.extensions import db

# Una corrida sin actividad durante este tiempo se considera interrumpida
# (worker caído, reinicio a mitad de proceso). Permite relanzar y evita que la
# UI quede "en ejecución" para siempre. El umbral es holgado frente al peor
# caso de un recurso lento (timeout 30 s x 3 reintentos x reintento sin SSL).
UMBRAL_OBSOLETO_MIN = 10

_TABLA = f"{SCHEMA_IDE}.estado_monitoreo"

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


def asegurar_estado_monitoreo() -> None:
    """Crea la tabla y la fila id=1 si no existen (idempotente).

    Se invoca al crear la app. ``CREATE TABLE IF NOT EXISTS`` + ``ON CONFLICT``
    lo hacen seguro aunque los 3 workers arranquen a la vez. Debe llamarse
    dentro de un app_context.
    """
    ddl = text(f"""
        CREATE TABLE IF NOT EXISTS {_TABLA} (
            id              integer PRIMARY KEY DEFAULT 1 CHECK (id = 1),
            estado          character varying(20) NOT NULL DEFAULT 'idle',
            tipo            character varying(40),
            iniciado_por    character varying(255),
            inicio          timestamp with time zone,
            fin             timestamp with time zone,
            actualizado_en  timestamp with time zone,
            total           integer NOT NULL DEFAULT 0,
            verificados     integer NOT NULL DEFAULT 0,
            resultado       text,
            error           text
        )
    """)
    seed = text(
        f"INSERT INTO {_TABLA} (id, estado) VALUES (1, 'idle') "
        "ON CONFLICT (id) DO NOTHING"
    )
    try:
        with db.engine.begin() as conn:
            conn.execute(ddl)
            conn.execute(seed)
    except Exception:
        logging.exception("No se pudo asegurar la tabla %s", _TABLA)


class _EstadoTarea:
    """Estado del proceso de monitoreo, respaldado en la fila id=1 de la BD."""

    # ------------------------------------------------------------------
    # Lectura del estado
    # ------------------------------------------------------------------

    def to_dict(self) -> dict:
        sql = text(f"""
            SELECT estado, tipo, iniciado_por, inicio, fin,
                   total, verificados, resultado, error,
                   (estado = 'ejecutando'
                    AND actualizado_en < now() - (interval '1 minute' * :umbral))
                       AS obsoleto,
                   CASE WHEN inicio IS NOT NULL
                        THEN round(extract(epoch FROM (coalesce(fin, now()) - inicio)))
                        ELSE NULL END AS duracion_segundos
            FROM {_TABLA}
            WHERE id = 1
        """)
        try:
            with db.engine.connect() as conn:
                fila = conn.execute(sql, {'umbral': UMBRAL_OBSOLETO_MIN}).mappings().first()
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
        sql = text(f"""
            SELECT (estado = 'ejecutando'
                    AND actualizado_en >= now() - (interval '1 minute' * :umbral))
                       AS activo
            FROM {_TABLA}
            WHERE id = 1
        """)
        try:
            with db.engine.connect() as conn:
                fila = conn.execute(sql, {'umbral': UMBRAL_OBSOLETO_MIN}).first()
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
        sql = text(f"""
            UPDATE {_TABLA}
            SET estado = 'ejecutando',
                tipo = :tipo,
                iniciado_por = :usuario,
                inicio = now(),
                fin = NULL,
                actualizado_en = now(),
                total = :total,
                verificados = 0,
                resultado = NULL,
                error = NULL
            WHERE id = 1
              AND (estado <> 'ejecutando'
                   OR actualizado_en < now() - (interval '1 minute' * :umbral))
        """)
        try:
            with db.engine.begin() as conn:
                resultado = conn.execute(sql, {
                    'tipo': tipo,
                    'usuario': usuario,
                    'total': total,
                    'umbral': UMBRAL_OBSOLETO_MIN,
                })
            return resultado.rowcount == 1
        except Exception:
            logging.exception("No se pudo iniciar la tarea de monitoreo")
            return False

    def actualizar_progreso(self, verificados: int) -> None:
        sql = text(f"""
            UPDATE {_TABLA}
            SET verificados = :verificados, actualizado_en = now()
            WHERE id = 1
        """)
        try:
            with db.engine.begin() as conn:
                conn.execute(sql, {'verificados': verificados})
        except Exception:
            logging.exception("No se pudo actualizar el progreso del monitoreo")

    def completar(self, resultado: dict) -> None:
        sql = text(f"""
            UPDATE {_TABLA}
            SET estado = 'completado',
                fin = now(),
                actualizado_en = now(),
                resultado = :resultado,
                verificados = total
            WHERE id = 1
        """)
        try:
            with db.engine.begin() as conn:
                conn.execute(sql, {'resultado': json.dumps(resultado)})
        except Exception:
            logging.exception("No se pudo marcar el monitoreo como completado")

    def marcar_error(self, error: str) -> None:
        sql = text(f"""
            UPDATE {_TABLA}
            SET estado = 'error', fin = now(), actualizado_en = now(), error = :error
            WHERE id = 1
        """)
        try:
            with db.engine.begin() as conn:
                conn.execute(sql, {'error': error})
        except Exception:
            logging.exception("No se pudo marcar el error del monitoreo")


# Instancia global. El estado real vive en la BD, así que es seguro compartirla
# entre todos los workers/threads de la app.
tarea = _EstadoTarea()
