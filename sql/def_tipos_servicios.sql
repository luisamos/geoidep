INSERT INTO ide.def_tipos_servicios (nombre, descripcion, estado, id_padre, orden, usuario_crea, fecha_crea, logotipo) VALUES
('Herramientas digitales', 'Son un conjunto de herramientas GIS que pertite compartir diferentes datos geográficos.', True, 0, 1, 1, '01-08-2025', null),
('Servicios OGC', 'Los servicios del Open Geospatial Consortium son estándares internacionales que permiten a diferentes sistemas compartir y acceder a datos e información geográfica a través de la web de forma abierta e interoperable.', True, 0, 2,  1, '01-08-2025', null),
('Servicios Rest de ArcGIS', 'Los Servicios REST de ArcGIS son una tecnología que permite a las aplicaciones conectarse y consultar datos y funcionalidades geográficas a través de la red usando el protocolo HTTP', True, 0, 3,  1, '01-08-2025', null),
('Servicios Rest', 'Son servicios desarrollados propiamente por la entidad', True, 0, 4, 1, '01-08-2025', null),
('Geoportales de entidades públicas', 'Portales públicos que comparten información geográfica y servicios especializados.', True, 1, 1,  1, '01-08-2025','captive_portal'),
('Visores de mapas', 'Visores de mapas institucionales.', True, 1, 2,  1, '01-08-2025',  'jamboard_kiosk'),
('Observatorios digitales', 'Un observatorio digital es una plataforma o sistema diseñado para recopilar, procesar, analizar y clasificar información de diversos entornos digitales con el fin de extraer conocimiento y apoyar la toma de decisiones', True, 1, 3,  1, '01-08-2025', 'mystery'),
('Aplicaciones y módulos', 'Aplicaciones GIS y módulos geográficos.', True, 1, 4,  1, '01-08-2025', 'apps'),
('Portal de metadatos', 'Portal de metadatos geográficos.', True, 1, 4,  1, '01-08-2025', 'quick_reference_all'),
('Descarga GIS (HTTPS, FTP)', 'Servicio de descarga.', True, 1, 5,  1, '01-08-2025', 'browser_updated'),
('Servicio de visualiación de mapas', 'El servicio OGC:WMS permite visualizar mapas en un visor o un software de Sistema de Información Geográfica - GIS.', True, 2, 1,  1, '01-08-2025', 'travel_explore'),
('Servicio de descarga por la web', 'El servicio OGC:WFS permite la descarga de datos vectoriales a través de la web. Los formatos compatibles.', True, 2, 2,  1, '01-08-2025','cloud_download'),
('Servicio de imagenes de mapas', 'El servicio OGC:WCS permite acceder a datos ráster georreferenciados en su formato de datos original.', False, 2, 3,  1, '01-08-2025', 'image_search'),
('Servicio de mosaicos de mapas.', 'El servicio OGC:WMTS permite almacenar los datos (caché) para agilizar la carga de los mismos para una visualización en base a las peticiones de fecha y hora.', True, 2, 4,  1, '01-08-2025', 'satellite'),
('Servicio de catalogación de metadatos.','El servicio OGC:CSW permite publicar y generar metadatos geográficos a través de la web.', False, 2, 5,  1, '01-08-2025', 'description'),
('Servicio de geoprocesamiento', 'El servicio OGC:WPS permite procesar solicitudes para el procesamiento geoespacial.', False, 2, 6,  1, '01-08-2025', 'subtitles_gear'),
('Servicio REST:ArcGIS Mapserver', 'Es un conjunto de especificaciones de API que permiten a las aplicaciones comunicarse con los servicios de ubicación de ArcGIS a través de solicitudes HTTPS.', True, 3, 1,  1,'01-08-2025', 'map_search'),
('Servicio REST:ArcGIS FeatureServer', 'Servicio Rest de acceso a mapas', False, 3, 2,  1,'01-08-2025', null),
('Servicio REST:ArcGIS ImageServer', 'Servicio Rest de imagenes', False, 3, 3,  1, '01-08-2025', null),
('Servicio REST:ArcGIS KML', 'Servicio Rest de exportación a formato KML', True, 3, 4,  1, '01-08-2025', null),
('Servicio REST:ArcGIS Geoprocessing', 'Servicio Rest de geoprocesamiento', False, 3, 5,  1, '01-08-2025', null),
('Servicio REST:API', 'Servicios Rest:Api', True, 4, 6,  1, '01-08-2025', null);

SELECT id, nombre FROM ide.def_tipos_servicios WHERE id_padre IN (2,3);

SELECT id AS id_tipo_servicio, nombre
FROM ide.def_tipos_servicios WHERE id_padre IN (1, 2,3) AND estado = True ORDER BY id ASC;