import argparse
import asyncio
import json
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

from apps import create_app, db
from apps.models import ServicioGeografico

# ---------------------------------------------------------------------------
# Constantes de tipos de servicio
# ---------------------------------------------------------------------------
WMS_SERVICE_TYPE = 11
WFS_SERVICE_TYPE = 12
WMTS_SERVICE_TYPE = 13          # <-- Nuevo: soporte WMTS
ARCGIS_REST_SERVICE_TYPE = 17
ARCGIS_KML_SERVICE_TYPE = 20

OGC_SERVICE_TYPES = {WMS_SERVICE_TYPE, WFS_SERVICE_TYPE, WMTS_SERVICE_TYPE}

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/120.0 Safari/537.36"
    ),
    "Accept": "application/xml,text/xml,application/json,*/*;q=0.8",
    "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
    "Connection": "keep-alive",
}

# ---------------------------------------------------------------------------
# Dataclasses
# ---------------------------------------------------------------------------

@dataclass
class RequestConfig:
    timeout: float
    delay: float


@dataclass
class LayerInfo:
    """Información de capa extraída de un servicio."""
    name: str
    title: str


@dataclass
class ServiceResult:
    """Resultado del procesamiento de un servicio."""
    ok: bool
    layers: Optional[list[LayerInfo]]
    status_code: Optional[int]
    error_message: Optional[str] = None


# ---------------------------------------------------------------------------
# Logging: dos archivos separados (éxitos y errores)
# ---------------------------------------------------------------------------

def setup_logging(log_dir: Path) -> tuple[logging.Logger, logging.Logger]:
    """Configura dos loggers separados: uno para actualizaciones y otro para errores."""
    log_dir.mkdir(parents=True, exist_ok=True)

    formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")

    # --- Logger de actualizaciones exitosas ---
    success_logger = logging.getLogger("servicios.actualizado")
    success_logger.setLevel(logging.INFO)
    success_logger.propagate = False

    sh_success = logging.StreamHandler()
    sh_success.setLevel(logging.INFO)
    sh_success.setFormatter(formatter)
    success_logger.addHandler(sh_success)

    fh_success = logging.FileHandler(
        log_dir / "servicios_actualizados.log", encoding="utf-8"
    )
    fh_success.setLevel(logging.INFO)
    fh_success.setFormatter(formatter)
    success_logger.addHandler(fh_success)

    # --- Logger de errores ---
    error_logger = logging.getLogger("servicios.error")
    error_logger.setLevel(logging.WARNING)
    error_logger.propagate = False

    sh_error = logging.StreamHandler()
    sh_error.setLevel(logging.WARNING)
    sh_error.setFormatter(formatter)
    error_logger.addHandler(sh_error)

    fh_error = logging.FileHandler(
        log_dir / "servicios_errores.log", encoding="utf-8"
    )
    fh_error.setLevel(logging.WARNING)
    fh_error.setFormatter(formatter)
    error_logger.addHandler(fh_error)

    return success_logger, error_logger


# ---------------------------------------------------------------------------
# Construcción de URLs
# ---------------------------------------------------------------------------

def build_getcapabilities_url(base_url: str, service: str) -> str:
    """Construye la URL GetCapabilities para WMS / WFS / WMTS."""
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


def build_arcgis_rest_url(base_url: str) -> str:
    """Agrega ?f=pjson a una URL de ArcGIS REST si no lo tiene."""
    if not base_url:
        return base_url

    parsed = urlsplit(base_url)
    query_items = dict(parse_qsl(parsed.query, keep_blank_values=True))
    query_items["f"] = "pjson"
    new_query = urlencode(query_items)
    return urlunsplit(
        (parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment)
    )


def build_service_url(servicio: ServicioGeografico) -> str:
    """Devuelve la URL apropiada según el tipo de servicio."""
    if servicio.id_tipo_servicio == WFS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WFS")
    if servicio.id_tipo_servicio == WMS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMS")
    if servicio.id_tipo_servicio == WMTS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMTS")
    if servicio.id_tipo_servicio in {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}:
        return build_arcgis_rest_url(servicio.direccion_web)
    return servicio.direccion_web


# ---------------------------------------------------------------------------
# Extracción de capas OGC (WMS / WFS / WMTS)
# ---------------------------------------------------------------------------

