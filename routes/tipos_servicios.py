from __future__ import annotations

from flask import Blueprint, jsonify, render_template
from flask_jwt_extended import jwt_required

from models.tipos_servicios import TipoServicio

bp = Blueprint('tipos_servicios', __name__, url_prefix='/tipos_servicios')


@bp.route('/')
@jwt_required()
def listar():
  return render_template('gestion/tipos_servicios.html')


@bp.route('/datos')
@jwt_required()
def datos():
  tipos = (
    TipoServicio.query.filter_by(id_padre=1)
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )
  data = []
  for tipo in tipos:
    estado = tipo.estado
    if estado is None:
      estado_display = 'Sin estado'
    elif estado:
      estado_display = 'Activo'
    else:
      estado_display = 'Inactivo'
    data.append(
      {
        'id': tipo.id,
        'nombre': tipo.nombre,
        'estado': estado,
        'estado_display': estado_display,
        'orden': tipo.orden,
      }
    )
  return jsonify({'tipos': data})