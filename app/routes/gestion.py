import asyncio
import logging

from flask import (
    Blueprint,
    flash,
    jsonify,
    redirect,
    render_template,
    request,
    url_for,
)
from flask_jwt_extended import (
    create_access_token,
    jwt_required,
    set_access_cookies,
    unset_jwt_cookies,
)

from sqlalchemy import and_, func, or_
from sqlalchemy.orm import joinedload

from app.extensions import db

from app.forms.autenticacion import LoginForm
from app.models import (
    CapaGeografica,
    HerramientaGeografica,
    Institucion,
    LogMonitoreo,
    ServicioGeografico,
    Tipo,
)
from app.models.usuarios import Usuario
from app.routes.helpers import obtener_usuario_actual
from app.services.monitoreo import RequestConfig, ejecutar_monitoreo

NIVELES_GOBIERNO = {
    1: 'Poder Ejecutivo',
    2: 'Poder Legislativo',
    3: 'Poder Judicial',
    4: 'Organismos Autónomos',
    5: 'Gobiernos Regionales',
    6: 'Gobiernos Locales',
    7: 'Organismos No Gubernamentales',
    8: 'Organismos Internacionales',
    9: 'Instituciones Privadas',
}

NODOS = [
    {
        'clave': 'institucionales',
        'nombre': 'Nodos institucionales',
        'ids_padre': [1, 2, 3, 4],
    },
    {
        'clave': 'regionales_locales',
        'nombre': 'Nodos regionales y locales',
        'ids_padre': [5, 6],
    },
    {
        'clave': 'no_gubernamentales',
        'nombre': 'Nodos no gubernamentales',
        'ids_padre': [7, 8, 9],
    },
]

bp = Blueprint('gestion', __name__)


def redirect_to_login():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta


# ---------------------------------------------------------------------------
# Helpers reutilizables
# ---------------------------------------------------------------------------

def ids_institucion_usuario(usuario):
  return [usuario.id_institucion]

def obtener_ids_servicios_por_institucion(ids_institucion):
  if not ids_institucion:
    return []
  filas = (
      db.session.query(ServicioGeografico.id)
      .join(CapaGeografica, ServicioGeografico.id_capa_geografica == CapaGeografica.id)
      .filter(CapaGeografica.id_institucion.in_(ids_institucion))
      .all()
  )
  return [fila[0] for fila in filas]

def ids_instituciones_por_nodo(nodo_ids_padre):
  return [
      inst.id for inst in
      Institucion.query.filter(Institucion.id_padre.in_(nodo_ids_padre)).all()
  ]

def ultima_verificacion():
  return db.session.query(
      func.max(LogMonitoreo.fecha_verificacion)
  ).scalar()

def build_estado_nodos_herramientas(es_vista_global, ids_inst_usuario):
  nodos_estado = []
  for nodo in NODOS:
    ids_inst_nodo = ids_instituciones_por_nodo(nodo['ids_padre'])
    if not es_vista_global:
      ids_inst_nodo = [i for i in ids_inst_nodo if i in ids_inst_usuario]

    if ids_inst_nodo:
      q_nodo = HerramientaGeografica.query.filter(HerramientaGeografica.id_institucion.in_(ids_inst_nodo))
      total = q_nodo.count()
      operativos = q_nodo.filter(HerramientaGeografica.estado == True).count()
    else:
      total = operativos = 0

    nodos_estado.append({
        'clave': nodo['clave'],
        'nombre': nodo['nombre'],
        'total': total,
        'operativos': operativos,
        'inoperativos': total - operativos,
        'detalle_url': url_for('gestion.detalle_monitoreo_estado', categoria='nodo', recurso='herramienta', nodo=nodo['clave']),
    })
  return nodos_estado

def build_estado_nodos_servicios(es_vista_global, ids_inst_usuario):
  nodos_estado = []
  for nodo in NODOS:
    ids_inst_nodo = ids_instituciones_por_nodo(nodo['ids_padre'])
    if not es_vista_global:
      ids_inst_nodo = [i for i in ids_inst_nodo if i in ids_inst_usuario]

    if ids_inst_nodo:
      ids_sg_nodo = obtener_ids_servicios_por_institucion(ids_inst_nodo)
      if ids_sg_nodo:
        q_nodo = ServicioGeografico.query.filter(ServicioGeografico.id.in_(ids_sg_nodo))
        total = q_nodo.count()
        operativos = q_nodo.filter(ServicioGeografico.estado == True).count()
      else:
        total = operativos = 0
    else:
      total = operativos = 0

    nodos_estado.append({
        'clave': nodo['clave'],
        'nombre': nodo['nombre'],
        'total': total,
        'operativos': operativos,
        'inoperativos': total - operativos,
        'detalle_url': url_for('gestion.detalle_monitoreo_estado', categoria='nodo', recurso='servicio', nodo=nodo['clave']),
    })
  return nodos_estado

