from flask import Blueprint, render_template, jsonify, request
from models.capas_geograficas import CapaGeografica, ServicioGeografico
from models.categorias import Categoria
from models.tipos_servicios import TipoServicio
from app import db

bp = Blueprint('capas_geograficas', __name__, url_prefix='/capas_geograficas')

@bp.route('/')
def inicio():
    categorias = Categoria.query.order_by(Categoria.codigo).all()
    tipos_serv  = (
        TipoServicio.query.order_by(
            TipoServicio.orden.asc(), TipoServicio.nombre.asc()
        ).all()
    )
    capas        = CapaGeografica.query.options(
                      db.joinedload(CapaGeografica.servicios)
                        .joinedload(ServicioGeografico.tipo_servicio)
                   ).all()
    return render_template('gestion/capas_geograficas.html',
                           categorias=categorias,
                           tipos_serv=tipos_serv,
                           capas=capas)

@bp.route('/listar')
def listar():
    data = []
    for c in CapaGeografica.query.all():
        servicios = ', '.join(s.tipo_servicio.nombre for s in c.servicios)
        data.append({ 'id': c.id, 'nombre': c.nombre,
                      'en_geoperu': c.publicar_geoperu,
                      'servicios': servicios })
    return jsonify(data)

@bp.route('/guardar', methods=['POST'])
def guardar():
    data = request.get_json(force=True)
    capa = CapaGeografica(
        nombre           = data['nombre'],
        descripcion      = data.get('descripcion', ''),
        tipo_capa        = (data.get('tipo_capa') == 'publico'),
        publicar_geoperu = bool(data.get('publicar_geoperu', False)),
        id_categoria     = data.get('categoria_id')
    )

    for s in data.get('servicios', []):
        tipo = TipoServicio.query.filter_by(nombre=s['tipo']).first()
        if not tipo:
            tipo = TipoServicio(nombre=s['tipo'])
            db.session.add(tipo)
            db.session.flush()   # para obtener tipo.id

        servicio = ServicioGeografico(
            id_tipo_servicio = tipo.id,
            direccion_web    = s['url'],
            nombre_layer     = s.get('layer'),
            visible          = bool(s.get('visible', True))
        )
        capa.servicios.append(servicio)

    db.session.add(capa)
    db.session.commit()

    return jsonify({
        'status': 'success',
        'capa_id': capa.id
    }), 201

