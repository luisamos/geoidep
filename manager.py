import os
import time
from datetime import datetime
from contextlib import contextmanager
from PIL import Image
from flask import current_app
from playwright.sync_api import sync_playwright, TimeoutError as PWTimeoutError

from app import create_app, db
from models.herramientas_digitales import HerramientaDigital

# --- Configuración general ---
MOBILE_VIEWPORT = {"width": 400, "height": 800}
OUT_DIR = os.path.join("static", "imagenes", "herramientas_digitales")
TIMEOUT_MS = 15000  # 15 segundos máximo por carga
BATCH_SIZE = 50     # registros por commit
MOBILE_UA = (
    "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) "
    "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
)

# ----------------------------------------------------------------
def ensure_out_dir():
    os.makedirs(OUT_DIR, exist_ok=True)

def normalize_url(url: str) -> str:
    if not url:
        return None
    url = url.strip()
    if not url.lower().startswith(("http://", "https://")):
        url = "http://" + url
    return url

def save_light_webp(png_path: str, out_path: str, max_size=(400, 800), quality=60):
    img = Image.open(png_path).convert("RGB")
    img.thumbnail(max_size)
    img.save(out_path, format="WEBP", quality=quality, method=6, optimize=True)

@contextmanager
def playwright_browser():
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

def capture_mobile_light(context, url: str, out_path: str) -> bool:
    """
    Retorna True si se genera correctamente la imagen.
    Retorna False si hay error o timeout.
    """
    page = context.new_page()
    try:
        resp = page.goto(url, timeout=TIMEOUT_MS, wait_until="networkidle")
        if resp and (resp.status < 200 or resp.status >= 400):
            return False

        tmp_png = out_path + ".tmp.png"
        page.screenshot(path=tmp_png, full_page=False)
        save_light_webp(tmp_png, out_path)
        os.remove(tmp_png)
        return True
    except PWTimeoutError:
        return False
    except Exception:
        return False
    finally:
        page.close()

# ----------------------------------------------------------------
def procesar_herramientas():
    ensure_out_dir()

    # Solo las activas (estado = 1) con recurso no nulo
    q = (
        HerramientaDigital.query
        .filter(HerramientaDigital.recurso.isnot(None))
        .filter(HerramientaDigital.estado == 1)
        .order_by(HerramientaDigital.id)
    )

    total = q.count()
    print(f"Total a procesar: {total}")

    procesadas = 0
    guardadas = 0
    fallidas = 0

    with playwright_browser() as context:
        offset = 0
        while True:
            batch = q.limit(BATCH_SIZE).offset(offset).all()
            if not batch:
                break

            for item in batch:
                out_path = os.path.join(OUT_DIR, f"{item.id}.webp")
                url = normalize_url(item.recurso)

                # ✅ Si ya existe la imagen, saltar
                if os.path.exists(out_path):
                    procesadas += 1
                    continue

                ok = False
                if url:
                    ok = capture_mobile_light(context, url, out_path)

                if not ok:
                    item.estado = 0  # ❌ sin conexión o error → desactivar
                    fallidas += 1
                else:
                    guardadas += 1

                item.fecha_modifica = datetime.utcnow()
                db.session.add(item)
                procesadas += 1

            # Commit por lote
            try:
                db.session.commit()
            except Exception as e:
                db.session.rollback()
                print(f"[ERROR] Commit fallido: {e}")

            print(f"Progreso: {min(offset+BATCH_SIZE, total)}/{total} | OK={guardadas}, Fallidas={fallidas}")
            offset += BATCH_SIZE
            time.sleep(0.2)

    print(f"\n✅ Finalizado. Total={procesadas}, Guardadas={guardadas}, Fallidas={fallidas}")

# ----------------------------------------------------------------
def main():
    app = create_app()
    with app.app_context():
        procesar_herramientas()

if __name__ == "__main__":
    main()
