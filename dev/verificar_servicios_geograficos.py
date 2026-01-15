import argparse
import logging
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Optional
from urllib.parse import urlsplit, urlunsplit, parse_qsl, urlencode

root_dir = Path(__file__).resolve().parents[1]
if str(root_dir) not in sys.path:
  sys.path.insert(0, str(root_dir))

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
  contact_email: str

  def headers(self) -> dict:
    return {
      "User-Agent": self.user_agent,
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
      "Origin": self.origin,
      "Referer": self.referer,
      "Connection": "keep-alive",
      "From": self.contact_email,
      "X-GeoIDEP-Notice": "Verificacion automatizada de servicios (no ataque)",
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

@dataclass
class RequestResult:
  response: Optional[requests.Response]
  status_code: Optional[int]
  error: Optional[str]


def probar_url(session: requests.Session, url: str, config: RequestConfig) -> RequestResult:
  try:
    response = session.get(
      url,
      headers=config.headers(),
      timeout=config.timeout,
      allow_redirects=True,
    )
  except RequestException as exc:
    return RequestResult(None, None, str(exc))

  return RequestResult(response, response.status_code, None)


def clasificar_estado(status_code: Optional[int]) -> str:
  if status_code in {400, 401, 301, 503}:
    return str(status_code)
  if status_code is None:
    return "sin_respuesta"
  return f"otro({status_code})"

def escribir_getcapabilities(tmp_dir: Path, servicio: ServicioGeografico, contenido: bytes) -> Path:
  tmp_dir.mkdir(parents=True, exist_ok=True)
  archivo = tmp_dir / f"servicio_{servicio.id}_getcapabilities.xml"
  archivo.write_bytes(contenido)
  return archivo

def procesar_servicio(
  session: requests.Session,
  servicio: ServicioGeografico,
  config: RequestConfig,
) -> tuple[bool, Optional[str], Optional[int]]:
  if servicio.id_tipo_servicio == 12:
    url = build_getcapabilities_url(servicio.direccion_web)
    resultado = probar_url(session, url, config)
    tmp_dir = root_dir / "tmp" / "wfs_getcapabilities"
    archivo = None
    if resultado.response and resultado.response.content:
      archivo = escribir_getcapabilities(tmp_dir, servicio, resultado.response.content)

    if archivo and archivo.exists():
      contenido = archivo.read_bytes()
      nombre_capa = extraer_nombre_capa_wfs(contenido)
      return True, nombre_capa, 200

    return False, None, resultado.status_code

  resultado = probar_url(session, servicio.direccion_web, config)
  estado_ok = bool(resultado.response) and (resultado.status_code or 0) < 400
  return estado_ok, None, resultado.status_code

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
      estado, nombre_capa, status_code = procesar_servicio(session, servicio, config)
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
      logging.info(
        "Log peticion | ID: %s | Capa: %s | URL: %s | Estado: %s",
        servicio.id,
        nombre_capa or servicio.nombre_capa or "N/D",
        servicio.direccion_web,
        clasificar_estado(status_code),
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
    "--contact-email",
    default="soporte@geoidep.local",
    help="Correo de contacto declarado en los encabezados para las peticiones.",
  )
  parser.add_argument(
    "--dry-run",
    action="store_true",
    help="Ejecuta la verificación sin guardar cambios en la base de datos.",
  )
  return parser.parse_args()

def main() -> None:
  args = parse_args()
  log_dir = Path(__file__).resolve().parent / "tmp" / "logs"
  log_dir.mkdir(parents=True, exist_ok=True)
  log_file = log_dir / "verificacion_servicios_geograficos.log"
  logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
      logging.StreamHandler(),
      logging.FileHandler(log_file, encoding="utf-8"),
    ],
  )

  config = RequestConfig(
    timeout=args.timeout,
    delay=args.delay,
    origin=args.origin,
    referer=args.referer,
    user_agent=args.user_agent,
    contact_email=args.contact_email,
  )
  actualizar_servicios(config, args.limite, args.dry_run)

if __name__ == "__main__":
  main()