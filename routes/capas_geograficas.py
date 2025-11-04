from __future__ import annotations

import xml.etree.ElementTree as ET

import requests
from flask import Blueprint, jsonify, render_template, request
from flask_jwt_extended import jwt_required
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse

from requests.exceptions import RequestException
from sqlalchemy import func, text
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app import db
from models.capas_geograficas import CapaGeografica, ServicioGeografico
from models.categorias import Categoria
from models.instituciones import Institucion
from models.tipos_servicios import TipoServicio
from routes._helpers import obtener_usuario_actual

bp = Blueprint('capas_geograficas', __name__, url_prefix='/capas_geograficas')

OGC_WMS_IDS = {11}
OGC_WFS_IDS = {12}
OGC_WMTS_IDS = {14}
ARCGIS_MAPSERVER_IDS = {17}

def limpiar_texto(elemento):
  if not elemento or not elemento.text:
    return None
  texto = elemento.text.strip()
  return texto or None

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
      text("SELECT setval(:secuencia::regclass, :valor, :llamado)"),
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

def extraer_capas_wms(contenido):
  capas = []
  raiz = ET.fromstring(contenido)

  namespaces = {'wms': 'http://www.opengis.net/wms'}
  candidatos = raiz.findall('.//wms:Layer', namespaces)

  if not candidatos:
    candidatos = raiz.findall('.//{*}Layer')

  for layer in candidatos:
    queryable = layer.get('queryable')
    if queryable == '1':
      nombre_layer = layer.find('wms:Name', namespaces)
      titulo_layer = layer.find('wms:Title', namespaces)

      if nombre_layer is not None and titulo_layer is not None:
        nombre = nombre_layer.text
        titulo = titulo_layer.text

      if nombre and titulo:
        capas.append({
        'value': nombre,
        'label': titulo
        })

  return capas

def extraer_capas_wfs(contenido):
  capas = []
  raiz = ET.fromstring(contenido)
  for feature in raiz.findall('.//{*}FeatureType'):
    nombre = limpiar_texto(feature.find('{*}Name'))
    if not nombre:
      continue
    titulo = limpiar_texto(feature.find('{*}Title'))
    etiqueta = titulo if titulo else nombre
    if titulo and titulo != nombre:
      etiqueta = f"{titulo} ({nombre})"
      capas.append({'value': nombre, 'label': etiqueta})
  return capas

def extraer_capas_wmts(contenido):
  capas = []
  raiz = ET.fromstring(contenido)
  for layer in raiz.findall('.//{*}Contents/{*}Layer'):
    identificador = limpiar_texto(layer.find('{*}Identifier'))
    if not identificador:
      continue
    titulo = limpiar_texto(layer.find('{*}Title'))
    etiqueta = titulo if titulo else identificador
    if titulo and titulo != identificador:
      etiqueta = f"{titulo} ({identificador})"
      capas.append({'value': identificador, 'label': etiqueta})
  return capas

