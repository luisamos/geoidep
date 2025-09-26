INSERT INTO public.def_tipos_servicios (nombre, id_padre) VALUES
('Herramientas digitales', 0),
('Geoportal', 1),
('Aplicaciones y módulos', 1),
('Portal de metadatos', 1),
('Visor de mapas', 1),
('Catalogo de metadatos', 1),
('GoogleMap', 1),
('Servicios geográficos', 0),
('OGC:WMS', 2),
('OGC:WFS', 2),
('OGC:WCS', 2),
('OGC:WMTS', 2),
('REST:ArcGIS', 2),
('Otros servicios', 1);

SELECT id AS id_tipo_servicio, nombre FROM public.def_tipos_servicios WHERE id_padre=1;



