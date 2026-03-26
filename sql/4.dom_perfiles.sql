INSERT INTO ide.dom_perfiles(nombre, estado, usuario_registro, fecha_registro) VALUES
('Administrador', False, 1, '01-08-2025'),
('Coordinador', True, 1, '01-08-2025'),
('Especialista TI', True, 1, '01-08-2025'),
('Especialista IDE', True, 1, '01-08-2025'),
('Especialista GEOPERU', True, 1, '01-08-2025'),
('Especialista PNDA', True, 1, '01-08-2025'),
('Gestor de información', True, 1, '01-08-2025');

INSERT INTO ide.dom_roles(nombre, usuario_registro, fecha_registro, orden, id_padre, logotipo, enlace) VALUES
-- Módulos principales
('Gestión de información',1,'20-03-2026',1,0,''),
('Plataformas tecnológicas',1,'20-03-2026',2,0,''),
('Monitoreo',1,'20-03-2026',3,0,''),
('Entidades',1,'20-03-2026',4,0,''),
('Configuración',1,'20-03-2026',5,0,''),

-- Gestión de Información (id_padre = 1)
('Documentos',1,'20-03-2026',1,1,'description','documentos.listar'),
('Seguimiento',1,'20-03-2026',2,1,'timeline','seguimientos.listar'),

-- Plataformas tecnológicas (id_padre = 2)
('Herramientas Geográficas',1,'20-03-2026',1,2,'public','herramientas_geograficas.inicio'),
('Capas Geográficas',1,'20-03-2026',2,2,'layers','capas_geograficas.inicio'),

-- Monitoreo (id_padre = 3)
('Herramientas geográficas',1,'20-03-2026',1,3,'public','gestion.monitoreo_herramientas'),
('Servicios geográficas',1,'20-03-2026',2,3,'layers','gestion.monitoreo_servicios'),

-- Entidades (id_padre = 4)
('Instituciones',1,'20-03-2026',1,4,'domain','instituciones.listar'),
('Usuarios',1,'20-03-2026',2,4,'group','usuarios.listar'),
('Roles',1,'20-03-2026',1,4,'security','roles.listar'),

-- Configuración (id_padre = 5)
('Mi cuenta',1,'20-03-2026',2,5,'account_circle','mi_cuenta.inicio');