from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app.extensions import db
from app.models.seguimientos import Seguimiento
from app.models.documentos import Documento
from app.models.instituciones import Institucion, SECTOR_IDS
from app.models.actividades import Actividad
from .helpers import obtener_usuario_actual

bp = Blueprint('seguimientos', __name__, url_prefix='/seguimientos')

EXCLUDED_PARENT_IDS = tuple(range(10))


def _instituciones_para(usuario):
    consulta = Institucion.query
    if usuario and usuario.es_gestor:
        consulta = consulta.filter(Institucion.id == usuario.id_institucion)
    else:
        consulta = consulta.filter(~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS))
    return consulta.order_by(Institucion.nombre.asc()).all()


@bp.route('/', endpoint='listar')
@jwt_required()
def listar():
    usuario = obtener_usuario_actual(requerido=True)
    actividades = Actividad.query.filter_by(estado=True).order_by(Actividad.orden.asc()).all()
    instituciones = _instituciones_para(usuario)
    documentos = Documento.query.order_by(Documento.f_documento.desc()).all()

    instituciones_json = [
        {'id': inst.id, 'nombre': inst.nombre or '', 'sigla': inst.sigla or ''}
        for inst in instituciones
    ]
    documentos_json = [
        {'id': doc.id, 'n_documento': doc.n_documento or ''}
        for doc in documentos
    ]

    return render_template(
        'gestion/seguimientos.html',
        actividades=actividades,
        instituciones=instituciones_json,
        documentos=documentos_json,
        usuario_actual=usuario,
    )


@bp.route('/datos')
@jwt_required()
def datos():
    usuario = obtener_usuario_actual(requerido=True)
    consulta = (
        Seguimiento.query.options(
            joinedload(Seguimiento.documento),
            joinedload(Seguimiento.institucion),
            joinedload(Seguimiento.actividad),
        )
        .order_by(Seguimiento.id.desc())
    )
    if usuario and usuario.es_gestor:
        consulta = consulta.filter(Seguimiento.id_institucion == usuario.id_institucion)

    registros = [
        {
            'id': seg.id,
            'id_documento': seg.id_documento,
            'documento_numero': seg.documento.n_documento if seg.documento else '',
            'id_institucion': seg.id_institucion,
            'institucion_nombre': seg.institucion.nombre if seg.institucion else '',
            'institucion_sigla': seg.institucion.sigla if seg.institucion else '',
            'id_actividad': seg.id_actividad,
            'actividad_nombre': seg.actividad.nombre if seg.actividad else '',
            'observacion': seg.observacion or '',
            'estado': seg.estado,
        }
        for seg in consulta.all()
    ]
    return jsonify({'seguimientos': registros})


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
    payload = request.get_json(silent=True) or {}
    id_documento = payload.get('id_documento')
    id_institucion = payload.get('id_institucion')
    id_actividad = payload.get('id_actividad')
    if not id_documento or not id_institucion or not id_actividad:
        return jsonify({'status': 'error', 'message': 'Documento, institución y actividad son obligatorios.'}), 400

    usuario = obtener_usuario_actual(requerido=True)
    seg = Seguimiento(
        id_documento=int(id_documento),
        id_institucion=int(id_institucion),
        id_actividad=int(id_actividad),
        observacion=(payload.get('observacion') or '').strip() or None,
        estado=bool(payload.get('estado', True)),
        usuario_registro=usuario.id if usuario else 1,
    )
    db.session.add(seg)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo registrar el seguimiento.'}), 400
    return jsonify({'status': 'success', 'message': 'Seguimiento registrado correctamente.'})


@bp.route('/<int:id_seg>', methods=['PUT'])
@jwt_required()
def actualizar(id_seg: int):
    seg = Seguimiento.query.get(id_seg)
    if not seg:
        return jsonify({'status': 'error', 'message': 'Seguimiento no encontrado.'}), 404

    payload = request.get_json(silent=True) or {}
    id_documento = payload.get('id_documento')
    id_institucion = payload.get('id_institucion')
    id_actividad = payload.get('id_actividad')
    if not id_documento or not id_institucion or not id_actividad:
        return jsonify({'status': 'error', 'message': 'Documento, institución y actividad son obligatorios.'}), 400

    seg.id_documento = int(id_documento)
    seg.id_institucion = int(id_institucion)
    seg.id_actividad = int(id_actividad)
    seg.observacion = (payload.get('observacion') or '').strip() or None
    seg.estado = bool(payload.get('estado', True))
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo actualizar el seguimiento.'}), 400
    return jsonify({'status': 'success', 'message': 'Seguimiento actualizado correctamente.'})


@bp.route('/<int:id_seg>', methods=['DELETE'])
@jwt_required()
def eliminar(id_seg: int):
    seg = Seguimiento.query.get(id_seg)
    if not seg:
        return jsonify({'status': 'error', 'message': 'Seguimiento no encontrado.'}), 404
    db.session.delete(seg)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se puede eliminar el seguimiento.'}), 400
    return jsonify({'status': 'success', 'message': 'Seguimiento eliminado correctamente.'})
