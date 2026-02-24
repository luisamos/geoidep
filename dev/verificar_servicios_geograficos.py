import argparse
import asyncio
import json
import logging
import re
import ssl
import sys
import time
from dataclasses import dataclass, field
from difflib import SequenceMatcher
from pathlib import Path
from typing import Optional
from urllib.parse import parse_qsl, urlencode, urlsplit, urlunsplit

import httpx
from lxml import etree

root_dir = Path(__file__).resolve().parents[1]
if str(root_dir) not in sys.path:
    sys.path.insert(0, str(root_dir))

from apps import create_app, db
from apps.models import CapaGeografica, ServicioGeografico

# ═══════════════════════════════════════════════════════════════════════════
# Constantes
# ═══════════════════════════════════════════════════════════════════════════
WMS_SERVICE_TYPE = 11
WFS_SERVICE_TYPE = 12
WMTS_SERVICE_TYPE = 14
ARCGIS_REST_SERVICE_TYPE = 17
ARCGIS_KML_SERVICE_TYPE = 20

OGC_SERVICE_TYPES = {WMS_SERVICE_TYPE, WFS_SERVICE_TYPE, WMTS_SERVICE_TYPE}
REST_SERVICE_TYPES = {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}
ALL_LAYER_TYPES = OGC_SERVICE_TYPES | REST_SERVICE_TYPES

FUZZY_THRESHOLD = 0.80

# Ruta al CA-bundle para dominios con certificado propio (p.ej. *.geoidep.gob.pe)
# Si no existe, se usa verificación estándar del sistema.
CA_BUNDLE_PATH = Path(__file__).resolve().parent / "STAR_geoidep_gob_pe.ca-bundle"

# Regex para detectar /MapServer/N o /FeatureServer/N (capa individual)
_RE_REST_LAYER_NUM = re.compile(
    r"(/(Map|Feature)Server)/\d+\s*$", re.IGNORECASE
)

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


# ═══════════════════════════════════════════════════════════════════════════
# Dataclasses
# ═══════════════════════════════════════════════════════════════════════════


@dataclass
class RequestConfig:
    timeout_connect: float = 10.0
    timeout_read: float = 25.0
    max_attempts: int = 3
    delay: float = 0.3
    concurrency: int = 20


@dataclass
class LayerInfo:
    """Capa extraída de un servicio."""

    name: str
    title: str


@dataclass
class FuzzyMatch:
    """Resultado del fuzzy matching."""

    layer: LayerInfo
    score: float
    matched: bool


@dataclass
class CachedCapabilities:
    """Resultado cacheado de una petición GetCapabilities / REST."""

    status: Optional[int]
    layers: list[LayerInfo]
    error_message: Optional[str] = None
    is_ok: bool = True
    latency_ms: float = 0.0


# ═══════════════════════════════════════════════════════════════════════════
# Logging: servicios_actualizados.log + servicios_errores.log
# ═══════════════════════════════════════════════════════════════════════════


def setup_logging(log_dir: Path) -> tuple[logging.Logger, logging.Logger]:
    log_dir.mkdir(parents=True, exist_ok=True)
    fmt = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")

    def _make(name: str, filename: str, level: int) -> logging.Logger:
        lg = logging.getLogger(name)
        lg.setLevel(level)
        lg.propagate = False
        if not lg.handlers:
            sh = logging.StreamHandler()
            sh.setLevel(level)
            sh.setFormatter(fmt)
            lg.addHandler(sh)
            fh = logging.FileHandler(log_dir / filename, encoding="utf-8")
            fh.setLevel(level)
            fh.setFormatter(fmt)
            lg.addHandler(fh)
        return lg

    return (
        _make("servicios.ok", "servicios_actualizados.log", logging.INFO),
        _make("servicios.error", "servicios_errores.log", logging.WARNING),
    )


# ═══════════════════════════════════════════════════════════════════════════
# Fuzzy matching
# ═══════════════════════════════════════════════════════════════════════════


