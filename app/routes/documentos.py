from __future__ import annotations

from datetime import datetime

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy import or_
from sqlalchemy.exc import IntegrityError

from app.extensions import db
from app.models.documentos import Documento
from .helpers import obtener_usuario_actual

bp = Blueprint('documentos', __name__, url_prefix='/documentos')

def parsear_fecha(valor, *, requerido=False, campo='fecha'):
  if valor in (None, ''):
      if requerido:
          raise ValueError(f'El campo "{campo}" es obligatorio.')
      return None
  if isinstance(valor, str):
      try:
          return datetime.strptime(valor, '%Y-%m-%d').date()
      except ValueError as error:
          raise ValueError(
              f'El campo "{campo}" debe tener el formato YYYY-MM-DD.'
          ) from error
  if hasattr(valor, 'year') and hasattr(valor, 'month') and hasattr(valor, 'day'):
      return valor
  raise ValueError(f'El campo "{campo}" tiene un formato inválido.')

@bp.route('/', endpoint='listar')
@jwt_required()
def listar():
    usuario = obtener_usuario_actual(requerido=True)
    return render_template(
        'gestion/documentos.html',
        usuario_actual=usuario,
    )


@bp.route('/datos')
@jwt_required()
def datos():
    n_documento = (request.args.get('n_documento') or '').strip()
    cod_expediente = (request.args.get('cod_expediente') or '').strip()
    termino = (request.args.get('q') or '').strip()

    consulta = Documento.query
    if n_documento:
        consulta = consulta.filter(Documento.n_documento.ilike(f'%{n_documento}%'))
    if cod_expediente:
        consulta = consulta.filter(Documento.cod_expediente.ilike(f'%{cod_expediente}%'))
    if termino:
        consulta = consulta.filter(
            or_(
                Documento.n_documento.ilike(f'%{termino}%'),
                Documento.cod_expediente.ilike(f'%{termino}%'),
            )
        )

    consulta = consulta.order_by(Documento.f_documento.desc(), Documento.id.desc()).all()
    registros = [
        {
            'id': doc.id,
            'n_documento': doc.n_documento or '',
            'f_documento': doc.f_documento.isoformat() if doc.f_documento else '',
            'cod_expediente': doc.cod_expediente or '',
            'f_recepcion': doc.f_recepcion.isoformat() if doc.f_recepcion else '',
            'url_documento': doc.url_documento or '',
        }
        for doc in consulta
    ]
    return jsonify({'documentos': registros})


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
    payload = request.get_json(silent=True) or {}
    n_documento = (payload.get('n_documento') or '').strip()
    try:
        f_documento = parsear_fecha(
            payload.get('f_documento'),
            requerido=True,
            campo='Fecha del documento',
        )
        f_recepcion = parsear_fecha(payload.get('f_recepcion'), campo='Fecha de recepción')
    except ValueError as error:
        return jsonify({'status': 'error', 'message': str(error)}), 400
    if not n_documento:
        return jsonify({'status': 'error', 'message': 'Número de documento y fecha son obligatorios.'}), 400

    usuario = obtener_usuario_actual(requerido=True)
    doc = Documento(
        n_documento=n_documento,
        f_documento=f_documento,
        cod_expediente=(payload.get('cod_expediente') or '').strip() or None,
        f_recepcion=f_recepcion,
        url_documento=(payload.get('url_documento') or '').strip() or None,
        usuario_registro=usuario.id if usuario else 1,
    )
    db.session.add(doc)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo registrar el documento.'}), 400
    return jsonify({'status': 'success', 'message': 'Documento registrado correctamente.'})


@bp.route('/<int:id_documento>', methods=['PUT'])
@jwt_required()
def actualizar(id_documento: int):
    doc = Documento.query.get(id_documento)
    if not doc:
        return jsonify({'status': 'error', 'message': 'Documento no encontrado.'}), 404

    payload = request.get_json(silent=True) or {}
    n_documento = (payload.get('n_documento') or '').strip()
    try:
        f_documento = parsear_fecha(
            payload.get('f_documento'),
            requerido=True,
            campo='Fecha del documento',
        )
        f_recepcion = parsear_fecha(payload.get('f_recepcion'), campo='Fecha de recepción')
    except ValueError as error:
        return jsonify({'status': 'error', 'message': str(error)}), 400
    if not n_documento:
        return jsonify({'status': 'error', 'message': 'Número de documento y fecha son obligatorios.'}), 400

    doc.n_documento = n_documento
    doc.f_documento = f_documento
    doc.cod_expediente = (payload.get('cod_expediente') or '').strip() or None
    doc.f_recepcion = f_recepcion
    doc.url_documento = (payload.get('url_documento') or '').strip() or None
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo actualizar el documento.'}), 400
    return jsonify({'status': 'success', 'message': 'Documento actualizado correctamente.'})


@bp.route('/<int:id_documento>', methods=['DELETE'])
@jwt_required()
def eliminar(id_documento: int):
    doc = Documento.query.get(id_documento)
    if not doc:
        return jsonify({'status': 'error', 'message': 'Documento no encontrado.'}), 404
    db.session.delete(doc)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se puede eliminar porque está asociado a otros registros.'}), 400
    return jsonify({'status': 'success', 'message': 'Documento eliminado correctamente.'})
