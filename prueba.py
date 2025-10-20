import requests
import xml.etree.ElementTree as ET

url = "https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Ordenamiento_Forestal/MapServer/WMSServer?request=GetCapabilities&service=WMS"

try:
    # Obtener el documento XML
    response = requests.get(url)
    response.raise_for_status()  # Verificar errores HTTP

    # Parsear el XML
    root = ET.fromstring(response.content)

    # Definir namespace
    namespaces = {
        'wms': 'http://www.opengis.net/wms',
        'xlink': 'http://www.w3.org/1999/xlink'
    }

    # Buscar todos los layers
    layers = root.findall('.//wms:Layer', namespaces)
    capas = []

    for layer in layers:
        # Verificar si es queryable (atributo queryable="1")
        queryable = layer.get('queryable')
        if queryable == '1':
            name_elem = layer.find('wms:Name', namespaces)
            title_elem = layer.find('wms:Title', namespaces)
            
            if name_elem is not None and title_elem is not None:
                nombre = name_elem.text
                titulo = title_elem.text
                
                if nombre and titulo:  # Asegurar que no estén vacíos
                    capas.append({
                        'value': nombre,
                        'label': titulo
                    })

    # Mostrar resultado
    print("Capas queryables encontradas:")
    for capa in capas:
        print(f"Nombre: {capa['value']}, Título: {capa['label']}")

except requests.exceptions.RequestException as e:
    print(f"Error en la petición HTTP: {e}")
except ET.ParseError as e:
    print(f"Error al parsear XML: {e}")
except Exception as e:
    print(f"Error inesperado: {e}")