def mapa_nodos_permitidos(es_vista_global, ids_inst_usuario):
  permitidos = {}
  for nodo in NODOS:
    ids_inst_nodo = ids_instituciones_por_nodo(nodo['ids_padre'])
    if not es_vista_global:
      ids_inst_nodo = [i for i in ids_inst_nodo if i in ids_inst_usuario]
    permitidos[nodo['clave']] = {
        'nombre': nodo['nombre'],
        'ids_institucion': ids_inst_nodo,
    }
  return permitidos

# ---------------------------------------------------------------------------
# Login / Logout
# ---------------------------------------------------------------------------

@bp.route('/gestion', methods=['GET', 'POST'])
def ingreso():
  usuario_actual = obtener_usuario_actual()
  if usuario_actual:
    return redirect(url_for('gestion.principal'))

  form = LoginForm()
  if form.validate_on_submit():
    email = form.email.data.strip().lower()
    usuario = Usuario.query.filter(
        func.lower(Usuario.correo_electronico) == email
    ).first()
    if not usuario or not usuario.check_password(form.password.data):
      flash('Correo o contraseña inválidos', 'error')
    elif not usuario.estado:
      flash('La cuenta se encuentra deshabilitada. Contacta al administrador.', 'error')
    elif not usuario.idep or not usuario.tiene_acceso_gestion:
      flash('Tu usuario no cuenta con acceso a la geoIDEP.', 'error')
    else:
      access_token = create_access_token(
        identity=str(usuario.id),
        additional_claims={
          'id_rol': usuario.id_perfil,
          'id_institucion': usuario.id_institucion,
        },
      )
      respuesta = redirect(url_for('gestion.principal'))
      set_access_cookies(respuesta, access_token)
      return respuesta
  elif form.is_submitted():
    for errores in form.errors.values():
      for mensaje in errores:
        flash(mensaje, 'error')
  return render_template('gestion/ingreso.html', form=form)


@bp.route('/salir', endpoint='logout')
@jwt_required(optional=True)
def salir():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta


# ---------------------------------------------------------------------------
# Panel general (resumen)
# ---------------------------------------------------------------------------

@bp.route('/principal')
@jwt_required()
def principal():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return redirect_to_login()

  es_vista_global = usuario.puede_gestionar_multiples_instituciones

  if es_vista_global:
    sg_total = ServicioGeografico.query.count()
    sg_activos = ServicioGeografico.query.filter(ServicioGeografico.estado == True).count()
    hd_total = HerramientaGeografica.query.count()
    hd_activos = HerramientaGeografica.query.filter(HerramientaGeografica.estado == True).count()
  else:
    ids_inst = ids_institucion_usuario(usuario)
    ids_sg = obtener_ids_servicios_por_institucion(ids_inst)
    if ids_sg:
      sg_total = ServicioGeografico.query.filter(ServicioGeografico.id.in_(ids_sg)).count()
      sg_activos = ServicioGeografico.query.filter(ServicioGeografico.id.in_(ids_sg), ServicioGeografico.estado == True).count()
    else:
      sg_total = sg_activos = 0
    hd_total = HerramientaGeografica.query.filter(HerramientaGeografica.id_institucion.in_(ids_inst)).count()
    hd_activos = HerramientaGeografica.query.filter(HerramientaGeografica.id_institucion.in_(ids_inst), HerramientaGeografica.estado == True).count()

  ultima_verif = ultima_verificacion()

  return render_template(
      'gestion/principal.html',
      usuario_actual=usuario,
      seccion_activa='',
      es_vista_global=es_vista_global,
      sg_total=sg_total,
      sg_activos=sg_activos,
      sg_inactivos=sg_total - sg_activos,
      hd_total=hd_total,
      hd_activos=hd_activos,
      hd_inactivos=hd_total - hd_activos,
      ultima_verificacion=ultima_verif,
  )


# ---------------------------------------------------------------------------
# Monitoreo: Herramientas geográficas
# ---------------------------------------------------------------------------

