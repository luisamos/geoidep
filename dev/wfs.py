import certifi
import owslib.util

# Forzar a OWSLib/requests a usar el CA bundle de certifi
owslib.util.requests_ca_bundle = certifi.where()

from owslib.wfs import WebFeatureService

url = "https://maps.inei.gob.pe/geoserver/T10Limites/ig_cpoblado/wfs"
wfs = WebFeatureService(url=url, version="2.0.0")

print("OK:", wfs.version, len(wfs.contents))


for name, ft in wfs.contents.items():
    print({
        "name": name,                 # esto es el ID real (tipo workspace:capa)
        "title": ft.title,
        "defaultCRS": getattr(ft, "defaultCRS", None),
    })
