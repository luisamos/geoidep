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
    id_institucion, id_categoria, capa AS layer, '' AS nombre_capa,
    MAX(CASE WHEN id_tipo = 11 THEN url_pub END) AS wms,
    MAX(CASE WHEN id_tipo = 12 THEN url_pub END) AS wfs,
	MAX(CASE WHEN id_tipo = 14 THEN url_pub END) AS wmts,
	MAX(CASE WHEN id_tipo = 17 THEN url_pub END) AS arcgis,
	MAX(CASE WHEN id_tipo = 20 THEN url_pub END) AS kml
FROM tmp.datos
WHERE id_tipo IN (11,12,14,17,20)
AND url_pub IS NULL
GROUP BY id_institucion, id_categoria, capa
ORDER BY 1,4
LIMIT 5;

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

--
-- CONSULTA PRINCIPAL
--
-- 
DROP TABLE IF EXISTS tmp.resultado_servicios;

CREATE TABLE tmp.resultado_servicios AS
WITH base AS (
  SELECT
      id_institucion,
      id_categoria,
      capa,
      BOOL_OR(geo = 'SI') AS publicar_geoperu,          -- <- unifica por geo
      MAX(url_pub) FILTER (WHERE id_tipo = 11) AS wms,
      MAX(url_pub) FILTER (WHERE id_tipo = 12) AS wfs,
      MAX(url_pub) FILTER (WHERE id_tipo = 14) AS wmts,
      MAX(url_pub) FILTER (WHERE id_tipo = 17) AS arcgis,
      MAX(url_pub) FILTER (WHERE id_tipo = 20) AS kml
  FROM tmp.datos
  WHERE id_tipo IN (11,12,14,17,20)
  GROUP BY id_institucion, id_categoria, capa
),
enriquecida AS (
  SELECT
    b.*,
    dl.nombre_capa AS nombre_capa_def
  FROM base b
  LEFT JOIN LATERAL (
    SELECT d.nombre_capa
    FROM public.def_layer d
    WHERE d.capa = b.capa
      AND d.idestado = 1
      AND d.idsubsistema = 0
      AND LENGTH(d.nombre_capa) > 0
    LIMIT 1
  ) dl ON TRUE
),
ranked AS (
  SELECT
    e.*,
    ROW_NUMBER() OVER (
      PARTITION BY e.id_institucion, e.id_categoria, e.capa
      ORDER BY (e.wms IS NOT NULL) DESC,
               e.publicar_geoperu DESC,
               (e.nombre_capa_def IS NOT NULL) DESC
    ) AS rn
  FROM enriquecida e
  WHERE (e.wms IS NOT NULL OR e.nombre_capa_def IS NOT NULL)
)
SELECT
  ROW_NUMBER() OVER (ORDER BY id_institucion ASC, capa ASC) AS numero,
  id_institucion,
  id_categoria,
  publicar_geoperu,
  capa AS layer,
  CASE
    WHEN wms IS NULL THEN COALESCE(nombre_capa_def, '')
    ELSE '0'
  END AS nombre_capa,
  CASE
    WHEN wms IS NULL THEN 'https://espacialg.geoperu.gob.pe/geoserver/geoperu/wms?'
    ELSE wms
  END AS wms,
  wfs,
  wmts,
  arcgis,
  kml
FROM ranked
WHERE rn = 1
ORDER BY id_institucion ASC, layer ASC;

-- Refuerzo de unicidad (opcional pero recomendado)
CREATE UNIQUE INDEX ON tmp.resultado_servicios (id_institucion, id_categoria, layer);

-- Verificación
SELECT * FROM tmp.resultado_servicios ORDER BY numero;

-- Inserción en la tabla destino (sin cambios en tu flujo)
INSERT INTO ide.def_capas_geograficas
  (id, nombre, tipo_capa, publicar_geoperu, id_categoria, id_institucion, usuario_crea)
SELECT numero, layer, 1, publicar_geoperu, id_categoria, id_institucion, 1
FROM tmp.resultado_servicios
ORDER BY numero ASC;


SELECT * FROM tmp.resultado_servicios;

INSERT INTO ide.def_capas_geograficas(id, nombre, tipo_capa, publicar_geoperu, id_categoria, id_institucion, usuario_crea)
SELECT numero, layer, 1, publicar_geoperu, id_categoria, id_institucion, 1 FROM tmp.resultado_servicios ORDER BY numero ASC;


SELECT * FROM tmp.datos WHERE id_tipo = 14;

INSERT INTO ide.def_servicios_geograficos(id_capa, id_tipo_servicio, direccion_web, nombre_capa, titulo_capa, estado, usuario_crea)
SELECT numero, 11, wms AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE wms IS NOT NULL UNION
SELECT numero, 12, wfs AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE wfs IS NOT NULL UNION
SELECT numero, 14, wmts AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE wmts IS NOT NULL UNION
SELECT numero, 17, arcgis AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE arcgis IS NOT NULL UNION
SELECT numero, 20, kml AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE kml IS NOT NULL;



