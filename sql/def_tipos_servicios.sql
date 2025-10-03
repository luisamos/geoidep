INSERT INTO public.def_tipos_servicios (nombre, descripcion, estado, id_padre, orden) VALUES
('Herramientas digitales', 'Son un conjunto de herramientas GIS que pertite compartir diferentes datos geográficos.', True, 0, 1),
('Servicios OGC', 'Los servicios del Open Geospatial Consortium son estándares internacionales que permiten a diferentes sistemas compartir y acceder a datos e información geográfica a través de la web de forma abierta e interoperable.', True, 0, 2),
('Servicios Rest de ArcGIS', 'Los Servicios REST de ArcGIS son una tecnología que permite a las aplicaciones conectarse y consultar datos y funcionalidades geográficas a través de la red usando el protocolo HTTP', True, 0, 3),
('Geoportales', 'Geoportales de entidades públicas.', True, 1, 1),
('Visores de mapas', 'Visores de mapas institucionales.', True, 1, 2),
('Aplicaciones y módulos', 'Aplicaciones GIS y módulos geográficos.', True, 1, 3),
('Descarga GIS (HTTPS, FTP)', 'Servicio de descarga.', True, 1, 4),

('OGC:WMS', 'Servicio de visualización de mapas.', True, 2, 1),
('OGC:WFS', 'Servicio de consulta y descarga de mapas.', True, 2, 2),
('OGC:WCS', 'Servicio de imagenes de mapas.', True, 2, 3),
('OGC:WMTS', 'servicio de mosaicos de mapas.', True, 2, 4),
('OGC:CSW', 'Servicio de catalogación de metadatos.', True, 2, 5),
('OGC:WPS', 'Servicio de geoprocesamiento', True, 2, 6),

('REST:ArcGIS MapServer', 'Servicio Rest de visualización de mapas', True, 3, 1),
('REST:ArcGIS FeatureServer', 'Servicio Rest de acceso a mapas', True, 3, 2),
('REST:ArcGIS ImageServer', 'Servicio Rest de imagenes', True, 3, 3),
('REST:ArcGIS KML', 'Servicio Rest de exportación a formato KML', True, 3, 4),
('REST:ArcGIS Geoprocessing', 'Servicio Rest de geoprocesamiento', True, 3, 5);

SELECT id AS id_tipo_servicio, nombre FROM public.def_tipos_servicios WHERE id_padre=1;