def es_servicio_wms(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id in OGC_WMS_IDS:
    return True
  nombre = (tipo_servicio.nombre or '').lower()
  return 'wms' in nombre

def es_servicio_wfs(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id in OGC_WFS_IDS:
    return True
  nombre = (tipo_servicio.nombre or '').lower()
  return 'wfs' in nombre

def es_servicio_wmts(tipo_servicio):
  if not tipo_servicio:
    return False
  if tipo_servicio.id in OGC_WMTS_IDS:
    return True
  nombre = (tipo_servicio.nombre or '').lower()
  return 'wmts' in nombre

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
  if tipo_servicio.id in ARCGIS_MAPSERVER_IDS:
    return True
  if tipo_servicio.id_padre != 3:
    return False
  nombre = (tipo_servicio.nombre or '').lower()
  return 'arcgis' in nombre and 'mapserver' in nombre

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
  try:
    respuesta = requests.get(url_json, timeout=15)
    respuesta.raise_for_status()
  except RequestException as error:
    raise ValueError('No se pudo conectar con el servicio especificado.') from error

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
  try:
    respuesta = requests.get(url_capabilities, timeout=15)
    respuesta.raise_for_status()
  except RequestException as error:
    raise ValueError('No se pudo conectar con el servicio especificado.') from error

  contenido = respuesta.text
  try:
    if es_servicio_wms(tipo_servicio):
      return extraer_capas_wms(contenido)
    if es_servicio_wfs(tipo_servicio):
      return extraer_capas_wfs(contenido)
    if es_servicio_wmts(tipo_servicio):
      return extraer_capas_wmts(contenido)
  except ET.ParseError as error:
    raise ValueError('La respuesta del servicio no es un XML válido.') from error

  raise ValueError('El tipo de servicio OGC seleccionado no está soportado.')

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
  ).order_by(CapaGeografica.nombre.asc())

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
          'estado': estado_servicio,
        }
      )

    nombres_servicios = ', '.join(
      detalle['nombre'] for detalle in servicios_detalle if detalle.get('nombre')
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
      'servicio_ids': [detalle['id'] for detalle in servicios_detalle],
    }

    if tiene_activos and not tiene_inactivos:
      activos.append(capa_data)
    elif tiene_inactivos and not tiene_activos:
      inactivos.append(capa_data)
    else:
      sin_estado.append(capa_data)

  return jsonify({'activos': activos, 'inactivos': inactivos, 'sin_estado': sin_estado})


@bp.route('/detalle/<int:capa_id>')
@jwt_required()
def detalle(capa_id):
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
    .filter(CapaGeografica.id == capa_id)
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
      'estado': servicio.estado,
      'tipo_servicio_nombre': servicio.tipo_servicio.nombre
      if servicio.tipo_servicio
      else None,
    }
    for servicio in capa.servicios
  ]

  return jsonify(
    {
      'id': capa.id,
      'nombre': capa.nombre,
      'descripcion': capa.descripcion,
      'tipo_capa': capa.tipo_capa,
      'en_geoperu': capa.publicar_geoperu,
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
    sincronizar_secuencia(CapaGeografica)
    capa = CapaGeografica(usuario_crea=usuario.id)
    db.session.add(capa)

  capa.nombre = nombre
  capa.descripcion = descripcion
  capa.tipo_capa = tipo_capa
  capa.publicar_geoperu = publicar_geoperu
  capa.id_categoria = categoria_id
  capa.id_institucion = institucion_id
  capa.usuario_modifica = usuario.id

  servicios_payload = data.get('servicios', [])
  if servicios_payload and not isinstance(servicios_payload, list):
    return (
      jsonify(
        {
          'status': 'error',
          'message': 'El formato de servicios enviados no es válido.',
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

    servicio_id = servicio.get('id')
    tipo_servicio_id = servicio.get('tipo_servicio_id')
    direccion = (servicio.get('direccion') or '').strip()
    nombre_capa_servicio = (servicio.get('nombre_capa') or '').strip()
    titulo_capa_servicio = (servicio.get('titulo_capa') or '').strip()
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

    if not tipo_servicio_id or not direccion:
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
      tipo_servicio_id = int(tipo_servicio_id)
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

    tipos_requeridos.add(tipo_servicio_id)
    servicios_validos.append(
      {
        'id': servicio_id,
        'tipo_id': tipo_servicio_id,
        'direccion': direccion,
        'nombre_capa': nombre_capa_servicio,
        'titulo_capa': titulo_capa_servicio,
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

  servicios_existentes = {serv.id: serv for serv in capa.servicios}
  ids_a_conservar = set()

  for servicio in servicios_validos:
    servicio_instancia = None
    if servicio['id']:
      try:
        servicio_id = int(servicio['id'])
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
      servicio_instancia = servicios_existentes.get(servicio_id)
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
      ids_a_conservar.add(servicio_id)
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
    jsonify({'status': 'success', 'capa_id': capa.id}),
    200 if capa_id else 201,
  )


@bp.route('/servicios/capabilities', methods=['POST'])
@jwt_required()
def obtener_capas_servicio():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({'status': 'error', 'message': 'Sesión no válida.'}), 401

  data = request.get_json(force=True) or {}
  tipo_id = data.get('tipo_servicio_id')
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
      404,
    )

  return jsonify({'status': 'success', 'capas': capas})