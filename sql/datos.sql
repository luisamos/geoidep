-- Table: tmp.datos

-- DROP TABLE IF EXISTS tmp.datos;

CREATE TABLE IF NOT EXISTS tmp.datos(
	id SERIAL PRIMARY KEY,
    n TEXT,
    grupo_tema TEXT,
    sub_tema TEXT,
    cod_capa TEXT,
    ide TEXT,
    geo TEXT,
    capa TEXT,
    sector TEXT,
    institucion TEXT,
    entidad TEXT,
    sub_ent TEXT,
    resp_inst TEXT,
    correo_inst TEXT,
    nro_inst TEXT,
    frec_act TEXT,
    fecha_reg TEXT,
    fecha_prox TEXT,
    paginaweb TEXT,
    url_pub TEXT,
    tipo_pub TEXT,
    nro_documento_recp TEXT,
    fecha_recepcion TEXT,
    responsable_proc TEXT,
    estado_proc TEXT,
    fecha_proc TEXT,
    responsable_pub TEXT,
    estado_pub_geo TEXT,
    fecha_pub_geo TEXT,
    estado_ide_proc TEXT,
    fecha_proc_ide TEXT,
    estado_pub_ide TEXT,
    fecha_pub_ide TEXT,
    descripcion TEXT,
    observacion TEXT,
    origen TEXT,
    tipo_entidad TEXT,
    estado_check TEXT,
    estado_servicio TEXT,
    estado_actu TEXT,
	id_institucion INTEGER,
	id_categoria INTEGER,
	id_tipo INTEGER
);

--\copy tmp.datos(n, grupo_tema, sub_tema, cod_capa, ide, geo, capa, sector, institucion, entidad, sub_ent, resp_inst, correo_inst, nro_inst, frec_act, fecha_reg, fecha_prox, paginaweb, url_pub, tipo_pub, nro_documento_recp, fecha_recepcion, responsable_proc, estado_proc, fecha_proc, responsable_pub, estado_pub_geo, fecha_pub_geo, estado_ide_proc, fecha_proc_ide, estado_pub_ide, fecha_pub_ide, descripcion, observacion, origen, tipo_entidad, estado_check, estado_servicio, estado_actu, id_categoria, id_institucion) FROM 'C:\apps\python\flask\geoidep\sql\datos.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

SELECT tipo_pub FROM tmp.datos
GROUP BY 1
ORDER BY 1;

SELECT * FROM ide.def_tipos_servicios WHERE id_padre = 1 ORDER BY orden;

UPDATE tmp.datos SET id_tipo = 5 WHERE tipo_pub = 'Geoportal';
UPDATE tmp.datos SET id_tipo = 6 WHERE tipo_pub = 'Geovisor';
UPDATE tmp.datos SET id_tipo = 9 WHERE tipo_pub = 'CSW (Catálogo de Metadatos)';
UPDATE tmp.datos SET id_tipo = 10 WHERE tipo_pub = 'Descarga GIS';

--
-- HERRAMIENTAS DIGITALES
--
INSERT INTO ide.def_herramientas_digitales(
	id_tipo_servicio, nombre, descripcion, estado, recurso, id_institucion, id_categoria)
SELECT id_tipo, capa, descripcion, 1, url_pub, id_institucion, id_categoria FROM tmp.datos
WHERE id_tipo IN (5,6,9,10) AND url_pub IS NOT NULL
GROUP BY 1,2,3,4,5,6,7;

-- 
-- SERVICIOS GEOGRAFICOS
--
SELECT * FROM ide.def_tipos_servicios WHERE id_padre IN (2,3) ORDER BY orden;

UPDATE tmp.datos SET id_tipo = 11 WHERE tipo_pub = 'Servicio WMS';
UPDATE tmp.datos SET id_tipo = 12 WHERE tipo_pub = 'Servicio WFS';
UPDATE tmp.datos SET id_tipo = 14 WHERE tipo_pub = 'Servicio WMTS';
UPDATE tmp.datos SET id_tipo = 17 WHERE tipo_pub = 'ArcGIS REST' OR tipo_pub = 'Arcgis REST';
UPDATE tmp.datos SET id_tipo = 20 WHERE tipo_pub = 'KML';
UPDATE tmp.datos SET id_tipo = 11 WHERE tipo_pub = 'Geoprocesamiento';--GEOPERU

SELECT
    ROW_NUMBER() OVER () AS numero,
    id_institucion, id_categoria, capa AS layer,
	--origen,
    MAX(CASE WHEN id_tipo = 11 THEN url_pub END) AS wms,
    MAX(CASE WHEN id_tipo = 12 THEN url_pub END) AS wfs,
	MAX(CASE WHEN id_tipo = 14 THEN url_pub END) AS wmts,
	MAX(CASE WHEN id_tipo = 17 THEN url_pub END) AS arcgis,
	MAX(CASE WHEN id_tipo = 20 THEN url_pub END) AS kml
FROM tmp.datos
WHERE id_tipo IN (11,12,14,17,20)
AND url_pub IS NULL
GROUP BY id_institucion, id_categoria, capa
ORDER BY 4;

UPDATE tmp.datos SET url_pub= NULL WHERE url_pub= 'Sin enlace' OR url_pub= '';
ALTER TABLE tmp.datos ADD COLUMN nombre_layer TEXT;

SELECT * FROM tmp.datos WHERE capa LIKE ('%Otros Usos%');

SELECT * FROM public.def_layer;

SELECT a.id_institucion, a.capa, b.capa, b.nombre_capa
FROM tmp.datos a
INNER JOIN public.def_layer b
ON a.capa = b.capa
WHERE a.id_tipo = 11 AND b.idestado = 1 AND b.idsubsistema= 0 AND url_pub IS NULL AND LENGTH(b.nombre_capa)>0
ORDER BY 1,2;

SELECT * FROM def_tipocapa;

