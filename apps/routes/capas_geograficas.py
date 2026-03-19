from __future__ import annotations

import requests
import urllib3
from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from owslib.wfs import WebFeatureService
from owslib.wms import WebMapService
from owslib.wmts import WebMapTileService
from urllib3.exceptions import InsecureRequestWarning
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse

from requests.exceptions import ProxyError, RequestException, SSLError
from sqlalchemy import func, nullslast, text
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from apps import db
from apps.models import CapaGeografica, ServicioGeografico
from apps.models import Categoria
from apps.models import Institucion
from apps.models import TipoServicio
from .helpers import obtener_usuario_actual

bp = Blueprint('capas_geograficas', __name__, url_prefix='/capas_geograficas')

INSECURE_CERT_HOSTS = {'maps.inei.gob.pe'}
HEADERS_LEGALES = {
  'User-Agent': 'GeoIDEP/1.0 (+https://geoidep.gob.pe)',
  'Accept': '*/*',
  'Referer': 'https://geoidep.gob.pe',
}

def sincronizar_secuencia(modelo):
  tabla = modelo.__table__
  pk_columna = next(iter(tabla.primary_key.columns))
  atributo_pk = getattr(modelo, pk_columna.name)
  max_id = db.session.query(func.coalesce(func.max(atributo_pk), 0)).scalar()
  nombre_secuencia = f"{tabla.name}_{pk_columna.name}_seq"
  if tabla.schema:
    nombre_secuencia = f"{tabla.schema}.{nombre_secuencia}"
  valor = max_id if max_id else 1
  db.session.execute(
    text("SELECT setval(to_regclass(:secuencia), :valor, :llamado)"),
    {
      'secuencia': nombre_secuencia,
      'valor': valor,
      'llamado': bool(max_id),
    },
  )

def obtener_instituciones_para(usuario):
  consulta = Institucion.query.filter(Institucion.id >= 45)
  if usuario and usuario.es_gestor:
    consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  return consulta.order_by(Institucion.id.asc()).all()