def _normalize(text: str) -> str:
    return text.lower().replace("_", " ").replace("-", " ").strip()


def fuzzy_match_layer(
    nombre_capa_geo: str,
    layers: list[LayerInfo],
    threshold: float = FUZZY_THRESHOLD,
) -> FuzzyMatch:
    if not layers:
        return FuzzyMatch(LayerInfo("", ""), 0.0, False)

    ref = _normalize(nombre_capa_geo)
    best_score = 0.0
    best_layer = layers[0]

    for layer in layers:
        s = max(
            SequenceMatcher(None, ref, _normalize(layer.title)).ratio(),
            SequenceMatcher(None, ref, _normalize(layer.name)).ratio(),
        )
        if s > best_score:
            best_score = s
            best_layer = layer

    return FuzzyMatch(best_layer, round(best_score, 4), best_score >= threshold)


# ═══════════════════════════════════════════════════════════════════════════
# Detección del tipo REAL de servicio por URL
# ═══════════════════════════════════════════════════════════════════════════


def detectar_tipo_real_url(url: str, id_tipo_servicio: int) -> int:
    """Analiza la URL para determinar el tipo real (WMS/WFS/WMTS/REST).

    Prioridad: lo que dice la URL > lo que dice la BD.
    """
    if not url:
        return id_tipo_servicio

    low = url.lower()
    path_low = urlsplit(low).path
    query_low = urlsplit(low).query

    # Path del servidor ArcGIS
    if "wmsserver" in path_low:
        return WMS_SERVICE_TYPE
    if "wfsserver" in path_low:
        return WFS_SERVICE_TYPE
    if "wmtsserver" in path_low:
        return WMTS_SERVICE_TYPE

    # Parámetro ?service=
    qs = dict(parse_qsl(query_low, keep_blank_values=True))
    sp = qs.get("service", "")
    if sp == "wms":
        return WMS_SERVICE_TYPE
    if sp == "wfs":
        return WFS_SERVICE_TYPE
    if sp == "wmts":
        return WMTS_SERVICE_TYPE

    # ArcGIS REST puro (sin endpoint OGC)
    if "/rest/services/" in path_low or (
        "/mapserver" in path_low
        and "wmsserver" not in path_low
        and "wfsserver" not in path_low
        and "wmtsserver" not in path_low
    ):
        return ARCGIS_REST_SERVICE_TYPE
    if "/featureserver" in path_low:
        return ARCGIS_REST_SERVICE_TYPE

    # GeoServer genérico
    if "/wms" in path_low and "/wmts" not in path_low:
        return WMS_SERVICE_TYPE
    if "/wfs" in path_low:
        return WFS_SERVICE_TYPE
    if "/wmts" in path_low:
        return WMTS_SERVICE_TYPE

    return id_tipo_servicio


# ═══════════════════════════════════════════════════════════════════════════
# Normalización de URLs
# ═══════════════════════════════════════════════════════════════════════════


def _strip_rest_layer_number(url: str) -> str:
    """Retrocede /MapServer/N → /MapServer y /FeatureServer/N → /FeatureServer.

    Esto asegura que la petición REST obtenga el listado completo de capas
    en lugar de la metadata de una sola capa.
    Ejemplo:
        .../MTC_Puentes_T/MapServer/1  → .../MTC_Puentes_T/MapServer
        .../OTASS_EPS_1/FeatureServer/2 → .../OTASS_EPS_1/FeatureServer
    """
    parsed = urlsplit(url)
    new_path = _RE_REST_LAYER_NUM.sub(r"\1", parsed.path)
    return urlunsplit(
        (parsed.scheme, parsed.netloc, new_path, parsed.query, parsed.fragment)
    )


def build_getcapabilities_url(base_url: str, service: str) -> str:
    if not base_url:
        return base_url

    parsed = urlsplit(base_url)
    qi = dict(parse_qsl(parsed.query, keep_blank_values=True))

    if (
        qi.get("request", "").lower() == "getcapabilities"
        and qi.get("service", "").lower() == service.lower()
    ):
        return base_url

    qi.setdefault("service", service)
    qi["request"] = "GetCapabilities"
    return urlunsplit(
        (parsed.scheme, parsed.netloc, parsed.path, urlencode(qi), parsed.fragment)
    )


