import argparse
import asyncio
import json
import logging
import random
import sys
from dataclasses import dataclass
from difflib import SequenceMatcher
from pathlib import Path
from typing import Optional
from urllib.parse import parse_qsl, urlencode, urlsplit, urlunsplit

import aiohttp
from lxml import etree

root_dir = Path(__file__).resolve().parents[1]
if str(root_dir) not in sys.path:
    sys.path.insert(0, str(root_dir))

from app import create_app, db
from app.models import CapaGeografica, ServicioGeografico

# ---------------------------------------------------------------------------
# Constantes de tipos de servicio
# ---------------------------------------------------------------------------
WMS_SERVICE_TYPE = 11
WFS_SERVICE_TYPE = 12
WMTS_SERVICE_TYPE = 14
ARCGIS_REST_SERVICE_TYPE = 17
ARCGIS_KML_SERVICE_TYPE = 20

OGC_SERVICE_TYPES = {WMS_SERVICE_TYPE, WFS_SERVICE_TYPE, WMTS_SERVICE_TYPE}

FUZZY_THRESHOLD = 0.80  # Umbral mínimo de similitud (80%)

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
    """Capa extraída de un servicio (Name/Identifier y Title)."""

    name: str
    title: str


@dataclass
class FuzzyMatch:
    """Resultado del fuzzy matching entre el nombre de la capa geográfica
    y las capas disponibles en el servicio."""

    layer: LayerInfo
    score: float
    matched: bool  # True si score >= FUZZY_THRESHOLD


@dataclass
class CachedCapabilities:
    """Resultado cacheado de un GetCapabilities / REST ?f=pjson."""

    body: str
    content_type: str
    status: Optional[int]
    layers: list[LayerInfo]
    error_message: Optional[str] = None
    is_ok: bool = True


# ---------------------------------------------------------------------------
# Logging: dos archivos separados (actualizados y errores)
# ---------------------------------------------------------------------------


def setup_logging(log_dir: Path) -> tuple[logging.Logger, logging.Logger]:
    """Configura dos loggers independientes:
    - servicios.actualizado  →  servicios_actualizados.log
    - servicios.error        →  servicios_errores.log
    """
    log_dir.mkdir(parents=True, exist_ok=True)

    formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")

    # ── Logger de actualizaciones exitosas ──
    success_logger = logging.getLogger("servicios.actualizado")
    success_logger.setLevel(logging.INFO)
    success_logger.propagate = False
    if not success_logger.handlers:
        sh = logging.StreamHandler()
        sh.setLevel(logging.INFO)
        sh.setFormatter(formatter)
        success_logger.addHandler(sh)

        fh = logging.FileHandler(
            log_dir / "servicios_actualizados.log", encoding="utf-8"
        )
        fh.setLevel(logging.INFO)
        fh.setFormatter(formatter)
        success_logger.addHandler(fh)

    # ── Logger de errores ──
    error_logger = logging.getLogger("servicios.error")
    error_logger.setLevel(logging.WARNING)
    error_logger.propagate = False
    if not error_logger.handlers:
        sh = logging.StreamHandler()
        sh.setLevel(logging.WARNING)
        sh.setFormatter(formatter)
        error_logger.addHandler(sh)

        fh = logging.FileHandler(
            log_dir / "servicios_errores.log", encoding="utf-8"
        )
        fh.setLevel(logging.WARNING)
        fh.setFormatter(formatter)
        error_logger.addHandler(fh)

    return success_logger, error_logger


# ---------------------------------------------------------------------------
# Fuzzy matching
# ---------------------------------------------------------------------------


def _normalize(text: str) -> str:
    """Normaliza un texto para comparación: minúsculas, sin guiones bajos."""
    return text.lower().replace("_", " ").replace("-", " ").strip()


