import asyncio
import random
import aiohttp
from lxml import etree

CANDIDATE_CAPS_URLS = [
    "https://maps.inei.gob.pe/geoserver/T10Limites/pi_cpoblado/wfs?service=WFS&request=GetCapabilities",
]

HEADERS = {
    # Muchos WAF bloquean agentes "vacíos" o muy genéricos
    "User-Agent": ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                   "AppleWebKit/537.36 (KHTML, like Gecko) "
                   "Chrome/120.0 Safari/537.36"),
    "Accept": "application/xml,text/xml,*/*;q=0.8",
    "Accept-Language": "es-ES,es;q=0.9,en;q=0.7",
    "Connection": "keep-alive",
}

def extract_featuretypes(xml_text: str) -> list[str]:
    parser = etree.XMLParser(recover=True, huge_tree=True)
    root = etree.fromstring(xml_text.encode("utf-8", errors="ignore"), parser=parser)

    # No depender de prefijos: usar local-name()
    nodes = root.xpath("//*[local-name()='FeatureTypeList']/*[local-name()='FeatureType']")
    names = []
    for ft in nodes:
        name = ft.xpath("string(./*[local-name()='Name'])").strip()
        if name:
            names.append(name)
    return names

async def fetch_with_retries(session, url, max_attempts=3):
    timeout = aiohttp.ClientTimeout(total=30, connect=10, sock_read=20)
    last_error = None

    for attempt in range(1, max_attempts + 1):
        try:
            async with session.get(url, headers=HEADERS, timeout=timeout, allow_redirects=True) as r:
                # Si un WAF devuelve HTML, igual lo leemos y diagnosticamos
                text = await r.text(errors="ignore")
                if r.status >= 400:
                    raise aiohttp.ClientResponseError(
                        request_info=r.request_info,
                        history=r.history,
                        status=r.status,
                        message=f"HTTP {r.status}",
                        headers=r.headers
                    )
                return text, r.headers.get("Content-Type", "")
        except Exception as e:
            last_error = e
            # Backoff con jitter
            await asyncio.sleep((0.7 * attempt) + random.random())

    raise last_error

async def discover_wfs_layers():
    async with aiohttp.ClientSession() as session:
        for url in CANDIDATE_CAPS_URLS:
            try:
                xml_text, ctype = await fetch_with_retries(session, url)
                # Heurística: si no parece XML, probablemente WAF/HTML
                if "<WFS_Capabilities" not in xml_text and "FeatureTypeList" not in xml_text:
                    # Diagnóstico simple
                    print(f"[WARN] Respuesta no parece WFS XML en: {url} (Content-Type: {ctype})")
                    print(xml_text[:300])
                    continue

                layers = extract_featuretypes(xml_text)
                if layers:
                    return {"capabilities_url": url, "layers": layers}
            except Exception as e:
                print(f"[FAIL] {url} -> {type(e).__name__}: {e}")

    return None

async def main():
    result = await discover_wfs_layers()
    if not result:
        print("No se pudo obtener GetCapabilities desde ninguno de los endpoints probados.")
        return

    print("GetCapabilities OK:", result["capabilities_url"])
    print("Total layers (FeatureTypes):", len(result["layers"]))
    print("Layers:", result["layers"])
    print("Layers:", result["layers"])

if __name__ == "__main__":
    asyncio.run(main())
