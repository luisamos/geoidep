import asyncio
import logging
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Optional
from urllib.parse import parse_qsl, urlencode, urlsplit, urlunsplit

import httpx
from apscheduler.schedulers.background import BackgroundScheduler
from lxml import etree

root_dir = Path(__file__).resolve().parents[1]
if str(root_dir) not in sys.path:
    sys.path.insert(0, str(root_dir))

from app import create_app, db
from app.models import ServicioGeografico

# =========================
# CONFIG
# =========================
CA_BUNDLE_PATH = "STAR_geoidep_gob_pe.ca-bundle"
CHECK_INTERVAL_MINUTES = 5

# Ajusta si tus tipos difieren
WMS_SERVICE_TYPE = 11
WFS_SERVICE_TYPE = 12
WCS_SERVICE_TYPE = 13  # si no existe, no afecta

OGC_BY_TIPO = {
    WMS_SERVICE_TYPE: "WMS",
    WFS_SERVICE_TYPE: "WFS",
    WCS_SERVICE_TYPE: "WCS",
}

HEADERS = {
    "User-Agent": "geo-monitor/1.0",
    "Accept": "application/xml,text/xml,*/*;q=0.8",
    "Accept-Language": "es-PE,es;q=0.9,en;q=0.8",
    "Connection": "keep-alive",
}


@dataclass
class RequestConfig:
    timeout_connect: float = 5.0
    timeout_read: float = 25.0
    max_attempts: int = 2
    concurrency: int = 40


# =========================
# URL helpers
# =========================
def build_getcapabilities_url(base_url: str, service: str) -> str:
    if not base_url:
        return base_url

    parsed = urlsplit(base_url)
    query_items = dict(parse_qsl(parsed.query, keep_blank_values=True))

    # Si ya es GetCapabilities del mismo service, respétalo
    if query_items.get("request", "").lower() == "getcapabilities" and query_items.get(
        "service", ""
    ).lower() == service.lower():
        return base_url

    query_items["service"] = service
    query_items["request"] = "GetCapabilities"
    new_query = urlencode(query_items)
    return urlunsplit((parsed.scheme, parsed.netloc, parsed.path, new_query, parsed.fragment))


def build_service_url(servicio: ServicioGeografico) -> tuple[str, Optional[str]]:
    ogc = OGC_BY_TIPO.get(servicio.id_tipo)
    if ogc:
        return build_getcapabilities_url(servicio.direccion_web, ogc), ogc
    return servicio.direccion_web, None


# =========================
# Parse OGC (primera capa)
# =========================
def parse_first_layer(xml_text: str, ogc_type: str) -> tuple[Optional[str], Optional[str]]:
    """
    Devuelve (name, title) de la primera capa encontrada.
    """
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    def txt(node) -> str:
        return (node.text or "").strip() if node is not None else ""

    if ogc_type == "WMS":
        for layer in root.findall(".//{*}Layer"):
            name = txt(layer.find("./{*}Name"))
            if not name:
                continue
            title = txt(layer.find("./{*}Title"))
            return name, (title or name)

    if ogc_type == "WFS":
        for ft in root.findall(".//{*}FeatureType"):
            name = txt(ft.find("./{*}Name"))
            if not name:
                continue
            title = txt(ft.find("./{*}Title"))
            return name, (title or name)

    if ogc_type == "WCS":
        # WCS 2.0
        for cs in root.findall(".//{*}CoverageSummary"):
            ident = txt(cs.find("./{*}CoverageId")) or txt(cs.find("./{*}Identifier"))
            if not ident:
                continue
            title = txt(cs.find("./{*}Title"))
            return ident, (title or ident)

        # fallback WCS 1.0 (variable)
        for cov in root.findall(".//{*}CoverageOfferingBrief"):
            name = txt(cov.find("./{*}name"))
            if not name:
                continue
            title = txt(cov.find("./{*}label"))
            return name, (title or name)

    return None, None


# =========================
# HTTP (httpx async)
# =========================
async def fetch_with_retries(
    client: httpx.AsyncClient,
    url: str,
    timeout: httpx.Timeout,
    max_attempts: int,
) -> tuple[Optional[str], Optional[int], Optional[str], Optional[str]]:
    """
    Retorna: (text, status_code, content_type, error)
    """
    last_exc: Optional[Exception] = None
    for attempt in range(1, max_attempts + 1):
        try:
            r = await client.get(url, timeout=timeout, follow_redirects=True)
            return r.text, r.status_code, (r.headers.get("content-type") or ""), None
        except Exception as exc:
            last_exc = exc
            await asyncio.sleep(0.4 * attempt)

    return None, None, None, str(last_exc) if last_exc else "HTTP error"


