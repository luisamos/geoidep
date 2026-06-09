"""Cliente OGC para descubrir capas de servicios WMS/WFS/WMTS y MapServer.

API pública:
  - Clasificación de tipo: `es_servicio_wms`, `es_servicio_wfs`,
    `es_servicio_wmts`, `es_servicio_arcgis_mapserver`.
  - Constantes de IDs de tipo: `ID_TIPO_WMS`, `ID_TIPO_WFS`, `ID_TIPO_WMTS`,
    `ID_TIPO_ARCGIS_MAPSERVER`, `ID_TIPO_ARCGIS_KML`.
  - Construcción de URL Capabilities:
    - `preparar_url_capabilities(tipo, url)` — usa el objeto Tipo de la BD.
    - `build_getcapabilities_url(url, service)` — usa el string 'WMS'/'WFS'/'WMTS'
      (compartido con `services/monitoreo.py`).
  - Formato de etiquetas: `formatear_etiqueta_capa`.
  - Descubrimiento de capas: `obtener_capas_desde_servicio` (OGC),
    `obtener_capas_desde_mapserver` (ArcGIS REST).
  - Parseo del XML: `construir_capas_desde_xml`.

Depende de :mod:`app.services.http` para la capa de transporte síncrona.
"""
from __future__ import annotations

import logging
import xml.etree.ElementTree as ET
from urllib.parse import parse_qsl, urlencode, urlparse, urlsplit, urlunparse, urlunsplit

from app.services.http import (
  asegurar_parametro,
  validar_estado_servicio,
)

# IDs de tipos en la BD para el clasificador OGC.
ID_TIPO_WMS = 11
ID_TIPO_WFS = 12
ID_TIPO_WMTS = 14
ID_TIPO_ARCGIS_MAPSERVER = 17
ID_TIPO_ARCGIS_KML = 20

# Categorías padre (id_padre del modelo Tipo) — agrupan los tipos por familia.
ID_PADRE_HERRAMIENTAS = 1   # visores, portales, aplicaciones
ID_PADRE_OGC = 2            # WMS / WFS / WMTS
ID_PADRE_ARCGIS = 3         # ArcGIS REST (MapServer, KML)

# Conjuntos útiles para filtrar:
IDS_PADRE_TODOS = (ID_PADRE_HERRAMIENTAS, ID_PADRE_OGC, ID_PADRE_ARCGIS)
IDS_PADRE_SERVICIOS = (ID_PADRE_OGC, ID_PADRE_ARCGIS)
TIPOS_ARCGIS = (ID_TIPO_ARCGIS_MAPSERVER, ID_TIPO_ARCGIS_KML)

# Valores válidos para CapaGeografica.tipo_capa (1 = vector, 2 = ráster).
TIPO_CAPA_VECTOR = 1
TIPO_CAPA_RASTER = 2
VALORES_TIPO_CAPA = (TIPO_CAPA_VECTOR, TIPO_CAPA_RASTER)


# ---------- Clasificación de tipo ----------

def es_servicio_wms(tipo) -> bool:
  if not tipo:
    return False
  if tipo.id == ID_TIPO_WMS:
    return True
  return 'wms' in (tipo.nombre or '').lower()


def es_servicio_wfs(tipo) -> bool:
  if not tipo:
    return False
  if tipo.id == ID_TIPO_WFS:
    return True
  return 'wfs' in (tipo.nombre or '').lower()


def es_servicio_wmts(tipo) -> bool:
  if not tipo:
    return False
  if tipo.id == ID_TIPO_WMTS:
    return True
  return 'wmts' in (tipo.nombre or '').lower()


def es_servicio_arcgis_mapserver(tipo) -> bool:
  if not tipo:
    return False
  if tipo.id == ID_TIPO_ARCGIS_MAPSERVER:
    return True
  if tipo.id_padre != ID_PADRE_ARCGIS:
    return False
  nombre = (tipo.nombre or '').lower()
  return 'arcgis' in nombre and 'mapserver' in nombre


# ---------- Formato de etiquetas ----------

