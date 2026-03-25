from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required

from app.extensions import db
from .helpers import obtener_usuario_actual

bp = Blueprint('mi_cuenta', __name__, url_prefix='/mi_cuenta')


@bp.route('/', endpoint='inicio')
@jwt_required()
def inicio():
    usuario = obtener_usuario_actual(requerido=True)
    return render_template(
        'gestion/mi_cuenta.html',
        usuario_actual=usuario,
        seccion_activa='rol16',
    )


@bp.route('/cambiar_password', methods=['POST'])
@jwt_required()
def cambiar_password():
    usuario = obtener_usuario_actual(requerido=True)
    if not usuario:
        return jsonify({'status': 'error', 'message': 'Sesión no válida.'}), 401

    payload = request.get_json(silent=True) or {}
    password_actual = payload.get('password_actual', '')
    password_nueva = payload.get('password_nueva', '')

    if not password_actual or not password_nueva:
        return jsonify({'status': 'error', 'message': 'Complete todos los campos.'}), 400

    if not usuario.check_password(password_actual):
        return jsonify({'status': 'error', 'message': 'La contraseña actual no es correcta.'}), 400

    if len(password_nueva) < 8:
        return jsonify({'status': 'error', 'message': 'La nueva contraseña debe tener al menos 8 caracteres.'}), 400

    usuario.set_password(password_nueva)
    try:
        db.session.commit()
    except Exception:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo actualizar la contraseña.'}), 500

    return jsonify({'status': 'success', 'message': 'Contraseña actualizada correctamente.'})
