-- 1) Vaciar en orden (hijo -> padre)

TRUNCATE TABLE ide.def_servicios_geograficos, ide.def_capas_geograficas RESTART IDENTITY CASCADE;

-- 2) Cargar capas (padre)
--\copy ide.def_capas_geograficas (id, nombre, descripcion, tipo_capa, fecha_inicio, id_categoria, id_institucion, usuario_registro, fecha_registro) FROM 'C:\apps\python\flask\geoidep\sql\capas_geograficas.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL 'NULL', ENCODING 'UTF8');

-- 3) Cargar servicios (hijo)
--\copy ide.def_servicios_geograficos (id, id_capa_geografica, id_tipo, direccion_web, nombre_capa, titulo_capa, estado, id_layer, usuario_registro, fecha_registro) FROM 'C:\apps\python\flask\geoidep\sql\servicios_geograficos.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL 'NULL', ENCODING 'UTF8');

-- 4) Ajustar secuencias (IMPORTANTE si tus PK usan serial/identity con sequence)
SELECT setval(pg_get_serial_sequence('ide.def_capas_geograficas','id'),
              (SELECT COALESCE(MAX(id),1) FROM ide.def_capas_geograficas), true);

SELECT setval(pg_get_serial_sequence('ide.def_servicios_geograficos','id'),
              (SELECT COALESCE(MAX(id),1) FROM ide.def_servicios_geograficos), true);

-- Validación rápida
SELECT 'capas_geograficas' tabla, COUNT(*) total FROM ide.def_capas_geograficas
UNION ALL
SELECT 'servicios_geograficos' tabla, COUNT(*) total FROM ide.def_servicios_geograficos;

SELECT *, b.* 
FROM ide.def_capas_geograficas a
INNER JOIN ide.def_servicios_geograficos b
ON a.id = b.id_capa 
WHERE nombre ILIKE ('%Unidad Ofertada%');

SELECT * FROM ide.def_servicios_geograficos WHERE direccion_web ILIKE '%https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0802/MapServer/WMSServer?request=GetCapabilities&service=WMS%';

SELECT * FROM ide.def_servicios_geograficos
WHERE direccion_web ILIKE '%http://giserver.proviasnac.gob.pe/%';

UPDATE ide.def_servicios_geograficos
SET direccion_web = REPLACE(direccion_web, 'http://', 'https://')
WHERE direccion_web ILIKE '%http://giserver.proviasnac.gob.pe/%';