def fuzzy_match_layer(
    nombre_capa_geo: str,
    layers: list[LayerInfo],
    threshold: float = FUZZY_THRESHOLD,
) -> FuzzyMatch:
    """Encuentra la capa del servicio más similar al nombre de la
    CapaGeografica.

    Compara contra el Title y el Name de cada layer y se queda con el
    mejor score global.
    """
    if not layers:
        return FuzzyMatch(
            layer=LayerInfo(name="", title=""), score=0.0, matched=False
        )

    normed_ref = _normalize(nombre_capa_geo)
    best_score = 0.0
    best_layer = layers[0]

    for layer in layers:
        score_title = SequenceMatcher(
            None, normed_ref, _normalize(layer.title)
        ).ratio()
        score_name = SequenceMatcher(
            None, normed_ref, _normalize(layer.name)
        ).ratio()
        score = max(score_title, score_name)

        if score > best_score:
            best_score = score
            best_layer = layer

    return FuzzyMatch(
        layer=best_layer,
        score=round(best_score, 4),
        matched=best_score >= threshold,
    )


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
    """Agrega ?f=pjson a una URL de ArcGIS REST."""
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
    """Devuelve la URL adecuada según el tipo de servicio."""
    tipo = servicio.id_tipo
    if tipo == WFS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WFS")
    if tipo == WMS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMS")
    if tipo == WMTS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMTS")
    if tipo in {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}:
        return build_arcgis_rest_url(servicio.direccion_web)
    return servicio.direccion_web


# ---------------------------------------------------------------------------
# Extracción de capas OGC
# ---------------------------------------------------------------------------


