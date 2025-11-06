from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.exc import IntegrityError

from apps.extensions import db
from apps.models import Categoria
from apps.models import Persona
from .helpers import obtener_usuario_actual

TIPOS_DOCUMENTO = [
  {'id': 1, 'nombre': 'Documento Nacional de Identidad'},
  {'id': 2, 'nombre': 'Carnet de extranjería'},
]

PERSONAL_CATALOGO_ID_PADRE = 1

bp = Blueprint('personal', __name__, url_prefix='/personal')

@bp.route('/')
@jwt_required()
def listar():
  usuario = obtener_usuario_actual(requerido=True)
  return render_template(
    'gestion/personal.html',
    tipos_documento=TIPOS_DOCUMENTO,
    usuario_actual=usuario,
  )

@bp.route('/catalogo')
@jwt_required()
def catalogo_listar():
  catalogos = (
    Categoria.query.filter_by(id_padre=PERSONAL_CATALOGO_ID_PADRE)
    .order_by(Categoria.nombre.asc())
    .all()
  )
  data = [
    {
      'id': item.id,
      'codigo': item.codigo,
      'nombre': item.nombre,
      'sigla': item.sigla or '',
      'descripcion': item.definicion or '',
    }
    for item in catalogos
  ]
  return jsonify({'catalogo': data})


def obtener_datos_catalogo(payload: dict[str, object]) -> tuple[dict[str, object], tuple[dict, int] | None]:
  codigo = (payload.get('codigo') or '').strip()
  nombre = (payload.get('nombre') or '').strip()
  sigla = (payload.get('sigla') or '').strip()
  descripcion = (payload.get('descripcion') or '').strip()

  if not codigo or not nombre or not sigla:
    return (
      {},
      (
        jsonify(
          {
            'status': 'error',
            'message': 'Ingrese código, nombre y sigla.',
          }
        ),
        400,
      ),
    )

  datos = {
    'codigo': codigo,
    'nombre': nombre,
    'sigla': sigla,
    'descripcion': descripcion or None,
  }
  return datos, None


@bp.route('/catalogo', methods=['POST'])
@jwt_required()
def catalogo_crear():
  payload = request.get_json(silent=True) or {}
  datos, error = obtener_datos_catalogo(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  registro = Categoria(
    codigo=datos['codigo'],
    nombre=datos['nombre'],
    sigla=datos['sigla'],
    definicion=datos['descripcion'],
    id_padre=PERSONAL_CATALOGO_ID_PADRE,
    usuario_crea=usuario.id if usuario else 1,
  )
  db.session.add(registro)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo registrar el personal.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Registro guardado correctamente.'})


@bp.route('/catalogo/<int:registro_id>', methods=['PUT'])
@jwt_required()
def catalogo_actualizar(registro_id: int):
  registro = Categoria.query.get(registro_id)
  if not registro or registro.id_padre != PERSONAL_CATALOGO_ID_PADRE:
    return jsonify({'status': 'error', 'message': 'Registro no encontrado.'}), 404

  payload = request.get_json(silent=True) or {}
  datos, error = obtener_datos_catalogo(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  registro.codigo = datos['codigo']
  registro.nombre = datos['nombre']
  registro.sigla = datos['sigla']
  registro.definicion = datos['descripcion']
  registro.usuario_modifica = usuario.id if usuario else None
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo actualizar el registro.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Registro actualizado correctamente.'})


@bp.route('/catalogo/<int:registro_id>', methods=['DELETE'])
@jwt_required()
def catalogo_eliminar(registro_id: int):
  registro = Categoria.query.get(registro_id)
  if not registro or registro.id_padre != PERSONAL_CATALOGO_ID_PADRE:
    return jsonify({'status': 'error', 'message': 'Registro no encontrado.'}), 404

  db.session.delete(registro)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se puede eliminar el registro porque está asociado a otros datos.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Registro eliminado correctamente.'})


@bp.route('/personas')
@jwt_required()
def personas_listar():
  personas = (
    Persona.query.filter(Persona.id > 1)
    .order_by(Persona.id.asc())
    .all()
  )
  data = []
  for persona in personas:
    tiene_usuario = any(usuario.estado for usuario in persona.usuarios)
    data.append(
      {
        'id': persona.id,
        'id_tipo_documento': persona.id_tipo_documento,
        'numero_documento': persona.numero_documento or '',
        'nombres_apellidos': persona.nombres_apellidos or '',
        'celular': persona.celular or '',
        'tiene_usuario': tiene_usuario,
      }
    )
  return jsonify({'personas': data})


def _obtener_datos_persona(payload: dict[str, object]) -> tuple[dict[str, object], tuple[dict, int] | None]:
  id_tipo_documento = payload.get('id_tipo_documento')
  numero_documento = (payload.get('numero_documento') or '').strip()
  nombres_apellidos = (payload.get('nombres_apellidos') or '').strip()
  celular = (payload.get('celular') or '').strip()

  try:
    id_tipo_documento_int = int(id_tipo_documento)
  except (TypeError, ValueError):
    return {}, (jsonify({'status': 'error', 'message': 'Tipo de documento inválido.'}), 400)

  if id_tipo_documento_int not in {opcion['id'] for opcion in TIPOS_DOCUMENTO}:
    return {}, (jsonify({'status': 'error', 'message': 'Seleccione un tipo de documento válido.'}), 400)

  if not numero_documento or not nombres_apellidos:
    return (
      {},
      (
        jsonify({'status': 'error', 'message': 'Ingrese número de documento y nombres completos.'}),
        400,
      ),
    )

  datos = {
    'id_tipo_documento': id_tipo_documento_int,
    'numero_documento': numero_documento,
    'nombres_apellidos': nombres_apellidos,
    'celular': celular or None,
  }
  return datos, None


@bp.route('/personas', methods=['POST'])
@jwt_required()
def personas_crear():
  payload = request.get_json(silent=True) or {}
  datos, error = _obtener_datos_persona(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  persona = Persona(
    id_tipo_documento=datos['id_tipo_documento'],
    numero_documento=datos['numero_documento'],
    nombres_apellidos=datos['nombres_apellidos'],
    celular=datos['celular'],
    usuario_crea=usuario.id if usuario else 1,
  )
  db.session.add(persona)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo registrar a la persona.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Persona registrada correctamente.'})


@bp.route('/personas/<int:id_persona>', methods=['PUT'])
@jwt_required()
def personas_actualizar(id_persona: int):
  persona = Persona.query.get(id_persona)
  if not persona:
    return jsonify({'status': 'error', 'message': 'Persona no encontrada.'}), 404

  payload = request.get_json(silent=True) or {}
  datos, error = _obtener_datos_persona(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  persona.id_tipo_documento = datos['id_tipo_documento']
  persona.numero_documento = datos['numero_documento']
  persona.nombres_apellidos = datos['nombres_apellidos']
  persona.celular = datos['celular']
  persona.usuario_modifica = usuario.id if usuario else None
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo actualizar a la persona.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Persona actualizada correctamente.'})


@bp.route('/personas/<int:id_persona>', methods=['DELETE'])
@jwt_required()
def personas_eliminar(id_persona: int):
  persona = Persona.query.get(id_persona)
  if not persona:
    return jsonify({'status': 'error', 'message': 'Persona no encontrada.'}), 404

  if persona.usuarios:
    return (
      jsonify({'status': 'error', 'message': 'No se puede eliminar a la persona porque tiene usuarios asociados.'}),
      400,
    )

  db.session.delete(persona)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify({'status': 'error', 'message': 'No se pudo eliminar a la persona.'}),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Persona eliminada correctamente.'})