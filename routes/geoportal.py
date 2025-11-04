import re
import unicodedata
import hmac
import secrets
from collections import OrderedDict
from copy import deepcopy
from types import SimpleNamespace

from flask import (
  Blueprint,
  current_app,
  render_template,
  request,
  abort,
  url_for,
  session,
)
from sqlalchemy.orm import joinedload
from sqlalchemy import func, or_, and_
from markupsafe import escape
from pathlib import Path
from urllib.parse import urlparse

from models.herramientas_digitales import HerramientaDigital
from models.categorias import Categoria
from models.instituciones import Institucion
from models.tipos_servicios import TipoServicio
from models.capas_geograficas import CapaGeografica, ServicioGeografico
from extensions import cache

bp = Blueprint('geoportal', __name__)

CATALOGO_CAPA_TIPO_IDS = (11, 12, 14, 17, 20)

EXCLUDED_PARENT_IDS = tuple(range(10))

SEARCH_TOKEN_SESSION_KEY = 'catalog_search_token'

def sanitize_text(value):
  if value is None:
    return None
  return str(escape(value))

def sanitize_query_text(value):
  if not value:
    return ''
  return re.sub(r"[<>\"'`]", '', value).strip()


def ensure_search_token():
  token = session.get(SEARCH_TOKEN_SESSION_KEY)
  if not token:
    token = secrets.token_urlsafe(32)
    session[SEARCH_TOKEN_SESSION_KEY] = token
  return token


def is_search_token_valid(provided_token):
  expected_token = session.get(SEARCH_TOKEN_SESSION_KEY)
  if not provided_token or not expected_token:
    return False
  try:
    return hmac.compare_digest(provided_token, expected_token)
  except TypeError:
    return False

def sanitize_external_url(value):
  if not value:
    return None

  value = value.strip()
  parsed = urlparse(value)

  if parsed.scheme in {'http', 'https'}:
    return value

  if not parsed.scheme and value.startswith('/'):
    return value

  return None

def obtener_imagen_herramienta_url(herramienta_id):
  if not herramienta_id:
    return url_for('static', filename='imagenes/imagen_no_disponible.jpg')

  static_folder = Path(current_app.static_folder)
  candidate_paths = []
  for directory in ('imagenes/herramientas_digitales', 'imagenes'):
    for extension in ('webp', 'jpg', 'jpeg', 'png'):
      candidate_paths.append(Path(directory) / f"{herramienta_id}.{extension}")

  for relative_path in candidate_paths:
    if (static_folder / relative_path).is_file():
      return url_for('static', filename=relative_path.as_posix())

  return url_for('static', filename='imagenes/imagen_no_disponible.jpg')

def obtener_tipos_servicios_catalogo():
  tipos = (
    TipoServicio.query.filter(
      TipoServicio.id_padre.in_((1, 2, 3)),
      TipoServicio.estado.is_(True),
    )
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )

  tipos_catalogo = []
  tipos_por_slug = {}

  for tipo in tipos:
    slug_base = (tipo.tag or '').strip() or slugify(tipo.nombre)
    if not slug_base:
      slug_base = f"tipo-{tipo.id}"

    slug_normalizado = slug_base.lower()

    tipo_data = {
      'id': tipo.id,
      'nombre': sanitize_text(tipo.nombre),
      'descripcion': sanitize_text(tipo.descripcion),
      'logotipo': tipo.logotipo,
      'slug': slug_base,
      'tag': slug_base,
    }

    tipos_catalogo.append(tipo_data)
    if slug_normalizado and slug_normalizado not in tipos_por_slug:
      tipos_por_slug[slug_normalizado] = tipo_data

  return SimpleNamespace(lista=tipos_catalogo, por_slug=tipos_por_slug)
  return SimpleNamespace(lista=tipos_catalogo, por_slug=tipos_por_slug)

