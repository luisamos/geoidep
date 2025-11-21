import re
import hmac
import secrets
import unicodedata
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
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse, quote

from apps.models import HerramientaDigital
from apps.models import Categoria
from apps.models import Institucion
from apps.models import TipoServicio
from apps.models import CapaGeografica, ServicioGeografico
from apps.extensions import cache

bp = Blueprint('geoportal', __name__)

SEARCH_TOKEN_SESSION_KEY = 'catalog_search_token'

EXCLUDED_PARENT_IDS = tuple(range(10))

DEFAULT_CAPA_PARENT_IDS = frozenset({2, 3})
DEFAULT_CAPA_TIPO_IDS = frozenset({11, 12, 14, 17, 20})

WFS_FORMATOS_ARCGIS = (
  ('GEOJSON', 'GEOJSON'),
  ('KML', 'KML'),
  ('SHAPE+ZIP', 'SHAPE+ZIP'),
  ('CSV', 'CSV'),
  ('Geopackage', 'GEOPACKAGE'),
)

WFS_FORMATOS_GEOSERVER = (
  ('GEOJSON', 'application/json'),
  ('KML', 'application/vnd.google-earth.kml+xml'),
  ('SHAPE+ZIP', 'shape-zip'),
  ('CSV', 'csv'),
  ('Geopackage', 'application/geopackage+sqlite3'),
)

def sanitize_text(value):
  if value is None:
    return None
  return str(escape(value))

def sanitize_query_text(value):
  if not value:
    return ''
  return re.sub(r"[<>\"'`]", '', value).strip()

def slugify_text(value):
  if not value:
    return ''

  normalized = unicodedata.normalize('NFKD', str(value))
  ascii_text = normalized.encode('ascii', 'ignore').decode('ascii')
  slug = re.sub(r'[^a-z0-9]+', '-', ascii_text.lower()).strip('-')
  return slug

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

def obtener_imagen_capa_url(id_capa):
  if not id_capa:
    return url_for('static', filename='imagenes/imagen_no_disponible.png')

  static_folder = Path(current_app.static_folder)
  candidate_paths = []
  for extension in ('webp', 'jpg', 'jpeg', 'png'):
    candidate_paths.append(Path('imagenes/capas_geograficas') / f"{id_capa}.{extension}")

  for relative_path in candidate_paths:
    if (static_folder / relative_path).is_file():
      return url_for('static', filename=relative_path.as_posix())

  fallback = Path('imagenes') / 'imagen_no_disponible.png'
  if (static_folder / fallback).is_file():
    return url_for('static', filename=fallback.as_posix())

  return url_for('static', filename='imagenes/imagen_no_disponible.jpg')

@cache.memoize(timeout=300)
def obtener_configuracion_servicios():
  tipos = (
    TipoServicio.query.filter(
      TipoServicio.estado.is_(True),
      TipoServicio.id_padre.in_(DEFAULT_CAPA_PARENT_IDS),
    )
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )

  tipos_por_id = {}
  capa_tipo_ids = set()

  for tipo in tipos:
    sigla = (tipo.sigla or '').strip()
    nombre = (tipo.nombre or '').strip()
    tag = (tipo.tag or '').strip()
    recurso = (tipo.recurso or '').strip() if getattr(tipo, 'recurso', None) else None

    tipos_por_id[tipo.id] = {
      'id': tipo.id,
      'sigla': sigla or None,
      'nombre': nombre or None,
      'recurso': recurso or None,
      'tag': tag or None,
      'id_padre': tipo.id_padre,
    }

    capa_tipo_ids.add(tipo.id)

  if not capa_tipo_ids:
    capa_tipo_ids = set(DEFAULT_CAPA_TIPO_IDS)

  return {
    'por_id': tipos_por_id,
    'ids_capa': frozenset(capa_tipo_ids),
  }

