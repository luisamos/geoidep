CREATE TABLE tmp.datos (
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
    estado_actu TEXT
);

--\copy tmp.datos FROM 'C:/Users/lvaler/Downloads/datos_final.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

--\copy tmp.datos FROM 'C:/Users/luisa/Downloads/datos.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

SELECT * FROM tmp.datos;