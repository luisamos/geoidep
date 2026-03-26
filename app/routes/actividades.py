from __future__ import annotations

from datetime import datetime

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app.extensions import db
from app.models.actividades import Actividad, HActividad
from app.models.documentos import Documento
from app.models.instituciones import Institucion
from app.models.tipos_actividades import TipoActividad
from .helpers import obtener_usuario_actual, usuario_restringido_a_su_entidad

bp = Blueprint('actividades', __name__, url_prefix='/actividades')

ESTADOS = {
    1: 'Pendiente',
    2: 'En proceso',
    3: 'Culminado',
}

def registrar_historico(act: Actividad, accion: str, usuario_id: int | None):
  historial = HActividad(
    id_documento=act.id_documento,
    id_institucion=act.id_institucion,
    id_actividad=act.id_actividad,
    f_atencion=act.f_atencion,
    estado=act.estado,
    descripcion=act.descripcion,
    usuario_registro=act.usuario_registro,
    fecha_registro=act.fecha_registro,
    accion=accion,
    usuario_accion=usuario_id,
  )
  db.session.add(historial)

def validar_unicidad(id_documento: int, id_actividad: int, estado: int, excluir_id: int | None = None):
  consulta = Actividad.query.filter_by(
    id_documento=id_documento,
    id_actividad=id_actividad,
    estado=estado,
  )
  if excluir_id:
    consulta = consulta.filter(Actividad.id != excluir_id)
  return consulta.first() is None

def parsear_fecha_atencion(valor: str | None):
  if not valor:
    return datetime.utcnow()
  try:
    return datetime.strptime(valor, '%Y-%m-%d')
  except ValueError:
    return None

def instituciones_para(usuario):
  consulta = Institucion.query.filter(Institucion.id >= 45)
  if usuario_restringido_a_su_entidad(usuario):
      consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  return consulta.order_by(Institucion.sigla.asc(), Institucion.nombre.asc()).all()

@bp.route('/', endpoint='listar')
@jwt_required()
def listar():
    usuario = obtener_usuario_actual(requerido=True)
    tipo_actividad = (
      TipoActividad.query
      .filter_by(estado=True, id_perfil=usuario.id_perfil)
      .order_by(TipoActividad.orden.asc())
      .all()
    )
    instituciones = instituciones_para(usuario)
    documentos_query = Documento.query
    if usuario_restringido_a_su_entidad(usuario):
        documentos_query = documentos_query.filter(
            Documento.actividades.any(Actividad.id_institucion == usuario.id_institucion)
        )
    documentos = documentos_query.order_by(Documento.n_documento.asc()).all()

    instituciones_json = [
        {'id': inst.id, 'nombre': inst.nombre or '', 'sigla': inst.sigla or ''}
        for inst in instituciones
    ]
    documentos_json = [
        {'id': doc.id, 'n_documento': doc.n_documento or ''}
        for doc in documentos
    ]

    return render_template(
        'gestion/actividades.html',
        tipo_actividad=tipo_actividad,
        instituciones=instituciones_json,
        documentos=documentos_json,
        estados=ESTADOS,
        usuario_actual=usuario,
    )

@bp.route('/datos')
@jwt_required()
def datos():
    usuario = obtener_usuario_actual(requerido=True)
    consulta = (
        Actividad.query.options(
            joinedload(Actividad.documento),
            joinedload(Actividad.institucion),
            joinedload(Actividad.actividad),
        )
        .order_by(Actividad.id.desc())
    )
    if usuario_restringido_a_su_entidad(usuario):
        consulta = consulta.filter(Actividad.id_institucion == usuario.id_institucion)

    registros = [
        {
            'id': act.id,
            'id_documento': act.id_documento,
            'documento_numero': act.documento.n_documento if act.documento else '',
            'id_institucion': act.id_institucion,
            'institucion_nombre': act.institucion.nombre if act.institucion else '',
            'institucion_sigla': act.institucion.sigla if act.institucion else '',
            'id_actividad': act.id_actividad,
            'actividad_nombre': act.actividad.nombre if act.actividad else '',
            'descripcion': act.descripcion or '',
            'estado': act.estado,
            'estado_nombre': ESTADOS.get(act.estado, 'Desconocido'),
            'f_atencion': act.f_atencion.strftime('%Y-%m-%d') if act.f_atencion else '',
        }
        for seg in consulta.all()
    ]
    return jsonify({'a': registros})


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
    payload = request.get_json(silent=True) or {}
    id_documento = payload.get('id_documento')
    id_institucion = payload.get('id_institucion')
    id_actividad = payload.get('id_actividad')
    estado = payload.get('estado')
    f_atencion = parsear_fecha_atencion(payload.get('f_atencion'))
    if not id_documento or not id_institucion or not id_actividad:
        return jsonify({'status': 'error', 'message': 'Documento, institución y actividad son obligatorios.'}), 400
    if estado not in ESTADOS:
        return jsonify({'status': 'error', 'message': 'Debe seleccionar un estado válido.'}), 400
    if not f_atencion:
        return jsonify({'status': 'error', 'message': 'La fecha de atención no tiene formato válido.'}), 400

    usuario = obtener_usuario_actual(requerido=True)
    actividad = Actividad.query.filter_by(id=int(id_actividad), estado=True).first()
    if not actividad or actividad.id_perfil != usuario.id_perfil:
        return jsonify({'status': 'error', 'message': 'La actividad seleccionada no está permitida para su perfil.'}), 403

    if (
        usuario_restringido_a_su_entidad(usuario)
        and int(id_institucion) != usuario.id_institucion
    ):
        return jsonify({'status': 'error', 'message': 'No puedes registrar actividades para otra institución.'}), 403

    if not validar_unicidad(int(id_documento), int(id_actividad), int(estado)):
        return jsonify({'status': 'error', 'message': 'Ya existe ese estado para la actividad en el documento seleccionado.'}), 400

    seg = Actividad(
      id_documento=int(id_documento),
      id_institucion=int(id_institucion),
      id_actividad=int(id_actividad),
      f_atencion=f_atencion,
      descripcion=(payload.get('descripcion') or '').strip() or None,
      estado=int(estado),
      usuario_registro=usuario.id if usuario else 1,
    )
    db.session.add(seg)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo registrar la actividad.'}), 400
    return jsonify({'status': 'success', 'message': 'Actividad registrado correctamente.'})

