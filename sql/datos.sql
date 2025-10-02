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

--\copy tmp.datos(n, grupo_tema, sub_tema, cod_capa, ide, geo, capa, sector, institucion, entidad, sub_ent, resp_inst, correo_inst, nro_inst, frec_act, fecha_reg, fecha_prox, paginaweb, url_pub, tipo_pub, nro_documento_recp, fecha_recepcion, responsable_proc, estado_proc, fecha_proc, responsable_pub, estado_pub_geo, fecha_pub_geo, estado_ide_proc, fecha_proc_ide, estado_pub_ide, fecha_pub_ide, descripcion, observacion, origen, tipo_entidad, estado_check, estado_servicio, estado_actu) FROM 'C:\apps\python\flask\geoidep\sql\datos.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

SELECT entidad FROM tmp.datos
GROUP BY 1
ORDER BY 1;


SELECT DISTINCT ON (a.id)
 UPPER(a.institucion),  'UPDATE tmp.datos SET id_instituciones=' || b.id || ', WHERE id=' || a.id || ';' AS sql
FROM tmp.datos a
JOIN public.def_instituciones b
  ON UPPER(a.entidad) = b.nombre || ' (' || b.sigla || ')'
ORDER BY a.id;