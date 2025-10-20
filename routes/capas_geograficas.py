from __future__ import annotations

from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app import db
from models.capas_geograficas import CapaGeografica, ServicioGeografico
from models.categorias import Categoria
from models.instituciones import Institucion
from models.tipos_servicios import TipoServicio
from routes._helpers import obtener_usuario_actual

bp = Blueprint('capas_geograficas', __name__, url_prefix='/capas_geograficas')


def _obtener_instituciones_para(usuario):
  consulta = Institucion.query.filter(Institucion.id >= 45)
  if usuario and usuario.es_gestor:
    consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  return consulta.order_by(Institucion.id.asc()).all()


@bp.route('/')
@jwt_required()
def inicio():
  usuario = obtener_usuario_actual(requerido=True)
  categorias = (
    Categoria.query.filter_by(id_padre=1)
    .order_by(Categoria.id.asc())
    .all()
  )
  tipos_serv = (
    TipoServicio.query.filter(TipoServicio.id_padre.in_((2, 3)))
    .order_by(TipoServicio.id.asc(), TipoServicio.nombre.asc())
    .all()
  )
  instituciones = _obtener_instituciones_para(usuario)
  puede_editar_institucion = (
    usuario.puede_gestionar_multiples_instituciones if usuario else False
  )
  return render_template(
    'gestion/capas_geograficas.html',
    categorias=categorias,
    tipos_serv=tipos_serv,
    instituciones=instituciones,
    institucion_usuario=usuario.institucion if usuario else None,
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

  consulta = CapaGeografica.query.options(
    joinedload(CapaGeografica.categoria),
    joinedload(CapaGeografica.institucion),
    joinedload(CapaGeografica.servicios).joinedload(
      ServicioGeografico.tipo_servicio
    ),
  ).order_by(CapaGeografica.nombre.asc())

  if usuario.es_gestor:
    consulta = consulta.filter(CapaGeografica.id_institucion == usuario.id_institucion)

  data = []
  for capa in consulta.all():
    servicios_en_capa = [
      (serv.tipo_servicio.id, serv.tipo_servicio.nombre)
      for serv in capa.servicios
      if serv.tipo_servicio
    ]
    servicios = ', '.join(nombre for _, nombre in servicios_en_capa)
    data.append(
      {
        'id': capa.id,
        'nombre': capa.nombre,
        'descripcion': capa.descripcion,
        'tipo_capa': capa.tipo_capa,
        'en_geoperu': capa.publicar_geoperu,
        'servicios': servicios,
        'categoria': capa.categoria.nombre if capa.categoria else None,
        'id_categoria': capa.id_categoria,
        'institucion_sigla': (
          capa.institucion.sigla or '' if capa.institucion else ''
        ),
        'institucion_nombre': (
          capa.institucion.nombre if capa.institucion else None
        ),
        'id_institucion': capa.id_institucion,
        'servicio_ids': [serv_id for serv_id, _ in servicios_en_capa],
      }
    )
  return jsonify(data)


@bp.route('/guardar', methods=['POST'])
@jwt_required()
def guardar():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return (
      jsonify({'status': 'error', 'message': 'Sesión no válida.'}),
      401,
    )

  data = request.get_json(force=True) or {}
  capa_id = data.get('id')

  try:
    categoria_id = int(data.get('categoria_id')) if data.get('categoria_id') else None
  except (TypeError, ValueError):
    categoria_id = None

  try:
    institucion_payload = int(data.get('institucion_id')) if data.get('institucion_id') else None
  except (TypeError, ValueError):
    institucion_payload = None

  if usuario.es_gestor:
    institucion_id = usuario.id_institucion
    if institucion_payload and institucion_payload != institucion_id:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'No puedes gestionar capas para otra institución.',
          }
        ),
        403,
      )
  else:
    institucion_id = institucion_payload or usuario.id_institucion

  if not institucion_id:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'Debe seleccionar una institución válida.',
        }
      ),
      400,
    )

  if not categoria_id:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'Debe seleccionar una categoría válida.',
        }
      ),
      400,
    )

  tipo_capa_valor = data.get('tipo_capa')
  try:
    tipo_capa = int(tipo_capa_valor)
  except (TypeError, ValueError):
    tipo_capa = None

  if tipo_capa not in (1, 2):
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'El tipo de capa seleccionado no es válido.',
        }
      ),
      400,
    )

  nombre = (data.get('nombre') or '').strip()
  if not nombre:
    return (
      jsonify(
        {'status': 'error', 'message': 'El nombre de la capa es obligatorio.'}
      ),
      400,
    )

  descripcion = (data.get('descripcion') or '').strip()
  publicar_geoperu = bool(data.get('publicar_geoperu', False))

  if capa_id:
    try:
      capa_id_int = int(capa_id)
    except (TypeError, ValueError):
      return (
        jsonify({'status': 'error', 'message': 'El identificador enviado no es válido.'}),
        400,
      )
    capa = CapaGeografica.query.get(capa_id_int)
    if not capa:
      return (
        jsonify({'status': 'error', 'message': 'La capa indicada no existe.'}),
        404,
      )
    if usuario.es_gestor and capa.id_institucion != usuario.id_institucion:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'No puedes modificar capas de otra institución.',
          }
        ),
        403,
      )
  else:
    capa = CapaGeografica(usuario_crea=usuario.id)
    db.session.add(capa)

  capa.nombre = nombre
  capa.descripcion = descripcion
  capa.tipo_capa = tipo_capa
  capa.publicar_geoperu = publicar_geoperu
  capa.id_categoria = categoria_id
  capa.id_institucion = institucion_id
  capa.usuario_modifica = usuario.id

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

  return jsonify({'status': 'success', 'capa_id': capa.id}), 200 if capa_id else 201