def extract_wfs_layers(xml_text: str) -> list[LayerInfo]:
    """FeatureTypeList / FeatureType → Name + Title."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(
        xml_text.encode("utf-8", errors="ignore"), parser=parser
    )
    nodes = root.xpath(
        "//*[local-name()='FeatureTypeList']/*[local-name()='FeatureType']"
    )
    layers: list[LayerInfo] = []
    for node in nodes:
        name = node.xpath("string(./*[local-name()='Name'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if name or title:
            layers.append(LayerInfo(name=name, title=title))
    return layers


def extract_wms_layers(xml_text: str) -> list[LayerInfo]:
    """Capability / Layer (anidados) → Name + Title."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(
        xml_text.encode("utf-8", errors="ignore"), parser=parser
    )
    # Todas las <Layer> que tengan un <Name> hijo directo
    nodes = root.xpath("//*[local-name()='Layer'][./*[local-name()='Name']]")
    layers: list[LayerInfo] = []
    for node in nodes:
        name = node.xpath("string(./*[local-name()='Name'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if name:
            layers.append(LayerInfo(name=name, title=title))
    return layers


def extract_wmts_layers(xml_text: str) -> list[LayerInfo]:
    """Contents / Layer → ows:Identifier + ows:Title."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(
        xml_text.encode("utf-8", errors="ignore"), parser=parser
    )
    nodes = root.xpath(
        "//*[local-name()='Contents']/*[local-name()='Layer']"
    )
    layers: list[LayerInfo] = []
    for node in nodes:
        identifier = node.xpath(
            "string(./*[local-name()='Identifier'])"
        ).strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if identifier or title:
            layers.append(LayerInfo(name=identifier, title=title))
    return layers


# ---------------------------------------------------------------------------
# Extracción de capas ArcGIS REST (JSON)
# ---------------------------------------------------------------------------


def extract_arcgis_rest_layers(json_text: str) -> list[LayerInfo]:
    """Parsea ?f=pjson de un MapServer / FeatureServer."""
    try:
        data = json.loads(json_text)
    except (json.JSONDecodeError, ValueError):
        return []

    layers: list[LayerInfo] = []
    for item in data.get("layers", []):
        layer_id = item.get("id", "")
        layer_name = item.get("name", "")
        if layer_name:
            layers.append(LayerInfo(name=str(layer_id), title=layer_name))
    return layers


def check_arcgis_rest_error(json_text: str) -> Optional[str]:
    """Detecta un bloque 'error' en la respuesta JSON de ArcGIS REST."""
    try:
        data = json.loads(json_text)
        if "error" in data:
            code = data["error"].get("code", "")
            msg = data["error"].get("message", "Error desconocido")
            return f"ArcGIS REST error {code}: {msg}"
    except (json.JSONDecodeError, ValueError):
        return "Respuesta no es JSON válido para ArcGIS REST"
    return None


# ---------------------------------------------------------------------------
# Petición HTTP con reintentos
# ---------------------------------------------------------------------------


async def fetch_with_retries(
    session: aiohttp.ClientSession,
    url: str,
    timeout: float,
    max_attempts: int = 3,
) -> tuple[str, str, Optional[int]]:
    """GET con reintentos y backoff aleatorio."""
    client_timeout = aiohttp.ClientTimeout(
        total=timeout, connect=10, sock_read=20
    )
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
                return (
                    text,
                    response.headers.get("Content-Type", ""),
                    response.status,
                )
        except Exception as exc:
            last_error = exc
            await asyncio.sleep((0.7 * attempt) + random.random())

    if last_error:
        raise last_error
    raise RuntimeError("No se pudo completar la petición HTTP.")


# ---------------------------------------------------------------------------
# Clasificación de estado HTTP
# ---------------------------------------------------------------------------


def clasificar_estado(status_code: Optional[int]) -> str:
    if status_code is None:
        return "sin_respuesta"
    return str(status_code)


# ---------------------------------------------------------------------------
# Caché de GetCapabilities / REST por URL
# ---------------------------------------------------------------------------


async def fetch_and_cache(
    session: aiohttp.ClientSession,
    url: str,
    tipo: int,
    config: RequestConfig,
    cache: dict[str, CachedCapabilities],
) -> CachedCapabilities:
    """Obtiene las capas de una URL; si ya se consultó, devuelve caché.

    Esto evita hacer múltiples GetCapabilities a la misma URL cuando
    varias filas de ServicioGeografico apuntan al mismo endpoint.
    """
    if url in cache:
        return cache[url]

    # ── Petición HTTP ──
    try:
        body, content_type, status = await fetch_with_retries(
            session, url, config.timeout
        )
    except Exception as exc:
        cached = CachedCapabilities(
            body="",
            content_type="",
            status=None,
            layers=[],
            error_message=f"Error de conexión: {exc}",
            is_ok=False,
        )
        cache[url] = cached
        return cached

    layers: list[LayerInfo] = []
    error_message: Optional[str] = None
    is_ok = status is not None and status < 400

    # ── Parseo según tipo de servicio ──
    if tipo == WFS_SERVICE_TYPE:
        if "<WFS_Capabilities" not in body and "FeatureTypeList" not in body:
            error_message = (
                f"Respuesta no parece WFS XML (Content-Type: {content_type})"
            )
            is_ok = False
        else:
            layers = extract_wfs_layers(body)

    elif tipo == WMS_SERVICE_TYPE:
        if (
            "<WMS_Capabilities" not in body
            and "<WMT_MS_Capabilities" not in body
        ):
            error_message = (
                f"Respuesta no parece WMS XML (Content-Type: {content_type})"
            )
            is_ok = False
        else:
            layers = extract_wms_layers(body)

    elif tipo == WMTS_SERVICE_TYPE:
        if "<Capabilities" not in body and "Contents" not in body:
            error_message = (
                f"Respuesta no parece WMTS XML (Content-Type: {content_type})"
            )
            is_ok = False
        else:
            layers = extract_wmts_layers(body)

    elif tipo in {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}:
        rest_err = check_arcgis_rest_error(body)
        if rest_err:
            error_message = rest_err
            is_ok = False
        else:
            layers = extract_arcgis_rest_layers(body)

    if is_ok and not layers:
        error_message = "Servicio respondió OK pero no se encontraron capas."

    cached = CachedCapabilities(
        body=body,
        content_type=content_type,
        status=status,
        layers=layers,
        error_message=error_message,
        is_ok=is_ok,
    )
    cache[url] = cached

    # Delay solo cuando se hace petición real (no caché)
    if config.delay:
        await asyncio.sleep(config.delay)

    return cached


# ---------------------------------------------------------------------------
# Actualización masiva
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

        servicios: list[ServicioGeografico] = query.all()

        if not servicios:
            success_log.info(
                "No se encontraron servicios geográficos para verificar."
            )
            return

        # ── Pre-cargar nombres de CapaGeografica ──
        ids_capa = {s.id_capa for s in servicios if s.id_capa}
        capas_geo: dict[int, str] = {}
        if ids_capa:
            capas = (
                CapaGeografica.query.filter(CapaGeografica.id.in_(ids_capa)).all()
            )
            capas_geo = {c.id: c.nombre for c in capas if c.nombre}

        success_log.info(
            "Iniciando verificación: %d servicios | %d capas geográficas cargadas.",
            len(servicios),
            len(capas_geo),
        )

        total = len(servicios)
        ok_count = 0
        err_count = 0
        match_count = 0
        no_match_count = 0
        direct_count = 0      # Asignación directa (capa única)
        no_layers_count = 0   # Servicios OK sin capas

        url_cache: dict[str, CachedCapabilities] = {}

        async with aiohttp.ClientSession(headers=HEADERS) as session:
            for idx, servicio in enumerate(servicios, start=1):
                estado_anterior = servicio.estado
                nombre_capa_anterior = servicio.nombre_capa
                titulo_capa_anterior = servicio.titulo_capa

                url = build_service_url(servicio)
                nombre_capa_geo = capas_geo.get(servicio.id_capa, "")

                # ── Consultar servicio (con caché) ──
                cached = await fetch_and_cache(
                    session,
                    url,
                    servicio.id_tipo,
                    config,
                    url_cache,
                )

                # ── Actualizar estado ──
                servicio.estado = cached.is_ok

                # ── Etiqueta legible del tipo ──
                tipo_label = {
                    WMS_SERVICE_TYPE: "WMS",
                    WFS_SERVICE_TYPE: "WFS",
                    WMTS_SERVICE_TYPE: "WMTS",
                    ARCGIS_REST_SERVICE_TYPE: "REST",
                    ARCGIS_KML_SERVICE_TYPE: "KML",
                }.get(servicio.id_tipo, str(servicio.id_tipo))

                num_layers = len(cached.layers)
                es_tipo_con_capas = servicio.id_tipo in (
                    OGC_SERVICE_TYPES
                    | {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}
                )

                # ── Lógica de asignación de nombre_capa / titulo_capa ──
                best_match: Optional[FuzzyMatch] = None
                match_info = ""

                if not cached.is_ok:
                    # Servicio con error HTTP / conexión → no tocar capas
                    match_info = "N/A (servicio con error)"

                elif es_tipo_con_capas and num_layers == 0:
                    # Servicio OK pero sin capas → reportar como error
                    err_count += 1
                    no_layers_count += 1
                    error_log.warning(
                        "[%d/%d] SIN CAPAS | ID: %s | Tipo: %s | id_capa: %s | "
                        "CapaGeo: '%s' | Estado: %s → %s | HTTP: %s | "
                        "Motivo: Servicio respondió OK pero no expone "
                        "ninguna capa | URL: %s",
                        idx,
                        total,
                        servicio.id,
                        tipo_label,
                        servicio.id_capa,
                        nombre_capa_geo or "(sin nombre)",
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(cached.status),
                        servicio.direccion_web,
                    )
                    # Continuar al siguiente servicio (ya se logueó como error)
                    if config.delay:
                        await asyncio.sleep(config.delay)
                    continue

                elif num_layers == 1:
                    # ── UNA SOLA CAPA → asignar directamente sin fuzzy ──
                    unica = cached.layers[0]
                    servicio.nombre_capa = unica.name
                    servicio.titulo_capa = unica.title
                    direct_count += 1
                    match_info = (
                        f"ASIGNACIÓN DIRECTA (capa única) "
                        f"name='{unica.name}' title='{unica.title}'"
                    )

                elif num_layers > 1 and nombre_capa_geo:
                    # ── VARIAS CAPAS → fuzzy match con CapaGeografica.nombre ──
                    best_match = fuzzy_match_layer(
                        nombre_capa_geo, cached.layers
                    )
                    if best_match.matched:
                        servicio.nombre_capa = best_match.layer.name
                        servicio.titulo_capa = best_match.layer.title
                        match_count += 1
                        match_info = (
                            f"MATCH FUZZY name='{best_match.layer.name}' "
                            f"title='{best_match.layer.title}' "
                            f"(score={best_match.score:.0%})"
                        )
                    else:
                        no_match_count += 1
                        match_info = (
                            f"SIN MATCH (mejor: name='{best_match.layer.name}' "
                            f"title='{best_match.layer.title}' "
                            f"score={best_match.score:.0%} "
                            f"< umbral {FUZZY_THRESHOLD:.0%})"
                        )

                elif num_layers > 1 and not nombre_capa_geo:
                    # Varias capas pero no hay nombre de CapaGeografica para comparar
                    no_match_count += 1
                    match_info = (
                        f"SIN MATCH (servicio tiene {num_layers} capas "
                        f"pero CapaGeografica no tiene nombre para comparar)"
                    )

                else:
                    match_info = "N/A (tipo de servicio sin capas esperadas)"

                # ── Escribir en el log correspondiente ──
                if cached.is_ok:
                    ok_count += 1
                    success_log.info(
                        "[%d/%d] OK | ID: %s | Tipo: %s | id_capa: %s | "
                        "CapaGeo: '%s' | Estado: %s → %s | HTTP: %s | "
                        "nombre_capa: '%s' → '%s' | "
                        "titulo_capa: '%s' → '%s' | "
                        "%s | Capas disponibles: %d | URL: %s",
                        idx,
                        total,
                        servicio.id,
                        tipo_label,
                        servicio.id_capa,
                        nombre_capa_geo or "(sin nombre)",
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(cached.status),
                        nombre_capa_anterior or "",
                        servicio.nombre_capa or "",
                        titulo_capa_anterior or "",
                        servicio.titulo_capa or "",
                        match_info,
                        num_layers,
                        servicio.direccion_web,
                    )
                else:
                    err_count += 1
                    error_log.warning(
                        "[%d/%d] ERROR | ID: %s | Tipo: %s | id_capa: %s | "
                        "CapaGeo: '%s' | Estado: %s → %s | HTTP: %s | "
                        "Motivo: %s | URL: %s",
                        idx,
                        total,
                        servicio.id,
                        tipo_label,
                        servicio.id_capa,
                        nombre_capa_geo or "(sin nombre)",
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(cached.status),
                        cached.error_message or "HTTP >= 400 o sin respuesta",
                        servicio.direccion_web,
                    )

        # ── Resumen final ──
        sep = "=" * 72
        success_log.info(sep)
        success_log.info("RESUMEN DE VERIFICACIÓN")
        success_log.info(sep)
        success_log.info("  Total servicios procesados     : %d", total)
        success_log.info("  Servicios OK                   : %d", ok_count)
        success_log.info("  Servicios con error            : %d", err_count)
        success_log.info("  Servicios OK sin capas         : %d", no_layers_count)
        success_log.info(
            "  Asignación directa (1 capa)    : %d", direct_count
        )
        success_log.info(
            "  Match fuzzy exitoso (≥%s)     : %d",
            f"{FUZZY_THRESHOLD:.0%}",
            match_count,
        )
        success_log.info("  Sin match suficiente           : %d", no_match_count)
        success_log.info("  URLs únicas consultadas        : %d", len(url_cache))
        success_log.info(sep)

        if err_count:
            error_log.warning(
                "Se registraron %d errores. Revisar: %s",
                err_count,
                log_dir / "servicios_errores.log",
            )

        if dry_run:
            db.session.rollback()
            success_log.info(
                "Ejecución en modo simulación (--dry-run): "
                "NO se guardaron cambios en BD."
            )
            return

        db.session.commit()
        success_log.info("Actualización completada y guardada en BD.")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Verifica servicios geográficos (WMS, WFS, WMTS, ArcGIS REST) "
            "y actualiza nombre_capa y titulo_capa mediante fuzzy matching "
            "con el nombre de la CapaGeografica asociada."
        ),
    )
    parser.add_argument(
        "--limite",
        type=int,
        help="Número máximo de registros a revisar.",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=30.0,
        help="Tiempo de espera HTTP en segundos (default: 30).",
    )
    parser.add_argument(
        "--delay",
        type=float,
        default=0.5,
        help="Espera en segundos entre cada petición nueva (default: 0.5).",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Ejecuta la verificación sin guardar cambios en la base de datos.",
    )
    parser.add_argument(
        "--log-dir",
        type=str,
        default=None,
        help="Directorio para archivos de log (default: ./tmp/logs).",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    log_dir = (
        Path(args.log_dir)
        if args.log_dir
        else Path(__file__).resolve().parent / "tmp" / "logs"
    )

    config = RequestConfig(timeout=args.timeout, delay=args.delay)
    asyncio.run(
        actualizar_servicios(config, args.limite, args.dry_run, log_dir)
    )


if __name__ == "__main__":
    main()
