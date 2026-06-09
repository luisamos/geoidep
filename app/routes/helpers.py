from __future__ import annotations

from typing import Optional

from flask import g, redirect, url_for
from flask_jwt_extended import get_jwt_identity, unset_jwt_cookies, verify_jwt_in_request
from sqlalchemy.orm import joinedload

from app.config import ID_INSTITUCION_ADMIN
from app.models import Rol, Usuario
from app.models.usuarios import UsuarioRol


def redirect_to_login():
  """Redirige al endpoint de ingreso y limpia las cookies JWT."""
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta


def obtener_nivel_datos_usuario(usuario: Optional[Usuario]) -> int:
  if not usuario:
    return 1
  niveles = [
    int(asignacion.nivel)
    for asignacion in (usuario.usuarios or [])
    if asignacion and asignacion.nivel is not None
  ]
  if not niveles:
    return 1
  return max(niveles)


def usuario_puede_ver_todas_entidades(usuario: Optional[Usuario]) -> bool:
  return bool(usuario and usuario.id_institucion == ID_INSTITUCION_ADMIN)


def usuario_restringido_a_su_entidad(usuario: Optional[Usuario]) -> bool:
  return not usuario_puede_ver_todas_entidades(usuario)


def usuario_puede_editar(usuario: Optional[Usuario]) -> bool:
  return obtener_nivel_datos_usuario(usuario) >= 2


def obtener_usuario_actual(*, requerido: bool = False) -> Optional[Usuario]:
  if hasattr(g, 'usuario_actual'):
    return g.usuario_actual

  try:
    verify_jwt_in_request(optional=not requerido)
  except Exception:
    g.usuario_actual = None
    return None

  # El claim 'sub' del JWT puede ser dict (legacy), str numérico o int;
  # el frontend antiguo guardaba {'id_usuario': ...} y el actual guarda
  # el id como string.
  identidad = get_jwt_identity()
  if isinstance(identidad, dict):
    id_usuario = identidad.get('id_usuario')
  elif isinstance(identidad, str):
    try:
      id_usuario = int(identidad)
    except ValueError:
      id_usuario = identidad
  else:
    id_usuario = identidad

  if not id_usuario:
    g.usuario_actual = None
    return None

  usuario = (
    Usuario.query.filter(Usuario.id == id_usuario)
    .options(
      joinedload(Usuario.institucion),
      joinedload(Usuario.perfil),
      joinedload(Usuario.usuarios).joinedload(UsuarioRol.roles),
    )
    .first()
  )

  if usuario:
    usuario.nivel_datos = obtener_nivel_datos_usuario(usuario)
    usuario.puede_ver_todas_entidades = usuario_puede_ver_todas_entidades(usuario)
    usuario.restringido_a_su_entidad = not usuario.puede_ver_todas_entidades
    roles_asignados = [asignacion.roles for asignacion in usuario.usuarios if asignacion.roles]
    ids_padre = sorted({rol.id_padre for rol in roles_asignados if rol.id_padre and rol.id_padre > 0})
    if ids_padre:
      usuario.roles_padre_menu = (
        Rol.query.filter(Rol.id.in_(ids_padre))
        .order_by(Rol.orden, Rol.id)
        .all()
      )
    else:
      usuario.roles_padre_menu = []

  if (
    not usuario
    or not usuario.estado
    or not usuario.idep
  ):
    g.usuario_actual = None
    return None

  g.usuario_actual = usuario
  return usuario