def build_arcgis_rest_url(base_url: str) -> str:
    """Normaliza una URL REST: quita /N de la capa y agrega ?f=pjson."""
    if not base_url:
        return base_url

    # Paso 1: retroceder /MapServer/N → /MapServer
    clean = _strip_rest_layer_number(base_url)

    parsed = urlsplit(clean)
    qi = dict(parse_qsl(parsed.query, keep_blank_values=True))
    qi["f"] = "pjson"
    return urlunsplit(
        (parsed.scheme, parsed.netloc, parsed.path, urlencode(qi), parsed.fragment)
    )


def build_service_url(servicio: ServicioGeografico) -> str:
    tipo = detectar_tipo_real_url(
        servicio.direccion_web, servicio.id_tipo_servicio
    )
    if tipo == WFS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WFS")
    if tipo == WMS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMS")
    if tipo == WMTS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMTS")
    if tipo in REST_SERVICE_TYPES:
        return build_arcgis_rest_url(servicio.direccion_web)
    return servicio.direccion_web


# ═══════════════════════════════════════════════════════════════════════════
# Extracción de capas OGC
# ═══════════════════════════════════════════════════════════════════════════

# Regex para extraer workspace/layer de URLs GeoServer
# Patrones soportados:
#   /geoserver/{workspace}/{layer}/ows
#   /geoserver/{workspace}/{layer}/wms
#   /geoserver/{workspace}/{layer}/wfs
#   /geoserver/{workspace}/ows   (solo workspace)
#   /geoserver/{workspace}/wms
_RE_GEOSERVER_LAYER = re.compile(
    r"/geoserver/([^/]+)/([^/]+)/(?:ows|wms|wfs|wmts)",
    re.IGNORECASE,
)
_RE_GEOSERVER_WS_ONLY = re.compile(
    r"/geoserver/([^/]+)/(?:ows|wms|wfs|wmts)",
    re.IGNORECASE,
)


def _extract_layer_from_geoserver_url(url: str) -> Optional[LayerInfo]:
    """Extrae workspace:layer de una URL GeoServer.

    Ejemplo:
        /geoserver/g_04_06/04_06_003_03_001_531_0000_00_00/ows
        → LayerInfo(name='g_04_06:04_06_003_03_001_531_0000_00_00',
                    title='04_06_003_03_001_531_0000_00_00')
    """
    path = urlsplit(url).path

    m = _RE_GEOSERVER_LAYER.search(path)
    if m:
        workspace = m.group(1)
        layer = m.group(2)
        return LayerInfo(
            name=f"{workspace}:{layer}",
            title=layer,
        )

    m = _RE_GEOSERVER_WS_ONLY.search(path)
    if m:
        workspace = m.group(1)
        return LayerInfo(name=workspace, title=workspace)

    return None


def _extract_layer_from_wms_root(
    xml_text: str, url: str
) -> list[LayerInfo]:
    """Fallback para WMS: si el XML tiene un <Layer> raíz con Title y
    BoundingBox pero sin <Name> (típico de GeoServer con workspace/layer
    en la URL), intenta extraer el nombre de la capa desde la URL.
    """
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(
        xml_text.encode("utf-8", errors="ignore"), parser=parser
    )

    # Verificar que hay al menos un <Layer> con BoundingBox (servicio válido)
    has_layer_with_bbox = root.xpath(
        "//*[local-name()='Layer']"
        "[./*[local-name()='EX_GeographicBoundingBox'] "
        "or ./*[local-name()='BoundingBox']]"
    )
    if not has_layer_with_bbox:
        return []

    # Intentar extraer el Title del Layer raíz (puede ser genérico)
    root_layer = root.xpath("//*[local-name()='Capability']/*[local-name()='Layer']")
    root_title = ""
    if root_layer:
        root_title = root_layer[0].xpath(
            "string(./*[local-name()='Title'])"
        ).strip()

    # Extraer nombre desde la URL
    url_layer = _extract_layer_from_geoserver_url(url)
    if url_layer:
        # Si el Title del XML es genérico, usar el de la URL
        if root_title and root_title not in (
            "GeoServer Web Map Service",
            "WMS",
            "Layers",
            "",
        ):
            url_layer.title = root_title
        return [url_layer]

    # Si no es GeoServer pero hay un Layer raíz con Title útil
    if root_title and root_title not in (
        "GeoServer Web Map Service",
        "WMS",
        "Layers",
        "",
    ):
        return [LayerInfo(name=root_title, title=root_title)]

    return []