def build_capabilities_url(base_url, fragment):
  if not base_url:
    return None

  base_url = base_url.strip()
  if not base_url:
    return None

  fragment = (fragment or '').strip()
  if not fragment:
    return base_url

  if fragment.startswith('?') or fragment.startswith('&'):
    fragment = fragment[1:]

  if not fragment:
    return base_url

  parsed_base = urlparse(base_url)
  base_pairs = parse_qsl(parsed_base.query, keep_blank_values=True)

  def normalize_key(key):
    normalized = (key or '').strip().lower()
    if normalized == 'services':
      return 'service'
    return normalized

  merged_pairs = OrderedDict()

  for key, value in base_pairs:
    normalized_key = normalize_key(key)
    if not normalized_key:
      continue
    if normalized_key in merged_pairs:
      continue
    merged_pairs[normalized_key] = (key, value)

  fragment_pairs = parse_qsl(fragment, keep_blank_values=True)
  for key, value in fragment_pairs:
    normalized_key = normalize_key(key)
    if not normalized_key:
      continue
    if normalized_key in merged_pairs:
      continue
    merged_pairs[normalized_key] = (key, value)

  new_query = urlencode(list(merged_pairs.values()), doseq=True)
  updated = parsed_base._replace(query=new_query)
  return urlunparse(updated)

def es_servicio_wfs_arcgis(base_url):
  if not base_url:
    return False

  return 'mapserver/wfsserver' in base_url.lower()

def obtener_opciones_formato_wfs(base_url):
  if es_servicio_wfs_arcgis(base_url):
    return WFS_FORMATOS_ARCGIS
  return WFS_FORMATOS_GEOSERVER

def construir_url_descarga_wfs(base_url, nombre_capa, formato_salida):
  if not base_url or not nombre_capa or not formato_salida:
    return None

  parsed_base = urlparse(base_url)
  base_pairs = parse_qsl(parsed_base.query, keep_blank_values=True)
  base_pairs = [
    (key, value)
    for key, value in base_pairs
    if key.lower() not in {'service', 'request', 'typename', 'outputformat'}
  ]

  base_pairs.extend(
    [
      ('service', 'WFS'),
      ('request', 'GetFeature'),
      ('typeName', nombre_capa),
      ('outputFormat', formato_salida),
    ]
  )

  new_query = urlencode(base_pairs, doseq=True, quote_via=quote)
  updated = parsed_base._replace(query=new_query)
  return urlunparse(updated)

def construir_opciones_descarga_wfs(base_url, nombre_capa):
  base_url = sanitize_external_url(base_url)
  nombre_capa = (nombre_capa or '').strip()

  if not base_url or not nombre_capa:
    return []

  opciones = []
  for etiqueta, formato in obtener_opciones_formato_wfs(base_url):
    url_descarga = construir_url_descarga_wfs(base_url, nombre_capa, formato)
    if url_descarga:
      opciones.append(
        {
          'label': etiqueta,
          'url': url_descarga,
        }
      )

  return opciones

def obtener_sigla_servicio(tipo_servicio, id_servicio):
  if tipo_servicio is not None:
    sigla = getattr(tipo_servicio, 'sigla', None)
    if sigla:
      return sanitize_text(sigla)
    nombre = getattr(tipo_servicio, 'nombre', None)
    if nombre:
      return sanitize_text(nombre)

  configuracion = obtener_configuracion_servicios()
  datos_tipo = configuracion['por_id'].get(id_servicio, {})
  sigla = datos_tipo.get('sigla') or datos_tipo.get('nombre')
  return sanitize_text(sigla) if sigla else None

