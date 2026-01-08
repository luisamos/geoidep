import argparse
import logging
import time
from dataclasses import dataclass
from typing import Optional
from urllib.parse import urlsplit, urlunsplit, parse_qsl, urlencode

import requests
from requests import RequestException
from xml.etree import ElementTree

from apps import create_app, db
from apps.models import ServicioGeografico

@dataclass
class RequestConfig:
  timeout: float
  delay: float
  origin: str
  referer: str
  user_agent: str

  def headers(self) -> dict:
    return {
      "User-Agent": self.user_agent,
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
      "Origin": self.origin,
      "Referer": self.referer,
      "Connection": "keep-alive",
    }


def build_getcapabilities_url(base_url: str) -> str:
  if not base_url:
    return base_url

  parsed = urlsplit(base_url)
  query_items = dict(parse_qsl(parsed.query, keep_blank_values=True))
  if query_items.get("request", "").lower() == "getcapabilities" and query_items.get(
    "service", ""
  ).lower() == "wfs":
    return base_url

  query_items.setdefault("service", "WFS")
  query_items["request"] = "GetCapabilities"
  new_query = urlencode(query_items)
  return urlunsplit((parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment))


def extraer_nombre_capa_wfs(xml_bytes: bytes) -> Optional[str]:
  try:
    root = ElementTree.fromstring(xml_bytes)
  except ElementTree.ParseError:
    return None

  for feature_type in root.iter():
    if feature_type.tag.lower().endswith("featuretype"):
      for child in list(feature_type):
        if child.tag.lower().endswith("name") and child.text:
          return child.text.strip()
  return None


def probar_url(session: requests.Session, url: str, config: RequestConfig) -> Optional[requests.Response]:
  try:
    response = session.get(
      url,
      headers=config.headers(),
      timeout=config.timeout,
      allow_redirects=True,
    )
  except RequestException:
    return None

  if response.status_code >= 400:
    return None
  return response


def procesar_servicio(
  session: requests.Session,
  servicio: ServicioGeografico,
  config: RequestConfig,
) -> tuple[bool, Optional[str]]:
  if servicio.id_tipo_servicio == 12:
    url = build_getcapabilities_url(servicio.direccion_web)
    response = probar_url(session, url, config)
    if not response:
      return False, None
    nombre_capa = extraer_nombre_capa_wfs(response.content)
    return True, nombre_capa

  response = probar_url(session, servicio.direccion_web, config)
  return response is not None, None


def actualizar_servicios(
  config: RequestConfig,
  limite: Optional[int],
  dry_run: bool,
) -> None:
  app = create_app()
  with app.app_context():
    query = ServicioGeografico.query.order_by(ServicioGeografico.id)
    if limite:
      query = query.limit(limite)

    servicios = query.all()

    if not servicios:
      logging.info("No se encontraron servicios geográficos para verificar.")
      return

    session = requests.Session()
    session.headers.update(config.headers())

    for servicio in servicios:
      estado_anterior = servicio.estado
      estado, nombre_capa = procesar_servicio(session, servicio, config)
      servicio.estado = bool(estado)

      if servicio.id_tipo_servicio == 12 and nombre_capa:
        servicio.nombre_capa = nombre_capa

      logging.info(
        "Servicio %s | URL: %s | Estado: %s -> %s",
        servicio.id,
        servicio.direccion_web,
        estado_anterior,
        servicio.estado,
      )

      if config.delay:
        time.sleep(config.delay)

    if dry_run:
      db.session.rollback()
      logging.info("Ejecución en modo simulación: no se guardaron cambios.")
      return

    db.session.commit()
    logging.info("Actualización de servicios completada.")


def parse_args() -> argparse.Namespace:
  parser = argparse.ArgumentParser(
    description="Verifica servicios geográficos y actualiza su estado.",
  )
  parser.add_argument("--limite", type=int, help="Número máximo de registros a revisar.")
  parser.add_argument("--timeout", type=float, default=15.0, help="Tiempo de espera HTTP.")
  parser.add_argument(
    "--delay",
    type=float,
    default=0.5,
    help="Espera en segundos entre cada petición.",
  )
  parser.add_argument(
    "--origin",
    default="https://geoidep.local",
    help="Origen declarado en los encabezados para las peticiones.",
  )
  parser.add_argument(
    "--referer",
    default="https://geoidep.local/validacion",
    help="Referer declarado en los encabezados para las peticiones.",
  )
  parser.add_argument(
    "--user-agent",
    default="GeoIDEP-Geoportal/1.0 (contacto: soporte@geoidep.local)",
    help="User-Agent declarado en los encabezados para las peticiones.",
  )
  parser.add_argument(
    "--dry-run",
    action="store_true",
    help="Ejecuta la verificación sin guardar cambios en la base de datos.",
  )
  return parser.parse_args()


def main() -> None:
  args = parse_args()
  logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

  config = RequestConfig(
    timeout=args.timeout,
    delay=args.delay,
    origin=args.origin,
    referer=args.referer,
    user_agent=args.user_agent,
  )
  actualizar_servicios(config, args.limite, args.dry_run)

if __name__ == "__main__":
  main()