@cache.memoize(timeout=300)
def obtener_datos_catalogo_cacheados(id_tipo, id_categoria, id_institucion, filter_terms):
  id_categoria = id_categoria or None
  id_institucion = id_institucion or None

  categorias = OrderedDict()
  es_tipo_capa = id_tipo in CATALOGO_CAPA_TIPO_IDS

  if es_tipo_capa:
    query = (
      CapaGeografica.query.options(
        joinedload(CapaGeografica.categoria),
        joinedload(CapaGeografica.institucion),
        joinedload(CapaGeografica.servicios),
      )
      .filter(
        CapaGeografica.servicios.any(
          and_(
            ServicioGeografico.id_tipo_servicio == id_tipo,
            or_(
              ServicioGeografico.estado.is_(True),
              ServicioGeografico.estado.is_(None),
            ),
          )
        )
      )
    )

    if id_institucion:
      query = query.filter(CapaGeografica.id_institucion == id_institucion)

    if id_categoria:
      query = query.filter(CapaGeografica.id_categoria == id_categoria)

    if filter_terms:
      pattern = f"%{filter_terms}%"
      query = query.filter(
        or_(
          CapaGeografica.nombre.ilike(pattern),
          CapaGeografica.descripcion.ilike(pattern),
          CapaGeografica.servicios.any(ServicioGeografico.nombre_capa.ilike(pattern)),
          CapaGeografica.servicios.any(ServicioGeografico.titulo_capa.ilike(pattern)),
        )
      )

    capas = query.all()
    capas.sort(
      key=lambda capa: (
        (capa.categoria.nombre.lower() if capa.categoria and capa.categoria.nombre else ''),
        (capa.nombre.lower() if capa.nombre else ''),
      )
    )

    for capa in capas:
      categoria = capa.categoria
      if not categoria:
        continue

      servicios_relacionados = [
        servicio
        for servicio in capa.servicios
        if servicio.id_tipo_servicio == id_tipo
        and (servicio.estado is True or servicio.estado is None)
      ]

      if not servicios_relacionados:
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

      institucion = capa.institucion
      institucion_info = None
      if institucion and institucion.id_padre not in EXCLUDED_PARENT_IDS:
        institucion_info = sanitize_text(institucion.nombre)

      servicios_data = []
      for servicio in sorted(
        servicios_relacionados,
        key=lambda item: (
          (item.titulo_capa or item.nombre_capa or '').lower(),
        ),
      ):
        etiqueta = servicio.titulo_capa or servicio.nombre_capa or capa.nombre
        servicios_data.append(
          {
            'etiqueta': sanitize_text(etiqueta),
            'nombre': sanitize_text(servicio.nombre_capa),
            'titulo': sanitize_text(servicio.titulo_capa),
            'url': servicio.direccion_web,
          }
        )

      categoria_data['herramientas'].append(
        {
          'id': capa.id,
          'nombre': sanitize_text(capa.nombre),
          'descripcion': sanitize_text(capa.descripcion),
          'institucion': institucion_info,
          'servicios': servicios_data,
          'estado': 1,
          'estado_label': 'Disponible',
          'estado_is_active': True,
          'recurso': None,
          'imagen_url': obtener_imagen_herramienta_url(capa.id),
          'tipo_servicio': None,
        }
      )

    instituciones_disponibles = (
      Institucion.query.join(Institucion.capas)
      .join(CapaGeografica.servicios)
      .filter(
        ServicioGeografico.id_tipo_servicio == id_tipo,
        ~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS),
      )
    )

    if id_categoria:
      instituciones_disponibles = instituciones_disponibles.filter(
        CapaGeografica.id_categoria == id_categoria
      )

    instituciones_disponibles = (
      instituciones_disponibles.with_entities(Institucion.id, Institucion.nombre)
      .order_by(Institucion.id.asc())
      .distinct()
      .all()
    )

    categorias_disponibles = (
      Categoria.query.join(Categoria.capas)
      .join(CapaGeografica.servicios)
      .filter(ServicioGeografico.id_tipo_servicio == id_tipo)
      .with_entities(Categoria.id, Categoria.nombre)
      .order_by(Categoria.nombre.asc())
      .distinct()
      .all()
    )
  else:
    query = (
      HerramientaDigital.query.options(
        joinedload(HerramientaDigital.categoria),
        joinedload(HerramientaDigital.institucion),
        joinedload(HerramientaDigital.tipo_servicio),
      )
      .filter(HerramientaDigital.id_tipo_servicio == id_tipo)
      .join(HerramientaDigital.categoria)
    )

    if id_categoria:
      query = query.filter(HerramientaDigital.id_categoria == id_categoria)

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

      institucion = herramienta.institucion
      institucion_nombre = None
      if institucion and institucion.id_padre not in EXCLUDED_PARENT_IDS:
        institucion_nombre = sanitize_text(institucion.nombre)

      estado = herramienta.estado or 0
      estado_is_active = estado == 1
      estado_label = 'Disponible' if estado_is_active else 'En mantenimiento'
      recurso = sanitize_external_url(herramienta.recurso)

      categoria_data['herramientas'].append(
        {
          'id': herramienta.id,
          'nombre': sanitize_text(herramienta.nombre),
          'descripcion': sanitize_text(herramienta.descripcion),
          'institucion': institucion_nombre,
          'recurso': recurso,
          'estado': estado,
          'estado_label': estado_label,
          'estado_is_active': estado_is_active,
          'imagen_url': obtener_imagen_herramienta_url(herramienta.id),
          'tipo_servicio': sanitize_text(
            herramienta.tipo_servicio.nombre if herramienta.tipo_servicio else None
          ),
        }
      )

    instituciones_disponibles = (
      Institucion.query.join(Institucion.herramientas)
      .filter(
        HerramientaDigital.id_tipo_servicio == id_tipo,
        ~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS),
      )
    )

    if id_categoria:
      instituciones_disponibles = instituciones_disponibles.filter(
        HerramientaDigital.id_categoria == id_categoria
      )

    instituciones_disponibles = (
      instituciones_disponibles.with_entities(Institucion.id, Institucion.nombre)
      .order_by(Institucion.nombre.asc())
      .distinct()
      .all()
    )

    categorias_disponibles = (
      Categoria.query.join(Categoria.herramientas)
      .filter(HerramientaDigital.id_tipo_servicio == id_tipo)
      .with_entities(Categoria.id, Categoria.nombre)
      .order_by(Categoria.nombre.asc())
      .distinct()
      .all()
    )

  categorias_list = list(categorias.values())
  total_herramientas = sum(
    len(categoria_data['herramientas']) for categoria_data in categorias_list
  )

  categorias_opciones = [
    {'id': cat_id, 'nombre': sanitize_text(nombre)}
    for cat_id, nombre in categorias_disponibles
  ]

  instituciones_opciones = [
    {'id': inst_id, 'nombre': sanitize_text(nombre)}
    for inst_id, nombre in instituciones_disponibles
  ]

  categorias_opciones.sort(key=lambda item: (item['nombre'] or '').lower())
  instituciones_opciones.sort(key=lambda item: (item['nombre'] or '').lower())

  return {
    'categorias': categorias_list,
    'categorias_opciones': categorias_opciones,
    'instituciones_opciones': instituciones_opciones,
    'total_herramientas': total_herramientas,
  }


