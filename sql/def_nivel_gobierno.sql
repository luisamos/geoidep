--
-- NIVEL DE GOBIERNO 
--

--
-- ENTIDAD
--

INSERT INTO public.def_entidades (codigo, nombre) VALUES
('PE', 'Poder Ejecutivo'),
('PL', 'Poder Legislativo'),
('PJ', 'Poder Judicial'),
('OA', 'Organismos Autónomos'),
('GR', 'Gobiernos Regionales'),
('GL', 'Gobiernos Locales'),
('ONG', 'Organismos No Gubernamentales'),
('I', 'Organismos Internacionales'),
('P', 'Instituciones Privadas');

SELECT * FROM public.def_entidades ORDER BY 1;

--
-- SECTOR
--
INSERT INTO public.def_sectores (codigo, nombre , id_entidad) VALUES
('01', 'PRESIDENCIA CONSEJO MINISTROS', 1),
('03', 'CULTURA', 1),
('04', 'PODER JUDICIAL', 1),
('05', 'AMBIENTAL', 1),
('06', 'JUSTICIA', 1),
('07', 'INTERIOR', 1),
('08', 'RELACIONES EXTERIORES', 1),
('09', 'ECONOMIA Y FINANZAS', 1),
('10', 'EDUCACION', 1),
('11', 'SALUD', 1),
('12', 'TRABAJO Y PROMOCION DEL EMPLEO', 1),
('13', 'AGRARIO Y DE RIEGO', 1),
('16', 'ENERGIA Y MINAS', 1),
('19', 'CONTRALORIA GENERAL', 4),
('20', 'DEFENSORIA DEL PUEBLO', 4),
('21', 'JUNTA NACIONAL DE JUSTICIA', 4),
('22', 'MINISTERIO PUBLICO', 1),
('24', 'TRIBUNAL CONSTITUCIONAL', 4),
('26', 'DEFENSA', 1),
('27', 'FUERO MILITAR POLICIAL', 4),
('28', 'CONGRESO DE LA REPUBLICA', 2),
('31', 'JURADO NACIONAL DE ELECCIONES', 4),
('32', 'OFICINA NACIONAL DE PROCESOS ELECTORALES', 4),
('33', 'REGISTRO NACIONAL DE IDENTIFICACION Y ESTADO CIVIL', 4),
('35', 'COMERCIO EXTERIOR Y TURISMO', 1),
('36', 'TRANSPORTES Y COMUNICACIONES', 1),
('37', 'VIVIENDA CONSTRUCCION Y SANEAMIENTO', 1),
('38', 'PRODUCCION', 1),
('39', 'MUJER Y POBLACIONES VULNERABLES', 1),
('40', 'DESARROLLO E INCLUSION SOCIAL', 1),
('99', 'GOBIERNOS REGIONALES', 5),
('M', 'GOBIERNOS MUNICIPALES', 6),
('B', 'BOMBEROS', 4),
('ONG', 'ORGANISMOS NO GUBERNAMENTALES', 7),
('I', 'ORGANIZACIONES INTERNACIONALES', 8),
('P', 'PRIVADO',9);

SELECT * FROM public.def_sectores ORDER BY 1;

--\copy public.def_instituciones (pliego, nombre, id_sector, sigla) FROM 'C:\Apps\python\Flask\geoidep\sql\instituciones.csv' WITH (FORMAT csv, DELIMITER ';', QUOTE '"', HEADER true, ENCODING 'UTF8');

--\copy public.def_instituciones (pliego, nombre, id_sector) FROM 'C:\Apps\python\Flask\geoidep\sql\municipalidades.csv' WITH (FORMAT csv, DELIMITER ';', QUOTE '"', HEADER true, ENCODING 'UTF8');

--\copy public.def_instituciones (pliego, nombre, sigla, id_sector) FROM 'C:\Apps\python\Flask\geoidep\sql\instituciones2.csv' WITH (FORMAT csv, DELIMITER ';', QUOTE '"', HEADER true, ENCODING 'UTF8');

SELECT id, nombre, sigla FROM public.def_instituciones
WHERE sigla = 'SERNANP';
