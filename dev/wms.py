from owslib.wms import WebMapService

wms = WebMapService(
    #"https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Depositos_Relave/MapServer/WMSServer",
    "https://maps.inei.gob.pe/geoserver/T10Limites/pi_cpoblado/wms?service=WMS&request=GetCapabilities",
    version="1.3.0"
)

for name, layer in wms.contents.items():
    print({
        "id": name,
        "title": layer.title
    })