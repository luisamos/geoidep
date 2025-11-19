--
-- ENTIDAD
--
INSERT INTO ide.def_instituciones (codigo,sigla, nombre, orden, id_padre, usuario_crea, fecha_crea) VALUES
('ENTIDAD', 'PE', 'PODER EJECUTIVO', 1, 0, 1, '01-08-2025'),
('ENTIDAD', 'PL', 'PODER LEGISLATIVO', 2, 0, 1, '01-08-2025'),
('ENTIDAD', 'PJ', 'PODER JUDICIAL', 3, 0, 1, '01-08-2025'),
('ENTIDAD', 'OA', 'ORGANISMOS AUTÓNOMOS', 4, 0, 1, '01-08-2025'),
('ENTIDAD', 'GR', 'GOBIERNOS REGIONALES', 5, 0, 1, '01-08-2025'),
('ENTIDAD', 'GL', 'GOBIERNOS LOCALES', 6, 0, 1, '01-08-2025'),
('ENTIDAD', 'ONG','ORGANISMOS NO GUBERNAMENTALES', 7, 0, 1, '01-08-2025'),
('ENTIDAD', 'I',  'ORGANISMOS INTERNACIONALES', 8, 0, 1, '01-08-2025'),
('ENTIDAD', 'P',  'INSTITUCIONES PRIVADAS', 9, 0, 1, '01-08-2025');

--
-- SECTOR
--
INSERT INTO ide.def_instituciones (orden, codigo, nombre , id_padre, usuario_crea, fecha_crea) VALUES
(1, '01', 'PRESIDENCIA CONSEJO MINISTROS', 1, 1, '08-01-2025'),
(2, '03', 'CULTURA', 1, 1, '08-01-2025'),
(3, '04', 'PODER JUDICIAL', 1, 1, '08-01-2025'),
(4, '05', 'AMBIENTAL', 1, 1, '08-01-2025'),
(5, '06', 'JUSTICIA', 1, 1, '08-01-2025'),
(6, '07', 'INTERIOR', 1, 1, '08-01-2025'),
(7, '08', 'RELACIONES EXTERIORES', 1, 1, '08-01-2025'),
(8, '09', 'ECONOMIA Y FINANZAS', 1, 1, '08-01-2025'),
(9, '10', 'EDUCACION', 1, 1, '08-01-2025'),
(10, '11', 'SALUD', 1, 1, '08-01-2025'),
(11, '12', 'TRABAJO Y PROMOCION DEL EMPLEO', 1, 1, '08-01-2025'),
(12, '13', 'AGRARIO Y DE RIEGO', 1, 1, '08-01-2025'),
(13, '16', 'ENERGIA Y MINAS', 1, 1, '08-01-2025'),
(14, '19', 'CONTRALORIA GENERAL', 4, 1, '08-01-2025'),
(15, '20', 'DEFENSORIA DEL PUEBLO', 4, 1, '08-01-2025'),
(16, '21', 'JUNTA NACIONAL DE JUSTICIA', 4, 1, '08-01-2025'),
(17, '22', 'MINISTERIO PUBLICO', 1, 1, '08-01-2025'),
(18, '24', 'TRIBUNAL CONSTITUCIONAL', 4, 1, '08-01-2025'),
(19, '26', 'DEFENSA', 1, 1, '08-01-2025'),
(20, '27', 'FUERO MILITAR POLICIAL', 4, 1, '08-01-2025'),
(21, '28', 'CONGRESO DE LA REPUBLICA', 2, 1, '08-01-2025'),
(22, '31', 'JURADO NACIONAL DE ELECCIONES', 4, 1, '08-01-2025'),
(23, '32', 'OFICINA NACIONAL DE PROCESOS ELECTORALES', 4, 1, '08-01-2025'),
(24, '33', 'REGISTRO NACIONAL DE IDENTIFICACION Y ESTADO CIVIL', 4, 1, '08-01-2025'),
(25, '35', 'COMERCIO EXTERIOR Y TURISMO', 1, 1, '08-01-2025'),
(26, '36', 'TRANSPORTES Y COMUNICACIONES', 1, 1, '08-01-2025'),
(27, '37', 'VIVIENDA CONSTRUCCION Y SANEAMIENTO', 1, 1, '08-01-2025'),
(28, '38', 'PRODUCCION', 1, 1, '08-01-2025'),
(29, '39', 'MUJER Y POBLACIONES VULNERABLES', 1, 1, '08-01-2025'),
(30, '40', 'DESARROLLO E INCLUSION SOCIAL', 1, 1, '08-01-2025'),
(31, '99', 'GOBIERNOS REGIONALES', 5, 1, '08-01-2025'),
(32, 'M', 'GOBIERNOS MUNICIPALES', 6, 1, '08-01-2025'),
(33, 'ONG', 'ORGANISMOS NO GUBERNAMENTALES', 7, 1, '08-01-2025'),
(34, 'I', 'ORGANIZACIONES INTERNACIONALES', 8, 1, '08-01-2025'),
(35, 'P', 'PRIVADO',9, 1, '08-01-2025');

SELECT id, nombre FROM ide.def_instituciones WHERE id_padre IN (1,2,3,4,5,6,7,8,9) ORDER BY orden;

--\copy ide.def_instituciones (codigo, nombre, id_padre, sigla, usuario_crea, fecha_crea) FROM 'C:\Apps\python\Flask\geoidep\sql\instituciones.csv' WITH (FORMAT csv, DELIMITER ';', QUOTE '"', HEADER true, ENCODING 'UTF8');

--\copy ide.def_instituciones (ubigeo, codigo, nombre, id_padre, usuario_crea, fecha_crea) FROM 'C:\Apps\python\Flask\geoidep\sql\municipalidades.csv' WITH (FORMAT csv, DELIMITER ';', QUOTE '"', HEADER true, ENCODING 'UTF8');

--\copy ide.def_instituciones (codigo, nombre, id_padre, sigla, usuario_crea, fecha_crea) FROM 'C:\Apps\python\Flask\geoidep\sql\instituciones2.csv' WITH (FORMAT csv, DELIMITER ';', QUOTE '"', HEADER true, ENCODING 'UTF8');

SELECT id, nombre, sigla FROM ide.def_instituciones
WHERE id >=45;
