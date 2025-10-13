--
-- PostgreSQL database dump
--

\restrict MTmppWC1BOXzeOUUk7g2yAgFj53f2Ev0hyqw3CVpDjBE4iOcFzcaZKtJ2YkqHC6

-- Dumped from database version 16.10
-- Dumped by pg_dump version 17.6

-- Started on 2025-10-06 09:10:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 10 (class 2615 OID 349995)
-- Name: ide; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ide;


ALTER SCHEMA ide OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 234 (class 1259 OID 350052)
-- Name: def_capas_geograficas; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_capas_geograficas (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion character varying(500),
    tipo_capa boolean,
    publicar_geoperu boolean,
    id_categoria integer NOT NULL,
    id_institucion integer NOT NULL
);


ALTER TABLE ide.def_capas_geograficas OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 350051)
-- Name: def_capas_geograficas_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_capas_geograficas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_capas_geograficas_id_seq OWNER TO postgres;

--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 233
-- Name: def_capas_geograficas_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_capas_geograficas_id_seq OWNED BY ide.def_capas_geograficas.id;


--
-- TOC entry 224 (class 1259 OID 349997)
-- Name: def_categorias; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_categorias (
    id integer NOT NULL,
    codigo character varying(5) NOT NULL,
    nombre character varying(500) NOT NULL,
    sigla character varying(500) NOT NULL,
    definicion text,
    id_padre integer
);


ALTER TABLE ide.def_categorias OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 349996)
-- Name: def_categorias_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_categorias_id_seq OWNER TO postgres;

--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 223
-- Name: def_categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_categorias_id_seq OWNED BY ide.def_categorias.id;


--
-- TOC entry 226 (class 1259 OID 350008)
-- Name: def_entidades; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_entidades (
    id integer NOT NULL,
    codigo character varying(3) NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE ide.def_entidades OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 350007)
-- Name: def_entidades_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_entidades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_entidades_id_seq OWNER TO postgres;

--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 225
-- Name: def_entidades_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_entidades_id_seq OWNED BY ide.def_entidades.id;


--
-- TOC entry 236 (class 1259 OID 350071)
-- Name: def_herramientas_digitales; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_herramientas_digitales (
    id integer NOT NULL,
    id_tipo_servicio integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion text,
    estado integer,
    recurso text,
    id_institucion integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE ide.def_herramientas_digitales OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 350070)
-- Name: def_herramientas_digitales_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_herramientas_digitales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_herramientas_digitales_id_seq OWNER TO postgres;

--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 235
-- Name: def_herramientas_digitales_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_herramientas_digitales_id_seq OWNED BY ide.def_herramientas_digitales.id;


--
-- TOC entry 232 (class 1259 OID 350038)
-- Name: def_instituciones; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_instituciones (
    id integer NOT NULL,
    pliego character varying(20),
    nombre character varying(800) NOT NULL,
    logotipo text,
    sigla character varying(50),
    id_sector integer NOT NULL
);


ALTER TABLE ide.def_instituciones OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 350037)
-- Name: def_instituciones_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_instituciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_instituciones_id_seq OWNER TO postgres;

--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 231
-- Name: def_instituciones_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_instituciones_id_seq OWNED BY ide.def_instituciones.id;


--
-- TOC entry 230 (class 1259 OID 350026)
-- Name: def_sectores; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_sectores (
    id integer NOT NULL,
    codigo character varying(3) NOT NULL,
    nombre character varying(100) NOT NULL,
    id_entidad integer NOT NULL
);


ALTER TABLE ide.def_sectores OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 350025)
-- Name: def_sectores_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_sectores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_sectores_id_seq OWNER TO postgres;

--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 229
-- Name: def_sectores_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_sectores_id_seq OWNED BY ide.def_sectores.id;


--
-- TOC entry 240 (class 1259 OID 350115)
-- Name: def_servicios_geograficos; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_servicios_geograficos (
    id integer NOT NULL,
    id_capa integer NOT NULL,
    id_tipo_servicio integer NOT NULL,
    direccion_web text NOT NULL,
    nombre_layer character varying(200),
    visible boolean
);


ALTER TABLE ide.def_servicios_geograficos OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 350114)
-- Name: def_servicios_geograficos_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_servicios_geograficos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_servicios_geograficos_id_seq OWNER TO postgres;

--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 239
-- Name: def_servicios_geograficos_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_servicios_geograficos_id_seq OWNED BY ide.def_servicios_geograficos.id;


--
-- TOC entry 228 (class 1259 OID 350015)
-- Name: def_tipos_servicios; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_tipos_servicios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    estado boolean,
    logotipo character varying(500),
    orden integer NOT NULL,
    id_padre integer NOT NULL
);


ALTER TABLE ide.def_tipos_servicios OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 350014)
-- Name: def_tipos_servicios_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_tipos_servicios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_tipos_servicios_id_seq OWNER TO postgres;

--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 227
-- Name: def_tipos_servicios_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_tipos_servicios_id_seq OWNED BY ide.def_tipos_servicios.id;


--
-- TOC entry 238 (class 1259 OID 350095)
-- Name: def_usuarios; Type: TABLE; Schema: ide; Owner: postgres
--

CREATE TABLE ide.def_usuarios (
    id integer NOT NULL,
    username character varying(80) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(256) NOT NULL,
    confirmed boolean NOT NULL,
    confirmation_token character varying(255),
    id_institucion integer NOT NULL
);


ALTER TABLE ide.def_usuarios OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 350094)
-- Name: def_usuarios_id_seq; Type: SEQUENCE; Schema: ide; Owner: postgres
--

CREATE SEQUENCE ide.def_usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 237
-- Name: def_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: postgres
--

ALTER SEQUENCE ide.def_usuarios_id_seq OWNED BY ide.def_usuarios.id;