def _xpath_layers(root, container_local: str, item_local: str) -> list[LayerInfo]:
    """Extrae Name y Title de nodos dentro de un contenedor XML OGC."""
    nodes = root.xpath(
        f"//*[local-name()='{container_local}']/*[local-name()='{item_local}']"
    )
    layers: list[LayerInfo] = []
    for node in nodes:
        name = node.xpath("string(./*[local-name()='Name'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if name or title:
            layers.append(LayerInfo(name=name, title=title))
    return layers


def extract_wfs_layers(xml_text: str) -> list[LayerInfo]:
    """Extrae FeatureType (Name, Title) del GetCapabilities WFS."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)
    return _xpath_layers(root, "FeatureTypeList", "FeatureType")


def extract_wms_layers(xml_text: str) -> list[LayerInfo]:
    """Extrae Layer (Name, Title) del GetCapabilities WMS."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    # WMS puede tener capas anidadas; extraemos todas las <Layer> que tengan <Name>
    nodes = root.xpath("//*[local-name()='Layer'][./*[local-name()='Name']]")
    layers: list[LayerInfo] = []
    for node in nodes:
        name = node.xpath("string(./*[local-name()='Name'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if name:
            layers.append(LayerInfo(name=name, title=title))
    return layers


def extract_wmts_layers(xml_text: str) -> list[LayerInfo]:
    """Extrae Layer (Identifier, Title) del GetCapabilities WMTS."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    # WMTS usa <ows:Identifier> en lugar de <Name>
    nodes = root.xpath(
        "//*[local-name()='Contents']/*[local-name()='Layer']"
    )
    layers: list[LayerInfo] = []
    for node in nodes:
        identifier = node.xpath("string(./*[local-name()='Identifier'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if identifier or title:
            layers.append(LayerInfo(name=identifier, title=title))
    return layers


# ---------------------------------------------------------------------------
# Extracción de capas ArcGIS REST
# ---------------------------------------------------------------------------

def extract_arcgis_rest_layers(json_text: str) -> list[LayerInfo]:
    """Extrae capas (id + name) del JSON de un MapServer / FeatureServer REST."""
    try:
        data = json.loads(json_text)
    except (json.JSONDecodeError, ValueError):
        return []

    layers: list[LayerInfo] = []

    # El JSON de un servicio REST contiene "layers" y opcionalmente "tables"
    for item in data.get("layers", []):
        layer_id = item.get("id", "")
        layer_name = item.get("name", "")
        if layer_name:
            layers.append(LayerInfo(name=str(layer_id), title=layer_name))

    return layers


# ---------------------------------------------------------------------------
# Petición HTTP con reintentos
# ---------------------------------------------------------------------------

async def fetch_with_retries(
    session: aiohttp.ClientSession,
    url: str,
    timeout: float,
    max_attempts: int = 3,
) -> tuple[str, str, Optional[int]]:
    """Realiza una petición GET con reintentos y backoff aleatorio."""
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


# ---------------------------------------------------------------------------
# Clasificación de estado
# ---------------------------------------------------------------------------

def clasificar_estado(status_code: Optional[int]) -> str:
    if status_code is None:
        return "sin_respuesta"
    return str(status_code)


# ---------------------------------------------------------------------------
# Procesamiento de un servicio individual
# ---------------------------------------------------------------------------

async def procesar_servicio(
    session: aiohttp.ClientSession,
    servicio: ServicioGeografico,
    config: RequestConfig,
) -> ServiceResult:
    """Procesa un servicio geográfico y devuelve el resultado."""
    url = build_service_url(servicio)

    try:
        body, content_type, status = await fetch_with_retries(
            session, url, config.timeout
        )
    except Exception as exc:
        return ServiceResult(
            ok=False, layers=None, status_code=None,
            error_message=f"Error de conexión: {exc}",
        )

    tipo = servicio.id_tipo_servicio

    # ---- WFS ----
    if tipo == WFS_SERVICE_TYPE:
        if "<WFS_Capabilities" not in body and "FeatureTypeList" not in body:
            return ServiceResult(
                ok=False, layers=None, status_code=status,
                error_message=(
                    f"Respuesta no parece WFS XML (Content-Type: {content_type})"
                ),
            )
        layers = extract_wfs_layers(body)
        ok = bool(layers) and (status is not None and status < 400)
        return ServiceResult(ok=ok, layers=layers or None, status_code=status)

    # ---- WMS ----
    if tipo == WMS_SERVICE_TYPE:
        if "<WMS_Capabilities" not in body and "<WMT_MS_Capabilities" not in body:
            return ServiceResult(
                ok=False, layers=None, status_code=status,
                error_message=(
                    f"Respuesta no parece WMS XML (Content-Type: {content_type})"
                ),
            )
        layers = extract_wms_layers(body)
        ok = bool(layers) and (status is not None and status < 400)
        return ServiceResult(ok=ok, layers=layers or None, status_code=status)

    # ---- WMTS ----
    if tipo == WMTS_SERVICE_TYPE:
        if "<Capabilities" not in body and "Contents" not in body:
            return ServiceResult(
                ok=False, layers=None, status_code=status,
                error_message=(
                    f"Respuesta no parece WMTS XML (Content-Type: {content_type})"
                ),
            )
        layers = extract_wmts_layers(body)
        ok = bool(layers) and (status is not None and status < 400)
        return ServiceResult(ok=ok, layers=layers or None, status_code=status)

    # ---- ArcGIS REST / KML ----
    if tipo in {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}:
        layers: list[LayerInfo] = []
        try:
            layers = extract_arcgis_rest_layers(body)
        except Exception:
            pass

        ok = status is not None and status < 400
        # Para REST verificamos también que no haya un error en el JSON
        if ok and body.strip().startswith("{"):
            try:
                data = json.loads(body)
                if "error" in data:
                    ok = False
                    err_msg = data["error"].get("message", "Error desconocido en REST")
                    return ServiceResult(
                        ok=False, layers=layers or None, status_code=status,
                        error_message=f"ArcGIS REST error: {err_msg}",
                    )
            except (json.JSONDecodeError, ValueError):
                pass

        return ServiceResult(ok=bool(ok), layers=layers or None, status_code=status)

    # ---- Otros tipos ----
    ok = status is not None and status < 400
    return ServiceResult(ok=bool(ok), layers=None, status_code=status)


# ---------------------------------------------------------------------------
# Actualización masiva de servicios
# ---------------------------------------------------------------------------

async def actualizar_servicios(
    config: RequestConfig,
    limite: Optional[int],
    dry_run: bool,
    log_dir: Path,
) -> None:
    success_log, error_log = setup_logging(log_dir)

    app = create_app()
    with app.app_context():
        query = ServicioGeografico.query.order_by(ServicioGeografico.id)
        if limite:
            query = query.limit(limite)

        servicios = query.all()

        if not servicios:
            success_log.info("No se encontraron servicios geográficos para verificar.")
            return

        total = len(servicios)
        ok_count = 0
        err_count = 0

        async with aiohttp.ClientSession(headers=HEADERS) as session:
            for idx, servicio in enumerate(servicios, start=1):
                estado_anterior = servicio.estado
                url = build_service_url(servicio)

                result = await procesar_servicio(session, servicio, config)

                # -- Actualizar estado --
                servicio.estado = result.ok

                # -- Actualizar nombre_capa y titulo_capa para OGC y REST --
                if result.layers:
                    first = result.layers[0]
                    servicio.nombre_capa = first.name
                    servicio.titulo_capa = first.title

                # -- Registro en el log correspondiente --
                if result.ok:
                    ok_count += 1
                    capas_str = (
                        ", ".join(f"{l.name} ({l.title})" for l in result.layers)
                        if result.layers
                        else servicio.nombre_capa or "N/D"
                    )
                    success_log.info(
                        "[%d/%d] OK | ID: %s | Tipo: %s | Estado: %s -> %s | "
                        "HTTP: %s | Capas: %s | URL: %s",
                        idx, total,
                        servicio.id,
                        servicio.id_tipo_servicio,
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(result.status_code),
                        capas_str,
                        servicio.direccion_web,
                    )
                else:
                    err_count += 1
                    error_log.warning(
                        "[%d/%d] ERROR | ID: %s | Tipo: %s | Estado: %s -> %s | "
                        "HTTP: %s | Motivo: %s | URL: %s",
                        idx, total,
                        servicio.id,
                        servicio.id_tipo_servicio,
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(result.status_code),
                        result.error_message or "HTTP >= 400 o sin respuesta",
                        servicio.direccion_web,
                    )

                if config.delay:
                    await asyncio.sleep(config.delay)

        # -- Resumen final --
        success_log.info(
            "Resumen: %d servicios procesados | %d OK | %d con error.",
            total, ok_count, err_count,
        )

        if dry_run:
            db.session.rollback()
            success_log.info(
                "Ejecución en modo simulación (--dry-run): no se guardaron cambios."
            )
            return

        db.session.commit()
        success_log.info("Actualización de servicios completada y guardada en BD.")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Verifica servicios geográficos (WMS, WFS, WMTS, ArcGIS REST) "
                    "y actualiza nombre_capa y titulo_capa.",
    )
    parser.add_argument(
        "--limite", type=int,
        help="Número máximo de registros a revisar.",
    )
    parser.add_argument(
        "--timeout", type=float, default=30.0,
        help="Tiempo de espera HTTP en segundos (default: 30).",
    )
    parser.add_argument(
        "--delay", type=float, default=0.5,
        help="Espera en segundos entre cada petición (default: 0.5).",
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Ejecuta la verificación sin guardar cambios en la base de datos.",
    )
    parser.add_argument(
        "--log-dir", type=str, default=None,
        help="Directorio para los archivos de log (default: ./tmp/logs).",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    if args.log_dir:
        log_dir = Path(args.log_dir)
    else:
        log_dir = Path(__file__).resolve().parent / "tmp" / "logs"

    config = RequestConfig(
        timeout=args.timeout,
        delay=args.delay,
    )
    asyncio.run(actualizar_servicios(config, args.limite, args.dry_run, log_dir))


if __name__ == "__main__":
    main()