from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy import func, text
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from extensions import db
from models.categorias import Categoria
from models.herramientas_digitales import HerramientaDigital
from models.instituciones import Institucion
from models.tipos_servicios import TipoServicio
from routes._helpers import obtener_usuario_actual

bp = Blueprint('herramientas_digitales', __name__, url_prefix='/herramientas_digitales')

EXCLUDED_PARENT_IDS = tuple(range(10))

def sincronizar_secuencia(modelo):
  tabla = modelo.__table__
  pk_columna = next(iter(tabla.primary_key.columns))
  atributo_pk = getattr(modelo, pk_columna.name)
  max_id = db.session.query(func.coalesce(func.max(atributo_pk), 0)).scalar()
  nombre_secuencia = f"{tabla.name}_{pk_columna.name}_seq"
  if tabla.schema:
    nombre_secuencia = f"{tabla.schema}.{nombre_secuencia}"
  valor = max_id if max_id else 1
  db.session.execute(
    text("SELECT setval(:secuencia::regclass, :valor, :llamado)"),
    {
      'secuencia': nombre_secuencia,
      'valor': valor,
      'llamado': bool(max_id),
    },
  )

def obtener_instituciones_para(usuario):
  if not usuario:
    return []
  consulta = Institucion.query
  if usuario.es_gestor:
    consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  else:
    consulta = consulta.filter(~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS))
  return consulta.order_by(Institucion.id.asc()).all()

@bp.route('/')
@jwt_required()
def inicio():
  usuario = obtener_usuario_actual(requerido=True)
  categorias = (
    Categoria.query.filter_by(id_padre=1)
    .order_by(Categoria.nombre)
    .all()
  )
  tipos_servicio = (
    TipoServicio.query.filter_by(id_padre=1)
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )
  instituciones = obtener_instituciones_para(usuario)
  instituciones_disponibles = [
    {
      'id': institucion.id,
      'nombre': institucion.nombre or '',
      'sigla': institucion.sigla or '',
    }
    for institucion in instituciones
  ]
  institucion_usuario = usuario.institucion if usuario else None
  puede_editar_institucion = usuario.puede_gestionar_multiples_instituciones if usuario else False
  return render_template(
    'gestion/herramientas_digitales.html',
    categorias=categorias,
    tipos_servicio=tipos_servicio,
    institucion_usuario=institucion_usuario,
    instituciones_disponibles=instituciones_disponibles,
    puede_editar_institucion=puede_editar_institucion,
  )

@bp.route('/listar')
@jwt_required()
def listar():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return (
      jsonify({'status': 'error', 'message': 'Sesión no válida.'}),
      401,
    )

  consulta = (
    HerramientaDigital.query.options(
      joinedload(HerramientaDigital.categoria),
      joinedload(HerramientaDigital.tipo_servicio),
      joinedload(HerramientaDigital.institucion),
    )
    .order_by(HerramientaDigital.nombre)
  )

  if usuario.es_gestor:
    consulta = consulta.filter(
      HerramientaDigital.id_institucion == usuario.id_institucion
    )

  herramientas = consulta.all()

  data = {
    'activos': [],
    'inactivos': [],
    'sin_estado': [],
  }

  for herramienta in herramientas:
    estado = herramienta.estado
    if estado is None:
      estado_display = 'Sin estado'
      destino = data['sin_estado']
    elif estado == 1:
      estado_display = 'Activo'
      destino = data['activos']
    elif estado == 0:
      estado_display = 'Inactivo'
      destino = data['inactivos']
    else:
      estado_display = str(estado)
      destino = data['sin_estado']

    destino.append(
      {
        'id': herramienta.id,
        'nombre': herramienta.nombre,
        'categoria': herramienta.categoria.nombre if herramienta.categoria else None,
        'id_categoria': herramienta.id_categoria,
        'tipo_servicio': herramienta.tipo_servicio.nombre if herramienta.tipo_servicio else None,
        'id_tipo_servicio': herramienta.id_tipo_servicio,
        'institucion': herramienta.institucion.nombre if herramienta.institucion else None,
        'id_institucion': herramienta.id_institucion,
        'estado': estado,
        'estado_display': estado_display,
        'estado_icono': herramienta.estado_icono,
        'recurso': herramienta.recurso,
        'descripcion': herramienta.descripcion,
      }
    )

  return jsonify(data)

@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
  payload = request.get_json(silent=True) or {}
  datos, error = validar_payload_herramienta(payload)
  if error:
    return error

  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se pudo determinar la institución del usuario.',
        }
      ),
      401,
    )

  institucion_payload = payload.get('id_institucion')
  institucion_id_payload = None
  if institucion_payload not in (None, ''):
    try:
      institucion_id_payload = int(institucion_payload)
    except (TypeError, ValueError):
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'La institución enviada no es válida.',
          }
        ),
        400,
      )

  if usuario.es_gestor:
    id_institucion = usuario.id_institucion
    if institucion_id_payload and institucion_id_payload != id_institucion:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'No puedes registrar herramientas para otra institución.',
          }
        ),
        403,
      )
  else:
    id_institucion = institucion_id_payload or usuario.id_institucion

  if not id_institucion:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se pudo establecer la institución para la herramienta.',
        }
      ),
      400,
    )

  estado = datos['estado'] if datos['estado_incluido'] else None

  sincronizar_secuencia(HerramientaDigital)
  herramienta = HerramientaDigital(
    nombre=datos['nombre'],
    descripcion=datos['descripcion'],
    estado=estado,
    recurso=datos['recurso'],
    id_tipo_servicio=datos['tipo'].id,
    id_categoria=datos['categoria'].id,
    id_institucion=id_institucion,
    usuario_crea=usuario.id,
  )

  db.session.add(herramienta)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se pudo registrar la herramienta digital.',
        }
      ),
      400,
    )

  return jsonify({'status': 'success', 'herramienta_id': herramienta.id}), 201

