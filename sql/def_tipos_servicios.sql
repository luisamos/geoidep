INSERT INTO public.def_tipos_servicios (nombre,descripcion, estado, id_padre) VALUES
('Herramientas digitales', 'Son un conjunto de herramientas GIS que pertite compartir diferentes datos geográficos.', 1, 0),
('Servicios OGC', 'Los servicios del Open Geospatial Consortium son estándares internacionales que permiten a diferentes sistemas compartir y acceder a datos e información geográfica a través de la web de forma abierta e interoperable.', 1, 0),
('Servicios Rest de ArcGIS', 'Los Servicios REST de ArcGIS son una tecnología que permite a las aplicaciones conectarse y consultar datos y funcionalidades geográficas a través de la red usando el protocolo HTTP', 1, 0),
('Geoportales', 'Geoportales de entidades públicas.', 1, 1),
('Aplicaciones y módulos', 'Aplicaciones GIS y módulos geográficos.', 1, 1),
('Visores de mapas', 'Visores de mapas institucionales.', 1, 1),
('Descarga GIS (HTTPS, FTP)', 'Servicio de descarga.', 1, 1),

('OGC:WMS', 'Servicio de visualización de mapas.' 2),
('OGC:WFS', 'Servicio de consulta y descarga de mapas.', 2),
('OGC:WCS', 'Servicio de imagenes de mapas.', 1, 2),
('OGC:WMTS', 'servicio de mosaicos de mapas.', 1, 2),
('OGC:CSW', 'Servicio de catalogación de metadatos.', 1, 2),
('OGC:WPS', 'Servicio de geoprocesamiento', 1, 2),

('REST:ArcGIS MapServer', 'Servicio Rest de visualización de mapas', 1, 3),
('REST:ArcGIS FeatureServer', 'Servicio Rest de acceso a mapas', 1, 3),
('REST:ArcGIS ImageServer', 'Servicio Rest de imagenes', 1, 3),
('REST:ArcGIS KML', 'Servicio Rest de exportación a formato KML' 3),
('REST:ArcGIS Geoprocessing', 'Servicio Rest de geoprocesamiento', 1, 3);

SELECT id AS id_tipo_servicio, nombre FROM public.def_tipos_servicios WHERE id_padre=1;