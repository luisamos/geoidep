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

--\copy tmp.datos(n, grupo_tema, sub_tema, cod_capa, ide, geo, capa, sector, institucion, entidad, sub_ent, resp_inst, correo_inst, nro_inst, frec_act, fecha_reg, fecha_prox, paginaweb, url_pub, tipo_pub, nro_documento_recp, fecha_recepcion, responsable_proc, estado_proc, fecha_proc, responsable_pub, estado_pub_geo, fecha_pub_geo, estado_ide_proc, fecha_proc_ide, estado_pub_ide, fecha_pub_ide, descripcion, observacion, origen, tipo_entidad, estado_check, estado_servicio, estado_actu, id_institucion, id_categoria) FROM 'C:\apps\python\flask\geoidep\sql\datos.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

SELECT tipo_pub FROM tmp.datos
GROUP BY 1
ORDER BY 1;

SELECT * FROM tmp.datos 
WHERE tipo_pub IN ('Infografía', 'Mapas web', 'Otros tipos de servicios')
ORDER BY tipo_pub;

SELECT * FROM tmp.datos 
WHERE id_categoria = 77
ORDER BY tipo_pub;

SELECT * FROM ide.def_tipos_servicios WHERE id_padre = 1 ORDER BY orden;

UPDATE tmp.datos SET id_tipo = 5 WHERE tipo_pub = 'Geoportal';
UPDATE tmp.datos SET id_tipo = 6 WHERE tipo_pub = 'Geovisor' OR tipo_pub = 'Mapas web';
UPDATE tmp.datos SET id_tipo = 8 WHERE tipo_pub = 'Infografía' OR tipo_pub = 'Otros tipos de servicios';
UPDATE tmp.datos SET id_tipo = 9 WHERE tipo_pub = 'CSW (Catálogo de Metadatos)';
UPDATE tmp.datos SET id_tipo = 10 WHERE tipo_pub = 'Descarga GIS';

--
-- HERRAMIENTAS DIGITALES
--
INSERT INTO ide.def_herramientas_digitales(
	id_tipo_servicio, nombre, descripcion, estado, recurso, id_institucion, id_categoria)
SELECT id_tipo, capa, descripcion, True, url_pub, id_institucion, id_categoria FROM tmp.datos
WHERE id_tipo IN (5,6,8, 9,10) AND url_pub IS NOT NULL
GROUP BY 1,2,3,4,5,6,7;

-- 
-- SERVICIOS GEOGRAFICOS
--
SELECT * FROM ide.def_tipos_servicios WHERE id_padre IN (2,3) ORDER BY orden;

UPDATE tmp.datos SET id_tipo = 11 WHERE tipo_pub = 'Servicio WMS';
UPDATE tmp.datos SET id_tipo = 12 WHERE tipo_pub = 'Servicio WFS' OR tipo_pub= 'WFS';
UPDATE tmp.datos SET id_tipo = 14 WHERE tipo_pub = 'Servicio WMTS';
UPDATE tmp.datos SET id_tipo = 17 WHERE tipo_pub = 'ArcGIS REST' OR tipo_pub = 'Arcgis REST';
UPDATE tmp.datos SET id_tipo = 20 WHERE tipo_pub = 'KML';
UPDATE tmp.datos SET id_tipo = 11 WHERE tipo_pub = 'Geoprocesamiento';--GEOPERU

UPDATE tmp.datos SET url_pub= NULL WHERE url_pub= 'Sin enlace' OR url_pub= '';
ALTER TABLE tmp.datos ADD COLUMN nombre_layer TEXT;

SELECT * FROM tmp.datos WHERE capa LIKE ('%Otros Usos%');

SELECT * FROM public.def_layer;