def validar_payload_herramienta(payload, *, requiere_nombre=True):
  nombre = (payload.get('nombre') or '').strip()
  if requiere_nombre and not nombre:
    return None, (
      jsonify({'status': 'error', 'message': 'El nombre es obligatorio.'}),
      400,
    )

  try:
    id_tipo = int(payload.get('id_tipo_servicio'))
    id_categoria = int(payload.get('id_categoria'))
  except (TypeError, ValueError):
    return None, (
      jsonify(
        {
          'status': 'error',
          'message': 'Los identificadores enviados no son válidos.',
        }
      ),
      400,
    )

  tipo = TipoServicio.query.get(id_tipo)
  categoria = Categoria.query.get(id_categoria)
  if not tipo or not categoria:
    return None, (
      jsonify(
        {
          'status': 'error',
          'message': 'No se encontró la información seleccionada.',
        }
      ),
      404,
    )

  descripcion = payload.get('descripcion')
  if descripcion is not None:
    descripcion = descripcion.strip()
    if len(descripcion) > 1000:
      return None, (
        jsonify(
          {
            'status': 'error',
            'message': 'La descripción no puede superar los 1000 caracteres.',
          }
        ),
        400,
      )
    if not descripcion:
      descripcion = None

  estado_incluido = 'estado' in payload
  estado = payload.get('estado')
  if estado in ('', None):
      estado = None
  elif estado_incluido:
    try:
      estado = int(estado)
    except (TypeError, ValueError):
      return None, (
          jsonify(
            {
              'status': 'error',
              'message': 'El estado debe ser un número entero.',
            }
          ),
          400,
      )

  recurso = payload.get('recurso')
  if recurso is not None:
    recurso = recurso.strip() or None

  datos = {
    'nombre': nombre,
    'tipo': tipo,
    'categoria': categoria,
    'descripcion': descripcion,
    'estado': estado,
    'estado_incluido': estado_incluido,
    'recurso': recurso,
  }
  return datos, None

@bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def actualizar(id):
    usuario = obtener_usuario_actual(requerido=True)
    if not usuario:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'No se pudo determinar la institución del usuario.',
          }
        ),
        401,
      )

    herramienta = HerramientaDigital.query.get(id)
    if not herramienta:
      return jsonify({'status': 'error', 'message': 'Herramienta no encontrada.'}), 404

    if usuario.es_gestor and herramienta.id_institucion not in (None, usuario.id_institucion):
        return (
          jsonify(
            {
              'status': 'error',
              'message': 'No puedes modificar herramientas de otra institución.',
            }
          ),
          403,
        )

    payload = request.get_json(silent=True) or {}
    datos, error = validar_payload_herramienta(payload)
    if error:
        return error

    institucion_payload = payload.get('id_institucion')
    if institucion_payload not in (None, '') and not usuario.es_gestor:
      try:
        herramienta.id_institucion = int(institucion_payload)
      except (TypeError, ValueError):
        return (
          jsonify(
            {
              'status': 'error',
              'message': 'La institución enviada no es válida.',
            }
          ),
          400,
        )
    elif herramienta.id_institucion is None:
        herramienta.id_institucion = usuario.id_institucion

    herramienta.nombre = datos['nombre']
    herramienta.descripcion = datos['descripcion']
    if datos['estado_incluido']:
      herramienta.estado = datos['estado']
    herramienta.recurso = datos['recurso']
    herramienta.id_tipo_servicio = datos['tipo'].id
    herramienta.id_categoria = datos['categoria'].id
    herramienta.usuario_modifica = usuario.id

    try:
      db.session.commit()
    except IntegrityError:
      db.session.rollback()
      return (
        jsonify(
          {
              'status': 'error',
              'message': 'No se pudo actualizar la herramienta digital.',
          }
        ),
        400,
      )

    return jsonify({'status': 'success'})


@bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def eliminar(id):
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return (
      jsonify(
          {
            'status': 'error',
            'message': 'No se pudo determinar la institución del usuario.',
          }
      ),
      401,
    )

  herramienta = HerramientaDigital.query.get(id)
  if not herramienta:
    return jsonify({'status': 'error', 'message': 'Herramienta no encontrada.'}), 404

  if usuario.es_gestor and herramienta.id_institucion not in (None, usuario.id_institucion):
    return (
      jsonify(
          {
            'status': 'error',
            'message': 'No puedes eliminar herramientas de otra institución.',
          }
      ),
      403,
    )

  db.session.delete(herramienta)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify(
          {
            'status': 'error',
            'message': 'No se pudo eliminar la herramienta digital.',
          }
      ),
      400,
    )

  return jsonify({'status': 'success'})
