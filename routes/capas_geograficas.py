from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app import db
from models.capas_geograficas import CapaGeografica, ServicioGeografico
from models.categorias import Categoria
from models.tipos_servicios import TipoServicio
from routes._helpers import obtener_usuario_actual

bp = Blueprint('capas_geograficas', __name__, url_prefix='/capas_geograficas')

@bp.route('/')
def inicio():
  usuario = obtener_usuario_actual()
  categorias = Categoria.query.order_by(Categoria.codigo).all()
  tipos_serv = (
    TipoServicio.query.order_by(
      TipoServicio.orden.asc(), TipoServicio.nombre.asc()
    ).all()
  )
  consulta = CapaGeografica.query.options(
    joinedload(CapaGeografica.servicios).joinedload(ServicioGeografico.tipo_servicio)
  ).order_by(CapaGeografica.nombre)
  if usuario and usuario.es_gestor:
    consulta = consulta.filter(CapaGeografica.id_institucion == usuario.id_institucion)
  capas = consulta.all()
  return render_template(
    'gestion/capas_geograficas.html',
    categorias=categorias,
    tipos_serv=tipos_serv,
    capas=capas,
  )

@bp.route('/listar')
def listar():
  usuario = obtener_usuario_actual()
  if not usuario:
    return (
      jsonify({'status': 'error', 'message': 'Sesión no válida.'}),
      401,
    )

  consulta = CapaGeografica.query.options(
    joinedload(CapaGeografica.servicios).joinedload(ServicioGeografico.tipo_servicio)
  )
  if usuario.es_gestor:
    consulta = consulta.filter(CapaGeografica.id_institucion == usuario.id_institucion)

  data = []
  for capa in consulta.all():
    servicios = ', '.join(
      serv.tipo_servicio.nombre
      for serv in capa.servicios
      if serv.tipo_servicio
    )
    data.append(
      {
        'id': capa.id,
        'nombre': capa.nombre,
        'en_geoperu': capa.publicar_geoperu,
        'servicios': servicios,
      }
    )
  return jsonify(data)

@bp.route('/guardar', methods=['POST'])
def guardar():
  usuario = obtener_usuario_actual()
  if not usuario:
    return (
      jsonify({'status': 'error', 'message': 'Sesión no válida.'}),
      401,
    )

  institucion_id = usuario.id_institucion or None
  if not institucion_id:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se pudo determinar la institución del usuario.',
        }
      ),
      400,
    )

  data = request.get_json(force=True)
  capa = CapaGeografica(
    nombre=data['nombre'],
    descripcion=data.get('descripcion', ''),
    tipo_capa=(data.get('tipo_capa') == 'publico'),
    publicar_geoperu=bool(data.get('publicar_geoperu', False)),
    id_categoria=data.get('categoria_id'),
    id_institucion=institucion_id,
  )

  for servicio_payload in data.get('servicios', []):
    nombre_tipo = servicio_payload.get('tipo')
    if not nombre_tipo:
      continue
    tipo = TipoServicio.query.filter_by(nombre=nombre_tipo).first()
    if not tipo:
      tipo = TipoServicio(nombre=nombre_tipo, id_padre=1, orden=0)
      db.session.add(tipo)
      db.session.flush()

    servicio = ServicioGeografico(
      id_tipo_servicio=tipo.id,
      direccion_web=servicio_payload.get('url'),
      nombre_layer=servicio_payload.get('layer'),
      visible=bool(servicio_payload.get('visible', True)),
    )
    capa.servicios.append(servicio)

  db.session.add(capa)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se pudo registrar la capa geográfica.',
        }
      ),
      400,
    )

  return jsonify({'status': 'success', 'capa_id': capa.id}), 201