async def check_one(
    client: httpx.AsyncClient,
    servicio: ServicioGeografico,
    cfg: RequestConfig,
    sem: asyncio.Semaphore,
) -> dict:
    async with sem:
        url, ogc_type = build_service_url(servicio)
        timeout = httpx.Timeout(connect=cfg.timeout_connect, read=cfg.timeout_read, write=10.0, pool=5.0)

        t0 = time.perf_counter()
        text, status, content_type, err = await fetch_with_retries(
            client, url, timeout, cfg.max_attempts
        )
        latency_ms = round((time.perf_counter() - t0) * 1000, 2)

        # TU REGLA: estado True solo si HTTP 200 (conexión OK)
        ok = bool(status == 200)

        name = title = None
        if ok and ogc_type and text:
            low = text.lower()
            if "capabilities" in low and "<" in low:
                try:
                    name, title = parse_first_layer(text, ogc_type)
                except Exception as exc:
                    err = f"parse_error: {exc}"
                    ok = False  # si quieres que parse error marque como false

        return {
            "id": servicio.id,
            "url": url,
            "ok": ok,
            "status": status,
            "latency_ms": latency_ms,
            "name": name,
            "title": title,
            "error": err,
            "content_type": content_type,
        }


# =========================
# Actualizador (BD)
# =========================
async def actualizar_servicios_geograficos_async(cfg: RequestConfig, limite: Optional[int] = None) -> None:
    app = create_app()
    with app.app_context():
        q = ServicioGeografico.query.order_by(ServicioGeografico.id)
        if limite:
            q = q.limit(limite)
        servicios = q.all()

        if not servicios:
            logging.info("No hay servicios para actualizar.")
            return

        sem = asyncio.Semaphore(cfg.concurrency)

        async with httpx.AsyncClient(
            headers=HEADERS,
            verify=CA_BUNDLE_PATH,  # <<<<<< CA bundle
        ) as client:
            results = await asyncio.gather(*(check_one(client, s, cfg, sem) for s in servicios))

        ok_count = 0
        for r in results:
            servicio = ServicioGeografico.query.get(r["id"])
            if not servicio:
                continue

            servicio.estado = bool(r["ok"])
            if servicio.estado:
                ok_count += 1
                # Actualiza name/title solo si los obtuviste
                if r["name"]:
                    servicio.nombre_capa = r["name"]
                if r["title"]:
                    servicio.titulo_capa = r["title"]
            else:
                # Si cae, opcional: limpiar name/title
                servicio.nombre_capa = None
                servicio.titulo_capa = None

            logging.info(
                "ID=%s estado=%s http=%s t=%sms name=%s title=%s url=%s err=%s",
                servicio.id,
                servicio.estado,
                r["status"],
                r["latency_ms"],
                servicio.nombre_capa or "N/D",
                (servicio.titulo_capa or "N/D")[:80],
                r["url"],
                r["error"],
            )

        db.session.commit()
        logging.info("✔ Actualización terminada. OK=%s / %s", ok_count, len(servicios))


def actualizar_servicios_geograficos(cfg: RequestConfig, limite: Optional[int] = None) -> None:
    asyncio.run(actualizar_servicios_geograficos_async(cfg, limite=limite))


# =========================
# Scheduler
# =========================
def main():
    log_dir = Path(__file__).resolve().parent / "tmp" / "logs"
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file = log_dir / "actualizar_servicios_geograficos.log"

    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[logging.StreamHandler(), logging.FileHandler(log_file, encoding="utf-8")],
    )

    cfg = RequestConfig(
        timeout_connect=5.0,
        timeout_read=25.0,
        max_attempts=2,
        concurrency=40,
    )

    # 1) Ejecuta una vez al iniciar
    actualizar_servicios_geograficos(cfg)

    # 2) Programa cada 5 minutos
    scheduler = BackgroundScheduler(daemon=True)
    scheduler.add_job(
        actualizar_servicios_geograficos,
        "interval",
        minutes=CHECK_INTERVAL_MINUTES,
        args=[cfg],
        max_instances=1,
        coalesce=True,
    )
    scheduler.start()

    logging.info("Scheduler activo: cada %s minutos.", CHECK_INTERVAL_MINUTES)

    try:
        while True:
            time.sleep(60)
    except KeyboardInterrupt:
        logging.info("Saliendo...")


if __name__ == "__main__":
    main()