def _datos_monitoreo_herramientas(usuario):
  es_vista_global = usuario.puede_gestionar_multiples_instituciones
  ids_inst_usuario = ids_institucion_usuario(usuario)

  if es_vista_global:
    hd_query = HerramientaGeografica.query
  else:
    hd_query = HerramientaGeografica.query.filter(HerramientaGeografica.id_institucion.in_(ids_inst_usuario))

  hd_total = hd_query.count()
  hd_activos = hd_query.filter(HerramientaGeografica.estado == True).count()
  hd_inactivos = hd_total - hd_activos

  tipos_hd = Tipo.query.filter(Tipo.id_padre == 1).order_by(Tipo.orden).all()
  stats_por_tipo = []

  for tipo in tipos_hd:
    q = hd_query.filter(HerramientaGeografica.id_tipo == tipo.id)
    total = q.count()
    activos = q.filter(HerramientaGeografica.estado == True).count()
    logotipo = (tipo.logotipo or '').strip() or 'apps'
    if total > 0:
      stats_por_tipo.append({
          'id_tipo': tipo.id,
          'nombre': tipo.nombre,
          'sigla': tipo.sigla or '',
          'logotipo': logotipo,
          'total': total,
          'activos': activos,
          'inactivos': total - activos,
          'detalle_url': url_for('gestion.detalle_monitoreo_estado', categoria='tipo', recurso='herramienta', id_tipo=tipo.id),
      })

  problemas_query = LogMonitoreo.query.filter(
      LogMonitoreo.tipo_recurso == 'herramienta_geografica',
      LogMonitoreo.estado_nuevo == False,
  )
  if not es_vista_global:
    ids_hd = [
        r[0] for r in HerramientaGeografica.query
        .filter(HerramientaGeografica.id_institucion.in_(ids_inst_usuario))
        .with_entities(HerramientaGeografica.id).all()
    ]
    problemas_query = problemas_query.filter(LogMonitoreo.id_recurso.in_(ids_hd)) if ids_hd else problemas_query.filter(False)
  problemas = problemas_query.order_by(LogMonitoreo.fecha_verificacion.desc()).limit(200).all()

  return {
      'es_vista_global': es_vista_global,
      'hd_total': hd_total,
      'hd_activos': hd_activos,
      'hd_inactivos': hd_inactivos,
      'stats_por_tipo': stats_por_tipo,
      'problemas': problemas,
      'ultima_verificacion': ultima_verificacion(),
      'nodos_estado': build_estado_nodos_herramientas(es_vista_global, ids_inst_usuario),
  }


@bp.route('/principal/herramientas-digitales')
@jwt_required()
def monitoreo_herramientas():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return redirect_to_login()

  datos = _datos_monitoreo_herramientas(usuario)

  return render_template(
      'gestion/monitoreo_herramientas.html',
      usuario_actual=usuario,
      seccion_activa='rol10',
      **datos,
  )


# ---------------------------------------------------------------------------
# Monitoreo: Servicios geograficos
# ---------------------------------------------------------------------------

def _datos_monitoreo_servicios(usuario):
  es_vista_global = usuario.puede_gestionar_multiples_instituciones
  ids_inst_usuario = ids_institucion_usuario(usuario)

  if es_vista_global:
    sg_query = ServicioGeografico.query
  else:
    ids_sg = obtener_ids_servicios_por_institucion(ids_inst_usuario)
    sg_query = ServicioGeografico.query.filter(ServicioGeografico.id.in_(ids_sg)) if ids_sg else ServicioGeografico.query.filter(False)

  sg_total = sg_query.count()
  sg_activos = sg_query.filter(ServicioGeografico.estado == True).count()
  sg_inactivos = sg_total - sg_activos

  tipos_sg = Tipo.query.filter(
      Tipo.id_padre.in_([2, 3]),
      Tipo.estado == True,
  ).order_by(Tipo.orden).all()
  stats_por_tipo = []
  for tipo in tipos_sg:
    q = sg_query.filter(ServicioGeografico.id_tipo == tipo.id)
    total = q.count()
    activos = q.filter(ServicioGeografico.estado == True).count()
    if total > 0:
      stats_por_tipo.append({
          'id_tipo': tipo.id,
          'nombre': tipo.nombre,
          'sigla': tipo.sigla or '',
          'logotipo': tipo.logotipo or 'layers',
          'total': total,
          'activos': activos,
          'inactivos': total - activos,
          'detalle_url': url_for('gestion.detalle_monitoreo_estado', categoria='tipo', recurso='servicio', id_tipo=tipo.id),
      })

  problemas_query = LogMonitoreo.query.filter(
      LogMonitoreo.tipo_recurso == 'servicio_geografico',
      LogMonitoreo.estado_nuevo == False,
  )
  if not es_vista_global:
    ids_sg = obtener_ids_servicios_por_institucion(ids_inst_usuario)
    problemas_query = problemas_query.filter(LogMonitoreo.id_recurso.in_(ids_sg)) if ids_sg else problemas_query.filter(False)
  problemas = problemas_query.order_by(LogMonitoreo.fecha_verificacion.desc()).limit(200).all()

  return {
      'es_vista_global': es_vista_global,
      'sg_total': sg_total,
      'sg_activos': sg_activos,
      'sg_inactivos': sg_inactivos,
      'stats_por_tipo': stats_por_tipo,
      'problemas': problemas,
      'ultima_verificacion': ultima_verificacion(),
      'nodos_estado': build_estado_nodos_servicios(es_vista_global, ids_inst_usuario),
  }