def extract_wms_layers(xml_text: str, url: str = "") -> list[LayerInfo]:
    """Extrae capas WMS. Si no encuentra <Layer> con <Name>, intenta
    extraer la capa desde la URL (fallback GeoServer)."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)
    layers: list[LayerInfo] = []
    for node in root.xpath("//*[local-name()='Layer'][./*[local-name()='Name']]"):
        name = node.xpath("string(./*[local-name()='Name'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if name:
            layers.append(LayerInfo(name=name, title=title))

    # Fallback: Layer raíz sin <Name> (GeoServer workspace/layer en URL)
    if not layers and url:
        layers = _extract_layer_from_wms_root(xml_text, url)

    return layers


def extract_wfs_layers(xml_text: str, url: str = "") -> list[LayerInfo]:
    """Extrae capas WFS. Fallback desde URL si FeatureTypeList está vacío."""
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)
    layers: list[LayerInfo] = []
    for node in root.xpath(
        "//*[local-name()='FeatureTypeList']/*[local-name()='FeatureType']"
    ):
        name = node.xpath("string(./*[local-name()='Name'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if name or title:
            layers.append(LayerInfo(name=name, title=title))

    # Fallback: GeoServer con workspace/layer en la URL
    if not layers and url:
        url_layer = _extract_layer_from_geoserver_url(url)
        if url_layer:
            layers = [url_layer]

    return layers


def extract_wmts_layers(xml_text: str) -> list[LayerInfo]:
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)
    layers: list[LayerInfo] = []
    for node in root.xpath("//*[local-name()='Contents']/*[local-name()='Layer']"):
        ident = node.xpath("string(./*[local-name()='Identifier'])").strip()
        title = node.xpath("string(./*[local-name()='Title'])").strip()
        if ident or title:
            layers.append(LayerInfo(name=ident, title=title))
    return layers


# ═══════════════════════════════════════════════════════════════════════════
# Extracción de capas ArcGIS REST
# ═══════════════════════════════════════════════════════════════════════════


def extract_arcgis_rest_layers(json_text: str) -> list[LayerInfo]:
    try:
        data = json.loads(json_text)
    except (json.JSONDecodeError, ValueError):
        return []
    layers: list[LayerInfo] = []
    for item in data.get("layers", []):
        lid = item.get("id", "")
        name = item.get("name", "")
        if name:
            layers.append(LayerInfo(name=str(lid), title=name))
    return layers


def check_arcgis_rest_error(json_text: str) -> Optional[str]:
    try:
        data = json.loads(json_text)
        if "error" in data:
            code = data["error"].get("code", "")
            msg = data["error"].get("message", "Error desconocido")
            return f"ArcGIS REST error {code}: {msg}"
    except (json.JSONDecodeError, ValueError):
        return "Respuesta no es JSON válido para ArcGIS REST"
    return None


# ═══════════════════════════════════════════════════════════════════════════
# Cliente HTTP: httpx con CA-bundle + fallback SSL
# ═══════════════════════════════════════════════════════════════════════════


def _build_ssl_context() -> ssl.SSLContext:
    """Construye un SSLContext que carga el CA-bundle si existe."""
    ctx = ssl.create_default_context()
    if CA_BUNDLE_PATH.exists():
        ctx.load_verify_locations(str(CA_BUNDLE_PATH))
    return ctx


async def fetch_with_retries(
    client_secure: httpx.AsyncClient,
    client_insecure: httpx.AsyncClient,
    url: str,
    cfg: RequestConfig,
) -> tuple[Optional[str], Optional[int], Optional[str], float]:
    """Petición GET con reintentos.

    Estrategia en 2 fases:
      1. Intentar con verificación SSL (CA-bundle).
      2. Si falla por SSL, reintentar sin verificación (verify=False).

    Retorna: (body, status_code, error_message, latency_ms)
    """
    timeout = httpx.Timeout(
        connect=cfg.timeout_connect,
        read=cfg.timeout_read,
        write=10.0,
        pool=5.0,
    )

    last_error: Optional[str] = None
    t0 = time.perf_counter()

    for attempt in range(1, cfg.max_attempts + 1):
        # ── Fase 1: con SSL verificado ──
        try:
            r = await client_secure.get(
                url, timeout=timeout, follow_redirects=True
            )
            latency = round((time.perf_counter() - t0) * 1000, 2)
            return r.text, r.status_code, None, latency
        except (httpx.ConnectError, httpx.ReadError) as exc:
            err_str = str(exc).lower()
            if "ssl" in err_str or "certificate" in err_str or "tls" in err_str:
                # ── Fase 2: fallback sin verificación SSL ──
                try:
                    r = await client_insecure.get(
                        url, timeout=timeout, follow_redirects=True
                    )
                    latency = round((time.perf_counter() - t0) * 1000, 2)
                    return r.text, r.status_code, None, latency
                except Exception as exc2:
                    last_error = f"SSL fallback falló: {exc2}"
            else:
                last_error = f"Error de conexión: {exc}"
        except httpx.TimeoutException as exc:
            last_error = f"Timeout: {exc}"
        except Exception as exc:
            last_error = f"Error: {exc}"

        if attempt < cfg.max_attempts:
            await asyncio.sleep(cfg.delay * attempt)

    latency = round((time.perf_counter() - t0) * 1000, 2)
    return None, None, last_error, latency


# ═══════════════════════════════════════════════════════════════════════════
# Clasificación de estado
# ═══════════════════════════════════════════════════════════════════════════


def clasificar_estado(status_code: Optional[int]) -> str:
    if status_code is None:
        return "sin_respuesta"
    return str(status_code)


# ═══════════════════════════════════════════════════════════════════════════
# Caché de GetCapabilities / REST por URL
# ═══════════════════════════════════════════════════════════════════════════


async def fetch_and_cache(
    client_secure: httpx.AsyncClient,
    client_insecure: httpx.AsyncClient,
    url: str,
    id_tipo_servicio: int,
    cfg: RequestConfig,
    cache: dict[str, CachedCapabilities],
) -> CachedCapabilities:
    """Consulta una URL; si ya se consultó, devuelve caché."""
    if url in cache:
        return cache[url]

    tipo = detectar_tipo_real_url(url, id_tipo_servicio)

    body, status, error, latency = await fetch_with_retries(
        client_secure, client_insecure, url, cfg
    )

    # ── Sin respuesta ──
    if body is None:
        cached = CachedCapabilities(
            status=status,
            layers=[],
            error_message=error,
            is_ok=False,
            latency_ms=latency,
        )
        cache[url] = cached
        return cached

    layers: list[LayerInfo] = []
    error_message: Optional[str] = None
    is_ok = status is not None and status < 400

    # ── Manejar códigos de bloqueo/seguridad ──
    if status in (401, 403, 407, 451):
        error_message = f"Acceso denegado/bloqueado (HTTP {status})"
        is_ok = False
    elif status in (500, 501, 502, 503, 504):
        error_message = f"Error del servidor (HTTP {status})"
        is_ok = False
    elif is_ok:
        # ── Parseo según tipo real ──
        if tipo == WMS_SERVICE_TYPE:
            if "<WMS_Capabilities" in body or "<WMT_MS_Capabilities" in body:
                layers = extract_wms_layers(body, url)
            else:
                error_message = (
                    f"Respuesta no parece WMS XML "
                    f"(HTTP {status}, Content-Type inferido)"
                )
                is_ok = False

        elif tipo == WFS_SERVICE_TYPE:
            if "<WFS_Capabilities" in body or "FeatureTypeList" in body:
                layers = extract_wfs_layers(body, url)
            else:
                error_message = (
                    f"Respuesta no parece WFS XML "
                    f"(HTTP {status})"
                )
                is_ok = False

        elif tipo == WMTS_SERVICE_TYPE:
            if "<Capabilities" in body and "Contents" in body:
                layers = extract_wmts_layers(body)
            else:
                error_message = (
                    f"Respuesta no parece WMTS XML "
                    f"(HTTP {status})"
                )
                is_ok = False

        elif tipo in REST_SERVICE_TYPES:
            rest_err = check_arcgis_rest_error(body)
            if rest_err:
                error_message = rest_err
                is_ok = False
            else:
                layers = extract_arcgis_rest_layers(body)

    cached = CachedCapabilities(
        status=status,
        layers=layers,
        error_message=error_message,
        is_ok=is_ok,
        latency_ms=latency,
    )
    cache[url] = cached
    return cached


# ═══════════════════════════════════════════════════════════════════════════
# Actualización masiva
# ═══════════════════════════════════════════════════════════════════════════


async def actualizar_servicios(
    cfg: RequestConfig,
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
            capas = CapaGeografica.query.filter(
                CapaGeografica.id.in_(ids_capa)
            ).all()
            capas_geo = {c.id: c.nombre for c in capas if c.nombre}

        success_log.info(
            "Iniciando verificación: %d servicios | %d capas geográficas.",
            len(servicios),
            len(capas_geo),
        )

        total = len(servicios)
        ok_count = 0
        err_count = 0
        match_count = 0
        no_match_count = 0
        direct_count = 0
        no_layers_count = 0
        ssl_fallback_count = 0
        url_normalized_count = 0

        url_cache: dict[str, CachedCapabilities] = {}
        ssl_ctx = _build_ssl_context()

        async with (
            httpx.AsyncClient(
                headers=HEADERS,
                verify=ssl_ctx,
            ) as client_secure,
            httpx.AsyncClient(
                headers=HEADERS,
                verify=False,
            ) as client_insecure,
        ):
            for idx, servicio in enumerate(servicios, start=1):
                estado_anterior = servicio.estado
                nombre_capa_anterior = servicio.nombre_capa
                titulo_capa_anterior = servicio.titulo_capa

                url_original = servicio.direccion_web
                url = build_service_url(servicio)
                nombre_capa_geo = capas_geo.get(servicio.id_capa, "")

                # Detectar si la URL fue normalizada (p.ej. /MapServer/1 → /MapServer)
                url_was_normalized = (
                    _RE_REST_LAYER_NUM.search(urlsplit(url_original).path)
                    is not None
                )
                if url_was_normalized:
                    url_normalized_count += 1

                # ── Consultar servicio (con caché) ──
                cached = await fetch_and_cache(
                    client_secure,
                    client_insecure,
                    url,
                    servicio.id_tipo_servicio,
                    cfg,
                    url_cache,
                )

                # ── Actualizar estado ──
                servicio.estado = cached.is_ok

                # ── Tipo real vs BD ──
                tipo_real = detectar_tipo_real_url(
                    url_original, servicio.id_tipo_servicio
                )
                _labels = {
                    WMS_SERVICE_TYPE: "WMS",
                    WFS_SERVICE_TYPE: "WFS",
                    WMTS_SERVICE_TYPE: "WMTS",
                    ARCGIS_REST_SERVICE_TYPE: "REST",
                    ARCGIS_KML_SERVICE_TYPE: "KML",
                }
                tipo_bd_label = _labels.get(
                    servicio.id_tipo_servicio,
                    str(servicio.id_tipo_servicio),
                )
                tipo_real_label = _labels.get(tipo_real, str(tipo_real))
                tipo_label = (
                    f"{tipo_real_label} (BD:{tipo_bd_label})"
                    if tipo_real != servicio.id_tipo_servicio
                    else tipo_bd_label
                )

                num_layers = len(cached.layers)
                es_tipo_con_capas = tipo_real in ALL_LAYER_TYPES

                # ── Lógica de asignación nombre_capa / titulo_capa ──
                best_match: Optional[FuzzyMatch] = None
                match_info = ""

                if not cached.is_ok:
                    match_info = "N/A (servicio con error)"

                elif es_tipo_con_capas and num_layers == 0:
                    # OK pero sin capas → error
                    err_count += 1
                    no_layers_count += 1
                    error_log.warning(
                        "[%d/%d] SIN CAPAS | ID: %s | Tipo: %s | "
                        "id_capa: %s | CapaGeo: '%s' | "
                        "Estado: %s → %s | HTTP: %s | %sms | "
                        "Motivo: Servicio respondió OK pero no expone "
                        "ninguna capa | URL_original: %s | URL_consulta: %s",
                        idx,
                        total,
                        servicio.id,
                        tipo_label,
                        servicio.id_capa,
                        nombre_capa_geo or "(sin nombre)",
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(cached.status),
                        cached.latency_ms,
                        url_original,
                        url,
                    )
                    continue

                elif num_layers == 1:
                    # ── 1 CAPA → asignación directa ──
                    unica = cached.layers[0]
                    servicio.nombre_capa = unica.name
                    servicio.titulo_capa = unica.title
                    direct_count += 1
                    match_info = (
                        f"ASIGNACIÓN DIRECTA (capa única) "
                        f"name='{unica.name}' title='{unica.title}'"
                    )

                elif num_layers > 1 and nombre_capa_geo:
                    # ── 2+ CAPAS → fuzzy match ──
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
                            f"SIN MATCH (mejor: "
                            f"name='{best_match.layer.name}' "
                            f"title='{best_match.layer.title}' "
                            f"score={best_match.score:.0%} "
                            f"< umbral {FUZZY_THRESHOLD:.0%})"
                        )

                elif num_layers > 1 and not nombre_capa_geo:
                    no_match_count += 1
                    match_info = (
                        f"SIN MATCH ({num_layers} capas pero "
                        f"CapaGeografica no tiene nombre)"
                    )

                else:
                    match_info = "N/A"

                # ── Nota de normalización ──
                url_note = ""
                if url_was_normalized:
                    url_note = f" | URL_normalizada: {url_original} → {url}"

                # ── Log ──
                if cached.is_ok:
                    ok_count += 1
                    success_log.info(
                        "[%d/%d] OK | ID: %s | Tipo: %s | id_capa: %s | "
                        "CapaGeo: '%s' | Estado: %s → %s | HTTP: %s | "
                        "%sms | nombre_capa: '%s' → '%s' | "
                        "titulo_capa: '%s' → '%s' | "
                        "%s | Capas: %d | URL: %s%s",
                        idx,
                        total,
                        servicio.id,
                        tipo_label,
                        servicio.id_capa,
                        nombre_capa_geo or "(sin nombre)",
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(cached.status),
                        cached.latency_ms,
                        nombre_capa_anterior or "",
                        servicio.nombre_capa or "",
                        titulo_capa_anterior or "",
                        servicio.titulo_capa or "",
                        match_info,
                        num_layers,
                        url_original,
                        url_note,
                    )
                else:
                    err_count += 1
                    error_log.warning(
                        "[%d/%d] ERROR | ID: %s | Tipo: %s | id_capa: %s | "
                        "CapaGeo: '%s' | Estado: %s → %s | HTTP: %s | "
                        "%sms | Motivo: %s | URL_original: %s | "
                        "URL_consulta: %s",
                        idx,
                        total,
                        servicio.id,
                        tipo_label,
                        servicio.id_capa,
                        nombre_capa_geo or "(sin nombre)",
                        estado_anterior,
                        servicio.estado,
                        clasificar_estado(cached.status),
                        cached.latency_ms,
                        cached.error_message
                        or "HTTP >= 400 o sin respuesta",
                        url_original,
                        url,
                    )

        # ── Resumen ──
        sep = "=" * 74
        success_log.info(sep)
        success_log.info("RESUMEN DE VERIFICACIÓN")
        success_log.info(sep)
        success_log.info("  Total servicios procesados       : %d", total)
        success_log.info("  Servicios OK                     : %d", ok_count)
        success_log.info("  Servicios con error              : %d", err_count)
        success_log.info("  Servicios OK sin capas           : %d", no_layers_count)
        success_log.info(
            "  Asignación directa (1 capa)      : %d", direct_count
        )
        success_log.info(
            "  Match fuzzy exitoso (≥%s)       : %d",
            f"{FUZZY_THRESHOLD:.0%}",
            match_count,
        )
        success_log.info(
            "  Sin match suficiente             : %d", no_match_count
        )
        success_log.info(
            "  URLs REST normalizadas (/N→base) : %d", url_normalized_count
        )
        success_log.info(
            "  URLs únicas consultadas          : %d", len(url_cache)
        )
        success_log.info(sep)

        if err_count:
            error_log.warning(
                "Total errores: %d → Revisar: %s",
                err_count,
                log_dir / "servicios_errores.log",
            )

        if dry_run:
            db.session.rollback()
            success_log.info(
                "MODO SIMULACIÓN (--dry-run): NO se guardaron cambios."
            )
            return

        db.session.commit()
        success_log.info("Actualización completada y guardada en BD.")


# ═══════════════════════════════════════════════════════════════════════════
# CLI
# ═══════════════════════════════════════════════════════════════════════════


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Verifica servicios geográficos (WMS, WFS, WMTS, ArcGIS REST) "
            "y actualiza nombre_capa y titulo_capa. Usa httpx con CA-bundle "
            "y fallback SSL para manejar certificados problemáticos."
        ),
    )
    parser.add_argument(
        "--limite",
        type=int,
        help="Número máximo de registros a revisar.",
    )
    parser.add_argument(
        "--timeout-connect",
        type=float,
        default=10.0,
        help="Timeout de conexión en segundos (default: 10).",
    )
    parser.add_argument(
        "--timeout-read",
        type=float,
        default=25.0,
        help="Timeout de lectura en segundos (default: 25).",
    )
    parser.add_argument(
        "--max-attempts",
        type=int,
        default=3,
        help="Reintentos por petición (default: 3).",
    )
    parser.add_argument(
        "--delay",
        type=float,
        default=0.3,
        help="Espera entre reintentos en segundos (default: 0.3).",
    )
    parser.add_argument(
        "--concurrency",
        type=int,
        default=20,
        help="Peticiones concurrentes máximas (default: 20).",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Verificación sin guardar cambios en BD.",
    )
    parser.add_argument(
        "--log-dir",
        type=str,
        default=None,
        help="Directorio para logs (default: ./tmp/logs).",
    )
    parser.add_argument(
        "--ca-bundle",
        type=str,
        default=None,
        help="Ruta al archivo CA-bundle para verificación SSL.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    # Actualizar CA_BUNDLE_PATH si se proporcionó por CLI
    global CA_BUNDLE_PATH
    if args.ca_bundle:
        CA_BUNDLE_PATH = Path(args.ca_bundle)

    log_dir = (
        Path(args.log_dir)
        if args.log_dir
        else Path(__file__).resolve().parent / "tmp" / "logs"
    )

    cfg = RequestConfig(
        timeout_connect=args.timeout_connect,
        timeout_read=args.timeout_read,
        max_attempts=args.max_attempts,
        delay=args.delay,
        concurrency=args.concurrency,
    )

    asyncio.run(actualizar_servicios(cfg, args.limite, args.dry_run, log_dir))


if __name__ == "__main__":
    main()
