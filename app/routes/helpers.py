from __future__ import annotations

from typing import Optional

from flask import g
from flask_jwt_extended import get_jwt_identity, verify_jwt_in_request
from sqlalchemy.orm import joinedload

from app.models import Rol, Usuario
from app.models.usuarios import UsuarioRol

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
  return obtener_nivel_datos_usuario(usuario) >= 2


def usuario_restringido_a_su_entidad(usuario: Optional[Usuario]) -> bool:
  return not usuario_puede_ver_todas_entidades(usuario)

def obtener_id_desde_identidad(identity):
  if isinstance(identity, dict):
    return identity.get('id_usuario')

  if isinstance(identity, str):
    try:
      return int(identity)
    except ValueError:
      return identity

  return identity

def obtener_usuario_actual(*, requerido: bool = False) -> Optional[Usuario]:
  if hasattr(g, 'usuario_actual'):
    return g.usuario_actual

  try:
    verify_jwt_in_request(optional=not requerido)
  except Exception:
    g.usuario_actual = None
    return None

  identidad = get_jwt_identity()
  id_usuario = obtener_id_desde_identidad(identidad)
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