@bp.route('/principal/servicios-geograficos')
@jwt_required()
def monitoreo_servicios():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return redirect_to_login()

  datos = _datos_monitoreo_servicios(usuario)

  return render_template(
      'gestion/monitoreo_servicios.html',
      usuario_actual=usuario,
      seccion_activa='rol11',
      **datos,
  )


# ---------------------------------------------------------------------------
# Detalle de estado
# ---------------------------------------------------------------------------

@bp.route('/principal/monitoreo/detalle')
@jwt_required()
def detalle_monitoreo_estado():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return redirect_to_login()

  es_vista_global = usuario.puede_gestionar_multiples_instituciones
  ids_inst_usuario = ids_institucion_usuario(usuario)

  categoria = request.args.get('categoria', 'tipo')
  recurso = request.args.get('recurso', 'herramienta')
  id_tipo = request.args.get('id_tipo', type=int)
  nodo = request.args.get('nodo')

  filas = []
  if recurso == 'herramienta':
    consulta = HerramientaGeografica.query.options(
        joinedload(HerramientaGeografica.institucion),
        joinedload(HerramientaGeografica.tipo),
    )
    if not es_vista_global:
      consulta = consulta.filter(HerramientaGeografica.id_institucion.in_(ids_inst_usuario))
    if categoria == 'tipo' and id_tipo:
      consulta = consulta.filter(HerramientaGeografica.id_tipo == id_tipo)
    elif categoria == 'nodo' and nodo:
      ids_nodo = mapa_nodos_permitidos(es_vista_global, ids_inst_usuario).get(nodo, {}).get('ids_institucion', [])
      consulta = consulta.filter(HerramientaGeografica.id_institucion.in_(ids_nodo)) if ids_nodo else consulta.filter(False)

    # El detalle debe enfocarse en recursos inoperativos.
    consulta = consulta.filter(HerramientaGeografica.estado == False)

    items = consulta.order_by(HerramientaGeografica.id.desc()).all()
    for item in items:
      log = LogMonitoreo.query.filter_by(
          tipo_recurso='herramienta_geografica',
          id_recurso=item.id,
      ).order_by(LogMonitoreo.fecha_verificacion.desc()).first()
      filas.append({
          'id_recurso': item.id,
          'nombre': item.nombre,
          'institucion': (item.institucion.nombre if item.institucion else '-'),
          'sigla': (item.institucion.sigla if item.institucion else '-'),
          'problema_detectado': (log.mensaje_error if log and log.mensaje_error else ('Servicio no disponible' if not item.estado else '-')),
          'codigo_problema': (log.codigo_http if log and log.codigo_http is not None else '-'),
          'fecha_hora': (log.fecha_verificacion if log else None),
          'tipo': (item.tipo.sigla if item.tipo and item.tipo.sigla else (item.tipo.nombre if item.tipo else '-')),
          'editar_url': url_for('herramientas_geograficas.inicio'),
          'ejecutar_url': url_for('gestion.ejecutar_monitoreo_endpoint', tipo='herramientas_geograficas'),
      })
  else:
    consulta = ServicioGeografico.query.options(
        joinedload(ServicioGeografico.capa).joinedload(CapaGeografica.institucion),
        joinedload(ServicioGeografico.tipo),
    )
    if not es_vista_global:
      ids_sg = obtener_ids_servicios_por_institucion(ids_inst_usuario)
      consulta = consulta.filter(ServicioGeografico.id.in_(ids_sg)) if ids_sg else consulta.filter(False)
    if categoria == 'tipo' and id_tipo:
      consulta = consulta.filter(ServicioGeografico.id_tipo == id_tipo)
    elif categoria == 'nodo' and nodo:
      ids_nodo = mapa_nodos_permitidos(es_vista_global, ids_inst_usuario).get(nodo, {}).get('ids_institucion', [])
      ids_sg_nodo = obtener_ids_servicios_por_institucion(ids_nodo) if ids_nodo else []
      consulta = consulta.filter(ServicioGeografico.id.in_(ids_sg_nodo)) if ids_sg_nodo else consulta.filter(False)

    # Solo listar servicios geográficos inoperativos.
    consulta = consulta.filter(ServicioGeografico.estado == False)

    items = consulta.order_by(ServicioGeografico.id.desc()).all()
    for item in items:
      institucion = item.capa.institucion if item.capa else None
      log = LogMonitoreo.query.filter_by(
          tipo_recurso='servicio_geografico',
          id_recurso=item.id,
      ).order_by(LogMonitoreo.fecha_verificacion.desc()).first()
      filas.append({
          'id_recurso': item.id,
          'nombre': (item.titulo_capa or item.nombre_capa or (item.capa.nombre if item.capa else '-')),
          'institucion': (institucion.nombre if institucion else '-'),
          'sigla': (institucion.sigla if institucion else '-'),
          'problema_detectado': (log.mensaje_error if log and log.mensaje_error else ('Servicio no disponible' if not item.estado else '-')),
          'codigo_problema': (log.codigo_http if log and log.codigo_http is not None else '-'),
          'fecha_hora': (log.fecha_verificacion if log else None),
          'tipo': (item.tipo.sigla if item.tipo and item.tipo.sigla else (item.tipo.nombre if item.tipo else '-')),
          'editar_url': url_for('capas_geograficas.inicio'),
          'ejecutar_url': url_for('gestion.ejecutar_monitoreo_endpoint', tipo='servicios_geograficos'),
      })

  titulo_tipo = None
  if categoria == 'tipo' and id_tipo:
    tipo_obj = Tipo.query.get(id_tipo)
    if tipo_obj:
      titulo_tipo = tipo_obj.nombre

  seccion_activa = 'rol11' if recurso == 'servicio' else 'rol10'

  return render_template(
      'gestion/monitoreo_detalle_estado.html',
      usuario_actual=usuario,
      seccion_activa=seccion_activa,
      categoria=categoria,
      recurso=recurso,
      titulo_tipo=titulo_tipo,
      filas=filas,
  )