def construir_contexto_catalogo(tipos_catalogo, tipo_config=None):
  id_institucion = request.args.get('id_institucion', type=int)
  id_categoria = request.args.get('id_categoria', type=int)
  filter_terms_raw = request.args.get('filter_terms', default='', type=str)
  provided_token = request.args.get('search_token', type=str)
  search_token = ensure_search_token()

  filter_terms = ''
  if filter_terms_raw:
    if is_search_token_valid(provided_token):
      filter_terms = sanitize_query_text(filter_terms_raw)
      if filter_terms_raw and not filter_terms:
        filter_terms = ''
    else:
      filter_terms_raw = ''

  categorias_opciones = []
  instituciones_opciones = []
  categorias_list = []
  total_herramientas = 0
  selected_tipo = None
  applied_filters = []
  selected_tipo_slug = None

  if tipo_config:
    selected_tipo = {
      'id': tipo_config['id'],
      'nombre': tipo_config['nombre'],
      'descripcion': tipo_config.get('descripcion'),
      'slug': tipo_config.get('slug') or tipo_config.get('tag'),
    }
    if selected_tipo['nombre']:
      applied_filters.append(selected_tipo['nombre'])

    id_tipo = tipo_config['id']
    selected_tipo_slug = (tipo_config.get('slug') or tipo_config.get('tag') or '').lower()

    cache_key = (
      id_tipo,
      id_categoria or 0,
      id_institucion or 0,
      filter_terms.lower() if filter_terms else '',
    )
    datos_cacheados = deepcopy(obtener_datos_catalogo_cacheados(*cache_key))

    categorias_list = datos_cacheados['categorias']
    categorias_opciones = datos_cacheados['categorias_opciones']
    instituciones_opciones = datos_cacheados['instituciones_opciones']
    total_herramientas = datos_cacheados['total_herramientas']

    if selected_tipo and selected_tipo['nombre']:
      for categoria in categorias_list:
        for herramienta in categoria.get('herramientas', []):
          if not herramienta.get('tipo_servicio'):
            herramienta['tipo_servicio'] = selected_tipo['nombre']

  if id_categoria:
    selected_categoria_nombre = next(
      (cat['nombre'] for cat in categorias_opciones if cat['id'] == id_categoria),
      None,
    )
    if selected_categoria_nombre:
      applied_filters.append(selected_categoria_nombre)

  if id_institucion:
    selected_institucion_nombre = next(
      (inst['nombre'] for inst in instituciones_opciones if inst['id'] == id_institucion),
      None,
    )
    if selected_institucion_nombre:
      applied_filters.append(selected_institucion_nombre)

  if filter_terms:
    applied_filters.append(f"Contiene: {sanitize_text(filter_terms)}")

  clear_filters_enabled = bool(applied_filters)

  return {
    'tipos_servicios': tipos_catalogo.lista,
    'selected_tipo': selected_tipo,
    'selected_tipo_slug': selected_tipo_slug,
    'categorias': categorias_list,
    'categorias_opciones': categorias_opciones,
    'instituciones_opciones': instituciones_opciones,
    'selected_categoria_id': id_categoria,
    'selected_institucion_id': id_institucion,
    'filter_terms': filter_terms,
    'applied_filters': applied_filters,
    'clear_filters_enabled': clear_filters_enabled,
    'total_herramientas': total_herramientas,
    'catalogo_url': url_for('geoportal.catalogo'),
    'search_token': search_token,
  }

