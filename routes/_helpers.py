
from __future__ import annotations

from typing import Optional

from flask import g
from flask_jwt_extended import get_jwt_identity, verify_jwt_in_request
from sqlalchemy.orm import joinedload

from models.usuarios import Usuario


def _obtener_id_desde_identidad(identity):
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
  id_usuario = _obtener_id_desde_identidad(identidad)
  if not id_usuario:
    g.usuario_actual = None
    return None

  usuario = (
    Usuario.query.filter(Usuario.id == id_usuario)
    .options(
      joinedload(Usuario.institucion),
      joinedload(Usuario.perfil),
    )
    .first()
  )

  if not usuario or not usuario.estado or not usuario.geoidep:
    g.usuario_actual = None
    return None

  g.usuario_actual = usuario
  return usuario