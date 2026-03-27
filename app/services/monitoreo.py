"""Servicio de monitoreo de herramientas geográficas y servicios geograficos.

Contiene la logica de verificacion de disponibilidad, utilizada tanto
por el endpoint /principal/monitoreo como por el script dev/.
"""

from __future__ import annotations

import asyncio
import logging
import random
from dataclasses import dataclass, field
from typing import Optional
from urllib.parse import parse_qsl, urlencode, urlsplit, urlunsplit

import aiohttp
import ssl
import certifi
from lxml import etree

from app import db
from app.models import (
    HerramientaGeografica,
    ServicioGeografico,
    LogMonitoreo,
    HLogMonitoreo,
)

TIPO_HERRAMIENTA_GEOGRAFICA = "herramienta_geografica"
TIPO_GEOGRAFICO = "servicio_geografico"

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

ACCEPTED_STATUSES = {401, 403, 405}


@dataclass
class RequestConfig:
    timeout: float = 30.0
    delay: float = 0.5


@dataclass
class ResultadoMonitoreo:
    servicios_verificados: int = 0
    servicios_activos: int = 0
    servicios_inactivos: int = 0
    herramientas_verificadas: int = 0
    herramientas_activas: int = 0
    herramientas_inactivas: int = 0
    errores: list[str] = field(default_factory=list)


# ---------------------------------------------------------------------------
# Funciones auxiliares
# ---------------------------------------------------------------------------
def build_ssl_context() -> ssl.SSLContext:
    return ssl.create_default_context(cafile=certifi.where())

def build_getcapabilities_url(base_url: str, service: str) -> str:
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
    return urlunsplit((parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment))


def extract_featuretypes(xml_text: str) -> list[str]:
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    nodes = root.xpath("//*[local-name()='FeatureTypeList']/*[local-name()='FeatureType']")
    names = []
    for feature_node in nodes:
        name = feature_node.xpath("string(./*[local-name()='Name'])").strip()
        if name:
            names.append(name)
    return names


def build_service_url(servicio: ServicioGeografico) -> str:
    if servicio.id_tipo == WFS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WFS")
    if servicio.id_tipo == WMS_SERVICE_TYPE:
        return build_getcapabilities_url(servicio.direccion_web, "WMS")
    return servicio.direccion_web


# ---------------------------------------------------------------------------
# Funciones async de verificacion
# ---------------------------------------------------------------------------

async def fetch_with_retries(
    session: aiohttp.ClientSession,
    url: str,
    timeout: float,
    headers: Optional[dict] = None,
    max_attempts: int = 3,
    ssl_verify: bool = True,
) -> tuple[str, str, Optional[int]]:
    client_timeout = aiohttp.ClientTimeout(total=timeout, connect=10, sock_read=20)
    last_error: Optional[Exception] = None
    request_headers = headers or HEADERS
    ssl_option = None if ssl_verify else False

    for attempt in range(1, max_attempts + 1):
        try:
            async with session.get(
                url,
                headers=request_headers,
                timeout=client_timeout,
                allow_redirects=True,
                ssl=ssl_option,
            ) as response:
                text = await response.text(errors="ignore")
                return text, response.headers.get("Content-Type", ""), response.status
        except Exception as exc:
            last_error = exc
            await asyncio.sleep((0.7 * attempt) + random.random())

    if last_error:
        raise last_error

    raise RuntimeError("No se pudo completar la petición HTTP.")

async def procesar_herramienta(
    session: aiohttp.ClientSession,
    herramienta,
    config,
) -> tuple[bool, Optional[int], Optional[str]]:
    url = (herramienta.recurso or "").strip()
    if not url:
        return False, None, "Sin URL de recurso"

    if not url.lower().startswith(("http://", "https://")):
        url = "http://" + url

    try:
        _text, _content_type, status = await fetch_with_retries(
            session,
            url,
            config.timeout,
            headers=HEADERS_HTML,
            ssl_verify=True,
        )

    except aiohttp.ClientConnectorCertificateError as exc:
        logging.warning(
            "Certificado inválido en %s -> %s. Reintentando sin verificación.",
            url, exc
        )
        try:
            _text, _content_type, status = await fetch_with_retries(
                session,
                url,
                config.timeout,
                headers=HEADERS_HTML,
                ssl_verify=False,
            )
            if status is not None and (200 <= status < 400 or status in ACCEPTED_STATUSES):
                return True, status, "Accesible, pero con certificado SSL no verificable"
            return False, status, "Certificado SSL inválido"
        except Exception as exc2:
            logging.warning(
                "Fallo herramienta %s incluso sin verificación SSL -> %s",
                url, exc2
            )
            return False, None, f"SSL inválido y fallo posterior: {exc2}"

    except ssl.SSLCertVerificationError as exc:
        logging.warning(
            "SSL no verificable en %s -> %s. Reintentando sin verificación.",
            url, exc
        )
        try:
            _text, _content_type, status = await fetch_with_retries(
                session,
                url,
                config.timeout,
                headers=HEADERS_HTML,
                ssl_verify=False,
            )
            if status is not None and (200 <= status < 400 or status in ACCEPTED_STATUSES):
                return True, status, "Accesible, pero con certificado SSL no verificable"
            return False, status, "No se pudo verificar el certificado SSL"
        except Exception as exc2:
            logging.warning(
                "Fallo herramienta %s incluso sin verificación SSL -> %s",
                url, exc2
            )
            return False, None, f"SSL no verificable y fallo posterior: {exc2}"

    except Exception as exc:
        logging.warning("Fallo herramienta %s -> %s", url, exc)
        return False, None, str(exc)

    if status is not None and (200 <= status < 400 or status in ACCEPTED_STATUSES):
        return True, status, None

    error_msg = f"HTTP {status}" if status else "Sin respuesta"
    return False, status, error_msg