--
-- TOC entry 4841 (class 2604 OID 350055)
-- Name: def_capas_geograficas id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_capas_geograficas ALTER COLUMN id SET DEFAULT nextval('ide.def_capas_geograficas_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 350000)
-- Name: def_categorias id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_categorias ALTER COLUMN id SET DEFAULT nextval('ide.def_categorias_id_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 350011)
-- Name: def_entidades id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_entidades ALTER COLUMN id SET DEFAULT nextval('ide.def_entidades_id_seq'::regclass);


--
-- TOC entry 4842 (class 2604 OID 350074)
-- Name: def_herramientas_digitales id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_herramientas_digitales ALTER COLUMN id SET DEFAULT nextval('ide.def_herramientas_digitales_id_seq'::regclass);


--
-- TOC entry 4840 (class 2604 OID 350041)
-- Name: def_instituciones id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_instituciones ALTER COLUMN id SET DEFAULT nextval('ide.def_instituciones_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 350029)
-- Name: def_sectores id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_sectores ALTER COLUMN id SET DEFAULT nextval('ide.def_sectores_id_seq'::regclass);


--
-- TOC entry 4844 (class 2604 OID 350118)
-- Name: def_servicios_geograficos id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_servicios_geograficos ALTER COLUMN id SET DEFAULT nextval('ide.def_servicios_geograficos_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 350018)
-- Name: def_tipos_servicios id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_tipos_servicios ALTER COLUMN id SET DEFAULT nextval('ide.def_tipos_servicios_id_seq'::regclass);


--
-- TOC entry 4843 (class 2604 OID 350098)
-- Name: def_usuarios id; Type: DEFAULT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_usuarios ALTER COLUMN id SET DEFAULT nextval('ide.def_usuarios_id_seq'::regclass);


--
-- TOC entry 5037 (class 0 OID 350052)
-- Dependencies: 234
-- Data for Name: def_capas_geograficas; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_capas_geograficas (id, nombre, descripcion, tipo_capa, publicar_geoperu, id_categoria, id_institucion) FROM stdin;
\.


--
-- TOC entry 5027 (class 0 OID 349997)
-- Dependencies: 224
-- Data for Name: def_categorias; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_categorias (id, codigo, nombre, sigla, definicion, id_padre) FROM stdin;
1	1	Categoría ISO 19115	ISO19115	Es una norma internacional que define un esquema estándar para la creación de metadatos, que son descripciones detalladas de los datos geográficos	0
2	001	Agricultura	farming	Cría de animales y/o cultivo de plantas. Ejemplos: agricultura, irrigación, acuicultura, plantaciones, plagas, epidemias y enfermedades que afectan a las cosechas y al ganado	1
3	002	Biología	biota	Flora y fauna en el medio natural. Ejemplos: fauna, vegetación, ciencias biológicas, ecología, vida salvaje, vida marina, pantanos, hábitat	1
4	003	Límites	boundaries	Descripciones legales del terreno. Ejemplos: límites administrativos y políticos	1
5	004	Atmósfera, Climatología, Meteorología	climatologyMeteorologyAtmosphere	Procesos y fenómenos de la atmósfera. Ejemplos: cobertura nubosa, tiempo, clima, condiciones atmosféricas, cambio climático, precipitación	1
6	005	Economía	economy	Actividades económicas, condiciones y empleo. Ejemplos: producción, trabajo, ingresos, comercio, industria, turismo y ecoturismo, silvicultura, políticas pesqueras, caza comercial y de subsistencia, exploración y explotación de recursos tales como minerales, aceite y gas	1
7	006	Elevación	elevation	Altura sobre o bajo el nivel del mar. Ejemplos: altitud, batimetría, modelos digitales del terreno, pendiente y productos derivados	1
8	007	Medio Ambiente	environment	Recursos medio ambientales, protección y conservación. Ejemplos: contaminación ambiental, tratamiento y almacenamiento de desechos, valoración del impacto ambiental, monitoreo del riesgo medioambiental, reservas naturales, paisaje	1
9	008	Información Geocientífica	geoscientificInformation	Información perteneciente a las ciencias de la Tierra. Ejemplos: procesos y fenómenos geofísicos, geología, minerales, ciencias relacionadas con la composición, estructura y origen de las rocas de la Tierra, riesgo sísmico, actividad volcánica, corrimiento de tierras, gravimetría, suelos, permafrost, hidrología y erosión	1
10	009	Salud	health	Salud, servicios de salud, ecología humana y seguridad. Ejemplos: dolencias y enfermedades, factores que afectan a la salud, higiene, abusos de sustancias, salud mental y física, servicios de salud	1
11	010	Cobertura de la Tierra con Mapas Básicos e Imágenes	imageBaseMapsEarthCover	Cartografía básica. Ejemplos: usos del suelo, mapas topográficos, imágenes, imágenes sin clasificar, anotaciones	1
12	011	Inteligencia Militar	intelligenceMilitary	Redes militares, estructuras, actividades. Ejemplos: cuarteles, zonas de instrucción, transporte militar, alistamiento	1
13	012	Aguas Interiores	inlandWaters	Fenómenos de agua interior, sistemas de drenaje y sus características. Ejemplos: ríos y glaciares, lagos de agua salada, planes de utilización de aguas, presas, corrientes, inundaciones, calidad de agua, planes hidrológicos	1
14	013	Localización	location	Información posicional y servicios. Ejemplos: direcciones, redes geodésicas, puntos de control, servicios y zonas postales, nombres de lugares	1
15	014	Océanos	oceans	Fenómenos y características de las aguas saladas (excluyendo las aguas interiores). Ejemplos: mareas, movimientos de marea, información de costa, arrecifes	1
16	015	Planeamiento Catastral	planningCadastre	Información usada para tomar las acciones más apropiadas para el uso futuro de la tierra. Ejemplos: mapas de uso de suelo, mapas de zonas, levantamientos catastrales, propiedad del terreno	1
17	016	Sociedad	society	Características de la sociedad y las culturas. Ejemplos: asentamientos, antropología, arqueología, educación, creencias tradicionales, modos y costumbres, datos demográficos, áreas y actividades recreativas, valoraciones de impacto social, crimen y justicia, información censal	1
18	017	Estructuras	structure	Construcciones hechas por el hombre. Ejemplos: construcciones, museos, iglesias, fábricas, viviendas, monumentos, tiendas, torres	1
19	018	Transporte	transportation	Medios y ayudas para transportar personas y mercancías. Ejemplos: carreteras, aeropuertos, pistas de aterrizaje, rutas, vías marítimas, túneles, cartas náuticas, localización de barcos o vehículos, cartas aeronáuticas, ferrocarriles	1
20	019	Redes de Suministro	utilitiesCommunication	Redes de agua, de energía, de retirada de residuos, de infraestructura de comunicaciones y servicios. Ejemplos: hidroeléctricas, fuentes de energía geotermal, solar y nuclear, distribución y depuración de agua, recogida y almacenamiento de aguas residuales, distribución de gas y energía, comunicación de datos, telecomunicaciones, radio, redes de comunicación	1
\.


--
-- TOC entry 5029 (class 0 OID 350008)
-- Dependencies: 226
-- Data for Name: def_entidades; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_entidades (id, codigo, nombre) FROM stdin;
1	PE	Poder Ejecutivo
2	PL	Poder Legislativo
3	PJ	Poder Judicial
4	OA	Organismos Autónomos
5	GR	Gobiernos Regionales
6	GL	Gobiernos Locales
7	ONG	Organismos No Gubernamentales
8	I	Organismos Internacionales
9	P	Instituciones Privadas
\.


--
-- TOC entry 5039 (class 0 OID 350071)
-- Dependencies: 236
-- Data for Name: def_herramientas_digitales; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_herramientas_digitales (id, id_tipo_servicio, nombre, descripcion, estado, recurso, id_institucion, id_categoria) FROM stdin;
1	4	GEOINPE	El GEOINPE, es la plataforma oficial para el acceso, uso y visualización de la información georreferenciada de la Población Penitenciaria que genera el Instituto Nacional Penitenciario.	1	https://arcg.is/0yXC1e	32	2
2	4	GEOMININTER	Web con información espacial de datos dirigidos a la seguridad ciudadana	1	https://geoportal.mininter.gob.pe/	35	14
3	4	Geoportal del Gobierno Regional Loreto	Es una plataforma de Servicios que permite la difusión e intercambio de información geoespacial.	1	https://geoportal.regionloreto.gob.pe/	175	15
4	4	Geoportal del MIDAGRI	Es el medio oficial para el acceso, uso e intercambio de información espacial que genera el MIDAGRI. Aprobado por R.M. N.° 451-2019-MINAGRI.	1	https://geo.midagri.gob.pe/#	116	3
5	4	Geoportal IDER UCAYALI	El Geoportal de la Infraestructura de Datos Espaciales - IDE del Gobierno Regional de Ucayali, como medio oficial para el acceso, uso e intercambio de información geoespacial  establecida mediante  Resolución Ejecutiva Regional N° 468-2018-GRU-GR	1	http://ider.regionucayali.gob.pe/	184	18
6	4	Geoportal IDERSan Martín	Es una plataforma de Servicios que permite la difusión e intercambio de información geoespacial.	1	https://geoportal.regionsanmartin.gob.pe/	181	15
7	4	Geoportal INGEMMET	Portal de información georreferenciada de la geología y el catastro minero nacional.	1	https://ingemmet-peru.maps.arcgis.com/home/index.html	124	9
8	4	Geoportal SENAMHI	La infraestructura de Datos Espaciales del SENAMHI PERU (IDESEP) es un conjunto de políticas, estándares, procesos, tecnologías y recursos humanos que se encuentran integrados y destinados a facilitar la producción, estandarización, uso y acceso a la información geoespacial del SENAMHI, teniendo como base la información estandarizada, oficial y oportuna para la toma de decisiones.	1	https://idesep.senamhi.gob.pe/portalidesep/	30	18
9	4	Infraestructur a de Datos Espaciales del Gobierno Regional Cajamarca	Consolida los enlaces a los distintos sistemas de información, además de brindar los serviciox WMS y los archivos KMZ	1	http://ide.regioncajamarca.gob.pe/	167	15
10	4	Mapa Audiovisual del Patrimonio Cultural Inmaterial Peruano	Mapa Audiovisual del Patrimonio Cultural Inmaterial Peruano	1	https://geoportal.cultura.gob.pe/audiovisual/	17	17
11	4	Portal interactivo de fiscalización ambiental (PIFA)	El Portal Interactivo de Fiscalización Ambiental (PIFA) es una plataforma  de información proveniente desde diversas fuentes y tecnologías en campo y gabinete; registrada, sistematizada, procesada y actualizada sobre el estado del ambiente y las acciones de fiscalización ambiental en el Perú.	1	https://sistemas.oefa.gob.pe/pifa/mfe/#/	25	5
12	5	Aplicativo de Historia de los penales del Perú	Es un plataforma con enfoque de StoryMap donde se presenta la historia, cartografia y localización de cada penal del Perú.	1	https://storymaps.arcgis.com/stories/bedfb2ba0aec41d8a649808a6e51c364	32	4
13	5	Área Funcional de Sensoramien to Remoto (AFSR)	Sistema que permite acceder a información del mar peruano.	1	https://satelite.imarpe.gob.pe/#/	154	3
14	5	Atlas de Energia Solar del Peru -2003	Sistema que tiene como objetivo promover la aplicación sostenible de energía fotovoltaica en zonas rurales del país, como una alternativa limpia, libre de la emisión de gases de efecto invernadero	1	http://dger.minem.gob.pe/vista/informacion_geografica.html	122	12
15	5	Biodiversidad y ecosistemas	La aplicación Biodiversidad y Ecosistemas tiene la finalidad de mostrar información de los parques de la ciudad que tienen rutas de observación de aves, las especies que se pueden avistar por cada parque, entre otros datos geográficos de interés relacionados al tema de biodiversidad y ecosistemas	1	https://sit.icl.gob.pe/biodiversidad_smia/	2077	18
16	5	Carta educativa	Carta educativa de las Direcciones Regionales de Educación y Unidades de Gestión Educativa Local en formato PDF. La oferta educativa se ubica a nivel del centro poblado.	1	http://escale.minedu.gob.pe/carta-educativa	48	17
17	5	Catálogo de Datos y Servicios	El catálogo de datos y servicios es una herramienta que aprovecha los datos sobre todo el conjunto de activos de datos y servicios web que mantiene OEFA para crear entradas que concentran toda la información relevante sobre un activo de datos en un solo lugar.	1	https://pifa.oefa.gob.pe/catalogo/main	25	15
18	5	Catastro Virtual	Visor de Mapas Temáticos	1	http://cvc.cofopri.gob.pe/(S(x4iy51zeolu2or55awfp55jn))/webRecomendaciones.aspx	151	16
19	5	Centro histórico de Lima	La aplicación web denominada PROLIMA se realizó en coordinación con la Gerencia de Cartografía y Tecnologías de la Información con el objetivo de mostrar los diversos monumentos y predios con Valor Monumental en Cercado de Lima y los distritos colindantes, dentro de estos inmuebles de carácter monumental y con valor monumental	1	https://sit.icl.gob.pe/prolima/	2077	16
20	5	Cobertura Movil	Aplicativo informatico, mediante el cual el usuario puede conocer la cobertura del servicio movil en cada una de las localidades declaradas por las empresas operadoras ante el OSIPTEL.	1	https://serviciosweb.osiptel.gob.pe/CoberturaMovil/	7	20
21	5	Código Postal Nacional  - Ministerio de Transportes y Comunicaciones	Plataforma oficial del Ministerio de Transportes y Comunicaciones (MTC) para consultar el Código Postal Nacional del Perú, permitiendo buscar y verificar el código postal de cualquier dirección en el país.	1	http://www.codigopostal.gob.pe/pages/invitado/consulta.jsf	143	19
22	5	Conecta Lima - Programa Nacional de Telecomunicaciones	Mapa interactivo del Programa Nacional de Telecomunicaciones (PRONATEL) que visualiza las localidades y el avance del Proyecto de Instalación de Banda Ancha para la Conectividad Integral y Desarrollo Social en la Región Lima.	1	http://pronatelconectalima.pe/mapa	143	20
23	5	Consulta de suministro de abastecimiento	Consulta de suministro de abastecimiento. Información proporcionada por SEDAPAL	1	https://sedapal.maps.arcgis.com/apps/webappviewer/index.html?Íd=90b9ac00a9d843o28f9536380a854000	2088	15
24	5	Cordilleras Glaciares	Mapa de Cordilleras Glaciares	1	https://www.arcgis.com/home/webscene/viewer.html?webscene=aa4e314afb4d4558a12f51fdb021bb7c&viewpoint=cam:-72.21665555,-23.73000922,2176541.167;360,24.93	28	13
25	5	Dashboard sociodemográfico de Lugar de Procedencia de los internos del Perú	El mapeo de la Población Penitenciaria a nivel nacional, muestra los principales indicadores estadísticos sociodemográfico de la Población Penitenciaria mapeada. Se han georreferenciado 85,448 datos de la variable lugar de procedencia de los internos al mes de marzo 2022.	1	https://arcg.is/LqjaH0	32	7
26	5	Datacrim	Sistema de información de estadisticas de la criminalidad	1	https://datacrim.inei.gob.pe/	2	4
27	5	Datass -Modelo para la toma de decisiones en Saneamiento	Aplicativo informático que registra datos de acceso, calidad y sostenibilidad de los servicios de saneamiento en el ámbito rural, fortaleciendo la toma de decisiones del sector.	1	https://datass.vivienda.gob.pe/#	147	20
28	5	Datos abiertos de la Población Penitenciaria	Es una plataforma donde se ubica la data georrefernciada de la Población Penitenciaria, ubicación de los penales y Medios libres para descargar en todas los formatos de GIS y Ciencia de datos.	1	https://portal-inpe.opendata.arcgis.com/search?collection=dataset&layout=grid	32	3
29	5	Descarga de información espacial del MED	Descarga de información espacial del MED	1	http://sigmed.minedu.gob.pe/descargas/	48	17
30	5	Emergencias 24 horas	Muestra la relación de las últimas emergencias registradas en la Central de Emergencias.	1	https://sgonorte.bomberosperu.gob.pe/24horas	36	18
31	5	Emergencias Viales - Provias Nacional	Visor de Emergencias Viales de Provías Nacional que muestra el estado de las carreteras en tiempo real, reportando alertas de tránsito (normal, restringido, interrumpido) por diversos factores como fenómenos naturales, accidentes o disturbios sociales.	1	http://wsgcv.proviasnac.gob.pe/sgcv_emergenciavial	143	19
32	5	ESCALE	Sistema georreferenciado para la ubicacion de centros poblados con servicios educativos, indicadores de educacion, mapas de Direcciones Regionales de Educacion y UGEL	1	http://escale.minedu.gob.pe/mapas	48	17
33	5	Estaciones acelerográficas	\N	1	Sin enlace	57	4
34	5	ESTADIST	Sistema de información distrital para la gestión publica	1	https://estadist.inei.gob.pe/	2	12
35	5	Expedición Huascarán 2019	En esta ocasión el equipo liderado por Lonnie Thompson, investigador experto en paleoclimatologia, y su equipo llegaron hasta las faldas del nevado mas imponente del Perú.	1	https://inaigem.maps.arcgis.com/apps/MapJournal/index.html?appid=e17070683caf4072aa756636dff345d8	28	13
36	5	Geo Transportes y Comunicaciones - Ministerio de Transportes y Comunicaciones	El visor geográfico "Geo Transportes y Comunicaciones" es una herramienta tecnológica interactiva que facilita la visualización y consulta de capas de información del Sector Transportes y Comunicaciones, en los siguientes grupos temáticos: transportes, comunicaciones, logística, gestión del riesgo de desastres e información básica territorial.	1	https://vgeoportal.mtc.gob.pe/index.php	143	19
37	5	Geo visor IDER Ucayali	Permite visualizar, realizar consultas, descargar informacion de un modo sencillo accediendo a la información de diferentes ámbitos administrativos.	1	https://ider.regionucayali.gob.pe/visor	184	4
38	5	GEO ZEE-OT Cajamarca	Muestra los mapas correspondientes al proceso de Ordenamiento Territorial	1	http://sigr.regioncajamarca.gob.pe/	167	16
39	5	GeoAMAZONAS	Portal de la Infraestructura de Datos Espaciales del Gobierno Regional Amazonas	1	http://geoportal.regionamazonas.gob.pe/	162	18
40	5	GeoANP	Herramienta interactiva que permite a los usuarios localizar, visualizar y descargar información espacial que se genera como parte de la gestión de las Áreas Naturales Protegidas (ANP); además brinda acceso al servicio de superposición de áreas de interés o coordenadas con el catastro de ANP y sus zonas de amortiguamiento (ZA)	1	https://geo.sernanp.gob.pe	24	8
41	5	GEOCATASTRO	Representar información catastral del distrito de Miraflores mediante diferentes tipos de capas	1	https://geocatastro.miraflores.gob.pe/#/	533	7
42	5	GEOCATMIN	Sistema de Información Geológico y Catastral Minero	1	https://geocatmin.ingemmet.gob.pe/	124	9
43	5	GeoJusticia	Sistema para la Visualizacion de las Dependencias Judiciales, Distritos Judiciales, Corte suprema, etc.	1	https://geojusticia.pj.gob.pe/basegispj/index.php	21	4
44	5	Geollaqta	Plataforma de Catastro Multipropósito. Cofopri implementa, gestiona, actualiza y ejecuta el Catastro Urbano Nacional. Promueve y establece mecanismos de intercambios de información proveniente de diferentes Entidades Generadores de Catastro.	1	https://catastro.cofopri.gob.pe/geollaqta/	151	16
45	5	GeoPerú	GeoPerú, es el Sistema Nacional de Información Geográfica que integra los datos espaciales e información de los diversos sectores del Estado, para la toma de decisiones a nivel territorial.	1	http://www.geoperu.gob.pe/	1	15
46	5	GeoPortal de Datos Fundamentales del IGN	Geoportal del Instituto Geográfico Nacional	1	http://www.idep.gob.pe/	133	11
47	5	Geoportal del Ministerio de Cultura	El Geoportal del Ministerio de Cultura, es una Infraestructura de Datos Espaciales que integra información geográfica y estadística del sector cultura. Con un acceso dinámico y de fácil manejo, para apoyar en la toma de decisiones e informar al ciudadano.	1	https://geoportal.cultura.gob.pe/	17	17
48	5	Geoportal del Ministerio de Transportes y Comunicaciones	El Geoportal del Ministerio de Transportes y Comunicaciones es la plataforma oficial para el acceso y consulta a los datos, mapas, servicios y aplicaciones de información geográfica espacial y estadística producidos o administrados por el sector Transportes y Comunicaciones. En este espacio digital encontrarás la información sobre la ubicación de las diversas infraestructuras de transportes y de telecomunicaciones desplegadas a nivel nacional, así como la distribución y cobertura de los principales servicios de transportes y comunicaciones. La plataforma contiene de forma complementaria, información básica territorial producida por las entidades públicas productoras.	1	https://geoportal.mtc.gob.pe	143	20
49	5	Geoportal del OTASS	El geoportal del OTASS es una herramienta que permite visualizar y enlazar con todos los productos GIS generados por el OTASS, meviante la ejecución de sus estrategias, proyectos y/o programas en marcha.	1	https://sig.otass.gob.pe/portal/apps/experiencebuilder/experience/?id=a60b271320d2452aa35e986ff2998059	150	7
50	5	Geoportal INAIGEM	Geoportal del Instituto Nacional de Investigación en Glaciares y Ecosistemas de Montaña INAIGEM.	1	https://inaigem.gob.pe/web2/geoportal/	28	13
51	5	Geoportal SERNANP	Herramienta online, desarrollada como parte de la implementación de la infraestructura de datos espaciales (IDE) del SERNANP, a través de la cual podrás acceder a las aplicaciones y servicios de información geoespacial.	1	https://geoportal.sernanp.gob.pe/	24	18
52	5	GEOPORTAL SISCOD	Accede a información cartográfica y georreferenciada sobre la Política Nacional Contra las Drogas	1	https://sistemas.devida.gob.pe/geoportal/inicio.html	5	4
53	5	GEOSERFOR	Portal web de la Infraestructura de Datos Espaciales del SERFOR, cuya finalidad es ofrecer a los usuarios el acceso a una serie de recursos y servicios basados en la información geográfica espacial forestal y de fauna silvestre.	1	https://geo.serfor.gob.pe/geoserfor/	121	18
54	5	GeoSunass	GeoSunass ha sido diseñado para ser de fácil acceso y uso. Permite al usuario manejar adecuadamente sus funcionalidades y herramientas de manera intuitiva. Asimismo, permite almacenar, integrar y compartir información interoperable de otras entidades relacionadas a los servicios de saneamiento.	1	https://geosunass.sunass.gob.pe/	9	20
55	5	GeoVisor Cartográfico	Visor de Mapas que proporciona toda la información que genera el ministerio en temas de saneamiento urbano y rural, así como los temas de vivienda.	1	https://geo2.vivienda.gob.pe/enlaces/geovisor.html	147	20
56	5	Geovisor Cartográfico del SENAMHI	Visor de mapas de información climatologica del Servicio Nacional de Meteorología e Hidrología del Perú (SENAMHI)	1	https://idesep.senamhi.gob.pe/geovisoridesep/	30	5
57	5	Geovisor de cartografia de peligro aplicado en los penales del Perú	El GEOVISOR de cartografía de peligro aplicado a los penales, es una plataforma geoespacial en la web, de libre acceso, diseñada para consultar, compartir, analizar y monitorear la información relacionada a peligros originados por fenómenos naturales.	1	https://www.arcgis.com/apps/webappviewer/index.html?id=5cbec598dc0c4e27b03579eb083b6a23	32	11
58	5	Geovisor de mapeo de Lugar de Procedencia de los internos del Perú	El Geovisor de Lugar de Procedencia de la Población Penitenciaria es una plataforma geoespacial en la web de libre acceso diseñada para consultar, compartir, analizar y monitorear la información georreferenciada de la Población Penitenciaria. Se han georreferenciado 81,988 datos de la variable Lugar de Procedencia de los PPL a nivel nacional al mes de Marzo 2022.	1	https://inpe.maps.arcgis.com/apps/webappviewer/index.html?id=7ca61cba81b642978a44840ec0770390	32	2
59	5	GeoVivienda	Plataforma que proporciona acceso unificado a información, servicios y aplicaciones geoespaciales de la información territorial que viene produciendo y usando el MVCS, como soporte al diseño, planificación, seguimiento de intervenciones y contribuir al cierre de brechas y la mejora de la calidad de los servicios.	1	http://geo.vivienda.gob.pe	147	2
60	5	GESTION DE CERCADO DE LIMA	Este aplicativo muestra la información catastral y el grupo de capas temáticos en el cual se carga la información enviada por otras entidades públicas o privadas, gerencias de MML y otras dependencias vinculadas a la MML en el ámbito de Cercado de Lima	1	https://sit.icl.gob.pe/cercado_lima_app/	2077	2
61	5	Gestión integral de residuos sólidos	Identifica las áreas degradadas por residuos sólidos municipales y no municipales	1	https://pifa.oefa.gob.pe/AppResiduos/	25	15
62	5	Grifo con tienda	El visor permite ubicar los grifos y restaurantes, utilizando GPS del aplicativo para visualizar grifos y tiendas cercanas, para el abastecimiento de productos para los transportistas de carga, la cual se abastecen a la población en época de la emergencia sanitaria COVID-19, Dicha información es coordinada con la Dirección de Políticas y Normas en Transporte Acuático.	1	https://vgrifos.mtc.gob.pe/	143	6
63	5	IDE IGP	Mostrar la información generada por el Instituto Geofísico del Perú e impulsar los estudios y/o productos que se derivan de estos.	1	https://www.igp.gob.pe/servicios/infraestructura-de-datos-espaciales/	29	7
64	5	Info-MIDIS	La plataforma de información geo-referenciada INFOMIDIS permite la visualizacion y disposición de información sobre cobertura (usuarios) de los programas sociales MIDIS, indicadores socioeconómicos, desnutrición crónica infantil, y vulnerabilidad.	1	https://sdv.midis.gob.pe/Infomidis/	160	5
65	5	Intervenciones por Ámbito de interés	Búsqueda por Departamento, Provincias, Distritos,  cuencas hidrográficas, comunidades campesinas, comunidades nativas.	1	https://sistemas.oefa.gob.pe/Portalpifa/Intervenciones.do	25	13
66	5	Investigación en Ecosistemas de Montaña	INAIGEM hace investigación para recuperar y conservar los ecosistemas de montaña y los servicios que estos brindan. Busca rescatar, revalorar y potenciar los conocimientos tradicionales para quienes viven cerca de estos ecosistemas, ya sean instituciones o pobladores, complementándolos y fortaleciéndolos con innovaciones y conocimientos científicos.	1	https://inaigem.maps.arcgis.com/apps/MapSeries/index.html?appid=8e1b90922fdc4fcc94ee41eld44b61a6	28	13
67	5	LICENCIAS DE EDIFICACIÓN	La aplicación Licencia de Edificaciones se realizo en conjunto con la Gerencia de Desarrollo Urbano y tiene como objetivo facilitar la información de licencia de edificaciones de los predios de Cercado de Lima en los años 2016 y 2019.	1	https://sit.icl.gob.pe/gdu_app/	2077	16
68	5	Mapa Base de Información urbana	Base de información del equipamiento socioeconomico y urbano del GORE Callao.	1	https://regioncallao.maps.arcgis.com/apps/webappviewer/index.html?id=8cbfbc1802e14dc7bef5db4dcef096ff	186	4
69	5	Mapa Cultural del Sur	Sistema integrado de información cultural de los siguientes estados: Argentina, Bolivia, Brasil, Chile, Colombia, Ecuador, Paraguay, Perú, Uruguay.\nPaís invitado: Costa Rica.	1	https://geoportal.cultura.gob.pe/mapa_cultural_del_sur/	17	17
70	5	Mapa de alertas de la Superintendencia de transporte terreste de personas, carga y mercancías - SUTRAN	Mapa interactivo de alertas de SUTRAN que informa en tiempo real sobre el estado del tránsito a nivel nacional, incluyendo bloqueos por accidentes, daños en infraestructura o disturbios, manteniendo la información actualizada las 24 horas.	1	http://gis.sutran.gob.pe/alerta_sutran/	143	18
71	5	Mapa de alertas de la Superintendencia de transporte terrestre de personas, carga y mercancías - SUTRAN (centro de gestión y monitoreo)	Plataforma virtual de la SUTRAN que ofrece información y servicios relacionados con la supervisión y fiscalización del transporte terrestre de personas, carga y mercancías en ámbitos nacional e internacional.	1	https://gis.sutran.gob.pe/STR_web/	143	19
72	5	Mapa de ciclovias	Mapa de ciclovias disponibles publicado por la Municipalidad de San Borja	1	http://www.munisanborja.gob.pe/mapa-de-las-ciclovias/	1511	4
73	5	Mapa de Ciudadanía y Patrimonio Cultural	El presente visor de mapas virtual permite conocer el ecosistema social (sociedad civil, instituciones, empresas y otros) que participan activamente en dichas estrategias y proyectos que implementa la Dirección de Participación Ciudadana a nivel nacional, además de las acciones que realizan por su legado cultural local, generando desarrollo local en sus territorios.	1	https://geoportal.cultura.gob.pe/participacion/	17	17
74	5	Mapa de Escuelas	Esta es una herramienta interactiva que permite a usuarios en línea, localizar la oferta del servicio educativo en cada centro poblado o localidad del Perú, así como conocer las características territoriales en la que las instituciones educativas están insertas.	1	http://sigmed.minedu.gob.pe/mapaeducativo/	48	17
125	5	Sistema de Datos Micro Regionales VRAEM	Sistema de datos en cooperación con CENTROGEO-México para la generación de indicadores en el VRAEM.	1	https://sdmr.inei.gob.pe/	2	4
75	5	Mapa de Evacuación y Señalética ante ocurrencia de Tsunamis	Rutas de evacuación, señalética de evacuación, refugios y albergues temporales ante ocurrencia de sismos que generan Tsunami en la Prov.Constitucional del Callao.	1	https://regioncallao.maps.arcgis.com/apps/webappviewer/index.html?id=c131439ec6754be3b8eac75305355623	186	9
76	5	Mapa de fiscalización ambiental	Conoce las acciones de supervisión por subsectores fiscalizables del OEFA y por ámbito territorial	1	https://pifa.oefa.gob.pe/mfiscamb/index.html#	25	14
77	5	Mapa de Paisajes Naturales	El presente visor de mapas virtual permite conocer la distribución de los paisajes culturales declarados e identificados hasta hoy, así como los elementos culturales que lo caracterizan, su relación con otras categorías de patrimonio y otros detalles de la administración del territorio, con el propósito de contribuir en el conocimiento del patrimonio cultural del país y como una herramienta para la toma de decisiones	1	https://geoportal.cultura.gob.pe/mapa_paisajes_culturales/	17	17
78	5	MAPA DE UBICA TU COMISARIA	Visor web que permite al usuario ubicar la comisaría mas cercana y trazar la ruta más optima para llegar a ella.	1	https://aplicaciones.mininter.gob.pe/ubicatucomisaria/	35	4
79	5	Mapa de ubicación de recursos turísticos y emprendimientos de turismo rural	Sistema de información georeferencial de los atractivos turísticos y emprendimientos de turismo rural comunitario del Perú, ofreciendo una búsqueda por criterio geográfico, actividades a desarrollar en el recurso. u otros.	1	https://sigmincetur.mincetur.gob.pe/turismo/	141	6
80	5	MAPA DEL DELITO GEORREFERENCIADO	Visor web que permite al usuario ubicar las zonas de mayor concentración de delitos georreferenciados y conocer las zonas de mayor inseguridad y tomar medidas preventivas. Ademas el aplicativo permite mayores funcionabilidades dependiendo del nivel técnico que realice consultas.	1	https://geomininter.mininter.gob.pe/portal/apps/webappviewer/index.html?id=4b3387e1beaf4f919925dcc013bb4cd7	35	12
81	5	Mapa Energético Minero	Presenta información de los sistemas energéticos por sub sector (Electricidad, Gas Natural, Hidrocarburos y RER) en beneficio de todos los actores que tienen interacción u operan en dichos sistemas así como del público en general.	1	https://gisem.osinergmin.gob.pe/menergetico/	8	2
82	5	Mapa Etnolingüístico del Perú	Sistema informativo y herramienta de planificación para una adecuada toma de decisiones en materia de uso, promoción, recuperación y preservación de las lenguas indígenas u originarias del Perú	1	https://geoportal.cultura.gob.pe/mapa_etnolinguistico/	17	17
83	5	Mapa Geoétnico	Mapa Geoétnico de Presencia Concentrada del Pueblo Afroperuano en el Territorio Nacional, documento que contiene información actualizada sobre la cantidad de hogares afroperuanos y centros poblados con presencia del pueblo afroperuano en el territorio nacional, basado en los datos proporcionados por el Censo Nacional 2017: XII Censo Nacional de Población, VII de Vivienda y III de Comunidades Indígenas	1	https://geoportal.cultura.gob.pe/mapa_afroperuano/	17	17
84	5	Mapa Global de Publicaciones (Amazonia)	El Visor de Servicio Web es una iniciativa que permite hacer consultas, búsquedas y el análisis de la información sobre las investigaciones y publicaciones realizadas en la Región Loreto ahora, y con perspectivas a cubrir el territorio de Amazonia peruana a futuro.	1	http://visores.iiap.gob.pe/publicaciones/	27	13
85	5	Mapa Global de Publicaciones (Amazonia)	El Visor de Servicio Web es una iniciativa que permite hacer consultas, búsquedas y el análisis de la información sobre las investigaciones y publicaciones realizadas en la Región Loreto ahora, y con perspectivas a cubrir el territorio de Amazonia peruana a futuro.	1	https://visores.iiap.gob.pe/publicaciones/	27	13
86	5	Mapa interactivo	Mapa interactivo con información del Ministerio de Comercio Exterior y Turismo	1	https://www.mincetur.gob.pe/centro_de_Informacion/mapa_interactivo/	141	6
87	5	Mapa interactivo de la BDPI	En este mapa podrá realizar consultas sobre la ubicación referencial de los pueblos indígenas u originarios y sus localidades, tales como comunidades nativas, comunidades campesinas y Reservas Territoriales Indígenas. Asimismo, podrá observar elementos de ubicación geográfica como vías asfaltadas, ríos principales, capitales departamentales, provinciales y distritales	1	https://bdpi.cultura.gob.pe/mapa-interactivo	17	17
88	5	Mapa SEIN	Visor de infraestructura de generación y transmisión electrica a nivel nacional	1	https://gisem.osinergmin.gob.pe/nuevo_mapasein	8	18
89	5	Mapa Sonoro	Mapa que muestra la distribucipon de hablantes de las lenguas indígenas del Perú.	1	https://geoportal.cultura.gob.pe/mapa_sonoro/	17	17
90	5	Mapas de la Infraestructura de Transporte	Información acerca de mapas de la Infraestructura de Transporte proporcionada por el Ministerio de Transportes y Comunicaciones.	1	https://portal.mtc.gob.pe/estadisticas/transportes.html	143	18
91	5	Mapas Perú	Sistema que permite la exploracion y valoracion visual de mapas que son provistos por las entidades publicas y privadas que conforman la Infraestructura de Datos Espaciales del Peru.	1	http://mapas.geoidep.gob.pe/mapasperu/	1	18
92	5	Mapas Viales	Permite acceder a información sobre las Rutas Viales del Sistema Nacional de Carreteras (SINAC), puentes, ríos, abras, ciudades, centros poblados, otros puntos de interés	1	https://portal.mtc.gob.pe/transportes/caminos/normas_carreteras/mapas_viales.html	143	19
93	5	MONITOREO DE LA VEGETACIÓN PARA LA PREVENCIÓN DE INCENDIOS FORESTALES	Aplicación que muestra el monitoreo de la humedad relativa de la vegetación	1	https://ide.igp.gob.pe/geovisor/ndvi/	29	5
94	5	MONITOREO DE PELIGRO VOLCÁNICO	Aplicación que muestra escenarios de riesgo del volcán Misti en una posible actividad	1	https://ide.igp.gob.pe/portal/apps/dashboards/1c26d652f18f4771b218afa82fc94897	29	9
95	5	MONITOREO DE RIESGO DE DESASTRES	La aplicación web de Gestión de Riesgo de Desastres muestra la información de Estudios de Riesgo que viene realizando la Subgerencia de Estimación, Prevención, Reducción y Reconstrucción en los diversos distritos de Lima Metropolitana	1	https://sit.icl.gob.pe/gdcgdr_app/	2077	14
96	5	MONITOREO SÍSMICO	Tablero de monitoreo de simos reportados en tiempo real del presente año	1	https://ide-igp.maps.arcgis.com/apps/dashboards/1ee1b5f32a424426aca0b1b81660e34c	29	11
97	5	Obras municipales	Mapa con ubicación geográfica de obras municipales publicado por la Municipalidad de San Borja	1	http://www.munisanborja.gob.pe/mapa-de-obras/	1511	3
126	5	Sistema de Fenómeno el Niño	Permite conocer los riesgos y vulnerabilidad a que está expuesta la población peruana ante la llegada del fenómeno de El Niño y otros fenómenos naturales	1	http://webinei.inei.gob.pe/nino/	2	2
98	5	Observatorio del Agua	Plataforma digital interactiva que recopila información hidrica a nivel nacional para una mejor gestión de los recursos hídricos, tales como estadísticas de la demanda del agua a nivel de cuencas, información de proyectos de formalización de uso del agua, embalses histórica, data sobre inventarios de pozos con datos detallados y otros.	1	https://snirh.ana.gob.pe/ObservatorioSNIRH/	120	13
99	5	Peligros hidrometeorológicos en unidades fiscalizables	Visualización, consulta y análisis de los peligros hidrometeorológicos (activación de quebradas y precipitaciones)en unidades fiscalizables	1	https://pifa.oefa.gob.pe/AppPeligrosUF/	25	13
100	5	Planos estratificados por ingresos a nivel de manzanas de las grandes ciudades	Sistema de información a nivel de manzana del ingreso per cápita para las grandes ciudades.	1	https://planoestratificado.inei.gob.pe/	2	16
101	5	Plataforma del Geoservidor del MINAM	Es una plataforma de Servicios que cuenta con mecanismos de difusion e intercambio de informacion geoespacial que se pone a disposicion de los profesionales, sectores de gobierno, gobiernos regionales, gobiernos locales y sociedad civil en general.	1	https://geoservidor.minam.gob.pe/	23	3
102	5	Plataforma Digital FONDEPES	Mapa online que permite conocer el estado actual de los desembarcaderos pesqueros artesanales.	1	https://plataformadigital.fondepes.gob.pe/mapa	153	3
103	5	Plataforma GEOBOSQUES	Es una plataforma de servicios de información sobre el monitoreo de los cambios de la cobertura de los bosques, que cuenta con cinco sub-módulos de información temática: Bosque y pérdida de bosque, Alertas tempranas, Uso y cambio de uso de la tierra, Degradación, Escenarios de referencia.	1	https://geobosques.minam.gob.pe/geobosque/view/index.php	23	5
104	5	Población con algún tipo de discapacidad en la Prov.Constitucional del Callao	Storymap con Información del Censo de Poblacion y Vivienda 2017 del INEI, donde se muestra poblacion con algun tipo de discapacidad: ver, oir, entender, relacionarse, hablar y moverse.	1	https://storymaps.arcgis.com/stories/16e5e48d32fe4ade887911aa8070c5b5	186	18
105	5	Portal Cartográfico GeoCallao	Difusión de contenidos de lugares de interés, rutas de transporte público, calles y AAHH del Callao	1	https://geocallao-regioncallao.hub.arcgis.com/	186	11
106	5	Portal de Datos Espaciales del Peru GeoIDEP	Proporciona un servicio de acceso unificado a datos, servicios y aplicaciones geoespaciales de la informacion territorial que producen y usan todas las entidades del sector publico y privado.	1	https://www.gob.pe/idep	1	2
107	5	Portal de Infraestructura de Datos Espaciales del INEI	El presente geoportal tiene como objetivo promover el uso y diseminación de la información geoespacial relevante, para la planificación, el desarrollo sostenible y el impulso de las Infraestructuras de Datos Espaciales. Ofrecemos a nuestros usuarios el acceso a aplicaciones y servicios para encontrar, compartir, procesar y utilizar de manera gratuita e interactiva la información.	1	https://ide.inei.gob.pe/	2	18
108	5	RED DE CICLOVÍAS	El presente aplicativo web denominado Red de Ciclovías se realizó en coordinación con la Subgerencia de Transporte No Motorizado de la Municipalidad de Lima	1	https://sit.icl.gob.pe/ciclovias_app/	2077	3
109	5	RED DE PANELES PUBLICITARIOS	El aplicativo web denominado Paneles Publicitarios se realizó en coordinación con la Gerencia de Cartografía y Tecnologías de la Información con el objetivo de acercar a los usuarios, gobiernos locales, entidades públicas, privadas, comunidad académica y público en general a un mayor conocimiento de los anuncios y avisos publicitarios autorizados y ubicados en Lima Metropolitana.	1	https://sit.icl.gob.pe/gdu_paneles/	2077	14
110	5	RED DE SEMAFOROS	La aplicación web de la gestión de la Red Semafórica no Centralizada nos muestra la información en un panel de control como una herramienta de gestión, esta aplicación la viene realizando la GERENCIA DE MOVILIDAD URBANA en los diversos distritos de Lima metropolitana	1	https://sit.icl.gob.pe/gmu/	2077	14
111	5	Registro de denuncias ambientales	Información georreferenciada sobre denuncias ambientales registradas ante el OEFA	1	https://oefa.maps.arcgis.com/apps/dashboards/9d24b76e3b6c4c7cb4035ff36d93902c	25	4
112	5	Reporta Residuos Ciudadano	Conoce las alertas de Residuos sólidos reportadas en tu distrito y las acciones de limpieza realizadas por las municipalidades	1	https://oefa.maps.arcgis.com/apps/webappviewer/index.html?id=7618e413435d495baf20c2e0167eab0e	25	15
113	5	Repositorio de Datasets con geoinformacion regional para consulta y descarga libre	Biblioteca de contenidos del GORE Callao con Datasets disponibles para descarga	1	https://geocallao-regioncallao.hub.arcgis.com/search	186	17
114	5	Retroceso Glaciar 1989 -2018	Mapa de Retroceso Glaciar 1989 - 2018	1	https://inaigem.maps.arcgis.com/apps/StorytellingSwipe/index.html?appid=fdb720b1e2c542ae933f872a2babd63e	28	13
115	5	SedapalWeb	Mostrar a los usuarios la información cartográfica de los activos de SEDAPAL, la cual permite gestionar, analizar y realizar actividades preventivas o correctivas sobre nuestros activos enlazando con información comercial y operativa.	1	http://gisprd.sedapal.com.pe/sedapalweb/	2088	2
116	5	SIGEO PRODUCE	Sistema que permite identificar los agrupamientos empresariales con el fin de focalizar mejor las intervenciones del Estado	1	http://sigeo.produce.gob.pe/appgis/	152	5
117	5	SIN NOMBRE	El observatorio actualmente muestra información de la criminalidad en el Perú	1	http://atlas.indaga.minjus.gob.pe:8080/visor/	31	15
118	5	SIN NOMBRE	Observatorio Nacional de Política Criminal	1	https://indagaweb.minjus.gob.pe/	31	4
119	5	SIRTOD	Sistema regional para la toma de decisiones	1	https://systems.inei.gob.pe/SIRTOD/#	2	5
120	5	SISFOR	Plataforma web donde se publica información de títulos habilitantes forestales y de fauna silvestre supervisados por el OSINFOR y otros relacionados, permitiendo fortalecer la transparencia de nuestras actividades ante los administrados y público en general.	1	https://sisfor.osinfor.gob.pe/visor/	12	2
121	5	Sistema de Consulta de Agua Potable	Sistema que cobertura información de manzana para la cobertura de agua potable	1	https://agua.inei.gob.pe/	2	20
122	5	Sistema de Consulta de centros poblados	Sistema de consulta con indicadores relevantes para los centros poblados	1	http://atlas.inei.gob.pe/inei/	2	18
123	5	Sistema de Consulta de Centros Poblados	Sistema de Consulta de Centros Poblados que brinda información geográfica, demográfica y social de los centros poblados del país.	1	http://sige.inei.gob.pe/test/atlas/	2	18
124	5	Sistema de consulta de mercado de abastos georreferenciados	Sistema que permite consultar la relación de mercados de abastos georeferenciados por UBIGEO	1	http://webinei.inei.gob.pe/cenama/	2	18
127	5	Sistema de Información Ambiental Regional SIAR	Sistema de Información Ambiental Regional SIAR administrado por la Gerencia de Recursos Naturales y Gestión del Medio Ambiente	1	http://siar.regioncajamarca.gob.pe/visor/	167	4
128	5	Sistema de Información de Lucha Contra las Drogas -SISCOD	SISCOD es una herramienta de gestión destinada a integrar y estandarizar la recolección, registro, manejo y consulta de datos, bases de datos y estadísticas, a través de la interacción con otros sistemas que gestionen la información en el ámbito institucional y multisectorial de la lucha contra las drogas, que faciliten el seguimiento, monitoreo y evaluación de la Política Nacional Contra las Drogas.	1	https://sistemas.devida.gob.pe/siscod/	5	18
129	5	Sistema de Información GeoCOSTA	El Sistema de Información para zonas marino costeras -GeoCOSTA es una herramienta de aplicación web geoespacial, diseñado para la visualización, análisis de cartografía georreferenciada y almacenamiento de soporte digital de las diferentes capas espaciales de información temática que contribuirán en el proceso de planificación para la toma de decisiones y desarrollo sostenible de las zonas marino costeras del país.	1	https://geoservidor.minam.gob.pe/geocostas/	23	5
130	5	Sistema de Información Geográfica para Emprendedores	Permite identificar a nivel de áreas geográficas personalizadas las potencialidades del mismo, ya sea identificando las características de las viviendas y de población distribuida por sexo, edad, nivel educativo e ingresos promedio	1	http://sige.inei.gob.pe/sige/	2	18
131	5	Sistema de Información para la Gestión del Riesgo y Desastre	El objetivo principal del sistema es brindar información geoespacial y registros administrativos referidos al riesgo de desastres así como herramientas y/o funcionalidades que permitan a los usuarios acceder, consultar, analizar, monitorear, procesas modelos, cargar y descargar información fundamental que sirva de apoyo para el planeamiento y formulación de proyectos de inversión pública vinculados a la estimación, prevención, reducción de riesgo de desastres y la reconstrucción.	1	https://sigrid.cenepred.gob.pe/sigridv3/	131	7
132	5	Sistema de Información para la Planificación Urbana -Territorial	El Sistema de Información para la Planificación Urbana -Territorial (GEOPLAN), es una herramienta Web que permite interactuar con la Información Geográfica Referenciada disponible en cada uno de los Planes Urbano Territoriales.	1	https://geo2.vivienda.gob.pe/enlaces/geoplan.html	147	7
133	5	SISTEMA DE INFORMACIÓN TERRITORIAL -SIT	Es un visor que muestra una serie de servicios que produce la institución a nivel de Cercado de Lima e información de otras entidades a nivel de Lima Metropolitana.	1	https://sit.icl.gob.pe/sit/	2077	14
134	5	SISTEMA DE MANTENIMIENTO	Este aplicativo muestra información de los mantenimientos programados por la MML y de esta forma, mantenerse al tanto de las acciones que se vienen realizando ello en el marco de los servicios que esta comuna brinda.	1	https://sit.icl.gob.pe/planificacion_mml/	2077	14
135	5	Sistema de toma de decisiones	Sistema de Informacion Regional para la toma de decisiones.	1	https://systems.inei.gob.pe/SIRTOD/#	2	2
136	5	Sistema Georeferenciado de Redes de Telecomunicaciones	Aplicativo basado en un Visor Web que permite visualizar la informacion publica Georreferenciada de las Redes de Telecomunicaciones desplegadas en el territorio peruano, incluyendo las zonas rurales.	1	https://serviciosweb.osiptel.gob.pe/VISORGIS/Visor/VisorPublico.aspx	7	20
137	5	Sistema Regional de Gestión Territorial de Madre de Dios	Geoportal de la Infraestructura de Datos Espaciales del Gobierno Regional de Madre de Dios	1	http://ide.regionmadrededios.gob.pe/	176	18
138	5	SUSALUD map	Aplicativo informático en el cual podrá consultar sobre las condiciones de funcionamiento de los Establecimientos de Salud y Servicios Médicos de Apoyo que se encuentran registrados en el RENIPRESS y cuentan con datos de georreferenciación.	1	http://mapa.susalud.gob.pe/	111	14
139	5	Tablero estadístico de Ingresos y Egresos de la Población Penitenciaria	Tablero estadístico de Ingresos y Egresos muestra información estadística de Egreso por Tipos de Libertades e Ingreso por Delitos Específicos.	1	https://www.arcgis.com/apps/dashboards/0096e3f27ee04658aa63aa9a26f34104	32	15
140	5	Tablero estadístico de la Población Extranjera (Carácteristicas sociodemográficas)	El Geoportal muestra información estadística de la población penal de nacionalidad extranjera por delitos específicos, situación jurídica, evolución histórica y sexo.	1	https://www.arcgis.com/apps/dashboards/72896bfdedf04ac99bb775917f4924e2	32	15
141	5	Tablero estadistico de los Establecimientos de Medio Libre	Se muestra la ubicación geográfica de los Establecimientos de los Medios Libres del Perú según Oficinas Regionales, departamento, provincia y distrito.	1	https://arcg.is/ynu5z0	32	5
142	5	Tablero estadistico de los Establecimientos Penitenciarios	Se muestra la ubicación geográfica de los penales del Perú según Oficinas Regionales, departamento, provincia y distrito.	1	https://www.arcgis.com/apps/dashboards/af652684d4e345c1847a4873edab4d80	32	3
143	5	Tablero estadístico de los Establecimientos Penitenciarios ( Carácteristicas sociodemográficas de los internos del Perú)	Tablero estadístico de los Establecimientos Penitenciarios muestra información estadística de la población penitenciaria	1	https://www.arcgis.com/apps/dashboards/9bfb61bd506f4162b97e3c2fefb53ee2	32	15
144	5	Tablero Estadístico de los Venezolanos	Este tablero estadistico muestra la información estadística de la población penal de venezolanos por delitos específicos, situación jurídica, evolución histórica y sexo.	1	https://www.arcgis.com/apps/dashboards/b9453691b14d4ff6bf34c2d26d4637ac	32	11
145	5	Tablero estadístico de Lugar de Procedencia de la Población de Sentenciados de Medio Libre del distrito de San Martín de Porres	Para el distrito de San Martín de Porres se presentan los siguientes análisis:\n1) La problemática de procedencia en función a los delitos generales y específicos.\n2) Los núcleos urbanos con altos índices de densidad de lugar de procedencia.\nEn total se han georreferenciado 731 sentenciados de Medio Libre	1	https://inpe.maps.arcgis.com/apps/MapJournal/index.html?appid=c36a49b7e9304116a109ba9f5c1d3ad4	32	11
146	5	Tablero estadístico de Lugar de Procedencia de Sentenciados de Medio Libre	Principales indicadores sociodemográficos y focos de concentración del lugar de Procedencia en los distritos de San Juan de Lurigancho, San Martin de Porres, Ate y La Victoria. En total se han georreferenciado 3,039 sentenciados de Medio Libre.	1	https://inpe.maps.arcgis.com/apps/webappviewer/index.html?id=e18032b3eada4470880d7481baadc242&extent=-8600907.8126%2C-1364065.1396%2C-8496724.143%2C-1322330.5222%2C102100	32	3
192	7	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Huallaga	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica del Huallaga año 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=5	5	12
147	5	Tablero Estadístico de mapeo de Lugar de Procedencia	El Tablero Estadístico de mapeo de la Población Penitenciaria a nivel nacional, muestra los principales indicadores estadísticos sociodemográfico de la Población Penitenciaria mapeada. Se han georreferenciado 85,448 datos de la variable lugar de procedencia de los internos al mes de Marzo 2022	1	https://www.arcgis.com/apps/dashboards/1bf4a5b854df4d59b7b54326ce9a5629	32	7
148	5	Ubícanos a Nivel Nacional	Muestra la ubicación de las compañías y comandancias departamentales del CGBVP a nivel nacional.	1	http://www.bomberosperu.gob.pe/cgbvp_maps.asp	36	7
149	5	Vigilancia ambiental de la calidad de aire	Consulta la calidad de aire en tiempo real a nivel nacional.	1	https://pifa.oefa.gob.pe/VigilanciaAmbiental/	25	5
150	5	Visor Cartográfico -GEOSERFOR	El GEOSERFOR es una herramienta tecnológica web, para disponer y consultar en internet la información geográfica sobre la gestión forestal. El GEOSERFOR cuenta con varias capas de información como son: las concesiones forestales, los bosques de producción permanente, las unidades de aprovechamiento, los bosques locales, la zonificación forestal y más.	1	https://geo.serfor.gob.pe/visor/#	121	16
151	5	Visor Cartográfico Institucional GOTASS	El GOTASS es una herramienta de tipo geovisor que permite visualizar, consultar, actualizar y analizar información georeferenciada del OTASS y otras entidades técnico científicas generadoras de información georeferenciada. Asimismo, el OTASS desarrolla de manera continua aplicativos web con tecnología GIS de acuerdo a las necesidades generadas en las áreas usuarias competentes, considerando las estrategias, proyectos y/o programas en marcha.	1	https://app.otass.gob.pe/gotass	150	2
152	5	Visor de Alertas de Siniestros Viales - Ministerio de Transportes y Comunicaciones	Mapa interactivo del Ministerio de Transportes y Comunicaciones (MTC) que permite a los ciudadanos conocer el estado de las carreteras a nivel nacional en tiempo real.	1	https://sratma.mtc.gob.pe/SRATMA/mapa/	143	19
153	5	Visor de Emergencias del Centro de Operaciones de Emergencias del Ministerio de Transportes y Comunicaciones	Mapa interactivo del Ministerio de Transportes y Comunicaciones (MTC) que pemite a los ciudadanos contar con información sobre las incidencias en carreteras, vías férreas, puertos y aeropuertos. La información se actualiza permanentemente las 24 horas del día.	1	https://saecoe.mtc.gob.pe/visor	143	19
154	5	Visor de Emergencias Hidricas	Monitorea y brinda información sobre peligros, emergencias y desastres relacionados a los recursos hídricos	1	https://snirh.ana.gob.pe/onrh/Index2.aspx?IdVar=39	120	13
155	5	Visor de Inventarios de Recursos Naturales	Este visor permite mostrar los inventarios realizados por el Instituto en el ámbito de la Amazonia Peruana. Se encuentra clasificado en grupos de Fauna, Flora, Suelos. El usuario podrá hacer uso de otras capas temáticas asi como descargar los datos de los inventarios.	1	http://visores.iiap.gob.pe/inventarios/	27	13
156	5	Visor de Inventarios de Recursos Naturales	Este visor permite mostrar los inventarios realizados por el Instituto en el ámbito de la Amazonia Peruana. Se encuentra clasificado en grupos de Fauna, Flora, Suelos. El usuario podrá hacer uso de otras capas temáticas asi como descargar los datos de los inventarios.	1	https://visores.iiap.gob.pe/inventarios/	27	13
157	5	Visor de la Infraestructur a de Datos Espaciales de Loreto	Sistema que permite la exploración y descarga de mapas de la Región Loreto	1	http://visor.regionloreto.gob.pe/	175	7
158	5	Visor de la Red Vial Nacional - Provias Nacional	Visor geográfico (WEBMAP) de Provías Nacional que permite consultar y visualizar la Red Vial Nacional y las intervenciones realizadas por Provías Nacional.	1	https://spwgm.proviasnac.gob.pe/webmap	143	19
159	5	Visor de Mapas de Electrificación Rural - DGER	Sistema de Consulta Web de Datos Espaciales de los Sistemas Eléctricos Rurales	1	https://mapas.minem.gob.pe/map_dger/	122	4
160	5	Visor de Mapas de GeoSunass	Visor de mapas de GeoSunass que permite visualizar información georreferenciada publicada por SUNASS y diversas entidades relacionadas a los servicios de saneamiento, generar reportes y descargar información en línea.	1	https://experience.arcgis.com/experience/12dd1e86bc3046eca8ba0b82b77ca508/	9	20
161	5	Visor de mapas de la IDE Madre de Dios	Visor de mapas de la Infraestructura de Datos Espaciales del Gobierno Regional de Madre de Dios	1	http://ide.regionmadrededios.gob.pe/geohub/default/home/index	176	18
162	5	Visor de mapas de la Infraestructur a de Datos Espaciales de Amazonas	Visor de mapas de la Infraestructura de Datos Espaciales de Amazonas	1	http://visor.regionamazonas.gob.pe/indexv.php	162	18
163	5	Visor de mapas del INAIGEM	Visor de mapas que concentra las investigaciones de los glaciares y ecosistemas de montaña elaborados por el Instituto Nacional de Investigación en Glaciares y Ecosistemas de Montaña (Inaigem).	1	https://visor.inaigem.gob.pe/	28	13
164	5	Visor de mapas del potencial eólico del Perú 2016	Ubicación con estadísticas de monitoreo sobre el Potencial Eólico del Perú	1	https://mapas.minem.gob.pe/map_eolico/	122	12
165	5	Visor de mapas del Potencial Hidroeléctric o en la cuentas del Apurímac, Madre de Dios, Purús, Grande	Ubicación y descripción de Proyectos con Potencial Hidroeléctrico en la cuentas del Apurímac, Madre de Dios, Purús, Grande, Chili, Tambo y Titicaca	1	https://mapas.minem.gob.pe/map_hidroelectrico/	122	2
166	5	Visor de mapas del SIG-DGER, referida al sistema de electrificació n rural	Elaborado con el fin de consultar y compartir información de los sistemas de electrificación rural a nivel nacional	1	https://mapas.minem.gob.pe/map_dger/	122	3
167	5	Visor de mapas del Sistema Nacional de Informacion Ambiental	Sistema que permite la visualizacion de informacion ambiental del SINIA	1	https://sinia.minam.gob.pe/portal/mapas-sinia/	23	2
168	5	Visor de Mapas IDERSAM	El visor de mapas brinda acceso a información espacial generada por el Gobierno Regional de San Martín en el cumplimiento de sus funciones. Estos datos tiene carácter oficial y están a disposición de la comunidad.	1	https://geoportal.regionsanmartin.gob.pe/visor/	181	2
169	5	Visor del Geoservidor del MINAM	Es una Plataforma de Servicios que cuenta con mecanismos de difusión e intercambio de información geoespacial que se pone a disposición de profesionales, sectores de gobierno, gobiernos regionales, gobiernos locales y sociedad civil en general; para que a través del internet puedan acceder a información relevante sobre la situación territorial y ambiental del país de manera transparente y actualizada.	1	https://app.minam.gob.pe/geominam/minam/home/index	23	7
193	7	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI La Convención-Kosñipata	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica La Convención-Kosñipata año 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=6	5	11
170	5	Visor del Sistema de Información para la Planificación Urbana -Territorial	El Sistema de Información para la Planificación Urbana -Territorial (GEOPLAN), es una herramienta Web que permite interactuar con la Información Geográfica Referenciada disponible en cada uno de los Planes Urbano Territoriales.	1	https://geo2.vivienda.gob.pe/mvcs/index.php	147	7
171	5	Visor GEOBOSQUES	El visor muestra las Alertas Tempranas de Deforestación, la cual es actualizada semanalmente, si un usuario se inscribe al sistema de alertas puede desde este visor gestionar sus áreas de monitoreo y saber cuantas alertas ocurren semanalmente.	1	https://geobosques.minam.gob.pe/geobosque/visor/	23	8
172	5	Visor geográfico del MIDAGRI	Repositorio centralizado y oficial de la información geográfica producida por el sector agrario y de riego.	1	https://geovisor.midagri.gob.pe/	116	13
173	5	Visor GIS - Autoridad Portuaria Nacional	Visor GIS de la Autoridad Portuaria Nacional (APN) que proporciona información geográfica sobre instalaciones portuarias, áreas otorgadas, edificaciones, equipamiento y desarrollo portuario.	1	https://gis.apn.gob.pe/visor_gis/	143	18
174	5	Visor SIAR Cusco	El SIAR, constituye una red de integración tecnológica, institucional y humana que facilita la sistematización, acceso y distribución de la información ambiental en el ámbito territorial de la Región.	1	http://siar.regioncusco.gob.pe/	168	18
175	7	Aeropuertos concesionad os por OSITRAN	OSITRAN supervisa y regula 19 aeropuertos concesionados ubicados en distintas ciudades del territorio peruano. La seguridad, calidad de los servicios, tecnología e infraestructura implementada en estos terminales son la base para el desarrollo de la actividad turística y de negocios de nuestro país.	1	https://www.ositran.gob.pe/aeropuertos/	10	19
176	7	Carreteras concesionadas por OSITRAN	OSITRAN supervisa 16 contratos de concesión de carreteras a nivel nacional, que permiten el crecimiento económico conectado de las poblaciones más alejadas del país.	1	https://www.ositran.gob.pe/carreteras/	10	19
177	7	Compendio de Mapas 2022	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	1	https://www.gob.pe/institucion/mtc/informes-publicaciones/4517084	143	18
178	7	Compendio de Mapas 2023 - I Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	1	https://www.gob.pe/institucion/mtc/informes-publicaciones/5137608	143	18
179	7	Compendio de Mapas 2023 - II Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	1	https://www.gob.pe/institucion/mtc/informes-publicaciones/5987687	143	18
180	7	Compendio de Mapas 2024 - I Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	1	https://www.gob.pe/institucion/mtc/informes-publicaciones/6161466	143	18
181	7	Compendio de Mapas 2024 - II Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	1	https://www.gob.pe/institucion/mtc/informes-publicaciones/6763678	143	18
182	7	Conservación por Niveles de Servicios	Conservación por Niveles de Servicios en formato KML	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_CNS/MapServer/generateKML	143	19
183	7	Demarcación Territorial	Brinda la información correspondiente a Limites Interdepartamentales, EDZ, SOT y categorizaciones.	1	https://dt.regioncajamarca.gob.pe/	167	4
184	7	Ecozonas	Cobertura de Ecozonas del Perú, corresponde a subpoblaciones usadas para el inventario nacional forestal y de fauna silvestre, definido en base en criterios fisiográfico, fisionómico, florístico, capacidad de almacenamiento de carbono y accesibilidad. Esta cobertura es empleada por los administrados en comunidades para aplicar al mecanismo de compensación de multas por conservación de bosques.	1	https://sisfor.osinfor.gob.pe/visor/	12	14
185	7	Estudios de la Red Vial Nacional	Estudios de la Red Vial Nacional	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Estudios/MapServer/generateKML	143	19
186	7	Información disponible Geoservidor	Esta herramienta permite disponer de información en formato shapefiles, a fin de ser utilizadas por los espacialistas en los diferentes analisis espaciales.	1	https://geoservidor.minam.gob.pe/recursos/intercambio-de-datos/	23	7
187	7	Itinerarios de la Red Vial Nacional	Itinerarios de la Red Vial Nacional en formato KML	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Itinerario/MapServer/generateKML	143	19
188	7	Mantenimien to de la Red Vial Nacional	Mantenimiento de la Red Vial Nacional en formato KML	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Mantenimiento/MapServer/generateKML	143	19
189	7	Mapa de Oficina Zonales 2019	Ámbito geográfico de Oficinas Zonales de DEVIDA	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=2	5	11
190	7	Mapa de Población Objetivo PIRDAIS 2019	Ámbito geográfico de intervención de la Población Objetiva del Programa Presupuestal del PIRDAIS 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=3	5	11
191	7	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Corredor Amazónico	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona estratégica del Corredor Amazónico año 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=4	5	12
194	7	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Sur Amazónico	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica Sur Amazónico año 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=7	5	12
195	7	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Triple Frontera	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica La Convención-Kosñipata año 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=8	5	4
196	7	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI VRAEM	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica VRAEM año 2020	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=9	5	12
197	7	Mapas temáticos de Ayacucho	Mapas temáticos del departamento de Ayacucho para descargar	1	https://www.regionayacucho.gob.pe/SIGWEB/	166	4
198	7	Monitoreo de la Superficie Cultivada con Arbusto de hoja de Coca en producción 2017	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio Peruano, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2017.	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=10	5	2
199	7	Monitoreo de la Superficie Cultivada con Arbusto de hoja de Coca en producción 2018	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio Peruano, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2018.	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=11	5	2
200	7	Monitoreo de la Superficie Cultivada en Áreas Naturales Protegidas 2017	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio de Áreas Naturales Protegidas, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2017.	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=13	5	8
201	7	Monitoreo de la Superficie Cultivada en Áreas Naturales Protegidas 2018	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio de Áreas Naturales Protegidas, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2018.	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=14	5	8
202	7	Monitoreo de la Superficie Cultivada en Áreas Naturales Protegidas 2019	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio de Áreas Naturales Protegidas, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2019.	1	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=15	5	8
203	7	Obras de la Red Vial Nacional	Obras de la Red Vial Nacional	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Obras/MapServer/generateKML	143	19
204	7	Peajes concesionados de la Red Vial Nacional	Peajes concesionados de la Red Vial Nacional en formato KML	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_PeajesConcesionados/MapServer/generateKML	143	19
205	7	Peajes no concesionados de la Red Vial Nacional	Peajes no concesionados de la Red Vial Nacional en formato KML	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_PeajesNoConcesionados/MapServer/generateKML	143	19
206	7	Portal Principal Ordenamiento Territorial GRC	Contiene toda la información correspondiente al proceso de Ordenamiento Territorial de Cajamarca incluyendo mapas y shapefiles	1	http://zeeot.regioncajamarca.gob.pe/	167	14
207	7	Puentes de la Red Vial Nacional	Puentes de la Red Vial Nacional en formato KML	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Puentes/MapServer/generateKML	143	19
208	7	Puertos concesionad os que son supervisados por OSITRAN	El OSITRAN supervisa y regula 7 terminales portuarios ubicados en diversas regiones del país, que brindan servicios a exportadores e importadores, permitiendo el intercambio de productos peruanos a nivel internacional.	1	https://www.ositran.gob.pe/puertos/	10	19
209	7	Red Vial Nacional	Red Vial Nacional	1	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_InfraestructuraVial/MapServer/generateKML	143	19
210	7	Vías férreas concesionadas por OSITRAN	El transporte ferroviario ofrece grandes ventajas como la gran capacidad de carga por eje, la menor tasa de accidentabilidad, el ahorro de combustible, la menor cantidad de emisiones contaminantes y la descongestión de las carreteras. Además constituye el transporte masivo más eficiente de los últimos años.	1	https://www.ositran.gob.pe/vias-ferreas/	10	19
\.


--
-- TOC entry 5035 (class 0 OID 350038)
-- Dependencies: 232
-- Data for Name: def_instituciones; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_instituciones (id, pliego, nombre, logotipo, sigla, id_sector) FROM stdin;
1	1	PRESIDENCIA DEL CONSEJO DE MINISTROS	\N	PCM	1
2	2	INSTITUTO NACIONAL DE ESTADISTICA E INFORMATICA	\N	INEI	1
3	10	DIRECCION NACIONAL DE INTELIGENCIA	\N	DINI	1
4	11	DESPACHO PRESIDENCIAL	\N	DP	1
5	12	COMISION NACIONAL PARA EL DESARROLLO Y VIDA SIN DROGAS	\N	DEVIDA	1
6	16	CENTRO NACIONAL DE PLANEAMIENTO ESTRATEGICO	\N	CEPLAN	1
7	19	ORGANISMO SUPERVISOR DE LA INVERSION PRIVADA EN TELECOMUNICACIONES	\N	OSIPTEL	1
8	20	ORGANISMO SUPERVISOR DE LA INVERSION EN ENERGIA Y MINERIA	\N	OSINERGMIN	1
9	21	SUPERINTENDENCIA NACIONAL DE SERVICIOS DE SANEAMIENTO	\N	SUNASS	1
10	22	ORGANISMO SUPERVISOR DE LA INVERSION EN INFRAESTRUCTURA DE TRANSPORTE DE USO PUBLICO	\N	OSITRAN	1
11	23	AUTORIDAD NACIONAL DEL SERVICIO CIVIL	\N	SERVIR	1
12	24	ORGANISMO DE SUPERVISION DE LOS RECURSOS FORESTALES Y DE FAUNA SILVESTRE	\N	OSINFOR	1
13	29	AUTORIDAD NACIONAL DE INFRAESTRUCTURA	\N	ANIN	1
14	31	ORGANISMO DE ESTUDIOS Y DISEÑO DE PROYECTOS DE INVERSION	\N	OEDI	1
15	114	CONSEJO NACIONAL DE CIENCIA, TECNOLOGIA E INNOVACION TECNOLOGICA	\N	CONCYTEC	1
16	183	INSTITUTO NACIONAL DE DEFENSA DE LA COMPETENCIA Y DE LA PROTECCION DE LA PROPIEDAD INTELECTUAL	\N	INDECOPI	1
17	3	MINISTERIO DE CULTURA	\N	MC	2
18	60	ARCHIVO GENERAL DE LA NACION	\N	CULTURA	2
19	113	BIBLIOTECA NACIONAL DEL PERU	\N	BNP	2
20	116	INSTITUTO NACIONAL DE RADIO Y TELEVISION DEL PERU	\N	IRTP	2
21	4	PODER JUDICIAL	\N	PJ	3
22	40	ACADEMIA DE LA MAGISTRATURA	\N	AMAG	3
23	5	MINISTERIO DEL AMBIENTE	\N	MINAM	4
24	50	SERVICIO NACIONAL DE AREAS NATURALES PROTEGIDAS POR EL ESTADO	\N	SERNANP	4
25	51	ORGANISMO DE EVALUACION Y FISCALIZACION AMBIENTAL	\N	OEFA	4
26	52	SERVICIO NACIONAL DE CERTIFICACION AMBIENTAL PARA LAS INVERSIONES SOSTENIBLES	\N	SENACE	4
27	55	INSTITUTO DE INVESTIGACIONES DE LA AMAZONIA PERUANA	\N	IIAP	4
28	56	INSTITUTO NACIONAL DE INVESTIGACION EN GLACIARES Y ECOSISTEMAS DE MONTAÑA	\N	INAIGEM	4
29	112	INSTITUTO GEOFISICO DEL PERU	\N	IGP	4
30	331	SERVICIO NACIONAL DE METEOROLOGIA E HIDROLOGIA	\N	SENAMHI	4
31	6	MINISTERIO DE JUSTICIA Y DERECHOS HUMANOS	\N	MINJUS	5
32	61	INSTITUTO NACIONAL PENITENCIARIO	\N	INP	5
33	67	SUPERINTENDENCIA NACIONAL DE LOS REGISTROS PUBLICOS	\N	SUNARP	5
34	68	PROCURADURIA GENERAL DEL ESTADO	\N	PGE	5
35	7	MINISTERIO DEL INTERIOR	\N	MININTER	6
36	70	INTENDENCIA NACIONAL DE BOMBEROS DEL PERÚ	\N	INBP	6
37	72	SUPERINTENDENCIA NACIONAL DE CONTROL DE SERVICIOS DE SEGURIDAD, ARMAS, MUNICIONES Y EXPLOSIVOS DE USO CIVIL	\N	SUCAMEC	6
38	73	SUPERINTENDENCIA NACIONAL DE MIGRACIONES	\N	MIGRACIONES	6
39	8	MINISTERIO DE RELACIONES EXTERIORES	\N	RR.EE.	7
40	80	AGENCIA PERUANA DE COOPERACION INTERNACIONAL	\N	APCI	7
41	9	MINISTERIO DE ECONOMIA Y FINANZAS	\N	MEF	8
42	55	AGENCIA DE PROMOCION DE LA INVERSION PRIVADA	\N	PROINVERSION	8
43	57	SUPERINTENDENCIA NACIONAL DE ADUANAS Y DE ADMINISTRACION TRIBUTARIA	\N	SUNAT	8
44	58	SUPERINTENDENCIA DEL MERCADO DE VALORES	\N	SMV	8
45	59	ORGANISMO ESPECIALIZADO PARA LAS CONTRATACIONES PUBLICAS EFICIENTES	\N	OECE	8
46	95	OFICINA DE NORMALIZACION PREVISIONAL	\N	ONP	8
47	96	CENTRAL DE COMPRAS PUBLICAS	\N	PERU COMPRAS	8
48	10	MINISTERIO DE DE EDUCACION	\N	MINEDU	9
49	111	CENTRO VACACIONAL HUAMPANI	\N	HUAMPANI	9
50	117	SISTEMA NACIONAL DE EVALUACION, ACREDITACION Y CERTIFICACION DE LA CALIDAD EDUCATIVA	\N	SINEACE	9
51	118	SUPERINTENDENCIA NACIONAL DE EDUCACION SUPERIOR UNIVERSITARIA	\N	SUNEDU	9
52	342	INSTITUTO PERUANO DEL DEPORTE	\N	IPD	9
53	510	UNIVERSIDAD NACIONAL MAYOR DE SAN MARCOS	\N	UNMSM	9
54	511	UNIVERSIDAD NACIONAL DE SAN ANTONIO ABAD DEL CUSCO	\N	UNSAAC	9
55	512	UNIVERSIDAD NACIONAL DE TRUJILLO	\N	UNT	9
56	513	UNIVERSIDAD NACIONAL DE SAN AGUSTIN	\N	UNSA	9
57	514	UNIVERSIDAD NACIONAL DE INGENIERIA	\N	UNI	9
58	515	UNIVERSIDAD NACIONAL SAN LUIS GONZAGA DE ICA	\N	UNSLG	9
59	516	UNIVERSIDAD NACIONAL SAN CRISTOBAL DE HUAMANGA	\N	UNSCH	9
60	517	UNIVERSIDAD NACIONAL DEL CENTRO DEL PERU	\N	UNCP	9
61	518	UNIVERSIDAD NACIONAL AGRARIA LA MOLINA	\N	UNALM	9
62	519	UNIVERSIDAD NACIONAL DE LA AMAZONIA PERUANA	\N	UNAP	9
63	520	UNIVERSIDAD NACIONAL DEL ALTIPLANO	\N	UNA PUNO	9
64	521	UNIVERSIDAD NACIONAL DE PIURA	\N	UNP	9
65	522	UNIVERSIDAD NACIONAL DE CAJAMARCA	\N	UNC	9
66	523	UNIVERSIDAD NACIONAL PEDRO RUIZ GALLO	\N	UNPRG	9
67	524	UNIVERSIDAD NACIONAL FEDERICO VILLARREAL	\N	UNFV	9
68	525	UNIVERSIDAD NACIONAL HERMILIO VALDIZAN	\N	UNHV	9
69	526	UNIVERSIDAD NACIONAL AGRARIA DE LA SELVA	\N	UNAS	9
70	527	UNIVERSIDAD NACIONAL DANIEL ALCIDES CARRION	\N	UNDAC	9
71	528	UNIVERSIDAD NACIONAL DE EDUCACION ENRIQUE GUZMAN Y VALLE	\N	UNE	9
72	529	UNIVERSIDAD NACIONAL DEL CALLAO	\N	UNAC	9
73	530	UNIVERSIDAD NACIONAL JOSE FAUSTINO SANCHEZ CARRION	\N	UNJFSC	9
74	531	UNIVERSIDAD NACIONAL JORGE BASADRE GROHMANN	\N	UNJBG	9
75	532	UNIVERSIDAD NACIONAL SANTIAGO ANTUNEZ DE MAYOLO	\N	UNSAM	9
76	533	UNIVERSIDAD NACIONAL DE SAN MARTIN	\N	UNSM	9
77	534	UNIVERSIDAD NACIONAL DE UCAYALI	\N	UNU	9
78	535	UNIVERSIDAD NACIONAL DE TUMBES	\N	UNT	9
79	536	UNIVERSIDAD NACIONAL DEL SANTA	\N	UNS	9
80	537	UNIVERSIDAD NACIONAL DE HUANCAVELICA	\N	UNH	9
81	538	UNIVERSIDAD NACIONAL AMAZONICA DE MADRE DE DIOS	\N	UNAMAD	9
82	539	UNIVERSIDAD NACIONAL MICAELA BASTIDAS DE APURIMAC	\N	UNAMBA	9
83	541	UNIVERSIDAD NACIONAL TORIBIO RODRIGUEZ DE MENDOZA DE AMAZONAS	\N	UNTRM	9
84	542	UNIVERSIDAD NACIONAL INTERCULTURAL DE LA AMAZONIA	\N	UNIA	9
85	543	UNIVERSIDAD NACIONAL TECNOLOGICA DE LIMA SUR	\N	UNTELS	9
86	544	UNIVERSIDAD NACIONAL JOSE MARIA ARGUEDAS	\N	UNAJMA	9
87	545	UNIVERSIDAD NACIONAL DE MOQUEGUA	\N	UNM	9
88	546	UNIVERSIDAD NACIONAL DE JAEN	\N	UNJ	9
89	547	UNIVERSIDAD NACIONAL DE CAÑETE	\N	UNDC	9
90	548	UNIVERSIDAD NACIONAL DE FRONTERA	\N	UNF	9
91	549	UNIVERSIDAD NACIONAL DE BARRANCA	\N	UNAB	9
92	550	UNIVERSIDAD NACIONAL AUTONOMA DE CHOTA	\N	UNACH	9
93	551	UNIVERSIDAD NACIONAL INTERCULTURAL DE LA SELVA CENTRAL JUAN SANTOS ATAHUALPA	\N	UNISCJSA	9
94	552	UNIVERSIDAD NACIONAL DE JULIACA	\N	UNAJ	9
95	553	UNIVERSIDAD NACIONAL AUTÓNOMA ALTOANDINA DE TARMA	\N	UNAAT	9
96	554	UNIVERSIDAD NACIONAL AUTÓNOMA DE HUANTA	\N	UNAH	9
97	555	UNIVERSIDAD NACIONAL INTERCULTURAL FABIOLA SALAZAR LEGUIA DE BAGUA	\N	UNIFSLB	9
98	556	UNIVERSIDAD NACIONAL INTERCULTURAL DE QUILLABAMBA	\N	UNIQ	9
99	557	UNIVERSIDAD NACIONAL AUTONOMA DE ALTO AMAZONAS	\N	UNAAA	9
100	558	UNIVERSIDAD NACIONAL AUTONOMA DE TAYACAJA DANIEL HERNANDEZ MORILLO	\N	UNAT	9
101	559	UNIVERSIDAD NACIONAL CIRO ALEGRIA	\N	UNCA	9
102	560	UNIVERSIDAD NACIONAL DE ARTE DIEGO QUISPE TITO DEL CUSCO	\N	UNADQTC	9
103	561	UNIVERSIDAD NACIONAL DE MÚSICA	\N	UNM	9
104	562	UNIVERSIDAD NACIONAL DANIEL ALOMIA ROBLES	\N	UNDAR	9
105	563	UNIVERSIDAD NACIONAL TECNOLOGICA DE FRONTERA SAN IGNACIO DE LOYOLA	\N	UNATEFSIL	9
106	564	UNIVERSIDAD NACIONAL TECNOLOGICA DE SAN JUAN DE LURIGANCHO	\N	UNTSJL	9
107	567	UNIVERSIDAD NACIONAL DEL VRAEM	\N	\N	9
108	569	UNIVERSIDAD NACIONAL AUTONOMA DE CUTERVO	\N	\N	9
109	11	MINISTERIO DE SALUD	\N	MINSA	9
110	131	INSTITUTO NACIONAL DE SALUD	\N	\N	9
111	134	SUPERINTENDENCIA NACIONAL DE SALUD	\N	SUSALUD	9
112	135	SEGURO INTEGRAL DE SALUD	\N	SIS	9
113	136	INSTITUTO NACIONAL DE ENFERMEDADES NEOPLASICAS	\N	INEN	9
114	12	MINISTERIO DE TRABAJO Y PROMOCION DEL EMPLEO	\N	MTPE	11
115	121	SUPERINTENDENCIA NACIONAL DE FISCALIZACION LABORAL	\N	SUNAFIL	11
116	13	MINISTERIO DE DESARROLLO AGRARIO Y RIEGO	\N	MIDAGRI	12
117	18	AGROMERCADO	\N	AGROMERCADO	12
118	160	SERVICIO NACIONAL DE SANIDAD AGRARIA	\N	SENASA	12
119	163	INSTITUTO NACIONAL DE INNOVACION AGRARIA	\N	INIA	12
120	164	AUTORIDAD NACIONAL DEL AGUA	\N	ANA	12
121	165	SERVICIO NACIONAL FORESTAL Y DE FAUNA SILVESTRE	\N	SERFOR	12
122	16	MINISTERIO DE ENERGIA Y MINAS	\N	MEM	13
123	220	INSTITUTO PERUANO DE ENERGIA NUCLEAR	\N	IPEN	13
124	221	INSTITUTO GEOLOGICO MINERO Y METALURGICO	\N	INGEMMET	13
125	19	CONTRALORIA GENERAL	\N	CONTRALORIA	14
126	20	DEFENSORIA DEL PUEBLO	\N	DEFENSORIA	15
127	21	JUNTA NACIONAL DE JUSTICIA	\N	JNJ	16
128	22	MINISTERIO PUBLICO	\N	MP	17
129	24	TRIBUNAL CONSTITUCIONAL	\N	TC	18
130	6	INSTITUTO NACIONAL DE DEFENSA CIVIL	\N	INDECI	19
131	25	CENTRO NACIONAL DE ESTIMACION, PREVENCION Y REDUCCION DEL RIESGO DE DESASTRES	\N	CENEPRED	19
132	26	MINISTERIO DE DEFENSA	\N	MINDEF	19
133	332	INSTITUTO GEOGRAFICO NACIONAL	\N	IGN	19
134	335	AGENCIA DE COMPRAS DE LAS FUERZAS ARMADAS	\N	ACFFAA	19
135	27	FUERO MILITAR POLICIAL	\N	FMP	20
136	28	CONGRESO DE LA REPUBLICA	\N	CONGRESO	21
137	31	JURADO NACIONAL DE ELECCIONES	\N	JNE	22
138	32	OFICINA NACIONAL DE PROCESOS ELECTORALES	\N	ONPE	23
139	33	REGISTRO NACIONAL DE IDENTIFICACION Y ESTADO CIVIL	\N	RENIEC	24
140	8	COMISION DE PROMOCION DEL PERU PARA LA EXPORTACION Y EL TURISMO	\N	PROMPERU	25
141	35	MINISTERIO DE COMERCIO EXTERIOR Y TURISMO	\N	MINCETUR	25
142	180	CENTRO DE FORMACION EN TURISMO	\N	CFT	25
143	36	MINISTERIO DE TRANSPORTES Y COMUNICACIONES	\N	MTC	26
144	202	SUPERINTENDENCIA DE TRANSPORTE TERRESTRE DE PERSONAS, CARGA Y MERCANCIAS	\N	SUTRAN	26
145	203	AUTORIDAD DE TRANSPORTE URBANO PARA LIMA Y CALLAO	\N	ATU	26
146	214	AUTORIDAD PORTUARIA NACIONAL	\N	APN	26
147	37	MINISTERIO DE VIVIENDA, CONSTRUCCION Y SANEAMIENTO	\N	MVCS	27
148	56	SUPERINTENDENCIA NACIONAL DE BIENES ESTATALES	\N	SBN	27
149	205	SERVICIO NACIONAL DE CAPACITACION PARA LA INDUSTRIA DE LA CONSTRUCCION	\N	SENCICO	27
150	207	ORGANISMO TECNICO DE LA ADMINISTRACION DE LOS SERVICIOS DE SANEAMIENTO	\N	OTASS	27
151	211	ORGANISMO DE FORMALIZACION DE LA PROPIEDAD INFORMAL	\N	COFOPRI	27
152	38	MINISTERIO DE LA PRODUCCION	\N	PRODUCE	28
153	59	FONDO NACIONAL DE DESARROLLO PESQUERO	\N	FONDEPES	28
154	240	INSTITUTO DEL MAR DEL PERU	\N	IMARPE	28
155	241	INSTITUTO TECNOLOGICO DE LA PRODUCCION	\N	ITP	28
156	243	AUTORIDAD NACIONAL DE SANIDAD E INOCUIDAD EN PESCA Y ACUICULTURA	\N	SANIPES	28
157	244	INSTITUTO NACIONAL DE CALIDAD	\N	INACAL	28
158	39	MINISTERIO DE LA MUJER Y POBLACIONES VULNERABLES	\N	MIMP	29
159	345	CONSEJO NACIONAL PARA LA INTEGRACION DE LA PERSONA CON DISCAPACIDAD	\N	CONADIS	29
160	40	MINISTERIO DE DESARROLLO E INCLUSION SOCIAL	\N	MIDIS	30
161	41	ORGANISMO DE FOCALIZACIÓN E INFORMACIÓN SOCIAL	\N	OFIS	30
162	440	GOBIERNO REGIONAL DEL DEPARTAMENTO DE AMAZONAS	\N	GORE AMAZONAS	31
163	441	GOBIERNO REGIONAL DEL DEPARTAMENTO DE ANCASH	\N	GORE ANCASH	31
164	442	GOBIERNO REGIONAL DEL DEPARTAMENTO DE APURIMAC	\N	GORE APURIMAC	31
165	443	GOBIERNO REGIONAL DEL DEPARTAMENTO DE AREQUIPA	\N	GORE AREQUIPA	31
166	444	GOBIERNO REGIONAL DEL DEPARTAMENTO DE AYACUCHO	\N	GORE AYACUCHO	31
167	445	GOBIERNO REGIONAL DEL DEPARTAMENTO DE CAJAMARCA	\N	GORE CAJAMARCA	31
168	446	GOBIERNO REGIONAL DEL DEPARTAMENTO DE CUSCO	\N	GORE CUSCO	31
169	447	GOBIERNO REGIONAL DEL DEPARTAMENTO DE HUANCAVELICA	\N	GORE HUANCAVELICA	31
170	448	GOBIERNO REGIONAL DEL DEPARTAMENTO DE HUANUCO	\N	GORE HUANUCO	31
171	449	GOBIERNO REGIONAL DEL DEPARTAMENTO DE ICA	\N	GORE ICA	31
172	450	GOBIERNO REGIONAL DEL DEPARTAMENTO DE JUNIN	\N	GORE JUNIN	31
173	451	GOBIERNO REGIONAL DEL DEPARTAMENTO DE LA LIBERTAD	\N	GORE LIBERTAD	31
174	452	GOBIERNO REGIONAL DEL DEPARTAMENTO DE LAMBAYEQUE	\N	GORE LAMBAYEQUE	31
175	453	GOBIERNO REGIONAL DEL DEPARTAMENTO DE LORETO	\N	GORE LORETO	31
176	454	GOBIERNO REGIONAL DEL DEPARTAMENTO DE MADRE DE DIOS	\N	GORE DIOS	31
177	455	GOBIERNO REGIONAL DEL DEPARTAMENTO DE MOQUEGUA	\N	GORE MOQUEGUA	31
178	456	GOBIERNO REGIONAL DEL DEPARTAMENTO DE PASCO	\N	GORE PASCO	31
179	457	GOBIERNO REGIONAL DEL DEPARTAMENTO DE PIURA	\N	GORE PIURA	31
180	458	GOBIERNO REGIONAL DEL DEPARTAMENTO DE PUNO	\N	GORE PUNO	31
181	459	GOBIERNO REGIONAL DEL DEPARTAMENTO DE SAN MARTIN	\N	GORE MARTIN	31
182	460	GOBIERNO REGIONAL DEL DEPARTAMENTO DE TACNA	\N	GORE TACNA	31
183	461	GOBIERNO REGIONAL DEL DEPARTAMENTO DE TUMBES	\N	GORE TUMBES	31
184	462	GOBIERNO REGIONAL DEL DEPARTAMENTO DE UCAYALI	\N	GORE UCAYALI	31
185	463	GOBIERNO REGIONAL DEL DEPARTAMENTO DE LIMA	\N	GORE LIMA	31
186	464	GOBIERNO REGIONAL DE LA PROVINCIA CONSTITUCIONAL DEL CALLAO	\N	GORE CALLAO	31
187	465	MUNICIPALIDAD METROPOLITANA DE LIMA	\N	MML	31
188	999	CUERPO GENERAL DE BOMBEROS VOLUNTARIOS DEL PERÚ	\N	BOMBEROS PERU	33
189	010101-300001	MUNICIPALIDAD PROVINCIAL DE CHACHAPOYAS	\N	\N	32
190	010102-300002	MUNICIPALIDAD DISTRITAL DE ASUNCION	\N	\N	32
191	010103-300003	MUNICIPALIDAD DISTRITAL DE BALSAS	\N	\N	32
192	010104-300004	MUNICIPALIDAD DISTRITAL DE CHETO	\N	\N	32
193	010105-300005	MUNICIPALIDAD DISTRITAL DE CHILIQUIN	\N	\N	32
194	010106-300006	MUNICIPALIDAD DISTRITAL DE CHUQUIBAMBA	\N	\N	32
195	010107-300007	MUNICIPALIDAD DISTRITAL DE GRANADA	\N	\N	32
196	010108-300008	MUNICIPALIDAD DISTRITAL DE HUANCAS	\N	\N	32
197	010109-300009	MUNICIPALIDAD DISTRITAL DE LA JALCA	\N	\N	32
198	010110-300010	MUNICIPALIDAD DISTRITAL DE LEIMEBAMBA	\N	\N	32
199	010111-300011	MUNICIPALIDAD DISTRITAL DE LEVANTO	\N	\N	32
200	010112-300012	MUNICIPALIDAD DISTRITAL DE MAGDALENA	\N	\N	32
201	010113-300013	MUNICIPALIDAD DISTRITAL DE MARISCAL CASTILLA	\N	\N	32
202	010114-300014	MUNICIPALIDAD DISTRITAL DE MOLINOPAMPA	\N	\N	32
203	010115-300015	MUNICIPALIDAD DISTRITAL DE MONTEVIDEO	\N	\N	32
204	010116-300016	MUNICIPALIDAD DISTRITAL DE OLLEROS	\N	\N	32
205	010117-300017	MUNICIPALIDAD DISTRITAL DE QUINJALCA	\N	\N	32
206	010118-300018	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DE DAGUAS	\N	\N	32
207	010119-300019	MUNICIPALIDAD DISTRITAL DE SAN ISIDRO DE MAINO	\N	\N	32
208	010120-300020	MUNICIPALIDAD DISTRITAL DE SOLOCO	\N	\N	32
209	010121-300021	MUNICIPALIDAD DISTRITAL DE SONCHE	\N	\N	32
210	010201-300022	MUNICIPALIDAD PROVINCIAL DE BAGUA	\N	\N	32
211	010202-300023	MUNICIPALIDAD DISTRITAL DE ARAMANGO	\N	\N	32
212	010203-300024	MUNICIPALIDAD DISTRITAL DE COPALLIN	\N	\N	32
213	010204-300025	MUNICIPALIDAD DISTRITAL DE EL PARCO	\N	\N	32
214	010205-300026	MUNICIPALIDAD DISTRITAL DE IMAZA	\N	\N	32
215	010206-300027	MUNICIPALIDAD DISTRITAL DE LA PECA	\N	\N	32
216	010301-300028	MUNICIPALIDAD PROVINCIAL DE BONGARA - JUMBILLA	\N	\N	32
217	010302-300029	MUNICIPALIDAD DISTRITAL DE CHISQUILLA	\N	\N	32
218	010303-300030	MUNICIPALIDAD DISTRITAL DE CHURUJA	\N	\N	32
219	010304-300031	MUNICIPALIDAD DISTRITAL DE COROSHA	\N	\N	32
220	010305-300032	MUNICIPALIDAD DISTRITAL DE CUISPES	\N	\N	32
221	010306-300033	MUNICIPALIDAD DISTRITAL DE FLORIDA	\N	\N	32
222	010307-300034	MUNICIPALIDAD DISTRITAL DE JAZAN	\N	\N	32
223	010308-300035	MUNICIPALIDAD DISTRITAL DE RECTA	\N	\N	32
224	010309-300036	MUNICIPALIDAD DISTRITAL DE SAN CARLOS	\N	\N	32
225	010310-300037	MUNICIPALIDAD DISTRITAL DE SHIPASBAMBA	\N	\N	32
226	010311-300038	MUNICIPALIDAD DISTRITAL DE VALERA	\N	\N	32
227	010312-300039	MUNICIPALIDAD DISTRITAL DE YAMBRASBAMBA	\N	\N	32
228	010401-300040	MUNICIPALIDAD PROVINCIAL DE CONDORCANQUI - NIEVA	\N	\N	32
229	010402-300041	MUNICIPALIDAD DISTRITAL DE EL CENEPA	\N	\N	32
230	010403-300042	MUNICIPALIDAD DISTRITAL DE RIO SANTIAGO	\N	\N	32
231	010501-300043	MUNICIPALIDAD PROVINCIAL DE LUYA - LAMUD	\N	\N	32
232	010502-300044	MUNICIPALIDAD DISTRITAL DE CAMPORREDONDO	\N	\N	32
233	010503-300045	MUNICIPALIDAD DISTRITAL DE COCABAMBA	\N	\N	32
234	010504-300046	MUNICIPALIDAD DISTRITAL DE COLCAMAR	\N	\N	32
235	010505-300047	MUNICIPALIDAD DISTRITAL DE CONILA	\N	\N	32
236	010506-300048	MUNICIPALIDAD DISTRITAL DE INGUILPATA	\N	\N	32
237	010507-300049	MUNICIPALIDAD DISTRITAL DE LONGUITA	\N	\N	32
238	010508-300050	MUNICIPALIDAD DISTRITAL DE LONYA CHICO	\N	\N	32
239	010509-300051	MUNICIPALIDAD DISTRITAL DE LUYA	\N	\N	32
240	010510-300052	MUNICIPALIDAD DISTRITAL DE LUYA VIEJO	\N	\N	32
241	010511-300053	MUNICIPALIDAD DISTRITAL DE MARIA	\N	\N	32
242	010512-300054	MUNICIPALIDAD DISTRITAL DE OCALLI	\N	\N	32
243	010513-300055	MUNICIPALIDAD DISTRITAL DE OCUMAL	\N	\N	32
244	010514-300056	MUNICIPALIDAD DISTRITAL DE PISUQUIA	\N	\N	32
245	010515-300057	MUNICIPALIDAD DISTRITAL DE PROVIDENCIA	\N	\N	32
246	010516-300058	MUNICIPALIDAD DISTRITAL DE SAN CRISTOBAL	\N	\N	32
247	010517-300059	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DEL YESO	\N	\N	32
248	010518-300060	MUNICIPALIDAD DISTRITAL DE SAN JERONIMO DE PACLAS	\N	\N	32
249	010519-300061	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE LOPECANCHA	\N	\N	32
250	010520-300062	MUNICIPALIDAD DISTRITAL DE SANTA CATALINA	\N	\N	32
251	010521-300063	MUNICIPALIDAD DISTRITAL DE SANTO TOMAS	\N	\N	32
252	010522-300064	MUNICIPALIDAD DISTRITAL DE TINGO	\N	\N	32
253	010523-300065	MUNICIPALIDAD DISTRITAL DE TRITA	\N	\N	32
254	010601-300066	MUNICIPALIDAD PROVINCIAL DE RODRIGUEZ DE MENDOZA - SAN NICOLAS	\N	\N	32
255	010602-300067	MUNICIPALIDAD DISTRITAL DE CHIRIMOTO	\N	\N	32
256	010603-300068	MUNICIPALIDAD DISTRITAL DE COCHAMAL	\N	\N	32
257	010604-300069	MUNICIPALIDAD DISTRITAL DE HUAMBO	\N	\N	32
258	010605-300070	MUNICIPALIDAD DISTRITAL DE LIMABAMBA	\N	\N	32
259	010606-300071	MUNICIPALIDAD DISTRITAL DE LONGAR	\N	\N	32
260	010607-300072	MUNICIPALIDAD DISTRITAL DE MARISCAL BENAVIDES	\N	\N	32
261	010608-300073	MUNICIPALIDAD DISTRITAL DE MILPUC	\N	\N	32
262	010609-300074	MUNICIPALIDAD DISTRITAL DE OMIA	\N	\N	32
263	010610-300075	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
264	010611-300076	MUNICIPALIDAD DISTRITAL DE TOTORA	\N	\N	32
265	010612-300077	MUNICIPALIDAD DISTRITAL DE VISTA ALEGRE	\N	\N	32
266	010701-300078	MUNICIPALIDAD PROVINCIAL DE UTCUBAMBA - BAGUA GRANDE	\N	\N	32
267	010702-300079	MUNICIPALIDAD DISTRITAL DE CAJARURO	\N	\N	32
268	010703-300080	MUNICIPALIDAD DISTRITAL DE CUMBA	\N	\N	32
269	010704-300081	MUNICIPALIDAD DISTRITAL DE EL MILAGRO	\N	\N	32
270	010705-300082	MUNICIPALIDAD DISTRITAL DE JAMALCA	\N	\N	32
271	010706-300083	MUNICIPALIDAD DISTRITAL DE LONYA GRANDE	\N	\N	32
272	010707-300084	MUNICIPALIDAD DISTRITAL DE YAMON	\N	\N	32
273	020101-300085	MUNICIPALIDAD PROVINCIAL DE HUARAZ	\N	\N	32
274	020102-300086	MUNICIPALIDAD DISTRITAL DE COCHABAMBA	\N	\N	32
275	020103-300087	MUNICIPALIDAD DISTRITAL DE COLCABAMBA	\N	\N	32
276	020104-300088	MUNICIPALIDAD DISTRITAL DE HUANCHAY	\N	\N	32
277	020105-300089	MUNICIPALIDAD DISTRITAL DE INDEPENDENCIA	\N	\N	32
278	020106-300090	MUNICIPALIDAD DISTRITAL DE JANGAS	\N	\N	32
279	020107-300091	MUNICIPALIDAD DISTRITAL DE LA LIBERTAD	\N	\N	32
280	020108-300092	MUNICIPALIDAD DISTRITAL DE OLLEROS	\N	\N	32
281	020109-300093	MUNICIPALIDAD DISTRITAL DE PAMPAS	\N	\N	32
282	020110-300094	MUNICIPALIDAD DISTRITAL DE PARIACOTO	\N	\N	32
283	020111-300095	MUNICIPALIDAD DISTRITAL DE PIRA	\N	\N	32
284	020112-300096	MUNICIPALIDAD DISTRITAL DE TARICA	\N	\N	32
285	020201-300097	MUNICIPALIDAD PROVINCIAL DE AIJA	\N	\N	32
286	020202-300098	MUNICIPALIDAD DISTRITAL DE CORIS	\N	\N	32
287	020203-300099	MUNICIPALIDAD DISTRITAL DE HUACLLAN	\N	\N	32
288	020204-300100	MUNICIPALIDAD DISTRITAL DE LA MERCED	\N	\N	32
289	020205-300101	MUNICIPALIDAD DISTRITAL DE SUCCHA	\N	\N	32
290	020301-300102	MUNICIPALIDAD PROVINCIAL DE ANTONIO RAYMONDI - LLAMELLIN	\N	\N	32
291	020302-300103	MUNICIPALIDAD DISTRITAL DE ACZO	\N	\N	32
292	020303-300104	MUNICIPALIDAD DISTRITAL DE CHACCHO	\N	\N	32
293	020304-300105	MUNICIPALIDAD DISTRITAL DE CHINGAS	\N	\N	32
294	020305-300106	MUNICIPALIDAD DISTRITAL DE MIRGAS	\N	\N	32
295	020306-300107	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE RONTOY	\N	\N	32
296	020401-300108	MUNICIPALIDAD PROVINCIAL DE ASUNCION - CHACAS	\N	\N	32
297	020402-300109	MUNICIPALIDAD DISTRITAL DE ACOCHACA	\N	\N	32
298	020501-300110	MUNICIPALIDAD PROVINCIAL DE BOLOGNESI - CHIQUIAN	\N	\N	32
299	020502-300111	MUNICIPALIDAD DISTRITAL DE ABELARDO PARDO LEZAMETA	\N	\N	32
300	020503-300112	MUNICIPALIDAD DISTRITAL DE ANTONIO RAYMONDI	\N	\N	32
301	020504-300113	MUNICIPALIDAD DISTRITAL DE AQUIA	\N	\N	32
302	020505-300114	MUNICIPALIDAD DISTRITAL DE CAJACAY	\N	\N	32
303	020506-300115	MUNICIPALIDAD DISTRITAL DE CANIS	\N	\N	32
304	020507-300116	MUNICIPALIDAD DISTRITAL DE COLQUIOC	\N	\N	32
305	020508-300117	MUNICIPALIDAD DISTRITAL DE HUALLANCA	\N	\N	32
306	020509-300118	MUNICIPALIDAD DISTRITAL DE HUASTA	\N	\N	32
307	020510-300119	MUNICIPALIDAD DISTRITAL DE HUAYLLACAYAN	\N	\N	32
308	020511-300120	MUNICIPALIDAD DISTRITAL DE LA PRIMAVERA	\N	\N	32
309	020512-300121	MUNICIPALIDAD DISTRITAL DE MANGAS	\N	\N	32
310	020513-300122	MUNICIPALIDAD DISTRITAL DE PACLLON	\N	\N	32
311	020514-300123	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL DE CORPANQUI	\N	\N	32
312	020515-300124	MUNICIPALIDAD DISTRITAL DE TICLLOS	\N	\N	32
313	020601-300125	MUNICIPALIDAD PROVINCIAL DE CARHUAZ	\N	\N	32
314	020602-300126	MUNICIPALIDAD DISTRITAL DE ACOPAMPA	\N	\N	32
315	020603-300127	MUNICIPALIDAD DISTRITAL DE AMASHCA	\N	\N	32
316	020604-300128	MUNICIPALIDAD DISTRITAL DE ANTA	\N	\N	32
317	020605-300129	MUNICIPALIDAD DISTRITAL DE ATAQUERO	\N	\N	32
318	020606-300130	MUNICIPALIDAD DISTRITAL DE MARCARA	\N	\N	32
319	020607-300131	MUNICIPALIDAD DISTRITAL DE PARIAHUANCA	\N	\N	32
320	020608-300132	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL DE ACO	\N	\N	32
321	020609-300133	MUNICIPALIDAD DISTRITAL DE SHILLA	\N	\N	32
322	020610-300134	MUNICIPALIDAD DISTRITAL DE TINCO	\N	\N	32
323	020611-300135	MUNICIPALIDAD DISTRITAL DE YUNGAR	\N	\N	32
324	020701-300136	MUNICIPALIDAD PROVINCIAL DE CARLOS FERMIN FITZCARRALD	\N	\N	32
325	020702-300137	MUNICIPALIDAD DISTRITAL DE SAN NICOLAS	\N	\N	32
326	020703-300138	MUNICIPALIDAD DISTRITAL DE YAUYA	\N	\N	32
327	020801-300139	MUNICIPALIDAD PROVINCIAL DE CASMA	\N	\N	32
328	020802-300140	MUNICIPALIDAD DISTRITAL DE BUENA VISTA ALTA	\N	\N	32
329	020803-300141	MUNICIPALIDAD DISTRITAL DE COMANDANTE NOEL	\N	\N	32
330	020804-300142	MUNICIPALIDAD DISTRITAL DE YAUTAN	\N	\N	32
331	020901-300143	MUNICIPALIDAD PROVINCIAL DE CORONGO	\N	\N	32
332	020902-300144	MUNICIPALIDAD DISTRITAL DE ACO	\N	\N	32
333	020903-300145	MUNICIPALIDAD DISTRITAL DE BAMBAS	\N	\N	32
334	020904-300146	MUNICIPALIDAD DISTRITAL DE CUSCA	\N	\N	32
335	020905-300147	MUNICIPALIDAD DISTRITAL DE LA PAMPA	\N	\N	32
336	020906-300148	MUNICIPALIDAD DISTRITAL DE YANAC	\N	\N	32
337	020907-300149	MUNICIPALIDAD DISTRITAL DE YUPAN	\N	\N	32
338	021001-300150	MUNICIPALIDAD PROVINCIAL DE HUARI	\N	\N	32
339	021002-300151	MUNICIPALIDAD DISTRITAL DE ANRA	\N	\N	32
340	021003-300152	MUNICIPALIDAD DISTRITAL DE CAJAY	\N	\N	32
341	021004-300153	MUNICIPALIDAD DISTRITAL DE CHAVIN DE HUANTAR	\N	\N	32
342	021005-300154	MUNICIPALIDAD DISTRITAL DE HUACACHI	\N	\N	32
343	021006-300155	MUNICIPALIDAD DISTRITAL DE HUACCHIS	\N	\N	32
344	021007-300156	MUNICIPALIDAD DISTRITAL DE HUACHIS	\N	\N	32
345	021008-300157	MUNICIPALIDAD DISTRITAL DE HUANTAR	\N	\N	32
346	021009-300158	MUNICIPALIDAD DISTRITAL DE MASIN	\N	\N	32
347	021010-300159	MUNICIPALIDAD DISTRITAL DE PAUCAS	\N	\N	32
348	021011-300160	MUNICIPALIDAD DISTRITAL DE PONTO	\N	\N	32
349	021012-300161	MUNICIPALIDAD DISTRITAL DE RAHUAPAMPA	\N	\N	32
350	021013-300162	MUNICIPALIDAD DISTRITAL DE RAPAYAN	\N	\N	32
351	021014-300163	MUNICIPALIDAD DISTRITAL DE SAN MARCOS	\N	\N	32
352	021015-300164	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE CHANA	\N	\N	32
353	021016-300165	MUNICIPALIDAD DISTRITAL DE UCO	\N	\N	32
354	021101-300166	MUNICIPALIDAD PROVINCIAL DE HUARMEY	\N	\N	32
355	021102-300167	MUNICIPALIDAD DISTRITAL DE COCHAPETI	\N	\N	32
356	021103-300168	MUNICIPALIDAD DISTRITAL DE CULEBRAS	\N	\N	32
357	021104-300169	MUNICIPALIDAD DISTRITAL DE HUAYAN	\N	\N	32
358	021105-300170	MUNICIPALIDAD DISTRITAL DE MALVAS	\N	\N	32
359	021201-300171	MUNICIPALIDAD PROVINCIAL DE HUAYLAS - CARAZ	\N	\N	32
360	021202-300172	MUNICIPALIDAD DISTRITAL DE HUALLANCA	\N	\N	32
361	021203-300173	MUNICIPALIDAD DISTRITAL DE HUATA	\N	\N	32
362	021204-300174	MUNICIPALIDAD DISTRITAL DE HUAYLAS	\N	\N	32
363	021205-300175	MUNICIPALIDAD DISTRITAL DE MATO	\N	\N	32
364	021206-300176	MUNICIPALIDAD DISTRITAL DE PAMPAROMAS	\N	\N	32
365	021207-300177	MUNICIPALIDAD DISTRITAL DE PUEBLO LIBRE	\N	\N	32
366	021208-300178	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ	\N	\N	32
367	021209-300179	MUNICIPALIDAD DISTRITAL DE SANTO TORIBIO	\N	\N	32
368	021210-300180	MUNICIPALIDAD DISTRITAL DE YURACMARCA	\N	\N	32
369	021301-300181	MUNICIPALIDAD PROVINCIAL DE MARISCAL LUZURIAGA - PISCOBAMBA	\N	\N	32
370	021302-300182	MUNICIPALIDAD DISTRITAL DE CASCA	\N	\N	32
371	021303-300183	MUNICIPALIDAD DISTRITAL DE ELEAZAR GUZMAN BARRON	\N	\N	32
372	021304-300184	MUNICIPALIDAD DISTRITAL DE FIDEL OLIVAS ESCUDERO	\N	\N	32
373	021305-300185	MUNICIPALIDAD DISTRITAL DE LLAMA	\N	\N	32
374	021306-300186	MUNICIPALIDAD DISTRITAL DE LLUMPA	\N	\N	32
375	021307-300187	MUNICIPALIDAD DISTRITAL DE LUCMA	\N	\N	32
376	021308-300188	MUNICIPALIDAD DISTRITAL DE MUSGA	\N	\N	32
377	021401-300189	MUNICIPALIDAD PROVINCIAL DE OCROS	\N	\N	32
378	021402-300190	MUNICIPALIDAD DISTRITAL DE ACAS	\N	\N	32
379	021403-300191	MUNICIPALIDAD DISTRITAL DE CAJAMARQUILLA	\N	\N	32
380	021404-300192	MUNICIPALIDAD DISTRITAL DE CARHUAPAMPA	\N	\N	32
381	021405-300193	MUNICIPALIDAD DISTRITAL DE COCHAS	\N	\N	32
382	021406-300194	MUNICIPALIDAD DISTRITAL DE CONGAS	\N	\N	32
383	021407-300195	MUNICIPALIDAD DISTRITAL DE LLIPA	\N	\N	32
384	021408-300196	MUNICIPALIDAD DISTRITAL DE SAN CRISTOBAL DE RAJAN	\N	\N	32
385	021409-300197	MUNICIPALIDAD DISTRITAL DE SAN PEDRO	\N	\N	32
386	021410-300198	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE CHILCAS	\N	\N	32
387	021501-300199	MUNICIPALIDAD PROVINCIAL DE PALLASCA - CABANA	\N	\N	32
388	021502-300200	MUNICIPALIDAD DISTRITAL DE BOLOGNESI	\N	\N	32
389	021503-300201	MUNICIPALIDAD DISTRITAL DE CONCHUCOS	\N	\N	32
390	021504-300202	MUNICIPALIDAD DISTRITAL DE HUACASCHUQUE	\N	\N	32
391	021505-300203	MUNICIPALIDAD DISTRITAL DE HUANDOVAL	\N	\N	32
392	021506-300204	MUNICIPALIDAD DISTRITAL DE LACABAMBA	\N	\N	32
393	021507-300205	MUNICIPALIDAD DISTRITAL DE LLAPO	\N	\N	32
394	021508-300206	MUNICIPALIDAD DISTRITAL DE PALLASCA	\N	\N	32
395	021509-300207	MUNICIPALIDAD DISTRITAL DE PAMPAS	\N	\N	32
396	021510-300208	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
397	021511-300209	MUNICIPALIDAD DISTRITAL DE TAUCA	\N	\N	32
398	021601-300210	MUNICIPALIDAD PROVINCIAL DE POMABAMBA	\N	\N	32
399	021602-300211	MUNICIPALIDAD DISTRITAL DE HUAYLLAN	\N	\N	32
400	021603-300212	MUNICIPALIDAD DISTRITAL DE PAROBAMBA	\N	\N	32
401	021604-300213	MUNICIPALIDAD DISTRITAL DE QUINUABAMBA	\N	\N	32
402	021701-300214	MUNICIPALIDAD PROVINCIAL DE RECUAY	\N	\N	32
403	021702-300215	MUNICIPALIDAD DISTRITAL DE CATAC	\N	\N	32
404	021703-300216	MUNICIPALIDAD DISTRITAL DE COTAPARACO	\N	\N	32
405	021704-300217	MUNICIPALIDAD DISTRITAL DE HUAYLLAPAMPA	\N	\N	32
406	021705-300218	MUNICIPALIDAD DISTRITAL DE LLACLLIN	\N	\N	32
407	021706-300219	MUNICIPALIDAD DISTRITAL DE MARCA	\N	\N	32
408	021707-300220	MUNICIPALIDAD DISTRITAL DE PAMPAS CHICO	\N	\N	32
409	021708-300221	MUNICIPALIDAD DISTRITAL DE PARARIN	\N	\N	32
410	021709-300222	MUNICIPALIDAD DISTRITAL DE TAPACOCHA	\N	\N	32
411	021710-300223	MUNICIPALIDAD DISTRITAL DE TICAPAMPA	\N	\N	32
412	021801-300224	MUNICIPALIDAD PROVINCIAL DEL SANTA - CHIMBOTE	\N	\N	32
413	021802-300225	MUNICIPALIDAD DISTRITAL DE CACERES DEL PERU	\N	\N	32
414	021803-300226	MUNICIPALIDAD DISTRITAL DE COISHCO	\N	\N	32
415	021804-300227	MUNICIPALIDAD DISTRITAL DE MACATE	\N	\N	32
416	021805-300228	MUNICIPALIDAD DISTRITAL DE MORO	\N	\N	32
417	021806-300229	MUNICIPALIDAD DISTRITAL DE NEPEÑA	\N	\N	32
418	021807-300230	MUNICIPALIDAD DISTRITAL DE SAMANCO	\N	\N	32
419	021808-300231	MUNICIPALIDAD DISTRITAL DE SANTA	\N	\N	32
420	021809-300232	MUNICIPALIDAD DISTRITAL DE NUEVO CHIMBOTE	\N	\N	32
421	021901-300233	MUNICIPALIDAD PROVINCIAL DE SIHUAS	\N	\N	32
422	021902-300234	MUNICIPALIDAD DISTRITAL DE ACOBAMBA	\N	\N	32
423	021903-300235	MUNICIPALIDAD DISTRITAL DE ALFONSO UGARTE	\N	\N	32
424	021904-300236	MUNICIPALIDAD DISTRITAL DE CASHAPAMPA	\N	\N	32
425	021905-300237	MUNICIPALIDAD DISTRITAL DE CHINGALPO	\N	\N	32
426	021906-300238	MUNICIPALIDAD DISTRITAL DE HUAYLLABAMBA	\N	\N	32
427	021907-300239	MUNICIPALIDAD DISTRITAL DE QUICHES	\N	\N	32
428	021908-300240	MUNICIPALIDAD DISTRITAL DE RAGASH	\N	\N	32
429	021909-300241	MUNICIPALIDAD DISTRITAL DE SAN JUAN	\N	\N	32
430	021910-300242	MUNICIPALIDAD DISTRITAL DE SICSIBAMBA	\N	\N	32
431	022001-300243	MUNICIPALIDAD PROVINCIAL DE YUNGAY	\N	\N	32
432	022002-300244	MUNICIPALIDAD DISTRITAL DE CASCAPARA	\N	\N	32
433	022003-300245	MUNICIPALIDAD DISTRITAL DE MANCOS	\N	\N	32
434	022004-300246	MUNICIPALIDAD DISTRITAL DE MATACOTO	\N	\N	32
435	022005-300247	MUNICIPALIDAD DISTRITAL DE QUILLO	\N	\N	32
436	022006-300248	MUNICIPALIDAD DISTRITAL DE RANRAHIRCA	\N	\N	32
437	022007-300249	MUNICIPALIDAD DISTRITAL DE SHUPLUY	\N	\N	32
438	022008-300250	MUNICIPALIDAD DISTRITAL DE YANAMA	\N	\N	32
439	030101-300251	MUNICIPALIDAD PROVINCIAL DE ABANCAY	\N	\N	32
440	030102-300252	MUNICIPALIDAD DISTRITAL DE CHACOCHE	\N	\N	32
441	030103-300253	MUNICIPALIDAD DISTRITAL DE CIRCA	\N	\N	32
442	030104-300254	MUNICIPALIDAD DISTRITAL DE CURAHUASI	\N	\N	32
443	030105-300255	MUNICIPALIDAD DISTRITAL DE HUANIPACA	\N	\N	32
444	030106-300256	MUNICIPALIDAD DISTRITAL DE LAMBRAMA	\N	\N	32
445	030107-300257	MUNICIPALIDAD DISTRITAL DE PICHIRHUA	\N	\N	32
446	030108-300258	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE CACHORA	\N	\N	32
447	030109-300259	MUNICIPALIDAD DISTRITAL DE TAMBURCO	\N	\N	32
448	030201-300260	MUNICIPALIDAD PROVINCIAL DE ANDAHUAYLAS	\N	\N	32
449	030202-300261	MUNICIPALIDAD DISTRITAL DE ANDARAPA	\N	\N	32
450	030203-300262	MUNICIPALIDAD DISTRITAL DE CHIARA	\N	\N	32
451	030204-300263	MUNICIPALIDAD DISTRITAL DE HUANCARAMA	\N	\N	32
452	030205-300264	MUNICIPALIDAD DISTRITAL DE HUANCARAY	\N	\N	32
453	030206-300265	MUNICIPALIDAD DISTRITAL DE HUAYANA	\N	\N	32
454	030207-300266	MUNICIPALIDAD DISTRITAL DE KISHUARA	\N	\N	32
455	030208-300267	MUNICIPALIDAD DISTRITAL DE PACOBAMBA	\N	\N	32
456	030209-300268	MUNICIPALIDAD DISTRITAL DE PACUCHA	\N	\N	32
457	030210-300269	MUNICIPALIDAD DISTRITAL DE PAMPACHIRI	\N	\N	32
458	030211-300270	MUNICIPALIDAD DISTRITAL DE POMACOCHA	\N	\N	32
459	030212-300271	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO DE CACHI	\N	\N	32
460	030213-300272	MUNICIPALIDAD DISTRITAL DE SAN JERONIMO	\N	\N	32
461	030214-300273	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL CHACCRAMPA	\N	\N	32
462	030215-300274	MUNICIPALIDAD DISTRITAL DE SANTA MARIA DE CHICMO	\N	\N	32
463	030216-300275	MUNICIPALIDAD DISTRITAL DE TALAVERA	\N	\N	32
464	030217-300276	MUNICIPALIDAD DISTRITAL DE TUMAY HUARACA	\N	\N	32
465	030218-300277	MUNICIPALIDAD DISTRITAL DE TURPO	\N	\N	32
466	030219-300278	MUNICIPALIDAD DISTRITAL DE KAQUIABAMBA	\N	\N	32
467	030220-301863	MUNICIPALIDAD DISTRITAL DE JOSE MARÍA ARGUEDAS	\N	\N	32
468	030301-300279	MUNICIPALIDAD PROVINCIAL DE ANTABAMBA	\N	\N	32
469	030302-300280	MUNICIPALIDAD DISTRITAL DE EL ORO	\N	\N	32
470	030303-300281	MUNICIPALIDAD DISTRITAL DE HUAQUIRCA	\N	\N	32
471	030304-300282	MUNICIPALIDAD DISTRITAL DE JUAN ESPINOZA MEDRANO	\N	\N	32
472	030305-300283	MUNICIPALIDAD DISTRITAL DE OROPESA	\N	\N	32
473	030306-300284	MUNICIPALIDAD DISTRITAL DE PACHACONAS	\N	\N	32
474	030307-300285	MUNICIPALIDAD DISTRITAL DE SABAINO	\N	\N	32
475	030401-300286	MUNICIPALIDAD PROVINCIAL DE AYMARAES - CHALHUANCA	\N	\N	32
476	030402-300287	MUNICIPALIDAD DISTRITAL DE CAPAYA	\N	\N	32
477	030403-300288	MUNICIPALIDAD DISTRITAL DE CARAYBAMBA	\N	\N	32
478	030404-300289	MUNICIPALIDAD DISTRITAL DE CHAPIMARCA	\N	\N	32
479	030405-300290	MUNICIPALIDAD DISTRITAL DE COLCABAMBA	\N	\N	32
480	030406-300291	MUNICIPALIDAD DISTRITAL DE COTARUSE	\N	\N	32
481	030407-300292	MUNICIPALIDAD DISTRITAL DE IHUAYLLO	\N	\N	32
482	030408-300293	MUNICIPALIDAD DISTRITAL DE JUSTO APU SAHUARAURA	\N	\N	32
483	030409-300294	MUNICIPALIDAD DISTRITAL DE LUCRE	\N	\N	32
484	030410-300295	MUNICIPALIDAD DISTRITAL DE POCOHUANCA	\N	\N	32
485	030411-300296	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE CHACÑA	\N	\N	32
486	030412-300297	MUNICIPALIDAD DISTRITAL DE SAÑAYCA	\N	\N	32
487	030413-300298	MUNICIPALIDAD DISTRITAL DE SORAYA	\N	\N	32
488	030414-300299	MUNICIPALIDAD DISTRITAL DE TAPAIRIHUA	\N	\N	32
489	030415-300300	MUNICIPALIDAD DISTRITAL DE TINTAY	\N	\N	32
490	030416-300301	MUNICIPALIDAD DISTRITAL DE TORAYA	\N	\N	32
491	030417-300302	MUNICIPALIDAD DISTRITAL DE YANACA	\N	\N	32
492	030501-300303	MUNICIPALIDAD PROVINCIAL DE COTABAMBAS - TAMBOBAMBA	\N	\N	32
493	030502-300304	MUNICIPALIDAD DISTRITAL DE COTABAMBAS	\N	\N	32
494	030503-300305	MUNICIPALIDAD DISTRITAL DE COYLLURQUI	\N	\N	32
495	030504-300306	MUNICIPALIDAD DISTRITAL DE HAQUIRA	\N	\N	32
496	030505-300307	MUNICIPALIDAD DISTRITAL DE MARA	\N	\N	32
497	030506-300308	MUNICIPALIDAD DISTRITAL DE CHALLHUAHUACHO	\N	\N	32
498	030601-300309	MUNICIPALIDAD PROVINCIAL DE CHINCHEROS	\N	\N	32
499	030602-300310	MUNICIPALIDAD DISTRITAL DE ANCO HUALLO	\N	\N	32
500	030603-300311	MUNICIPALIDAD DISTRITAL DE COCHARCAS	\N	\N	32
501	030604-300312	MUNICIPALIDAD DISTRITAL DE HUACCANA	\N	\N	32
502	030605-300313	MUNICIPALIDAD DISTRITAL DE OCOBAMBA	\N	\N	32
503	030606-300314	MUNICIPALIDAD DISTRITAL DE ONGOY	\N	\N	32
504	030607-300315	MUNICIPALIDAD DISTRITAL DE URANMARCA	\N	\N	32
505	030608-300316	MUNICIPALIDAD DISTRITAL DE RANRACANCHA	\N	\N	32
506	030609-301877	MUNICIPALIDAD DISTRITAL DE ROCCHACC	\N	\N	32
507	030610-301878	MUNICIPALIDAD DISTRITAL DE EL PORVENIR	\N	\N	32
508	030611-301880	MUNICIPALIDAD DISTRITAL DE LOS CHANKAS	\N	\N	32
509	030612-301900	MUNICIPALIDAD DISTRITAL DE AHUAYRO	\N	\N	32
510	030701-300317	MUNICIPALIDAD PROVINCIAL DE GRAU - CHUQUIBAMBILLA	\N	\N	32
511	030702-300318	MUNICIPALIDAD DISTRITAL DE CURPAHUASI	\N	\N	32
512	030703-300319	MUNICIPALIDAD DISTRITAL DE GAMARRA	\N	\N	32
513	030704-300320	MUNICIPALIDAD DISTRITAL DE HUAYLLATI	\N	\N	32
514	030705-300321	MUNICIPALIDAD DISTRITAL DE MAMARA	\N	\N	32
515	030706-300322	MUNICIPALIDAD DISTRITAL DE MICAELA BASTIDAS	\N	\N	32
516	030707-300323	MUNICIPALIDAD DISTRITAL DE PATAYPAMPA	\N	\N	32
517	030708-300324	MUNICIPALIDAD DISTRITAL DE PROGRESO	\N	\N	32
518	030709-300325	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO	\N	\N	32
519	030710-300326	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
520	030711-300327	MUNICIPALIDAD DISTRITAL DE TURPAY	\N	\N	32
521	030712-300328	MUNICIPALIDAD DISTRITAL DE VILCABAMBA	\N	\N	32
522	030713-300329	MUNICIPALIDAD DISTRITAL DE VIRUNDO	\N	\N	32
523	030714-300330	MUNICIPALIDAD DISTRITAL DE CURASCO	\N	\N	32
524	040101-300331	MUNICIPALIDAD PROVINCIAL DE AREQUIPA	\N	\N	32
525	040102-300332	MUNICIPALIDAD DISTRITAL DE ALTO SELVA ALEGRE	\N	\N	32
526	040103-300333	MUNICIPALIDAD DISTRITAL DE CAYMA	\N	\N	32
527	040104-300334	MUNICIPALIDAD DISTRITAL DE CERRO COLORADO	\N	\N	32
528	040105-300335	MUNICIPALIDAD DISTRITAL DE CHARACATO	\N	\N	32
529	040106-300336	MUNICIPALIDAD DISTRITAL DE CHIGUATA	\N	\N	32
530	040107-300337	MUNICIPALIDAD DISTRITAL DE JACOBO HUNTER	\N	\N	32
531	040108-300338	MUNICIPALIDAD DISTRITAL DE LA JOYA	\N	\N	32
532	040109-300339	MUNICIPALIDAD DISTRITAL DE MARIANO MELGAR	\N	\N	32
533	040110-300340	MUNICIPALIDAD DISTRITAL DE MIRAFLORES	\N	\N	32
534	040111-300341	MUNICIPALIDAD DISTRITAL DE MOLLEBAYA	\N	\N	32
535	040112-300342	MUNICIPALIDAD DISTRITAL DE PAUCARPATA	\N	\N	32
536	040113-300343	MUNICIPALIDAD DISTRITAL DE POCSI	\N	\N	32
537	040114-300344	MUNICIPALIDAD DISTRITAL DE POLOBAYA	\N	\N	32
538	040115-300345	MUNICIPALIDAD DISTRITAL DE QUEQUE¥A	\N	\N	32
539	040116-300346	MUNICIPALIDAD DISTRITAL DE SABANDIA	\N	\N	32
540	040117-300347	MUNICIPALIDAD DISTRITAL DE SACHACA	\N	\N	32
541	040118-300348	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE SIGUAS	\N	\N	32
542	040119-300349	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE TARUCANI	\N	\N	32
543	040120-300350	MUNICIPALIDAD DISTRITAL DE SANTA ISABEL DE SIGUAS	\N	\N	32
544	040121-300351	MUNICIPALIDAD DISTRITAL DE SANTA RITA DE SIGUAS	\N	\N	32
545	040122-300352	MUNICIPALIDAD DISTRITAL DE SOCABAYA	\N	\N	32
546	040123-300353	MUNICIPALIDAD DISTRITAL DE TIABAYA	\N	\N	32
547	040124-300354	MUNICIPALIDAD DISTRITAL DE UCHUMAYO	\N	\N	32
548	040125-300355	MUNICIPALIDAD DISTRITAL DE VITOR	\N	\N	32
549	040126-300356	MUNICIPALIDAD DISTRITAL DE YANAHUARA	\N	\N	32
550	040127-300357	MUNICIPALIDAD DISTRITAL DE YARABAMBA	\N	\N	32
551	040128-300358	MUNICIPALIDAD DISTRITAL DE YURA	\N	\N	32
552	040129-300359	MUNICIPALIDAD DISTRITAL DE JOSE LUIS BUSTAMANTE Y RIVERO	\N	\N	32
553	040201-300360	MUNICIPALIDAD PROVINCIAL DE CAMANA	\N	\N	32
554	040202-300361	MUNICIPALIDAD DISTRITAL DE JOSE MARIA QUIMPER	\N	\N	32
555	040203-300362	MUNICIPALIDAD DISTRITAL DE MARIANO NICOLAS VALCARCEL	\N	\N	32
556	040204-300363	MUNICIPALIDAD DISTRITAL DE MARISCAL CACERES	\N	\N	32
557	040205-300364	MUNICIPALIDAD DISTRITAL DE NICOLAS DE PIEROLA	\N	\N	32
558	040206-300365	MUNICIPALIDAD DISTRITAL DE OCOÑA	\N	\N	32
559	040207-300366	MUNICIPALIDAD DISTRITAL DE QUILCA	\N	\N	32
560	040208-300367	MUNICIPALIDAD DISTRITAL DE SAMUEL PASTOR	\N	\N	32
561	040301-300368	MUNICIPALIDAD PROVINCIAL DE CARAVELI	\N	\N	32
562	040302-300369	MUNICIPALIDAD DISTRITAL DE ACARI	\N	\N	32
563	040303-300370	MUNICIPALIDAD DISTRITAL DE ATICO	\N	\N	32
564	040304-300371	MUNICIPALIDAD DISTRITAL DE ATIQUIPA	\N	\N	32
565	040305-300372	MUNICIPALIDAD DISTRITAL DE BELLA UNION	\N	\N	32
566	040306-300373	MUNICIPALIDAD DISTRITAL DE CAHUACHO	\N	\N	32
567	040307-300374	MUNICIPALIDAD DISTRITAL DE CHALA	\N	\N	32
568	040308-300375	MUNICIPALIDAD DISTRITAL DE CHAPARRA	\N	\N	32
569	040309-300376	MUNICIPALIDAD DISTRITAL DE HUANUHUANU	\N	\N	32
570	040310-300377	MUNICIPALIDAD DISTRITAL DE JAQUI	\N	\N	32
571	040311-300378	MUNICIPALIDAD DISTRITAL DE LOMAS	\N	\N	32
572	040312-300379	MUNICIPALIDAD DISTRITAL DE QUICACHA	\N	\N	32
573	040313-300380	MUNICIPALIDAD DISTRITAL DE YAUCA	\N	\N	32
574	040401-300381	MUNICIPALIDAD PROVINCIAL DE CASTILLA - APLAO	\N	\N	32
575	040402-300382	MUNICIPALIDAD DISTRITAL DE ANDAGUA	\N	\N	32
576	040403-300383	MUNICIPALIDAD DISTRITAL DE AYO	\N	\N	32
577	040404-300384	MUNICIPALIDAD DISTRITAL DE CHACHAS	\N	\N	32
578	040405-300385	MUNICIPALIDAD DISTRITAL DE CHILCAYMARCA	\N	\N	32
579	040406-300386	MUNICIPALIDAD DISTRITAL DE CHOCO	\N	\N	32
580	040407-300387	MUNICIPALIDAD DISTRITAL DE HUANCARQUI	\N	\N	32
581	040408-300388	MUNICIPALIDAD DISTRITAL DE MACHAGUAY	\N	\N	32
582	040409-300389	MUNICIPALIDAD DISTRITAL DE ORCOPAMPA	\N	\N	32
583	040410-300390	MUNICIPALIDAD DISTRITAL DE PAMPACOLCA	\N	\N	32
584	040411-300391	MUNICIPALIDAD DISTRITAL DE TIPAN	\N	\N	32
585	040412-300392	MUNICIPALIDAD DISTRITAL DE UÑON	\N	\N	32
586	040413-300393	MUNICIPALIDAD DISTRITAL DE URACA	\N	\N	32
587	040414-300394	MUNICIPALIDAD DISTRITAL DE VIRACO	\N	\N	32
588	040501-300395	MUNICIPALIDAD PROVINCIAL DE CAYLLOMA - CHIVAY	\N	\N	32
589	040502-300396	MUNICIPALIDAD DISTRITAL DE ACHOMA	\N	\N	32
590	040503-300397	MUNICIPALIDAD DISTRITAL DE CABANACONDE	\N	\N	32
591	040504-300398	MUNICIPALIDAD DISTRITAL DE CALLALLI	\N	\N	32
592	040505-300399	MUNICIPALIDAD DISTRITAL DE CAYLLOMA	\N	\N	32
593	040506-300400	MUNICIPALIDAD DISTRITAL DE COPORAQUE	\N	\N	32
594	040507-300401	MUNICIPALIDAD DISTRITAL DE HUAMBO	\N	\N	32
595	040508-300402	MUNICIPALIDAD DISTRITAL DE HUANCA	\N	\N	32
596	040509-300403	MUNICIPALIDAD DISTRITAL DE ICHUPAMPA	\N	\N	32
597	040510-300404	MUNICIPALIDAD DISTRITAL DE LARI	\N	\N	32
598	040511-300405	MUNICIPALIDAD DISTRITAL DE LLUTA	\N	\N	32
599	040512-300406	MUNICIPALIDAD DISTRITAL DE MACA	\N	\N	32
600	040513-300407	MUNICIPALIDAD DISTRITAL DE MADRIGAL	\N	\N	32
601	040514-300408	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO DE CHUCA	\N	\N	32
602	040515-300409	MUNICIPALIDAD DISTRITAL DE SIBAYO	\N	\N	32
603	040516-300410	MUNICIPALIDAD DISTRITAL DE TAPAY	\N	\N	32
604	040517-300411	MUNICIPALIDAD DISTRITAL DE TISCO	\N	\N	32
605	040518-300412	MUNICIPALIDAD DISTRITAL DE TUTI	\N	\N	32
606	040519-300413	MUNICIPALIDAD DISTRITAL DE YANQUE	\N	\N	32
607	040520-300414	MUNICIPALIDAD DISTRITAL DE MAJES	\N	\N	32
608	040601-300415	MUNICIPALIDAD PROVINCIAL DE CONDESUYOS - CHUQUIBAMBA	\N	\N	32
609	040602-300416	MUNICIPALIDAD DISTRITAL DE ANDARAY	\N	\N	32
610	040603-300417	MUNICIPALIDAD DISTRITAL DE CAYARANI	\N	\N	32
611	040604-300418	MUNICIPALIDAD DISTRITAL DE CHICHAS	\N	\N	32
612	040605-300419	MUNICIPALIDAD DISTRITAL DE IRAY	\N	\N	32
613	040606-300420	MUNICIPALIDAD DISTRITAL DE RIO GRANDE	\N	\N	32
614	040607-300421	MUNICIPALIDAD DISTRITAL DE SALAMANCA	\N	\N	32
615	040608-300422	MUNICIPALIDAD DISTRITAL DE YANAQUIHUA	\N	\N	32
616	040701-300423	MUNICIPALIDAD PROVINCIAL DE ISLAY - MOLLENDO	\N	\N	32
617	040702-300424	MUNICIPALIDAD DISTRITAL DE COCACHACRA	\N	\N	32
618	040703-300425	MUNICIPALIDAD DISTRITAL DE DEAN VALDIVIA	\N	\N	32
619	040704-300426	MUNICIPALIDAD DISTRITAL DE ISLAY	\N	\N	32
620	040705-300427	MUNICIPALIDAD DISTRITAL DE MEJIA	\N	\N	32
621	040706-300428	MUNICIPALIDAD DISTRITAL DE PUNTA DE BOMBON	\N	\N	32
622	040801-300429	MUNICIPALIDAD PROVINCIAL DE LA UNION - COTAHUASI	\N	\N	32
623	040802-300430	MUNICIPALIDAD DISTRITAL DE ALCA	\N	\N	32
624	040803-300431	MUNICIPALIDAD DISTRITAL DE CHARCANA	\N	\N	32
625	040804-300432	MUNICIPALIDAD DISTRITAL DE HUAYNACOTAS	\N	\N	32
626	040805-300433	MUNICIPALIDAD DISTRITAL DE PAMPAMARCA	\N	\N	32
627	040806-300434	MUNICIPALIDAD DISTRITAL DE PUYCA	\N	\N	32
628	040807-300435	MUNICIPALIDAD DISTRITAL DE QUECHUALLA	\N	\N	32
629	040808-300436	MUNICIPALIDAD DISTRITAL DE SAYLA	\N	\N	32
630	040809-300437	MUNICIPALIDAD DISTRITAL DE TAURIA	\N	\N	32
631	040810-300438	MUNICIPALIDAD DISTRITAL DE TOMEPAMPA	\N	\N	32
632	040811-300439	MUNICIPALIDAD DISTRITAL DE TORO	\N	\N	32
633	050101-300440	MUNICIPALIDAD PROVINCIAL DE HUAMANGA	\N	\N	32
634	050102-300441	MUNICIPALIDAD DISTRITAL DE ACOCRO	\N	\N	32
635	050103-300442	MUNICIPALIDAD DISTRITAL DE ACOS VINCHOS	\N	\N	32
636	050104-300443	MUNICIPALIDAD DISTRITAL DE CARMEN ALTO	\N	\N	32
637	050105-300444	MUNICIPALIDAD DISTRITAL DE CHIARA	\N	\N	32
638	050106-300445	MUNICIPALIDAD DISTRITAL DE OCROS	\N	\N	32
639	050107-300446	MUNICIPALIDAD DISTRITAL DE PACAICASA	\N	\N	32
640	050108-300447	MUNICIPALIDAD DISTRITAL DE QUINUA	\N	\N	32
641	050109-300448	MUNICIPALIDAD DISTRITAL DE SAN JOSE DE TICLLAS	\N	\N	32
642	050110-300449	MUNICIPALIDAD DISTRITAL DE SAN JUAN BAUTISTA	\N	\N	32
643	050111-300450	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE PISCHA	\N	\N	32
644	050112-300451	MUNICIPALIDAD DISTRITAL DE SOCOS	\N	\N	32
645	050113-300452	MUNICIPALIDAD DISTRITAL DE TAMBILLO	\N	\N	32
646	050114-300453	MUNICIPALIDAD DISTRITAL DE VINCHOS	\N	\N	32
647	050115-301830	MUNICIPALIDAD DISTRITAL JESUS NAZARENO	\N	\N	32
648	050116-301852	MUNICIPALIDAD DISTRITAL DE ANDRES AVELINO CACERES DORREGARAY	\N	\N	32
649	050201-300454	MUNICIPALIDAD PROVINCIAL DE CANGALLO	\N	\N	32
650	050202-300455	MUNICIPALIDAD DISTRITAL DE CHUSCHI	\N	\N	32
651	050203-300456	MUNICIPALIDAD DISTRITAL DE LOS MOROCHUCOS	\N	\N	32
652	050204-300457	MUNICIPALIDAD DISTRITAL DE MARIA PARADO DE BELLIDO	\N	\N	32
653	050205-300458	MUNICIPALIDAD DISTRITAL DE PARAS	\N	\N	32
654	050206-300459	MUNICIPALIDAD DISTRITAL DE TOTOS	\N	\N	32
655	050301-300460	MUNICIPALIDAD PROVINCIAL DE HUANCA SANCOS - SANCOS	\N	\N	32
656	050302-300461	MUNICIPALIDAD DISTRITAL DE CARAPO	\N	\N	32
657	050303-300462	MUNICIPALIDAD DISTRITAL DE SACSAMARCA	\N	\N	32
658	050304-300463	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE LUCANAMARCA	\N	\N	32
659	050401-300464	MUNICIPALIDAD PROVINCIAL DE HUANTA	\N	\N	32
660	050402-300465	MUNICIPALIDAD DISTRITAL DE AYAHUANCO	\N	\N	32
661	050403-300466	MUNICIPALIDAD DISTRITAL DE HUAMANGUILLA	\N	\N	32
662	050404-300467	MUNICIPALIDAD DISTRITAL DE IGUAIN	\N	\N	32
663	050405-300468	MUNICIPALIDAD DISTRITAL DE LURICOCHA	\N	\N	32
664	050406-300469	MUNICIPALIDAD DISTRITAL DE SANTILLANA	\N	\N	32
665	050407-300470	MUNICIPALIDAD DISTRITAL DE SIVIA	\N	\N	32
666	050408-301837	MUNICIPALIDAD DISTRITAL DE LLOCHEGUA	\N	\N	32
667	050409-301850	MUNICIPALIDAD DISTRITAL DE CANAYRE	\N	\N	32
668	050410-301862	MUNICIPALIDAD DISTRITAL DE UCHURACCAY	\N	\N	32
669	050411-301866	MUNICIPALIDAD DISTRITAL DE PUCACOLPA	\N	\N	32
670	050412-301874	MUNICIPALIDAD DISTRITAL DE CHACA	\N	\N	32
671	050413-301888	MUNICIPALIDAD DISTRITAL DE PUTIS	\N	\N	32
672	050501-300471	MUNICIPALIDAD PROVINCIAL DE LA MAR - SAN MIGUEL	\N	\N	32
673	050502-300472	MUNICIPALIDAD DISTRITAL DE ANCO	\N	\N	32
674	050503-300473	MUNICIPALIDAD DISTRITAL DE AYNA	\N	\N	32
675	050504-300474	MUNICIPALIDAD DISTRITAL DE CHILCAS	\N	\N	32
676	050505-300475	MUNICIPALIDAD DISTRITAL DE CHUNGUI	\N	\N	32
677	050506-300476	MUNICIPALIDAD DISTRITAL DE LUIS CARRANZA	\N	\N	32
678	050507-300477	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
679	050508-300478	MUNICIPALIDAD DISTRITAL DE TAMBO	\N	\N	32
680	050509-301848	MUNICIPALIDAD DISTRITAL DE SAMUGARI	\N	\N	32
681	050510-301851	MUNICIPALIDAD DISTRITAL DE ANCHIHUAY	\N	\N	32
682	050511-301882	MUNICIPALIDAD DISTRITAL DE ORONCCOY	\N	\N	32
683	050512-301889	MUNICIPALIDAD DISTRITAL DE UNION PROGRESO	\N	\N	32
684	050513-301890	MUNICIPALIDAD DISTRITAL DE RIO MAGDALENA	\N	\N	32
685	050514-301891	MUNICIPALIDAD DISTRITAL DE NINABAMBA	\N	\N	32
686	050515-301892	MUNICIPALIDAD DISTRITAL DE PATIBAMBA	\N	\N	32
687	050601-300479	MUNICIPALIDAD PROVINCIAL DE LUCANAS - PUQUIO	\N	\N	32
688	050602-300480	MUNICIPALIDAD DISTRITAL DE AUCARA	\N	\N	32
689	050603-300481	MUNICIPALIDAD DISTRITAL DE CABANA	\N	\N	32
690	050604-300482	MUNICIPALIDAD DISTRITAL DE CARMEN SALCEDO	\N	\N	32
691	050605-300483	MUNICIPALIDAD DISTRITAL DE CHAVIÑA	\N	\N	32
692	050606-300484	MUNICIPALIDAD DISTRITAL DE CHIPAO	\N	\N	32
693	050607-300485	MUNICIPALIDAD DISTRITAL DE HUAC - HUAS	\N	\N	32
694	050608-300486	MUNICIPALIDAD DISTRITAL DE LARAMATE	\N	\N	32
695	050609-300487	MUNICIPALIDAD DISTRITAL DE LEONCIO PRADO	\N	\N	32
696	050610-300488	MUNICIPALIDAD DISTRITAL DE LLAUTA	\N	\N	32
697	050611-300489	MUNICIPALIDAD DISTRITAL DE LUCANAS	\N	\N	32
698	050612-300490	MUNICIPALIDAD DISTRITAL DE OCAÑA	\N	\N	32
699	050613-300491	MUNICIPALIDAD DISTRITAL DE OTOCA	\N	\N	32
700	050614-300492	MUNICIPALIDAD DISTRITAL DE SAISA	\N	\N	32
701	050615-300493	MUNICIPALIDAD DISTRITAL DE SAN CRISTOBAL	\N	\N	32
702	050616-300494	MUNICIPALIDAD DISTRITAL DE SAN JUAN	\N	\N	32
703	050617-300495	MUNICIPALIDAD DISTRITAL DE SAN PEDRO	\N	\N	32
704	050618-300496	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE PALCO	\N	\N	32
705	050619-300497	MUNICIPALIDAD DISTRITAL DE SANCOS	\N	\N	32
706	050620-300498	MUNICIPALIDAD DISTRITAL DE SANTA ANA DE HUAYCAHUACHO	\N	\N	32
707	050621-300499	MUNICIPALIDAD DISTRITAL DE SANTA LUCIA	\N	\N	32
708	050701-300500	MUNICIPALIDAD PROVINCIAL DE PARINACOCHAS - CORACORA	\N	\N	32
709	050702-300501	MUNICIPALIDAD DISTRITAL DE CHUMPI	\N	\N	32
710	050703-300502	MUNICIPALIDAD DISTRITAL DE CORONEL CASTAÑEDA	\N	\N	32
711	050704-300503	MUNICIPALIDAD DISTRITAL DE PACAPAUSA	\N	\N	32
712	050705-300504	MUNICIPALIDAD DISTRITAL DE PULLO	\N	\N	32
713	050706-300505	MUNICIPALIDAD DISTRITAL DE PUYUSCA	\N	\N	32
714	050707-300506	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DE RIVACAYCO	\N	\N	32
715	050708-300507	MUNICIPALIDAD DISTRITAL DE UPAHUACHO	\N	\N	32
716	050801-300508	MUNICIPALIDAD PROVINCIAL DE PAUCAR DEL SARA SARA - PAUSA	\N	\N	32
717	050802-300509	MUNICIPALIDAD DISTRITAL DE COLTA	\N	\N	32
718	050803-300510	MUNICIPALIDAD DISTRITAL DE CORCULLA	\N	\N	32
719	050804-300511	MUNICIPALIDAD DISTRITAL DE LAMPA	\N	\N	32
720	050805-300512	MUNICIPALIDAD DISTRITAL DE MARCABAMBA	\N	\N	32
721	050806-300513	MUNICIPALIDAD DISTRITAL DE OYOLO	\N	\N	32
722	050807-300514	MUNICIPALIDAD DISTRITAL DE PARARCA	\N	\N	32
723	050808-300515	MUNICIPALIDAD DISTRITAL DE SAN JAVIER DE ALPABAMBA	\N	\N	32
724	050809-300516	MUNICIPALIDAD DISTRITAL DE SAN JOSE DE USHUA	\N	\N	32
725	050810-300517	MUNICIPALIDAD DISTRITAL DE SARA SARA	\N	\N	32
726	050901-300518	MUNICIPALIDAD PROVINCIAL DE SUCRE - QUEROBAMBA	\N	\N	32
727	050902-300519	MUNICIPALIDAD DISTRITAL DE BELEN	\N	\N	32
728	050903-300520	MUNICIPALIDAD DISTRITAL DE CHALCOS	\N	\N	32
729	050904-300521	MUNICIPALIDAD DISTRITAL DE CHILCAYOC	\N	\N	32
730	050905-300522	MUNICIPALIDAD DISTRITAL DE HUACAÑA	\N	\N	32
731	050906-300523	MUNICIPALIDAD DISTRITAL DE MORCOLLA	\N	\N	32
732	050907-300524	MUNICIPALIDAD DISTRITAL DE PAICO	\N	\N	32
733	050908-300525	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE LARCAY	\N	\N	32
734	050909-300526	MUNICIPALIDAD DISTRITAL DE SAN SALVADOR DE QUIJE	\N	\N	32
735	050910-300527	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE PAUCARAY	\N	\N	32
736	050911-300528	MUNICIPALIDAD DISTRITAL DE SORAS	\N	\N	32
737	051001-300529	MUNICIPALIDAD PROVINCIAL DE VICTOR FAJARDO - HUANCAPI	\N	\N	32
738	051002-300530	MUNICIPALIDAD DISTRITAL DE ALCAMENCA	\N	\N	32
739	051003-300531	MUNICIPALIDAD DISTRITAL DE APONGO	\N	\N	32
740	051004-300532	MUNICIPALIDAD DISTRITAL DE ASQUIPATA	\N	\N	32
741	051005-300533	MUNICIPALIDAD DISTRITAL DE CANARIA	\N	\N	32
742	051006-300534	MUNICIPALIDAD DISTRITAL DE CAYARA	\N	\N	32
743	051007-300535	MUNICIPALIDAD DISTRITAL DE COLCA	\N	\N	32
744	051008-300536	MUNICIPALIDAD DISTRITAL DE HUAMANQUIQUIA	\N	\N	32
745	051009-300537	MUNICIPALIDAD DISTRITAL DE HUANCARAYLLA	\N	\N	32
746	051010-300538	MUNICIPALIDAD DISTRITAL DE HUALLA	\N	\N	32
747	051011-300539	MUNICIPALIDAD DISTRITAL DE SARHUA	\N	\N	32
748	051012-300540	MUNICIPALIDAD DISTRITAL DE VILCANCHOS	\N	\N	32
749	051101-300541	MUNICIPALIDAD PROVINCIAL DE VILCAS HUAMAN	\N	\N	32
750	051102-300542	MUNICIPALIDAD DISTRITAL DE ACCOMARCA	\N	\N	32
751	051103-300543	MUNICIPALIDAD DISTRITAL DE CARHUANCA	\N	\N	32
752	051104-300544	MUNICIPALIDAD DISTRITAL DE CONCEPCION	\N	\N	32
753	051105-300545	MUNICIPALIDAD DISTRITAL DE HUAMBALPA	\N	\N	32
754	051106-300546	MUNICIPALIDAD DISTRITAL DE INDEPENDENCIA	\N	\N	32
755	051107-300547	MUNICIPALIDAD DISTRITAL DE SAURAMA	\N	\N	32
756	051108-300548	MUNICIPALIDAD DISTRITAL DE VISCHONGO	\N	\N	32
757	060101-300549	MUNICIPALIDAD PROVINCIAL DE CAJAMARCA	\N	\N	32
758	060102-300550	MUNICIPALIDAD DISTRITAL DE ASUNCION	\N	\N	32
759	060103-300551	MUNICIPALIDAD DISTRITAL DE CHETILLA	\N	\N	32
760	060104-300552	MUNICIPALIDAD DISTRITAL DE COSPAN	\N	\N	32
761	060105-300553	MUNICIPALIDAD DISTRITAL DE ENCAÑADA	\N	\N	32
762	060106-300554	MUNICIPALIDAD DISTRITAL DE JESUS	\N	\N	32
763	060107-300555	MUNICIPALIDAD DISTRITAL DE LLACANORA	\N	\N	32
764	060108-300556	MUNICIPALIDAD DISTRITAL DE LOS BA¥OS DEL INCA	\N	\N	32
765	060109-300557	MUNICIPALIDAD DISTRITAL DE MAGDALENA	\N	\N	32
766	060110-300558	MUNICIPALIDAD DISTRITAL DE MATARA	\N	\N	32
767	060111-300559	MUNICIPALIDAD DISTRITAL DE NAMORA	\N	\N	32
768	060112-300560	MUNICIPALIDAD DISTRITAL DE SAN JUAN	\N	\N	32
769	060201-300562	MUNICIPALIDAD PROVINCIAL DE CAJABAMBA	\N	\N	32
770	060202-300563	MUNICIPALIDAD DISTRITAL DE CACHACHI	\N	\N	32
771	060203-300564	MUNICIPALIDAD DISTRITAL DE CONDEBAMBA	\N	\N	32
772	060204-300565	MUNICIPALIDAD DISTRITAL DE SITACOCHA	\N	\N	32
773	060301-300566	MUNICIPALIDAD PROVINCIAL DE CELENDIN	\N	\N	32
774	060302-300567	MUNICIPALIDAD DISTRITAL DE CHUMUCH	\N	\N	32
775	060303-300568	MUNICIPALIDAD DISTRITAL DE CORTEGANA	\N	\N	32
776	060304-300569	MUNICIPALIDAD DISTRITAL DE HUASMIN	\N	\N	32
777	060305-300570	MUNICIPALIDAD DISTRITAL DE JORGE CHAVEZ	\N	\N	32
778	060306-300571	MUNICIPALIDAD DISTRITAL DE JOSE GALVEZ	\N	\N	32
779	060307-300572	MUNICIPALIDAD DISTRITAL DE MIGUEL IGLESIAS	\N	\N	32
780	060308-300573	MUNICIPALIDAD DISTRITAL DE OXAMARCA	\N	\N	32
781	060309-300574	MUNICIPALIDAD DISTRITAL DE SOROCHUCO	\N	\N	32
782	060310-300575	MUNICIPALIDAD DISTRITAL DE SUCRE	\N	\N	32
783	060311-300576	MUNICIPALIDAD DISTRITAL DE UTCO	\N	\N	32
784	060312-300577	MUNICIPALIDAD DISTRITAL DE LA LIBERTAD DE PALLAN	\N	\N	32
785	060401-300578	MUNICIPALIDAD PROVINCIAL DE CHOTA	\N	\N	32
786	060402-300579	MUNICIPALIDAD DISTRITAL DE ANGUIA	\N	\N	32
787	060403-300580	MUNICIPALIDAD DISTRITAL DE CHADIN	\N	\N	32
788	060404-300581	MUNICIPALIDAD DISTRITAL DE CHIGUIRIP	\N	\N	32
789	060405-300582	MUNICIPALIDAD DISTRITAL DE CHIMBAN	\N	\N	32
790	060406-300583	MUNICIPALIDAD DISTRITAL DE CHOROPAMPA	\N	\N	32
791	060407-300584	MUNICIPALIDAD DISTRITAL DE COCHABAMBA	\N	\N	32
792	060408-300585	MUNICIPALIDAD DISTRITAL DE CONCHAN	\N	\N	32
793	060409-300586	MUNICIPALIDAD DISTRITAL DE HUAMBOS	\N	\N	32
794	060410-300587	MUNICIPALIDAD DISTRITAL DE LAJAS	\N	\N	32
795	060411-300588	MUNICIPALIDAD DISTRITAL DE LLAMA	\N	\N	32
796	060412-300589	MUNICIPALIDAD DISTRITAL DE MIRACOSTA	\N	\N	32
797	060413-300590	MUNICIPALIDAD DISTRITAL DE PACCHA	\N	\N	32
798	060414-300591	MUNICIPALIDAD DISTRITAL DE PION	\N	\N	32
799	060415-300592	MUNICIPALIDAD DISTRITAL DE QUEROCOTO	\N	\N	32
800	060416-300593	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE LICUPIS	\N	\N	32
801	060417-300594	MUNICIPALIDAD DISTRITAL DE TACABAMBA	\N	\N	32
802	060418-300595	MUNICIPALIDAD DISTRITAL DE TOCMOCHE	\N	\N	32
803	060419-300596	MUNICIPALIDAD DISTRITAL DE CHALAMARCA	\N	\N	32
804	060501-300597	MUNICIPALIDAD PROVINCIAL DE CONTUMAZA	\N	\N	32
805	060502-300598	MUNICIPALIDAD DISTRITAL DE CHILETE	\N	\N	32
806	060503-300599	MUNICIPALIDAD DISTRITAL DE CUPISNIQUE	\N	\N	32
807	060504-300600	MUNICIPALIDAD DISTRITAL DE GUZMANGO	\N	\N	32
808	060505-300601	MUNICIPALIDAD DISTRITAL DE SAN BENITO	\N	\N	32
809	060506-300602	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ DE TOLEDO	\N	\N	32
810	060507-300603	MUNICIPALIDAD DISTRITAL DE TANTARICA	\N	\N	32
811	060508-300604	MUNICIPALIDAD DISTRITAL DE YONAN	\N	\N	32
812	060601-300605	MUNICIPALIDAD PROVINCIAL DE CUTERVO	\N	\N	32
813	060602-300606	MUNICIPALIDAD DISTRITAL DE CALLAYUC	\N	\N	32
814	060603-300607	MUNICIPALIDAD DISTRITAL DE CHOROS	\N	\N	32
815	060604-300608	MUNICIPALIDAD DISTRITAL DE CUJILLO	\N	\N	32
816	060605-300609	MUNICIPALIDAD DISTRITAL DE LA RAMADA	\N	\N	32
817	060606-300610	MUNICIPALIDAD DISTRITAL DE PIMPINGOS	\N	\N	32
818	060607-300611	MUNICIPALIDAD DISTRITAL DE QUEROCOTILLO	\N	\N	32
819	060608-300612	MUNICIPALIDAD DISTRITAL DE SAN ANDRES DE CUTERVO	\N	\N	32
820	060609-300613	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE CUTERVO	\N	\N	32
821	060610-300614	MUNICIPALIDAD DISTRITAL DE SAN LUIS DE LUCMA	\N	\N	32
822	060611-300615	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ	\N	\N	32
823	060612-300616	MUNICIPALIDAD DISTRITAL DE SANTO DOMINGO DE LA CAPILLA	\N	\N	32
824	060613-300617	MUNICIPALIDAD DISTRITAL DE SANTO TOMAS	\N	\N	32
825	060614-300618	MUNICIPALIDAD DISTRITAL DE SOCOTA	\N	\N	32
826	060615-300619	MUNICIPALIDAD DISTRITAL DE TORIBIO CASANOVA	\N	\N	32
827	060701-300620	MUNICIPALIDAD PROVINCIAL DE HUALGAYOC - BAMBAMARCA	\N	\N	32
828	060702-300621	MUNICIPALIDAD DISTRITAL DE CHUGUR	\N	\N	32
829	060703-300622	MUNICIPALIDAD DISTRITAL DE HUALGAYOC	\N	\N	32
830	060801-300623	MUNICIPALIDAD PROVINCIAL DE JAEN	\N	\N	32
831	060802-300624	MUNICIPALIDAD DISTRITAL DE BELLAVISTA	\N	\N	32
832	060803-300625	MUNICIPALIDAD DISTRITAL DE CHONTALI	\N	\N	32
833	060804-300626	MUNICIPALIDAD DISTRITAL DE COLASAY	\N	\N	32
834	060805-300627	MUNICIPALIDAD DISTRITAL DE HUABAL	\N	\N	32
835	060806-300628	MUNICIPALIDAD DISTRITAL DE LAS PIRIAS	\N	\N	32
836	060807-300629	MUNICIPALIDAD DISTRITAL DE POMAHUACA	\N	\N	32
837	060808-300630	MUNICIPALIDAD DISTRITAL DE PUCARA	\N	\N	32
838	060809-300631	MUNICIPALIDAD DISTRITAL DE SALLIQUE	\N	\N	32
839	060810-300632	MUNICIPALIDAD DISTRITAL DE SAN FELIPE	\N	\N	32
840	060811-300633	MUNICIPALIDAD DISTRITAL DE SAN JOSE DEL ALTO	\N	\N	32
841	060812-300634	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
842	060901-300635	MUNICIPALIDAD PROVINCIAL DE SAN IGNACIO	\N	\N	32
843	060902-300636	MUNICIPALIDAD DISTRITAL DE CHIRINOS	\N	\N	32
844	060903-300637	MUNICIPALIDAD DISTRITAL DE HUARANGO	\N	\N	32
845	060904-300638	MUNICIPALIDAD DISTRITAL DE LA COIPA	\N	\N	32
846	060905-300639	MUNICIPALIDAD DISTRITAL DE NAMBALLE	\N	\N	32
847	060906-300640	MUNICIPALIDAD DISTRITAL DE SAN JOSE DE LOURDES	\N	\N	32
848	060907-300641	MUNICIPALIDAD DISTRITAL DE TABACONAS	\N	\N	32
849	061001-300642	MUNICIPALIDAD PROVINCIAL DE SAN MARCOS - PEDRO GALVEZ	\N	\N	32
850	061002-300643	MUNICIPALIDAD DISTRITAL DE CHANCAY	\N	\N	32
851	061003-300644	MUNICIPALIDAD DISTRITAL DE EDUARDO VILLANUEVA	\N	\N	32
852	061004-300645	MUNICIPALIDAD DISTRITAL DE GREGORIO PITA	\N	\N	32
853	061005-300646	MUNICIPALIDAD DISTRITAL DE ICHOCAN	\N	\N	32
854	061006-300647	MUNICIPALIDAD DISTRITAL DE JOSE MANUEL QUIROZ	\N	\N	32
855	061007-300648	MUNICIPALIDAD DISTRITAL DE JOSE SABOGAL	\N	\N	32
856	061101-300649	MUNICIPALIDAD PROVINCIAL DE SAN MIGUEL	\N	\N	32
857	061102-300650	MUNICIPALIDAD DISTRITAL DE BOLIVAR	\N	\N	32
858	061103-300651	MUNICIPALIDAD DISTRITAL DE CALQUIS	\N	\N	32
859	061104-300652	MUNICIPALIDAD DISTRITAL DE CATILLUC	\N	\N	32
860	061105-300653	MUNICIPALIDAD DISTRITAL DE EL PRADO	\N	\N	32
861	061106-300654	MUNICIPALIDAD DISTRITAL DE LA FLORIDA	\N	\N	32
862	061107-300655	MUNICIPALIDAD DISTRITAL DE LLAPA	\N	\N	32
863	061108-300656	MUNICIPALIDAD DISTRITAL DE NANCHOC	\N	\N	32
864	061109-300657	MUNICIPALIDAD DISTRITAL DE NIEPOS	\N	\N	32
865	061110-300658	MUNICIPALIDAD DISTRITAL DE SAN GREGORIO	\N	\N	32
866	061111-300659	MUNICIPALIDAD DISTRITAL DE SAN SILVESTRE DE COCHAN	\N	\N	32
867	061112-300660	MUNICIPALIDAD DISTRITAL DE TONGOD	\N	\N	32
868	061113-300661	MUNICIPALIDAD DISTRITAL DE UNION AGUA BLANCA	\N	\N	32
869	061201-300662	MUNICIPALIDAD PROVINCIAL DE SAN PABLO	\N	\N	32
870	061202-300663	MUNICIPALIDAD DISTRITAL DE SAN BERNARDINO	\N	\N	32
871	061203-300664	MUNICIPALIDAD DISTRITAL DE SAN LUIS	\N	\N	32
872	061204-300665	MUNICIPALIDAD DISTRITAL DE TUMBADEN	\N	\N	32
873	061301-300666	MUNICIPALIDAD PROVINCIAL DE SANTA CRUZ	\N	\N	32
874	061302-300667	MUNICIPALIDAD DISTRITAL DE ANDABAMBA	\N	\N	32
875	061303-300668	MUNICIPALIDAD DISTRITAL DE CATACHE	\N	\N	32
876	061304-300669	MUNICIPALIDAD DISTRITAL DE CHANCAYBAÑOS	\N	\N	32
877	061305-300670	MUNICIPALIDAD DISTRITAL DE LA ESPERANZA	\N	\N	32
878	061306-300671	MUNICIPALIDAD DISTRITAL DE NINABAMBA	\N	\N	32
879	061307-300672	MUNICIPALIDAD DISTRITAL DE PULAN	\N	\N	32
880	061308-300673	MUNICIPALIDAD DISTRITAL DE SAUCEPAMPA	\N	\N	32
881	061309-300674	MUNICIPALIDAD DISTRITAL DE SEXI	\N	\N	32
882	061310-300675	MUNICIPALIDAD DISTRITAL DE UTICYACU	\N	\N	32
883	061311-300676	MUNICIPALIDAD DISTRITAL DE YAUYUCAN	\N	\N	32
884	070101-300677	MUNICIPALIDAD PROVINCIAL DEL CALLAO	\N	\N	32
885	070102-300678	MUNICIPALIDAD DISTRITAL DE BELLAVISTA	\N	\N	32
886	070103-300679	MUNICIPALIDAD DISTRITAL DE CARMEN DE LA LEGUA REYNOSO	\N	\N	32
887	070104-300680	MUNICIPALIDAD DISTRITAL DE LA PERLA	\N	\N	32
888	070105-300681	MUNICIPALIDAD DISTRITAL DE LA PUNTA	\N	\N	32
889	070106-300682	MUNICIPALIDAD DISTRITAL DE VENTANILLA	\N	\N	32
890	070107-301853	MUNICIPALIDAD DISTRITAL DE MI PERU	\N	\N	32
891	080101-300684	MUNICIPALIDAD PROVINCIAL DEL CUZCO	\N	\N	32
892	080102-300685	MUNICIPALIDAD DISTRITAL DE CCORCCA	\N	\N	32
893	080103-300686	MUNICIPALIDAD DISTRITAL DE POROY	\N	\N	32
894	080104-300687	MUNICIPALIDAD DISTRITAL DE SAN JERONIMO	\N	\N	32
895	080105-300688	MUNICIPALIDAD DISTRITAL DE SAN SEBASTIAN	\N	\N	32
896	080106-300689	MUNICIPALIDAD DISTRITAL DE SANTIAGO	\N	\N	32
897	080107-300690	MUNICIPALIDAD DISTRITAL DE SAYLLA	\N	\N	32
898	080108-300691	MUNICIPALIDAD DISTRITAL DE WANCHAQ	\N	\N	32
899	080201-300692	MUNICIPALIDAD PROVINCIAL DE ACOMAYO	\N	\N	32
900	080202-300693	MUNICIPALIDAD DISTRITAL DE ACOPIA	\N	\N	32
901	080203-300694	MUNICIPALIDAD DISTRITAL DE ACOS	\N	\N	32
902	080204-300695	MUNICIPALIDAD DISTRITAL DE MOSOC LLACTA	\N	\N	32
903	080205-300696	MUNICIPALIDAD DISTRITAL DE POMACANCHI	\N	\N	32
904	080206-300697	MUNICIPALIDAD DISTRITAL DE RONDOCAN	\N	\N	32
905	080207-300698	MUNICIPALIDAD DISTRITAL DE SANGARARA	\N	\N	32
906	080301-300699	MUNICIPALIDAD PROVINCIAL DE ANTA	\N	\N	32
907	080302-300700	MUNICIPALIDAD DISTRITAL DE ANCAHUASI	\N	\N	32
908	080303-300701	MUNICIPALIDAD DISTRITAL DE CACHIMAYO	\N	\N	32
909	080304-300702	MUNICIPALIDAD DISTRITAL DE CHINCHAYPUJIO	\N	\N	32
910	080305-300703	MUNICIPALIDAD DISTRITAL DE HUAROCONDO	\N	\N	32
911	080306-300704	MUNICIPALIDAD DISTRITAL DE LIMATAMBO	\N	\N	32
912	080307-300705	MUNICIPALIDAD DISTRITAL DE MOLLEPATA	\N	\N	32
913	080308-300706	MUNICIPALIDAD DISTRITAL DE PUCYURA	\N	\N	32
914	080309-300707	MUNICIPALIDAD DISTRITAL DE ZURITE	\N	\N	32
915	080401-300708	MUNICIPALIDAD PROVINCIAL DE CALCA	\N	\N	32
916	080402-300709	MUNICIPALIDAD DISTRITAL DE COYA	\N	\N	32
917	080403-300710	MUNICIPALIDAD DISTRITAL DE LAMAY	\N	\N	32
918	080404-300711	MUNICIPALIDAD DISTRITAL DE LARES	\N	\N	32
919	080405-300712	MUNICIPALIDAD DISTRITAL DE PISAC	\N	\N	32
920	080406-300713	MUNICIPALIDAD DISTRITAL DE SAN SALVADOR	\N	\N	32
921	080407-300714	MUNICIPALIDAD DISTRITAL DE TARAY	\N	\N	32
922	080408-300715	MUNICIPALIDAD DISTRITAL DE YANATILE	\N	\N	32
923	080501-300716	MUNICIPALIDAD PROVINCIAL DE CANAS - YANAOCA	\N	\N	32
924	080502-300717	MUNICIPALIDAD DISTRITAL DE CHECCA	\N	\N	32
925	080503-300718	MUNICIPALIDAD DISTRITAL DE KUNTURKANKI	\N	\N	32
926	080504-300719	MUNICIPALIDAD DISTRITAL DE LANGUI	\N	\N	32
927	080505-300720	MUNICIPALIDAD DISTRITAL DE LAYO	\N	\N	32
928	080506-300721	MUNICIPALIDAD DISTRITAL DE PAMPAMARCA	\N	\N	32
929	080507-300722	MUNICIPALIDAD DISTRITAL DE QUEHUE	\N	\N	32
930	080508-300723	MUNICIPALIDAD DISTRITAL DE TUPAC AMARU	\N	\N	32
931	080601-300724	MUNICIPALIDAD PROVINCIAL DE CANCHIS - SICUANI	\N	\N	32
932	080602-300725	MUNICIPALIDAD DISTRITAL DE CHECACUPE	\N	\N	32
933	080603-300726	MUNICIPALIDAD DISTRITAL DE COMBAPATA	\N	\N	32
934	080604-300727	MUNICIPALIDAD DISTRITAL DE MARANGANI	\N	\N	32
935	080605-300728	MUNICIPALIDAD DISTRITAL DE PITUMARCA	\N	\N	32
936	080606-300729	MUNICIPALIDAD DISTRITAL DE SAN PABLO	\N	\N	32
937	080607-300730	MUNICIPALIDAD DISTRITAL DE SAN PEDRO	\N	\N	32
938	080608-300731	MUNICIPALIDAD DISTRITAL DE TINTA	\N	\N	32
939	080701-300732	MUNICIPALIDAD PROVINCIAL DE CHUMBIVILCAS - SANTO TOMAS	\N	\N	32
940	080702-300733	MUNICIPALIDAD DISTRITAL DE CAPACMARCA	\N	\N	32
941	080703-300734	MUNICIPALIDAD DISTRITAL DE CHAMACA	\N	\N	32
942	080704-300735	MUNICIPALIDAD DISTRITAL DE COLQUEMARCA	\N	\N	32
943	080705-300736	MUNICIPALIDAD DISTRITAL DE LIVITACA	\N	\N	32
944	080706-300737	MUNICIPALIDAD DISTRITAL DE LLUSCO	\N	\N	32
945	080707-300738	MUNICIPALIDAD DISTRITAL DE QUIÑOTA	\N	\N	32
946	080708-300739	MUNICIPALIDAD DISTRITAL DE VELILLE	\N	\N	32
947	080801-300740	MUNICIPALIDAD PROVINCIAL DE ESPINAR	\N	\N	32
948	080802-300741	MUNICIPALIDAD DISTRITAL DE CONDOROMA	\N	\N	32
949	080803-300742	MUNICIPALIDAD DISTRITAL DE COPORAQUE	\N	\N	32
950	080804-300743	MUNICIPALIDAD DISTRITAL DE OCORURO	\N	\N	32
951	080805-300744	MUNICIPALIDAD DISTRITAL DE PALLPATA	\N	\N	32
952	080806-300745	MUNICIPALIDAD DISTRITAL DE PICHIGUA	\N	\N	32
953	080807-300746	MUNICIPALIDAD DISTRITAL DE SUYCKUTAMBO	\N	\N	32
954	080808-300747	MUNICIPALIDAD DISTRITAL DE ALTO PICHIGUA	\N	\N	32
955	080901-300748	MUNICIPALIDAD PROVINCIAL DE LA CONVENCION - SANTA ANA	\N	\N	32
956	080902-300749	MUNICIPALIDAD DISTRITAL DE ECHARATI	\N	\N	32
957	080903-300750	MUNICIPALIDAD DISTRITAL DE HUAYOPATA	\N	\N	32
958	080904-300751	MUNICIPALIDAD DISTRITAL DE MARANURA	\N	\N	32
959	080905-300752	MUNICIPALIDAD DISTRITAL DE OCOBAMBA	\N	\N	32
960	080906-300753	MUNICIPALIDAD DISTRITAL DE QUELLOUNO	\N	\N	32
961	080907-300754	MUNICIPALIDAD DISTRITAL DE QUIMBIRI	\N	\N	32
962	080908-300755	MUNICIPALIDAD DISTRITAL DE SANTA TERESA	\N	\N	32
963	080909-300756	MUNICIPALIDAD DISTRITAL DE VILCABAMBA	\N	\N	32
964	080910-300757	MUNICIPALIDAD DISTRITAL DE PICHARI	\N	\N	32
965	080911-301859	MUNICIPALIDAD DISTRITAL DE INKAWASI	\N	\N	32
966	080912-301858	MUNICIPALIDAD DISTRITAL DE VILLA VIRGEN	\N	\N	32
967	080913-301867	MUNICIPALIDAD DISTRITAL DE VILLA KINTIARINA	\N	\N	32
968	080914-301884	MUNICIPALIDAD DISTRITAL DE MEGANTONI	\N	\N	32
969	080915-301893	MUNICIPALIDAD DISTRITAL DE KUMPIRUSHIATO	\N	\N	32
970	080916-301894	MUNICIPALIDAD DISTRITAL DE CIELO PUNCO	\N	\N	32
971	080917-301895	MUNICIPALIDAD DISTRITAL DE MANITEA	\N	\N	32
972	080918-301902	MUNICIPALIDAD DISTRITAL DE UNION ASHANINKA	\N	\N	32
973	081001-300758	MUNICIPALIDAD PROVINCIAL DE PARURO	\N	\N	32
974	081002-300759	MUNICIPALIDAD DISTRITAL DE ACCHA	\N	\N	32
975	081003-300760	MUNICIPALIDAD DISTRITAL DE CCAPI	\N	\N	32
976	081004-300761	MUNICIPALIDAD DISTRITAL DE COLCHA	\N	\N	32
977	081005-300762	MUNICIPALIDAD DISTRITAL DE HUANOQUITE	\N	\N	32
978	081006-300763	MUNICIPALIDAD DISTRITAL DE OMACHA	\N	\N	32
979	081007-300764	MUNICIPALIDAD DISTRITAL DE PACCARITAMBO	\N	\N	32
980	081008-300765	MUNICIPALIDAD DISTRITAL DE PILLPINTO	\N	\N	32
981	081009-300766	MUNICIPALIDAD DISTRITAL DE YAURISQUE	\N	\N	32
982	081101-300767	MUNICIPALIDAD PROVINCIAL DE PAUCARTAMBO	\N	\N	32
983	081102-300768	MUNICIPALIDAD DISTRITAL DE CAICAY	\N	\N	32
984	081103-300769	MUNICIPALIDAD DISTRITAL DE CHALLABAMBA	\N	\N	32
985	081104-300770	MUNICIPALIDAD DISTRITAL DE COLQUEPATA	\N	\N	32
986	081105-300771	MUNICIPALIDAD DISTRITAL DE HUANCARANI	\N	\N	32
987	081106-300772	MUNICIPALIDAD DISTRITAL DE KOSÑIPATA	\N	\N	32
988	081201-300773	MUNICIPALIDAD PROVINCIAL DE QUISPICANCHIS - URCOS	\N	\N	32
989	081202-300774	MUNICIPALIDAD DISTRITAL DE ANDAHUAYLILLAS	\N	\N	32
990	081203-300775	MUNICIPALIDAD DISTRITAL DE CAMANTI	\N	\N	32
991	081204-300776	MUNICIPALIDAD DISTRITAL DE CCARHUAYO	\N	\N	32
992	081205-300777	MUNICIPALIDAD DISTRITAL DE CCATCA	\N	\N	32
993	081206-300778	MUNICIPALIDAD DISTRITAL DE CUSIPATA	\N	\N	32
994	081207-300779	MUNICIPALIDAD DISTRITAL DE HUARO	\N	\N	32
995	081208-300780	MUNICIPALIDAD DISTRITAL DE LUCRE	\N	\N	32
996	081209-300781	MUNICIPALIDAD DISTRITAL DE MARCAPATA	\N	\N	32
997	081210-300782	MUNICIPALIDAD DISTRITAL DE OCONGATE	\N	\N	32
998	081211-300783	MUNICIPALIDAD DISTRITAL DE OROPESA	\N	\N	32
999	081212-300784	MUNICIPALIDAD DISTRITAL DE QUIQUIJANA	\N	\N	32
1000	081301-300785	MUNICIPALIDAD PROVINCIAL DE URUBAMBA	\N	\N	32
1001	081302-300786	MUNICIPALIDAD DISTRITAL DE CHINCHERO	\N	\N	32
1002	081303-300787	MUNICIPALIDAD DISTRITAL DE HUAYLLABAMBA	\N	\N	32
1003	081304-300788	MUNICIPALIDAD DISTRITAL DE MACHUPICCHU	\N	\N	32
1004	081305-300789	MUNICIPALIDAD DISTRITAL DE MARAS	\N	\N	32
1005	081306-300790	MUNICIPALIDAD DISTRITAL DE OLLANTAYTAMBO	\N	\N	32
1006	081307-300791	MUNICIPALIDAD DISTRITAL DE YUCAY	\N	\N	32
1007	090101-300792	MUNICIPALIDAD PROVINCIAL DE HUANCAVELICA	\N	\N	32
1008	090102-300793	MUNICIPALIDAD DISTRITAL DE ACOBAMBILLA	\N	\N	32
1009	090103-300794	MUNICIPALIDAD DISTRITAL DE ACORIA	\N	\N	32
1010	090104-300795	MUNICIPALIDAD DISTRITAL DE CONAYCA	\N	\N	32
1011	090105-300796	MUNICIPALIDAD DISTRITAL DE CUENCA	\N	\N	32
1012	090106-300797	MUNICIPALIDAD DISTRITAL DE HUACHOCOLPA	\N	\N	32
1013	090107-300798	MUNICIPALIDAD DISTRITAL DE HUAYLLAHUARA	\N	\N	32
1014	090108-300799	MUNICIPALIDAD DISTRITAL DE IZCUCHACA	\N	\N	32
1015	090109-300800	MUNICIPALIDAD DISTRITAL DE LARIA	\N	\N	32
1016	090110-300801	MUNICIPALIDAD DISTRITAL DE MANTA	\N	\N	32
1017	090111-300802	MUNICIPALIDAD DISTRITAL DE MARISCAL CÁCERES	\N	\N	32
1018	090112-300803	MUNICIPALIDAD DISTRITAL DE MOYA	\N	\N	32
1019	090113-300804	MUNICIPALIDAD DISTRITAL DE NUEVO OCCORO	\N	\N	32
1020	090114-300805	MUNICIPALIDAD DISTRITAL DE PALCA	\N	\N	32
1021	090115-300806	MUNICIPALIDAD DISTRITAL DE PILCHACA	\N	\N	32
1022	090116-300807	MUNICIPALIDAD DISTRITAL DE VILCA	\N	\N	32
1023	090117-300808	MUNICIPALIDAD DISTRITAL DE YAULI	\N	\N	32
1024	090118-301831	MUNICIPALIDAD DISTRITAL ASCENSION	\N	\N	32
1025	090119-300875	MUNICIPALIDAD DISTRITAL DE HUANDO	\N	\N	32
1026	090201-300809	MUNICIPALIDAD PROVINCIAL DE ACOBAMBA	\N	\N	32
1027	090202-300810	MUNICIPALIDAD DISTRITAL DE ANDABAMBA	\N	\N	32
1028	090203-300811	MUNICIPALIDAD DISTRITAL DE ANTA	\N	\N	32
1029	090204-300812	MUNICIPALIDAD DISTRITAL DE CAJA	\N	\N	32
1030	090205-300813	MUNICIPALIDAD DISTRITAL DE MARCAS	\N	\N	32
1031	090206-300814	MUNICIPALIDAD DISTRITAL DE PAUCARA	\N	\N	32
1032	090207-300815	MUNICIPALIDAD DISTRITAL DE POMACOCHA	\N	\N	32
1033	090208-300816	MUNICIPALIDAD DISTRITAL DE ROSARIO	\N	\N	32
1034	090301-300817	MUNICIPALIDAD PROVINCIAL DE ANGARAES - LIRCAY	\N	\N	32
1035	090302-300818	MUNICIPALIDAD DISTRITAL DE ANCHONGA	\N	\N	32
1036	090303-300819	MUNICIPALIDAD DISTRITAL DE CALLANMARCA	\N	\N	32
1037	090304-300820	MUNICIPALIDAD DISTRITAL DE CCOCHACCASA	\N	\N	32
1038	090305-300821	MUNICIPALIDAD DISTRITAL DE CHINCHO	\N	\N	32
1039	090306-300822	MUNICIPALIDAD DISTRITAL DE CONGALLA	\N	\N	32
1040	090307-300823	MUNICIPALIDAD DISTRITAL DE HUANCA HUANCA	\N	\N	32
1041	090308-300824	MUNICIPALIDAD DISTRITAL DE HUAYLLAY GRANDE	\N	\N	32
1042	090309-300825	MUNICIPALIDAD DISTRITAL DE JULCAMARCA	\N	\N	32
1043	090310-300826	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO DE ANTAPARCO	\N	\N	32
1044	090311-300827	MUNICIPALIDAD DISTRITAL DE SANTO TOMAS DE PATA	\N	\N	32
1045	090312-300828	MUNICIPALIDAD DISTRITAL DE SECCLLA	\N	\N	32
1046	090401-300829	MUNICIPALIDAD PROVINCIAL DE CASTROVIRREYNA	\N	\N	32
1047	090402-300830	MUNICIPALIDAD DISTRITAL DE ARMA	\N	\N	32
1048	090403-300831	MUNICIPALIDAD DISTRITAL DE AURAHUA	\N	\N	32
1049	090404-300832	MUNICIPALIDAD DISTRITAL DE CAPILLAS	\N	\N	32
1050	090405-300833	MUNICIPALIDAD DISTRITAL DE CHUPAMARCA	\N	\N	32
1051	090406-300834	MUNICIPALIDAD DISTRITAL DE COCAS	\N	\N	32
1052	090407-300835	MUNICIPALIDAD DISTRITAL DE HUACHOS	\N	\N	32
1053	090408-300836	MUNICIPALIDAD DISTRITAL DE HUAMATAMBO	\N	\N	32
1054	090409-300837	MUNICIPALIDAD DISTRITAL DE MOLLEPAMPA	\N	\N	32
1055	090410-300838	MUNICIPALIDAD DISTRITAL DE SAN JUAN	\N	\N	32
1056	090411-300839	MUNICIPALIDAD DISTRITAL DE SANTA ANA	\N	\N	32
1057	090412-300840	MUNICIPALIDAD DISTRITAL DE TANTARA	\N	\N	32
1058	090413-300841	MUNICIPALIDAD DISTRITAL DE TICRAPO	\N	\N	32
1059	090501-300842	MUNICIPALIDAD PROVINCIAL DE CHURCAMPA	\N	\N	32
1060	090502-300843	MUNICIPALIDAD DISTRITAL DE ANCO	\N	\N	32
1061	090503-300844	MUNICIPALIDAD DISTRITAL DE CHINCHIHUASI	\N	\N	32
1062	090504-300845	MUNICIPALIDAD DISTRITAL DE EL CARMEN	\N	\N	32
1063	090505-300846	MUNICIPALIDAD DISTRITAL DE LA MERCED	\N	\N	32
1064	090506-300847	MUNICIPALIDAD DISTRITAL DE LOCROJA	\N	\N	32
1065	090507-300848	MUNICIPALIDAD DISTRITAL DE PAUCARBAMBA	\N	\N	32
1066	090508-300849	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL DE MAYOCC	\N	\N	32
1067	090509-300850	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE CORIS	\N	\N	32
1068	090510-300851	MUNICIPALIDAD DISTRITAL DE PACHAMARCA	\N	\N	32
1069	090511-301845	MUNICIPALIDAD DISTRITAL DE COSME	\N	\N	32
1070	090601-300852	MUNICIPALIDAD PROVINCIAL DE HUAYTARA	\N	\N	32
1071	090602-300853	MUNICIPALIDAD DISTRITAL DE AYAVI	\N	\N	32
1072	090603-300854	MUNICIPALIDAD DISTRITAL DE CORDOVA	\N	\N	32
1073	090604-300855	MUNICIPALIDAD DISTRITAL DE HUAYACUNDO ARMA	\N	\N	32
1074	090605-300856	MUNICIPALIDAD DISTRITAL DE LARAMARCA	\N	\N	32
1075	090606-300857	MUNICIPALIDAD DISTRITAL DE OCOYO	\N	\N	32
1076	090607-300858	MUNICIPALIDAD DISTRITAL DE PILPICHACA	\N	\N	32
1077	090608-300859	MUNICIPALIDAD DISTRITAL DE QUERCO	\N	\N	32
1078	090609-300860	MUNICIPALIDAD DISTRITAL DE QUITO ARMA	\N	\N	32
1079	090610-300861	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO DE CUSICANCHA	\N	\N	32
1080	090611-300862	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DE SANGAYAICO	\N	\N	32
1081	090612-300863	MUNICIPALIDAD DISTRITAL DE SAN ISIDRO - HUIRPACANCHA	\N	\N	32
1082	090613-300864	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE CHOCORVOS	\N	\N	32
1083	090614-300865	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE QUIRAHUARA	\N	\N	32
1084	090615-300866	MUNICIPALIDAD DISTRITAL DE SANTO DOMINGO DE CAPILLAS	\N	\N	32
1085	090616-300867	MUNICIPALIDAD DISTRITAL DE TAMBO	\N	\N	32
1086	090701-300868	MUNICIPALIDAD PROVINCIAL DE TAYACAJA - PAMPAS	\N	\N	32
1087	090702-300869	MUNICIPALIDAD DISTRITAL DE ACOSTAMBO	\N	\N	32
1088	090703-300870	MUNICIPALIDAD DISTRITAL DE ACRAQUIA	\N	\N	32
1089	090704-300871	MUNICIPALIDAD DISTRITAL DE AHUAYCHA	\N	\N	32
1090	090705-300872	MUNICIPALIDAD DISTRITAL DE COLCABAMBA	\N	\N	32
1091	090706-300873	MUNICIPALIDAD DISTRITAL DE DANIEL HERNANDES	\N	\N	32
1092	090707-300874	MUNICIPALIDAD DISTRITAL DE HUACHOCOLPA	\N	\N	32
1093	090709-300876	MUNICIPALIDAD DISTRITAL DE HUARIBAMBA	\N	\N	32
1094	090710-300877	MUNICIPALIDAD DISTRITAL DE ÑAHUIMPUQUIO	\N	\N	32
1095	090711-300878	MUNICIPALIDAD DISTRITAL DE PAZOS	\N	\N	32
1096	090713-300879	MUNICIPALIDAD DISTRITAL DE QUISHUAR	\N	\N	32
1097	090714-300880	MUNICIPALIDAD DISTRITAL DE SALCABAMBA	\N	\N	32
1098	090715-300881	MUNICIPALIDAD DISTRITAL DE SALCAHUASI	\N	\N	32
1099	090716-300882	MUNICIPALIDAD DISTRITAL DE SAN MARCOS ROCCHAC	\N	\N	32
1100	090717-300883	MUNICIPALIDAD DISTRITAL DE SURCUBAMBA	\N	\N	32
1101	090718-300884	MUNICIPALIDAD DISTRITAL DE TINTAY PUNCU	\N	\N	32
1102	090719-301860	MUNICIPALIDAD DISTRITAL DE QUICHUAS	\N	\N	32
1103	090720-301861	MUNICIPALIDAD DISTRITAL DE ANDAYMARCA	\N	\N	32
1104	090721-301876	MUNICIPALIDAD DISTRITAL DE ROBLE	\N	\N	32
1105	090722-301871	MUNICIPALIDAD DISTRITAL DE PICHOS	\N	\N	32
1106	090723-301883	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE TUCUMA	\N	\N	32
1107	090724-301887	MUNICIPALIDAD DISTRITAL DE LAMBRAS	\N	\N	32
1108	090725-301896	MUNICIPALIDAD DISTRITAL DE COCHABAMBA	\N	\N	32
1109	100101-300885	MUNICIPALIDAD PROVINCIAL DE HUANUCO	\N	\N	32
1110	100102-300886	MUNICIPALIDAD DISTRITAL DE AMARILIS	\N	\N	32
1111	100103-300887	MUNICIPALIDAD DISTRITAL DE CHINCHAO	\N	\N	32
1112	100104-300888	MUNICIPALIDAD DISTRITAL DE CHURUBAMBA	\N	\N	32
1113	100105-300889	MUNICIPALIDAD DISTRITAL DE MARGOS	\N	\N	32
1114	100106-300890	MUNICIPALIDAD DISTRITAL DE QUISQUI	\N	\N	32
1115	100107-300891	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DE CAYRAN	\N	\N	32
1116	100108-300892	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE CHAULAN	\N	\N	32
1117	100109-300893	MUNICIPALIDAD DISTRITAL DE SANTA MARIA DEL VALLE	\N	\N	32
1118	100110-300894	MUNICIPALIDAD DISTRITAL DE YARUMAYO	\N	\N	32
1119	100111-301835	MUNICIPALIDAD DISTRITAL DE PILLCO MARCA	\N	\N	32
1120	100112-301846	MUNICIPALIDAD DISTRITAL DE YACUS	\N	\N	32
1121	100113-301875	MUNICIPALIDAD DISTRITAL DE SAN PABLO DE PILLAO	\N	\N	32
1122	100201-300895	MUNICIPALIDAD PROVINCIAL DE AMBO	\N	\N	32
1123	100202-300896	MUNICIPALIDAD DISTRITAL DE CAYNA	\N	\N	32
1124	100203-300897	MUNICIPALIDAD DISTRITAL DE COLPAS	\N	\N	32
1125	100204-300898	MUNICIPALIDAD DISTRITAL DE CONCHAMARCA	\N	\N	32
1126	100205-300899	MUNICIPALIDAD DISTRITAL DE HUACAR	\N	\N	32
1127	100206-300900	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO	\N	\N	32
1128	100207-300901	MUNICIPALIDAD DISTRITAL DE SAN RAFAEL	\N	\N	32
1129	100208-300902	MUNICIPALIDAD DISTRITAL DE TOMAY KICHWA	\N	\N	32
1130	100301-300903	MUNICIPALIDAD PROVINCIAL DE DOS DE MAYO - LA UNION	\N	\N	32
1131	100307-300904	MUNICIPALIDAD DISTRITAL DE CHUQUIS	\N	\N	32
1132	100311-300905	MUNICIPALIDAD DISTRITAL DE MARIAS	\N	\N	32
1133	100313-300906	MUNICIPALIDAD DISTRITAL DE PACHAS	\N	\N	32
1134	100316-300907	MUNICIPALIDAD DISTRITAL DE QUIVILLA	\N	\N	32
1135	100317-300908	MUNICIPALIDAD DISTRITAL DE RIPAN	\N	\N	32
1136	100321-300909	MUNICIPALIDAD DISTRITAL DE SHUNQUI	\N	\N	32
1137	100322-300910	MUNICIPALIDAD DISTRITAL DE SILLAPATA	\N	\N	32
1138	100323-300911	MUNICIPALIDAD DISTRITAL DE YANAS	\N	\N	32
1139	100401-300912	MUNICIPALIDAD PROVINCIAL DE HUACAYBAMBA	\N	\N	32
1140	100402-300913	MUNICIPALIDAD DISTRITAL DE CANCHABAMBA	\N	\N	32
1141	100403-300914	MUNICIPALIDAD DISTRITAL DE COCHABAMBA	\N	\N	32
1142	100404-300915	MUNICIPALIDAD DISTRITAL DE PINRA	\N	\N	32
1143	100501-300916	MUNICIPALIDAD PROVINCIAL DE HUAMALIES - LLATA	\N	\N	32
1144	100502-300917	MUNICIPALIDAD DISTRITAL DE ARANCAY	\N	\N	32
1145	100503-300918	MUNICIPALIDAD DISTRITAL DE CHAVIN DE PARIARCA	\N	\N	32
1146	100504-300919	MUNICIPALIDAD DISTRITAL DE JACAS GRANDE	\N	\N	32
1147	100505-300920	MUNICIPALIDAD DISTRITAL DE JIRCAN	\N	\N	32
1148	100506-300921	MUNICIPALIDAD DISTRITAL DE MIRAFLORES	\N	\N	32
1149	100507-300922	MUNICIPALIDAD DISTRITAL DE MONZON	\N	\N	32
1150	100508-300923	MUNICIPALIDAD DISTRITAL DE PUNCHAO	\N	\N	32
1151	100509-300924	MUNICIPALIDAD DISTRITAL DE PUÑOS	\N	\N	32
1152	100510-300925	MUNICIPALIDAD DISTRITAL DE SINGA	\N	\N	32
1153	100511-300926	MUNICIPALIDAD DISTRITAL DE TANTAMAYO	\N	\N	32
1154	100601-300927	MUNICIPALIDAD PROVINCIAL DE LEONCIO PRADO - RUPA RUPA	\N	\N	32
1155	100602-300928	MUNICIPALIDAD DISTRITAL DE DANIEL ALOMIA ROBLES	\N	\N	32
1156	100603-300929	MUNICIPALIDAD DISTRITAL DE HERMILIO VALDIZAN	\N	\N	32
1157	100604-300930	MUNICIPALIDAD DISTRITAL DE CRESPO Y CASTILLO	\N	\N	32
1158	100605-300931	MUNICIPALIDAD DISTRITAL DE LUYANDO	\N	\N	32
1159	100606-300932	MUNICIPALIDAD DISTRITAL DE MARIANO DAMASO BERAUN	\N	\N	32
1160	100607-301879	MUNICIPALIDAD DISTRITAL DE PUCAYACU	\N	\N	32
1161	100608-301870	MUNICIPALIDAD DISTRITAL DE CASTILLO GRANDE	\N	\N	32
1162	100609-301881	MUNICIPALIDAD DISTRITAL DE PUEBLO NUEVO	\N	\N	32
1163	100610-301885	MUNICIPALIDAD DISTRITAL DE SANTO DOMINGO DE ANDA	\N	\N	32
1164	100701-300934	MUNICIPALIDAD PROVINCIAL DE MARAÑON - HUACRACHUCO	\N	\N	32
1165	100702-300935	MUNICIPALIDAD DISTRITAL DE CHOLON	\N	\N	32
1166	100703-300936	MUNICIPALIDAD DISTRITAL DE SAN BUENAVENTURA	\N	\N	32
1167	100704-301872	MUNICIPALIDAD DISTRITAL DE LA MORADA	\N	\N	32
1168	100705-301873	MUNICIPALIDAD DISTRITAL DE SANTA ROSA DE ALTO YANAJANCA	\N	\N	32
1169	100801-300937	MUNICIPALIDAD PROVINCIAL DE PACHITEA - PANAO	\N	\N	32
1170	100802-300938	MUNICIPALIDAD DISTRITAL DE CHAGLLA	\N	\N	32
1171	100803-300939	MUNICIPALIDAD DISTRITAL DE MOLINO	\N	\N	32
1172	100804-300940	MUNICIPALIDAD DISTRITAL DE UMARI	\N	\N	32
1173	100901-300941	MUNICIPALIDAD PROVINCIAL DE PUERTO INCA	\N	\N	32
1174	100902-300942	MUNICIPALIDAD DISTRITAL DE CODO DE POZUZO	\N	\N	32
1175	100903-300943	MUNICIPALIDAD DISTRITAL DE HONORIA	\N	\N	32
1176	100904-300944	MUNICIPALIDAD DISTRITAL DE TOURNAVISTA	\N	\N	32
1177	100905-300945	MUNICIPALIDAD DISTRITAL DE YUYAPICHIS	\N	\N	32
1178	101001-300946	MUNICIPALIDAD PROVINCIAL DE LAURICOCHA - JESUS	\N	\N	32
1179	101002-300947	MUNICIPALIDAD DISTRITAL DE BAÑOS	\N	\N	32
1180	101003-300948	MUNICIPALIDAD DISTRITAL DE JIVIA	\N	\N	32
1181	101004-300949	MUNICIPALIDAD DISTRITAL DE QUEROPALCA	\N	\N	32
1182	101005-300950	MUNICIPALIDAD DISTRITAL DE RONDOS	\N	\N	32
1183	101006-300951	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DE ASIS	\N	\N	32
1184	101007-300952	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL DE CAURI	\N	\N	32
1185	101101-300953	MUNICIPALIDAD PROVINCIAL DE YAROWILCA - CHAVINILLO	\N	\N	32
1186	101102-300954	MUNICIPALIDAD DISTRITAL DE CAHUAC	\N	\N	32
1187	101103-300955	MUNICIPALIDAD DISTRITAL DE CHACABAMBA	\N	\N	32
1188	101104-300956	MUNICIPALIDAD DISTRITAL APARICIO POMARES	\N	\N	32
1189	101105-300957	MUNICIPALIDAD DISTRITAL DE JACAS CHICO	\N	\N	32
1190	101106-300958	MUNICIPALIDAD DISTRITAL DE OBAS	\N	\N	32
1191	101107-300959	MUNICIPALIDAD DISTRITAL DE PAMPAMARCA	\N	\N	32
1192	101108-301839	MUNICIPALIDAD DISTRITAL DE CHORAS	\N	\N	32
1193	110101-300960	MUNICIPALIDAD PROVINCIAL DE ICA	\N	\N	32
1194	110102-300961	MUNICIPALIDAD DISTRITAL DE TINGUIÑA	\N	\N	32
1195	110103-300962	MUNICIPALIDAD DISTRITAL DE LOS AQUIJES	\N	\N	32
1196	110104-300963	MUNICIPALIDAD DISTRITAL DE OCUCAJE	\N	\N	32
1197	110105-300964	MUNICIPALIDAD DISTRITAL DE PACHACUTEC	\N	\N	32
1198	110106-300965	MUNICIPALIDAD DISTRITAL DE PARCONA	\N	\N	32
1199	110107-300966	MUNICIPALIDAD DISTRITAL DE PUEBLO NUEVO	\N	\N	32
1200	110108-300967	MUNICIPALIDAD DISTRITAL DE SALAS	\N	\N	32
1201	110109-300968	MUNICIPALIDAD DISTRITAL DE SAN JOSE DE LOS MOLINOS	\N	\N	32
1202	110110-300969	MUNICIPALIDAD DISTRITAL DE SAN JUAN BAUTISTA	\N	\N	32
1203	110111-300970	MUNICIPALIDAD DISTRITAL DE SANTIAGO	\N	\N	32
1204	110112-300971	MUNICIPALIDAD DISTRITAL DE SUBTANJALLA	\N	\N	32
1205	110113-300972	MUNICIPALIDAD DISTRITAL DE TATE	\N	\N	32
1206	110114-300973	MUNICIPALIDAD DISTRITAL DE YAUCA DEL ROSARIO	\N	\N	32
1207	110201-300974	MUNICIPALIDAD PROVINCIAL DE CHINCHA - CHINCHA ALTA	\N	\N	32
1208	110202-300975	MUNICIPALIDAD DISTRITAL DE ALTO LARAN	\N	\N	32
1209	110203-300976	MUNICIPALIDAD DISTRITAL DE CHAVIN	\N	\N	32
1210	110204-300977	MUNICIPALIDAD DISTRITAL DE CHINCHA BAJA	\N	\N	32
1211	110205-300978	MUNICIPALIDAD DISTRITAL DE EL CARMEN	\N	\N	32
1212	110206-300979	MUNICIPALIDAD DISTRITAL DE GROCIO PRADO	\N	\N	32
1213	110207-300980	MUNICIPALIDAD DISTRITAL DE PUEBLO NUEVO	\N	\N	32
1214	110208-300981	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE YANAC	\N	\N	32
1215	110209-300982	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE HUACARPANA	\N	\N	32
1216	110210-300983	MUNICIPALIDAD DISTRITAL DE SUNAMPE	\N	\N	32
1217	110211-300984	MUNICIPALIDAD DISTRITAL DE TAMBO DE MORA	\N	\N	32
1218	110301-300985	MUNICIPALIDAD PROVINCIAL DE NASCA	\N	\N	32
1219	110302-300986	MUNICIPALIDAD DISTRITAL DE CHANGUILLO	\N	\N	32
1220	110303-300987	MUNICIPALIDAD DISTRITAL DE EL INGENIO	\N	\N	32
1221	110304-300988	MUNICIPALIDAD DISTRITAL DE MARCONA	\N	\N	32
1222	110305-300989	MUNICIPALIDAD DISTRITAL DE VISTA ALEGRE	\N	\N	32
1223	110401-300990	MUNICIPALIDAD PROVINCIAL DE PALPA	\N	\N	32
1224	110402-300991	MUNICIPALIDAD DISTRITAL DE LLIPATA	\N	\N	32
1225	110403-300992	MUNICIPALIDAD DISTRITAL DE RIO GRANDE	\N	\N	32
1226	110404-300993	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ	\N	\N	32
1227	110405-300994	MUNICIPALIDAD DISTRITAL DE TIBILLO	\N	\N	32
1228	110501-300995	MUNICIPALIDAD PROVINCIAL DE PISCO	\N	\N	32
1229	110502-300996	MUNICIPALIDAD DISTRITAL DE HUANCANO	\N	\N	32
1230	110503-300997	MUNICIPALIDAD DISTRITAL DE HUMAY	\N	\N	32
1231	110504-300998	MUNICIPALIDAD DISTRITAL DE INDEPENDENCIA	\N	\N	32
1232	110505-300999	MUNICIPALIDAD DISTRITAL DE PARACAS	\N	\N	32
1233	110506-301000	MUNICIPALIDAD DISTRITAL DE SAN ANDRES	\N	\N	32
1234	110507-301001	MUNICIPALIDAD DISTRITAL DE SAN CLEMENTE	\N	\N	32
1235	110508-301002	MUNICIPALIDAD DISTRITAL DE TUPAC AMARU INCA	\N	\N	32
1236	120101-301003	MUNICIPALIDAD PROVINCIAL DE HUANCAYO	\N	\N	32
1237	120104-301004	MUNICIPALIDAD DISTRITAL DE CARHUACALLANGA	\N	\N	32
1238	120105-301005	MUNICIPALIDAD DISTRITAL DE CHACAPAMPA	\N	\N	32
1239	120106-301006	MUNICIPALIDAD DISTRITAL DE CHICCHE	\N	\N	32
1240	120107-301007	MUNICIPALIDAD DISTRITAL DE CHILCA	\N	\N	32
1241	120108-301008	MUNICIPALIDAD DISTRITAL DE CHONGOS ALTO	\N	\N	32
1242	120111-301009	MUNICIPALIDAD DISTRITAL DE CHUPURO	\N	\N	32
1243	120112-301010	MUNICIPALIDAD DISTRITAL DE COLCA	\N	\N	32
1244	120113-301011	MUNICIPALIDAD DISTRITAL DE CULLHUAS	\N	\N	32
1245	120114-301012	MUNICIPALIDAD DISTRITAL DE EL TAMBO	\N	\N	32
1246	120116-301013	MUNICIPALIDAD DISTRITAL DE HUACRAPUQUIO	\N	\N	32
1247	120117-301014	MUNICIPALIDAD DISTRITAL DE HUALHUAS	\N	\N	32
1248	120119-301015	MUNICIPALIDAD DISTRITAL DE HUANCAN	\N	\N	32
1249	120120-301016	MUNICIPALIDAD DISTRITAL DE HUASICANCHA	\N	\N	32
1250	120121-301017	MUNICIPALIDAD DISTRITAL DE HUAYUCACHI	\N	\N	32
1251	120122-301018	MUNICIPALIDAD DISTRITAL DE INGENIO	\N	\N	32
1252	120124-301019	MUNICIPALIDAD DISTRITAL DE PARIAHUANCA	\N	\N	32
1253	120125-301020	MUNICIPALIDAD DISTRITAL DE PILCOMAYO	\N	\N	32
1254	120126-301021	MUNICIPALIDAD DISTRITAL DE PUCARA	\N	\N	32
1255	120127-301022	MUNICIPALIDAD DISTRITAL DE QUICHUAY	\N	\N	32
1256	120128-301023	MUNICIPALIDAD DISTRITAL DE QUILCAS	\N	\N	32
1257	120129-301024	MUNICIPALIDAD DISTRITAL DE SAN AGUSTIN	\N	\N	32
1258	120130-301025	MUNICIPALIDAD DISTRITAL DE SAN JERONIMO DE TUNAN	\N	\N	32
1259	120132-301026	MUNICIPALIDAD DISTRITAL DE SAÑO	\N	\N	32
1260	120133-301027	MUNICIPALIDAD DISTRITAL DE SAPALLANGA	\N	\N	32
1261	120134-301028	MUNICIPALIDAD DISTRITAL DE SICAYA	\N	\N	32
1262	120135-301029	MUNICIPALIDAD DISTRITAL DE SANTO DOMINGO DE ACOBAMBA	\N	\N	32
1263	120136-301030	MUNICIPALIDAD DISTRITAL DE VIQUES	\N	\N	32
1264	120201-301031	MUNICIPALIDAD PROVINCIAL DE CONCEPCION	\N	\N	32
1265	120202-301032	MUNICIPALIDAD DISTRITAL DE ACO	\N	\N	32
1266	120203-301033	MUNICIPALIDAD DISTRITAL DE ANDAMARCA	\N	\N	32
1267	120204-301034	MUNICIPALIDAD DISTRITAL DE CHAMBARA	\N	\N	32
1268	120205-301035	MUNICIPALIDAD DISTRITAL DE COCHAS	\N	\N	32
1269	120206-301036	MUNICIPALIDAD DISTRITAL DE COMAS	\N	\N	32
1270	120207-301037	MUNICIPALIDAD DISTRITAL DE HEROINAS TOLEDO	\N	\N	32
1271	120208-301038	MUNICIPALIDAD DISTRITAL DE MANZANARES	\N	\N	32
1272	120209-301039	MUNICIPALIDAD DISTRITAL DE MARISCAL CASTILLA	\N	\N	32
1273	120210-301040	MUNICIPALIDAD DISTRITAL DE MATAHUASI	\N	\N	32
1274	120211-301041	MUNICIPALIDAD DISTRITAL DE MITO	\N	\N	32
1275	120212-301042	MUNICIPALIDAD DISTRITAL DE NUEVE DE JULIO	\N	\N	32
1276	120213-301043	MUNICIPALIDAD DISTRITAL DE ORCOTUNA	\N	\N	32
1277	120214-301044	MUNICIPALIDAD DISTRITAL DE SAN JOSE DE QUERO	\N	\N	32
1278	120215-301045	MUNICIPALIDAD DISTRITAL DE SANTA ROSA DE OCOPA	\N	\N	32
1279	120301-301046	MUNICIPALIDAD PROVINCIAL DE CHANCHAMAYO	\N	\N	32
1280	120302-301047	MUNICIPALIDAD DISTRITAL DE PERENE	\N	\N	32
1281	120303-301048	MUNICIPALIDAD DISTRITAL DE PICHANAQUI	\N	\N	32
1282	120304-301049	MUNICIPALIDAD DISTRITAL DE SAN LUIS DE SHUARO	\N	\N	32
1283	120305-301050	MUNICIPALIDAD DISTRITAL DE SAN RAMON	\N	\N	32
1284	120306-301051	MUNICIPALIDAD DISTRITAL DE VITOC	\N	\N	32
1285	120401-301052	MUNICIPALIDAD PROVINCIAL DE JAUJA	\N	\N	32
1286	120402-301053	MUNICIPALIDAD DISTRITAL DE ACOLLA	\N	\N	32
1287	120403-301054	MUNICIPALIDAD DISTRITAL DE APATA	\N	\N	32
1288	120404-301055	MUNICIPALIDAD DISTRITAL DE ATAURA	\N	\N	32
1289	120405-301056	MUNICIPALIDAD DISTRITAL DE CANCHAYLLO	\N	\N	32
1290	120406-301057	MUNICIPALIDAD DISTRITAL DE CURICACA	\N	\N	32
1291	120407-301058	MUNICIPALIDAD DISTRITAL DE EL MANTARO	\N	\N	32
1292	120408-301059	MUNICIPALIDAD DISTRITAL DE HUAMALI	\N	\N	32
1293	120409-301060	MUNICIPALIDAD DISTRITAL DE HUARIPAMPA	\N	\N	32
1294	120410-301061	MUNICIPALIDAD DISTRITAL DE HUERTAS	\N	\N	32
1295	120411-301062	MUNICIPALIDAD DISTRITAL DE JANJAILLO	\N	\N	32
1296	120412-301063	MUNICIPALIDAD DISTRITAL DE JULCAN	\N	\N	32
1297	120413-301064	MUNICIPALIDAD DISTRITAL DE LEONOR ORDO¥EZ	\N	\N	32
1298	120414-301065	MUNICIPALIDAD DISTRITAL DE LLOCLLAPAMPA	\N	\N	32
1299	120415-301066	MUNICIPALIDAD DISTRITAL DE MARCO	\N	\N	32
1300	120416-301067	MUNICIPALIDAD DISTRITAL DE MASMA	\N	\N	32
1301	120417-301068	MUNICIPALIDAD DISTRITAL DE MASMA CHICCHE	\N	\N	32
1302	120418-301069	MUNICIPALIDAD DISTRITAL DE MOLINOS	\N	\N	32
1303	120419-301070	MUNICIPALIDAD DISTRITAL DE MONOBAMBA	\N	\N	32
1304	120420-301071	MUNICIPALIDAD DISTRITAL DE MUQUI	\N	\N	32
1305	120421-301072	MUNICIPALIDAD DISTRITAL DE MUQUIYAUYO	\N	\N	32
1306	120422-301073	MUNICIPALIDAD DISTRITAL DE PACA	\N	\N	32
1307	120423-301074	MUNICIPALIDAD DISTRITAL DE PACCHA	\N	\N	32
1308	120424-301075	MUNICIPALIDAD DISTRITAL DE PANCAN	\N	\N	32
1309	120425-301076	MUNICIPALIDAD DISTRITAL DE PARCO	\N	\N	32
1310	120426-301077	MUNICIPALIDAD DISTRITAL DE POMACANCHA	\N	\N	32
1311	120427-301078	MUNICIPALIDAD DISTRITAL DE RICRAN	\N	\N	32
1312	120428-301079	MUNICIPALIDAD DISTRITAL DE SAN LORENZO	\N	\N	32
1313	120429-301080	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE CHUNAN	\N	\N	32
1314	120430-301081	MUNICIPALIDAD DISTRITAL DE SAUSA	\N	\N	32
1315	120431-301082	MUNICIPALIDAD DISTRITAL DE SINCOS	\N	\N	32
1316	120432-301083	MUNICIPALIDAD DISTRITAL DE TUNAN MARCA	\N	\N	32
1317	120433-301084	MUNICIPALIDAD DISTRITAL DE YAULI	\N	\N	32
1318	120434-301085	MUNICIPALIDAD DISTRITAL DE YAUYOS	\N	\N	32
1319	120501-301086	MUNICIPALIDAD PROVINCIAL DE JUNIN	\N	\N	32
1320	120502-301087	MUNICIPALIDAD DISTRITAL DE CARHUAMAYO	\N	\N	32
1321	120503-301088	MUNICIPALIDAD DISTRITAL DE ONDORES	\N	\N	32
1322	120504-301089	MUNICIPALIDAD DISTRITAL DE ULCUMAYO	\N	\N	32
1323	120601-301090	MUNICIPALIDAD PROVINCIAL DE SATIPO	\N	\N	32
1324	120602-301091	MUNICIPALIDAD DISTRITAL DE COVIRIALI	\N	\N	32
1325	120603-301092	MUNICIPALIDAD DISTRITAL DE LLAYLLA	\N	\N	32
1326	120604-301093	MUNICIPALIDAD DISTRITAL DE MAZAMARI	\N	\N	32
1327	120605-301094	MUNICIPALIDAD DISTRITAL PAMPA HERMOSA	\N	\N	32
1328	120606-301095	MUNICIPALIDAD DISTRITAL DE PANGOA	\N	\N	32
1329	120607-301096	MUNICIPALIDAD DISTRITAL DE RIO NEGRO	\N	\N	32
1330	120608-301097	MUNICIPALIDAD DISTRITAL DE RIO TAMBO	\N	\N	32
1331	120609-301868	MUNICIPALIDAD DISTRITAL DE VIZCATAN DEL ENE	\N	\N	32
1332	120701-301098	MUNICIPALIDAD PROVINCIAL DE TARMA	\N	\N	32
1333	120702-301099	MUNICIPALIDAD DISTRITAL DE ACOBAMBA	\N	\N	32
1334	120703-301100	MUNICIPALIDAD DISTRITAL DE HUARICOLCA	\N	\N	32
1335	120704-301101	MUNICIPALIDAD DISTRITAL DE HUASAHUASI	\N	\N	32
1336	120705-301102	MUNICIPALIDAD DISTRITAL DE LA UNION	\N	\N	32
1337	120706-301103	MUNICIPALIDAD DISTRITAL DE PALCA	\N	\N	32
1338	120707-301104	MUNICIPALIDAD DISTRITAL DE PALCAMAYO	\N	\N	32
1339	120708-301105	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE CAJAS	\N	\N	32
1340	120709-301106	MUNICIPALIDAD DISTRITAL DE TAPO	\N	\N	32
1341	120801-301108	MUNICIPALIDAD PROVINCIAL DE YAULI - LA OROYA	\N	\N	32
1342	120802-301109	MUNICIPALIDAD DISTRITAL DE CHACAPALPA	\N	\N	32
1343	120803-301110	MUNICIPALIDAD DISTRITAL DE HUAY - HUAY	\N	\N	32
1344	120804-301111	MUNICIPALIDAD DISTRITAL DE MARCAPOMACOCHA	\N	\N	32
1345	120805-301112	MUNICIPALIDAD DISTRITAL DE MOROCOCHA	\N	\N	32
1346	120806-301113	MUNICIPALIDAD DISTRITAL DE PACCHA	\N	\N	32
1347	120807-301114	MUNICIPALIDAD DISTRITAL DE SANTA BARBARA DE CARHUACAYAN	\N	\N	32
1348	120808-301115	MUNICIPALIDAD DISTRITAL DE SANTA ROSA DE SACCO	\N	\N	32
1349	120809-301116	MUNICIPALIDAD DISTRITAL DE SUITUCANCHA	\N	\N	32
1350	120810-301117	MUNICIPALIDAD DISTRITAL DE YAULI	\N	\N	32
1351	120901-301118	MUNICIPALIDAD PROVINCIAL DE CHUPACA	\N	\N	32
1352	120902-301119	MUNICIPALIDAD DISTRITAL DE AHUAC	\N	\N	32
1353	120903-301120	MUNICIPALIDAD DISTRITAL DE CHONGOS BAJO	\N	\N	32
1354	120904-301121	MUNICIPALIDAD DISTRITAL DE HUACHAC	\N	\N	32
1355	120905-301122	MUNICIPALIDAD DISTRITAL DE HUAMANCACA CHICO	\N	\N	32
1356	120906-301123	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE ISCOS	\N	\N	32
1357	120907-301124	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE JARPA	\N	\N	32
1358	120908-301125	MUNICIPALIDAD DISTRITAL DE TRES DE DICIEMBRE	\N	\N	32
1359	120909-301126	MUNICIPALIDAD DISTRITAL DE YANACANCHA	\N	\N	32
1360	130101-301127	MUNICIPALIDAD PROVINCIAL DE TRUJILLO	\N	\N	32
1361	130102-301128	MUNICIPALIDAD DISTRITAL DE EL PORVENIR	\N	\N	32
1362	130103-301129	MUNICIPALIDAD DISTRITAL DE FLORENCIA DE MORA	\N	\N	32
1363	130104-301130	MUNICIPALIDAD DISTRITAL DE HUANCHACO	\N	\N	32
1364	130105-301131	MUNICIPALIDAD DISTRITAL DE LA ESPERANZA	\N	\N	32
1365	130106-301132	MUNICIPALIDAD DISTRITAL DE LAREDO	\N	\N	32
1366	130107-301133	MUNICIPALIDAD DISTRITAL DE MOCHE	\N	\N	32
1367	130108-301134	MUNICIPALIDAD DISTRITAL DE POROTO	\N	\N	32
1368	130109-301135	MUNICIPALIDAD DISTRITAL DE SALAVERRY	\N	\N	32
1369	130110-301136	MUNICIPALIDAD DISTRITAL DE SIMBAL	\N	\N	32
1370	130111-301137	MUNICIPALIDAD DISTRITAL DE VICTOR LARCO HERRERA	\N	\N	32
1371	130112-301903	MUNICIPALIDAD DISTRITAL DE ALTO TRUJILLO	\N	\N	32
1372	130201-301140	MUNICIPALIDAD PROVINCIAL DE ASCOPE	\N	\N	32
1373	130202-301141	MUNICIPALIDAD DISTRITAL DE CHICAMA	\N	\N	32
1374	130203-301142	MUNICIPALIDAD DISTRITAL DE CHOCOPE	\N	\N	32
1375	130204-301143	MUNICIPALIDAD DISTRITAL DE MAGDALENA DE CAO	\N	\N	32
1376	130205-301144	MUNICIPALIDAD DISTRITAL DE PAIJAN	\N	\N	32
1377	130206-301145	MUNICIPALIDAD DISTRITAL DE RAZURI	\N	\N	32
1378	130207-301146	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE CAO	\N	\N	32
1379	130208-301147	MUNICIPALIDAD DISTRITAL DE CASA GRANDE	\N	\N	32
1380	130301-301148	MUNICIPALIDAD PROVINCIAL DE BOLIVAR	\N	\N	32
1381	130302-301149	MUNICIPALIDAD DISTRITAL DE BAMBAMARCA	\N	\N	32
1382	130303-301150	MUNICIPALIDAD DISTRITAL DE CONDORMARCA	\N	\N	32
1383	130304-301151	MUNICIPALIDAD DISTRITAL DE LONGOTEA	\N	\N	32
1384	130305-301152	MUNICIPALIDAD DISTRITAL DE UCHUMARCA	\N	\N	32
1385	130306-301153	MUNICIPALIDAD DISTRITAL DE UCUNCHA	\N	\N	32
1386	130401-301154	MUNICIPALIDAD PROVINCIAL DE CHEPEN	\N	\N	32
1387	130402-301155	MUNICIPALIDAD DISTRITAL DE PACANGA	\N	\N	32
1388	130403-301156	MUNICIPALIDAD DISTRITAL DE PUEBLO NUEVO	\N	\N	32
1389	130501-301157	MUNICIPALIDAD PROVINCIAL DE JULCAN	\N	\N	32
1390	130502-301158	MUNICIPALIDAD DISTRITAL DE CALAMARCA	\N	\N	32
1391	130503-301159	MUNICIPALIDAD DISTRITAL DE CARABAMBA	\N	\N	32
1392	130504-301160	MUNICIPALIDAD DISTRITAL DE HUASO	\N	\N	32
1393	130601-301161	MUNICIPALIDAD PROVINCIAL DE OTUZCO	\N	\N	32
1394	130602-301162	MUNICIPALIDAD DISTRITAL DE AGALLPAMPA	\N	\N	32
1395	130604-301163	MUNICIPALIDAD DISTRITAL DE CHARAT	\N	\N	32
1396	130605-301164	MUNICIPALIDAD DISTRITAL DE HUARANCHAL	\N	\N	32
1397	130606-301165	MUNICIPALIDAD DISTRITAL DE LA CUESTA	\N	\N	32
1398	130608-301166	MUNICIPALIDAD DISTRITAL DE MACHE	\N	\N	32
1399	130610-301167	MUNICIPALIDAD DISTRITAL DE PARANDAY	\N	\N	32
1400	130611-301168	MUNICIPALIDAD DISTRITAL DE SALPO	\N	\N	32
1401	130613-301169	MUNICIPALIDAD DISTRITAL DE SINSICAP	\N	\N	32
1402	130614-301170	MUNICIPALIDAD DISTRITAL DE USQUIL	\N	\N	32
1403	130701-301171	MUNICIPALIDAD PROVINCIAL DE PACASMAYO - SAN PEDRO DE LLOC	\N	\N	32
1404	130702-301172	MUNICIPALIDAD DISTRITAL DE GUADALUPE	\N	\N	32
1405	130703-301173	MUNICIPALIDAD DISTRITAL DE JEQUETEPEQUE	\N	\N	32
1406	130704-301174	MUNICIPALIDAD DISTRITAL DE PACASMAYO	\N	\N	32
1407	130705-301175	MUNICIPALIDAD DISTRITAL DE SAN JOSE	\N	\N	32
1408	130801-301176	MUNICIPALIDAD PROVINCIAL DE PATAZ - TAYABAMBA	\N	\N	32
1409	130802-301177	MUNICIPALIDAD DISTRITAL DE BULDIBUYO	\N	\N	32
1410	130803-301178	MUNICIPALIDAD DISTRITAL DE CHILLIA	\N	\N	32
1411	130804-301179	MUNICIPALIDAD DISTRITAL DE HUANCASPATA	\N	\N	32
1412	130805-301180	MUNICIPALIDAD DISTRITAL DE HUAYLILLAS	\N	\N	32
1413	130806-301181	MUNICIPALIDAD DISTRITAL DE HUAYO	\N	\N	32
1414	130807-301182	MUNICIPALIDAD DISTRITAL DE ONGON	\N	\N	32
1415	130808-301183	MUNICIPALIDAD DISTRITAL DE PARCOY	\N	\N	32
1416	130809-301184	MUNICIPALIDAD DISTRITAL DE PATAZ	\N	\N	32
1417	130810-301185	MUNICIPALIDAD DISTRITAL DE PIAS	\N	\N	32
1418	130811-301186	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE CHALLAS	\N	\N	32
1419	130812-301187	MUNICIPALIDAD DISTRITAL DE TAURIJA	\N	\N	32
1420	130813-301188	MUNICIPALIDAD DISTRITAL DE URPAY	\N	\N	32
1421	130901-301189	MUNICIPALIDAD PROVINCIAL DE SANCHEZ CARRION - HUAMACHUCO	\N	\N	32
1422	130902-301190	MUNICIPALIDAD DISTRITAL DE CHUGAY	\N	\N	32
1423	130903-301191	MUNICIPALIDAD DISTRITAL DE COCHORCO	\N	\N	32
1424	130904-301192	MUNICIPALIDAD DISTRITAL DE CURGOS	\N	\N	32
1425	130905-301193	MUNICIPALIDAD DISTRITAL DE MARCABAL	\N	\N	32
1426	130906-301194	MUNICIPALIDAD DISTRITAL DE SANAGORAN	\N	\N	32
1427	130907-301195	MUNICIPALIDAD DISTRITAL DE SARIN	\N	\N	32
1428	130908-301196	MUNICIPALIDAD DISTRITAL DE SARTIMBAMBA	\N	\N	32
1429	131001-301197	MUNICIPALIDAD PROVINCIAL DE SANTIAGO DE CHUCO	\N	\N	32
1430	131002-301198	MUNICIPALIDAD DISTRITAL DE ANGASMARCA	\N	\N	32
1431	131003-301199	MUNICIPALIDAD DISTRITAL DE CACHICADAN	\N	\N	32
1432	131004-301200	MUNICIPALIDAD DISTRITAL DE MOLLEBAMBA	\N	\N	32
1433	131005-301201	MUNICIPALIDAD DISTRITAL DE MOLLEPATA	\N	\N	32
1434	131006-301202	MUNICIPALIDAD DISTRITAL DE QUIRUVILCA	\N	\N	32
1435	131007-301203	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ DE CHUCA	\N	\N	32
1436	131008-301204	MUNICIPALIDAD DISTRITAL DE SITABAMBA	\N	\N	32
1437	131101-301205	MUNICIPALIDAD PROVINCIAL GRAN CHIMU - CASCAS	\N	\N	32
1438	131102-301206	MUNICIPALIDAD DISTRITAL DE LUCMA	\N	\N	32
1439	131103-301207	MUNICIPALIDAD DISTRITAL DE MARMOT	\N	\N	32
1440	131104-301208	MUNICIPALIDAD DISTRITAL DE SAYAPULLO	\N	\N	32
1441	131201-301209	MUNICIPALIDAD PROVINCIAL DE VIRU	\N	\N	32
1442	131202-301210	MUNICIPALIDAD DISTRITAL DE CHAO	\N	\N	32
1443	131203-301211	MUNICIPALIDAD DISTRITAL DE GUADALUPITO	\N	\N	32
1444	140101-301212	MUNICIPALIDAD PROVINCIAL DE CHICLAYO	\N	\N	32
1445	140102-301213	MUNICIPALIDAD DISTRITAL DE CHONGOYAPE	\N	\N	32
1446	140103-301214	MUNICIPALIDAD DISTRITAL DE ETEN	\N	\N	32
1447	140104-301215	MUNICIPALIDAD DISTRITAL DE ETEN PUERTO	\N	\N	32
1448	140105-301216	MUNICIPALIDAD DISTRITAL DE JOSE LEONARDO ORTIZ	\N	\N	32
1449	140106-301217	MUNICIPALIDAD DISTRITAL DE LA VICTORIA	\N	\N	32
1450	140107-301218	MUNICIPALIDAD DISTRITAL DE LAGUNAS	\N	\N	32
1451	140108-301219	MUNICIPALIDAD DISTRITAL DE MONSEFU	\N	\N	32
1452	140109-301220	MUNICIPALIDAD DISTRITAL DE NUEVA ARICA	\N	\N	32
1453	140110-301221	MUNICIPALIDAD DISTRITAL DE OYOTUN	\N	\N	32
1454	140111-301222	MUNICIPALIDAD DISTRITAL DE PICSI	\N	\N	32
1455	140112-301223	MUNICIPALIDAD DISTRITAL DE PIMENTEL	\N	\N	32
1456	140113-301224	MUNICIPALIDAD DISTRITAL DE REQUE	\N	\N	32
1457	140114-301225	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
1458	140115-301226	MUNICIPALIDAD DISTRITAL DE ZAÑA	\N	\N	32
1459	140116-301227	MUNICIPALIDAD DISTRITAL DE CAYALTI	\N	\N	32
1460	140117-301228	MUNICIPALIDAD DISTRITAL DE PATAPO	\N	\N	32
1461	140118-301229	MUNICIPALIDAD DISTRITAL DE POMALCA	\N	\N	32
1462	140119-301230	MUNICIPALIDAD DISTRITAL DE PUCALA	\N	\N	32
1463	140120-301231	MUNICIPALIDAD DISTRITAL DE TUMAN	\N	\N	32
1464	140201-301232	MUNICIPALIDAD PROVINCIAL DE FERREÑAFE	\N	\N	32
1465	140202-301233	MUNICIPALIDAD DISTRITAL DE KAÑARIS	\N	\N	32
1466	140203-301234	MUNICIPALIDAD DISTRITAL DE INCAHUASI	\N	\N	32
1467	140204-301235	MUNICIPALIDAD DISTRITAL DE MANUEL ANTONIO MESONES MURO	\N	\N	32
1468	140205-301236	MUNICIPALIDAD DISTRITAL DE PITIPO	\N	\N	32
1469	140206-301237	MUNICIPALIDAD DISTRITAL DE PUEBLO NUEVO	\N	\N	32
1470	140301-301238	MUNICIPALIDAD PROVINCIAL DE LAMBAYEQUE	\N	\N	32
1471	140302-301239	MUNICIPALIDAD DISTRITAL DE CHOCHOPE	\N	\N	32
1472	140303-301240	MUNICIPALIDAD DISTRITAL DE ILLIMO	\N	\N	32
1473	140304-301241	MUNICIPALIDAD DISTRITAL DE JAYANCA	\N	\N	32
1474	140305-301242	MUNICIPALIDAD DISTRITAL DE MOCHUMI	\N	\N	32
1475	140306-301243	MUNICIPALIDAD DISTRITAL DE MORROPE	\N	\N	32
1476	140307-301244	MUNICIPALIDAD DISTRITAL DE MOTUPE	\N	\N	32
1477	140308-301245	MUNICIPALIDAD DISTRITAL DE OLMOS	\N	\N	32
1478	140309-301246	MUNICIPALIDAD DISTRITAL DE PACORA	\N	\N	32
1479	140310-301247	MUNICIPALIDAD DISTRITAL DE SALAS	\N	\N	32
1480	140311-301248	MUNICIPALIDAD DISTRITAL DE SAN JOSE	\N	\N	32
1481	140312-301249	MUNICIPALIDAD DISTRITAL DE TUCUME	\N	\N	32
1482	150101-301250	MUNICIPALIDAD METROPOLITANA DE LIMA	\N	\N	32
1483	150102-301251	MUNICIPALIDAD DISTRITAL DE ANCON	\N	\N	32
1484	150103-301252	MUNICIPALIDAD DISTRITAL DE ATE - VITARTE	\N	\N	32
1485	150104-301253	MUNICIPALIDAD DISTRITAL DE BARRANCO	\N	\N	32
1486	150105-301254	MUNICIPALIDAD DISTRITAL DE BREÑA	\N	\N	32
1487	150106-301255	MUNICIPALIDAD DISTRITAL DE CARABAYLLO	\N	\N	32
1488	150107-301256	MUNICIPALIDAD DISTRITAL DE CHACLACAYO	\N	\N	32
1489	150108-301257	MUNICIPALIDAD DISTRITAL DE CHORRILLOS	\N	\N	32
1490	150109-301258	MUNICIPALIDAD DISTRITAL DE CIENEGUILLA	\N	\N	32
1491	150110-301259	MUNICIPALIDAD DISTRITAL DE COMAS	\N	\N	32
1492	150111-301260	MUNICIPALIDAD DISTRITAL DE EL AGUSTINO	\N	\N	32
1493	150112-301261	MUNICIPALIDAD DISTRITAL DE INDEPENDENCIA	\N	\N	32
1494	150113-301262	MUNICIPALIDAD DISTRITAL DE JESUS MARIA	\N	\N	32
1495	150114-301263	MUNICIPALIDAD DISTRITAL DE LA MOLINA	\N	\N	32
1496	150115-301264	MUNICIPALIDAD DISTRITAL DE LA VICTORIA	\N	\N	32
1497	150116-301265	MUNICIPALIDAD DISTRITAL DE LINCE	\N	\N	32
1498	150117-301266	MUNICIPALIDAD DISTRITAL DE LOS OLIVOS	\N	\N	32
1499	150118-301267	MUNICIPALIDAD DISTRITAL DE LURIGANCHO (CHOSICA)	\N	\N	32
1500	150119-301268	MUNICIPALIDAD DISTRITAL DE LURIN	\N	\N	32
1501	150120-301269	MUNICIPALIDAD DISTRITAL DE MAGDALENA DEL MAR	\N	\N	32
1502	150121-301270	MUNICIPALIDAD DISTRITAL DE PUEBLO LIBRE	\N	\N	32
1503	150122-301271	MUNICIPALIDAD DISTRITAL DE MIRAFLORES	\N	\N	32
1504	150123-301272	MUNICIPALIDAD DISTRITAL DE PACHACAMAC	\N	\N	32
1505	150124-301273	MUNICIPALIDAD DISTRITAL DE PUCUSANA	\N	\N	32
1506	150125-301274	MUNICIPALIDAD DISTRITAL DE PUENTE PIEDRA	\N	\N	32
1507	150126-301275	MUNICIPALIDAD DISTRITAL DE PUNTA HERMOSA	\N	\N	32
1508	150127-301276	MUNICIPALIDAD DISTRITAL DE PUNTA NEGRA	\N	\N	32
1509	150128-301277	MUNICIPALIDAD DISTRITAL DE RIMAC	\N	\N	32
1510	150129-301278	MUNICIPALIDAD DISTRITAL DE SAN BARTOLO	\N	\N	32
1511	150130-301279	MUNICIPALIDAD DISTRITAL DE SAN BORJA	\N	\N	32
1512	150131-301280	MUNICIPALIDAD DISTRITAL DE SAN ISIDRO	\N	\N	32
1513	150132-301281	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE LURIGANCHO	\N	\N	32
1514	150133-301282	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE MIRAFLORES	\N	\N	32
1515	150134-301283	MUNICIPALIDAD DISTRITAL DE SAN LUIS	\N	\N	32
1516	150135-301284	MUNICIPALIDAD DISTRITAL DE SAN MARTIN DE PORRES	\N	\N	32
1517	150136-301285	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL	\N	\N	32
1518	150137-301286	MUNICIPALIDAD DISTRITAL DE SANTA ANITA	\N	\N	32
1519	150138-301287	MUNICIPALIDAD DISTRITAL DE SANTA MARIA DEL MAR	\N	\N	32
1520	150139-301288	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
1521	150140-301289	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE SURCO	\N	\N	32
1522	150141-301290	MUNICIPALIDAD DISTRITAL DE SURQUILLO	\N	\N	32
1523	150142-301291	MUNICIPALIDAD DISTRITAL DE VILLA EL SALVADOR	\N	\N	32
1524	150143-301292	MUNICIPALIDAD DISTRITAL DE VILLA MARIA DEL TRIUNFO	\N	\N	32
1525	150201-301294	MUNICIPALIDAD PROVINCIAL DE BARRANCA	\N	\N	32
1526	150202-301295	MUNICIPALIDAD DISTRITAL DE PARAMONGA	\N	\N	32
1527	150203-301296	MUNICIPALIDAD DISTRITAL DE PATIVILCA	\N	\N	32
1528	150204-301297	MUNICIPALIDAD DISTRITAL DE SUPE	\N	\N	32
1529	150205-301298	MUNICIPALIDAD DISTRITAL DE SUPE PUERTO	\N	\N	32
1530	150301-301299	MUNICIPALIDAD PROVINCIAL DE CAJATAMBO	\N	\N	32
1531	150302-301300	MUNICIPALIDAD DISTRITAL DE COPA	\N	\N	32
1532	150303-301301	MUNICIPALIDAD DISTRITAL DE GORGOR	\N	\N	32
1533	150304-301302	MUNICIPALIDAD DISTRITAL DE HUANCAPON	\N	\N	32
1534	150305-301303	MUNICIPALIDAD DISTRITAL DE MANAS	\N	\N	32
1535	150401-301304	MUNICIPALIDAD PROVINCIAL DE CANTA	\N	\N	32
1536	150402-301305	MUNICIPALIDAD DISTRITAL DE ARAHUAY	\N	\N	32
1537	150403-301306	MUNICIPALIDAD DISTRITAL DE HUAMANTANGA	\N	\N	32
1538	150404-301307	MUNICIPALIDAD DISTRITAL DE HUAROS	\N	\N	32
1539	150405-301308	MUNICIPALIDAD DISTRITAL DE LACHAQUI	\N	\N	32
1540	150406-301309	MUNICIPALIDAD DISTRITAL DE SAN BUENAVENTURA	\N	\N	32
1541	150407-301310	MUNICIPALIDAD DISTRITAL DE SANTA ROSA DE QUIVES	\N	\N	32
1542	150501-301311	MUNICIPALIDAD PROVINCIAL DE CAÑETE - SAN VICENTE DE CAÑETE	\N	\N	32
1543	150502-301312	MUNICIPALIDAD DISTRITAL DE ASIA	\N	\N	32
1544	150503-301313	MUNICIPALIDAD DISTRITAL DE CALANGO	\N	\N	32
1545	150504-301314	MUNICIPALIDAD DISTRITAL DE CERRO AZUL	\N	\N	32
1546	150505-301315	MUNICIPALIDAD DISTRITAL DE CHILCA	\N	\N	32
1547	150506-301316	MUNICIPALIDAD DISTRITAL DE COAYLLO	\N	\N	32
1548	150507-301317	MUNICIPALIDAD DISTRITAL DE IMPERIAL	\N	\N	32
1549	150508-301318	MUNICIPALIDAD DISTRITAL DE LUNAHUANA	\N	\N	32
1550	150509-301319	MUNICIPALIDAD DISTRITAL DE MALA	\N	\N	32
1551	150510-301320	MUNICIPALIDAD DISTRITAL DE NUEVO IMPERIAL	\N	\N	32
1552	150511-301321	MUNICIPALIDAD DISTRITAL DE PACARAN	\N	\N	32
1553	150512-301322	MUNICIPALIDAD DISTRITAL DE QUILMANA	\N	\N	32
1554	150513-301323	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO	\N	\N	32
1555	150514-301324	MUNICIPALIDAD DISTRITAL DE SAN LUIS	\N	\N	32
1556	150515-301325	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ DE FLORES	\N	\N	32
1557	150516-301326	MUNICIPALIDAD DISTRITAL DE ZUÑIGA	\N	\N	32
1558	150601-301327	MUNICIPALIDAD PROVINCIAL DE HUARAL	\N	\N	32
1559	150602-301328	MUNICIPALIDAD DISTRITAL DE ATAVILLOS ALTO	\N	\N	32
1560	150603-301329	MUNICIPALIDAD DISTRITAL DE ATAVILLOS BAJO	\N	\N	32
1561	150604-301330	MUNICIPALIDAD DISTRITAL DE AUCALLAMA	\N	\N	32
1562	150605-301331	MUNICIPALIDAD DISTRITAL DE CHANCAY	\N	\N	32
1563	150606-301332	MUNICIPALIDAD DISTRITAL DE IHUARI	\N	\N	32
1564	150607-301333	MUNICIPALIDAD DISTRITAL DE LAMPIAN	\N	\N	32
1565	150608-301334	MUNICIPALIDAD DISTRITAL DE PACARAOS	\N	\N	32
1566	150609-301335	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL DE ACOS	\N	\N	32
1567	150610-301336	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ DE ANDAMARCA	\N	\N	32
1568	150611-301337	MUNICIPALIDAD DISTRITAL DE SUMBILCA	\N	\N	32
1569	150612-301338	MUNICIPALIDAD DISTRITAL VEINTISIETE DE NOVIEMBRE	\N	\N	32
1570	150701-301339	MUNICIPALIDAD PROVINCIAL DE HUAROCHIRI - MATUCANA	\N	\N	32
1571	150702-301340	MUNICIPALIDAD DISTRITAL DE ANTIOQUIA	\N	\N	32
1572	150703-301341	MUNICIPALIDAD DISTRITAL DE CALLAHUANCA	\N	\N	32
1573	150704-301342	MUNICIPALIDAD DISTRITAL DE CARAMPOMA	\N	\N	32
1574	150705-301343	MUNICIPALIDAD DISTRITAL DE CHICLA	\N	\N	32
1575	150706-301344	MUNICIPALIDAD DISTRITAL DE SAN JOSE DE LOS CHORRILLOS - CUENCA	\N	\N	32
1576	150707-301345	MUNICIPALIDAD DISTRITAL DE HUACHUPAMPA	\N	\N	32
1577	150708-301346	MUNICIPALIDAD DISTRITAL DE HUANZA	\N	\N	32
1578	150709-301347	MUNICIPALIDAD DISTRITAL DE HUAROCHIRI	\N	\N	32
1579	150710-301348	MUNICIPALIDAD DISTRITAL DE LAHUAYTAMBO	\N	\N	32
1580	150711-301349	MUNICIPALIDAD DISTRITAL DE LANGA	\N	\N	32
1581	150712-301350	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE LARAOS	\N	\N	32
1582	150713-301351	MUNICIPALIDAD DISTRITAL DE MARIATANA	\N	\N	32
1583	150714-301352	MUNICIPALIDAD DISTRITAL DE RICARDO PALMA	\N	\N	32
1584	150715-301353	MUNICIPALIDAD DISTRITAL DE SAN ANDRES DE TUPICOCHA	\N	\N	32
1585	150716-301354	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO	\N	\N	32
1586	150717-301355	MUNICIPALIDAD DISTRITAL DE SAN BARTOLOME	\N	\N	32
1587	150718-301356	MUNICIPALIDAD DISTRITAL DE SAN DAMIAN	\N	\N	32
1588	150719-301357	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE IRIS	\N	\N	32
1589	150720-301358	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE TANTARANCHE	\N	\N	32
1590	150721-301359	MUNICIPALIDAD DISTRITAL DE SAN LORENZO DE QUINTI	\N	\N	32
1591	150722-301360	MUNICIPALIDAD DISTRITAL DE SAN MATEO	\N	\N	32
1592	150723-301361	MUNICIPALIDAD DISTRITAL DE SAN MATEO DE OTAO	\N	\N	32
1593	150724-301362	MUNICIPALIDAD DISTRITAL DE CASTA	\N	\N	32
1594	150725-301363	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE HUANCAYRE	\N	\N	32
1595	150726-301364	MUNICIPALIDAD DISTRITAL DE SANGALLAYA	\N	\N	32
1596	150727-301365	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ DE COCACHACRA	\N	\N	32
1597	150728-301366	MUNICIPALIDAD DISTRITAL DE SANTA EULALIA	\N	\N	32
1598	150729-301367	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE ANCHUCAYA	\N	\N	32
1599	150730-301368	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE TUNA	\N	\N	32
1600	150731-301369	MUNICIPALIDAD DISTRITAL DE SANTO DOMINGO DE LOS OLLEROS	\N	\N	32
1601	150732-301370	MUNICIPALIDAD DISTRITAL DE SURCO	\N	\N	32
1602	150801-301371	MUNICIPALIDAD PROVINCIAL DE HUAURA	\N	\N	32
1603	150802-301372	MUNICIPALIDAD DISTRITAL DE AMBAR	\N	\N	32
1604	150803-301373	MUNICIPALIDAD DISTRITAL DE CALETA DE CARQUIN	\N	\N	32
1605	150804-301374	MUNICIPALIDAD DISTRITAL DE CHECRAS	\N	\N	32
1606	150805-301375	MUNICIPALIDAD DISTRITAL DE HUALMAY	\N	\N	32
1607	150806-301376	MUNICIPALIDAD DISTRITAL DE HUAURA	\N	\N	32
1608	150807-301377	MUNICIPALIDAD DISTRITAL DE LEONCIO PRADO	\N	\N	32
1609	150808-301378	MUNICIPALIDAD DISTRITAL DE PACCHO	\N	\N	32
1610	150809-301379	MUNICIPALIDAD DISTRITAL DE SANTA LEONOR	\N	\N	32
1611	150810-301380	MUNICIPALIDAD DISTRITAL DE SANTA MARIA	\N	\N	32
1612	150811-301381	MUNICIPALIDAD DISTRITAL DE SAYAN	\N	\N	32
1613	150812-301382	MUNICIPALIDAD DISTRITAL DE VEGUETA	\N	\N	32
1614	150901-301383	MUNICIPALIDAD PROVINCIAL DE OYON	\N	\N	32
1615	150902-301384	MUNICIPALIDAD DISTRITAL DE ANDAJES	\N	\N	32
1616	150903-301385	MUNICIPALIDAD DISTRITAL DE CAUJUL	\N	\N	32
1617	150904-301386	MUNICIPALIDAD DISTRITAL DE COCHAMARCA	\N	\N	32
1618	150905-301387	MUNICIPALIDAD DISTRITAL DE NAVAN	\N	\N	32
1619	150906-301388	MUNICIPALIDAD DISTRITAL DE PACHANGARA	\N	\N	32
1620	151001-301389	MUNICIPALIDAD PROVINCIAL DE YAUYOS	\N	\N	32
1621	151002-301390	MUNICIPALIDAD DISTRITAL DE ALIS	\N	\N	32
1622	151003-301391	MUNICIPALIDAD DISTRITAL DE AYAUCA	\N	\N	32
1623	151004-301392	MUNICIPALIDAD DISTRITAL DE AYAVIRI	\N	\N	32
1624	151005-301393	MUNICIPALIDAD DISTRITAL DE AZANGARO	\N	\N	32
1625	151006-301394	MUNICIPALIDAD DISTRITAL DE CACRA	\N	\N	32
1626	151007-301395	MUNICIPALIDAD DISTRITAL DE CARANIA	\N	\N	32
1627	151008-301396	MUNICIPALIDAD DISTRITAL DE CATAHUASI	\N	\N	32
1628	151009-301397	MUNICIPALIDAD DISTRITAL DE CHOCOS	\N	\N	32
1629	151010-301398	MUNICIPALIDAD DISTRITAL DE COCHAS	\N	\N	32
1630	151011-301399	MUNICIPALIDAD DISTRITAL DE COLONIA	\N	\N	32
1631	151012-301400	MUNICIPALIDAD DISTRITAL DE HONGOS	\N	\N	32
1632	151013-301401	MUNICIPALIDAD DISTRITAL DE HUAMPARA	\N	\N	32
1633	151014-301402	MUNICIPALIDAD DISTRITAL DE HUANCAYA	\N	\N	32
1634	151015-301403	MUNICIPALIDAD DISTRITAL DE HUANGASCAR	\N	\N	32
1635	151016-301404	MUNICIPALIDAD DISTRITAL DE HUANTAN	\N	\N	32
1636	151017-301405	MUNICIPALIDAD DISTRITAL DE HUAÑEC	\N	\N	32
1637	151018-301406	MUNICIPALIDAD DISTRITAL DE LARAOS	\N	\N	32
1638	151019-301407	MUNICIPALIDAD DISTRITAL DE LINCHA	\N	\N	32
1639	151020-301408	MUNICIPALIDAD DISTRITAL DE MADEAN	\N	\N	32
1640	151021-301409	MUNICIPALIDAD DISTRITAL DE MIRAFLORES	\N	\N	32
1641	151022-301410	MUNICIPALIDAD DISTRITAL DE OMAS	\N	\N	32
1642	151023-301411	MUNICIPALIDAD DISTRITAL DE PUTINZA	\N	\N	32
1643	151024-301412	MUNICIPALIDAD DISTRITAL DE QUINCHES	\N	\N	32
1644	151025-301413	MUNICIPALIDAD DISTRITAL DE QUINOCAY	\N	\N	32
1645	151026-301414	MUNICIPALIDAD DISTRITAL DE SAN JOAQUIN	\N	\N	32
1646	151027-301415	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE PILAS	\N	\N	32
1647	151028-301416	MUNICIPALIDAD DISTRITAL DE TANTA	\N	\N	32
1648	151029-301417	MUNICIPALIDAD DISTRITAL DE TAURIPAMPA	\N	\N	32
1649	151030-301418	MUNICIPALIDAD DISTRITAL DE TOMAS	\N	\N	32
1650	151031-301419	MUNICIPALIDAD DISTRITAL DE TUPE	\N	\N	32
1651	151032-301420	MUNICIPALIDAD DISTRITAL DE VIÑAC	\N	\N	32
1652	151033-301421	MUNICIPALIDAD DISTRITAL DE VITIS	\N	\N	32
1653	160101-301422	MUNICIPALIDAD PROVINCIAL DE MAYNAS - IQUITOS	\N	\N	32
1654	160102-301423	MUNICIPALIDAD DISTRITAL DE ALTO NANAY	\N	\N	32
1655	160103-301424	MUNICIPALIDAD DISTRITAL DE FERNANDO LORES	\N	\N	32
1656	160104-301425	MUNICIPALIDAD DISTRITAL DE INDIANA	\N	\N	32
1657	160105-301426	MUNICIPALIDAD DISTRITAL DE LAS AMAZONAS	\N	\N	32
1658	160106-301427	MUNICIPALIDAD DISTRITAL DE MAZAN	\N	\N	32
1659	160107-301428	MUNICIPALIDAD DISTRITAL DE NAPO	\N	\N	32
1660	160108-301429	MUNICIPALIDAD DISTRITAL DE PUNCHANA	\N	\N	32
1661	160110-301431	MUNICIPALIDAD DISTRITAL DE TORRES CAUSANA	\N	\N	32
1662	160112-301432	MUNICIPALIDAD DISTRITAL DE BELEN	\N	\N	32
1663	160113-301433	MUNICIPALIDAD DISTRITAL DE SAN JUAN BAUTISTA	\N	\N	32
1664	160201-301434	MUNICIPALIDAD PROVINCIAL DEL ALTO AMAZONAS - YURIMAGUAS	\N	\N	32
1665	160202-301435	MUNICIPALIDAD DISTRITAL DE BALSAPUERTO	\N	\N	32
1666	160205-301438	MUNICIPALIDAD DISTRITAL DE JEBEROS	\N	\N	32
1667	160206-301439	MUNICIPALIDAD DISTRITAL DE LAGUNAS	\N	\N	32
1668	160210-301443	MUNICIPALIDAD DISTRITAL DE SANTA CRUZ	\N	\N	32
1669	160211-301444	MUNICIPALIDAD DISTRITAL DE TENIENTE CESAR LOPEZ ROJAS	\N	\N	32
1670	160301-301445	MUNICIPALIDAD PROVINCIAL DE LORETO - NAUTA	\N	\N	32
1671	160302-301446	MUNICIPALIDAD DISTRITAL DE PARINARI	\N	\N	32
1672	160303-301447	MUNICIPALIDAD DISTRITAL DE TIGRE	\N	\N	32
1673	160304-301448	MUNICIPALIDAD DISTRITAL DE TROMPETEROS	\N	\N	32
1674	160305-301449	MUNICIPALIDAD DISTRITAL DE URARINAS	\N	\N	32
1675	160401-301450	MUNICIPALIDAD PROVINCIAL DE MARISCAL RAMON CASTILLA	\N	\N	32
1676	160402-301451	MUNICIPALIDAD DISTRITAL DE PEVAS	\N	\N	32
1677	160403-301452	MUNICIPALIDAD DISTRITAL DE YAVARI	\N	\N	32
1678	160404-301453	MUNICIPALIDAD DISTRITAL DE SAN PABLO	\N	\N	32
1679	160501-301454	MUNICIPALIDAD PROVINCIAL DE REQUENA	\N	\N	32
1680	160502-301455	MUNICIPALIDAD DISTRITAL DE ALTO TAPICHE	\N	\N	32
1681	160503-301456	MUNICIPALIDAD DISTRITAL DE CAPELO	\N	\N	32
1682	160504-301457	MUNICIPALIDAD DISTRITAL DE EMILIO SAN MARTIN	\N	\N	32
1683	160505-301458	MUNICIPALIDAD DISTRITAL DE MAQUIA	\N	\N	32
1684	160506-301459	MUNICIPALIDAD DISTRITAL DE PUINAHUA	\N	\N	32
1685	160507-301460	MUNICIPALIDAD DISTRITAL DE SAQUENA	\N	\N	32
1686	160508-301461	MUNICIPALIDAD DISTRITAL DE SOPLIN	\N	\N	32
1687	160509-301462	MUNICIPALIDAD DISTRITAL DE TAPICHE	\N	\N	32
1688	160510-301463	MUNICIPALIDAD DISTRITAL DE JENARO HERRERA	\N	\N	32
1689	160511-301464	MUNICIPALIDAD DISTRITAL DE YAQUERANA	\N	\N	32
1690	160601-301465	MUNICIPALIDAD PROVINCIAL DE UCAYALI - CONTAMANA	\N	\N	32
1691	160602-301466	MUNICIPALIDAD DISTRITAL DE INAHUAYA	\N	\N	32
1692	160603-301467	MUNICIPALIDAD DISTRITAL DE PADRE MARQUEZ	\N	\N	32
1693	160604-301468	MUNICIPALIDAD DISTRITAL DE PAMPA HERMOZA	\N	\N	32
1694	160605-301469	MUNICIPALIDAD DISTRITAL DE SARAYACU	\N	\N	32
1695	160606-301470	MUNICIPALIDAD DISTRITAL DE VARGAS GUERRA	\N	\N	32
1696	160701-301436	MUNICIPALIDAD PROVINCIAL DE DATEM DEL MARAÑON	\N	\N	32
1697	160702-301437	MUNICIPALIDAD DISTRITAL DE CAHUAPANAS	\N	\N	32
1698	160703-301440	MUNICIPALIDAD DISTRITAL DE MANSERICHE	\N	\N	32
1699	160704-301441	MUNICIPALIDAD DISTRITAL DE MORONA	\N	\N	32
1700	160705-301442	MUNICIPALIDAD DISTRITAL DE PASTAZA	\N	\N	32
1701	160706-301842	MUNICIPALIDAD DISTRITAL DE ANDOAS	\N	\N	32
1702	160801-301854	MUNICIPALIDAD PROVINCIAL DE PUTUMAYO	\N	\N	32
1703	160802-301856	MUNICIPALIDAD DISTRITAL DE ROSA PANDURO	\N	\N	32
1704	160803-301855	MUNICIPALIDAD DISTRITAL DE TENIENTE MANUEL CLAVERO	\N	\N	32
1705	160804-301857	MUNICIPALIDAD DISTRITAL DE YAGUAS	\N	\N	32
1706	170101-301471	MUNICIPALIDAD PROVINCIAL DE TAMBOPATA	\N	\N	32
1707	170102-301472	MUNICIPALIDAD DISTRITAL DE INAMBARI	\N	\N	32
1708	170103-301473	MUNICIPALIDAD DISTRITAL DE LAS PIEDRAS	\N	\N	32
1709	170104-301474	MUNICIPALIDAD DISTRITAL DE LABERINTO	\N	\N	32
1710	170201-301475	MUNICIPALIDAD PROVINCIAL DE MANU	\N	\N	32
1711	170202-301476	MUNICIPALIDAD DISTRITAL DE FITZCARRALD	\N	\N	32
1712	170203-301477	MUNICIPALIDAD DISTRITAL DE MADRE DE DIOS	\N	\N	32
1713	170204-301836	MUNICIPALIDAD DISTRITAL DE HUEPETUHE	\N	\N	32
1714	170301-301478	MUNICIPALIDAD PROVINCIAL DE TAHUAMANU - IÑAPARI	\N	\N	32
1715	170302-301479	MUNICIPALIDAD DISTRITAL DE IBERIA	\N	\N	32
1716	170303-301480	MUNICIPALIDAD DISTRITAL DE TAHUAMANU	\N	\N	32
1717	180101-301481	MUNICIPALIDAD PROVINCIAL DE MARISCAL NIETO - MOQUEGUA	\N	\N	32
1718	180102-301482	MUNICIPALIDAD DISTRITAL DE CARUMAS	\N	\N	32
1719	180103-301483	MUNICIPALIDAD DISTRITAL DE CUCHUMBAYA	\N	\N	32
1720	180104-301484	MUNICIPALIDAD DISTRITAL DE SAMEGUA	\N	\N	32
1721	180105-301485	MUNICIPALIDAD DISTRITAL DE SAN CRISTOBAL	\N	\N	32
1722	180106-301486	MUNICIPALIDAD DISTRITAL DE TORATA	\N	\N	32
1723	180107-301901	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO	\N	\N	32
1724	180201-301487	MUNICIPALIDAD PROVINCIAL DE SANCHEZ CERRO - OMATE	\N	\N	32
1725	180202-301488	MUNICIPALIDAD DISTRITAL DE CHOJATA	\N	\N	32
1726	180203-301489	MUNICIPALIDAD DISTRITAL DE COALAQUE	\N	\N	32
1727	180204-301490	MUNICIPALIDAD DISTRITAL DE ICHUÑA	\N	\N	32
1728	180205-301491	MUNICIPALIDAD DISTRITAL DE LA CAPILLA	\N	\N	32
1729	180206-301492	MUNICIPALIDAD DISTRITAL DE LLOQUE	\N	\N	32
1730	180207-301493	MUNICIPALIDAD DISTRITAL DE MATALAQUE	\N	\N	32
1731	180208-301494	MUNICIPALIDAD DISTRITAL DE PUQUINA	\N	\N	32
1732	180209-301495	MUNICIPALIDAD DISTRITAL DE QUINISTAQUILLAS	\N	\N	32
1733	180210-301496	MUNICIPALIDAD DISTRITAL DE UBINAS	\N	\N	32
1734	180211-301497	MUNICIPALIDAD DISTRITAL DE YUNGA	\N	\N	32
1735	180301-301498	MUNICIPALIDAD PROVINCIAL DE ILO	\N	\N	32
1736	180302-301499	MUNICIPALIDAD DISTRITAL DE EL ALGARROBAL	\N	\N	32
1737	180303-301500	MUNICIPALIDAD DISTRITAL DE PACOCHA	\N	\N	32
1738	190101-301501	MUNICIPALIDAD PROVINCIAL DE PASCO - CHAUPIMARCA	\N	\N	32
1739	190102-301502	MUNICIPALIDAD DISTRITAL DE HUACHON	\N	\N	32
1740	190103-301503	MUNICIPALIDAD DISTRITAL DE HUARIACA	\N	\N	32
1741	190104-301504	MUNICIPALIDAD DISTRITAL DE HUAYLLAY	\N	\N	32
1742	190105-301505	MUNICIPALIDAD DISTRITAL DE NINACACA	\N	\N	32
1743	190106-301506	MUNICIPALIDAD DISTRITAL DE PALLANCHACRA	\N	\N	32
1744	190107-301507	MUNICIPALIDAD DISTRITAL DE PAUCARTAMBO	\N	\N	32
1745	190108-301508	MUNICIPALIDAD DISTRITAL DE SAN FRANCISCO DE ASIS DE YARUSYACAN	\N	\N	32
1746	190109-301509	MUNICIPALIDAD DISTRITAL DE SIMON BOLIVAR	\N	\N	32
1747	190110-301510	MUNICIPALIDAD DISTRITAL DE TICLACAYAN	\N	\N	32
1748	190111-301511	MUNICIPALIDAD DISTRITAL DE TINYAHUARCO	\N	\N	32
1749	190112-301512	MUNICIPALIDAD DISTRITAL DE VICCO	\N	\N	32
1750	190113-301513	MUNICIPALIDAD DISTRITAL DE YANACANCHA	\N	\N	32
1751	190201-301514	MUNICIPALIDAD PROVINCIAL DE DANIEL A. CARRION - YANAHUANCA	\N	\N	32
1752	190202-301515	MUNICIPALIDAD DISTRITAL DE CHACAYAN	\N	\N	32
1753	190203-301516	MUNICIPALIDAD DISTRITAL DE GOYLLARISQUIZGA	\N	\N	32
1754	190204-301517	MUNICIPALIDAD DISTRITAL DE PAUCAR	\N	\N	32
1755	190205-301518	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE PILLAO	\N	\N	32
1756	190206-301519	MUNICIPALIDAD DISTRITAL DE SANTA ANA DE TUSI	\N	\N	32
1757	190207-301520	MUNICIPALIDAD DISTRITAL DE TAPUC	\N	\N	32
1758	190208-301521	MUNICIPALIDAD DISTRITAL DE VILCABAMBA	\N	\N	32
1759	190301-301522	MUNICIPALIDAD PROVINCIAL DE OXAPAMPA	\N	\N	32
1760	190302-301523	MUNICIPALIDAD DISTRITAL DE CHONTABAMBA	\N	\N	32
1761	190303-301524	MUNICIPALIDAD DISTRITAL DE HUANCABAMBA	\N	\N	32
1762	190304-301525	MUNICIPALIDAD DISTRITAL DE PALCAZU	\N	\N	32
1763	190305-301526	MUNICIPALIDAD DISTRITAL DE POZUZO	\N	\N	32
1764	190306-301527	MUNICIPALIDAD DISTRITAL DE PUERTO BERMUDEZ	\N	\N	32
1765	190307-301528	MUNICIPALIDAD DISTRITAL DE VILLA RICA	\N	\N	32
1766	190308-301847	MUNICIPALIDAD DISTRITAL DE CONSTITUCION	\N	\N	32
1767	200101-301529	MUNICIPALIDAD PROVINCIAL DE PIURA	\N	\N	32
1768	200104-301530	MUNICIPALIDAD DISTRITAL DE CASTILLA	\N	\N	32
1769	200105-301531	MUNICIPALIDAD DISTRITAL DE CATACAOS	\N	\N	32
1770	200107-301532	MUNICIPALIDAD DISTRITAL DE CURA MORI	\N	\N	32
1771	200108-301533	MUNICIPALIDAD DISTRITAL DE EL TALLAN	\N	\N	32
1772	200109-301534	MUNICIPALIDAD DISTRITAL DE LA ARENA	\N	\N	32
1773	200110-301535	MUNICIPALIDAD DISTRITAL DE LA UNION	\N	\N	32
1774	200111-301536	MUNICIPALIDAD DISTRITAL DE LAS LOMAS	\N	\N	32
1775	200114-301537	MUNICIPALIDAD DISTRITAL DE TAMBO GRANDE	\N	\N	32
1776	200115-301849	MUNICIPALIDAD DISTRITAL VEINTISEIS DE OCTUBRE	\N	\N	32
1777	200201-301538	MUNICIPALIDAD PROVINCIAL DE AYABACA	\N	\N	32
1778	200202-301539	MUNICIPALIDAD DISTRITAL DE FRIAS	\N	\N	32
1779	200203-301540	MUNICIPALIDAD DISTRITAL DE JILILI	\N	\N	32
1780	200204-301541	MUNICIPALIDAD DISTRITAL DE LAGUNAS	\N	\N	32
1781	200205-301542	MUNICIPALIDAD DISTRITAL DE MONTERO	\N	\N	32
1782	200206-301543	MUNICIPALIDAD DISTRITAL DE PACAIPAMPA	\N	\N	32
1783	200207-301544	MUNICIPALIDAD DISTRITAL DE PAIMAS	\N	\N	32
1784	200208-301545	MUNICIPALIDAD DISTRITAL DE SAPILLICA	\N	\N	32
1785	200209-301546	MUNICIPALIDAD DISTRITAL DE SICCHEZ	\N	\N	32
1786	200210-301547	MUNICIPALIDAD DISTRITAL DE SUYO	\N	\N	32
1787	200301-301548	MUNICIPALIDAD PROVINCIAL DE HUANCABAMBA	\N	\N	32
1788	200302-301549	MUNICIPALIDAD DISTRITAL DE CANCHAQUE	\N	\N	32
1789	200303-301550	MUNICIPALIDAD DISTRITAL DE EL CARMEN DE LA FRONTERA	\N	\N	32
1790	200304-301551	MUNICIPALIDAD DISTRITAL DE HUARMACA	\N	\N	32
1791	200305-301552	MUNICIPALIDAD DISTRITAL DE LALAQUIZ	\N	\N	32
1792	200306-301553	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL DE EL FAIQUE	\N	\N	32
1793	200307-301554	MUNICIPALIDAD DISTRITAL DE SONDOR	\N	\N	32
1794	200308-301555	MUNICIPALIDAD DISTRITAL DE SONDORILLO	\N	\N	32
1795	200401-301556	MUNICIPALIDAD PROVINCIAL DE MORROPON - CHULUCANAS	\N	\N	32
1796	200402-301557	MUNICIPALIDAD DISTRITAL DE BUENOS AIRES	\N	\N	32
1797	200403-301558	MUNICIPALIDAD DISTRITAL DE CHALACO	\N	\N	32
1798	200404-301559	MUNICIPALIDAD DISTRITAL DE LA MATANZA	\N	\N	32
1799	200405-301560	MUNICIPALIDAD DISTRITAL DE MORROPON	\N	\N	32
1800	200406-301561	MUNICIPALIDAD DISTRITAL DE SALITRAL	\N	\N	32
1801	200407-301562	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE BIGOTE	\N	\N	32
1802	200408-301563	MUNICIPALIDAD DISTRITAL DE SANTA CATALINA DE MOSSA	\N	\N	32
1803	200409-301564	MUNICIPALIDAD DISTRITAL DE SANTO DOMINGO	\N	\N	32
1804	200410-301565	MUNICIPALIDAD DISTRITAL DE YAMANGO	\N	\N	32
1805	200501-301566	MUNICIPALIDAD PROVINCIAL DE PAITA	\N	\N	32
1806	200502-301567	MUNICIPALIDAD DISTRITAL DE AMOTAPE	\N	\N	32
1807	200503-301568	MUNICIPALIDAD DISTRITAL DE EL ARENAL	\N	\N	32
1808	200504-301569	MUNICIPALIDAD DISTRITAL DE COLAN	\N	\N	32
1809	200505-301570	MUNICIPALIDAD DISTRITAL DE LA HUACA	\N	\N	32
1810	200506-301571	MUNICIPALIDAD DISTRITAL DE TAMARINDO	\N	\N	32
1811	200507-301572	MUNICIPALIDAD DISTRITAL DE VICHAYAL	\N	\N	32
1812	200601-301573	MUNICIPALIDAD PROVINCIAL DE SULLANA	\N	\N	32
1813	200602-301574	MUNICIPALIDAD DISTRITAL DE BELLAVISTA	\N	\N	32
1814	200603-301575	MUNICIPALIDAD DISTRITAL DE IGNACIO ESCUDERO	\N	\N	32
1815	200604-301576	MUNICIPALIDAD DISTRITAL DE LANCONES	\N	\N	32
1816	200605-301577	MUNICIPALIDAD DISTRITAL DE MARCAVELICA	\N	\N	32
1817	200606-301578	MUNICIPALIDAD DISTRITAL DE MIGUEL CHECA	\N	\N	32
1818	200607-301579	MUNICIPALIDAD DISTRITAL DE QUERECOTILLO	\N	\N	32
1819	200608-301580	MUNICIPALIDAD DISTRITAL DE SALITRAL	\N	\N	32
1820	200701-301581	MUNICIPALIDAD PROVINCIAL DE TALARA - PARIÑAS	\N	\N	32
1821	200702-301582	MUNICIPALIDAD DISTRITAL DE EL ALTO	\N	\N	32
1822	200703-301583	MUNICIPALIDAD DISTRITAL DE LA BREA	\N	\N	32
1823	200704-301584	MUNICIPALIDAD DISTRITAL DE LOBITOS	\N	\N	32
1824	200705-301585	MUNICIPALIDAD DISTRITAL DE LOS ORGANOS	\N	\N	32
1825	200706-301586	MUNICIPALIDAD DISTRITAL DE MANCORA	\N	\N	32
1826	200801-301587	MUNICIPALIDAD PROVINCIAL DE SECHURA	\N	\N	32
1827	200802-301588	MUNICIPALIDAD DISTRITAL DE BELLAVISTA DE LA UNION	\N	\N	32
1828	200803-301589	MUNICIPALIDAD DISTRITAL DE BERNAL	\N	\N	32
1829	200804-301590	MUNICIPALIDAD DISTRITAL DE CRISTO NOS VALGA	\N	\N	32
1830	200805-301591	MUNICIPALIDAD DISTRITAL DE VICE	\N	\N	32
1831	200806-301592	MUNICIPALIDAD DISTRITAL DE RINCONADA LLICUAR	\N	\N	32
1832	210101-301593	MUNICIPALIDAD PROVINCIAL DE PUNO	\N	\N	32
1833	210102-301594	MUNICIPALIDAD DISTRITAL DE ACORA	\N	\N	32
1834	210103-301595	MUNICIPALIDAD DISTRITAL DE AMANTANI	\N	\N	32
1835	210104-301596	MUNICIPALIDAD DISTRITAL DE ATUNCOLLA	\N	\N	32
1836	210105-301597	MUNICIPALIDAD DISTRITAL DE CAPACHICA	\N	\N	32
1837	210106-301598	MUNICIPALIDAD DISTRITAL DE CHUCUITO	\N	\N	32
1838	210107-301599	MUNICIPALIDAD DISTRITAL DE COATA	\N	\N	32
1839	210108-301600	MUNICIPALIDAD DISTRITAL HUATA	\N	\N	32
1840	210109-301601	MUNICIPALIDAD DISTRITAL DE MAÑAZO	\N	\N	32
1841	210110-301602	MUNICIPALIDAD DISTRITAL DE PAUCARCOLLA	\N	\N	32
1842	210111-301603	MUNICIPALIDAD DISTRITAL DE PICHACANI	\N	\N	32
1843	210112-301604	MUNICIPALIDAD DISTRITAL DE PLATERIA	\N	\N	32
1844	210113-301605	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO	\N	\N	32
1845	210114-301606	MUNICIPALIDAD DISTRITAL DE TIQUILLACA	\N	\N	32
1846	210115-301607	MUNICIPALIDAD DISTRITAL DE VILQUE	\N	\N	32
1847	210201-301608	MUNICIPALIDAD PROVINCIAL DE AZANGARO	\N	\N	32
1848	210202-301609	MUNICIPALIDAD DISTRITAL DE ACHAYA	\N	\N	32
1849	210203-301610	MUNICIPALIDAD DISTRITAL DE ARAPA	\N	\N	32
1850	210204-301611	MUNICIPALIDAD DISTRITAL DE ASILLO	\N	\N	32
1851	210205-301612	MUNICIPALIDAD DISTRITAL DE CAMINACA	\N	\N	32
1852	210206-301613	MUNICIPALIDAD DISTRITAL DE CHUPA	\N	\N	32
1853	210207-301614	MUNICIPALIDAD DISTRITAL DE JOSE DOMINGO CHOQUEHUANCA	\N	\N	32
1854	210208-301615	MUNICIPALIDAD DISTRITAL DE MUÑANI	\N	\N	32
1855	210209-301616	MUNICIPALIDAD DISTRITAL DE POTONI	\N	\N	32
1856	210210-301617	MUNICIPALIDAD DISTRITAL DE SAMAN	\N	\N	32
1857	210211-301618	MUNICIPALIDAD DISTRITAL DE SAN ANTON	\N	\N	32
1858	210212-301619	MUNICIPALIDAD DISTRITAL DE SAN JOSE	\N	\N	32
1859	210213-301620	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE SALINAS	\N	\N	32
1860	210214-301621	MUNICIPALIDAD DISTRITAL DE SANTIAGO DE PUPUJA	\N	\N	32
1861	210215-301622	MUNICIPALIDAD DISTRITAL DE TIRAPATA	\N	\N	32
1862	210301-301623	MUNICIPALIDAD PROVINCIAL DE CARABAYA - MACUSANI	\N	\N	32
1863	210302-301624	MUNICIPALIDAD DISTRITAL DE AJOYANI	\N	\N	32
1864	210303-301625	MUNICIPALIDAD DISTRITAL DE AYAPATA	\N	\N	32
1865	210304-301626	MUNICIPALIDAD DISTRITAL DE COASA	\N	\N	32
1866	210305-301627	MUNICIPALIDAD DISTRITAL DE CORANI	\N	\N	32
1867	210306-301628	MUNICIPALIDAD DISTRITAL DE CRUCERO	\N	\N	32
1868	210307-301629	MUNICIPALIDAD DISTRITAL DE ITUATA	\N	\N	32
1869	210308-301630	MUNICIPALIDAD DISTRITAL DE OLLACHEA	\N	\N	32
1870	210309-301631	MUNICIPALIDAD DISTRITAL DE SAN GABAN	\N	\N	32
1871	210310-301632	MUNICIPALIDAD DISTRITAL DE USICAYOS	\N	\N	32
1872	210401-301633	MUNICIPALIDAD PROVINCIAL DE CHUCUITO - JULI	\N	\N	32
1873	210402-301634	MUNICIPALIDAD DISTRITAL DE DESAGUADERO	\N	\N	32
1874	210403-301635	MUNICIPALIDAD DISTRITAL DE HUACULLANI	\N	\N	32
1875	210404-301636	MUNICIPALIDAD DISTRITAL DE KELLUYO	\N	\N	32
1876	210405-301637	MUNICIPALIDAD DISTRITAL DE PISACOMA	\N	\N	32
1877	210406-301638	MUNICIPALIDAD DISTRITAL DE POMATA	\N	\N	32
1878	210407-301639	MUNICIPALIDAD DISTRITAL DE ZEPITA	\N	\N	32
1879	210501-301640	MUNICIPALIDAD PROVINCIAL EL COLLAO - ILAVE	\N	\N	32
1880	210502-301641	MUNICIPALIDAD DISTRITAL DE CAPASO	\N	\N	32
1881	210503-301642	MUNICIPALIDAD DISTRITAL DE PILCUYO	\N	\N	32
1882	210504-301643	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
1883	210505-301644	MUNICIPALIDAD DISTRITAL DE CONDURIRI	\N	\N	32
1884	210601-301645	MUNICIPALIDAD PROVINCIAL DE HUANCANE	\N	\N	32
1885	210602-301646	MUNICIPALIDAD DISTRITAL DE COJATA	\N	\N	32
1886	210603-301647	MUNICIPALIDAD DISTRITAL DE HUATASANI	\N	\N	32
1887	210604-301648	MUNICIPALIDAD DISTRITAL DE INCHUPALLA	\N	\N	32
1888	210605-301649	MUNICIPALIDAD DISTRITAL DE PUSI	\N	\N	32
1889	210606-301650	MUNICIPALIDAD DISTRITAL DE ROSASPATA	\N	\N	32
1890	210607-301651	MUNICIPALIDAD DISTRITAL DE TARACO	\N	\N	32
1891	210608-301652	MUNICIPALIDAD DISTRITAL DE VILQUE CHICO	\N	\N	32
1892	210701-301653	MUNICIPALIDAD PROVINCIAL DE LAMPA	\N	\N	32
1893	210702-301654	MUNICIPALIDAD DISTRITAL DE CABANILLA	\N	\N	32
1894	210703-301655	MUNICIPALIDAD DISTRITAL DE CALAPUJA	\N	\N	32
1895	210704-301656	MUNICIPALIDAD DISTRITAL DE NICASIO	\N	\N	32
1896	210705-301657	MUNICIPALIDAD DISTRITAL DE OCUVIRI	\N	\N	32
1897	210706-301658	MUNICIPALIDAD DISTRITAL DE PALCA	\N	\N	32
1898	210707-301659	MUNICIPALIDAD DISTRITAL DE PARATIA	\N	\N	32
1899	210708-301660	MUNICIPALIDAD DISTRITAL DE PUCARA	\N	\N	32
1900	210709-301661	MUNICIPALIDAD DISTRITAL DE SANTA LUCIA	\N	\N	32
1901	210710-301662	MUNICIPALIDAD DISTRITAL DE VILAVILA	\N	\N	32
1902	210801-301663	MUNICIPALIDAD PROVINCIAL DE MELGAR - AYAVIRI	\N	\N	32
1903	210802-301664	MUNICIPALIDAD DISTRITAL DE ANTAUTA	\N	\N	32
1904	210803-301665	MUNICIPALIDAD DISTRITAL DE CUPI	\N	\N	32
1905	210804-301666	MUNICIPALIDAD DISTRITAL DE LLALLI	\N	\N	32
1906	210805-301667	MUNICIPALIDAD DISTRITAL DE MACARI	\N	\N	32
1907	210806-301668	MUNICIPALIDAD DISTRITAL DE NUÑOA	\N	\N	32
1908	210807-301669	MUNICIPALIDAD DISTRITAL DE ORURILLO	\N	\N	32
1909	210808-301670	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
1910	210809-301671	MUNICIPALIDAD DISTRITAL DE UMACHIRI	\N	\N	32
1911	210901-301672	MUNICIPALIDAD PROVINCIAL DE MOHO	\N	\N	32
1912	210902-301673	MUNICIPALIDAD DISTRITAL DE CONIMA	\N	\N	32
1913	210903-301674	MUNICIPALIDAD DISTRITAL DE HUAYRAPATA	\N	\N	32
1914	210904-301675	MUNICIPALIDAD DISTRITAL DE TILALI	\N	\N	32
1915	211001-301676	MUNICIPALIDAD PROVINCIAL DE SAN ANTONIO DE PUTINA	\N	\N	32
1916	211002-301677	MUNICIPALIDAD DISTRITAL DE ANANEA	\N	\N	32
1917	211003-301678	MUNICIPALIDAD DISTRITAL DE PEDRO VILCA APAZA	\N	\N	32
1918	211004-301679	MUNICIPALIDAD DISTRITAL DE QUILCAPUNCU	\N	\N	32
1919	211005-301680	MUNICIPALIDAD DISTRITAL DE SINA	\N	\N	32
1920	211101-301681	MUNICIPALIDAD PROVINCIAL DE SAN ROMAN - JULIACA	\N	\N	32
1921	211102-301682	MUNICIPALIDAD DISTRITAL DE CABANA	\N	\N	32
1922	211103-301683	MUNICIPALIDAD DISTRITAL DE CABANILLAS	\N	\N	32
1923	211104-301684	MUNICIPALIDAD DISTRITAL DE CARACOTO	\N	\N	32
1924	211105-301886	MUNICIPALIDAD DISTRITAL DE SAN MIGUEL	\N	\N	32
1925	211201-301685	MUNICIPALIDAD PROVINCIAL DE SANDIA	\N	\N	32
1926	211202-301686	MUNICIPALIDAD DISTRITAL DE CUYOCUYO	\N	\N	32
1927	211203-301687	MUNICIPALIDAD DISTRITAL DE LIMBANI	\N	\N	32
1928	211204-301688	MUNICIPALIDAD DISTRITAL DE PATAMBUCO	\N	\N	32
1929	211205-301689	MUNICIPALIDAD DISTRITAL DE PHARA	\N	\N	32
1930	211206-301690	MUNICIPALIDAD DISTRITAL DE QUIACA	\N	\N	32
1931	211207-301691	MUNICIPALIDAD DISTRITAL DE SAN JUAN DEL ORO	\N	\N	32
1932	211208-301692	MUNICIPALIDAD DISTRITAL DE YANAHUAYA	\N	\N	32
1933	211209-301693	MUNICIPALIDAD DISTRITAL DE ALTO INAMBARI	\N	\N	32
1934	211210-301841	MUNICIPALIDAD DISTRITAL DE SAN PEDRO DE PUTINA PUNCO	\N	\N	32
1935	211301-301694	MUNICIPALIDAD PROVINCIAL DE YUNGUYO	\N	\N	32
1936	211302-301695	MUNICIPALIDAD DISTRITAL DE ANAPIA	\N	\N	32
1937	211303-301696	MUNICIPALIDAD DISTRITAL DE COPANI	\N	\N	32
1938	211304-301697	MUNICIPALIDAD DISTRITAL DE CUTURAPI	\N	\N	32
1939	211305-301698	MUNICIPALIDAD DISTRITAL DE OLLARAYA	\N	\N	32
1940	211306-301699	MUNICIPALIDAD DISTRITAL DE TINICACHI	\N	\N	32
1941	211307-301700	MUNICIPALIDAD DISTRITAL DE UNICACHI	\N	\N	32
1942	220101-301701	MUNICIPALIDAD PROVINCIAL DE MOYOBAMBA	\N	\N	32
1943	220102-301702	MUNICIPALIDAD DISTRITAL DE CALZADA	\N	\N	32
1944	220103-301703	MUNICIPALIDAD DISTRITAL DE HABANA	\N	\N	32
1945	220104-301704	MUNICIPALIDAD DISTRITAL DE JEPELACIO	\N	\N	32
1946	220105-301705	MUNICIPALIDAD DISTRITAL DE SORITOR	\N	\N	32
1947	220106-301706	MUNICIPALIDAD DISTRITAL DE YANTALO	\N	\N	32
1948	220201-301707	MUNICIPALIDAD PROVINCIAL DE BELLAVISTA	\N	\N	32
1949	220202-301708	MUNICIPALIDAD DISTRITAL DE ALTO BIAVO	\N	\N	32
1950	220203-301709	MUNICIPALIDAD DISTRITAL DE BAJO BIAVO	\N	\N	32
1951	220204-301710	MUNICIPALIDAD DISTRITAL DE HUALLAGA	\N	\N	32
1952	220205-301711	MUNICIPALIDAD DISTRITAL DE SAN PABLO	\N	\N	32
1953	220206-301712	MUNICIPALIDAD DISTRITAL DE SAN RAFAEL	\N	\N	32
1954	220301-301713	MUNICIPALIDAD PROVINCIAL DE EL DORADO	\N	\N	32
1955	220302-301714	MUNICIPALIDAD DISTRITAL DE AGUA BLANCA	\N	\N	32
1956	220303-301715	MUNICIPALIDAD DISTRITAL DE SAN MARTIN	\N	\N	32
1957	220304-301716	MUNICIPALIDAD DISTRITAL DE SANTA ROSA	\N	\N	32
1958	220305-301717	MUNICIPALIDAD DISTRITAL DE SHATOJA	\N	\N	32
1959	220401-301718	MUNICIPALIDAD PROVINCIAL DE HUALLAGA - SAPOSOA	\N	\N	32
1960	220402-301719	MUNICIPALIDAD DISTRITAL DE ALTO SAPOSOA	\N	\N	32
1961	220403-301720	MUNICIPALIDAD DISTRITAL DE EL ESLABON	\N	\N	32
1962	220404-301721	MUNICIPALIDAD DISTRITAL DE PISCOYACU	\N	\N	32
1963	220405-301722	MUNICIPALIDAD DISTRITAL DE SACANCHE	\N	\N	32
1964	220406-301723	MUNICIPALIDAD DISTRITAL DE TINGO DE SAPOSOA	\N	\N	32
1965	220501-301724	MUNICIPALIDAD PROVINCIAL DE LAMAS	\N	\N	32
1966	220502-301725	MUNICIPALIDAD DISTRITAL DE ALONSO DE ALVARADO	\N	\N	32
1967	220503-301726	MUNICIPALIDAD DISTRITAL DE BARRANQUITA	\N	\N	32
1968	220504-301727	MUNICIPALIDAD DISTRITAL DE CAYNARACHI	\N	\N	32
1969	220505-301728	MUNICIPALIDAD DISTRITAL DE CUÑUMBUQUI	\N	\N	32
1970	220506-301729	MUNICIPALIDAD DISTRITAL DE PINTO RECODO	\N	\N	32
1971	220507-301730	MUNICIPALIDAD DISTRITAL DE RUMISAPA	\N	\N	32
1972	220508-301731	MUNICIPALIDAD DISTRITAL DE SAN ROQUE DE CUMBAZA	\N	\N	32
1973	220509-301732	MUNICIPALIDAD DISTRITAL DE SHANAO	\N	\N	32
1974	220510-301733	MUNICIPALIDAD DISTRITAL DE TABALOSOS	\N	\N	32
1975	220511-301734	MUNICIPALIDAD DISTRITAL DE ZAPATERO	\N	\N	32
1976	220601-301735	MUNICIPALIDAD PROVINCIAL DE MARISCAL CACERES - JUANJUI	\N	\N	32
1977	220602-301736	MUNICIPALIDAD DISTRITAL DE CAMPANILLA	\N	\N	32
1978	220603-301737	MUNICIPALIDAD DISTRITAL DE HUICUNGO	\N	\N	32
1979	220604-301738	MUNICIPALIDAD DISTRITAL DE PACHIZA	\N	\N	32
1980	220605-301739	MUNICIPALIDAD DISTRITAL DE PAJARILLO	\N	\N	32
1981	220701-301740	MUNICIPALIDAD PROVINCIAL DE PICOTA	\N	\N	32
1982	220702-301741	MUNICIPALIDAD DISTRITAL DE BUENOS AIRES	\N	\N	32
1983	220703-301742	MUNICIPALIDAD DISTRITAL DE CASPISAPA	\N	\N	32
1984	220704-301743	MUNICIPALIDAD DISTRITAL DE PILLUANA	\N	\N	32
1985	220705-301744	MUNICIPALIDAD DISTRITAL DE PUCACACA	\N	\N	32
1986	220706-301745	MUNICIPALIDAD DISTRITAL DE SAN CRISTOBAL	\N	\N	32
1987	220707-301746	MUNICIPALIDAD DISTRITAL DE SAN HILARION	\N	\N	32
1988	220708-301747	MUNICIPALIDAD DISTRITAL DE SHAMBOYACU	\N	\N	32
1989	220709-301748	MUNICIPALIDAD DISTRITAL DE TINGO DE PONASA	\N	\N	32
1990	220710-301749	MUNICIPALIDAD DISTRITAL DE TRES UNIDOS	\N	\N	32
1991	220801-301750	MUNICIPALIDAD PROVINCIAL DE RIOJA	\N	\N	32
1992	220802-301751	MUNICIPALIDAD DISTRITAL DE AWAJUN	\N	\N	32
1993	220803-301752	MUNICIPALIDAD DISTRITAL DE ELIAS SOPLIN VARGAS	\N	\N	32
1994	220804-301753	MUNICIPALIDAD DISTRITAL DE NUEVA CAJAMARCA	\N	\N	32
1995	220805-301754	MUNICIPALIDAD DISTRITAL DE PARDO MIGUEL	\N	\N	32
1996	220806-301755	MUNICIPALIDAD DISTRITAL DE POSIC	\N	\N	32
1997	220807-301756	MUNICIPALIDAD DISTRITAL DE SAN FERNANDO	\N	\N	32
1998	220808-301757	MUNICIPALIDAD DISTRITAL DE YORONGOS	\N	\N	32
1999	220809-301758	MUNICIPALIDAD DISTRITAL DE YURACYACU	\N	\N	32
2000	220901-301759	MUNICIPALIDAD PROVINCIAL DE SAN MARTIN - TARAPOTO	\N	\N	32
2001	220902-301760	MUNICIPALIDAD DISTRITAL DE ALBERTO LEVEAU	\N	\N	32
2002	220903-301761	MUNICIPALIDAD DISTRITAL DE CACATACHI	\N	\N	32
2003	220904-301762	MUNICIPALIDAD DISTRITAL DE CHAZUTA	\N	\N	32
2004	220905-301763	MUNICIPALIDAD DISTRITAL DE CHIPURANA	\N	\N	32
2005	220906-301764	MUNICIPALIDAD DISTRITAL DE EL PORVENIR	\N	\N	32
2006	220907-301765	MUNICIPALIDAD DISTRITAL DE HUIMBAYOC	\N	\N	32
2007	220908-301766	MUNICIPALIDAD DISTRITAL DE JUAN GUERRA	\N	\N	32
2008	220909-301767	MUNICIPALIDAD DISTRITAL DE LA BANDA DE SHILCAYO	\N	\N	32
2009	220910-301768	MUNICIPALIDAD DISTRITAL DE MORALES	\N	\N	32
2010	220911-301769	MUNICIPALIDAD DISTRITAL DE PAPAPLAYA	\N	\N	32
2011	220912-301770	MUNICIPALIDAD DISTRITAL DE SAN ANTONIO	\N	\N	32
2012	220913-301771	MUNICIPALIDAD DISTRITAL DE SAUCE	\N	\N	32
2013	220914-301772	MUNICIPALIDAD DISTRITAL DE SHAPAJA	\N	\N	32
2014	221001-301773	MUNICIPALIDAD PROVINCIAL DE TOCACHE	\N	\N	32
2015	221002-301774	MUNICIPALIDAD DISTRITAL DE NUEVO PROGRESO	\N	\N	32
2016	221003-301775	MUNICIPALIDAD DISTRITAL DE POLVORA	\N	\N	32
2017	221004-301776	MUNICIPALIDAD DISTRITAL DE SHUNTE	\N	\N	32
2018	221005-301777	MUNICIPALIDAD DISTRITAL DE UCHIZA	\N	\N	32
2019	221006-301897	MUNICIPALIDAD DISTRITAL DE SANTA LUCIA	\N	\N	32
2020	230101-301778	MUNICIPALIDAD PROVINCIAL DE TACNA	\N	\N	32
2021	230102-301779	MUNICIPALIDAD DISTRITAL DE ALTO DE LA ALIANZA	\N	\N	32
2022	230103-301780	MUNICIPALIDAD DISTRITAL DE CALANA	\N	\N	32
2023	230104-301781	MUNICIPALIDAD DISTRITAL DE CIUDAD NUEVA	\N	\N	32
2024	230105-301782	MUNICIPALIDAD DISTRITAL DE INCLAN	\N	\N	32
2025	230106-301783	MUNICIPALIDAD DISTRITAL DE PACHIA	\N	\N	32
2026	230107-301784	MUNICIPALIDAD DISTRITAL DE PALCA	\N	\N	32
2027	230108-301785	MUNICIPALIDAD DISTRITAL DE POCOLLAY	\N	\N	32
2028	230109-301786	MUNICIPALIDAD DISTRITAL DE SAMA	\N	\N	32
2029	230110-301838	MUNICIPALIDAD DISTRITAL DE CORONEL GREGORIO ALBARRACIN LANCHIPA	\N	\N	32
2030	230111-301869	MUNICIPALIDAD DISTRITAL DE LA YARADA LOS PALOS	\N	\N	32
2031	230201-301787	MUNICIPALIDAD PROVINCIAL DE CANDARAVE	\N	\N	32
2032	230202-301788	MUNICIPALIDAD DISTRITAL DE CAIRANI	\N	\N	32
2033	230203-301789	MUNICIPALIDAD DISTRITAL DE CAMILACA	\N	\N	32
2034	230204-301790	MUNICIPALIDAD DISTRITAL DE CURIBAYA	\N	\N	32
2035	230205-301791	MUNICIPALIDAD DISTRITAL DE HUANUARA	\N	\N	32
2036	230206-301792	MUNICIPALIDAD DISTRITAL DE QUILAHUANI	\N	\N	32
2037	230301-301793	MUNICIPALIDAD PROVINCIAL DE JORGE BASADRE - LOCUMBA	\N	\N	32
2038	230302-301794	MUNICIPALIDAD DISTRITAL DE ILABAYA	\N	\N	32
2039	230303-301795	MUNICIPALIDAD DISTRITAL DE ITE	\N	\N	32
2040	230401-301796	MUNICIPALIDAD PROVINCIAL DE TARATA	\N	\N	32
2041	230402-301797	MUNICIPALIDAD DISTRITAL HEROES ALBARRACIN - CHUCATAMANI	\N	\N	32
2042	230403-301798	MUNICIPALIDAD DISTRITAL DE ESTIQUE	\N	\N	32
2043	230404-301799	MUNICIPALIDAD DISTRITAL DE ESTIQUE PAMPA	\N	\N	32
2044	230405-301800	MUNICIPALIDAD DISTRITAL DE SITAJARA	\N	\N	32
2045	230406-301801	MUNICIPALIDAD DISTRITAL DE SUSAPAYA	\N	\N	32
2046	230407-301802	MUNICIPALIDAD DISTRITAL DE TARUCACHI	\N	\N	32
2047	230408-301803	MUNICIPALIDAD DISTRITAL DE TICACO	\N	\N	32
2048	240101-301804	MUNICIPALIDAD PROVINCIAL DE TUMBES	\N	\N	32
2049	240102-301805	MUNICIPALIDAD DISTRITAL DE CORRALES	\N	\N	32
2050	240103-301806	MUNICIPALIDAD DISTRITAL DE LA CRUZ	\N	\N	32
2051	240104-301807	MUNICIPALIDAD DISTRITAL DE PAMPAS DE HOSPITAL	\N	\N	32
2052	240105-301808	MUNICIPALIDAD DISTRITAL DE SAN JACINTO	\N	\N	32
2053	240106-301809	MUNICIPALIDAD DISTRITAL DE SAN JUAN DE LA VIRGEN	\N	\N	32
2054	240201-301810	MUNICIPALIDAD PROVINCIAL DE CONTRALMIRANTE VILLAR	\N	\N	32
2055	240202-301811	MUNICIPALIDAD DISTRITAL DE CASITAS	\N	\N	32
2056	240203-301843	MUNICIPALIDAD DISTRITAL CANOAS DE PUNTA SAL	\N	\N	32
2057	240301-301812	MUNICIPALIDAD PROVINCIAL DE ZARUMILLA	\N	\N	32
2058	240302-301813	MUNICIPALIDAD DISTRITAL DE AGUAS VERDES	\N	\N	32
2059	240303-301814	MUNICIPALIDAD DISTRITAL DE MATAPALO	\N	\N	32
2060	240304-301815	MUNICIPALIDAD DISTRITAL DE PAPAYAL	\N	\N	32
2061	002-469	COMANDO CONJUNTO DE LAS FUERZAS ARMADAS	\N	CCFFAA	19
2062	003-470	EJERCITO PERUANO	\N	EP	19
2063	004-471	MARINA DE GUERRA DEL PERU	\N	MGP	19
2064	005-472	FUERZA AEREA DEL PERU	\N	FAP	19
2065	006-1122	COMISION NACIONAL DE INVESTIGACION Y DESARROLLO AEROESPACIAL	\N	CONIDA	19
2066	008-1123	ESCUELA NACIONAL DE MARINA MERCANTE	\N	ENAMM	19
2067	009-1124	OFICINA PREVISIONAL DE LAS FUERZAS ARMADAS	\N	OPREFA	19
2068	011-1761	CENTRO DE ALTOS ESTUDIOS NACIONALES	\N	CAEN-EPG	19
2069	\N	CAJA DE PENSIONES MILITAR POLICIAL	\N	CPMP	19
2070	\N	BANCO DE LA NACION	\N	BN	8
2071	\N	FONDO MIVIVIENDA S.A.	\N	FMV	27
2072	\N	EMPRESA DE ADMINISTRACIÓN DE INFRAESTRUCTURA ELÉCTRICA S.A.	\N	ADINELSA	13
2073	\N	EMPRESA DE SERVICIO PÚBLICO DE ELECTRICIDAD DEL NOR OESTE DEL PERÚ S.A.	\N	ENOSA	13
2074	\N	EMPRESA DE SERVICIO PÚBLICO DE ELECTRICIDAD ELECTRO NORTE MEDIO S.A	\N	HIDRANDINA	13
2075	\N	GRUPO ISA	\N	ISA REP	13
2076	\N	INSTITUTO NACIONAL DE REHABILITACIÓN	\N	INR	10
2077	\N	INSTITUTO CATASTRAL DE LIMA	\N	ICL	32
2078	\N	CENTRO DE INFORMACIÓN Y EDUCACIÓN PARA LA PREVENCIÓN DEL ABUSO DE DROGAS	\N	CEDRO	34
2079	\N	SOCIEDAD NACIONAL DE MINERÍA, PETRÓLEO Y ENERGÍA	\N	SNMPE	34
2080	\N	FONDO DE POBLACIÓN DE LAS NACIONES UNIDAS	\N	UNFPA	35
2081	\N	PROGRAMA DE LAS NACIONES UNIDAS PARA EL DESARROLLO	\N	PNUD	35
2082	\N	PROGRAMA MUNDIAL DE ALIMENTOS	\N	PMA	35
2083	\N	TELEFONICA DEL PERU	\N	TELEFONICA	36
2084	\N	SUPERINTENDENCIA DE BANCA, SEGUROS Y ADMINISTRADORAS PRIVADAS DE FONDOS DE PENSIONES	\N	SBS	8
2085	\N	PLAN BINACIONAL DE DESARROLLO DE LA REGIÓN FRONTERIZA PERÚ - ECUADOR	\N	BINACIONAL	7
2086	\N	UNIDAD EJECUTORA DE INVERSIÓN EN COMERCIO EXTERIOR Y TURISMO	\N	COPESCO NACIONAL	25
2087	\N	PROGRAMA DE EMPLEO TEMPORAL	\N	LLAMKASUN PERÚ	11
2088	\N	SERVICIO DE AGUA POTABLE Y ALCANTARILLADO DE LIMA	\N	SEDAPAL	27
2089	\N	PROGRAMA NACIONAL DE SANEAMIENTO RURAL	\N	PNSR	27
2090	\N	SERVICIOS INDUSTRIALES DE LA MARINA S.A.	\N	SIMA	19
2091	\N	PROGRAMA INTEGRAL NACIONAL PARA EL BIENESTAR FAMILIAR	\N	INABIF	29
2092	\N	PROGRAMA NACIONAL A COMER PESCADO	\N	PNACP	28
2093	\N	PROGRAMA NACIONAL DE CENTROS JUVENILES	\N	PRONACEJ	5
2094	\N	PROGRAMA NACIONAL DE TELECOMUNICACIONES	\N	PRONATEL	26
2095	\N	PROYECTO ESPECIAL DE INVERSIÓN PÚBLICA ESCUELAS BICENTENARIO	\N	ESCUELAS BICENTENARIO	9
2096	\N	PROYECTO ESPECIAL LEGADO	\N	LEGADO	1
2097	003-1426	PROGRAMA NACIONAL CUNA MAS	\N	PNCM	30
2098	004-1427	FONDO DE COOPERACION PARA EL DESARROLLO SOCIAL	\N	FONCODES	30
2099	005-1428	PROGRAMA NACIONAL DE APOYO DIRECTO A LOS MAS POBRES	\N	JUNTOS	30
2100	006-1441	PROGRAMA NACIONAL DE ASISTENCIA SOLIDARIA	\N	PENSION 65	30
2101	007-1456	PROGRAMA NACIONAL DE ALIMENTACION ESCOLAR COMUNITARIA	\N	WASI MIKUNA	30
2102	008-1674	PROGRAMA NACIONAL PLATAFORMAS DE ACCION PARA LA INCLUSION SOCIAL	\N	PAIS	30
2103	010-1723	PROGRAMA NACIONAL DE ENTREGA DE LA PENSIÓN NO CONTRIBUTIVA A PERSONAS CON DISCAPACIDAD SEVERA EN SITUACIÓN DE POBREZA	\N	CONTIGO	30
\.


--
-- TOC entry 5033 (class 0 OID 350026)
-- Dependencies: 230
-- Data for Name: def_sectores; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_sectores (id, codigo, nombre, id_entidad) FROM stdin;
1	01	PRESIDENCIA CONSEJO MINISTROS	1
2	03	CULTURA	1
3	04	PODER JUDICIAL	1
4	05	AMBIENTAL	1
5	06	JUSTICIA	1
6	07	INTERIOR	1
7	08	RELACIONES EXTERIORES	1
8	09	ECONOMIA Y FINANZAS	1
9	10	EDUCACION	1
10	11	SALUD	1
11	12	TRABAJO Y PROMOCION DEL EMPLEO	1
12	13	AGRARIO Y DE RIEGO	1
13	16	ENERGIA Y MINAS	1
14	19	CONTRALORIA GENERAL	4
15	20	DEFENSORIA DEL PUEBLO	4
16	21	JUNTA NACIONAL DE JUSTICIA	4
17	22	MINISTERIO PUBLICO	1
18	24	TRIBUNAL CONSTITUCIONAL	4
19	26	DEFENSA	1
20	27	FUERO MILITAR POLICIAL	4
21	28	CONGRESO DE LA REPUBLICA	2
22	31	JURADO NACIONAL DE ELECCIONES	4
23	32	OFICINA NACIONAL DE PROCESOS ELECTORALES	4
24	33	REGISTRO NACIONAL DE IDENTIFICACION Y ESTADO CIVIL	4
25	35	COMERCIO EXTERIOR Y TURISMO	1
26	36	TRANSPORTES Y COMUNICACIONES	1
27	37	VIVIENDA CONSTRUCCION Y SANEAMIENTO	1
28	38	PRODUCCION	1
29	39	MUJER Y POBLACIONES VULNERABLES	1
30	40	DESARROLLO E INCLUSION SOCIAL	1
31	99	GOBIERNOS REGIONALES	5
32	M	GOBIERNOS MUNICIPALES	6
33	B	BOMBEROS	4
34	ONG	ORGANISMOS NO GUBERNAMENTALES	7
35	I	ORGANIZACIONES INTERNACIONALES	8
36	P	PRIVADO	9
\.


--
-- TOC entry 5043 (class 0 OID 350115)
-- Dependencies: 240
-- Data for Name: def_servicios_geograficos; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_servicios_geograficos (id, id_capa, id_tipo_servicio, direccion_web, nombre_layer, visible) FROM stdin;
\.


--
-- TOC entry 5031 (class 0 OID 350015)
-- Dependencies: 228
-- Data for Name: def_tipos_servicios; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_tipos_servicios (id, nombre, descripcion, estado, logotipo, orden, id_padre) FROM stdin;
1	Herramientas digitales	Son un conjunto de herramientas GIS que pertite compartir diferentes datos geográficos.	t	\N	1	0
2	Servicios OGC	Los servicios del Open Geospatial Consortium son estándares internacionales que permiten a diferentes sistemas compartir y acceder a datos e información geográfica a través de la web de forma abierta e interoperable.	t	\N	2	0
3	Servicios Rest de ArcGIS	Los Servicios REST de ArcGIS son una tecnología que permite a las aplicaciones conectarse y consultar datos y funcionalidades geográficas a través de la red usando el protocolo HTTP	t	\N	3	0
4	Geoportales	Geoportales de entidades públicas.	t	\N	1	1
5	Visores de mapas	Visores de mapas institucionales.	t	\N	2	1
6	Aplicaciones y módulos	Aplicaciones GIS y módulos geográficos.	t	\N	3	1
7	Descarga GIS (HTTPS, FTP)	Servicio de descarga.	t	\N	4	1
8	OGC:WMS	Servicio de visualización de mapas.	t	\N	1	2
9	OGC:WFS	Servicio de consulta y descarga de mapas.	t	\N	2	2
10	OGC:WCS	Servicio de imagenes de mapas.	t	\N	3	2
11	OGC:WMTS	Servicio de mosaicos de mapas.	t	\N	4	2
12	OGC:CSW	Servicio de catalogación de metadatos.	t	\N	5	2
13	OGC:WPS	Servicio de geoprocesamiento	t	\N	6	2
14	REST:ArcGIS MapServer	Servicio Rest de visualización de mapas	t	\N	1	3
15	REST:ArcGIS FeatureServer	Servicio Rest de acceso a mapas	t	\N	2	3
16	REST:ArcGIS ImageServer	Servicio Rest de imagenes	t	\N	3	3
17	REST:ArcGIS KML	Servicio Rest de exportación a formato KML	t	\N	4	3
18	REST:ArcGIS Geoprocessing	Servicio Rest de geoprocesamiento	t	\N	5	3
\.


--
-- TOC entry 5041 (class 0 OID 350095)
-- Dependencies: 238
-- Data for Name: def_usuarios; Type: TABLE DATA; Schema: ide; Owner: postgres
--

COPY ide.def_usuarios (id, username, email, password, confirmed, confirmation_token, id_institucion) FROM stdin;
1	luisamos	luis.valer.v@gmail.com	scrypt:32768:8:1$EnUOwxP7EvUc0ZNm$74bc6b57b2adfaf722cbfbb9886194bf8f82f02232facd4620256e444412f2c78992eb9fde7b2c501c08e08bc0b17852d0d34075fced48811ca5b1cbde2f5fb7	t	XKsjsUdT8n-Ut0rw6PrkOQvDFJYfy7bvlijlVtNSwBA	1
\.


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 233
-- Name: def_capas_geograficas_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_capas_geograficas_id_seq', 1, false);


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 223
-- Name: def_categorias_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_categorias_id_seq', 20, true);


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 225
-- Name: def_entidades_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_entidades_id_seq', 9, true);


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 235
-- Name: def_herramientas_digitales_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_herramientas_digitales_id_seq', 210, true);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 231
-- Name: def_instituciones_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_instituciones_id_seq', 2103, true);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 229
-- Name: def_sectores_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_sectores_id_seq', 36, true);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 239
-- Name: def_servicios_geograficos_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_servicios_geograficos_id_seq', 1, false);


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 227
-- Name: def_tipos_servicios_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_tipos_servicios_id_seq', 18, true);


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 237
-- Name: def_usuarios_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: postgres
--

SELECT pg_catalog.setval('ide.def_usuarios_id_seq', 1, true);


--
-- TOC entry 4860 (class 2606 OID 350059)
-- Name: def_capas_geograficas def_capas_geograficas_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_capas_geograficas
    ADD CONSTRAINT def_capas_geograficas_pkey PRIMARY KEY (id);


--
-- TOC entry 4846 (class 2606 OID 350006)
-- Name: def_categorias def_categorias_codigo_key; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_categorias
    ADD CONSTRAINT def_categorias_codigo_key UNIQUE (codigo);


--
-- TOC entry 4848 (class 2606 OID 350004)
-- Name: def_categorias def_categorias_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_categorias
    ADD CONSTRAINT def_categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 350013)
-- Name: def_entidades def_entidades_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_entidades
    ADD CONSTRAINT def_entidades_pkey PRIMARY KEY (id);


--
-- TOC entry 4862 (class 2606 OID 350078)
-- Name: def_herramientas_digitales def_herramientas_digitales_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 350045)
-- Name: def_instituciones def_instituciones_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_instituciones
    ADD CONSTRAINT def_instituciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 350031)
