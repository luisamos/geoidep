import argparse
import asyncio
import logging
import random
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Optional
from urllib.parse import parse_qsl, urlencode, urlsplit, urlunsplit

import aiohttp
from lxml import etree

root_dir = Path(__file__).resolve().parents[1]
if str(root_dir) not in sys.path:
    sys.path.insert(0, str(root_dir))

from app import create_app, db
from app.models import ServicioGeografico

WMS_SERVICE_TYPE = 11
WFS_SERVICE_TYPE = 12
ARCGIS_REST_SERVICE_TYPE = 17
ARCGIS_KML_SERVICE_TYPE = 20

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/120.0 Safari/537.36"
    ),
    "Accept": "application/xml,text/xml,*/*;q=0.8",
    "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
    "Connection": "keep-alive",
}


@dataclass
class RequestConfig:
    timeout: float
    delay: float


def build_getcapabilities_url(base_url: str, service: str) -> str:
    if not base_url:
        return base_url

    parsed = urlsplit(base_url)
    query_items = dict(parse_qsl(parsed.query, keep_blank_values=True))
    if query_items.get("request", "").lower() == "getcapabilities" and query_items.get(
        "service", ""
    ).lower() == service.lower():
        return base_url

    query_items.setdefault("service", service)
    query_items["request"] = "GetCapabilities"
    new_query = urlencode(query_items)
    return urlunsplit((parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment))


def extract_featuretypes(xml_text: str) -> list[str]:
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    nodes = root.xpath("//*[local-name()='FeatureTypeList']/*[local-name()='FeatureType']")
    names = []
    for feature in nodes:
        name = feature.xpath("string(./*[local-name()='Name'])").strip()
        if name:
            names.append(name)
    return names


async def fetch_with_retries(
    session: aiohttp.ClientSession,
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
                headers=HEADERS,
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


def clasificar_estado(status_code: Optional[int]) -> str:
    if status_code is None:
        return "sin_respuesta"
    return str(status_code)


def build_service_url(servicio: ServicioGeografico) -> str:
    if servicio.id_tipo == WFS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WFS")
    if servicio.id_tipo == WMS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMS")
    return servicio.direccion_web


async def procesar_servicio(
    session: aiohttp.ClientSession,
    servicio: ServicioGeografico,
    config: RequestConfig,
) -> tuple[bool, Optional[list[str]], Optional[int]]:
    url = build_service_url(servicio)
    try:
        xml_text, content_type, status = await fetch_with_retries(
            session, url, config.timeout
        )
    except Exception as exc:
        logging.warning("Fallo servicio %s -> %s", url, exc)
        return False, None, None

    if servicio.id_tipo == WFS_SERVICE_TYPE:
        if "<WFS_Capabilities" not in xml_text and "FeatureTypeList" not in xml_text:
            logging.warning(
                "Respuesta no parece WFS XML en %s (Content-Type: %s)",
                url,
                content_type,
            )
            logging.debug("Contenido parcial: %s", xml_text[:300])
            return False, None, status

        layers = extract_featuretypes(xml_text)
        estado_ok = bool(layers) and (status is not None and status < 400)
        return estado_ok, layers or None, status

    if servicio.id_tipo in {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}:
        estado_ok = bool(status is not None and status < 400)
        return estado_ok, None, status

    estado_ok = bool(status is not None and status < 400)
    return estado_ok, None, status


async def actualizar_servicios(
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

        async with aiohttp.ClientSession(headers=HEADERS) as session:
            for servicio in servicios:
                estado_anterior = servicio.estado
                url = build_service_url(servicio)
                estado, layers, status_code = await procesar_servicio(
                    session, servicio, config
                )
                servicio.estado = bool(estado)

                if servicio.id_tipo == WFS_SERVICE_TYPE and layers:
                    servicio.nombre_capa = layers[0]

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
                    ", ".join(layers or [servicio.nombre_capa or "N/D"]),
                    url,
                    clasificar_estado(status_code),
                )

                if config.delay:
                    await asyncio.sleep(config.delay)

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
    parser.add_argument("--timeout", type=float, default=30.0, help="Tiempo de espera HTTP.")
    parser.add_argument(
        "--delay",
        type=float,
        default=0.5,
        help="Espera en segundos entre cada petición.",
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
    )
    asyncio.run(actualizar_servicios(config, args.limite, args.dry_run))

if __name__ == "__main__":
    main()