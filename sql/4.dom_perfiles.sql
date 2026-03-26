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
('Gestión de información',1,'20-03-2026',1,0,'',''),
('Plataformas tecnológicas',1,'20-03-2026',2,0,'',''),
('Monitoreo',1,'20-03-2026',3,0,'',''),
('Reportes',1,'20-03-2026',5,0,'',''),
('Entidades',1,'20-03-2026',4,0,'',''),
('Configuración',1,'20-03-2026',5,0,'',''),

-- Gestión de Información (id_padre = 1)
('Documentos',1,'20-03-2026',1,1,'description','documentos.listar'),
('Seguimiento',1,'20-03-2026',2,1,'timeline','seguimientos.listar'),

-- Plataformas tecnológicas (id_padre = 2)
('Herramientas Geográficas',1,'20-03-2026',1,2,'public','herramientas_geograficas.inicio'),
('Capas Geográficas',1,'20-03-2026',2,2,'layers','capas_geograficas.inicio'),

-- Monitoreo (id_padre = 3)
('Herramientas geográficas',1,'20-03-2026',1,3,'public','gestion.monitoreo_herramientas'),
('Servicios geográficas',1,'20-03-2026',2,3,'layers','gestion.monitoreo_servicios'),

-- Reportes (id_padre = 4)
('Seguimiento',1,'20-03-2026',1,4,'timeline','seguimientos.reportes'),

-- Entidades (id_padre = 5)
('Instituciones',1,'20-03-2026',1,5,'domain','instituciones.listar'),
('Usuarios',1,'20-03-2026',2,5,'group','usuarios.listar'),
('Roles',1,'20-03-2026',3,5,'security','roles.listar'),

-- Configuración (id_padre = 6)
('Mi cuenta',1,'20-03-2026',1,6,'account_circle','mi_cuenta.inicio');

SELECT * FROM ide.dom_roles WHERE id_padre = 4;

UPDATE ide.dom_roles SET enlace = 'seguimientos.listar' WHERE id = 13;

SELECT * FROM ide.aso_usuarios_roles;