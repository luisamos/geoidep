import os
import time
from datetime import datetime, UTC
from contextlib import contextmanager

import requests
from PIL import Image
from playwright.sync_api import sync_playwright, TimeoutError as PWTimeoutError

from app import create_app, db
from models.herramientas_digitales import HerramientaDigital

# ===== Config =====
OUT_DIR = os.path.join("static", "imagenes", "temporal")
MOBILE_VIEWPORT = {"width": 400, "height": 800}
TIMEOUT_MS = 15000              # Playwright nav timeout (ms)
REQ_TIMEOUT = (6, 12)           # (connect, read) en segundos
BATCH_SIZE = 50
SLEEP_BETWEEN_BATCHES = 0.2
RETRIES_HTTP = 2
RETRIES_SCREENSHOT = 1

MOBILE_UA = (
    "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) "
    "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
)

# ===== Utils =====
def ensure_out_dir():
    os.makedirs(OUT_DIR, exist_ok=True)

def normalize_url(url: str) -> str | None:
    if not url:
        return None
    u = url.strip()
    if not u.lower().startswith(("http://", "https://")):
        u = "http://" + u
    return u

def is_url_available_follow_redirects(url: str) -> tuple[bool, str | None]:
    """
    Intenta resolver y verificar disponibilidad del recurso.
    - Sigue redirecciones (acortadores tipo arcg.is).
    - Acepta 2xx/3xx como disponible.
    Retorna (disponible, url_final_resuelta_o_None).
    """
    if not url:
        return (False, None)

    session = requests.Session()
    session.headers.update({
        "User-Agent": MOBILE_UA,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    })

    last_exc = None
    # Algunos servidores no aceptan HEAD → probamos HEAD y luego GET ligero
    for attempt in range(RETRIES_HTTP + 1):
        try:
            r = session.head(url, allow_redirects=True, timeout=REQ_TIMEOUT)
            if 200 <= r.status_code < 400:
                return (True, r.url)
            # HEAD puede devolver 405 → intentar GET
            if r.status_code in (405, 403, 404) or r.is_redirect:
                # GET con stream para no descargar todo el cuerpo
                g = session.get(url, allow_redirects=True, timeout=REQ_TIMEOUT, stream=True)
                if 200 <= g.status_code < 400:
                    return (True, g.url)
                else:
                    last_exc = f"GET status={g.status_code}"
            else:
                last_exc = f"HEAD status={r.status_code}"
        except Exception as e:
            last_exc = e
        time.sleep(0.2)

    # No disponible
    return (False, None)

def save_light_webp(png_path: str, out_path: str, max_size=(400, 800), quality=60):
    img = Image.open(png_path).convert("RGB")
    img.thumbnail(max_size)  # vertical, mantiene proporción
    img.save(out_path, format="WEBP", quality=quality, method=6, optimize=True)

@contextmanager
def pw_context():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            viewport=MOBILE_VIEWPORT,
            is_mobile=True,
            user_agent=MOBILE_UA,
            device_scale_factor=2,
            java_script_enabled=True,
        )
        try:
            yield context
        finally:
            context.close()
            browser.close()

def try_capture(context, url: str, out_path: str) -> bool:
    """
    Intenta capturar 1..(1+RETRIES_SCREENSHOT) veces.
    Devuelve True si generó la imagen; False si falla.
    """
    for attempt in range(1 + RETRIES_SCREENSHOT):
        page = context.new_page()
        try:
            resp = page.goto(url, timeout=TIMEOUT_MS, wait_until="networkidle")
            if resp and not (200 <= resp.status < 400):
                raise RuntimeError(f"HTTP {resp.status}")

            tmp_png = out_path + ".tmp.png"
            page.screenshot(path=tmp_png, full_page=False)
            save_light_webp(tmp_png, out_path)
            os.remove(tmp_png)
            return True
        except (PWTimeoutError, Exception):
            pass
        finally:
            page.close()
        time.sleep(0.2)
    return False

# ===== Worker principal =====
def check_and_capture_all():
    ensure_out_dir()

    q = (
        HerramientaDigital.query
        .filter(HerramientaDigital.recurso.isnot(None))
        .order_by(HerramientaDigital.id)
    )

    total = q.count()
    print(f"Total registros a evaluar: {total}")

    ok_imgs = 0
    set_zero = 0
    processed = 0

    with pw_context() as context:
        offset = 0
        while True:
            batch = q.limit(BATCH_SIZE).offset(offset).all()
            if not batch:
                break

            for item in batch:
                out_path = os.path.join(OUT_DIR, f"{item.id}.webp")
                url = normalize_url(item.recurso)

                # 1) Verificar disponibilidad (resuelve acortadores)
                available, final_url = is_url_available_follow_redirects(url)

                if not available:
                    # Recurso caído / no accesible → estado 0
                    item.estado = 0
                    item.fecha_modifica = datetime.now(UTC)
                    db.session.add(item)
                    set_zero += 1
                    processed += 1
                    continue

                # 2) Si hay disponibilidad:
                #    - Si ya existe imagen: NO recapturar.
                #    - Si NO existe imagen: capturar ahora.
                if os.path.exists(out_path):
                    # Solo actualiza estado a 1 si el recurso está OK
                    if item.estado != 1:
                        item.estado = 1
                        item.fecha_modifica = datetime.now(UTC)
                        db.session.add(item)
                else:
                    # Generar captura; si falla, estado 0
                    if try_capture(context, final_url or url, out_path):
                        item.estado = 1
                    else:
                        item.estado = 0
                        set_zero += 1
                    item.fecha_modifica = datetime.now(UTC)
                    db.session.add(item)

                processed += 1

            # Commit por lote
            try:
                db.session.commit()
            except Exception as e:
                db.session.rollback()
                print(f"[ERROR] Commit fallido: {e}")

            print(f"Progreso: {min(offset+BATCH_SIZE, total)}/{total} | imgs_ok={ok_imgs}, estado0={set_zero}")
            offset += BATCH_SIZE
            time.sleep(SLEEP_BETWEEN_BATCHES)

    print(f"✔ Hecho. Procesados={processed}, Marcados estado=0={set_zero}")

# ===== Entrada =====
def main():
    app = create_app()
    with app.app_context():
        check_and_capture_all()

if __name__ == "__main__":
    main()
