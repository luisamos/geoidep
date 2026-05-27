--\copy ide.def_documentos (n_documento, f_documento, f_recepcion, url_documento, usuario_registro, fecha_registro) FROM 'C:\apps\python\flask\geoidep\sql\documentos.csv' WITH (FORMAT csv,HEADER true,DELIMITER ',',QUOTE '"',NULL '',ENCODING 'UTF8');

SELECT id, n_documento, f_documento, cod_expediente, f_recepcion, url_documento, usuario_registro, fecha_registro
	FROM ide.def_documentos;
