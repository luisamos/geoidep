from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.orm import aliased
from sqlalchemy.exc import IntegrityError

from extensions import db
from models.instituciones import Institucion, SECTOR_IDS
from routes._helpers import obtener_usuario_actual


bp = Blueprint('instituciones', __name__, url_prefix='/instituciones')

@bp.route('/')
@jwt_required()
def listar():
  sectores = (
    Institucion.query.filter(Institucion.id.in_(SECTOR_IDS))
    .order_by(Institucion.orden.asc(), Institucion.nombre.asc())
    .all()
  )
  return render_template('gestion/instituciones.html', sectores=sectores)


@bp.route('/datos')
@jwt_required()
def datos():
  sector_alias = aliased(Institucion)
  consulta = (
    db.session.query(Institucion, sector_alias.nombre.label('sector_nombre'))
    .outerjoin(sector_alias, Institucion.id_padre == sector_alias.id)
    #.filter(Institucion.id_padre.in_(SECTOR_IDS))
    .filter(Institucion.id >= 45)
    .order_by(Institucion.nombre.asc())
  )
  instituciones = [
    {
      'id': institucion.id,
      'codigo': institucion.codigo or '',
      'ubigeo': institucion.ubigeo or '',
      'nombre': institucion.nombre,
      'nro_ruc': institucion.nro_ruc or '',
      'direccion_web': institucion.direccion_web or '',
      'sigla': institucion.sigla or '',
      'sector_id': institucion.id_padre,
      'sector': sector_nombre or '',
    }
    for institucion, sector_nombre in consulta.all()
  ]
  return jsonify({'instituciones': instituciones})


def _validar_sector(sector_id: int | None) -> bool:
  return sector_id in SECTOR_IDS


def _obtener_datos_institucion(payload: dict[str, object]) -> tuple[dict[str, object], tuple[dict, int] | None]:
  codigo = (payload.get('codigo') or '').strip()
  nombre = (payload.get('nombre') or '').strip()
  sigla = (payload.get('sigla') or '').strip()
  ubigeo = (payload.get('ubigeo') or '').strip()
  nro_ruc = (payload.get('nro_ruc') or '').strip()
  direccion_web = (payload.get('direccion_web') or '').strip()
  sector_id = payload.get('sector_id')

  try:
    sector_id_int = int(sector_id) if sector_id not in (None, '') else None
  except (TypeError, ValueError):
    return {}, (jsonify({'status': 'error', 'message': 'Sector inválido.'}), 400)

  if not nombre:
    return {}, (jsonify({'status': 'error', 'message': 'El nombre es obligatorio.'}), 400)

  if not _validar_sector(sector_id_int):
    return {}, (
      jsonify({'status': 'error', 'message': 'Seleccione un sector válido.'}),
      400,
    )

  datos = {
    'codigo': codigo or None,
    'nombre': nombre,
    'sigla': sigla or None,
    'ubigeo': ubigeo or None,
    'nro_ruc': nro_ruc or None,
    'direccion_web': direccion_web or None,
    'id_padre': sector_id_int,
  }
  return datos, None


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
  payload = request.get_json(silent=True) or {}
  datos, error = _obtener_datos_institucion(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  institucion = Institucion(
    codigo=datos['codigo'],
    nombre=datos['nombre'],
    sigla=datos['sigla'],
    ubigeo=datos['ubigeo'],
    nro_ruc=datos['nro_ruc'],
    direccion_web=datos['direccion_web'],
    id_padre=datos['id_padre'],
    usuario_crea=usuario.id if usuario else 1,
  )
  db.session.add(institucion)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo registrar la institución.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Institución registrada correctamente.'})


@bp.route('/<int:institucion_id>', methods=['PUT'])
@jwt_required()
def actualizar(institucion_id: int):
  institucion = Institucion.query.get(institucion_id)
  if not institucion:
    return jsonify({'status': 'error', 'message': 'Institución no encontrada.'}), 404

  payload = request.get_json(silent=True) or {}
  datos, error = _obtener_datos_institucion(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  institucion.codigo = datos['codigo']
  institucion.nombre = datos['nombre']
  institucion.sigla = datos['sigla']
  institucion.ubigeo = datos['ubigeo']
  institucion.nro_ruc = datos['nro_ruc']
  institucion.direccion_web = datos['direccion_web']
  institucion.id_padre = datos['id_padre']
  institucion.usuario_modifica = usuario.id if usuario else None
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo actualizar la institución.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Institución actualizada correctamente.'})


@bp.route('/<int:institucion_id>', methods=['DELETE'])
@jwt_required()
def eliminar(institucion_id: int):
  institucion = Institucion.query.get(institucion_id)
  if not institucion:
    return jsonify({'status': 'error', 'message': 'Institución no encontrada.'}), 404

  db.session.delete(institucion)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se puede eliminar la institución porque está asociada a otros registros.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Institución eliminada correctamente.'})