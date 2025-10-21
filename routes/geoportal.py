from collections import OrderedDict
import re
import unicodedata

from flask import Blueprint, render_template, request, abort
from sqlalchemy.orm import joinedload
from sqlalchemy import func, or_
from markupsafe import escape

from models.herramientas_digitales import HerramientaDigital
from models.categorias import Categoria
from models.instituciones import Institucion
from models.tipos_servicios import TipoServicio

bp = Blueprint('geoportal', __name__)

CATALOGO_TIPO_IDS = (5,6,7,8,9,10)

EXCLUDED_PARENT_IDS = tuple(range(10))

CATALOGO_SLUGS = {
  5: 'geoportales',
  6: 'visores',
  7: 'observatorios',
  8: 'apps',
  9: 'metadatos',
  10:'descargas'
}

CATALOGO_SLUG_TO_ID = {slug: id_tipo for id_tipo, slug in CATALOGO_SLUGS.items()}

def slugify(value):
  if not value:
    return ''
  normalized = unicodedata.normalize('NFKD', value)
  without_accents = ''.join(
    character for character in normalized if not unicodedata.combining(character)
  )
  slug = re.sub(r'[^a-z0-9]+', '-', without_accents.lower())
  return slug.strip('-')

def sanitize_text(value):
  if value is None:
    return None
  return str(escape(value))

def obtener_tipos_servicios_catalogo():
  tipos = (
    TipoServicio.query.filter(
      TipoServicio.id_padre == 1,
      TipoServicio.id.in_(CATALOGO_TIPO_IDS),
      or_(TipoServicio.estado.is_(True), TipoServicio.estado.is_(None)),
    )
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )

  tipos_por_id = {tipo.id: tipo for tipo in tipos}
  tipos_catalogo = []

  for tipo_id in CATALOGO_TIPO_IDS:
    tipo = tipos_por_id.get(tipo_id)
    if not tipo:
        continue
    tipos_catalogo.append(
      {
        'id': tipo.id,
        'nombre': sanitize_text(tipo.nombre),
        'descripcion': sanitize_text(tipo.descripcion),
        'logotipo': tipo.logotipo,
        'slug': CATALOGO_SLUGS.get(tipo.id, slugify(tipo.nombre)),
      }
    )

  return tipos_catalogo

@bp.route('/')
def principal():
  return render_template('geoportal/inicio.html')

@bp.route('/que_es_la_geoidep')
def que_es_la_geoidep():
  return None

@bp.route('/idep')
def idep():
  return render_template('geoportal/idep.html')

@bp.route('/que_es_idep')
def que_es_idep():
  return None

@bp.route('/componente_idep')
def componente_idep():
  return None

@bp.route('/ccidep')
def ccidep():
  return None

@bp.route('/asistencia_tecnica')
def asistencia_tecnica():
  return None

@bp.route('/secretaria_tecnica_ccidep')
def secretaria_tecnica_ccidep():
  return None

@bp.route('/catalogo')
def catalogo():
  tipos_servicios = obtener_tipos_servicios_catalogo()
  return render_template('geoportal/catalogo.html', tipos_servicios=tipos_servicios)

@bp.route('/catalogo/<slug>')
def catalogo_por_tipo(slug):
  slug_normalizado = slug.lower()
  id_tipo = CATALOGO_SLUG_TO_ID.get(slug_normalizado)
  if not id_tipo:
    abort(404)

  tipos_servicios = obtener_tipos_servicios_catalogo()
  tipo_config = next((tipo for tipo in tipos_servicios if tipo['id'] == id_tipo), None)
  if not tipo_config:
    abort(404)

  tipo_nombre = sanitize_text(tipo_config['nombre'])
  descripcion_config = tipo_config.get('descripcion')
  tipo_titulo = descripcion_config or tipo_nombre
  tipo_descripcion = descripcion_config

  id_institucion = request.args.get('id_institucion', type=int)
  filter_terms = request.args.get('filter_terms', default='', type=str).strip()
  if filter_terms:
      filter_terms = re.sub(r'[<>"\'`]', '', filter_terms)

  if id_tipo not in CATALOGO_TIPO_IDS:
    abort(404)

  query = (
    HerramientaDigital.query.options(
      joinedload(HerramientaDigital.categoria),
      joinedload(HerramientaDigital.institucion),
    )
    .filter(HerramientaDigital.id_tipo_servicio == id_tipo)
    .join(HerramientaDigital.categoria)
  )

  if id_institucion:
    query = query.filter(HerramientaDigital.id_institucion == id_institucion)

  if filter_terms:
    pattern = f"%{filter_terms}%"
    query = query.filter(
      or_(
        HerramientaDigital.nombre.ilike(pattern),
        HerramientaDigital.descripcion.ilike(pattern),
      )
    )

  herramientas = query.order_by(
    func.lower(Categoria.nombre), func.lower(HerramientaDigital.nombre)
  ).all()

  categorias = OrderedDict()
  instituciones = OrderedDict()

  for herramienta in herramientas:
    categoria = herramienta.categoria
    if not categoria:
        continue
    categoria_data = categorias.setdefault(
      categoria.id,
      {
        'id': categoria.id,
        'nombre': sanitize_text(categoria.nombre),
        'descripcion': sanitize_text(categoria.definicion),
        'herramientas': [],
      },
    )
    categoria_data['herramientas'].append(herramienta)

    institucion = herramienta.institucion
    if institucion and institucion.id_padre not in EXCLUDED_PARENT_IDS:
      instituciones.setdefault(
        institucion.id,
        {
          'id': institucion.id,
          'nombre': sanitize_text(institucion.nombre),
        },
      )

  instituciones_disponibles = (
    Institucion.query.join(Institucion.herramientas)
    .filter(
      HerramientaDigital.id_tipo_servicio == id_tipo,
      ~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS),
    )
    .with_entities(Institucion.id, Institucion.nombre)
    .order_by(Institucion.id.asc())
    .distinct()
    .all()
  )

  instituciones_catalogo = [
    {'id': inst_id, 'nombre': sanitize_text(nombre)}
    for inst_id, nombre in instituciones_disponibles
  ]
  instituciones_catalogo.sort(key=lambda i: i['id'])

  categorias_list = list(categorias.values())
  total_herramientas = sum(
      len(categoria_data['herramientas']) for categoria_data in categorias_list
  )

  return render_template(
    'geoportal/subcatalogo.html',
    slug=slug,
    tipos_servicios=tipos_servicios,
    tipo_nombre=tipo_nombre,
    tipo_titulo=tipo_titulo,
    tipo_descripcion=tipo_descripcion,
    categorias=categorias_list,
    instituciones=instituciones_catalogo,
    id_institucion=id_institucion,
    filter_terms=filter_terms,
    total_herramientas=total_herramientas,
  )