def obtener_recurso_tipo_servicio(tipo_servicio, id_servicio):
  if tipo_servicio is not None:
    recurso = getattr(tipo_servicio, 'recurso', None)
    if recurso:
      recurso = recurso.strip()
      if recurso:
        return recurso

  configuracion = obtener_configuracion_servicios()
  datos_tipo = configuracion['por_id'].get(id_servicio, {})
  recurso = datos_tipo.get('recurso')
  return recurso.strip() if recurso else None

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
    slug_base = (tipo.tag or '').strip() or slugify_text(tipo.nombre)
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
def obtener_datos_catalogo_cacheados(
  id_tipo,
  id_categoria,
  id_institucion,
  filter_terms,
  estado_filter=None,
):
  id_categoria = id_categoria or None
  id_institucion = id_institucion or None
  if estado_filter not in (0, 1, None):
    estado_filter = None

  categorias = OrderedDict()
  configuracion_servicios = obtener_configuracion_servicios()
  es_tipo_capa = id_tipo in configuracion_servicios['ids_capa']

  if es_tipo_capa:
    query = (
      CapaGeografica.query.options(
        joinedload(CapaGeografica.categoria),
        joinedload(CapaGeografica.institucion),
        joinedload(CapaGeografica.servicios).joinedload(
          ServicioGeografico.tipo_servicio
        ),
      )
      .filter(
        CapaGeografica.servicios.any(
          and_(
            ServicioGeografico.id_tipo_servicio == id_tipo,
            *(
              [ServicioGeografico.estado.is_(bool(estado_filter))]
              if estado_filter is not None
              else []
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

      servicios_relacionados = []
      for servicio in capa.servicios:
        if servicio.id_tipo_servicio not in configuracion_servicios['ids_capa']:
          continue

        estado_activo = servicio.estado is True
        if estado_filter == 1 and not estado_activo:
          continue
        if estado_filter == 0 and estado_activo:
          continue

        servicios_relacionados.append(servicio)

      if not any(
        servicio.id_tipo_servicio == id_tipo
        for servicio in servicios_relacionados
      ):
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
      acciones = []
      acciones_vistas = set()
      acciones_copia = set()
      def servicio_sort_key(item):
        tipo = item.tipo_servicio
        orden = getattr(tipo, 'orden', None)
        if orden is None:
          orden = 9999
        sigla_orden = obtener_sigla_servicio(tipo, item.id_tipo_servicio) or ''
        return (
          orden,
          sigla_orden.lower(),
        )

      for servicio in sorted(servicios_relacionados, key=servicio_sort_key):
        recurso = sanitize_external_url(servicio.direccion_web)
        estado_activo = servicio.estado is True
        sigla = obtener_sigla_servicio(
          servicio.tipo_servicio,
          servicio.id_tipo_servicio,
        )
        copy_url = None
        download_options = []
        layer_name = None
        if servicio.nombre_capa and servicio.nombre_capa.strip():
          layer_name = servicio.nombre_capa.strip()
        elif servicio.titulo_capa and servicio.titulo_capa.strip():
          layer_name = servicio.titulo_capa.strip()
        elif capa and capa.nombre:
          layer_name = capa.nombre.strip()
        recurso_tipo = obtener_recurso_tipo_servicio(
          servicio.tipo_servicio,
          servicio.id_tipo_servicio,
        )
        if recurso:
          if recurso_tipo:
            copy_url = build_capabilities_url(recurso, recurso_tipo)
          else:
            copy_url = recurso

        sigla_display = sigla or 'SERVICIO'
        view_map_url = None
        if estado_activo and sigla_display and 'WMS' in sigla_display.upper():
          view_map_url = f"https://visor.geoperu.gob.pe/?idcapa={servicio.id}"

        if (
          estado_activo
          and recurso
          and layer_name
          and sigla_display
          and 'WFS' in sigla_display.upper()
        ):
          download_options = construir_opciones_descarga_wfs(recurso, layer_name)

        if estado_activo and view_map_url and view_map_url not in acciones_vistas:
          acciones.append(
            {
              'tipo': 'view_map',
              'url': view_map_url,
            }
          )
          acciones_vistas.add(view_map_url)

        if estado_activo and copy_url:
          copy_key = (sigla_display, copy_url)
          if copy_key not in acciones_copia:
            acciones.append(
              {
                'tipo': 'copy',
                'url': copy_url,
                'sigla': sigla_display,
              }
            )
            acciones_copia.add(copy_key)

        servicios_data.append(
          {
            'estado': 1 if estado_activo else 0,
            'estado_is_active': estado_activo,
            'copy_url': copy_url if estado_activo else None,
            'view_map_url': view_map_url,
            'sigla': sigla_display,
            'id_tipo_servicio': servicio.id_tipo_servicio,
            'download_options': download_options,
          }
        )

      estado_general_activo = any(
        item['estado_is_active'] for item in servicios_data
      )

      categoria_data['herramientas'].append(
        {
          'id': capa.id,
          'nombre': sanitize_text(capa.nombre),
          'descripcion': sanitize_text(capa.descripcion),
          'institucion': institucion_info,
          'servicios': servicios_data,
          'acciones': acciones,
          'estado': 1 if estado_general_activo else 0,
          'estado_label': 'Disponible' if estado_general_activo else 'No disponible',
          'estado_is_active': estado_general_activo,
          'recurso': None,
          'imagen_url': obtener_imagen_capa_url(capa.id),
          'tipo_servicio': None,
          'es_capa': True,
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

    if estado_filter is not None:
      instituciones_disponibles = instituciones_disponibles.filter(
        ServicioGeografico.estado.is_(bool(estado_filter))
      )

    instituciones_disponibles = (
      instituciones_disponibles.with_entities(
        Institucion.id,
        Institucion.nombre,
        Institucion.sigla,
      )
      .order_by(Institucion.id.asc())
      .distinct()
      .all()
    )

    categorias_disponibles_query = (
      Categoria.query.join(Categoria.capas)
      .join(CapaGeografica.servicios)
      .filter(ServicioGeografico.id_tipo_servicio == id_tipo)
    )

    if estado_filter is not None:
      categorias_disponibles_query = categorias_disponibles_query.filter(
        ServicioGeografico.estado.is_(bool(estado_filter))
      )

    categorias_disponibles = (
      categorias_disponibles_query.with_entities(Categoria.id, Categoria.nombre)
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

    if estado_filter is not None:
      query = query.filter(HerramientaDigital.estado == bool(estado_filter))

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
          'servicios': [],
          'acciones': [],
          'es_capa': False,
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

    if estado_filter is not None:
      instituciones_disponibles = instituciones_disponibles.filter(
        HerramientaDigital.estado == bool(estado_filter)
      )

    instituciones_disponibles = (
      instituciones_disponibles.with_entities(
        Institucion.id,
        Institucion.nombre,
        Institucion.sigla,
      )
      .order_by(Institucion.nombre.asc())
      .distinct()
      .all()
    )

    categorias_disponibles_query = (
      Categoria.query.join(Categoria.herramientas)
      .filter(HerramientaDigital.id_tipo_servicio == id_tipo)
    )

    if estado_filter is not None:
      categorias_disponibles_query = categorias_disponibles_query.filter(
        HerramientaDigital.estado == bool(estado_filter)
      )

    categorias_disponibles = (
      categorias_disponibles_query.with_entities(Categoria.id, Categoria.nombre)
      .order_by(Categoria.nombre.asc())
      .distinct()
      .all()
    )

  categorias_list = list(categorias.values())
  total_herramientas = sum(
    len(categoria_data['herramientas']) for categoria_data in categorias_list
  )

  categorias_opciones = [
    {'id': id_cat, 'nombre': sanitize_text(nombre)}
    for id_cat, nombre in categorias_disponibles
  ]

  instituciones_opciones = [
    {
      'id': id_inst,
      'nombre': sanitize_text(nombre),
      'sigla': sanitize_text(sigla) if sigla else None,
    }
    for id_inst, nombre, sigla in instituciones_disponibles
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
  estado_param = request.args.get('ordenar', type=str)
  provided_token = request.args.get('search_token', type=str)
  filter_terms_raw = request.args.get('filter_terms', default='', type=str)
  search_token = ensure_search_token()

  estado_filter = None
  if estado_param in {'0', '1'}:
    estado_filter = int(estado_param)
  else:
    estado_param = ''

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
  selected_tipo_slug = None
  applied_filters = []

  estado_cache_key = estado_filter if estado_filter is not None else -1

  if tipo_config:
    selected_tipo = {
      'id': tipo_config['id'],
      'nombre': tipo_config['nombre'],
      'descripcion': tipo_config.get('descripcion'),
      'slug': tipo_config.get('slug') or tipo_config.get('tag'),
    }

    id_tipo = tipo_config['id']
    selected_tipo_slug = (tipo_config.get('slug') or tipo_config.get('tag') or '').lower()

    cache_args = (
      id_tipo,
      id_categoria or 0,
      id_institucion or 0,
      filter_terms.lower() if filter_terms else '',
      estado_cache_key,
    )
    datos_cacheados = deepcopy(obtener_datos_catalogo_cacheados(*cache_args))

    categorias_list = datos_cacheados['categorias']
    categorias_opciones = datos_cacheados['categorias_opciones']
    instituciones_opciones = datos_cacheados['instituciones_opciones']
    total_herramientas = datos_cacheados['total_herramientas']

    if selected_tipo['nombre']:
      applied_filters.append(
        {
          'label': selected_tipo['nombre'],
          'type': 'tipo',
        }
      )
      for categoria in categorias_list:
        for herramienta in categoria.get('herramientas', []):
          if not herramienta.get('tipo_servicio'):
            herramienta['tipo_servicio'] = selected_tipo['nombre']
  else:
    aggregated_request = any(
      [
        filter_terms,
        id_categoria,
        id_institucion,
        estado_filter is not None,
      ]
    )

    if aggregated_request:
      categorias_agregadas = OrderedDict()
      categorias_opciones_map = {}
      instituciones_opciones_map = {}

      for tipo in tipos_catalogo.lista:
        id_tipo = tipo.get('id')
        if not id_tipo:
          continue

        cache_args = (
          id_tipo,
          id_categoria or 0,
          id_institucion or 0,
          filter_terms.lower() if filter_terms else '',
          estado_cache_key,
        )
        datos_tipo = deepcopy(obtener_datos_catalogo_cacheados(*cache_args))

        if not datos_tipo['total_herramientas']:
          continue

        for categoria in datos_tipo['categorias']:
          categoria_acumulada = categorias_agregadas.setdefault(
            categoria['id'],
            {
              'id': categoria['id'],
              'nombre': categoria.get('nombre'),
              'descripcion': categoria.get('descripcion'),
              'herramientas': [],
            },
          )

          for herramienta in categoria.get('herramientas', []):
            if not herramienta.get('tipo_servicio'):
              herramienta['tipo_servicio'] = tipo.get('nombre')
            categoria_acumulada['herramientas'].append(herramienta)

        for opcion in datos_tipo['categorias_opciones']:
          categorias_opciones_map[opcion['id']] = opcion

        for opcion in datos_tipo['instituciones_opciones']:
          existente = instituciones_opciones_map.get(opcion['id'])
          if not existente or (opcion.get('sigla') and not existente.get('sigla')):
            instituciones_opciones_map[opcion['id']] = opcion

      categorias_list = [
        datos
        for _, datos in sorted(
          categorias_agregadas.items(),
          key=lambda item: (item[1]['nombre'] or '').lower(),
        )
      ]

      for categoria in categorias_list:
        categoria['herramientas'].sort(
          key=lambda item: (item.get('nombre') or '').lower()
        )

      categorias_opciones = sorted(
        categorias_opciones_map.values(),
        key=lambda item: (item['nombre'] or '').lower(),
      )
      instituciones_opciones = sorted(
        instituciones_opciones_map.values(),
        key=lambda item: (item['nombre'] or '').lower(),
      )

      total_herramientas = sum(
        len(categoria.get('herramientas', [])) for categoria in categorias_list
      )

  if id_categoria:
    selected_categoria_nombre = next(
      (cat['nombre'] for cat in categorias_opciones if cat['id'] == id_categoria),
      None,
    )
    if selected_categoria_nombre:
      applied_filters.append(
        {
          'label': selected_categoria_nombre,
          'type': 'categoria',
        }
      )

  if id_institucion:
    selected_institucion = next(
      (inst for inst in instituciones_opciones if inst['id'] == id_institucion),
      None,
    )
    if selected_institucion:
      label = selected_institucion['nombre']
      if selected_institucion.get('sigla'):
        label = f"{label} ({selected_institucion['sigla']})"
      applied_filters.append(
        {
          'label': label,
          'type': 'entidad',
        }
      )

  if filter_terms:
    applied_filters.append(
      {
        'label': f"Contiene: {sanitize_text(filter_terms)}",
        'type': 'search',
      }
    )

  if estado_filter is not None:
    applied_filters.append(
      {
        'label': 'Disponible' if estado_filter == 1 else 'En mantenimiento',
        'type': 'estado',
      }
    )

  clear_filters_enabled = bool(applied_filters)

  return {
    'tipos_servicios': tipos_catalogo.lista,
    'selected_tipo': selected_tipo,
    'selected_tipo_slug': selected_tipo_slug,
    'categorias': categorias_list,
    'categorias_opciones': categorias_opciones,
    'instituciones_opciones': instituciones_opciones,
    'selected_id_categoria': id_categoria,
    'selected_id_institucion': id_institucion,
    'filter_terms': filter_terms,
    'selected_estado': estado_filter,
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
      catalogo_url=url_for('geoportal.catalogo'),
      search_token=ensure_search_token(),
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

@bp.route('/idep')
def que_es_la_idep():
  secciones = [
    {
      'id': 'institucional',
      'titulo': 'Institucional',
      'descripcion': (
        'Comprende la base conceptual, los actores y las etapas que permiten '
        'gestionar la Infraestructura de Datos Espaciales del Perú.'
      ),
      'subsecciones': [
        {
          'titulo': '¿Qué es la IDEP?',
          'descripcion': (
            'La IDEP articula datos, servicios y estándares geoespaciales del '
            'Estado para facilitar su búsqueda, uso y reutilización segura.'
          ),
          'imagen': 'imagenes/que_es_idep.png',
        },
        {
          'titulo': 'Componentes de la IDEP',
          'descripcion': (
            'Marco institucional, normativa, tecnología, datos, estándares y '
            'talento que hacen posible la operación de la plataforma.'
          ),
          'imagen': 'imagenes/image_general.png',
        },
        {
          'titulo': 'Organización de la IDEP',
          'descripcion': (
            'Describe la estructura de coordinación, roles y espacios de '
            'gobernanza que alinean a las entidades participantes.'
          ),
          'imagen': 'imagenes/detalles.png',
        },
        {
          'titulo': 'Proceso de implementación IDE',
          'descripcion': (
            'Etapas sugeridas para planificar, ejecutar y monitorear un nodo '
            'que aporte al ecosistema nacional.'
          ),
          'imagen': 'imagenes/banner_idep.png',
        },
      ],
    },
    {
      'id': 'estandares',
      'titulo': 'Estándares',
      'descripcion': (
        'Lineamientos técnicos que aseguran interoperabilidad, calidad y '
        'aprovechamiento de los servicios y datos geoespaciales.'
      ),
      'subsecciones': [
        {
          'titulo': '¿Qué son los estándares geográficos?',
          'descripcion': (
            'Principios y normas que permiten compartir información espacial '
            'de manera uniforme entre plataformas y organizaciones.'
          ),
          'imagen': 'imagenes/detalles.png',
        },
        {
          'titulo': 'Estándares sobre los servicios geográficos',
          'descripcion': (
            'Buenas prácticas como OGC WMS, WFS y WMTS que definen cómo '
            'exponer y consumir servicios desde distintos clientes.'
          ),
          'imagen': 'imagenes/image_general.png',
        },
        {
          'titulo': 'Metadatos geográficos',
          'descripcion': (
            'Documentación estructurada que describe datasets, servicios y '
            'recursos para facilitar su hallazgo y evaluación.'
          ),
          'imagen': 'imagenes/documentos.svg',
        },
        {
          'titulo': 'Servicios geográficos',
          'descripcion': (
            'Capacidades en línea para visualizar, consultar o descargar capas '
            'y modelos espaciales actualizados.'
          ),
          'imagen': 'imagenes/enlace.png',
        },
        {
          'titulo': 'Manuales de despliegue de servicios',
          'descripcion': (
            'Guías prácticas para configurar servidores, asegurar la calidad '
            'de los servicios y monitorear su desempeño.'
          ),
          'imagen': 'imagenes/informes.svg',
        },
      ],
    },
    {
      'id': 'normatividad',
      'titulo': 'Normatividad',
      'descripcion': (
        'Marco legal y normativo que respalda la publicación, intercambio y '
        'uso responsable de la información geoespacial.'
      ),
      'subsecciones': [
        {
          'titulo': 'Normas vigentes',
          'descripcion': (
            'Decretos, resoluciones y lineamientos que sustentan la '
            'implementación y operación de la IDEP en el sector público.'
          ),
          'imagen': 'imagenes/documentos.svg',
        },
        {
          'titulo': 'Normas Técnicas Peruanas',
          'descripcion': (
            'Estándares nacionales que alinean terminología, formatos y '
            'procedimientos para asegurar la calidad de la información.'
          ),
          'imagen': 'imagenes/informes.svg',
        },
      ],
    },
  ]

  return render_template('geoportal/que_es_la_idep.html', secciones=secciones)
