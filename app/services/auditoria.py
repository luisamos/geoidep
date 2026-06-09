"""Registro de auditoría (tablas H*) compartido entre rutas.

Cada función toma la entidad fuente, la acción (INSERT/UPDATE/DELETE) y el
id del usuario que la ejecuta, y crea la fila correspondiente en la tabla
histórica. El commit es responsabilidad del llamador.
"""
from __future__ import annotations

from typing import Optional

from app.extensions import db
from app.models.actividades import Actividad, HActividad
from app.models.capas_geograficas import (
  CapaGeografica,
  HCapaGeografica,
  HServicioGeografico,
  ServicioGeografico,
)
from app.models.herramientas_geograficas import (
  HHerramientaGeografica,
  HerramientaGeografica,
)


def registrar_historico_capa(
  capa: CapaGeografica,
  accion: str,
  usuario_id: Optional[int],
) -> None:
  historial = HCapaGeografica(
    id_capa_geografica=capa.id,
    nombre=capa.nombre,
    descripcion=capa.descripcion,
    fecha_inicio=capa.fecha_inicio,
    fecha_fin=capa.fecha_fin,
    proyeccion=capa.proyeccion,
    tipo_capa=capa.tipo_capa,
    id_categoria=capa.id_categoria,
    id_institucion=capa.id_institucion,
    usuario_registro=capa.usuario_registro,
    fecha_registro=capa.fecha_registro,
    accion=accion,
    usuario_accion=usuario_id,
  )
  db.session.add(historial)


def registrar_historico_servicio(
  servicio: ServicioGeografico,
  accion: str,
  usuario_id: Optional[int],
) -> None:
  historial = HServicioGeografico(
    id_servicio_geografico=servicio.id,
    id_capa_geografica=servicio.id_capa_geografica,
    id_tipo=servicio.id_tipo,
    direccion_web=servicio.direccion_web,
    nombre_capa=servicio.nombre_capa,
    titulo_capa=servicio.titulo_capa,
    estado=servicio.estado,
    descarga=servicio.descarga,
    url_doc_descarga=servicio.url_doc_descarga,
    id_layer=servicio.id_layer,
    usuario_registro=servicio.usuario_registro,
    fecha_registro=servicio.fecha_registro,
    accion=accion,
    usuario_accion=usuario_id,
  )
  db.session.add(historial)


def registrar_historico_herramienta(
  herramienta: HerramientaGeografica,
  accion: str,
  usuario_id: Optional[int],
) -> None:
  historial = HHerramientaGeografica(
    id_herramienta_geografica=herramienta.id,
    nombre=herramienta.nombre,
    descripcion=herramienta.descripcion,
    estado=herramienta.estado,
    recurso=herramienta.recurso,
    id_tipo=herramienta.id_tipo,
    id_categoria=herramienta.id_categoria,
    id_institucion=herramienta.id_institucion,
    usuario_registro=herramienta.usuario_registro,
    fecha_registro=herramienta.fecha_registro,
    accion=accion,
    usuario_accion=usuario_id,
  )
  db.session.add(historial)


def registrar_historico_actividad(
  act: Actividad,
  accion: str,
  usuario_id: Optional[int],
) -> None:
  historial = HActividad(
    id_documento=act.id_documento,
    id_institucion=act.id_institucion,
    id_tipo_actividad=act.id_tipo_actividad,
    f_atencion=act.f_atencion,
    estado=act.estado,
    description=act.description,
    usuario_registro=act.usuario_registro,
    fecha_registro=act.fecha_registro,
    accion=accion,
    usuario_accion=usuario_id,
  )
  db.session.add(historial)