-- Name: def_sectores def_sectores_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_sectores
    ADD CONSTRAINT def_sectores_pkey PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 350122)
-- Name: def_servicios_geograficos def_servicios_geograficos_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_servicios_geograficos
    ADD CONSTRAINT def_servicios_geograficos_pkey PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 350024)
-- Name: def_tipos_servicios def_tipos_servicios_nombre_key; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_tipos_servicios
    ADD CONSTRAINT def_tipos_servicios_nombre_key UNIQUE (nombre);


--
-- TOC entry 4854 (class 2606 OID 350022)
-- Name: def_tipos_servicios def_tipos_servicios_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_tipos_servicios
    ADD CONSTRAINT def_tipos_servicios_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 350104)
-- Name: def_usuarios def_usuarios_confirmation_token_key; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_confirmation_token_key UNIQUE (confirmation_token);


--
-- TOC entry 4866 (class 2606 OID 350106)
-- Name: def_usuarios def_usuarios_email_key; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_email_key UNIQUE (email);


--
-- TOC entry 4868 (class 2606 OID 350102)
-- Name: def_usuarios def_usuarios_pkey; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 2606 OID 350108)
-- Name: def_usuarios def_usuarios_username_key; Type: CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_username_key UNIQUE (username);


--
-- TOC entry 4875 (class 2606 OID 350060)
-- Name: def_capas_geograficas def_capas_geograficas_id_categoria_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_capas_geograficas
    ADD CONSTRAINT def_capas_geograficas_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES ide.def_categorias(id);