async def procesar_servicio(
    session: aiohttp.ClientSession,
    servicio: ServicioGeografico,
    config: RequestConfig,
) -> tuple[bool, Optional[list[str]], Optional[int], Optional[str]]:
    url = build_service_url(servicio)
    try:
        xml_text, content_type, status = await fetch_with_retries(
            session, url, config.timeout
        )
    except Exception as exc:
        logging.warning("Fallo servicio %s -> %s", url, exc)
        return False, None, None, str(exc)

    if servicio.id_tipo == WFS_SERVICE_TYPE:
        if "<WFS_Capabilities" not in xml_text and "FeatureTypeList" not in xml_text:
            logging.warning(
                "Respuesta no parece WFS XML en %s (Content-Type: %s)",
                url,
                content_type,
            )
            return False, None, status, "Respuesta no es WFS XML válido"

        layers = extract_featuretypes(xml_text)
        estado_ok = bool(layers) and (status is not None and status < 400)
        error_msg = None if estado_ok else "No se encontraron FeatureTypes"
        return estado_ok, layers or None, status, error_msg

    if servicio.id_tipo in {ARCGIS_REST_SERVICE_TYPE, ARCGIS_KML_SERVICE_TYPE}:
        estado_ok = bool(status is not None and status < 400)
        error_msg = None if estado_ok else f"HTTP {status}"
        return estado_ok, None, status, error_msg

    estado_ok = bool(status is not None and status < 400)
    error_msg = None if estado_ok else f"HTTP {status}"
    return estado_ok, None, status, error_msg


# ---------------------------------------------------------------------------
# Registro de logs en BD
# ---------------------------------------------------------------------------
def registrar_log(
    tipo_recurso: str,
    id_recurso: int,
    nombre_recurso: Optional[str],
    url_verificada: Optional[str],
    estado_anterior: Optional[bool],
    estado_nuevo: bool,
    codigo_http: Optional[int],
    mensaje_error: Optional[str],
) -> None:
    payload = {
        "tipo_recurso": tipo_recurso,
        "id_recurso": id_recurso,
        "nombre_recurso": nombre_recurso,
        "url_verificada": url_verificada,
        "estado_anterior": estado_anterior,
        "estado_nuevo": estado_nuevo,
        "codigo_http": codigo_http,
        "mensaje_error": mensaje_error,
    }

    # Guardar historico completo
    db.session.add(HLogMonitoreo(**payload))

    # Mantener en la tabla principal solo el ultimo estado por recurso
    log_actual = LogMonitoreo.query.filter_by(
        tipo_recurso=tipo_recurso,
        id_recurso=id_recurso,
    ).first()
    if log_actual:
        for campo, valor in payload.items():
            setattr(log_actual, campo, valor)
    else:
        db.session.add(LogMonitoreo(**payload))

