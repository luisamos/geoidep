--\copy ide.def_herramientas_geograficas (id,id_tipo, nombre, descripcion, estado, recurso, id_categoria, id_institucion, usuario_registro, fecha_registro) FROM 'C:\apps\python\flask\geoidep\sql\herramientas_geograficas.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL 'NULL', ENCODING 'UTF8');

SELECT * FROM ide.def_herramientas_geograficas
WHERE recurso ILIKE '%http://giserver.proviasnac.gob.pe/%';

UPDATE ide.def_herramientas_geograficas
SET recurso = REPLACE(recurso, 'http://', 'https://')
WHERE recurso ILIKE '%http://giserver.proviasnac.gob.pe/%';

SELECT * FROM ide.def_herramientas_geograficas
WHERE recurso ILIKE '%http://escale.minedu.gob.pe/%';

UPDATE ide.def_herramientas_geograficas
SET recurso = REPLACE(recurso, 'http://', 'https://')
WHERE recurso ILIKE '%http://escale.minedu.gob.pe/%';