@bp.route('/')
def principal():
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  geoportales_count = HerramientaDigital.query.filter(
      HerramientaDigital.id_tipo_servicio == 5
  ).count()
  servicios_mapas_count = CapaGeografica.query.count()
  visores_count = HerramientaDigital.query.filter(
      HerramientaDigital.id_tipo_servicio == 6
  ).count()
  catalogo_metadatos_count = HerramientaDigital.query.filter(
      HerramientaDigital.id_tipo_servicio == 9
  ).count()

  estadisticas = [
    {
      'label': 'Geoportales institucionales',
      'count': geoportales_count,
    },
    {
      'label': 'Servicios de mapas geográficos',
      'count': servicios_mapas_count,
    },
    {
      'label': 'Visores de mapas institucional',
      'count': visores_count,
    },
    {
      'label': 'Catálogo de Metadatos geográficos',
      'count': catalogo_metadatos_count,
    },
  ]

  for estadistica in estadisticas:
    estadistica['display_value'] = f"+{estadistica['count']:,}".replace(',', '')

  return render_template(
      'geoportal/inicio.html',
      tipos_servicios=tipos_catalogo.lista,
      estadisticas=estadisticas,
  )

@bp.route('/catalogo')
def catalogo():
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  contexto = construir_contexto_catalogo(tipos_catalogo)
  return render_template('geoportal/catalogo.html', **contexto)

@bp.route('/catalogo/<slug>')
def catalogo_por_tipo(slug):
  slug_normalizado = slug.lower()
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  tipo_config = tipos_catalogo.por_slug.get(slug_normalizado)
  if not tipo_config:
    abort(404)
  contexto = construir_contexto_catalogo(tipos_catalogo, tipo_config)
  return render_template('geoportal/catalogo.html', **contexto)
