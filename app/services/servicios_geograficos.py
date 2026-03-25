from __future__ import annotations

import asyncio
import logging
import random
from typing import Optional
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse, urlsplit, urlunsplit

import aiohttp
import requests
import urllib3
from lxml import etree
from owslib.wfs import WebFeatureService
from owslib.wms import WebMapService
from owslib.wmts import WebMapTileService
from requests.exceptions import ProxyError, RequestException, SSLError
from urllib3.exceptions import InsecureRequestWarning

from app.models import ServicioGeografico


class ServiciosGeograficos:
  WMS_SERVICE_TYPE = 11
  WFS_SERVICE_TYPE = 12
  ARCGIS_REST_SERVICE_TYPE = 17
  ARCGIS_KML_SERVICE_TYPE = 20

  ASYNC_HEADERS = {
    "User-Agent": (
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
      "AppleWebKit/537.36 (KHTML, like Gecko) "
      "Chrome/120.0 Safari/537.36"
    ),
    "Accept": "application/xml,text/xml,*/*;q=0.8",
    "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
    "Connection": "keep-alive",
  }

  def __init__(
    self,
    async_headers: Optional[dict[str, str]] = None,
    headers_legales: Optional[dict[str, str]] = None,
    insecure_hosts: Optional[set[str]] = None,
  ) -> None:
    self.async_headers = async_headers or self.ASYNC_HEADERS
    self.headers_legales = headers_legales or {}
    self.insecure_hosts = set(insecure_hosts or set())

