from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.exc import IntegrityError

from app.extensions import db
from app.models.roles import Rol
from .helpers import obtener_usuario_actual

bp = Blueprint('roles', __name__, url_prefix='/roles')


@bp.route('/', endpoint='listar')
@jwt_required()
def listar():
    usuario = obtener_usuario_actual(requerido=True)
    # Roles padre (id_padre == 0 o primer nivel)
    roles_padre = Rol.query.filter(Rol.id_padre == 0).order_by(Rol.orden.asc(), Rol.nombre.asc()).all()
    return render_template(
        'gestion/roles.html',
        roles_padre=roles_padre,
        usuario_actual=usuario,
    )


@bp.route('/datos')
@jwt_required()
def datos():
    todos = Rol.query.order_by(Rol.id_padre.asc(), Rol.orden.asc(), Rol.nombre.asc()).all()
    # Mapa de id → nombre para padres
    mapa_padre = {r.id: r.nombre for r in todos}

    registros = [
        {
            'id': rol.id,
            'nombre': rol.nombre or '',
            'logotipo': (rol.logotipo or '').strip(),
            'enlace': rol.enlace or '',
            'orden': rol.orden,
            'id_padre': rol.id_padre,
            'padre_nombre': mapa_padre.get(rol.id_padre, '') if rol.id_padre else '',
        }
        for rol in todos
    ]
    return jsonify({'roles': registros})


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
    payload = request.get_json(silent=True) or {}
    nombre = (payload.get('nombre') or '').strip()
    if not nombre:
        return jsonify({'status': 'error', 'message': 'El nombre del rol es obligatorio.'}), 400

    usuario = obtener_usuario_actual(requerido=True)
    try:
        id_padre = int(payload.get('id_padre', 0))
    except (TypeError, ValueError):
        id_padre = 0

    rol = Rol(
        nombre=nombre,
        logotipo=(payload.get('logotipo') or '').strip() or None,
        enlace=(payload.get('enlace') or '').strip() or None,
        orden=int(payload.get('orden', 1) or 1),
        id_padre=id_padre,
        usuario_registro=usuario.id if usuario else 1,
    )
    db.session.add(rol)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo registrar el rol.'}), 400
    return jsonify({'status': 'success', 'message': 'Rol registrado correctamente.'})


@bp.route('/<int:id_rol>', methods=['PUT'])
@jwt_required()
def actualizar(id_rol: int):
    rol = Rol.query.get(id_rol)
    if not rol:
        return jsonify({'status': 'error', 'message': 'Rol no encontrado.'}), 404

    payload = request.get_json(silent=True) or {}
    nombre = (payload.get('nombre') or '').strip()
    if not nombre:
        return jsonify({'status': 'error', 'message': 'El nombre del rol es obligatorio.'}), 400

    try:
        id_padre = int(payload.get('id_padre', 0))
    except (TypeError, ValueError):
        id_padre = 0

    rol.nombre = nombre
    rol.logotipo = (payload.get('logotipo') or '').strip() or None
    rol.enlace = (payload.get('enlace') or '').strip() or None
    rol.orden = int(payload.get('orden', 1) or 1)
    rol.id_padre = id_padre
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se pudo actualizar el rol.'}), 400
    return jsonify({'status': 'success', 'message': 'Rol actualizado correctamente.'})


@bp.route('/<int:id_rol>', methods=['DELETE'])
@jwt_required()
def eliminar(id_rol: int):
    rol = Rol.query.get(id_rol)
    if not rol:
        return jsonify({'status': 'error', 'message': 'Rol no encontrado.'}), 404
    db.session.delete(rol)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'status': 'error', 'message': 'No se puede eliminar el rol porque está en uso.'}), 400
    return jsonify({'status': 'success', 'message': 'Rol eliminado correctamente.'})