def es_servicio_wms(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id == 11:
    return True
  nombre = (tipo_servicio.nombre or '').lower()
  return 'wms' in nombre

def es_servicio_wfs(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id == 12:
    return True
  nombre = (tipo_servicio.nombre or '').lower()
  return 'wfs' in nombre

def es_servicio_wmts(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id == 14:
    return True
  nombre = (tipo_servicio.nombre or '').lower()
  return 'wmts' in nombre

def formatear_etiqueta_capa(nombre, titulo):
  titulo_final = titulo or nombre
  if titulo_final and titulo_final != nombre:
    return f"{titulo_final} ({nombre})"
  return titulo_final

def construir_capas_desde_contenidos(contenidos):
  capas = []
  for nombre, capa in contenidos.items():
    if not nombre:
      continue
    titulo = getattr(capa, 'title', None) or nombre
    etiqueta = formatear_etiqueta_capa(nombre, titulo)
    capas.append({'value': nombre, 'label': etiqueta})
  return capas

def validar_estado_servicio(url):
  try:
    respuesta = realizar_request_get(url)
  except RequestException as error:
    raise ValueError('No se pudo conectar con el servicio especificado.') from error
  if respuesta.status_code != 200:
    detalle = respuesta.reason or 'Error en el servicio'
    raise ValueError(
      f"El servicio respondió con estado {respuesta.status_code}: {detalle}."
    )
  return respuesta

def preparar_url_capabilities(tipo_servicio, url):
  if not url:
    return url

  parametros = None
  if es_servicio_wms(tipo_servicio):
    parametros = {'request': 'GetCapabilities', 'service': 'WMS'}
  elif es_servicio_wfs(tipo_servicio):
    parametros = {'request': 'GetCapabilities', 'service': 'WFS'}
  elif es_servicio_wmts(tipo_servicio):
    parametros = {'request': 'GetCapabilities', 'service': 'WMTS'}

  if not parametros:
    return url

  parsed = urlparse(url)
  query_pairs = parse_qsl(parsed.query, keep_blank_values=True)
  claves_parametros = {clave.lower() for clave in parametros}
  filtrados = [
    (clave, valor)
    for clave, valor in query_pairs
    if clave.lower() not in claves_parametros
  ]
  for clave, valor in parametros.items():
    filtrados.append((clave, valor))

  nueva_query = urlencode(filtrados, doseq=True)
  parsed = parsed._replace(query=nueva_query)
  return urlunparse(parsed)

def es_servicio_arcgis_mapserver(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id == 17:
    return True
  if tipo_servicio.id_padre != 3:
    return False
  nombre = (tipo_servicio.nombre or '').lower()
  return 'arcgis' in nombre and 'mapserver' in nombre

def realizar_request_get(url, timeout=15, headers=None):
  headers_final = HEADERS_LEGALES.copy()
  if headers:
    headers_final.update(headers)
  parsed_url = urlparse(url)
  allow_insecure = parsed_url.hostname in INSECURE_CERT_HOSTS
  try:
    return requests.get(url, timeout=timeout, headers=headers_final)
  except ProxyError:
    return requests.get(
      url,
      timeout=timeout,
      headers=headers_final,
      proxies={'http': None, 'https': None},
    )
  except SSLError:
    if not allow_insecure:
      raise
    try:
      urllib3.disable_warnings(InsecureRequestWarning)
      return requests.get(
        url,
        timeout=timeout,
        headers=headers_final,
        verify=False,
      )
    except ProxyError:
      urllib3.disable_warnings(InsecureRequestWarning)
      return requests.get(
        url,
        timeout=timeout,
        headers=headers_final,
        proxies={'http': None, 'https': None},
        verify=False,
      )

def asegurar_parametro(url, clave, valor):
  if not url:
    return url

  parsed = urlparse(url)
  query_pairs = parse_qsl(parsed.query, keep_blank_values=True)
  clave_lower = clave.lower()
  filtrados = [(k, v) for k, v in query_pairs if k.lower() != clave_lower]
  filtrados.append((clave, valor))
  nueva_query = urlencode(filtrados, doseq=True)
  return urlunparse(parsed._replace(query=nueva_query))

def obtener_capas_desde_mapserver(url):
  url_json = asegurar_parametro(url, 'f', 'pjson')
  respuesta = validar_estado_servicio(url_json)

  try:
    data = respuesta.json()
  except ValueError as error:
    raise ValueError('La respuesta del servicio no es un JSON válido.') from error

  capas = []
  for layer in data.get('layers', []):
    layer_id = layer.get('id')
    nombre = layer.get('name')
    if layer_id is None or not nombre:
      continue
    capas.append({'value': str(layer_id), 'label': nombre})

  if not capas:
    raise ValueError('No se encontraron capas disponibles en el servicio.')

  return capas

def obtener_capas_desde_servicio(tipo_servicio, url):
  url_capabilities = preparar_url_capabilities(tipo_servicio, url)
  validar_estado_servicio(url_capabilities)

  try:
    if es_servicio_wms(tipo_servicio):
      servicio = WebMapService(url_capabilities, headers=HEADERS_LEGALES)
      capas = construir_capas_desde_contenidos(servicio.contents)
    elif es_servicio_wfs(tipo_servicio):
      servicio = WebFeatureService(url_capabilities, headers=HEADERS_LEGALES)
      capas = construir_capas_desde_contenidos(servicio.contents)
    elif es_servicio_wmts(tipo_servicio):
      servicio = WebMapTileService(url_capabilities, headers=HEADERS_LEGALES)
      capas = construir_capas_desde_contenidos(servicio.contents)
    else:
      raise ValueError('El tipo de servicio OGC seleccionado no está soportado.')
  except Exception as error:
    codigo_error = None
    respuesta_error = getattr(error, 'response', None)
    if respuesta_error is not None:
      codigo_error = getattr(respuesta_error, 'status_code', None)
    if codigo_error:
      mensaje_error = (
        f"No se pudo leer las capacidades del servicio (HTTP {codigo_error})."
      )
    else:
      mensaje_error = 'No se pudo leer las capacidades del servicio.'
    raise ValueError(mensaje_error) from error

  if not capas:
    raise ValueError('No se encontraron capas disponibles en el servicio.')

  return capas

@bp.route('/')
@jwt_required()
def inicio():
  usuario = obtener_usuario_actual(requerido=True)
  categorias = (
    Categoria.query.filter_by(id_padre=1)
    .order_by(Categoria.id.asc())
    .all()
  )
  tipos_serv_query = (
    TipoServicio.query.filter(TipoServicio.estado.is_(True))
    .filter(TipoServicio.id_padre.in_((2, 3)))
    .order_by(TipoServicio.id.asc(), TipoServicio.nombre.asc())
    .all()
  )
  tipos_serv = [
    {
      'id': tipo.id,
      'nombre': tipo.nombre,
      'sigla' : tipo.sigla,
      'id_padre': tipo.id_padre,
      'estado': tipo.estado,
    }
    for tipo in tipos_serv_query
  ]
  instituciones = obtener_instituciones_para(usuario)
  instituciones_disponibles = [
    {
      'id': institucion.id,
      'nombre': institucion.nombre or '',
      'sigla': institucion.sigla or '',
    }
    for institucion in instituciones
  ]
  puede_editar_institucion = (
    usuario.puede_gestionar_multiples_instituciones if usuario else False
  )
  return render_template(
    'gestion/capas_geograficas.html',
    categorias=categorias,
    tipos_serv=tipos_serv,
    instituciones_disponibles=instituciones_disponibles,
    institucion_usuario=usuario.institucion if usuario else None,
    puede_editar_institucion=puede_editar_institucion,
    usuario_actual=usuario,
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
  ).outerjoin(
    Institucion,
    CapaGeografica.id_institucion == Institucion.id,
  ).order_by(
    nullslast(Institucion.nombre.asc()),
    CapaGeografica.nombre.asc(),
  )

  if usuario.es_gestor:
    consulta = consulta.filter(CapaGeografica.id_institucion == usuario.id_institucion)

  activos = []
  inactivos = []
  sin_estado = []

  for capa in consulta.all():
    servicios_detalle = []
    tiene_activos = False
    tiene_inactivos = False

    for servicio in capa.servicios:
      if not servicio.tipo_servicio:
        continue

      estado_servicio = None
      if servicio.estado is True:
        estado_servicio = True
        tiene_activos = True
      elif servicio.estado is False:
        estado_servicio = False
        tiene_inactivos = True

      servicios_detalle.append(
        {
          'id': servicio.tipo_servicio.id,
          'nombre': servicio.tipo_servicio.nombre,
          'sigla': servicio.tipo_servicio.sigla,
          'estado': estado_servicio,
        }
      )

    servicios_detalle.sort(key=lambda detalle: detalle.get('id') or 0)

    nombres_servicios = ', '.join(
      detalle.get('sigla') or detalle.get('nombre')
      for detalle in servicios_detalle
      if detalle.get('sigla') or detalle.get('nombre')
    )

    capa_data = {
      'id': capa.id,
      'nombre': capa.nombre,
      'descripcion': capa.descripcion,
      'tipo_capa': capa.tipo_capa,
      'en_geoperu': capa.publicar_geoperu,
      'servicios': nombres_servicios,
      'servicios_detalle': servicios_detalle,
      'categoria': capa.categoria.nombre if capa.categoria else None,
      'id_categoria': capa.id_categoria,
      'institucion_sigla': (
        capa.institucion.sigla or '' if capa.institucion else ''
      ),
      'institucion_nombre': (
        capa.institucion.nombre if capa.institucion else None
      ),
      'id_institucion': capa.id_institucion,
      'ids_servicio': [detalle['id'] for detalle in servicios_detalle],
    }

    if tiene_activos and not tiene_inactivos:
      activos.append(capa_data)
    elif tiene_inactivos and not tiene_activos:
      inactivos.append(capa_data)
    else:
      sin_estado.append(capa_data)

  return jsonify({'activos': activos, 'inactivos': inactivos, 'sin_estado': sin_estado})


@bp.route('/detalle/<int:id_capa>')
@jwt_required()
def detalle(id_capa):
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({'status': 'error', 'message': 'Sesión no válida.'}), 401

  capa = (
    CapaGeografica.query.options(
      joinedload(CapaGeografica.categoria),
      joinedload(CapaGeografica.institucion),
      joinedload(CapaGeografica.servicios).joinedload(
        ServicioGeografico.tipo_servicio
      ),
    )
    .filter(CapaGeografica.id == id_capa)
    .first()
  )

  if not capa:
    return jsonify({'status': 'error', 'message': 'La capa indicada no existe.'}), 404

  if usuario.es_gestor and capa.id_institucion != usuario.id_institucion:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No puedes acceder a capas de otra institución.',
        }
      ),
      403,
    )

  servicios = [
    {
      'id': servicio.id,
      'id_tipo_servicio': servicio.id_tipo_servicio,
      'direccion_web': servicio.direccion_web,
      'nombre_capa': servicio.nombre_capa,
      'titulo_capa': servicio.titulo_capa,
      'id_layer': servicio.id_layer,
      'estado': servicio.estado,
      'tipo_servicio_nombre': servicio.tipo_servicio.nombre
      if servicio.tipo_servicio
      else None,
    }
    for servicio in capa.servicios
  ]

  servicio_wms = next(
    (servicio for servicio in capa.servicios if servicio.id_tipo_servicio == 11),
    None,
  )

  return jsonify(
    {
      'id': capa.id,
      'nombre': capa.nombre,
      'descripcion': capa.descripcion,
      'tipo_capa': capa.tipo_capa,
      'en_geoperu': capa.publicar_geoperu,
      'id_layer_geoperu': servicio_wms.id_layer if servicio_wms else 0,
      'id_categoria': capa.id_categoria,
      'id_institucion': capa.id_institucion,
      'servicios': servicios,
    }
  )


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
  id_capa = data.get('id')

  try:
    id_categoria = int(data.get('id_categoria')) if data.get('id_categoria') else None
  except (TypeError, ValueError):
    id_categoria = None

  try:
    institucion_payload = int(data.get('id_institucion')) if data.get('id_institucion') else None
  except (TypeError, ValueError):
    institucion_payload = None

  if usuario.es_gestor:
    id_institucion = usuario.id_institucion
    if institucion_payload and institucion_payload != id_institucion:
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
    id_institucion = institucion_payload or usuario.id_institucion

  if not id_institucion:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'Debe seleccionar una institución válida.',
        }
      ),
      400,
    )

  if not id_categoria:
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
  id_layer_geoperu = data.get('id_layer_geoperu')

  if id_layer_geoperu in ('', None):
    id_layer_geoperu = None
  else:
    try:
      id_layer_geoperu = int(id_layer_geoperu)
    except (TypeError, ValueError):
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'El ID Layer de GeoPerú debe contener solo números.',
          }
        ),
        400,
      )
    if id_layer_geoperu < 0:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'El ID Layer de GeoPerú no puede ser negativo.',
          }
        ),
        400,
      )

  servicios_validos = []
  tipos_requeridos = set()
  for servicio in servicios_payload:
    if not isinstance(servicio, dict):
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'La estructura de un servicio no es válida.',
          }
        ),
        400,
      )

    id_servicio = servicio.get('id')
    id_tipo_servicio = servicio.get('id_tipo_servicio')
    direccion = (servicio.get('direccion') or '').strip()
    nombre_capa_servicio = (servicio.get('nombre_capa') or '').strip()
    titulo_capa_servicio = (servicio.get('titulo_capa') or '').strip()
    id_layer = servicio.get('id_layer')
    visible = bool(servicio.get('visible', True))
    estado_valor = servicio.get('estado', False)
    if isinstance(estado_valor, str):
      estado_normalizado = estado_valor.strip().lower()
      estado_servicio = estado_normalizado in (
        '1',
        'true',
        't',
        'si',
        'sí',
        'on',
        'yes',
      )
    else:
      estado_servicio = bool(estado_valor)

    if not id_tipo_servicio or not direccion:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'Cada servicio debe contar con tipo y dirección.',
          }
        ),
        400,
      )

    try:
      id_tipo_servicio = int(id_tipo_servicio)
    except (TypeError, ValueError):
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'El tipo de servicio indicado no es válido.',
          }
        ),
        400,
      )

    tipos_requeridos.add(id_tipo_servicio)
    servicios_validos.append(
      {
        'id': id_servicio,
        'tipo_id': id_tipo_servicio,
        'direccion': direccion,
        'nombre_capa': nombre_capa_servicio,
        'titulo_capa': titulo_capa_servicio,
        'id_layer': id_layer,
        'estado': estado_servicio,
        'visible': visible,
      }
    )

  tipos_consulta = (
    TipoServicio.query.filter(TipoServicio.id.in_(tipos_requeridos)).all()
    if tipos_requeridos
    else []
  )
  tipos_por_id = {tipo.id: tipo for tipo in tipos_consulta}

  tipos_controlados = set()

  for servicio in servicios_validos:
    tipo_servicio = tipos_por_id.get(servicio['tipo_id'])
    if not tipo_servicio:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'Se indicó un tipo de servicio inexistente.',
          }
        ),
        400,
      )
    requiere_unicidad = (
      tipo_servicio.estado
      and tipo_servicio.id_padre in (2, 3)
    )
    if requiere_unicidad:
      if tipo_servicio.id in tipos_controlados:
        return (
          jsonify(
            {
              'status': 'error',
              'message': 'No se puede registrar más de un servicio por tipo seleccionado.',
            }
          ),
          400,
        )
      tipos_controlados.add(tipo_servicio.id)

    if tipo_servicio.id_padre == 2:
      if servicio['estado']:
        if not servicio['nombre_capa'] or not servicio['titulo_capa']:
          return (
            jsonify(
              {
                'status': 'error',
                'message': 'Los servicios OGC conectados deben incluir nombre y título de capa.',
              }
            ),
            400,
          )
      else:
        if not servicio['nombre_capa']:
          return (
            jsonify(
              {
                'status': 'error',
                'message': 'Indique el nombre de la capa cuando el servicio OGC no está activo.',
              }
            ),
            400,
          )
        servicio['titulo_capa'] = None
    elif es_servicio_arcgis_mapserver(tipo_servicio):
      if servicio['estado']:
        if not servicio['nombre_capa'] or not servicio['titulo_capa']:
          return (
            jsonify(
              {
                'status': 'error',
                'message': 'Los servicios ArcGIS MapServer conectados requieren id y nombre de capa.',
              }
            ),
            400,
          )
      else:
        if not servicio['nombre_capa']:
          return (
            jsonify(
              {
                'status': 'error',
                'message': 'Indique el identificador de capa cuando el servicio ArcGIS MapServer no está activo.',
              }
            ),
            400,
          )
        servicio['titulo_capa'] = None

    if tipo_servicio.id_padre in (2, 3) and not servicio['nombre_capa']:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'Los servicios deben contar con un nombre de capa válido.',
          }
        ),
        400,
      )
    servicio['nombre_capa'] = servicio['nombre_capa'] or None
    servicio['titulo_capa'] = servicio['titulo_capa'] or None

    if servicio['tipo_id'] == 11 and publicar_geoperu and id_layer_geoperu is None:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'Ingrese el ID Layer de GeoPerú para el servicio WMS.',
          }
        ),
        400,
      )

  servicios_existentes = {serv.id: serv for serv in capa.servicios}
  ids_a_conservar = set()

  for servicio in servicios_validos:
    servicio_instancia = None
    if servicio['id']:
      try:
        id_servicio = int(servicio['id'])
      except (TypeError, ValueError):
        return (
          jsonify(
            {
              'status': 'error',
              'message': 'El identificador de servicio es inválido.',
            }
          ),
          400,
        )
      servicio_instancia = servicios_existentes.get(id_servicio)
      if not servicio_instancia:
        return (
          jsonify(
            {
              'status': 'error',
              'message': 'Uno de los servicios indicados no existe.',
            }
          ),
          404,
        )
      ids_a_conservar.add(id_servicio)
    else:
      sincronizar_secuencia(ServicioGeografico)
      servicio_instancia = ServicioGeografico(
        capa=capa,
        usuario_crea=usuario.id,
      )
      db.session.add(servicio_instancia)

    servicio_instancia.id_tipo_servicio = servicio['tipo_id']
    servicio_instancia.direccion_web = servicio['direccion']
    servicio_instancia.nombre_capa = servicio['nombre_capa'] or None
    servicio_instancia.titulo_capa = servicio['titulo_capa'] or None
    servicio_instancia.estado = servicio['estado']
    servicio_instancia.visible = servicio['visible']
    if servicio['tipo_id'] == 11:
      if publicar_geoperu and id_layer_geoperu is not None:
        servicio_instancia.id_layer = id_layer_geoperu
    elif not servicio_instancia.id_layer:
      servicio_instancia.id_layer = 0
    servicio_instancia.usuario_modifica = usuario.id

  for servicio in list(capa.servicios):
    if servicio.id and servicio.id not in ids_a_conservar:
      db.session.delete(servicio)

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

  return (
    jsonify({'status': 'success', 'id_capa': capa.id}),
    200 if id_capa else 201,
  )


