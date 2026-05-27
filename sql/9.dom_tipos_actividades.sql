SELECT * FROM ide.dom_perfiles;

INSERT INTO ide.dom_tipos_actividades(nombre, estado, orden, id_perfil, usuario_registro, fecha_registro) VALUES 
('Creación de usuarios', True, 1, 3, 1, '20-03-2026'),
('Creación del subsistema', True, 2, 3, 1, '20-03-2026'),
('Presentación de la plataforma', True, 3, 3, 1, '20-03-2026'),
('Recepción de datos', True, 4, 3, 1, '20-03-2026'),
('Procesamiento de capas', True, 5, 3, 1, '20-03-2026'),
('Publicación', True, 6, 3, 1, '20-03-2026'),
('Gestión de metadatos', True, 7, 3, 1, '20-03-2026'),
('Capacitación en herramientas GIS', True, 8, 3, 1, '20-03-2026');

SELECT * FROM ide.dom_tipos_actividades;