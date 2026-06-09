import json
import csv
import requests
from datetime import datetime

URL = "https://www.serpost.com.pe/Cliente/RedOficina/GetOficinas"
OUT_GEOJSON = "./dev/serpost_oficinas.geojson"
RAW_DUMP = "./dev/serpost_raw_response.txt"
LOG_TXT = "./dev/serpost_omitidos.log"
LOG_CSV = "./dev/serpost_omitidos.csv"

def to_float(x):
    if x is None:
        return None
    if isinstance(x, (int, float)):
        return float(x)
    s = str(x).strip().replace(",", ".")
    if s == "" or s.lower() in ("null", "none", "nan"):
        return None
    try:
        return float(s)
    except ValueError:
        return None

def try_parse_json(text):
    try:
        return json.loads(text)
    except Exception:
        try:
            inner = json.loads(text)
            if isinstance(inner, str):
                return json.loads(inner)
            return inner
        except Exception:
            return None

def extract_items(data):
    if isinstance(data, list):
        return data

    if isinstance(data, dict):
        for k in ("data", "Data", "result", "results", "d", "items"):
            v = data.get(k)
            if isinstance(v, list):
                return v
            if isinstance(v, str):
                parsed = try_parse_json(v)
                if isinstance(parsed, list):
                    return parsed

        if len(data) == 1:
            v = next(iter(data.values()))
            if isinstance(v, list):
                return v
            if isinstance(v, str):
                parsed = try_parse_json(v)
                if isinstance(parsed, list):
                    return parsed

        for v in data.values():
            if isinstance(v, list):
                return v
            if isinstance(v, str):
                parsed = try_parse_json(v)
                if isinstance(parsed, list):
                    return parsed

    if isinstance(data, str):
        parsed = try_parse_json(data)
        if isinstance(parsed, list):
            return parsed

    return None

def main():
    headers = {
        "Accept": "application/json, text/plain, */*",
        "User-Agent": "Mozilla/5.0",
        "X-Requested-With": "XMLHttpRequest",
        "Referer": "https://www.serpost.com.pe/",
    }

    r = requests.get(URL, headers=headers, timeout=60)

    with open(RAW_DUMP, "w", encoding="utf-8") as f:
        f.write(r.text)

    r.raise_for_status()

    try:
        data = r.json()
    except Exception:
        data = try_parse_json(r.text)

    items = extract_items(data)
    if not isinstance(items, list):
        raise ValueError("No se pudo interpretar la estructura del JSON.")

    features = []
    omitted = []  # lista de dicts para log

    for row in items:
        if not isinstance(row, dict):
            omitted.append({
                "motivo": "fila no dict",
                "registro": str(row)
            })
            continue

        lat = to_float(row.get("PLATITUD"))
        lon = to_float(row.get("PLONGITUD"))

        if lat is None or lon is None:
            omitted.append({
                "motivo": "lat/lon inválidas",
                "IDOFICINA": row.get("IDOFICINA"),
                "PLATITUD": row.get("PLATITUD"),
                "PLONGITUD": row.get("PLONGITUD"),
                "PTODPTO": row.get("PTODPTO"),
                "PTOPROV": row.get("PTOPROV"),
                "PTODIST": row.get("PTODIST"),
            })
            continue

        props = dict(row)
        props["lat"] = lat
        props["lon"] = lon

        features.append({
            "type": "Feature",
            "geometry": {"type": "Point", "coordinates": [lon, lat]},
            "properties": props
        })

    # === GEOJSON ===
    geojson = {
        "type": "FeatureCollection",
        "name": "serpost_oficinas",
        "crs": {"type": "name", "properties": {"name": "EPSG:4326"}},
        "features": features
    }

    with open(OUT_GEOJSON, "w", encoding="utf-8") as f:
        json.dump(geojson, f, ensure_ascii=False, indent=2)

    # === LOG TXT ===
    with open(LOG_TXT, "w", encoding="utf-8") as f:
        f.write(f"Log generado: {datetime.now().isoformat()}\n")
        f.write(f"Total registros omitidos: {len(omitted)}\n\n")
        for o in omitted:
            f.write(json.dumps(o, ensure_ascii=False) + "\n")

    # === LOG CSV ===
    if omitted:
        keys = sorted({k for o in omitted for k in o.keys()})
        with open(LOG_CSV, "w", encoding="utf-8", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=keys)
            writer.writeheader()
            writer.writerows(omitted)

    # === RESUMEN CONSOLA ===
    print(f"OK: {len(features)} puntos exportados a {OUT_GEOJSON}")
    print(f"Registros omitidos: {len(omitted)}")
    if omitted:
        print("Ejemplo de omitidos:")
        for o in omitted[:5]:
            print(" -", o)

if __name__ == "__main__":
    main()
