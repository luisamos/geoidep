INSERT INTO public.def_tipos_servicios (nombre, id_padre) VALUES
('Herramientas digitales', 0),
('Geoportal', 1),
('Aplicaciones y módulos', 1),
('Visor de mapas', 1),
('Descarga GIS (HTTPS, FTP)', 1),
('Servicios geográficos', 0),
('OGC:WMS', 2),
('OGC:WFS', 2),
('OGC:WCS', 2),
('OGC:WMTS', 2),
('OGC:CSW', 2),
('OGC:WPS', 2),
('REST:ArcGIS MapServer', 2),
('REST:ArcGIS FeatureServer', 2),
('REST:ArcGIS ImageServer', 2),
('REST:ArcGIS KML', 2),
('REST:ArcGIS Geoprocessing', 2),
('Otros servicios', 1);

SELECT id AS id_tipo_servicio, nombre FROM public.def_tipos_servicios WHERE id_padre=1;



