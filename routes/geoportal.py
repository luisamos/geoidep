from collections import OrderedDict
from types import SimpleNamespace
import re
import unicodedata

from flask import Blueprint, render_template, request, abort
from sqlalchemy.orm import joinedload
from sqlalchemy import func, or_, and_
from markupsafe import escape

from models.herramientas_digitales import HerramientaDigital
from models.categorias import Categoria
from models.instituciones import Institucion
from models.tipos_servicios import TipoServicio
from models.capas_geograficas import CapaGeografica, ServicioGeografico

bp = Blueprint('geoportal', __name__)

CATALOGO_CAPA_TIPO_IDS = (11, 12, 14, 17, 20)

EXCLUDED_PARENT_IDS = tuple(range(10))

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
  return render_template('geoportal/catalogo.html', tipos_servicios=tipos_catalogo.lista)

@bp.route('/catalogo/<slug>')
def catalogo_por_tipo(slug):
  slug_normalizado = slug.lower()
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  tipo_config = tipos_catalogo.por_slug.get(slug_normalizado)
  if not tipo_config:
    abort(404)

  tipo_nombre = tipo_config['nombre']
  descripcion_config = tipo_config.get('descripcion')
  tipo_titulo = descripcion_config or tipo_nombre
  tipo_descripcion = descripcion_config

  id_institucion = request.args.get('id_institucion', type=int)
  filter_terms = request.args.get('filter_terms', default='', type=str).strip()
  if filter_terms:
    filter_terms = re.sub(r'[<>"\'`]', '', filter_terms)

  id_tipo = tipo_config['id']

  es_tipo_capa = id_tipo in CATALOGO_CAPA_TIPO_IDS

  categorias = OrderedDict()
  instituciones = OrderedDict()

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
        instituciones.setdefault(
          institucion.id,
          {
            'id': institucion.id,
            'nombre': sanitize_text(institucion.nombre),
          },
        )
        institucion_info = SimpleNamespace(
          nombre=sanitize_text(institucion.nombre)
        )

      servicios_data = []
      for servicio in sorted(
        servicios_relacionados,
        key=lambda item: (
          (item.titulo_capa or item.nombre_capa or '').lower(),
        ),
      ):
        etiqueta = servicio.titulo_capa or servicio.nombre_capa or capa.nombre
        servicios_data.append(
          SimpleNamespace(
            etiqueta=sanitize_text(etiqueta),
            nombre=sanitize_text(servicio.nombre_capa),
            titulo=sanitize_text(servicio.titulo_capa),
            url=servicio.direccion_web,
          )
        )

      categoria_data['herramientas'].append(
        SimpleNamespace(
          nombre=sanitize_text(capa.nombre),
          descripcion=sanitize_text(capa.descripcion),
          recurso=None,
          institucion=institucion_info,
          servicios=servicios_data,
        )
      )

    instituciones_disponibles = (
      Institucion.query.join(Institucion.capas)
      .join(CapaGeografica.servicios)
      .filter(
        ServicioGeografico.id_tipo_servicio == id_tipo,
        ~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS),
      )
      .with_entities(Institucion.id, Institucion.nombre)
      .order_by(Institucion.id.asc())
      .distinct()
      .all()
    )
  else:
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
    tipos_servicios=tipos_catalogo.lista,
    tipo_nombre=tipo_nombre,
    tipo_titulo=tipo_titulo,
    tipo_descripcion=tipo_descripcion,
    categorias=categorias_list,
    instituciones=instituciones_catalogo,
    id_institucion=id_institucion,
    filter_terms=filter_terms,
    total_herramientas=total_herramientas,
  )
