from collections import OrderedDict

from flask import Blueprint, render_template, request, abort
from sqlalchemy.orm import joinedload
from sqlalchemy import func, or_

from models.herramientas_digitales import HerramientaDigital
from models.categorias import Categoria
from models.niveles_gobierno import Institucion

bp = Blueprint('geoportal', __name__)

@bp.route('/')
def principal():
    return render_template('geoportal/inicio.html')

@bp.route('/idep')
def idep():
    return render_template('geoportal/idep.html')

@bp.route('/catalogo')
def catalogo():
    return render_template('geoportal/catalogo.html')


TIPO_SERVICIO_SLUGS = {
    'geoportales': {
        'id': 2,
        'nombre': 'Geoportales',
        'titulo': 'Geoportales en entidades públicas',
        'descripcion': (
            'Geoportales administrados por entidades públicas del Estado peruano.'
        ),
    },
}


@bp.route('/catalogos/<slug>')
def catalogo_por_tipo(slug):
    tipo_config = TIPO_SERVICIO_SLUGS.get(slug.lower())
    if not tipo_config:
        abort(404)

    tipo_id = tipo_config['id']
    tipo_nombre = tipo_config['nombre']
    tipo_titulo = tipo_config.get('titulo', tipo_nombre)
    tipo_descripcion = tipo_config.get('descripcion')

    institucion_id = request.args.get('institucion_id', type=int)
    filter_terms = request.args.get('filter_terms', default='', type=str).strip()

    if tipo_id != 2:
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
        tipo_nombre=tipo_nombre,
        tipo_titulo=tipo_titulo,
        tipo_descripcion=tipo_descripcion,
        categorias=categorias_list,
        instituciones=instituciones_catalogo,
        institucion_id=institucion_id,
        filter_terms=filter_terms,
        total_herramientas=total_herramientas,
    )
