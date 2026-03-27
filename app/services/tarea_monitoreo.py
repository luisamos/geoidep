"""Gestión del estado global del proceso de monitoreo en segundo plano.

Permite que un único proceso de monitoreo se ejecute a la vez. Cualquier
usuario puede consultar el estado en tiempo real mediante polling al endpoint
/principal/estado, sin necesidad de volver a lanzar el proceso.
"""
from __future__ import annotations

import threading
from datetime import datetime
from typing import Optional


class _EstadoTarea:
    """Estado compartido y thread-safe del proceso de monitoreo."""

    def __init__(self) -> None:
        self._lock = threading.Lock()
        self.estado: str = 'idle'          # idle | ejecutando | completado | error
        self.tipo: str = 'todos'
        self.iniciado_por: Optional[str] = None
        self.inicio: Optional[datetime] = None
        self.fin: Optional[datetime] = None
        self.total: int = 0
        self.verificados: int = 0
        self.resultado: Optional[dict] = None
        self.error: Optional[str] = None

    # ------------------------------------------------------------------
    # Lectura del estado (segura para cualquier hilo)
    # ------------------------------------------------------------------

    def to_dict(self) -> dict:
        with self._lock:
            duracion = None
            if self.inicio:
                ref = self.fin or datetime.now()
                duracion = round((ref - self.inicio).total_seconds())

            porcentaje = (
                round(self.verificados * 100 / self.total)
                if self.total > 0 else 0
            )

            return {
                'estado': self.estado,
                'tipo': self.tipo,
                'iniciado_por': self.iniciado_por,
                'inicio': self.inicio.isoformat() if self.inicio else None,
                'fin': self.fin.isoformat() if self.fin else None,
                'total': self.total,
                'verificados': self.verificados,
                'porcentaje': porcentaje,
                'resultado': self.resultado,
                'error': self.error,
                'duracion_segundos': duracion,
            }

    def esta_ejecutando(self) -> bool:
        with self._lock:
            return self.estado == 'ejecutando'

    # ------------------------------------------------------------------
    # Mutaciones (sólo desde el hilo de background o el endpoint)
    # ------------------------------------------------------------------

    def iniciar(self, tipo: str, total: int, usuario: str) -> bool:
        """Marca la tarea como iniciada. Retorna False si ya está en ejecución."""
        with self._lock:
            if self.estado == 'ejecutando':
                return False
            self.estado = 'ejecutando'
            self.tipo = tipo
            self.iniciado_por = usuario
            self.inicio = datetime.now()
            self.fin = None
            self.total = total
            self.verificados = 0
            self.resultado = None
            self.error = None
            return True

    def actualizar_progreso(self, verificados: int) -> None:
        with self._lock:
            self.verificados = verificados

    def completar(self, resultado: dict) -> None:
        with self._lock:
            self.estado = 'completado'
            self.fin = datetime.now()
            self.resultado = resultado
            self.verificados = self.total

    def marcar_error(self, error: str) -> None:
        with self._lock:
            self.estado = 'error'
            self.fin = datetime.now()
            self.error = error


# Instancia global única compartida por todos los workers/threads de la app
tarea = _EstadoTarea()