@bp.route('/<int:id_seg>', methods=['PUT'])
@jwt_required()
def actualizar(id_seg: int):
    seg = Actividad.query.get(id_seg)
    if not seg:
        return jsonify({'status': 'error', 'message': 'Actividad no encontrado.'}), 404
    usuario = obtener_usuario_actual(requerido=True)
    if (
        usuario_restringido_a_su_entidad(usuario)
        and act.id_institucion != usuario.id_institucion
    ):
        return jsonify({'status': 'error', 'message': 'No puedes modificar la actividad de otra institución.'}), 403

    payload = request.get_json(silent=True) or {}
    id_documento = payload.get('id_documento')
    id_institucion = payload.get('id_institucion')
    id_actividad = payload.get('id_actividad')
    estado = payload.get('estado')
    f_atencion = parsear_fecha_atencion(payload.get('f_atencion'))
    if not id_documento or not id_institucion or not id_actividad:
        return jsonify({'status': 'error', 'message': 'Documento, institución y actividad son obligatorios.'}), 400
    if estado not in ESTADOS:
        return jsonify({'status': 'error', 'message': 'Debe seleccionar un estado válido.'}), 400
    if not f_atencion:
        return jsonify({'status': 'error', 'message': 'La fecha de atención no tiene formato válido.'}), 400

    actividad = Actividad.query.filter_by(id=int(id_actividad), estado=True).first()
    if not actividad or actividad.id_perfil != usuario.id_perfil:
        return jsonify({'status': 'error', 'message': 'La actividad seleccionada no está permitida para su perfil.'}), 403

    nuevo_id_institucion = int(id_institucion)
    if (
        usuario_restringido_a_su_entidad(usuario)
        and nuevo_id_institucion != usuario.id_institucion
    ):
        return jsonify({'status': 'error', 'message': 'No puedes mover la actividad a otra institución.'}), 403

    if not validar_unicidad(int(id_documento), int(id_actividad), int(estado), excluir_id=id_seg):
        return jsonify({'status': 'error', 'message': 'Ya existe ese estado para la actividad en el documento seleccionado.'}), 400

    registrar_historico(seg, 'UPDATE', usuario.id if usuario else None)

    act.id_documento = int(id_documento)
    act.id_institucion = nuevo_id_institucion
    act.id_actividad = int(id_actividad)
    act.f_atencion = f_atencion
    act.descripcion = (payload.get('d') or '').strip() or None
    act.estado = int(estado)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo actualizar la actividad.'}), 400
    return jsonify({'status': 'success', 'message': 'Actividad actualizado correctamente.'})

@bp.route('/<int:id_seg>', methods=['DELETE'])
@jwt_required()
def eliminar(id_seg: int):
    seg = Actividad.query.get(id_seg)
    if not seg:
        return jsonify({'status': 'error', 'message': 'Actividad no encontrado.'}), 404
    usuario = obtener_usuario_actual(requerido=True)
    if (
        usuario_restringido_a_su_entidad(usuario)
        and act.id_institucion != usuario.id_institucion
    ):
        return jsonify({'status': 'error', 'message': 'No puedes eliminar la actividad de otra institución.'}), 403
    registrar_historico(seg, 'DELETE', usuario.id if usuario else None)
    db.session.delete(seg)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se puede eliminar la actividad.'}), 400
    return jsonify({'status': 'success', 'message': 'Actividad eliminada correctamente.'})

@bp.route('seguimiento/<int:id_seg>')
@jwt_required()
def seguimiento(id_seg: int):
    seg = Actividad.query.options(
        joinedload(Actividad.documento),
        joinedload(Actividad.institucion),
        joinedload(Actividad.actividad),
    ).filter_by(id=id_seg).first()
    if not seg:
        return jsonify({'status': 'error', 'message': 'Actividad no encontrado.'}), 404
    usuario = obtener_usuario_actual(requerido=True)
    if (
        usuario_restringido_a_su_entidad(usuario)
        and act.id_institucion != usuario.id_institucion
    ):
        return jsonify({'status': 'error', 'message': 'No puedes ver seguimientos de otra institución.'}), 403

    registro = {
        'id': act.id,
        'id_documento': act.id_documento,
        'documento_numero': act.documento.n_documento if act.documento else '',
        'id_institucion': act.id_institucion,
        'institucion_nombre': act.institucion.nombre if act.institucion else '',
        'institucion_sigla': act.institucion.sigla if act.institucion else '',
        'id_actividad': act.id_actividad,
        'actividad_nombre': act.actividad.nombre if act.actividad else '',
        'descripcion': act.descripcion or '',
        'estado': act.estado,
        'estado_nombre': ESTADOS.get(act.estado, 'Desconocido'),
        'f_atencion': act.f_atencion.strftime('%Y-%m-%d') if act.f_atencion else '',
    }
    return jsonify({'seguimiento': registro})