--
-- CONSULTA PRINCIPAL
--
-- 
-- DROP TABLE tmp.resultado_servicios;
CREATE TABLE tmp.resultado_servicios AS
WITH base AS (
  SELECT
      id_institucion,
      id_categoria,
      capa,
      CASE WHEN geo = 'SI' THEN TRUE ELSE FALSE END AS publicar_geoperu,
      MAX(url_pub) FILTER (WHERE id_tipo = 11) AS wms,
      MAX(url_pub) FILTER (WHERE id_tipo = 12) AS wfs,
      MAX(url_pub) FILTER (WHERE id_tipo = 14) AS wmts,
      MAX(url_pub) FILTER (WHERE id_tipo = 17) AS arcgis,
      MAX(url_pub) FILTER (WHERE id_tipo = 20) AS kml
  FROM tmp.datos
  WHERE id_tipo IN (11,12,14,17,20)
  GROUP BY id_institucion, id_categoria, capa, geo
),
enriquecida AS (
  SELECT
    b.*,
	dl.nombre_capa AS nombre_capa_def,
	dl.idfuente AS idfuente_def,
	dl.idsubsistema AS idsubsistema_def,
	dl.hashcode AS hashcode_def,
	dl.url_fuente AS url_fuente_def
  FROM base b
  LEFT JOIN LATERAL (
    SELECT
      d.nombre_capa,
      d.idfuente,
      d.idsubsistema,
      d.hashcode,
      d.url_fuente
    FROM public.def_layer d
    WHERE d.capa = b.capa
      AND d.idestado = 1
      AND d.idsubsistema = 0
      AND LENGTH(d.nombre_capa) > 0
    LIMIT 1
  ) dl ON TRUE
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
    WHEN wms IS NULL THEN
      CASE
	    WHEN idfuente_def = 1 THEN 'https://espacialg.geoperu.gob.pe/geoserver/geoperu/' || COALESCE(nombre_capa_def, '') || '/wms?'
        WHEN idfuente_def = 2 THEN COALESCE(url_fuente_def, '')
        WHEN idfuente_def = 3 AND COALESCE(idsubsistema_def, 0) = 0
          THEN 'https://espacialg.geoperu.gob.pe/geoserver/geoperu/' || COALESCE(hashcode_def, '') || '/wms?'
        ELSE 'https://espacialg.geoperu.gob.pe/geoserver/subsistema/' || COALESCE(hashcode_def, '') || '/wms?'
      END
    ELSE wms
  END AS wms,
  wfs,
  wmts,
  arcgis,
  kml
FROM enriquecida
WHERE (wms IS NOT NULL OR nombre_capa_def IS NOT NULL)
ORDER BY id_institucion ASC, layer ASC;

--CREATE UNIQUE INDEX ON tmp.resultado_servicios (id_institucion, id_categoria, layer);

SELECT * FROM tmp.resultado_servicios ORDER BY numero;

SELECT * FROM public.def_layer WHERE capa LIKE ('%Mapa de sacudimiento teórico%') ;

-- CAPAS GEOGRAFICAS
INSERT INTO ide.def_capas_geograficas
  (id, nombre, tipo_capa, publicar_geoperu, id_categoria, id_institucion, usuario_crea)
SELECT numero, layer, 1, publicar_geoperu, id_categoria, id_institucion, 1
FROM tmp.resultado_servicios
ORDER BY numero ASC;

-- SERVICIOS GEOGRAFICOS
INSERT INTO ide.def_servicios_geograficos(id_capa, id_tipo_servicio, direccion_web, nombre_capa, titulo_capa, estado, usuario_crea)
SELECT numero, 11, wms AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE wms IS NOT NULL UNION
SELECT numero, 12, wfs AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE wfs IS NOT NULL UNION
SELECT numero, 14, wmts AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE wmts IS NOT NULL UNION
SELECT numero, 17, arcgis AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE arcgis IS NOT NULL;
--SELECT numero, 20, kml AS direccion_web, nombre_capa, layer, True, 1 FROM tmp.resultado_servicios WHERE kml IS NOT NULL;