@bp.route('/servicios/capabilities', methods=['POST'])
@jwt_required()
def obtener_capas_servicio():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({'status': 'error', 'message': 'Sesión no válida.'}), 401

  data = request.get_json(force=True) or {}
  tipo_id = data.get('id_tipo_servicio')
  url = (data.get('url') or '').strip()

  if not tipo_id or not url:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'Debe indicar el tipo de servicio y la URL.',
        }
      ),
      400,
    )

  try:
    tipo_id_int = int(tipo_id)
  except (TypeError, ValueError):
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'El tipo de servicio enviado no es válido.',
        }
      ),
      400,
    )

  tipo_servicio = TipoServicio.query.get(tipo_id_int)
  if not tipo_servicio:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'El tipo de servicio indicado no existe.',
        }
      ),
      400,
    )

  try:
    if tipo_servicio.id_padre == 2:
      capas = obtener_capas_desde_servicio(tipo_servicio, url)
    elif es_servicio_arcgis_mapserver(tipo_servicio):
      capas = obtener_capas_desde_mapserver(url)
    else:
      return (
        jsonify(
          {
            'status': 'error',
            'message': 'El tipo de servicio seleccionado no admite conexión automática.',
          }
        ),
        400,
      )
  except ValueError as error:
    return jsonify({'status': 'error', 'message': str(error)}), 400

  if not capas:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se encontraron capas disponibles en el servicio.',
        }
      ),
      200,
    )

  return jsonify({'status': 'success', 'capas': capas})

@bp.route('/<int:id_capa>', methods=['DELETE'])
@jwt_required()
def eliminar(id_capa: int):
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({'status': 'error', 'message': 'Sesión no válida.'}), 401

  capa = CapaGeografica.query.get(id_capa)
  if not capa:
    return jsonify({'status': 'error', 'message': 'La capa indicada no existe.'}), 404

  if usuario.es_gestor and capa.id_institucion != usuario.id_institucion:
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No puedes eliminar capas de otra institución.',
        }
      ),
      403,
    )

  db.session.delete(capa)
  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'No se pudo eliminar la capa geográfica.',
        }
      ),
      400,
    )

  return jsonify({'status': 'success', 'message': 'Capa geográfica eliminada correctamente.'})