# ---------------------------------------------------------------------------
# Ejecutar monitoreo
# ---------------------------------------------------------------------------

@bp.route('/principal/monitoreo', methods=['POST'])
@jwt_required()
def ejecutar_monitoreo_endpoint():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({"message": "No autorizado"}), 401

  tipo = request.args.get('tipo', 'todos')
  if tipo not in ('todos', 'servicios_geograficos', 'herramientas_geograficas'):
    return jsonify({"message": "Tipo inválido. Use: todos, servicios_geograficos, herramientas_geograficas"}), 400

  try:
    payload = request.get_json(silent=True) or {}
    ids = payload.get('ids') if isinstance(payload.get('ids'), list) else None
    config = RequestConfig(timeout=30.0, delay=0.5)
    resultado = asyncio.run(ejecutar_monitoreo(config=config, tipo=tipo, ids=ids))

    return jsonify({
        "message": "Monitoreo completado",
        "servicios_geograficos": {
            "verificados": resultado.servicios_verificados,
            "activos": resultado.servicios_activos,
            "inactivos": resultado.servicios_inactivos,
        },
        "herramientas_geograficas": {
            "verificadas": resultado.herramientas_verificadas,
            "activas": resultado.herramientas_activas,
            "inactivas": resultado.herramientas_inactivas,
        },
        "total_errores": len(resultado.errores),
    }), 200
  except Exception as exc:
    logging.exception("Error al ejecutar el monitoreo de servicios")
    return jsonify({"message": f"Error durante el monitoreo: {str(exc)}"}), 500


@bp.route('/principal/monitoreo/total')
@jwt_required()
def total_recursos_monitoreo():
  """Retorna la cantidad total de recursos a verificar para calcular el progreso."""
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({"message": "No autorizado"}), 401

  tipo = request.args.get('tipo', 'todos')
  total = 0
  if tipo in ('todos', 'servicios_geograficos'):
    total += ServicioGeografico.query.count()
  if tipo in ('todos', 'herramientas_geograficas'):
    total += HerramientaGeografica.query.filter(HerramientaGeografica.recurso.isnot(None)).count()

  return jsonify({"total": total})