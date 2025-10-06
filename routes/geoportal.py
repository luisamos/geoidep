from collections import OrderedDict
import re
import unicodedata

from flask import Blueprint, render_template, request, abort
from sqlalchemy.orm import joinedload
from sqlalchemy import func, or_

from models.herramientas_digitales import HerramientaDigital
from models.categorias import Categoria
from models.niveles_gobierno import Institucion
from models.tipos_servicios import TipoServicio

bp = Blueprint('geoportal', __name__)

@bp.route('/')
def principal():
    return render_template('geoportal/inicio.html')

@bp.route('/idep')
def idep():
    return render_template('geoportal/idep.html')

CATALOGO_TIPO_IDS = (4, 5, 6, 7)

CATALOGO_SLUGS = {
    4: 'geoportales',
    5: 'visores',
    6: 'apps',
    7: 'descargas',
}

CATALOGO_SLUG_TO_ID = {slug: tipo_id for tipo_id, slug in CATALOGO_SLUGS.items()}


def _slugify(value):
    if not value:
        return ''
    normalized = unicodedata.normalize('NFKD', value)
    without_accents = ''.join(
        character for character in normalized if not unicodedata.combining(character)
    )
    slug = re.sub(r'[^a-z0-9]+', '-', without_accents.lower())
    return slug.strip('-')


def _obtener_tipos_servicio_catalogo():
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
                'nombre': tipo.nombre,
                'descripcion': tipo.descripcion,
                'logotipo': tipo.logotipo,
                'slug': CATALOGO_SLUGS.get(tipo.id, _slugify(tipo.nombre)),
            }
        )

    return tipos_catalogo


@bp.route('/catalogo')
def catalogo():
    tipos_servicio = _obtener_tipos_servicio_catalogo()
    return render_template('geoportal/catalogo.html', tipos_servicio=tipos_servicio)


@bp.route('/catalogos/<slug>')
def catalogo_por_tipo(slug):
    slug_normalizado = slug.lower()
    tipo_id = CATALOGO_SLUG_TO_ID.get(slug_normalizado)
    if not tipo_id:
        abort(404)

    tipos_servicio = _obtener_tipos_servicio_catalogo()
    tipo_config = next((tipo for tipo in tipos_servicio if tipo['id'] == tipo_id), None)
    if not tipo_config:
        abort(404)

    tipo_nombre = tipo_config['nombre']
    tipo_titulo = tipo_config.get('descripcion') or tipo_nombre
    tipo_descripcion = tipo_config.get('descripcion')

    institucion_id = request.args.get('institucion_id', type=int)
    filter_terms = request.args.get('filter_terms', default='', type=str).strip()

    if tipo_id not in CATALOGO_TIPO_IDS:
        abort(404)

    query = (
        HerramientaDigital.query.options(
            joinedload(HerramientaDigital.categoria),
            joinedload(HerramientaDigital.institucion),
        )
        .filter(HerramientaDigital.id_tipo_servicio == tipo_id)
        .join(HerramientaDigital.categoria)
    )

    if institucion_id:
        query = query.filter(HerramientaDigital.id_institucion == institucion_id)

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
                'nombre': categoria.nombre,
                'descripcion': categoria.definicion,
                'herramientas': [],
            },
        )
        categoria_data['herramientas'].append(herramienta)

        institucion = herramienta.institucion
        if institucion:
            instituciones.setdefault(
                institucion.id,
                {
                    'id': institucion.id,
                    'nombre': institucion.nombre,
                },
            )

    instituciones_disponibles = (
        Institucion.query.join(Institucion.herramientas)
        .filter(HerramientaDigital.id_tipo_servicio == tipo_id)
        .with_entities(Institucion.id, Institucion.nombre)
        .distinct()
        .order_by(Institucion.nombre.asc())
        .all()
    )

    instituciones_catalogo = [
        {'id': inst_id, 'nombre': nombre}
        for inst_id, nombre in instituciones_disponibles
    ]

    if not instituciones_catalogo and instituciones:
        instituciones_catalogo = list(instituciones.values())

    categorias_list = list(categorias.values())
    total_herramientas = sum(
        len(categoria_data['herramientas']) for categoria_data in categorias_list
    )

    return render_template(
        'geoportal/subcatalogo.html',
        slug=slug,
        tipos_servicio=tipos_servicio,
        tipo_nombre=tipo_nombre,
        tipo_titulo=tipo_titulo,
        tipo_descripcion=tipo_descripcion,
        categorias=categorias_list,
        instituciones=instituciones_catalogo,
        institucion_id=institucion_id,
        filter_terms=filter_terms,
        total_herramientas=total_herramientas,
    )
