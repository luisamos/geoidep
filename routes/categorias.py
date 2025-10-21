from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.exc import IntegrityError

from extensions import db
from models.categorias import Categoria
from routes._helpers import obtener_usuario_actual


bp = Blueprint('categorias', __name__, url_prefix='/categorias')


@bp.route('/')
@jwt_required()
def listar():
  return render_template('gestion/categorias.html')


@bp.route('/datos')
@jwt_required()
def datos():
  categorias = (
    Categoria.query.filter_by(id_padre=1)
    .order_by(Categoria.nombre.asc())
    .all()
  )
  data = [
    {
      'id': categoria.id,
      'codigo': categoria.codigo,
      'nombre': categoria.nombre,
      'sigla': categoria.sigla or '',
      'definicion': categoria.definicion or '',
    }
    for categoria in categorias
  ]
  return jsonify({'categorias': data})


def _obtener_datos_categoria(payload: dict[str, object]) -> tuple[dict[str, object], tuple[dict, int] | None]:
  codigo = (payload.get('codigo') or '').strip()
  nombre = (payload.get('nombre') or '').strip()
  sigla = (payload.get('sigla') or '').strip()
  definicion = (payload.get('definicion') or '').strip()

  if not codigo or not nombre or not sigla:
    return (
      {},
      (
        jsonify(
          {
            'status': 'error',
            'message': 'Complete los campos obligatorios (código, nombre y sigla).',
          }
        ),
        400,
      ),
    )

  datos = {
    'codigo': codigo,
    'nombre': nombre,
    'sigla': sigla,
    'definicion': definicion or None,
  }
  return datos, None


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
  payload = request.get_json(silent=True) or {}
  datos, error = _obtener_datos_categoria(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  categoria = Categoria(
    codigo=datos['codigo'],
    nombre=datos['nombre'],
    sigla=datos['sigla'],
    definicion=datos['definicion'],
    id_padre=1,
    usuario_crea=usuario.id if usuario else 1,
  )
  db.session.add(categoria)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo registrar la categoría.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Categoría registrada correctamente.'})


@bp.route('/<int:categoria_id>', methods=['PUT'])
@jwt_required()
def actualizar(categoria_id: int):
  categoria = Categoria.query.get(categoria_id)
  if not categoria or categoria.id_padre != 1:
    return jsonify({'status': 'error', 'message': 'Categoría no encontrada.'}), 404

  payload = request.get_json(silent=True) or {}
  datos, error = _obtener_datos_categoria(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  categoria.codigo = datos['codigo']
  categoria.nombre = datos['nombre']
  categoria.sigla = datos['sigla']
  categoria.definicion = datos['definicion']
  categoria.usuario_modifica = usuario.id if usuario else None
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo actualizar la categoría.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Categoría actualizada correctamente.'})


@bp.route('/<int:categoria_id>', methods=['DELETE'])
@jwt_required()
def eliminar(categoria_id: int):
  categoria = Categoria.query.get(categoria_id)
  if not categoria or categoria.id_padre != 1:
    return jsonify({'status': 'error', 'message': 'Categoría no encontrada.'}), 404

  db.session.delete(categoria)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se puede eliminar la categoría porque tiene registros asociados.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Categoría eliminada correctamente.'})