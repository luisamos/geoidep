"""Utilidades HTTP compartidas para consultas a servicios externos.

Capa síncrona (basada en `requests`):
  - HEADERS_LEGALES — cabeceras estándar GeoIDEP/1.0
  - realizar_request_get — GET con reintentos para proxy y SSL inverificable
  - validar_estado_servicio — wrapper que normaliza status != 200 como ValueError
  - describir_error_conexion — traduce excepciones a mensajes en español
  - asegurar_parametro — upsert case-insensitive de query string

Capa común al monitoreo async (en `services/monitoreo.py`):
  - build_ssl_context — contexto SSL con bundle certifi (reutilizable)
  - HEADERS_HTML — cabeceras de navegador para herramientas/HTML
  - HEADERS_OGC — cabeceras Accept para WMS/WFS XML
"""
from __future__ import annotations

import logging
import ssl

import certifi
import requests
import urllib3
from requests.exceptions import (
  ConnectionError as RequestsConnectionError,
  ConnectTimeout,
  ProxyError,
  ReadTimeout,
  RequestException,
  SSLError,
  Timeout,
  TooManyRedirects,
)
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse
from urllib3.exceptions import InsecureRequestWarning


HEADERS_LEGALES = {
  'User-Agent': 'GeoIDEP/1.0 (+https://geoidep.gob.pe)',
  'Accept': '*/*',
  'Referer': 'https://geoidep.gob.pe',
}

# Cabeceras de navegador (para herramientas que validan el User-Agent y
# devuelven HTML).
HEADERS_HTML = {
  "User-Agent": (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/120.0 Safari/537.36"
  ),
  "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
  "Connection": "keep-alive",
}

# Cabeceras para consultas OGC (XML).
HEADERS_OGC = {
  "User-Agent": HEADERS_HTML["User-Agent"],
  "Accept": "application/xml,text/xml,*/*;q=0.8",
  "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
  "Connection": "keep-alive",
}


def build_ssl_context() -> ssl.SSLContext:
  """Contexto SSL con el bundle de certifi."""
  return ssl.create_default_context(cafile=certifi.where())


def realizar_request_get(url, timeout: int = 15, headers: dict | None = None):
  """GET con reintentos para proxy y certificados no verificables.

  Para servicios OGC públicos sólo se leen capabilities en modo lectura, por
  lo que se admite reintentar sin verificación SSL ante certificados no
  reconocidos (común en servidores gubernamentales).
  """
  headers_final = HEADERS_LEGALES.copy()
  if headers:
    headers_final.update(headers)
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
    logging.warning(
      'Certificado SSL no verificable para %s; reintentando sin verificación.',
      url,
    )
    urllib3.disable_warnings(InsecureRequestWarning)
    try:
      return requests.get(
        url,
        timeout=timeout,
        headers=headers_final,
        verify=False,
      )
    except ProxyError:
      return requests.get(
        url,
        timeout=timeout,
        headers=headers_final,
        proxies={'http': None, 'https': None},
        verify=False,
      )


def describir_error_conexion(error: Exception) -> str:
  """Traduce una excepción de `requests` a un mensaje en español."""
  if isinstance(error, SSLError):
    return (
      'Error de certificado SSL: el servicio no presenta un certificado válido '
      'o reconocido. Verifica que la URL inicie con HTTPS y que el dominio '
      'sea confiable.'
    )
  if isinstance(error, (ConnectTimeout, ReadTimeout, Timeout)):
    return (
      'Tiempo de espera agotado al conectar con el servicio. Es posible que '
      'el servidor esté lento o no disponible. Inténtalo nuevamente más tarde.'
    )
  if isinstance(error, ProxyError):
    return 'No se pudo establecer la conexión a través del proxy configurado.'
  if isinstance(error, TooManyRedirects):
    return 'El servicio devolvió demasiadas redirecciones; revisa la URL.'
  if isinstance(error, RequestsConnectionError):
    texto = str(error).lower()
    if 'name or service not known' in texto or 'nodename nor servname' in texto:
      return (
        'No se pudo resolver el dominio del servicio. Verifica que la URL '
        'esté escrita correctamente.'
      )
    if 'connection refused' in texto:
      return 'El servidor rechazó la conexión. El servicio podría estar caído.'
    if 'cors' in texto:
      return (
        'La solicitud fue bloqueada por política CORS del servidor remoto. '
        'Solicita al proveedor habilitar el origen geoidep.gob.pe.'
      )
    return (
      'No se pudo establecer la conexión con el servicio. Comprueba la URL, '
      'tu conexión a internet o si el servicio remoto está disponible.'
    )
  return 'No se pudo conectar con el servicio especificado.'


def validar_estado_servicio(url):
  """Hace GET y lanza `ValueError` con mensaje legible si la respuesta no es 200."""
  try:
    respuesta = realizar_request_get(url)
  except RequestException as error:
    raise ValueError(describir_error_conexion(error)) from error
  if respuesta.status_code != 200:
    detalle = respuesta.reason or 'Error en el servicio'
    if 400 <= respuesta.status_code < 500:
      pista = (
        ' Es posible que el servicio requiera autenticación o que la URL no '
        'sea pública.'
      )
    elif 500 <= respuesta.status_code < 600:
      pista = ' El servidor remoto está reportando un error interno.'
    else:
      pista = ''
    raise ValueError(
      f"El servicio respondió con estado {respuesta.status_code}: {detalle}.{pista}"
    )
  return respuesta


def asegurar_parametro(url: str, clave: str, valor) -> str:
  """Inserta o reemplaza un parámetro en la query string de la URL.

  Compara claves de forma case-insensitive para evitar duplicados como
  ``service=WMS&Service=wms``.
  """
  if not url:
    return url

  parsed = urlparse(url)
  query_pairs = parse_qsl(parsed.query, keep_blank_values=True)
  clave_lower = clave.lower()
  filtrados = [(k, v) for k, v in query_pairs if k.lower() != clave_lower]
  filtrados.append((clave, valor))
  nueva_query = urlencode(filtrados, doseq=True)
  return urlunparse(parsed._replace(query=nueva_query))
