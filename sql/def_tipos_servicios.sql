INSERT INTO ide.def_tipos_servicios (tag, sigla, nombre, descripcion, estado, id_padre, orden, usuario_crea, fecha_crea, logotipo) VALUES
('herramientas_digitales', null, 'Herramientas digitales', 'Son un conjunto de herramientas GIS que pertite compartir diferentes datos geográficos.', True, 0, 1, 1, '01-08-2025', null),
('servicios_ogc', null, 'Servicios OGC', 'Los servicios del Open Geospatial Consortium son estándares internacionales que permiten a diferentes sistemas compartir y acceder a datos e información geográfica a través de la web de forma abierta e interoperable.', True, 0, 2,  1, '01-08-2025', null),
('servicios_rest_arcgis', null, 'Servicios Rest de ArcGIS', 'Los Servicios REST de ArcGIS son una tecnología que permite a las aplicaciones conectarse y consultar datos y funcionalidades geográficas a través de la red usando el protocolo HTTP', True, 0, 3,  1, '01-08-2025', null),
('servicios_rest', null, 'Servicios Rest', 'Son servicios desarrollados propiamente por la entidad', True, 0, 4, 1, '01-08-2025', null),
('geoportales', 'Geoportales', 'Geoportales de entidades públicas', 'Portales públicos que comparten información geográfica y servicios especializados.', True, 1, 1,  1, '01-08-2025','captive_portal'),
('visores', 'Visores', 'Visores de mapas', 'Visores de mapas desarrollados por las instituciones públicas.', True, 1, 2,  1, '01-08-2025',  'jamboard_kiosk'),
('observatorios', 'Observatorio', 'Observatorios digitales', 'Un observatorio digital es una plataforma o sistema diseñado para recopilar, procesar, analizar y clasificar información de diversos entornos digitales con el fin de extraer conocimiento.', False, 1, 11,  1, '01-08-2025', 'mystery'),
('apps', 'Apps', 'Aplicaciones y módulos', 'Son los programas y herramientas de software que a través de módulos geográficos permiten crear, gestionar, analizar y visualizar datos georreferenciados en mapas.', True, 1, 3,  1, '01-08-2025', 'apps'),
('metadatos', 'Metadatos', 'Portal de metadatos', 'Es una aplicación en línea que permite a los usuarios buscar y acceder a información descriptiva (metadatos) sobre conjuntos de datos geográficos, como mapas, imágenes y capas de un Sistema de Información Geográfica (SIG).', True, 1, 16,  1, '01-08-2025', 'quick_reference_all'),
('descargas', 'Descargas GIS', 'Descarga GIS (HTTPS, FTP)', 'Es transferencia de archivos de Sistemas de Información Geográfica (GIS) a través de protocolos FTP y/o HTTPS.', True, 1, 17,  1, '01-08-2025', 'browser_updated'),
('servicios_ogc_wms', 'OGC:WMS', 'Servicio de visualización de mapas', 'El servicio OGC:WMS permite visualizar mapas en un visor o un software de Sistema de Información Geográfica - GIS.', True, 2, 4,  1, '01-08-2025', 'travel_explore'),
('servicios_ogc_wfs', 'OGC:WFS', 'Servicio de descarga por la web', 'El servicio OGC:WFS permite la descarga de datos vectoriales a través de la web. Los formatos compatibles.', True, 2, 5,  1, '01-08-2025','cloud_download'),
('servicios_ogc_wcs', 'OGC:WCS', 'Servicio de imagenes de mapas', 'El servicio OGC:WCS permite acceder a datos ráster georreferenciados en su formato de datos original.', False, 2, 9,  1, '01-08-2025', 'image_search'),
('servicios_ogc_wmts', 'OGC:WMTS', 'Servicio de mosaicos de mapas.', 'El servicio OGC:WMTS permite almacenar los datos (caché) para agilizar la carga de los mismos para una visualización en base a las peticiones de fecha y hora.', True, 2, 7,  1, '01-08-2025', 'satellite'),
('servicios_ogc_csw', 'OGC:CSW', 'Servicio de catalogación de metadatos.','El servicio OGC:CSW permite publicar y generar metadatos geográficos a través de la web.', False, 2, 8,  1, '01-08-2025', 'description'),
('servicios_ogc_wps', 'OGC:WPS', 'Servicio de geoprocesamiento', 'El servicio OGC:WPS permite procesar solicitudes para el procesamiento geoespacial.', False, 2, 10,  1, '01-08-2025', 'subtitles_gear'),
('servicios_rest_arcgis_mapserver', 'REST:ArcGIS Mapserver', 'Servicio REST:ArcGIS Mapserver', 'Es un conjunto de especificaciones de API que permiten a las aplicaciones comunicarse con los servicios de ubicación de ArcGIS a través de solicitudes HTTPS.', True, 3, 6,  1,'01-08-2025', 'map_search'),
('servicios_rest_arcgis_feature', 'REST:ArcGIS FeatureServer', 'Servicio REST:ArcGIS FeatureServer', 'Servicio Rest de acceso a mapas', False, 3, 12,  1, '01-08-2025', null),
('servicios_rest_arcgis_image', 'REST:ArcGIS ImageServer', 'Servicio REST:ArcGIS ImageServer', 'Servicio Rest de imagenes', False, 3, 13,  1, '01-08-2025', null),
('servicios_rest_arcgis_kml', 'REST:ArcGIS KML','Servicio REST:ArcGIS KML', 'Servicio Rest de ArcGIS que permite la exportación de datos en formato KML.', True, 3, 14,  1, '01-08-2025', 'file_json'),
('servicios_rest_arcgis_processing', 'REST:ArcGIS Geoprocessing', 'Servicio REST:ArcGIS Geoprocessing', 'Servicio Rest de ArcGIS de geoprocesamiento es una interfaz de servicios web que permite acceder y ejecutar herramientas de geoprocesamiento a través de una URL. Se basa en un modelo de recursos jerárquico.', False, 3, 15,  1, '01-08-2025', null),
('servicios_rest_api', 'REST:Api', 'Servicio REST:Api', 'Servicios Rest:Api es una interfaz de programación de aplicaciones (API) que se basa en el estilo arquitectónico REST (Transferencia de Estado Representacional) para permitir la comunicación entre sistemas a través de Internet.', True, 4, 16,  1, '01-08-2025', null);

SELECT id AS id_tipo_servicio, tag, sigla, nombre, descripcion, logotipo, orden, id_padre
FROM ide.def_tipos_servicios WHERE id_padre IN (1, 2, 3)
AND estado = True
ORDER BY orden ASC;