# ---------------------------------------------------------------------------
# Funciones principales de actualizacion
# ---------------------------------------------------------------------------
async def actualizar_herramientas_geograficas(
    session: aiohttp.ClientSession,
    config: RequestConfig,
    resultado: ResultadoMonitoreo,
    limite: Optional[int] = None,
    ids: Optional[list[int]] = None,
    progress_callback=None,
    progress_offset: int = 0,
) -> None:
    query = HerramientaGeografica.query.filter(
        HerramientaGeografica.recurso.isnot(None)
    ).order_by(HerramientaGeografica.id)
    if ids:
        query = query.filter(HerramientaGeografica.id.in_(ids))
    if limite:
        query = query.limit(limite)

    herramientas = query.all()

    if not herramientas:
        logging.info("No se encontraron herramientas geográficas para verificar.")
        return

    for herramienta in herramientas:
        estado_anterior = herramienta.estado
        url = (herramienta.recurso or "").strip()
        estado, status_code, error_msg = await procesar_herramienta(
            session, herramienta, config
        )
        herramienta.estado = bool(estado)

        registrar_log(
            tipo_recurso=TIPO_HERRAMIENTA_GEOGRAFICA,
            id_recurso=herramienta.id,
            nombre_recurso=herramienta.nombre,
            url_verificada=url,
            estado_anterior=estado_anterior,
            estado_nuevo=herramienta.estado,
            codigo_http=status_code,
            mensaje_error=error_msg,
        )

        resultado.herramientas_verificadas += 1
        if herramienta.estado:
            resultado.herramientas_activas += 1
        else:
            resultado.herramientas_inactivas += 1
            if error_msg:
                resultado.errores.append(f"[HD #{herramienta.id}] {error_msg}")

        if progress_callback:
            progress_callback(progress_offset + resultado.herramientas_verificadas)

        logging.info(
            "Herramienta %s | URL: %s | Estado: %s -> %s",
            herramienta.id,
            url,
            estado_anterior,
            herramienta.estado,
        )

        if config.delay:
            await asyncio.sleep(config.delay)

async def actualizar_servicios_geograficos(
    session: aiohttp.ClientSession,
    config: RequestConfig,
    resultado: ResultadoMonitoreo,
    limite: Optional[int] = None,
    ids: Optional[list[int]] = None,
    progress_callback=None,
    progress_offset: int = 0,
) -> None:
    query = ServicioGeografico.query.order_by(ServicioGeografico.id)
    if ids:
        query = query.filter(ServicioGeografico.id.in_(ids))
    if limite:
        query = query.limit(limite)

    servicios = query.all()

    if not servicios:
        logging.info("No se encontraron servicios geográficos para verificar.")
        return

    for servicio in servicios:
        estado_anterior = servicio.estado

        estado, _layers, _status_code, error_msg = await procesar_servicio(
            session, servicio, config
        )

        # SOLO actualiza estado
        servicio.estado = bool(estado)

        resultado.servicios_verificados += 1
        if servicio.estado:
            resultado.servicios_activos += 1
        else:
            resultado.servicios_inactivos += 1
            if error_msg:
                resultado.errores.append(f"[SG #{servicio.id}] {error_msg}")

        if progress_callback:
            progress_callback(progress_offset + resultado.servicios_verificados)

        logging.info(
            "Servicio %s | URL: %s | Estado: %s -> %s",
            servicio.id,
            servicio.direccion_web,
            estado_anterior,
            servicio.estado,
        )

        if config.delay:
            await asyncio.sleep(config.delay)

# ---------------------------------------------------------------------------
# Funcion orquestadora (usada por el endpoint y por el script dev/)
# ---------------------------------------------------------------------------

async def ejecutar_monitoreo(
    config: Optional[RequestConfig] = None,
    tipo: str = "todos",
    limite: Optional[int] = None,
    ids: Optional[list[int]] = None,
    dry_run: bool = False,
    progress_callback=None,
) -> ResultadoMonitoreo:
    """Ejecuta el monitoreo completo. Debe llamarse dentro de un app_context.

    Args:
        progress_callback: callable(verificados: int) llamado tras verificar
            cada recurso. Permite que el caller actualice el progreso en tiempo
            real (e.g. desde un hilo de fondo).
    """
    if config is None:
        config = RequestConfig()

    resultado = ResultadoMonitoreo()

    async with aiohttp.ClientSession() as session:
        if tipo in ("todos", "servicios_geograficos"):
            logging.info("=== Verificando servicios geográficos ===")
            await actualizar_servicios_geograficos(
                session, config, resultado, limite, ids,
                progress_callback=progress_callback,
                progress_offset=0,
            )

        if tipo in ("todos", "herramientas_geograficas"):
            logging.info("=== Verificando herramientas geográficas ===")
            # El offset acumula los servicios ya verificados para que el
            # progreso sea global y no reinicie al cambiar de categoría.
            await actualizar_herramientas_geograficas(
                session, config, resultado, limite, ids,
                progress_callback=progress_callback,
                progress_offset=resultado.servicios_verificados,
            )

    if dry_run:
        db.session.rollback()
        logging.info("Ejecución en modo simulación: no se guardaron cambios.")
    else:
        db.session.commit()
        logging.info("Verificación completada y cambios guardados.")

    return resultado