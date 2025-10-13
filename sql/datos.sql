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
    fecha_reg DATE,
    fecha_prox DATE,
    paginaweb TEXT,
    url_pub TEXT,
    tipo_pub TEXT,
    nro_documento_recp TEXT,
    fecha_recepcion DATE,
    responsable_proc TEXT,
    estado_proc TEXT,
    fecha_proc DATE,
    responsable_pub TEXT,
    estado_pub_geo TEXT,
    fecha_pub_geo DATE,
    estado_ide_proc TEXT,
    fecha_proc_ide DATE,
    estado_pub_ide TEXT,
    fecha_pub_ide DATE,
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

--\copy tmp.datos(n, grupo_tema, sub_tema, cod_capa, ide, geo, capa, sector, institucion, entidad, sub_ent, resp_inst, correo_inst, nro_inst, frec_act, fecha_reg, fecha_prox, paginaweb, url_pub, tipo_pub, nro_documento_recp, fecha_recepcion, responsable_proc, estado_proc, fecha_proc, responsable_pub, estado_pub_geo, fecha_pub_geo, estado_ide_proc, fecha_proc_ide, estado_pub_ide, fecha_pub_ide, descripcion, observacion, origen, tipo_entidad, estado_check, estado_servicio, estado_actu, id_categoria, id_institucion) FROM 'C:\apps\python\flask\geoidep\sql\datos.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

SELECT tipo_pub FROM tmp.datos
GROUP BY 1
ORDER BY 1;

SELECT * FROM ide.def_tipos_servicios WHERE id_padre = 2 ORDER BY orden;

UPDATE tmp.datos SET id_tipo = 4 WHERE tipo_pub = 'Geoportal';
UPDATE tmp.datos SET id_tipo = 5 WHERE tipo_pub = 'Geovisor';
UPDATE tmp.datos SET id_tipo = 6 WHERE tipo_pub = 'Dashboard';
UPDATE tmp.datos SET id_tipo = 7 WHERE tipo_pub = 'Descarga GIS';

UPDATE tmp.datos SET id_tipo = 8 WHERE tipo_pub = 'Servicio WMS';
UPDATE tmp.datos SET id_tipo = 9 WHERE tipo_pub = 'Servicio WFS';
UPDATE tmp.datos SET id_tipo = 11 WHERE tipo_pub = 'Servicio WMTS';
UPDATE tmp.datos SET id_tipo = 12 WHERE tipo_pub = 'CSW (Catálogo de Metadatos)';
--GEOPERU
UPDATE tmp.datos SET id_tipo = 18 WHERE tipo_pub = 'Geoprocesamiento';

UPDATE tmp.datos SET id_tipo = 14 WHERE tipo_pub = 'ArcGIS REST' OR tipo_pub = 'Arcgis REST';
UPDATE tmp.datos SET id_tipo = 17 WHERE tipo_pub = 'KML';


INSERT INTO ide.def_herramientas_digitales(
	id_tipo_servicio, nombre, descripcion, estado, recurso, id_institucion, id_categoria)
SELECT id_tipo, capa, descripcion, 1, url_pub, id_institucion, id_categoria FROM tmp.datos
WHERE id_tipo IN (4,5,6,7)
GROUP BY 1,2,3,4,5,6,7;

SELECT * FROM tmp.datos WHERE id_tipo IN (8,9,11,12)
GROUP BY estado_actu;

SELECT
    ROW_NUMBER() OVER () AS numero,
    capa AS layer,
	--origen,
    MAX(CASE WHEN id_tipo = 8 THEN url_pub END) AS wms,
    MAX(CASE WHEN id_tipo = 9 THEN url_pub END) AS wfs,
	MAX(CASE WHEN id_tipo = 11 THEN url_pub END) AS wmts,
	MAX(CASE WHEN id_tipo = 11 THEN url_pub END) AS wmts,
FROM tmp.datos
WHERE geo = 'SI' AND id_tipo IN (8,9,11,12)
GROUP BY capa--, origen
ORDER BY capa;



SELECT * FROM ide.def_instituciones;