--
-- TOC entry 4876 (class 2606 OID 350065)
-- Name: def_capas_geograficas def_capas_geograficas_id_institucion_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_capas_geograficas
    ADD CONSTRAINT def_capas_geograficas_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES ide.def_instituciones(id);


--
-- TOC entry 4877 (class 2606 OID 350079)
-- Name: def_herramientas_digitales def_herramientas_digitales_id_categoria_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES ide.def_categorias(id);


--
-- TOC entry 4878 (class 2606 OID 350084)
-- Name: def_herramientas_digitales def_herramientas_digitales_id_institucion_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES ide.def_instituciones(id);


--
-- TOC entry 4879 (class 2606 OID 350089)
-- Name: def_herramientas_digitales def_herramientas_digitales_id_tipo_servicio_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_id_tipo_servicio_fkey FOREIGN KEY (id_tipo_servicio) REFERENCES ide.def_tipos_servicios(id);


--
-- TOC entry 4874 (class 2606 OID 350046)
-- Name: def_instituciones def_instituciones_id_sector_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_instituciones
    ADD CONSTRAINT def_instituciones_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES ide.def_sectores(id);


--
-- TOC entry 4873 (class 2606 OID 350032)
-- Name: def_sectores def_sectores_id_entidad_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_sectores
    ADD CONSTRAINT def_sectores_id_entidad_fkey FOREIGN KEY (id_entidad) REFERENCES ide.def_entidades(id);


--
-- TOC entry 4881 (class 2606 OID 350123)
-- Name: def_servicios_geograficos def_servicios_geograficos_id_capa_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_servicios_geograficos
    ADD CONSTRAINT def_servicios_geograficos_id_capa_fkey FOREIGN KEY (id_capa) REFERENCES ide.def_capas_geograficas(id);


--
-- TOC entry 4882 (class 2606 OID 350128)
-- Name: def_servicios_geograficos def_servicios_geograficos_id_tipo_servicio_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_servicios_geograficos
    ADD CONSTRAINT def_servicios_geograficos_id_tipo_servicio_fkey FOREIGN KEY (id_tipo_servicio) REFERENCES ide.def_tipos_servicios(id);


--
-- TOC entry 4880 (class 2606 OID 350109)
-- Name: def_usuarios def_usuarios_id_institucion_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: postgres
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES ide.def_instituciones(id);


-- Completed on 2025-10-06 09:10:26

--
-- PostgreSQL database dump complete
--

\unrestrict MTmppWC1BOXzeOUUk7g2yAgFj53f2Ev0hyqw3CVpDjBE4iOcFzcaZKtJ2YkqHC6

