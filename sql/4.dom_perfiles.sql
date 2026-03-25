INSERT INTO ide.dom_perfiles(nombre, usuario_registro, fecha_registro) VALUES
('Administrador', 1, '01-08-2025'),
('Coordinador', 1, '01-08-2025'),
('Especialista', 1, '01-08-2025'),
('Gestor de información', 1, '01-08-2025');

INSERT INTO ide.dom_roles(nombre, usuario_registro, fecha_registro, orden, id_padre, logotipo) VALUES
-- Módulos principales
('Gestión de información',1,'20-03-2026',1,0,''),
('Plataformas tecnológicas',1,'20-03-2026',2,0,''),
('Monitoreo',1,'20-03-2026',3,0,''),
('Entidades',1,'20-03-2026',4,0,''),
('Configuración',1,'20-03-2026',5,0,''),

-- Gestión de Información (id_padre = 1)
('Documentos',1,'20-03-2026',1,1,'description'),
('Seguimiento',1,'20-03-2026',2,1,'timeline'),

-- Plataformas tecnológicas (id_padre = 2)
('Herramientas Geográficas',1,'20-03-2026',1,2,'public'),
('Capas Geográficas',1,'20-03-2026',2,2,'layers'),

-- Monitoreo (id_padre = 3)
('Herramientas geográficas',1,'20-03-2026',1,3,'public'),
('Servicios geográficas',1,'20-03-2026',2,3,'layers'),

-- Entidades (id_padre = 4)
('Instituciones',1,'20-03-2026',1,4,'domain'),
('Personal',1,'20-03-2026',2,4,'badge'),
('Usuarios',1,'20-03-2026',3,4,'group'),

-- Configuración (id_padre = 5)
('Roles',1,'20-03-2026',1,5,'security'),
('Mi cuenta',1,'20-03-2026',2,5,'account_circle');