def formatear_etiqueta_capa(nombre: str | None, titulo: str | None) -> str | None:
  titulo_final = titulo or nombre
  if titulo_final and titulo_final != nombre:
    return f"{titulo_final} ({nombre})"
  return titulo_final


# ---------- Helpers XML ----------

def nombre_local_xml(elemento) -> str:
  """Devuelve el nombre del tag sin namespace XML."""
  return (elemento.tag or '').split('}')[-1]


def texto_hijo_directo(elemento, nombre: str) -> str | None:
  """Devuelve el texto del primer hijo con el nombre indicado (sin namespace)."""
  for hijo in list(elemento):
    if nombre_local_xml(hijo) == nombre and hijo.text:
      return hijo.text.strip()
  return None


# ---------- Parsers de Capabilities ----------

def _construir_capas_wms_desde_xml(root) -> list[dict]:
  capas = []

  def recorrer_layer(layer):
    if nombre_local_xml(layer) != 'Layer':
      return
    nombre = texto_hijo_directo(layer, 'Name')
    if nombre:
      titulo = texto_hijo_directo(layer, 'Title') or nombre
      capas.append({'value': nombre, 'label': formatear_etiqueta_capa(nombre, titulo)})
    for hijo in list(layer):
      if nombre_local_xml(hijo) == 'Layer':
        recorrer_layer(hijo)

  for elemento in root.iter():
    if nombre_local_xml(elemento) == 'Capability':
      for hijo in list(elemento):
        if nombre_local_xml(hijo) == 'Layer':
          recorrer_layer(hijo)
      break
  return capas


def _construir_capas_wfs_desde_xml(root) -> list[dict]:
  capas = []
  for feature_type in root.iter():
    if nombre_local_xml(feature_type) != 'FeatureType':
      continue
    nombre = texto_hijo_directo(feature_type, 'Name')
    if not nombre:
      continue
    titulo = texto_hijo_directo(feature_type, 'Title') or nombre
    capas.append({'value': nombre, 'label': formatear_etiqueta_capa(nombre, titulo)})
  return capas


def _construir_capas_wmts_desde_xml(root) -> list[dict]:
  capas = []
  for layer in root.iter():
    if nombre_local_xml(layer) != 'Layer':
      continue
    nombre = texto_hijo_directo(layer, 'Identifier')
    if not nombre:
      continue
    titulo = texto_hijo_directo(layer, 'Title') or nombre
    capas.append({'value': nombre, 'label': formatear_etiqueta_capa(nombre, titulo)})
  return capas


def construir_capas_desde_xml(tipo, contenido) -> list[dict]:
  """Parsea las capas desde el XML de Capabilities ya descargado.

  Algunos servidores publican documentos válidos que OWSLib no procesa por
  DTDs externas o metadatos atípicos; este parser mínimo trabaja sobre el XML
  crudo y extrae los nombres publicados.
  """
  try:
    root = ET.fromstring(contenido)
  except ET.ParseError as error:
    raise ValueError(
      'El servicio respondió, pero el documento de Capabilities no es un XML válido.'
    ) from error

  if es_servicio_wms(tipo):
    return _construir_capas_wms_desde_xml(root)
  if es_servicio_wfs(tipo):
    return _construir_capas_wfs_desde_xml(root)
  if es_servicio_wmts(tipo):
    return _construir_capas_wmts_desde_xml(root)
  return []


# ---------- Construcción de URL Capabilities ----------

def build_getcapabilities_url(base_url: str, service: str) -> str:
  """Ajusta la URL para apuntar a su GetCapabilities, indicando el servicio.

  Variante por string (`'WMS'`, `'WFS'`, `'WMTS'`) compartida con el monitoreo
  async (que no tiene un objeto Tipo a la mano, sólo el `id_tipo`).
  """
  if not base_url:
    return base_url

  parsed = urlsplit(base_url)
  query_items = dict(parse_qsl(parsed.query, keep_blank_values=True))
  if (
    query_items.get("request", "").lower() == "getcapabilities"
    and query_items.get("service", "").lower() == service.lower()
  ):
    return base_url

  query_items.setdefault("service", service)
  query_items["request"] = "GetCapabilities"
  new_query = urlencode(query_items)
  return urlunsplit(
    (parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment)
  )


