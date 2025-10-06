from flask import Blueprint, render_template, jsonify, request, session
from sqlalchemy import func
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from models.herramientas_digitales import HerramientaDigital
from models.categorias import Categoria
from models.tipos_servicios import TipoServicio
from models.usuarios import Usuario
from app import db

bp = Blueprint('herramientas_digitales', __name__, url_prefix='/herramientas_digitales')

def _obtener_usuario_actual():
  email = session.get('usuario')
  if not email:
      return None
  return (
      Usuario.query.filter(func.lower(Usuario.email) == email.lower())
      .options(joinedload(Usuario.institucion))
      .first()
  )

@bp.route('/')
def inicio():
    categorias = (
        Categoria.query.filter_by(id_padre=1)
        .order_by(Categoria.id)
        .all()
    )
    tipos_servicio = (
        TipoServicio.query.filter_by(id_padre=1)
        .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
        .all()
    )
    institucion_usuario = None
    usuario = _obtener_usuario_actual()
    if usuario:
        institucion_usuario = usuario.institucion
    return render_template(
        'gestion/herramientas_digitales.html',
        categorias=categorias,
        tipos_servicio=tipos_servicio,
        institucion_usuario=institucion_usuario,
    )

@bp.route('/listar')
def listar():
    herramientas = (
        HerramientaDigital.query.options(
            joinedload(HerramientaDigital.categoria),
            joinedload(HerramientaDigital.tipo_servicio),
            joinedload(HerramientaDigital.institucion),
        )
        .order_by(HerramientaDigital.nombre)
        .all()
    )

    data = []
    for herramienta in herramientas:
        estado = herramienta.estado
        if estado is None:
            estado_display = 'Sin estado'
        elif estado == 1:
            estado_display = 'Activo'
        elif estado == 0:
            estado_display = 'Inactivo'
        else:
            estado_display = str(estado)

        data.append(
            {
                'id': herramienta.id,
                'nombre': herramienta.nombre,
                'categoria': herramienta.categoria.nombre if herramienta.categoria else None,
                'categoria_id': herramienta.id_categoria,
                'tipo_servicio': herramienta.tipo_servicio.nombre if herramienta.tipo_servicio else None,
                'tipo_servicio_id': herramienta.id_tipo_servicio,
                'institucion': herramienta.institucion.nombre if herramienta.institucion else None,
                'institucion_id': herramienta.id_institucion,
                'estado': estado,
                'estado_display': estado_display,
                'recurso': herramienta.recurso,
                'descripcion': herramienta.descripcion,
            }
        )

    return jsonify(data)

@bp.route('/guardar', methods=['POST'])
def guardar():
    payload = request.get_json(silent=True) or {}
    datos, error = _validar_payload_herramienta(payload)
    if error:
        return error

    usuario = _obtener_usuario_actual()
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

    if not usuario.institucion:
        return (
            jsonify(
                {
                    'status': 'error',
                    'message': 'El usuario no tiene una institución asociada.',
                }
            ),
            400,
        )

    institucion = usuario.institucion

    institucion_payload = payload.get('id_institucion')
    if institucion_payload not in (None, ''):
        try:
            institucion_id = int(institucion_payload)
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
        if institucion_id != institucion.id:
            return (
                jsonify(
                    {
                        'status': 'error',
                        'message': 'No puedes registrar herramientas para otra institución.',
                    }
                ),
                403,
            )

    herramienta = HerramientaDigital(
        nombre=datos['nombre'],
        descripcion=datos['descripcion'],
        estado=datos['estado'],
        recurso=datos['recurso'],
        id_tipo_servicio=datos['tipo'].id,
        id_categoria=datos['categoria'].id,
        id_institucion=institucion.id,
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

def _validar_payload_herramienta(payload, *, requiere_nombre=True):
    nombre = (payload.get('nombre') or '').strip()
    if requiere_nombre and not nombre:
        return None, (
            jsonify({'status': 'error', 'message': 'El nombre es obligatorio.'}),
            400,
        )

    try:
        tipo_id = int(payload.get('id_tipo_servicio'))
        categoria_id = int(payload.get('id_categoria'))
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

    tipo = TipoServicio.query.get(tipo_id)
    categoria = Categoria.query.get(categoria_id)
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
        if len(descripcion) > 20:
            return None, (
                jsonify(
                    {
                        'status': 'error',
                        'message': 'La descripción no puede superar los 20 caracteres.',
                    }
                ),
                400,
            )
        if not descripcion:
            descripcion = None

    estado = payload.get('estado')
    if estado in ('', None):
        estado = None
    else:
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
        'recurso': recurso,
    }
    return datos, None

@bp.route('/<int:herramienta_id>', methods=['PUT'])
def actualizar(herramienta_id):
    usuario = _obtener_usuario_actual()
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

    if not usuario.institucion:
        return (
            jsonify(
                {
                    'status': 'error',
                    'message': 'El usuario no tiene una institución asociada.',
                }
            ),
            400,
        )

    herramienta = HerramientaDigital.query.get(herramienta_id)
    if not herramienta:
        return jsonify({'status': 'error', 'message': 'Herramienta no encontrada.'}), 404

    if herramienta.id_institucion not in (None, usuario.institucion.id):
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
    datos, error = _validar_payload_herramienta(payload)
    if error:
        return error

    if herramienta.id_institucion is None:
        herramienta.id_institucion = usuario.institucion.id

    herramienta.nombre = datos['nombre']
    herramienta.descripcion = datos['descripcion']
    herramienta.estado = datos['estado']
    herramienta.recurso = datos['recurso']
    herramienta.id_tipo_servicio = datos['tipo'].id
    herramienta.id_categoria = datos['categoria'].id

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

@bp.route('/<int:herramienta_id>', methods=['DELETE'])
def eliminar(herramienta_id):
    usuario = _obtener_usuario_actual()
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

    if not usuario.institucion:
        return (
            jsonify(
                {
                    'status': 'error',
                    'message': 'El usuario no tiene una institución asociada.',
                }
            ),
            400,
        )

    herramienta = HerramientaDigital.query.get(herramienta_id)
    if not herramienta:
        return jsonify({'status': 'error', 'message': 'Herramienta no encontrada.'}), 404

    if herramienta.id_institucion not in (None, usuario.institucion.id):
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