def build_getcapabilities_url(self, base_url: str, service: str) -> str:
    if not base_url:
      return base_url

    parsed = urlsplit(base_url)
    query_items = dict(parse_qsl(parsed.query, keep_blank_values=True))
    if query_items.get("request", "").lower() == "getcapabilities" and query_items.get(
      "service", ""
    ).lower() == service.lower():
      return base_url

    query_items["service"] = service
    query_items["request"] = "GetCapabilities"
    new_query = urlencode(query_items)
    return urlunsplit(
      (parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment)
    )

  def extract_featuretypes(self, xml_text: str) -> list[str]:
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    nodes = root.xpath(
      "//*[local-name()='FeatureTypeList']/*[local-name()='FeatureType']"
    )
    names = []
    for feature in nodes:
      name = feature.xpath("string(./*[local-name()='Name'])").strip()
      if name:
        names.append(name)
    return names

  async def fetch_with_retries(
    self,
    session,
    url: str,
    timeout: float,
    max_attempts: int = 3,
  ) -> tuple[str, str, Optional[int]]:
    client_timeout = aiohttp.ClientTimeout(total=timeout, connect=10, sock_read=20)
    last_error: Optional[Exception] = None

    for attempt in range(1, max_attempts + 1):
      try:
        async with session.get(
          url,
          headers=self.async_headers,
          timeout=client_timeout,
          allow_redirects=True,
        ) as response:
          text = await response.text(errors="ignore")
          return text, response.headers.get("Content-Type", ""), response.status
      except Exception as exc:
        last_error = exc
        await asyncio.sleep((0.7 * attempt) + random.random())

    if last_error:
      raise last_error

    raise RuntimeError("No se pudo completar la petición HTTP.")

  def clasificar_estado(self, status_code: Optional[int]) -> str:
    if status_code is None:
      return "sin_respuesta"
    return str(status_code)

  def build_service_url(self, servicio: ServicioGeografico) -> str:
    if servicio.id_tipo == self.WMS_SERVICE_TYPE:
      return self.build_getcapabilities_url(servicio.direccion_web, "WMS")
    if servicio.id_tipo == self.WFS_SERVICE_TYPE:
      return self.build_getcapabilities_url(servicio.direccion_web, "WFS")
    return servicio.direccion_web

  async def procesar_servicio(
    self,
    session,
    servicio: ServicioGeografico,
    config,
  ) -> tuple[bool, Optional[list[str]], Optional[int]]:
    url = self.build_service_url(servicio)
    try:
      xml_text, content_type, status = await self.fetch_with_retries(
        session, url, config.timeout
      )
    except Exception as exc:
      logging.warning("Fallo servicio %s -> %s", url, exc)
      return False, None, None

    if servicio.id_tipo == self.WFS_SERVICE_TYPE:
      if "<WFS_Capabilities" not in xml_text and "FeatureTypeList" not in xml_text:
        logging.warning(
          "Respuesta no parece WFS XML en %s (Content-Type: %s)",
          url,
          content_type,
        )
        logging.debug("Contenido parcial: %s", xml_text[:300])
        return False, None, status

      layers = self.extract_featuretypes(xml_text)
      estado_ok = bool(layers) and (status is not None and status < 400)
      return estado_ok, layers or None, status

    if servicio.id_tipo in {
      self.ARCGIS_REST_SERVICE_TYPE,
      self.ARCGIS_KML_SERVICE_TYPE,
    }:
      estado_ok = bool(status is not None and status < 400)
      return estado_ok, None, status

    estado_ok = bool(status is not None and status < 400)
    return estado_ok, None, status

  def formatear_etiqueta_capa(self, nombre, titulo):
    titulo_final = titulo or nombre
    if titulo_final and titulo_final != nombre:
      return f"{titulo_final} ({nombre})"
    return titulo_final

  def construir_capas_desde_contenidos(self, contenidos):
    capas = []
    for nombre, capa in contenidos.items():
      if not nombre:
        continue
      titulo = getattr(capa, "title", None) or nombre
      etiqueta = self.formatear_etiqueta_capa(nombre, titulo)
      capas.append({"value": nombre, "label": etiqueta})
    return capas

  def es_servicio_wms(self, tipo):
    if not tipo:
      return False
    if tipo.id == self.WMS_SERVICE_TYPE:
      return True
    nombre = (tipo.nombre or "").lower()
    return "wms" in nombre

  def es_servicio_wfs(self, tipo):
    if not tipo:
      return False
    if tipo.id == self.WFS_SERVICE_TYPE:
      return True
    nombre = (tipo.nombre or "").lower()
    return "wfs" in nombre

  def es_servicio_wmts(self, tipo):
    if not tipo:
      return False
    if tipo.id == 14:
      return True
    nombre = (tipo.nombre or "").lower()
    return "wmts" in nombre

  def es_servicio_arcgis_mapserver(self, tipo):
    if not tipo:
      return False
    if tipo.id == self.ARCGIS_REST_SERVICE_TYPE:
      return True
    if tipo.id_padre != 3:
      return False
    nombre = (tipo.nombre or "").lower()
    return "arcgis" in nombre and "mapserver" in nombre

  def preparar_url_capabilities(self, tipo, url):
    if not url:
      return url
    if self.es_servicio_wms(tipo):
      return self.build_getcapabilities_url(url, "WMS")
    if self.es_servicio_wfs(tipo):
      return self.build_getcapabilities_url(url, "WFS")
    if self.es_servicio_wmts(tipo):
      return self.build_getcapabilities_url(url, "WMTS")
    return url

  def realizar_request_get(self, url, timeout=15, headers=None):
    headers_final = self.headers_legales.copy()
    if headers:
      headers_final.update(headers)
    parsed_url = urlparse(url)
    allow_insecure = parsed_url.hostname in self.insecure_hosts
    try:
      return requests.get(url, timeout=timeout, headers=headers_final)
    except ProxyError:
      return requests.get(
        url,
        timeout=timeout,
        headers=headers_final,
        proxies={"http": None, "https": None},
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
            proxies={"http": None, "https": None},
            verify=False,
          )

  def validar_estado_servicio(self, url):
    try:
      respuesta = self.realizar_request_get(url)
    except RequestException as error:
      raise ValueError("No se pudo conectar con el servicio especificado.") from error
    if respuesta.status_code != 200:
      detalle = respuesta.reason or "Error en el servicio"
      raise ValueError(
        f"El servicio respondió con estado {respuesta.status_code}: {detalle}."
      )
    return respuesta

  def asegurar_parametro(self, url, clave, valor):
    if not url:
      return url

    parsed = urlparse(url)
    query_pairs = parse_qsl(parsed.query, keep_blank_values=True)
    clave_lower = clave.lower()
    filtrados = [(k, v) for k, v in query_pairs if k.lower() != clave_lower]
    filtrados.append((clave, valor))
    nueva_query = urlencode(filtrados, doseq=True)
    return urlunparse(parsed._replace(query=nueva_query))

  def obtener_capas_desde_mapserver(self, url):
    url_json = self.asegurar_parametro(url, "f", "pjson")
    respuesta = self.validar_estado_servicio(url_json)

    try:
      data = respuesta.json()
    except ValueError as error:
      raise ValueError("La respuesta del servicio no es un JSON válido.") from error

    capas = []
    for layer in data.get("layers", []):
      layer_id = layer.get("id")
      nombre = layer.get("name")
      if layer_id is None or not nombre:
        continue
      capas.append({"value": str(layer_id), "label": nombre})

    if not capas:
      raise ValueError("No se encontraron capas disponibles en el servicio.")

    return capas

  def obtener_capas_desde_servicio(self, tipo, url):
    url_capabilities = self.preparar_url_capabilities(tipo, url)
    self.validar_estado_servicio(url_capabilities)

    try:
      if self.es_servicio_wms(tipo):
        servicio = WebMapService(url_capabilities, headers=self.headers_legales)
        capas = self.construir_capas_desde_contenidos(servicio.contents)
      elif self.es_servicio_wfs(tipo):
        servicio = WebFeatureService(url_capabilities, headers=self.headers_legales)
        capas = self.construir_capas_desde_contenidos(servicio.contents)
      elif self.es_servicio_wmts(tipo):
        servicio = WebMapTileService(url_capabilities, headers=self.headers_legales)
        capas = self.construir_capas_desde_contenidos(servicio.contents)
      else:
        raise ValueError("El tipo de servicio OGC seleccionado no está soportado.")
    except Exception as error:
        codigo_error = None
        respuesta_error = getattr(error, "response", None)
        if respuesta_error is not None:
          codigo_error = getattr(respuesta_error, "status_code", None)
        if codigo_error:
          mensaje_error = (
            f"No se pudo leer las capacidades del servicio (HTTP {codigo_error})."
          )
        else:
          mensaje_error = "No se pudo leer las capacidades del servicio."
        raise ValueError(mensaje_error) from error

    if not capas:
      raise ValueError("No se encontraron capas disponibles en el servicio.")

    return capas