def preparar_url_capabilities(tipo, url: str) -> str:
  """Ajusta la URL del servicio para apuntar a su GetCapabilities.

  Variante por objeto Tipo (ORM) que delega en ``build_getcapabilities_url``
  según la clasificación WMS/WFS/WMTS.
  """
  if not url:
    return url
  if es_servicio_wms(tipo):
    return build_getcapabilities_url(url, 'WMS')
  if es_servicio_wfs(tipo):
    return build_getcapabilities_url(url, 'WFS')
  if es_servicio_wmts(tipo):
    return build_getcapabilities_url(url, 'WMTS')
  return url


# ---------- Descubrimiento de capas ----------

def obtener_capas_desde_mapserver(url: str) -> list[dict]:
  """Devuelve las capas publicadas por un ArcGIS MapServer (REST `?f=pjson`)."""
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
    raise ValueError(
      'El servicio respondió correctamente, pero no expone capas. Verifica '
      'que el MapServer tenga capas publicadas o que tengas permisos para '
      'consultarlas.'
    )

  return capas


def obtener_capas_desde_servicio(tipo, url: str) -> list[dict]:
  """Descubre las capas de un servicio OGC (WMS/WFS/WMTS) leyendo Capabilities.

  Si el parser no logra extraer capas, reintenta forzando una versión explícita
  para servidores que omiten el parámetro `version` en sus respuestas
  (síntoma común en GeoServer).
  """
  url_capabilities = preparar_url_capabilities(tipo, url)

  urls_intento = [url_capabilities]
  if es_servicio_wms(tipo):
    urls_intento.append(asegurar_parametro(url_capabilities, 'version', '1.1.1'))
  elif es_servicio_wfs(tipo):
    urls_intento.append(asegurar_parametro(url_capabilities, 'version', '1.1.0'))

  ultimo_error = None
  total_intentos = len(urls_intento)
  for indice, url_intento in enumerate(urls_intento):
    respuesta = validar_estado_servicio(url_intento)
    try:
      capas = construir_capas_desde_xml(tipo, respuesta.content)
    except ValueError:
      raise
    except Exception as error:
      ultimo_error = error
      continue
    if capas:
      logging.info(
        'Capabilities OK: tipo=%s url=%s capas=%d',
        getattr(tipo, 'nombre', None) or getattr(tipo, 'id', None),
        url_intento,
        len(capas),
      )
      return capas
    if indice < total_intentos - 1:
      logging.warning(
        'GetCapabilities devolvió 0 capas en %s; reintentando con versión explícita.',
        url_intento,
      )

  if ultimo_error is not None:
    codigo_error = None
    respuesta_error = getattr(ultimo_error, 'response', None)
    if respuesta_error is not None:
      codigo_error = getattr(respuesta_error, 'status_code', None)
    descripcion_error = (str(ultimo_error) or '').strip().lower()
    if codigo_error:
      mensaje_error = (
        f"No se pudo leer las capacidades del servicio (HTTP {codigo_error}). "
        'Revisa que la URL sea pública y devuelva un documento de Capabilities válido.'
      )
    elif 'xml' in descripcion_error or 'parse' in descripcion_error:
      mensaje_error = (
        'El servicio respondió, pero el documento de Capabilities no es un XML '
        'válido. Verifica la URL o que el servicio publique sus metadatos OGC.'
      )
    else:
      mensaje_error = (
        'No se pudo leer las capacidades del servicio. Es posible que el origen '
        'bloquee la consulta (CORS / cabeceras restringidas).'
      )
    raise ValueError(mensaje_error) from ultimo_error

  raise ValueError(
    'El servicio respondió correctamente, pero no expone capas visibles. '
    'Verifica que el servicio publique capas con nombre o que tengas '
    'permisos sobre ellas.'
  )
