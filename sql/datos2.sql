DROP TABLE IF EXISTS tmp.datos2;

CREATE TABLE tmp.datos2 (
  id serial PRIMARY KEY,
  id_layer           text,
  idtematica         text,
  idsubtematico      text,
  ide                text,
  geo                text,
  capa               text,
  entidad            text,
  frec_act           text,
  fecha_reg          text,
  fecha_prox         text,
  wms                text,
  wfs                text,
  arcgis             text,
  wmts               text,
  responsable_geo    text,
  estado_proc        text,
  fecha_proc         text,
  responsable_pub    text,
  estado_pub_geo     text,
  fecha_pub_geo      text,
  estado_ide_proc    text,
  fecha_proc_ide     text,
  estado_pub_ide     text,
  fecha_pub_ide      text,
  descripcion        text,
  observacion        text,
  estado_actu        text,
  id_institucion     text,
  id_categoria       text
);

--\copy tmp.datos2 (id_layer, idtematica, idsubtematico, ide, geo, capa, entidad, frec_act, fecha_reg, fecha_prox, wms, wfs, arcgis, wmts, responsable_geo, estado_proc, fecha_proc, responsable_pub, estado_pub_geo, fecha_pub_geo, estado_ide_proc, fecha_proc_ide, estado_pub_ide, fecha_pub_ide, descripcion, observacion, estado_actu, id_institucion, id_categoria) FROM 'C:\apps\python\flask\geoidep\sql\datos2.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

INSERT INTO ide.def_capas_geograficas
  (id, nombre, tipo_capa, publicar_geoperu, id_categoria, id_institucion, usuario_crea)
SELECT id, capa, 1, True, id_categoria :: integer, id_institucion:: integer, 1
FROM tmp.datos2
ORDER BY id ASC;

SELECT * FROM def_layer WHERE id = 38800;


INSERT INTO ide.def_servicios_geograficos(id_capa, id_tipo_servicio, direccion_web, nombre_capa, titulo_capa, estado, id_layer, usuario_crea)
SELECT id, 11, wms AS direccion_web, '' AS nombre_capa, '' AS capa, True, id_layer:: integer, 1 
FROM tmp.datos2
WHERE wms IS NOT NULL UNION
SELECT id, 12, wfs AS direccion_web, '' AS nombre_capa, '' AS capa, True, id_layer:: integer, 1 
FROM tmp.datos2
WHERE wfs IS NOT NULL UNION
SELECT id, 14, wmts AS direccion_web, '' AS nombre_capa, '' AS capa, True, id_layer:: integer, 1 
FROM tmp.datos2
WHERE wmts IS NOT NULL UNION
SELECT id, 17, arcgis AS direccion_web, '' AS nombre_capa, '' AS capa, True, id_layer:: integer, 1 
FROM tmp.datos2
WHERE arcgis IS NOT NULL;

SELECT * FROM ide.def_servicios_geograficos;





