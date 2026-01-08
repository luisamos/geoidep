--
-- PostgreSQL database dump
--

\restrict h1Ob3z60u5uDIbj10qrf4dnvBt6SkDEGBQNZBtlYdPIfWneLdukPtQ8X7jK2pY7

-- Dumped from database version 16.11
-- Dumped by pg_dump version 18.0

-- Started on 2026-01-07 14:25:09

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
-- TOC entry 8 (class 2615 OID 373803)
-- Name: ide; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ide;


ALTER SCHEMA ide OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 239 (class 1259 OID 373869)
-- Name: def_capas_geograficas; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_capas_geograficas (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion character varying(500),
    tipo_capa integer NOT NULL,
    publicar_geoperu boolean,
    fecha_registro date,
    id_categoria integer NOT NULL,
    id_institucion integer NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_capas_geograficas OWNER TO usrgeoperuprd;

--
-- TOC entry 238 (class 1259 OID 373868)
-- Name: def_capas_geograficas_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_capas_geograficas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_capas_geograficas_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5895 (class 0 OID 0)
-- Dependencies: 238
-- Name: def_capas_geograficas_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_capas_geograficas_id_seq OWNED BY ide.def_capas_geograficas.id;


--
-- TOC entry 229 (class 1259 OID 373805)
-- Name: def_categorias; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_categorias (
    id integer NOT NULL,
    codigo character varying(5) NOT NULL,
    nombre character varying(500) NOT NULL,
    sigla character varying(500) NOT NULL,
    definicion text,
    id_padre integer DEFAULT 1 NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_categorias OWNER TO usrgeoperuprd;

--
-- TOC entry 228 (class 1259 OID 373804)
-- Name: def_categorias_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_categorias_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5896 (class 0 OID 0)
-- Dependencies: 228
-- Name: def_categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_categorias_id_seq OWNED BY ide.def_categorias.id;


--
-- TOC entry 241 (class 1259 OID 373890)
-- Name: def_herramientas_digitales; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_herramientas_digitales (
    id integer NOT NULL,
    id_tipo_servicio integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion text,
    estado boolean,
    recurso text,
    id_categoria integer NOT NULL,
    id_institucion integer NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_herramientas_digitales OWNER TO usrgeoperuprd;

--
-- TOC entry 240 (class 1259 OID 373889)
-- Name: def_herramientas_digitales_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_herramientas_digitales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_herramientas_digitales_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5897 (class 0 OID 0)
-- Dependencies: 240
-- Name: def_herramientas_digitales_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_herramientas_digitales_id_seq OWNED BY ide.def_herramientas_digitales.id;


--
-- TOC entry 231 (class 1259 OID 373819)
-- Name: def_instituciones; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_instituciones (
    id integer NOT NULL,
    codigo character varying(20),
    ubigeo character varying(20),
    nombre character varying(800) NOT NULL,
    nro_ruc character varying(11),
    direccion_web character varying(255),
    sigla character varying(50),
    logotipo text,
    orden integer DEFAULT 1 NOT NULL,
    estado boolean DEFAULT true,
    id_padre integer NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_instituciones OWNER TO usrgeoperuprd;

--
-- TOC entry 230 (class 1259 OID 373818)
-- Name: def_instituciones_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_instituciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_instituciones_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5898 (class 0 OID 0)
-- Dependencies: 230
-- Name: def_instituciones_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_instituciones_id_seq OWNED BY ide.def_instituciones.id;


--
-- TOC entry 233 (class 1259 OID 373832)
-- Name: def_perfiles; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_perfiles (
    id integer NOT NULL,
    nombre character varying(120) NOT NULL,
    estado boolean DEFAULT true,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_perfiles OWNER TO usrgeoperuprd;

--
-- TOC entry 232 (class 1259 OID 373831)
-- Name: def_perfiles_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_perfiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_perfiles_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5899 (class 0 OID 0)
-- Dependencies: 232
-- Name: def_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_perfiles_id_seq OWNED BY ide.def_perfiles.id;


--
-- TOC entry 235 (class 1259 OID 373844)
-- Name: def_personas; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_personas (
    id integer NOT NULL,
    id_tipo_documento integer,
    numero_documento character varying(20),
    nombres_apellidos text,
    celular character varying(20),
    fotografia character varying(256),
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_personas OWNER TO usrgeoperuprd;

--
-- TOC entry 234 (class 1259 OID 373843)
-- Name: def_personas_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_personas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_personas_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5900 (class 0 OID 0)
-- Dependencies: 234
-- Name: def_personas_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_personas_id_seq OWNED BY ide.def_personas.id;


--
-- TOC entry 245 (class 1259 OID 373943)
-- Name: def_servicios_geograficos; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_servicios_geograficos (
    id integer NOT NULL,
    id_capa integer NOT NULL,
    id_tipo_servicio integer NOT NULL,
    direccion_web text NOT NULL,
    nombre_capa character varying(200),
    titulo_capa character varying(500),
    estado boolean,
    id_layer integer NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_servicios_geograficos OWNER TO usrgeoperuprd;

--
-- TOC entry 244 (class 1259 OID 373942)
-- Name: def_servicios_geograficos_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_servicios_geograficos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_servicios_geograficos_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5901 (class 0 OID 0)
-- Dependencies: 244
-- Name: def_servicios_geograficos_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_servicios_geograficos_id_seq OWNED BY ide.def_servicios_geograficos.id;


--
-- TOC entry 237 (class 1259 OID 373855)
-- Name: def_tipos_servicios; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_tipos_servicios (
    id integer NOT NULL,
    tag character varying(40),
    sigla character varying(30),
    nombre character varying(100) NOT NULL,
    descripcion text,
    estado boolean DEFAULT true,
    logotipo text,
    orden integer NOT NULL,
    id_padre integer NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_tipos_servicios OWNER TO usrgeoperuprd;

--
-- TOC entry 236 (class 1259 OID 373854)
-- Name: def_tipos_servicios_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_tipos_servicios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_tipos_servicios_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5902 (class 0 OID 0)
-- Dependencies: 236
-- Name: def_tipos_servicios_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_tipos_servicios_id_seq OWNED BY ide.def_tipos_servicios.id;


--
-- TOC entry 243 (class 1259 OID 373916)
-- Name: def_usuarios; Type: TABLE; Schema: ide; Owner: usrgeoperuprd
--

CREATE TABLE ide.def_usuarios (
    id integer NOT NULL,
    correo_electronico character varying(120) NOT NULL,
    contrasena character varying(256) NOT NULL,
    estado boolean DEFAULT true,
    fecha_baja date,
    geoidep boolean NOT NULL,
    geoperu boolean NOT NULL,
    metadatos boolean NOT NULL,
    id_perfil integer NOT NULL,
    id_persona integer NOT NULL,
    id_institucion integer NOT NULL,
    usuario_crea integer DEFAULT 1 NOT NULL,
    fecha_crea timestamp with time zone DEFAULT now() NOT NULL,
    usuario_modifica integer,
    fecha_modifica timestamp with time zone
);


ALTER TABLE ide.def_usuarios OWNER TO usrgeoperuprd;

--
-- TOC entry 242 (class 1259 OID 373915)
-- Name: def_usuarios_id_seq; Type: SEQUENCE; Schema: ide; Owner: usrgeoperuprd
--

CREATE SEQUENCE ide.def_usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ide.def_usuarios_id_seq OWNER TO usrgeoperuprd;

--
-- TOC entry 5903 (class 0 OID 0)
-- Dependencies: 242
-- Name: def_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: ide; Owner: usrgeoperuprd
--

ALTER SEQUENCE ide.def_usuarios_id_seq OWNED BY ide.def_usuarios.id;


--
-- TOC entry 5675 (class 2604 OID 373872)
-- Name: def_capas_geograficas id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_capas_geograficas ALTER COLUMN id SET DEFAULT nextval('ide.def_capas_geograficas_id_seq'::regclass);


--
-- TOC entry 5655 (class 2604 OID 373808)
-- Name: def_categorias id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_categorias ALTER COLUMN id SET DEFAULT nextval('ide.def_categorias_id_seq'::regclass);


--
-- TOC entry 5678 (class 2604 OID 373893)
-- Name: def_herramientas_digitales id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_herramientas_digitales ALTER COLUMN id SET DEFAULT nextval('ide.def_herramientas_digitales_id_seq'::regclass);


--
-- TOC entry 5659 (class 2604 OID 373822)
-- Name: def_instituciones id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_instituciones ALTER COLUMN id SET DEFAULT nextval('ide.def_instituciones_id_seq'::regclass);


--
-- TOC entry 5664 (class 2604 OID 373835)
-- Name: def_perfiles id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_perfiles ALTER COLUMN id SET DEFAULT nextval('ide.def_perfiles_id_seq'::regclass);


--
-- TOC entry 5668 (class 2604 OID 373847)
-- Name: def_personas id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_personas ALTER COLUMN id SET DEFAULT nextval('ide.def_personas_id_seq'::regclass);


--
-- TOC entry 5685 (class 2604 OID 373946)
-- Name: def_servicios_geograficos id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_servicios_geograficos ALTER COLUMN id SET DEFAULT nextval('ide.def_servicios_geograficos_id_seq'::regclass);


--
-- TOC entry 5671 (class 2604 OID 373858)
-- Name: def_tipos_servicios id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_tipos_servicios ALTER COLUMN id SET DEFAULT nextval('ide.def_tipos_servicios_id_seq'::regclass);


--
-- TOC entry 5681 (class 2604 OID 373919)
-- Name: def_usuarios id; Type: DEFAULT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_usuarios ALTER COLUMN id SET DEFAULT nextval('ide.def_usuarios_id_seq'::regclass);


--
-- TOC entry 5883 (class 0 OID 373869)
-- Dependencies: 239
-- Data for Name: def_capas_geograficas; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_capas_geograficas (id, nombre, descripcion, tipo_capa, publicar_geoperu, fecha_registro, id_categoria, id_institucion, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	Agrario	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
2	Agrarios	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
3	Ámbito VRAEM	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
4	Bienes y servicios	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
5	Casos al 01 de setiembre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
6	Casos al 01 de setiembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
7	Casos al 01 de setiembre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
8	Casos al 02 de junio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
9	Casos al 02 de junio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
10	Casos al 03 de febrero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
11	Casos al 03 de marzo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
12	Casos al 04 de agosto del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
13	Casos al 04 de agosto del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
14	Casos al 04 de agosto del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
15	Casos al 04 de julio 2022	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
16	Casos al 04 de noviembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
17	Casos al 05 de mayo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
18	Casos al 05 de mayo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
19	Casos al 05 de octubre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
20	Casos al 06 de Diciembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
21	Casos al 06 de enero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
22	Casos al 06 de octubre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
23	Casos al 07 de abril del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
24	Casos al 07 de abril del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
25	Casos al 07 de julio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
26	Casos al 07 de julio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
27	Casos al 07 de octubre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
28	Casos al 08 de Noviembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
29	Casos al 08 de setiembre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
30	Casos al 08 de setiembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
31	Casos al 08 de setiembre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
32	Casos al 09 de junio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
33	Casos al 09 de junio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
34	Casos al 10 de diciembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
35	Casos al 10 de febrero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
36	Casos al 10 de marzo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
37	Casos al 11 de agosto del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
38	Casos al 11 de agosto del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
39	Casos al 11 de agosto del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
40	Casos al 11 de noviembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
41	Casos al 12 de mayo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
42	Casos al 12 de mayo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
43	Casos al 13 de Diciembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
44	Casos al 13 de enero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
45	Casos al 13 de octubre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
46	Casos al 13 de octubre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
47	Casos al 14 de abril del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
48	Casos al 14 de abril del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
49	Casos al 14 de julio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
50	Casos al 14 de julio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
51	Casos al 14 de octubre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
52	Casos al 15 de Noviembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
53	Casos al 15 de setiembre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
54	Casos al 15 de setiembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
55	Casos al 15 de setiembre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
56	Casos al 16 de diciembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
57	Casos al 16 de junio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
58	Casos al 16 de junio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
59	Casos al 17 de febrero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
60	Casos al 17 de marzo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
61	Casos al 17 de marzo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
62	Casos al 18 de agosto del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
63	Casos al 18 de agosto del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
64	Casos al 18 de agosto del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
65	Casos al 18 de noviembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
66	Casos al 18 de Octubre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
67	Casos al 19 de mayo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
68	Casos al 19 de mayo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
69	Casos al 20 de Diciembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
70	Casos al 20 de enero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
71	Casos al 20 de octubre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
72	Casos al 20 de octubre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
73	Casos al 21 de abril del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
74	Casos al 21 de abril del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
75	Casos al 21 de julio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
76	Casos al 21 de julio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
77	Casos al 21 de octubre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
78	Casos al 22 de junio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
79	Casos al 22 de Noviembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
80	Casos al 22 de setiembre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
81	Casos al 22 de setiembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
82	Casos al 22 de setiembre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
83	Casos al 23 de junio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
84	Casos al 24 de febrero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
85	Casos al 24 de marzo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
86	Casos al 24 de marzo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
87	Casos al 25 de agosto del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
88	Casos al 25 de agosto del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
89	Casos al 25 de agosto del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
90	Casos al 25 de noviembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
91	Casos al 25 de Octubre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
92	Casos al 26 de mayo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
93	Casos al 26 de mayo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
94	Casos al 27 de enero del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
95	Casos al 27 de octubre del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
96	Casos al 27 de octubre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
97	Casos al 28 de abril del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
98	Casos al 28 de abril del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
99	Casos al 28 de julio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
100	Casos al 28 de octubre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
101	Casos al 29 de Noviembre 2021	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
102	Casos al 29 de setiembre del 2024	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
103	Casos al 29 de setiembre del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
104	Casos al 30 de julio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
105	Casos al 30 de junio del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
106	Casos al 30 de junio del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
107	Casos al 31 de marzo del 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
108	Casos al 31 de marzo del 2025	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
109	Centros MAC	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
110	Consejo de Coordinación Regional (CCR)	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
111	Delimitación Territorial	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
112	Demarcación territorial	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
113	Educación	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
114	Gestión de Recursos Públicos	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
115	Gobernabilidad	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
116	Hídrico	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
117	Hídricos	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
118	Hidrocarburos	\N	1	t	\N	20	45	1	2026-01-07 09:45:35.443767-05	\N	\N
119	Industria Socioambiental	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
120	Infraestructura	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
121	Infraestructura Socioambiental	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
122	Invasión de Terrenos	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
123	Laboral	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
124	Laborales Gremiales	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
125	Laboratorios de la Academia	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
126	Laboratorios de la Sociedad Civil	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
127	Laboratorios del Sector Privado	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
128	Laboratorios del Sector Público	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
129	MAC Express Municipalidades	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
130	MAC Express PIAS	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
131	MAC Express TAMBOS	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
132	Marzo 2023	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
133	Minería	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
134	Minería Ilegal	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
135	Minería Laboral	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
136	Otros	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
137	Programa Niñas Digitales - Edición 1	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
138	Programa Niñas Digitales - Edición 3	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
139	Programa Niñas Digitales - Edición 4	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
140	Programa Niñas Digitales - Edición 5	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
141	Programa Niñas Digitales - ORACLE	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
142	Programa Niñas Digitales - Perú EDUCA	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
143	Transporte	\N	1	t	\N	17	45	1	2026-01-07 09:45:35.443767-05	\N	\N
144	Áreas Verdes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
145	Autoridades por Género	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
146	Calles	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
147	Campo o Instalación Deportiva	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
148	Capital de Departamento	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
149	Capital de Provincia	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
150	Capital Humano	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
151	Casos de Feminicidio	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
152	Catastro Municipal	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
153	CCL - Distrital	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
154	CCL - Provincial	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
155	CCL - Provincial - (Impl.)	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
156	Cementerio	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
157	Centro de Abastos	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
158	Centro de Acopio	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
159	Centro Poblado	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
160	Centro Poblado (ámbito geográfico)	\N	1	f	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
161	Centro Poblado (población censada)	\N	1	f	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
162	Ciudadanía Digital Per cápita (%)	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
163	Club	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
164	Club de Madres	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
165	Comedores Populares	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
166	Complejo	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
167	Con al menos una NBI	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
168	Con al Menos una NBI	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
169	Con Piso de Tierra	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
170	Con una Habitación	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
171	De 1,001 a 2,500 Habitantes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
172	De 151 a 1,000 Habitantes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
173	De 2,501 a 5,000 Habitantes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
174	De 5,001 a 500,000 Habitantes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
175	Distritos más pobres	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
176	Energía o Combustible para Cocinar	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
177	Esquema de Ordenamiento Urbano	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
178	Ferias	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
179	Hog. con Alta Dependencia Económica	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
180	Hogares que Cocinan con Leña	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
181	Hogares sin Internet	\N	1	t	\N	20	46	1	2026-01-07 09:45:35.443767-05	\N	\N
182	Ingreso per cápita del Hogar	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
183	IV Censo Nacional Económico 2008	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
184	Límite Departamental	\N	1	t	\N	4	46	1	2026-01-07 09:45:35.443767-05	\N	\N
185	Límite Distrital	\N	1	t	\N	4	46	1	2026-01-07 09:45:35.443767-05	\N	\N
186	Límite Provincial	\N	1	t	\N	4	46	1	2026-01-07 09:45:35.443767-05	\N	\N
187	Local Comunal y Otros	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
188	Manzana	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
189	Más de 500,000 Habitantes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
190	Material de la Vivienda	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
191	Menos de 151 Habitantes	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
192	Mercado	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
193	Mujer	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
194	No Sabe Escribir/Leer	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
195	Organizaciones Juveniles	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
196	PEA	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
197	Pesquería Artesanal	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
198	Plan de Desarrollo de Capacidades	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
199	Plan de Desarrollo Económico Local	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
200	Plan de Gestión de Riesgos de Desastres	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
201	Plan Estratégico Institucional	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
202	Población Adulto Mayor de 65 años y más	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
203	Población Dispersa	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
204	Pobreza Monetaria - Dist. 2018	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
205	Pobreza Monetaria - Regional 2022	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
206	Productores - Distrito	\N	1	t	\N	2	46	1	2026-01-07 09:45:35.443767-05	\N	\N
207	Productores - SEA	\N	1	t	\N	2	46	1	2026-01-07 09:45:35.443767-05	\N	\N
208	Programa del Vaso de Leche	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
209	Proyectada Departamentos	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
210	Proyectada Distritos	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
211	Sin Abastecimiento de Agua	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
212	Sin Alumbrado Eléctrico	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
213	Sin Seguro de Salud	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
214	Técnicos y Auxiliares	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
215	Viv. con Caract. Físicas Inadecuadas	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
216	Viv. con Hacinamiento	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
217	Viviendas con Piso de Tierra	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
218	Viviendas en Cerros - Distritos	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
219	Viviendas en Cerros - Manzanas	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
220	Viviendas sin Abastecimiento de Agua	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
221	Viviendas sin Alumbrado Eléctrico	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
222	Viviendas sin Servicios Higiénicos	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
223	Zonas Urbanas	\N	1	t	\N	17	46	1	2026-01-07 09:45:35.443767-05	\N	\N
224	Densidad de Cultivos de Coca 2012-2020	\N	1	f	\N	17	49	1	2026-01-07 09:45:35.443767-05	\N	\N
225	Zonas Cocaleras	\N	1	f	\N	2	49	1	2026-01-07 09:45:35.443767-05	\N	\N
226	Zonas Estratégicas de Intervención	\N	1	t	\N	17	49	1	2026-01-07 09:45:35.443767-05	\N	\N
227	Bitel	\N	1	t	\N	20	51	1	2026-01-07 09:45:35.443767-05	\N	\N
228	Claro	\N	1	t	\N	20	51	1	2026-01-07 09:45:35.443767-05	\N	\N
229	Entel	\N	1	t	\N	20	51	1	2026-01-07 09:45:35.443767-05	\N	\N
230	Movistar	\N	1	t	\N	20	51	1	2026-01-07 09:45:35.443767-05	\N	\N
231	Todos los operadores Internet Móvil	\N	1	t	\N	20	51	1	2026-01-07 09:45:35.443767-05	\N	\N
232	Alumbrado público - Equipos	\N	1	f	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
233	Alumbrado público - Tramos	\N	1	f	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
234	Red de baja tensión - Estructuras	\N	1	f	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
235	Red de baja tensión - Tramos	\N	1	f	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
236	Red de media tensión - Estructuras	\N	1	f	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
237	Red de media tensión - Tramos	\N	1	f	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
238	Redes distribución de gas natural	\N	1	t	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
239	Subestación de distribución eléctrica	\N	1	t	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
240	Suministros eléctricos - Acometida	\N	1	t	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
241	Suministros eléctricos - Suministro	\N	1	t	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
242	Tubería de conexión gas natural	\N	1	t	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
243	Válvulas de gas natural	\N	1	t	\N	17	52	1	2026-01-07 09:45:35.443767-05	\N	\N
244	Área de la prestación de servicios de saneamiento	\N	1	f	\N	17	53	1	2026-01-07 09:45:35.443767-05	\N	\N
245	Convenios Colectivos - Local	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
246	Convenios Colectivos - Nacional	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
247	E.P. con asistencia técnica MCC y CAP	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
248	E.P. con dotación aprobada	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
249	E.P. con dotación y MPP aprobados	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
250	Entidades Públicas (E.P.) con CAP Provisional	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
251	Local	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
252	Nacional	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
253	Regional	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
254	Seguimiento a Seguridad y Salud en el Trabajo - Local	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
255	Seguimiento a Seguridad y Salud en el Trabajo - Nacional	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
256	Seguimiento a Seguridad y Salud en el Trabajo - Regional	\N	1	t	\N	17	55	1	2026-01-07 09:45:35.443767-05	\N	\N
257	Concesión Forestal	\N	1	t	\N	5	56	1	2026-01-07 09:45:35.443767-05	\N	\N
258	Supervisiones Forestales	\N	1	f	\N	5	56	1	2026-01-07 09:45:35.443767-05	\N	\N
259	Proyectos de Inversión - ANIN	\N	1	t	\N	17	57	1	2026-01-07 09:45:35.443767-05	\N	\N
260	Infraestructura deportiva - Sedes legado	\N	1	t	\N	17	61	1	2026-01-07 09:45:35.443767-05	\N	\N
261	Caminos del Inca	\N	1	t	\N	19	62	1	2026-01-07 09:45:35.443767-05	\N	\N
262	Comunidades Nativas y Campesinas	\N	1	t	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
263	cultura_arte	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
264	cultura_centros_poblados	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
265	cultura_localidad	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
266	cultura_map	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
267	cultura_museos	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
268	cultura_paisaje_cultural	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
269	cultura_reserva_indigena	\N	1	f	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
270	Monumentos arqueológicos prehispánicos	\N	1	t	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
271	Museos	\N	1	t	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
272	Reservas Indígenas (PIACI)	\N	1	t	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
273	Zonas Arqueológicas	\N	1	t	\N	17	62	1	2026-01-07 09:45:35.443767-05	\N	\N
274	Bosque y pérdida de bosques al 2023	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
275	Capas de servicios genéticos y bioseguridad	\N	1	f	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
276	Cobertura Vegetal	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
277	Condiciones Favorables para la Ocurrencia de Incendios	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
278	Degradación de ecosistemas 2022	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
279	Ecosistemas	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
280	Infraestructura sanitaria	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
281	Pérdida de Bosque 2001 al 2023	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
282	Registro histórico de incendios en la cobertura vegetal	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
283	Sitios RAMSAR	\N	1	t	\N	5	68	1	2026-01-07 09:45:35.443767-05	\N	\N
284	ANP de Administracion Nacional Definitiva	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
285	ANP de Administracion Nacional Transitoria	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
286	Área de Conservación Privada	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
287	Área de Conservación Regional	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
288	Áreas Naturales Protegidas de Administración Nacional Definitiva	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
289	Áreas Naturales Protegidas de Administración Nacional Transitoria	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
290	Zonas de amortiguamiento en Áreas Naturales Protegidas	\N	1	f	\N	5	69	1	2026-01-07 09:45:35.443767-05	\N	\N
291	Zonificación ACP	\N	1	f	\N	8	69	1	2026-01-07 09:45:35.443767-05	\N	\N
292	Zonificación ACR	\N	1	f	\N	8	69	1	2026-01-07 09:45:35.443767-05	\N	\N
293	Zonificación ANP	\N	1	f	\N	8	69	1	2026-01-07 09:45:35.443767-05	\N	\N
294	Componentes fiscalizables - Depósito de relave mineros	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
295	Conflictos socioambientales - Áreas de influencia	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
296	Conflictos socioambientales - Mesas de diálogo	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
297	Denuncias ambientales registradas	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
298	Grifos y EESS. Gasocentros	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
299	Inventario de áreas degradadas por RRSS no municipales	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
300	Inventario nacional de áreas de infraestructura de RRSS	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
301	Inventario nacional de áreas degradadas por RRSS municipales	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
302	Lotes Explotación	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
303	Oleoducto Nor Peruano	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
304	Red de vigilancia ambiental de la calidad del aire	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
305	Reporta Residuos - Alertas de residuos sólidos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
306	Unidad fiscalizable - Ductos de transporte de hidrocarburos líquidos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
307	Unidad fiscalizable - Red de distribución Calidda	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
308	Unidad fiscalizable - Red de distribución Contugas	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
309	Unidades fiscalizables - Agricultura (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
310	Unidades fiscalizables - Agricultura (punto)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
311	Unidades fiscalizables - Áreas degrad. por RRSS no municipales	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
312	Unidades fiscalizables - Áreas degradadas por RRSS municipales	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
313	Unidades fiscalizables - Centrales hidroeléctricas existente	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
314	Unidades fiscalizables - Centrales hidroeléctricas proyectada	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
315	Unidades fiscalizables - Centrales termoeléctricas existentes	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
316	Unidades fiscalizables - Centrales termoeléctricas proyectadas	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
317	Unidades fiscalizables - Concesiones de distribución eléctrica	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
318	Unidades fiscalizables - Concesiones de generación electrica	\N	1	f	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
319	Unidades fiscalizables - Consultoras ambientales (línea)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
320	Unidades fiscalizables - Consultoras ambientales (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
321	Unidades fiscalizables - Depósitos concentrados	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
322	Unidades fiscalizables - Derechos acuícolas (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
323	Unidades fiscalizables - Derechos acuícolas (punto)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
324	Unidades fiscalizables - Educación (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
325	Unidades fiscalizables - Generación sistemas eléctricos aislados	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
326	Unidades fiscalizables - Industrias pesqueras	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
327	Unidades fiscalizables - Infraestructuras de RRSS (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
328	Unidades fiscalizables - Infraestructuras de RRSS (punto)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
329	Unidades fiscalizables - Línea de transmisión existente	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
330	Unidades fiscalizables - Línea de transmisión proyectada	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
331	Unidades fiscalizables - Lotes de gas natural	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
332	Unidades fiscalizables - Lotes de hidrocarburos líquidos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
333	Unidades fiscalizables - Minería	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
334	Unidades fiscalizables - Plan de manejo de RRSS municipales	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
335	Unidades fiscalizables - Plantas almacenam. de hidrocarburos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
336	Unidades fiscalizables - Plantas almacenamiento de gas natural	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
337	Unidades fiscalizables - Plantas de procesamiento de gas natural	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
338	Unidades fiscalizables - Plantas distribución de hidrocarburos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
339	Unidades fiscalizables - Plantas envasadora de hidrocarburos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
340	Unidades fiscalizables - Plantas industriales (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
341	Unidades fiscalizables - Plantas industriales (punto)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
342	Unidades fiscalizables - Plantas procesamiento de hidrocarburos	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
343	Unidades fiscalizables - Recurso energético renovable (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
344	Unidades fiscalizables - Recurso energético renovable (punto)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
345	Unidades fiscalizables - Sistema de ductos de transporte de gas	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
346	Unidades fiscalizables - Subestación de distribución	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
347	Unidades fiscalizables - Subestación de transmision existente	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
348	Unidades fiscalizables - Unid. menores hidrocarburos (polígono)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
349	Unidades fiscalizables - Unid.menores hidrocarburos (punto)	\N	1	t	\N	5	70	1	2026-01-07 09:45:35.443767-05	\N	\N
350	Proyectos del SENACE	\N	1	t	\N	5	71	1	2026-01-07 09:45:35.443767-05	\N	\N
351	Servicio de mapa de publicaciones de la Amazonía	\N	1	t	\N	8	72	1	2026-01-07 09:45:35.443767-05	\N	\N
352	Inventario Nacional de Bofedales	\N	1	t	\N	5	73	1	2026-01-07 09:45:35.443767-05	\N	\N
353	Inventario Nacional de glaciares de origen glaciar	\N	1	t	\N	5	73	1	2026-01-07 09:45:35.443767-05	\N	\N
354	Inventario Nacional de Lagunas de origen glaciar	\N	1	t	\N	5	73	1	2026-01-07 09:45:35.443767-05	\N	\N
355	Anomalías de NDVI (%) (últimos 30 días)	\N	1	f	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
356	Base Histórica de sismos (1475 -1960)	\N	1	f	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
357	Base Histórica de sismos desde 1960	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
358	Catálogo Sísmico Histórico de 1471 a 1959	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
359	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Capacidad Portante	\N	1	f	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
360	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Geodinámica	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
361	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Geología	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
362	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Geomorfología	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
363	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Suelos	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
364	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Zonificación Sísmica	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
365	Mapa de sacudimiento real	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
366	Mapa de sacudimiento teórico	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
367	Monitoreo NDVI	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
368	Sismos reportados	\N	1	f	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
369	Sismos reportados en tiempo real	\N	1	f	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
370	Último Sismo	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
371	Volcanes activos y potencialmente activos del Perú	\N	1	f	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
372	Volcanes: Nivel de alerta	\N	1	t	\N	8	74	1	2026-01-07 09:45:35.443767-05	\N	\N
373	Anomalía de Precipitación 01 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
374	Anomalía de Precipitación 02 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
375	Anomalía de Precipitación 03 Década del mes.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
376	Anomalía de Precipitación Mensual	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
377	Anomalía de Temperatura Máxima 01 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
378	Anomalía de Temperatura Máxima 02 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
379	Anomalía de Temperatura Máxima 03 Década del mes.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
380	Anomalía de Temperatura Máxima Mensual	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
381	Anomalía de Temperatura Mínima 01 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
382	Anomalía de Temperatura Mínima 02 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
383	Anomalía de Temperatura Mínima 03 Década del mes.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
384	Anomalía de Temperatura Mínima Mensual	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
385	Anual	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
386	Atlas de Energia Solar Anual	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
387	Atlas de Energia Solar del mes de Abril.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
388	Atlas de Energia Solar del mes de Agosto.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
389	Atlas de Energia Solar del mes de Diciembre.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
390	Atlas de Energia Solar del mes de Enero.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
391	Atlas de Energia Solar del mes de Febrero.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
392	Atlas de Energia Solar del mes de Julio.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
393	Atlas de Energia Solar del mes de Junio.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
394	Atlas de Energia Solar del mes de Marzo.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
395	Atlas de Energia Solar del mes de Mayo.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
396	Atlas de Energia Solar del mes de Noviembre.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
397	Atlas de Energia Solar del mes de Octubre.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
398	Atlas de Energia Solar del mes de Septiembre.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
399	Cambio Climático (Proyección 2030 Anual)	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
400	Cambio Climático (Proyección de Disponibilidad Hídrica 2020)	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
401	Cambio Climático (Proyección de Disponibilidad Hídrica 2030)	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
402	Cambio de Precipitación 2050 Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
403	Cambio de Precipitación 2050 Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
404	Cambio de Precipitación 2050 Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
405	Cambio de Precipitación 2050 Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
406	Cambio de Precipitación 2050 Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
407	Cambio de Temperatura Máxima 2050 Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
408	Cambio de Temperatura Máxima 2050 Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
409	Cambio de Temperatura Máxima 2050 Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
410	Cambio de Temperatura Máxima 2050 Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
411	Cambio de Temperatura Máxima 2050 Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
412	Cambio de Temperatura Mínima 2050 Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
413	Cambio de Temperatura Mínima 2050 Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
414	Cambio de Temperatura Mínima 2050 Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
415	Cambio de Temperatura Mínima 2050 Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
416	Cambio de Temperatura Mínima 2050 Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
417	Caracterización de Clasificación Climática	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
418	Caracterización de la Duración de Lluvias del Departamento de Puno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
419	Caracterización de Precipitación - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
420	Caracterización de Precipitación - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
421	Caracterización de Precipitación - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
422	Caracterización de Precipitación - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
423	Caracterización de Precipitación - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
424	Caracterización de Precipitación - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
425	Caracterización de Precipitación - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
426	Caracterización de Precipitación - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
427	Caracterización de Precipitación - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
428	Caracterización de Precipitación - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
429	Caracterización de Precipitación - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
430	Caracterización de Precipitación - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
431	Caracterización de Precipitación - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
432	Caracterización de Precipitación - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
433	Caracterización de Precipitación - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
434	Caracterización de Precipitación - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
435	Caracterización de Precipitación - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
436	Caracterización de Precipitación del Departamento de Lima - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
437	Caracterización de Precipitación del Departamento de Lima - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
438	Caracterización de Precipitación del Departamento de Lima - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
439	Caracterización de Precipitación del Departamento de Lima - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
440	Caracterización de Precipitación del Departamento de Lima - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
441	Caracterización de Precipitación del Departamento de Lima - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
442	Caracterización de Precipitación del Departamento de Lima - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
443	Caracterización de Precipitación del Departamento de Lima - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
444	Caracterización de Precipitación del Departamento de Lima - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
445	Caracterización de Precipitación del Departamento de Lima - Mes de Febrero.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
446	Caracterización de Precipitación del Departamento de Lima - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
447	Caracterización de Precipitación del Departamento de Lima - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
448	Caracterización de Precipitación del Departamento de Lima - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
449	Caracterización de Precipitación del Departamento de Lima - Mes de Mayo.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
450	Caracterización de Precipitación del Departamento de Lima - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
451	Caracterización de Precipitación del Departamento de Lima - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
452	Caracterización de Precipitación del Departamento de Lima - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
635	Niño 2023 - Precipitación EFM	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
453	Caracterización de Precipitación del Departamento de San Martín - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
454	Caracterización de Precipitación del Departamento de San Martín - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
455	Caracterización de Precipitación del Departamento de San Martín - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
456	Caracterización de Precipitación del Departamento de San Martín - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
457	Caracterización de Precipitación del Departamento de San Martín - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
458	Caracterización de Precipitación del Departamento de San Martín - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
459	Caracterización de Precipitación del Departamento de San Martín - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
460	Caracterización de Precipitación del Departamento de San Martín - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
461	Caracterización de Precipitación del Departamento de San Martín - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
462	Caracterización de Precipitación del Departamento de San Martín - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
463	Caracterización de Precipitación del Departamento de San Martín - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
464	Caracterización de Precipitación del Departamento de San Martín - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
465	Caracterización de Precipitación del Departamento de San Martín - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
466	Caracterización de Precipitación del Departamento de San Martín - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
467	Caracterización de Precipitación del Departamento de San Martín - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
468	Caracterización de Precipitación del Departamento de San Martín - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
469	Caracterización de Precipitación del Departamento de San Martín - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
470	Caracterización de Temperatura Máxima - Anual	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
471	Caracterización de Temperatura Máxima - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
472	Caracterización de Temperatura Máxima - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
473	Caracterización de Temperatura Máxima - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
474	Caracterización de Temperatura Máxima - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
475	Caracterización de Temperatura Máxima - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
476	Caracterización de Temperatura Máxima - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
477	Caracterización de Temperatura Máxima - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
478	Caracterización de Temperatura Máxima - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
479	Caracterización de Temperatura Máxima - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
480	Caracterización de Temperatura Máxima - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
481	Caracterización de Temperatura Máxima - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
482	Caracterización de Temperatura Máxima - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
483	Caracterización de Temperatura Máxima - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
484	Caracterización de Temperatura Máxima - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
485	Caracterización de Temperatura Máxima - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
486	Caracterización de Temperatura Máxima - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
487	Caracterización de Temperatura Máxima del Departamento de Lima - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
488	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
489	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
490	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
491	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
492	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
493	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
494	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
495	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
496	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
497	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
498	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
499	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
500	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
501	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
502	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
503	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
504	Caracterización de Temperatura Máxima del Departamento de San Martín - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
505	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
506	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
636	Niño 2023 - Precipitación FMA	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
507	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
508	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
509	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
510	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
511	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
512	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
513	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
514	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
515	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
516	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
517	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
518	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
519	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
520	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
521	Caracterización de Temperatura Mínima - Anual	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
522	Caracterización de Temperatura Mínima - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
523	Caracterización de Temperatura Mínima - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
524	Caracterización de Temperatura Mínima - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
525	Caracterización de Temperatura Mínima - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
526	Caracterización de Temperatura Mínima - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
527	Caracterización de Temperatura Mínima - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
528	Caracterización de Temperatura Mínima - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
529	Caracterización de Temperatura Mínima - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
530	Caracterización de Temperatura Mínima - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
531	Caracterización de Temperatura Mínima - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
532	Caracterización de Temperatura Mínima - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
533	Caracterización de Temperatura Mínima - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
534	Caracterización de Temperatura Mínima - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
535	Caracterización de Temperatura Mínima - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
536	Caracterización de Temperatura Mínima del Departamento de Lima - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
537	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
538	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
539	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
540	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
541	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
542	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
543	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
544	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
545	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
546	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
547	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
548	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
549	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
550	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
551	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
552	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
553	Caracterización de Temperatura Mínima del Departamento de San Martín - Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
554	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Invierno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
555	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Otoño.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
556	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Primavera.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
557	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Verano.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
558	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
559	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
560	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
561	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
562	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
563	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
564	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
565	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
566	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
567	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
568	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
569	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
570	Caracterización del Fin de Lluvias del Departamento de Puno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
571	Caracterización del Inicio de Lluvias del Departamento de Puno.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
572	Clasificación Climática	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
573	Descenso Tmin - Agosto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
574	Descenso Tmin - Julio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
575	Descenso Tmin - Junio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
576	Descenso Tmin - Mayo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
577	Disponibilidad Hídrica 2020.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
578	Disponibilidad Hídrica 2030.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
579	Duración Olas de Calor - Invierno	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
580	Duración Olas de Calor - Otoño	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
581	Duración Olas de Calor - Primavera	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
582	Duración Olas de Calor - Verano	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
583	Energía Solar	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
584	Erosión del Suelo	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
585	Erosión Hídrica del Suelo del año 2010.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
586	Erosión Hídrica del Suelo del año 2011.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
587	Erosión Hídrica del Suelo del año 2012.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
588	Erosión Hídrica del Suelo del año 2013.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
589	Erosión Hídrica del Suelo del año 2014	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
590	Evento El Niño / La Niña 2017	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
591	Evento Niño 82-83	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
592	Evento Niño 97-98	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
593	Eventos Olas de Calor - Invierno	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
594	Eventos Olas de Calor - Otoño	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
595	Eventos Olas de Calor - Primavera	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
596	Eventos Olas de Calor - Verano	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
597	Frecuencia de Heladas Anual	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
598	Frecuencia de Heladas del mes de Abril	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
599	Frecuencia de Heladas del mes de Agosto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
600	Frecuencia de Heladas del mes de Diciembre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
601	Frecuencia de Heladas del mes de Enero	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
602	Frecuencia de Heladas del mes de Febrero	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
603	Frecuencia de Heladas del mes de Julio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
604	Frecuencia de Heladas del mes de Junio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
605	Frecuencia de Heladas del mes de Marzo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
606	Frecuencia de Heladas del mes de Mayo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
607	Frecuencia de Heladas del mes de Noviembre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
608	Frecuencia de Heladas del mes de Octubre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
609	Frecuencia de Heladas del mes de Septiembre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
610	Frecuencia Olas de Calor - Invierno	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
611	Frecuencia Olas de Calor - Otoño	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
612	Frecuencia Olas de Calor - Primavera	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
613	Frecuencia Olas de Calor - Verano	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
614	índice de Radiación UV - 48 Hrs	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
615	índice de Radiación UV - 72 Hrs	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
616	Mapa de Zonas de Vida.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
617	Mes de Abril	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
618	Mes de Agosto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
619	Mes de Diciembre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
620	Mes de Enero	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
621	Mes de Febrero	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
622	Mes de Julio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
623	Mes de Junio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
624	Mes de Marzo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
625	Mes de Mayo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
626	Mes de Noviembre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
627	Mes de Octubre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
628	Mes de Septiembre	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
629	Monitoreo de la Precipitación	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
630	Monitoreo de Temperatura Máxima (Mar)	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
631	Monitoreo de Temperatura Mínima (Mar)	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
632	Niño 2017 - Precipitación DEF	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
633	Niño 2017 - Precipitación EFM	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
634	Niño 2017 - Precipitación FMA	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
637	Niño 2024 - Precipitación DEF	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
638	Niño 2024 - Precipitación EFM	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
639	Niño 82 - 83 - Precipitación DEF	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
640	Niño 82 - 83 - Precipitación EFM	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
641	Niño 82 - 83 - Precipitación FMA	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
642	Niño 97 - 98 - Precipitación DEF	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
643	Niño 97 - 98 - Precipitación EFM	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
644	Niño 97 - 98 - Precipitación FMA	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
645	Número de Eventos de Nevadas Promedio Mensual de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
646	Número de Eventos de Nevadas Promedio Mensual de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
647	Número de Eventos de Nevadas Promedio Mensual de Diciembre	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
648	Número de Eventos de Nevadas Promedio Mensual de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
649	Número de Eventos de Nevadas Promedio Mensual de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
650	Número de Eventos de Nevadas Promedio Mensual de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
651	Número de Eventos de Nevadas Promedio Mensual de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
652	Número de Eventos de Nevadas Promedio Mensual de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
653	Número de Eventos de Nevadas Promedio Mensual de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
654	Número de Eventos de Nevadas Promedio Mensual de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
655	Número de Eventos de Nevadas Promedio Mensual de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
656	Número de Eventos de Nevadas Promedio Mensual de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
657	Percentil 1 - Tmin Extrema - Agosto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
658	Percentil 1 - Tmin Extrema - Julio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
659	Percentil 1 - Tmin Extrema - Junio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
660	Percentil 1 - Tmin Extrema - Mayo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
661	Percentil 10 - Tmin Extrema - Agosto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
662	Percentil 10 - Tmin Extrema - Julio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
663	Percentil 10 - Tmin Extrema - Junio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
664	Percentil 10 - Tmin Extrema - Mayo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
665	Percentil 5 - Tmin Extrema - Agosto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
666	Percentil 5 - Tmin Extrema - Julio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
667	Percentil 5 - Tmin Extrema - Junio	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
668	Percentil 5 - Tmin Extrema - Mayo	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
669	Predicción Numérica - Modelo Pp 24 Hrs.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
670	Predicción Numérica - Modelo Pp 48 Hrs.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
671	Predicción Numérica - Modelo Pp 72 Hrs.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
672	Pronostico climático	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
673	Pronóstico Climático de Precipitacion Trimestral	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
674	Pronóstico Climático de Temperatura Máxima Trimestral.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
675	Pronóstico Climático de Temperatura Mínima Trimestral.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
676	Puno Años Secos - Antes de 1960 (1940)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
677	Puno Años Secos - Antes de 1960 (1941)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
678	Puno Años Secos - Antes de 1960 (1956)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
679	Puno Años Secos - Después de 1960 (1966)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
680	Puno Años Secos - Después de 1960 (1983)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
681	Puno Años Secos - Después de 1960 (1990)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
682	Puno Años Secos - Después de 1960 (1992)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
683	Puno Periodo Retorno Sequías - 2019 - Retorno SPI (Extrema)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
684	Puno Periodo Retorno Sequías - 2019 - Retorno SPI (Moderado)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
685	Puno Periodo Retorno Sequías - 2019 - Retorno SPI (Severa)	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
686	Puno Tendencia Sequías 1964 - 2019	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
687	Red de Estaciones	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
688	Riesgo de cultivo de Arroz	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
689	Riesgo de cultivo de Cacao	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
690	Riesgo de cultivo de Café	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
691	Riesgo de cultivo de Frijol	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
692	Riesgo de cultivo de Maiz	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
693	Riesgo de cultivo de Palto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
694	Riesgo de cultivo de Papa	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
695	Riesgo de cultivo de Pasto	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
696	Riesgo de cultivo de Quinua	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
697	Tendencia de Lluvia, Duración 1964/65 a 2018/19 del Departamento de Puno.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
698	Tendencia de Lluvia, Duración 1989/90 a 2018/19 del Departamento de Puno.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
699	Tendencia de Lluvia, Fin 1964/65 a 2018/19 del Departamento de Puno.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
700	Tendencia de Lluvia, Fin 1989/90 a 2018/19 del Departamento de Puno.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
701	Tendencia de Lluvia, Inicio 1964/65 a 2018/19 del Departamento de Puno.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
702	Tendencia de Temperatura Máxima Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
703	Tendencia de Temperatura Máxima Mensual de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
704	Tendencia de Temperatura Máxima Mensual de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
705	Tendencia de Temperatura Máxima Mensual de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
706	Tendencia de Temperatura Máxima Mensual de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
707	Tendencia de Temperatura Máxima Mensual de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
708	Tendencia de Temperatura Máxima Mensual de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
709	Tendencia de Temperatura Máxima Mensual de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
710	Tendencia de Temperatura Máxima Mensual de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
711	Tendencia de Temperatura Máxima Mensual de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
712	Tendencia de Temperatura Máxima Mensual de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
713	Tendencia de Temperatura Máxima Mensual de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
714	Tendencia de Temperatura Máxima Mensual de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
715	Tendencia de Temperatura Media Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
716	Tendencia de Temperatura Media Mensual de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
717	Tendencia de Temperatura Media Mensual de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
718	Tendencia de Temperatura Media Mensual de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
719	Tendencia de Temperatura Media Mensual de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
720	Tendencia de Temperatura Media Mensual de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
721	Tendencia de Temperatura Media Mensual de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
722	Tendencia de Temperatura Media Mensual de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
723	Tendencia de Temperatura Media Mensual de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
724	Tendencia de Temperatura Media Mensual de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
725	Tendencia de Temperatura Media Mensual de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
726	Tendencia de Temperatura Media Mensual de Octubre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
727	Tendencia de Temperatura Media Mensual de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
728	Tendencia de Temperatura Mínima Anual.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
729	Tendencia de Temperatura Mínima Mensual de Abril.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
730	Tendencia de Temperatura Mínima Mensual de Agosto.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
731	Tendencia de Temperatura Mínima Mensual de Diciembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
732	Tendencia de Temperatura Mínima Mensual de Enero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
733	Tendencia de Temperatura Mínima Mensual de Febrero.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
734	Tendencia de Temperatura Mínima Mensual de Julio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
735	Tendencia de Temperatura Mínima Mensual de Junio.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
736	Tendencia de Temperatura Mínima Mensual de Marzo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
737	Tendencia de Temperatura Mínima Mensual de Mayo.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
738	Tendencia de Temperatura Mínima Mensual de Noviembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
739	Tendencia de Temperatura Mínima Mensual de Octubre.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
740	Tendencia de Temperatura Mínima Mensual de Septiembre.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
741	Tendencia Lluvia, de Inicio 1989/90 a 2018/19 del Departamento de Puno.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
742	Variable de Evapotranspiración 01 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
743	Variable de Evapotranspiración 02 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
744	Variable de Evapotranspiración 03 Década del mes.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
745	Variable de Índice de Humedad 01 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
746	Variable de Índice de Humedad 02 Década del mes.	\N	1	t	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
747	Variable de Índice de Humedad 03 Década del mes.	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
748	Vigilancia de Incendios	\N	1	f	\N	5	75	1	2026-01-07 09:45:35.443767-05	\N	\N
749	Vigilancia Meteorológica de Incendios FWI	\N	1	f	\N	8	75	1	2026-01-07 09:45:35.443767-05	\N	\N
750	Establecimientos de Medios Libres	\N	1	t	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
751	Establecimientos Penitenciarios	\N	1	t	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
752	Mapeo de Lugar de Procedencia de internos con casos TB	\N	1	f	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
753	Mapeo de Lugar de Procedencia de la Población Penitenciaria	\N	1	t	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
754	Mapeo de Lugar de Procedencia de los Venezolanos	\N	1	t	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
755	Oficinas Regionales	\N	1	t	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
756	Sedes Regionales	\N	1	t	\N	17	77	1	2026-01-07 09:45:35.443767-05	\N	\N
757	Locales de la PGE	\N	1	t	\N	6	79	1	2026-01-07 09:45:35.443767-05	\N	\N
758	Centros Juveniles de Diagnóstico y Rehabilitación (CDJR)	\N	1	t	\N	17	80	1	2026-01-07 09:45:35.443767-05	\N	\N
759	Infracciones por distrito según CJDR	\N	1	t	\N	17	80	1	2026-01-07 09:45:35.443767-05	\N	\N
760	Infracciones por distrito según SOA	\N	1	t	\N	17	80	1	2026-01-07 09:45:35.443767-05	\N	\N
761	Servicio de Orientación al Adolescente (SOA)	\N	1	t	\N	17	80	1	2026-01-07 09:45:35.443767-05	\N	\N
762	Barrio Seguro	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
763	Cantidad de computadoras propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
764	Cantidad de equipos multifuncionales propios y operativos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
765	Cantidad de escáner propios y operativos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
766	Cantidad de Fotocopiadoras propias y operativas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
767	Cantidad de impresoras propias y operativas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
768	Cantidad de laptop - notebook - propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
769	Cantidad de proyectores propios y operativos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
770	Cantidad de servidores propios y operativos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
771	Centro de Emergencia Mujer	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
772	Comisarías	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
773	Comisarias Básicas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
774	Comisarías con al menos un equipo de comunicación operativo y propio	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
843	Robo de Negocio	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
775	Comisarías con servicio de agua potable (24 horas)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
776	Comisarías en buen estado de conservación	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
777	Comisarias Familia	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
778	Comisarías que cuentan con servicio de desagüe en buen estado	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
779	Comisarías que disponen al menos un equipo informático operativas y propias	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
780	Comisarías que disponen con serenazgo en el distrito	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
781	Comisarías que disponen de servicios básicos adecuados	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
782	Comisarías que realizan patrullaje integrado en el distrito	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
783	Comisarías que tienen paredes en buen estado de conservación	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
784	Comisarías que tienen pisos en buen estado de conservación	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
785	Comisarías que tienen servicio de energía eléctrica (Permanente)	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
786	Comisarías que tienen techos en buen estado de conservación	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
787	Confianza en Institución - Ministerio Público	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
788	Confianza en Institución - Poder Judicial	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
789	Confianza en Institución - Policía Nacional del Perú	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
790	Delitos Informáticos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
791	Denuncias	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
792	División Policial	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
793	Establecimientos penitenciarios	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
794	Estafas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
795	Extorsiones	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
796	Feminicidios	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
797	GPS- Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
798	Hombres atendidos por Violencia Económica o Patrimonial (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
799	Hombres atendidos por Violencia Económica o Patrimonial (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
800	Hombres atendidos por Violencia Económica o Patrimonial (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
801	Hombres atendidos por Violencia Familiar (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
802	Hombres atendidos por Violencia Familiar (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
803	Hombres atendidos por Violencia Familiar (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
804	Hombres atendidos por Violencia Física (0 – 17 años)	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
805	Hombres atendidos por Violencia Física (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
806	Hombres atendidos por Violencia Física (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
807	Hombres atendidos por Violencia Psicológica (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
808	Hombres atendidos por Violencia Psicológica (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
809	Hombres atendidos por Violencia Psicológica (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
810	Hombres atendidos por Violencia Sexual (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
811	Hombres atendidos por Violencia Sexual (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
812	Hombres atendidos por Violencia Sexual (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
813	Hurto	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
814	Incidencias Barrios Seguros	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
815	Jurisdicciones Comisarias Básicas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
816	Jurisdicciones Comisarias Familia	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
817	Microcomercialización	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
818	Mujeres atendidas por Violencia Económica o Patrimonial (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
819	Mujeres atendidas por Violencia Económica o Patrimonial (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
820	Mujeres atendidas por Violencia Económica o Patrimonial (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
821	Mujeres atendidas por Violencia Familiar (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
822	Mujeres atendidas por Violencia Familiar (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
823	Mujeres atendidas por Violencia Familiar (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
824	Mujeres atendidas por Violencia Física (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
825	Mujeres atendidas por Violencia Física (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
826	Mujeres atendidas por Violencia Física (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
827	Mujeres atendidas por Violencia Psicológica (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
828	Mujeres atendidas por Violencia Psicológica (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
829	Mujeres atendidas por Violencia Psicológica (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
830	Mujeres atendidas por Violencia Sexual (0 – 17 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
831	Mujeres atendidas por Violencia Sexual (18 – 59 años)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
832	Mujeres atendidas por Violencia Sexual (60 años a más)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
833	Número de Centros de Emergencia Mujer	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
834	Número de Proyectos	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
835	Percepción de Inseguridad (Próximos 12 Meses)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
836	Puestos Fronterizos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
837	Radio fijo base- Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
838	Radio móvil- Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
839	Radio portátil - Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
840	Región Policial	\N	1	f	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
841	Robo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
842	Robo de Dinero Cartera y Celular	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
844	Robo de Vehículos	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
845	RPC - Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
846	RPM - Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
847	Sectores Comisarias Básicas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
848	Sustracción de Menores	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
849	Teléfono fijo - Propio y operativo	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
850	Tipo de Vigilancia	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
851	Total de Proyectos Finalizados	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
852	Total de Proyectos No Finalizados	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
853	Trata de Personas	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
854	Victimización	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
855	Victimización a Hogares (Últimos 12 Meses)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
856	Victimización con Arma de Fuego	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
857	Vigilancia	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
858	Vigilancia Tipo de Vigilancia	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
859	Violencia Familiar	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
860	Violencia Familiar contra la Mujer	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
861	Violencia Física	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
862	Violencia Física (Últimos 12 Meses)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
863	Violencia Psicológica y-o Verbal	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
864	Violencia Psicológica y-o Verbal (Últimos 12 Meses)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
865	Violencia Sexual	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
866	Violencia Sexual (Últimos 12 Meses)	\N	1	t	\N	17	81	1	2026-01-07 09:45:35.443767-05	\N	\N
867	Comandancias departamentales de bomberos	\N	1	t	\N	17	82	1	2026-01-07 09:45:35.443767-05	\N	\N
868	Compañías de bomberos	\N	1	t	\N	17	82	1	2026-01-07 09:45:35.443767-05	\N	\N
869	Distritos de Frontera	\N	1	t	\N	17	85	1	2026-01-07 09:45:35.443767-05	\N	\N
870	Actividades - Distrital	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
871	Actividades - Provincial	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
872	Actividades - Regional	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
873	Actividades y Proyectos - Distrital	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
874	Actividades y Proyectos - Provincial	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
875	Actividades y Proyectos - Regional	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
876	Distribución del Canon	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
877	Distribución del FONCOMUN	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
878	Presupuesto Regional	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
879	Proyectos - Distrital	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
880	Proyectos - Provincial	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
881	Proyectos - Regional	\N	1	t	\N	6	88	1	2026-01-07 09:45:35.443767-05	\N	\N
882	Centros de Servicios al Contribuyente - Lima y Callao	\N	1	t	\N	6	90	1	2026-01-07 09:45:35.443767-05	\N	\N
883	Centros de Servicios al Contribuyente - Provincias	\N	1	t	\N	6	90	1	2026-01-07 09:45:35.443767-05	\N	\N
884	Tributos Aduaneros Recaudados	\N	1	t	\N	6	90	1	2026-01-07 09:45:35.443767-05	\N	\N
885	Tributos Internos Recaudados	\N	1	t	\N	6	90	1	2026-01-07 09:45:35.443767-05	\N	\N
886	Datos de la convocatoria o invitación - Adjudicado	\N	1	t	\N	6	92	1	2026-01-07 09:45:35.443767-05	\N	\N
887	Datos de la convocatoria o invitación - Consentido	\N	1	t	\N	6	92	1	2026-01-07 09:45:35.443767-05	\N	\N
888	Datos de la convocatoria o invitación - Contratado	\N	1	t	\N	6	92	1	2026-01-07 09:45:35.443767-05	\N	\N
889	Afiliados del Sistema Nacional de Pensiones (SNP)	\N	1	t	\N	6	93	1	2026-01-07 09:45:35.443767-05	\N	\N
890	Autoservicio	\N	1	t	\N	6	93	1	2026-01-07 09:45:35.443767-05	\N	\N
891	MAC Express	\N	1	t	\N	6	93	1	2026-01-07 09:45:35.443767-05	\N	\N
892	Pensionistas del Sistema Nacional de Pensiones (SNP)	\N	1	t	\N	6	93	1	2026-01-07 09:45:35.443767-05	\N	\N
893	Puntos de Atención	\N	1	t	\N	6	93	1	2026-01-07 09:45:35.443767-05	\N	\N
894	Estadísticas por catálogo - 2023	\N	1	t	\N	6	94	1	2026-01-07 09:45:35.443767-05	\N	\N
895	Agencias	\N	1	t	\N	6	95	1	2026-01-07 09:45:35.443767-05	\N	\N
896	Cajeros Automáticos (ATM)	\N	1	t	\N	6	95	1	2026-01-07 09:45:35.443767-05	\N	\N
897	Cajeros Corresponsales del Sistema Financiero (POS)	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
898	Crédito promedio en el sistema financiero – hombres	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
899	Crédito promedio en el sistema financiero – mujeres	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
900	Establecimientos de operaciones básicas (EOB)	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
901	Hombres afiliados al sistema privado de pensiones (% PEA)	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
902	Mujeres afiliadas al sistema privado de pensiones (% PEA)	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
903	Oficinas del Sistema Financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
904	Porcentaje de adultos con crédito en el sistema financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
905	Porcentaje de adultos con cuenta en el sistema financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
906	Porcentaje de hombres adultos con crédito en el sistema financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
907	Porcentaje de hombres adultos con cuenta en el sistema financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
908	Porcentaje de mujeres adultas con crédito en el sistema financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
909	Porcentaje de mujeres adultas con cuenta en el sistema financiero	\N	1	t	\N	17	96	1	2026-01-07 09:45:35.443767-05	\N	\N
910	Ciencia y Tecnología - Regional	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
911	Dirección Regional de Educación (DRE)	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
912	I.E. Básica Alternativa - CEBA	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
913	I.E. Básica Especial - CEBE	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
914	I.E. Inicial	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
915	I.E. Ocupacional	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
916	I.E. Primaria	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
917	I.E. Secundaria	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
918	I.E. Superior Artística - ESFA	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
919	I.E. Superior Pedagógica - ISP	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
920	I.E. Superior Tecnológica - IST	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
921	I.E. Técnico Prod. - CETPRO	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
922	Instituciones Educativas	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
923	Lectura - Regional	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
924	Locales Educativos	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
925	Matemática - Regional	\N	1	t	\N	17	97	1	2026-01-07 09:45:35.443767-05	\N	\N
926	Infraestructuras Deportivas del IPD	\N	1	t	\N	17	101	1	2026-01-07 09:45:35.443767-05	\N	\N
927	Escuelas Bicentenario	\N	1	t	\N	17	102	1	2026-01-07 09:45:35.443767-05	\N	\N
928	Sede Cultural	\N	1	t	\N	17	103	1	2026-01-07 09:45:35.443767-05	\N	\N
929	Sede de Educación	\N	1	t	\N	17	103	1	2026-01-07 09:45:35.443767-05	\N	\N
930	Sede de Residencia	\N	1	t	\N	17	103	1	2026-01-07 09:45:35.443767-05	\N	\N
931	Estaciones acelerográficas	\N	1	t	\N	17	107	1	2026-01-07 09:45:35.443767-05	\N	\N
932	Universidad Nacional Intercultural de la Amazonía	\N	1	t	\N	17	134	1	2026-01-07 09:45:35.443767-05	\N	\N
933	Universidad Nacional José María Arguedas	\N	1	t	\N	17	136	1	2026-01-07 09:45:35.443767-05	\N	\N
934	UNIFSLB	\N	1	t	\N	17	147	1	2026-01-07 09:45:35.443767-05	\N	\N
935	Universidad Nacional de Música	\N	1	t	\N	17	153	1	2026-01-07 09:45:35.443767-05	\N	\N
936	Adultos Mayores Fallecidos	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
937	Adultos Mayores Vacunados	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
938	Casos Positivos	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
939	Centros de Vacunación	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
940	Defunciones personas no identificadas	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
941	Defunciones por accidentes de tránsito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
942	Defunciones por homicidio	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
943	Defunciones por otro accidente	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
944	Defunciones por suicidio	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
945	Enfermeros por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
946	Enfermeros por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
947	Establecimientos de salud	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
948	Fallecidos	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
949	Madres menores de 17 años	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
950	Médico Veterinario por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
951	Médico Veterinario por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
952	Médicos por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
953	Médicos por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
954	Médicos que certifican el nacimiento	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
955	Mujeres con nivel de instrucción secundario	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
956	Mujeres con nivel de instrucción superior	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
957	Mujeres con recién nacido vivo	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
958	Nacidos vivos con bajo peso	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
959	Nutricionistas por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
960	Nutricionistas por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
961	Obstetras por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
962	Obstetras por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
963	Obstetras que certifican el nacimiento	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
964	Odontólogos (Cirujano Dentista) por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
965	Odontólogos por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
966	Psicólogos por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
967	Psicólogos por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
968	Químico por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
969	Químicos por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
970	Técnico Especializado por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
971	Técnico Especializado por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
972	Tecnólogo Médico por distrito	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
973	Tecnólogo Médico por EESS	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
974	Telemedicina	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
975	Vacuna Antineumocócica	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
976	Vacuna Antituberculosa (BCG)	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
977	Vacuna contra Rotavirus	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
978	Vacuna DPT-HVB-HIB	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
979	Vacuna para tétanos, toxoide diftérico (TDAP)	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
980	Vacunados	\N	1	t	\N	10	159	1	2026-01-07 09:45:35.443767-05	\N	\N
981	Centro de Salud	\N	1	t	\N	10	161	1	2026-01-07 09:45:35.443767-05	\N	\N
982	Hospital	\N	1	t	\N	10	161	1	2026-01-07 09:45:35.443767-05	\N	\N
983	Otros	\N	1	t	\N	10	161	1	2026-01-07 09:45:35.443767-05	\N	\N
984	Afiliados activos por grupo de edad	\N	1	t	\N	10	162	1	2026-01-07 09:45:35.443767-05	\N	\N
985	Afiliados activos por régimen de financiamiento	\N	1	t	\N	10	162	1	2026-01-07 09:45:35.443767-05	\N	\N
986	Afiliados activos según sexo	\N	1	t	\N	10	162	1	2026-01-07 09:45:35.443767-05	\N	\N
987	Pacientes atendidos en el INR por mes - Nivel Departamental	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
988	Pacientes atendidos en el INR por mes - Nivel Distrital	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
989	Pacientes atendidos en el INR por mes - Nivel Provincial	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
990	Pacientes INR atendidos según grupos de edad - Departamental	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
991	Pacientes INR atendidos según grupos de edad - Distrital	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
992	Pacientes INR atendidos según grupos de edad - Provincial	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
993	Pacientes INR atendidos según sexo - Departamental	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
994	Pacientes INR atendidos según sexo - Distrital	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
995	Pacientes INR atendidos según sexo - Provincial	\N	1	t	\N	10	164	1	2026-01-07 09:45:35.443767-05	\N	\N
996	Capacitación laboral (Abril - Junio 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
997	Capacitación laboral (Abril - Junio 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
998	Capacitación laboral (Enero - Marzo 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
999	Capacitación laboral (Jul - Set 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1082	Principales Presas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1000	Capacitación laboral (Nov - Dic 2023)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1001	Capacitación laboral (Oct - Dic 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1002	Capacitación y asistencia técnica para el autoempleo productivo (Abril - Junio 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1003	Capacitación y asistencia técnica para el autoempleo productivo (Enero - Marzo 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1004	Certificación de competencias laborales (Abril - Junio 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1005	Certificación de competencias laborales (Abril - Junio 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1006	Certificación de competencias laborales (Enero - Marzo 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1007	Certificación de competencias laborales (Jul - Set 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1008	Certificación de competencias laborales (Nov - Dic 2023)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1009	Certificación de competencias laborales (Oct - Dic 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1010	Moodle (Abril - Junio 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1011	Moodle (Abril - Junio 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1012	Moodle (Enero - Marzo 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1013	Moodle (Enero - Marzo 2025)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1014	Moodle (Jul - Set 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1015	Moodle (Nov - Dic 2023)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1016	Moodle (Oct - Dic 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1017	Promoción del autoempleo (Abril - Junio 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1018	Promoción del autoempleo productivo (Jul - Set 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1019	Promoción del autoempleo productivo (Oct - Dic 2024)	\N	1	t	\N	6	165	1	2026-01-07 09:45:35.443767-05	\N	\N
1020	Empleos temporales - Agosto 2025	\N	1	t	\N	6	167	1	2026-01-07 09:45:35.443767-05	\N	\N
1021	Empleos temporales - Julio 2025	\N	1	t	\N	6	167	1	2026-01-07 09:45:35.443767-05	\N	\N
1022	Empleos temporales - Junio 2025	\N	1	t	\N	6	167	1	2026-01-07 09:45:35.443767-05	\N	\N
1023	Empleos temporales - Setiembre 2025	\N	1	t	\N	6	167	1	2026-01-07 09:45:35.443767-05	\N	\N
1024	CUM Detallado 1-10000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1025	CUM Reconocimiento 1-100000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1026	CUM Reconocimiento 1-20000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1027	CUM Reconocimiento 1-25000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1028	CUM Reconocimiento 1-30000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1029	CUM Reconocimiento 1-35000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1030	CUM Reconocimiento 1-50000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1031	CUM Semidetallado 1-10000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1032	CUM Semidetallado 1-12000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1033	CUM Semidetallado 1-2000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1034	CUM Semidetallado 1-20000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1035	CUM Semidetallado 1-25000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1036	CUM Semidetallado 1-45000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1037	CUM Semidetallado 1-50000	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1038	DESLTERR	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1039	PREDRUST	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1040	TACL - Cultivos Permanentes	\N	1	t	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1041	TERRDEMAR	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1042	UnidadesHidrograficas	\N	1	f	\N	2	168	1	2026-01-07 09:45:35.443767-05	\N	\N
1043	AAA	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1044	Acreditación de Disponibilidad Hídrica	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1045	Acueductos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1046	Acuícola	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1047	Acuíferos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1048	Acuíferos en veda	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1049	Administración Local del Agua	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1050	Agrarios	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1051	ALA	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1052	Aprobados	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1053	Autoridad Administrativa del Agua	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1054	Autorización de Ejecución de Obras	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1055	Autorización de Vertimientos de Aguas Residuales Tratadas	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1056	Bocatomas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1057	Canales de Aducción	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1058	Canales de Derivación	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1059	Canales de Trasvase	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1060	Canales Laterales	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1061	Consejos de Recursos Hidricos de Cuenca	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1062	De Transporte	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1063	Doméstico – Poblacional	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1064	Drenes	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1065	Energético	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1066	Estación de Bombeo	\N	1	f	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1067	Faja Marginal	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1068	Formalización	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1069	Fuentes Contaminantes	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1070	Glaciares	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1071	Industrial	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1072	Lagunas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1073	Minero	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1074	Obras de Arte	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1075	Otros Usos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1076	Pecuario	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1077	Pesquero	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1078	Poblacional	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1079	Poblaciones Vulnerables por Activación de Quebradas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1080	Pozos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1081	Presas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1083	Propuesta	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1084	Puntos Críticos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1085	Puntos de Muestreo	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1086	Recreativo	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1087	Reservorios	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1088	Ríos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1089	Sector Mayor	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1090	Sector Menor Clase A	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1091	Sector Menor Clase B	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1092	Sector Menor Clase C	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1093	Tomas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1094	Túneles	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1095	Turístico	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1096	Unidades Hidrográficas	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1097	Vertimientos	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1098	Volúmenes Utilizados	\N	1	t	\N	2	172	1	2026-01-07 09:45:35.443767-05	\N	\N
1099	Alertas de incendio forestal	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1100	Autorización de cambio de uso actual de las tierras a fines agropecuarios	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1101	Autorizaciones de Productos Forestales Diferentes a la Madera (PFDM) en Asociaciones Vegetales No Boscosas (AVNB)	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1102	Bosques Locales (Título Habilitante)	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1103	Cesiones en Uso	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1104	Concesión Forestal	\N	1	t	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1105	Ecosistemas frágiles	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1106	Focos de Calor	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1107	Inventario Forestal	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1108	Modalidades de acceso	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1109	Ordenamiento Forestal	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1110	Permisos	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1111	Unidad de aprovechamiento	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1112	Unidad de Monitoreo Satelital	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1113	Zonificación forestal	\N	1	f	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1114	Zonificación Forestal	\N	1	t	\N	5	173	1	2026-01-07 09:45:35.443767-05	\N	\N
1115	Cartera de Proyectos de Inversión Minera	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1116	Centrales Hidroeléctricas	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1117	Centros de carga, centros registrados en la DGER, redes de alta tensión y de media tensión	\N	1	f	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1118	Concesión Eléctrica del SFVD	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1119	Distribución Eléctrica	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1120	Gaseoducto	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1121	Generación Eléctrica	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1122	Hidrocarburos	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1123	Proyectos con Potencial Hidroeléctrico	\N	1	f	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1124	Transmisión Eléctrica	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1125	Unidades Mineras en Producción	\N	1	t	\N	20	174	1	2026-01-07 09:45:35.443767-05	\N	\N
1126	Catastro Minero	\N	1	t	\N	20	176	1	2026-01-07 09:45:35.443767-05	\N	\N
1127	Mapa Geológico del Perú	\N	1	t	\N	20	176	1	2026-01-07 09:45:35.443767-05	\N	\N
1128	Centros de generación	\N	1	t	\N	20	177	1	2026-01-07 09:45:35.443767-05	\N	\N
1129	Centros de transformación (P.E)	\N	1	t	\N	20	177	1	2026-01-07 09:45:35.443767-05	\N	\N
1130	Líneas de transmisión	\N	1	t	\N	20	177	1	2026-01-07 09:45:35.443767-05	\N	\N
1131	Redes media tensión - Sistemas eléctricos	\N	1	t	\N	20	177	1	2026-01-07 09:45:35.443767-05	\N	\N
1132	Centro de atención al cliente	\N	1	t	\N	20	178	1	2026-01-07 09:45:35.443767-05	\N	\N
1133	Oficina principal	\N	1	t	\N	20	178	1	2026-01-07 09:45:35.443767-05	\N	\N
1134	Oficinas de atención al cliente	\N	1	t	\N	20	178	1	2026-01-07 09:45:35.443767-05	\N	\N
1135	Subestación de transmisión	\N	1	t	\N	20	178	1	2026-01-07 09:45:35.443767-05	\N	\N
1136	Unidad de negocios	\N	1	t	\N	20	178	1	2026-01-07 09:45:35.443767-05	\N	\N
1137	Centros de Atención al Cliente de Hidrandina S.A.	\N	1	f	\N	20	179	1	2026-01-07 09:45:35.443767-05	\N	\N
1138	Operaciones del Grupo ISA	\N	1	t	\N	17	180	1	2026-01-07 09:45:35.443767-05	\N	\N
1139	Sedes	\N	1	t	\N	17	181	1	2026-01-07 09:45:35.443767-05	\N	\N
1140	Delitos contra el Patrimonio	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1141	Delitos contra la Administración Pública	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1142	Delitos contra La Familia	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1143	Delitos contra La Libertad	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1144	Delitos contra la Seguridad Pública	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1145	Delitos contra la Vida, el Cuerpo y la Salud	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1146	Delitos Informáticos	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1147	Distritos Fiscales	\N	1	t	\N	17	184	1	2026-01-07 09:45:35.443767-05	\N	\N
1148	Almacenes - INDECI	\N	1	f	\N	12	187	1	2026-01-07 09:45:35.443767-05	\N	\N
1149	Emergencias	\N	1	t	\N	12	187	1	2026-01-07 09:45:35.443767-05	\N	\N
1150	Heladas y friaje sector Agricultura Agrícola	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1151	Heladas y friaje sector Agricultura Pecuaria	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1152	Heladas y friaje sector Educación	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1153	Heladas y friaje sector MIMP	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1154	Heladas y friaje sector Salud	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1155	Heladas y friaje sector Vivienda	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1156	Inundaciones por lluvias fuertes	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1157	Movimientos en masa por lluvias fuertes	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1158	Riesgos por friaje	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1159	Riesgos por heladas	\N	1	t	\N	12	188	1	2026-01-07 09:45:35.443767-05	\N	\N
1160	Centros Poblados	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1161	Cota	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1162	Cultural (Escala 1:100 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1163	Cultural (Escala 1:500 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1164	DEM Y Regiones del Perú	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1165	Fisiografía (Escala 1:100 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1166	Fisiografia (Escala 1:500 000)	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1167	Hidrografía - Islas (Escala 1:500 000)	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1168	Hidrografía - Rocas Flor Agua (Escala 1:500 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1169	Hidrografía (Escala 1:100 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1170	Hidrografía (Escala 1:500 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1171	Imagen Satelital de Arequipa	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1172	Imagen Satelital de Huancayo	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1173	Imagen Satelital de Ica	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1174	Imagen Satelital de Trujillo	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1175	Imágen Satelital de Tumbes	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1176	Imágenes RPA	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1177	Imágenes RPA - Costa Verde	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1178	Imágenes RPA - Frontera Perú - Bolivia	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1179	Imágenes RPA - Frontera Perú - Brasil	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1180	Imágenes RPA - Río Rímac	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1181	Imágenes RPA - San Isidro	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1182	Industria	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1183	Lago y Laguna	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1184	Límites (Escala 1:100 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1185	Límites Cartointerpretables	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1186	Ortofoto Cañete	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1187	Ortofoto Caral	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1188	Ortofoto Carhuaz	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1189	Ortofoto Huaraz	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1190	Ortofoto Ilo	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1191	Ortofoto Nasca	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1192	Ortofoto Puno	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1193	Ortofoto Tingo María	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1194	PERÚ_RASTE R_100K	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1195	PERÚ_RASTE R_25K	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1196	PERÚ_RASTE R_50K	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1197	Puente Piedra	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1198	Río Área	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1199	Río Lineal	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1200	Toponimia - Cerro (Escala 1:500 000)	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1201	Toponimia - Nevado (Escala 1:500 000)	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1202	Toponimia - Volcán (Escala 1:500 000)	\N	1	t	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1203	Toponimia (Escala 1:500 000)	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1204	Transportes y Comunicaciones 100K	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1205	Transportes y Comunicaciones 500K	\N	1	f	\N	12	189	1	2026-01-07 09:45:35.443767-05	\N	\N
1206	Cartas Lacustres	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1207	Cartas Náuticas	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1208	Estación Meteorológica	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1209	Facilidades Portuarias	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1210	Faros y Boyas	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1211	Islas e Islotes	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1212	Tráfico Marítimo	\N	1	t	\N	12	193	1	2026-01-07 09:45:35.443767-05	\N	\N
1213	Ciudad de Jaén - Cajamarca	\N	1	t	\N	12	195	1	2026-01-07 09:45:35.443767-05	\N	\N
1214	Ciudad de Tumbes	\N	1	t	\N	12	195	1	2026-01-07 09:45:35.443767-05	\N	\N
1215	Departamento de Tumbes	\N	1	t	\N	12	195	1	2026-01-07 09:45:35.443767-05	\N	\N
1216	Provincia Contralmirante Villar - Tumbes	\N	1	t	\N	12	195	1	2026-01-07 09:45:35.443767-05	\N	\N
1217	Provincia de Tumbes	\N	1	t	\N	12	195	1	2026-01-07 09:45:35.443767-05	\N	\N
1218	Provincia de Zarumilla - Tumbes	\N	1	t	\N	12	195	1	2026-01-07 09:45:35.443767-05	\N	\N
1219	Participación Electoral - Distritos	\N	1	t	\N	17	203	1	2026-01-07 09:45:35.443767-05	\N	\N
1220	Participación Electoral - Provincias	\N	1	t	\N	17	203	1	2026-01-07 09:45:35.443767-05	\N	\N
1221	Participación Electoral - Regiones	\N	1	t	\N	17	203	1	2026-01-07 09:45:35.443767-05	\N	\N
1222	Accesibilidad entre Capitales	\N	1	t	\N	17	204	1	2026-01-07 09:45:35.443767-05	\N	\N
1223	Población Electoral Total	\N	1	t	\N	17	204	1	2026-01-07 09:45:35.443767-05	\N	\N
1224	Inventario Turístico	\N	1	t	\N	17	206	1	2026-01-07 09:45:35.443767-05	\N	\N
1225	Puntos de atención IPERÚ	\N	1	t	\N	17	207	1	2026-01-07 09:45:35.443767-05	\N	\N
1226	Proyectos Plan COPESCO Nacional	\N	1	t	\N	17	209	1	2026-01-07 09:45:35.443767-05	\N	\N
1227	Aeródromos 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1228	Aeródromos 2023	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1229	Aeroportuaria	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1230	Asfaltado - 2025	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1231	Corredores Logísticos	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1232	Corredores Viales Alimentadores	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1233	Ejes de integración	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1234	Embarcadero	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1235	Estaciones de pesaje 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1236	Estaciones ferroviarias	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1237	Líneas Férreas	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1238	Puentes	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1239	Red ferroviaria 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1240	Red vial departamental 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1241	Red vial departamental 2023	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1242	Red vial departamental 2024	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1243	Red Vial Nacional	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1244	Red vial nacional 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1245	Red vial nacional 2023	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1246	Red vial nacional 2024	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1247	Red Vial Vecinal	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1248	Red vial vecinal 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1249	Red vial vecinal 2023	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1250	Terminal Pesquero	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1251	Terminal Portuario	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1252	Terminales portuarios y embarcaderos 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1253	Terminales portuarios y embarcaderos 2023	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1254	Terminales terrestres	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1255	Túneles	\N	1	t	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1256	Unidades de peaje 2022	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1257	Unidades de peaje 2023	\N	1	f	\N	19	210	1	2026-01-07 09:45:35.443767-05	\N	\N
1258	Centros de Acceso Digital (CAD)	\N	1	t	\N	19	214	1	2026-01-07 09:45:35.443767-05	\N	\N
1259	Dependencias Policiales	\N	1	t	\N	19	214	1	2026-01-07 09:45:35.443767-05	\N	\N
1260	Espacios Públicos de Acceso Digital (EPAD)	\N	1	t	\N	19	214	1	2026-01-07 09:45:35.443767-05	\N	\N
1261	Establecimientos de Salud	\N	1	t	\N	19	214	1	2026-01-07 09:45:35.443767-05	\N	\N
1262	Nodos de la Red Nacional	\N	1	t	\N	19	214	1	2026-01-07 09:45:35.443767-05	\N	\N
1263	Nodos de la Red Regional	\N	1	t	\N	19	214	1	2026-01-07 09:45:35.443767-05	\N	\N
1264	Ciudad Intermedia	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1265	Ciudad Intermedia Principal	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1266	Ciudad Mayor	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1267	Ciudad Mayor Principal	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1268	Ciudad Menor	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1269	Ciudad Menor Principal	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1270	Macro Sistema	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1271	Metrópoli Nacional	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1272	Metrópoli Regional	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1273	Plan de Acondicionamiento Territorial	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1274	Plan de Desarrollo Urbano	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1275	Sistema Urbano	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1276	Subsistema Urbano	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1277	Villa	\N	1	t	\N	20	215	1	2026-01-07 09:45:35.443767-05	\N	\N
1278	Ortofoto de Alta Resolución de la ciudad de Bagua	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1279	Ortofoto de Alta Resolución de la ciudad de Bagua Grande	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1280	Ortofoto de la ciudad de Bagua	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1281	Ortofoto de la ciudad de Bagua Grande	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1282	Ortofoto de la ciudad de Barranca	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1283	Ortofoto de la ciudad de Chachapoyas	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1284	Ortofoto de la ciudad de Huaral	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1285	Ortofoto de la ciudad de Jaén	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1286	Ortofoto de la ciudad de Moyobamba	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1287	Ortofoto de la ciudad de San Ignacio	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1288	Ortofoto de la ciudad de Tocache	\N	1	t	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1289	ORTOFOTO_EMAPAB	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1290	ORTOFOTO_EMAPAB_AR	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1291	ORTOFOTO_EMAPACOP_CAMPOVERDE	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1292	ORTOFOTO_EMAPAHUARAL	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1293	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR1	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1294	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR2	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1295	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR3	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1296	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR4	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1297	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR5	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1298	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR6	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1299	ORTOFOTO_EMAPASANMARTIN_TOCACHE	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1300	ORTOFOTO_EMAPAVIGS	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1301	ORTOFOTO_EMUSAP	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1302	ORTOFOTO_EPSBARRANCA	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1303	ORTOFOTO_EPSMARANON_JAEN	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1304	ORTOFOTO_EPSMARANON_SAN_IGNACIO	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1305	ORTOFOTO_EPSMOYOBAMBA	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1306	ORTOFOTO_EPSSMU	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1307	ORTOFOTO_EPSSMU_AR	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1308	WMSJ3TASS _AREASINFLUENCIA	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1309	WMSJ3TASS _EPS	\N	1	f	\N	20	218	1	2026-01-07 09:45:35.443767-05	\N	\N
1310	Créditos Mivivienda con BBP Sostenible	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1311	Financiamiento Complementario Techo Propio (FCTP)	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1312	Modalidad Adquisición de Vivienda Nueva (AVN)	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1313	Modalidad AVN Reconstrucción (AVN-r)	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1314	Modalidad Construcción en Sitio Propio (CSP)	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1315	Modalidad CSP Reconstrucción (CSP-r)	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1316	Nuevo Crédito MIVIVIENDA (NCMV)	\N	1	t	\N	20	220	1	2026-01-07 09:45:35.443767-05	\N	\N
1317	Accesorios	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1318	Acometidas	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1319	Colectores por presión	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1320	Colectores Red Primaria	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1321	Colectores Red Secundaria	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1322	Conexión domiciliaria	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1323	Hidrantes	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1324	Lotes	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1325	Surtidores	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1326	Tuberías Primaria	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1327	Tuberías Secundaria	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1328	Vías	\N	1	t	\N	20	221	1	2026-01-07 09:45:35.443767-05	\N	\N
1329	Accesibilidad entre Centros Poblados	\N	1	t	\N	20	222	1	2026-01-07 09:45:35.443767-05	\N	\N
1330	Viviendas con Cobertura de Agua	\N	1	t	\N	20	222	1	2026-01-07 09:45:35.443767-05	\N	\N
1331	Viviendas con Cobertura de Desagüe	\N	1	t	\N	20	222	1	2026-01-07 09:45:35.443767-05	\N	\N
1332	Áreas de Derechos Acuícolas	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1333	Áreas Disponibles	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1334	Áreas en Trámite de Derecho Acuícola	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1335	Áreas Habilitadas	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1336	Derechos Acuícolas	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1337	Formulario de Reserva	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1338	Solicitud de Formulario de Reserva	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1339	Solicitud de Habilitación Acuática	\N	1	t	\N	6	223	1	2026-01-07 09:45:35.443767-05	\N	\N
1340	Centro de Acuicultura	\N	1	f	\N	6	224	1	2026-01-07 09:45:35.443767-05	\N	\N
1341	Centro de Educación Técnico	\N	1	t	\N	6	224	1	2026-01-07 09:45:35.443767-05	\N	\N
1342	Centro de Procesamiento Pesquero Artesanal	\N	1	t	\N	6	224	1	2026-01-07 09:45:35.443767-05	\N	\N
1343	Infraestructura Pesquera Artesanal	\N	1	t	\N	6	224	1	2026-01-07 09:45:35.443767-05	\N	\N
1344	Muelle Pesquero Artesanal	\N	1	f	\N	6	224	1	2026-01-07 09:45:35.443767-05	\N	\N
1345	Infraestructuras habilitadas por SANIPES	\N	1	t	\N	6	227	1	2026-01-07 09:45:35.443767-05	\N	\N
1346	Oficinas Desconcentradas de SANIPES	\N	1	t	\N	6	227	1	2026-01-07 09:45:35.443767-05	\N	\N
1347	Organismos de Evaluación Acreditados	\N	1	t	\N	6	228	1	2026-01-07 09:45:35.443767-05	\N	\N
1348	Educación Alimentaria y Nutricional (Cocinando con Pescado) - 2022	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1349	Educación Alimentaria y Nutricional (Cocinando con Pescado) - 2023	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1350	Educación Alimentaria y Nutricional (Cocinando con Pescado) - 2024	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1351	Educación Alimentaria y Nutricional (PESCAEduca) - 2022	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1352	Educación Alimentaria y Nutricional (PESCAEduca) - 2023	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1353	Educación Alimentaria y Nutricional (PESCAEduca) - 2024	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1354	Educación Alimentaria y Nutricional (PESCANutrición) - 2022	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1355	Educación Alimentaria y Nutricional (PESCANutrición) - 2023	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1356	Educación Alimentaria y Nutricional (PESCANutrición) - 2024	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1357	Fomento de la Producción Pesquera para el Consumo Humano Directo - 2022	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1358	Fomento de la Producción Pesquera para el Consumo Humano Directo - 2023	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1359	Fomento de la Producción Pesquera para el Consumo Humano Directo - 2024	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1360	Promoción de Consumos de Productos Hidrobiológicos - 2022	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1361	Promoción de Consumos de Productos Hidrobiológicos - 2023	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1362	Promoción de Consumos de Productos Hidrobiológicos - 2024	\N	1	t	\N	6	229	1	2026-01-07 09:45:35.443767-05	\N	\N
1363	Casos atendidos total CEM (2023)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1364	Casos atendidos total CEM (2024)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1365	Casos atendidos total CEM (2025)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1366	CEM en Comisarías (2023)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1367	CEM en Comisarías (2025)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1368	CEM Regulares (2023)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1369	CEM Regulares (2024)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1370	CEM Regulares (2025)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1371	Violencia Económica o Patrimonial (2023)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1372	Violencia Económica o Patrimonial (2024)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1373	Violencia Económica o Patrimonial (2025)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1374	Violencia Psicológica (2023)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1375	Violencia Psicológica (2024)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1376	Violencia Psicológica (2025)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1377	Violencia Sexual (2023)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1378	Violencia Sexual (2024)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1379	Violencia Sexual (2025)	\N	1	t	\N	17	230	1	2026-01-07 09:45:35.443767-05	\N	\N
1380	% Población con discapacidad por tipo de dificultad o limitación permanente (2017)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1381	% Población de 14 años a más ocupada, por sectores económicos (2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1382	% Población de 14 años a más, ocupada (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1383	% Población de 14 años a más, por condición de PEA y no PEA (2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1384	% Población de 6 años a más que accede y usa internet (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1385	% Población en situación de pobreza monetaria (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1386	% Población en situación de pobreza monetaria extrema (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1387	% Población por sexo (2017)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1388	% Población por tenencia de seguro de salud (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1389	% Población que no se atendieron en un centro de salud (2014 al 2023)	\N	1	t	\N	10	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1390	% Población que participa en organizaciones sociales por año (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1391	% Población que tiene acceso a agua potable (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1392	% Población que tiene electricidad en su vivienda (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1393	Al medio físico según entidades, puntos de intervención y regiones (2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1394	En el transporte, tránsito y seguridad vial según regiones y entidades (2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1395	En la comunicación, según regiones y entidades (2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1396	En la PCM y Ministerios	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1397	En las Municipalidades Distritales	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1398	En las Municipalidades Provinciales	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1399	En los Gobiernos Regionales	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1400	En Otras Entidades Públicas	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1401	Instituciones Educativas Fiscalizadas (2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1402	Población con discapacidad	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1403	Población de 3 años a más, por nivel educativo alcanzado (2017)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1404	Por grupo de edad	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1405	Por nivel de gravedad leve	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1406	Por nivel de gravedad moderado	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1407	Por nivel de gravedad no especificado	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1408	Por nivel de gravedad severo	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1409	Por sexo	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1410	Por tipo de deficiencia en la discapacidad física	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1411	Por tipo de deficiencia en la discapacidad intelectual	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1412	Por tipo de deficiencia en la discapacidad mental	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1413	Por tipo de deficiencia en la discapacidad sensorial	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1414	Promedio de años de estudio de la población de 15 años a más (2014 al 2023)	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1415	Según Regiones	\N	1	t	\N	17	231	1	2026-01-07 09:45:35.443767-05	\N	\N
1416	Reporte Servicio Educadores de Calle	\N	1	t	\N	17	232	1	2026-01-07 09:45:35.443767-05	\N	\N
1417	Reporte Servicio PUNCHE FAMILIA	\N	1	t	\N	17	232	1	2026-01-07 09:45:35.443767-05	\N	\N
1418	FONCODES	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1419	Número de PPSS por distritos	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1420	PAIS (TAMBOS)	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1421	Vul. Inseguridad Alimentaria - CCPP	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1422	Vul. Inseguridad Alimentaria Mza.	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1423	Vul. Inseguridad Alimentaria RFN Dist.	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1424	Vul. Inseguridad Alimentaria RFN Dpto.	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1425	Vul. Inseguridad Alimentaria RFN Prov.	\N	1	t	\N	17	233	1	2026-01-07 09:45:35.443767-05	\N	\N
1426	CUNA MÁS	\N	1	t	\N	17	235	1	2026-01-07 09:45:35.443767-05	\N	\N
1427	JUNTOS	\N	1	t	\N	17	237	1	2026-01-07 09:45:35.443767-05	\N	\N
1428	Agencias	\N	1	t	\N	17	238	1	2026-01-07 09:45:35.443767-05	\N	\N
1429	Cantidad de usuarios por distrito	\N	1	t	\N	17	238	1	2026-01-07 09:45:35.443767-05	\N	\N
1430	Plataformas Itinerantes (PIAS) 2023	\N	1	t	\N	17	240	1	2026-01-07 09:45:35.443767-05	\N	\N
1431	Plataformas Itinerantes (PIAS) 2024	\N	1	t	\N	17	240	1	2026-01-07 09:45:35.443767-05	\N	\N
1432	Plataformas Itinerantes (PIAS) 2025	\N	1	t	\N	17	240	1	2026-01-07 09:45:35.443767-05	\N	\N
1433	Tambos Operativos	\N	1	t	\N	17	240	1	2026-01-07 09:45:35.443767-05	\N	\N
1434	CONTIGO	\N	1	t	\N	17	241	1	2026-01-07 09:45:35.443767-05	\N	\N
1435	Áreas de Conservación Ambiental	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1436	Áreas de Conservación Privada	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1437	Áreas de Conservación Regional	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1438	Áreas Naturales Protegidas	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1439	Áreas Naturales Protegidas de Administración Nacional Definitiva	\N	1	f	\N	5	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1440	Áreas Urbanas	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1441	Autorización es PFDMAVNB	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1442	Concesiones para Conservación	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1443	Cuerpos de Agua	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1444	Drenaje superficial	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1445	Ecosistemas frágiles	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1446	Límite Departamental	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1447	Límite Distrital	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1448	Límite Provincial	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1449	Permisos	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1450	Permisos Forestales	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1451	Sedes y Puestos de control	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1452	Zonas de amortiguamiento en Áreas Naturales Protegidas	\N	1	f	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1453	Zonas Reservadas	\N	1	t	\N	14	242	1	2026-01-07 09:45:35.443767-05	\N	\N
1454	Información Base	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1455	Medio Ambiental	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1456	Medio Biológico	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1457	Medio Cultural	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1458	Medio Físico	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1459	Sector Económico	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1460	SM Aptitud Urbano Industrial	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1461	SM Conflictos Uso	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1462	SM Peligros Potenciales Múltiples	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1463	SM Potencialidades Socioeconómicas	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1464	SM V Bioecológico	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1465	SM V Histórico Cultural	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1466	SM V Prod RRNN No Renovables	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1467	SM V Prod RRNN Renovables	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1468	SM Vulnerabilidad	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1469	ZEE	\N	1	f	\N	14	247	1	2026-01-07 09:45:35.443767-05	\N	\N
1470	Circunscripción política	\N	1	f	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1471	Comunidades Campesinas	\N	1	t	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1472	Comunidades Nativas	\N	1	t	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1473	Cuerpos de agua	\N	1	t	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1474	Hidrografía	\N	1	t	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1475	Relieve	\N	1	t	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1476	Transporte	\N	1	t	\N	14	255	1	2026-01-07 09:45:35.443767-05	\N	\N
1477	Aeroportuaria	\N	1	t	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1478	Comunidades Nativas	\N	1	t	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1479	Concesiones para Conservación	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1480	Concesiones para Productos Forestales Diferentes a la Madera	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1481	Cuerpos de Agua en Reposo	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1482	Instalaciones Portuarias	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1483	Lugares Poblados Madre de Dios	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1484	Unidades de Aprovechamiento	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1485	Zonas climáticas Madre de Dios	\N	1	f	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1486	Zonificación Ecológica y Económica	\N	1	t	\N	14	256	1	2026-01-07 09:45:35.443767-05	\N	\N
1487	Ámbito de Intervención del "Proyecto Cacao"	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1488	Ámbito de Intervención del "Proyecto Naranja"	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1489	Autorización de cambio de uso actual	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1490	Bosque y No Bosque	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1491	Bosques locales	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1492	Bosques preparados	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1493	Cesiones otorgadas	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1494	Cobertura forestal en reserva	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1495	Cuencas hidrodráficas (ANA)	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1496	Desbosques autorizados	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1497	Ecosistemas frágiles	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1498	Establecimientos autorizados	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1499	Hábitats Críticos	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1500	Límite departamental	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1501	Modalidades de acceso	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1502	Monitoreo y Control Forestal	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1503	Ordenamiento Forestal	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1504	Parcelas demostrativa s e investigación y Módulos de post-cosecha del proyecto Cacao	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1505	Productores asistidos técnicamente del Proyecto "Cacao"	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1506	Puestos de control	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1507	Registro de Productores Beneficiarios Asistidos por el Proyecto Naranja	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1508	Registro Forestal	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1509	ZoCRES	\N	1	f	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1510	Zonificación Ecológica y Económica	\N	1	t	\N	14	261	1	2026-01-07 09:45:35.443767-05	\N	\N
1511	Área Político Administrativa	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1512	Centros poblados	\N	1	t	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1513	Conseciones	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1514	Division admnistrativa del bosque(bloques quinquenales, parcela de corta)	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1515	Hidrografía	\N	1	t	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1516	Límite Político Administrativo	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1517	Permisos	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1518	Puesto de control	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1519	Registro forestal	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1520	Transporte	\N	1	t	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1521	Zonificación forestal	\N	1	f	\N	14	264	1	2026-01-07 09:45:35.443767-05	\N	\N
1522	Construcciónes	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1523	Eje de vía	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1524	Lotes catastrales	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1525	Manzanas catastrales	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1526	Parques	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1527	Puertas	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1528	Sectores catastrales	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1529	tg_hab_urb	\N	1	f	\N	14	268	1	2026-01-07 09:45:35.443767-05	\N	\N
1530	Telecentros - CEDRO	\N	1	t	\N	17	269	1	2026-01-07 09:45:35.443767-05	\N	\N
1531	ISA REP	\N	1	t	\N	17	270	1	2026-01-07 09:45:35.443767-05	\N	\N
1532	Cambio en tasa de nacidos vivos en mujeres de 10 a 14 años	\N	1	t	\N	17	271	1	2026-01-07 09:45:35.443767-05	\N	\N
1533	Cambio en tasa de nacidos vivos en mujeres de 15 a 19 años	\N	1	t	\N	17	271	1	2026-01-07 09:45:35.443767-05	\N	\N
1534	Años de educación (Población de 25 años y más)	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1535	Esperanza de vida al nacer (años)	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1536	IDH Departamental 2019	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1537	IDH Distrital 2019	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1538	IDH Provincial 2019	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1539	Ingreso familiar per cápita (soles por mes)	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1540	Población (18 años) con secundaria completa (%)	\N	1	t	\N	17	272	1	2026-01-07 09:45:35.443767-05	\N	\N
1541	Componente de Comunicaciones	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1542	Componente de Logística	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1543	Componente de Organización	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1544	Componente de Planificación	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1545	Componente de Recursos Financieros	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1546	Componente de Recursos Humanos	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1547	EPCI Provincial	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1548	EPCI Regional	\N	1	t	\N	17	273	1	2026-01-07 09:45:35.443767-05	\N	\N
1549	Greenfield - IPT	\N	1	t	\N	17	274	1	2026-01-07 09:45:35.443767-05	\N	\N
1550	Perimetro site code - IPT	\N	1	t	\N	17	274	1	2026-01-07 09:45:35.443767-05	\N	\N
1551	Vaso de Leche	\N	1	t	\N	14	275	1	2026-01-07 09:45:35.443767-05	\N	\N
1552	Ubicación	\N	1	t	\N	14	351	1	2026-01-07 09:45:35.443767-05	\N	\N
1553	Lotes Catastrales	\N	1	t	\N	14	354	1	2026-01-07 09:45:35.443767-05	\N	\N
1554	Manzanas	\N	1	t	\N	14	354	1	2026-01-07 09:45:35.443767-05	\N	\N
1555	Ubicación	\N	1	t	\N	14	354	1	2026-01-07 09:45:35.443767-05	\N	\N
1556	Zonificación Urbana	\N	1	t	\N	14	354	1	2026-01-07 09:45:35.443767-05	\N	\N
1557	Ubicación	\N	1	t	\N	14	376	1	2026-01-07 09:45:35.443767-05	\N	\N
1558	Ubicación	\N	1	t	\N	14	397	1	2026-01-07 09:45:35.443767-05	\N	\N
1559	Ubicación	\N	1	t	\N	14	410	1	2026-01-07 09:45:35.443767-05	\N	\N
1560	Ubicación	\N	1	t	\N	14	413	1	2026-01-07 09:45:35.443767-05	\N	\N
1561	Área de inundación por Tsunami - GORE CALLAO	\N	1	t	\N	14	464	1	2026-01-07 09:45:35.443767-05	\N	\N
1562	Ubicación	\N	1	t	\N	14	498	1	2026-01-07 09:45:35.443767-05	\N	\N
1563	Cámaras de seguridad	\N	1	t	\N	14	534	1	2026-01-07 09:45:35.443767-05	\N	\N
1564	Ubicación	\N	1	t	\N	14	534	1	2026-01-07 09:45:35.443767-05	\N	\N
1565	Ubicación	\N	1	t	\N	14	610	1	2026-01-07 09:45:35.443767-05	\N	\N
1566	Ubicación	\N	1	t	\N	14	614	1	2026-01-07 09:45:35.443767-05	\N	\N
1567	Ubicación	\N	1	t	\N	14	702	1	2026-01-07 09:45:35.443767-05	\N	\N
1568	Ubicación	\N	1	t	\N	14	708	1	2026-01-07 09:45:35.443767-05	\N	\N
1569	Ubicación	\N	1	t	\N	14	781	1	2026-01-07 09:45:35.443767-05	\N	\N
1570	Ubicación	\N	1	t	\N	14	871	1	2026-01-07 09:45:35.443767-05	\N	\N
1571	Ubicación	\N	1	t	\N	14	890	1	2026-01-07 09:45:35.443767-05	\N	\N
1572	Ubicación	\N	1	t	\N	14	898	1	2026-01-07 09:45:35.443767-05	\N	\N
1573	Ubicación	\N	1	t	\N	14	971	1	2026-01-07 09:45:35.443767-05	\N	\N
1574	Ubicación	\N	1	t	\N	14	972	1	2026-01-07 09:45:35.443767-05	\N	\N
1575	Cámaras de seguridad	\N	1	t	\N	14	974	1	2026-01-07 09:45:35.443767-05	\N	\N
1576	Ubicación	\N	1	t	\N	14	974	1	2026-01-07 09:45:35.443767-05	\N	\N
1577	Ubicación	\N	1	t	\N	14	977	1	2026-01-07 09:45:35.443767-05	\N	\N
1578	Ubicación	\N	1	t	\N	14	1046	1	2026-01-07 09:45:35.443767-05	\N	\N
1579	Ubicación	\N	1	t	\N	14	1047	1	2026-01-07 09:45:35.443767-05	\N	\N
1580	Ubicación	\N	1	t	\N	14	1132	1	2026-01-07 09:45:35.443767-05	\N	\N
1581	Ubicación	\N	1	t	\N	14	1287	1	2026-01-07 09:45:35.443767-05	\N	\N
1582	Ubicación	\N	1	t	\N	14	1314	1	2026-01-07 09:45:35.443767-05	\N	\N
1583	Ubicación	\N	1	t	\N	14	1369	1	2026-01-07 09:45:35.443767-05	\N	\N
1584	Ubicación	\N	1	t	\N	14	1371	1	2026-01-07 09:45:35.443767-05	\N	\N
1585	Ubicación	\N	1	t	\N	14	1405	1	2026-01-07 09:45:35.443767-05	\N	\N
1586	Ubicación	\N	1	t	\N	14	1414	1	2026-01-07 09:45:35.443767-05	\N	\N
1587	Ubicación	\N	1	t	\N	14	1437	1	2026-01-07 09:45:35.443767-05	\N	\N
1588	Cámaras de seguridad	\N	1	t	\N	14	1472	1	2026-01-07 09:45:35.443767-05	\N	\N
1589	Comisarías	\N	1	t	\N	14	1472	1	2026-01-07 09:45:35.443767-05	\N	\N
1590	Serenazgo	\N	1	t	\N	14	1472	1	2026-01-07 09:45:35.443767-05	\N	\N
1591	Vaso de Leche	\N	1	t	\N	14	1472	1	2026-01-07 09:45:35.443767-05	\N	\N
1592	Comités de Vaso de Leche	\N	1	t	\N	14	1507	1	2026-01-07 09:45:35.443767-05	\N	\N
1593	Ubicación	\N	1	t	\N	14	1527	1	2026-01-07 09:45:35.443767-05	\N	\N
1594	Ubicación	\N	1	t	\N	14	1550	1	2026-01-07 09:45:35.443767-05	\N	\N
1595	Ubicación	\N	1	t	\N	14	1556	1	2026-01-07 09:45:35.443767-05	\N	\N
1596	Ubicación	\N	1	t	\N	14	1581	1	2026-01-07 09:45:35.443767-05	\N	\N
1597	Lotes del distrito de Lince	\N	1	f	\N	14	1583	1	2026-01-07 09:45:35.443767-05	\N	\N
1598	Manzanas del distrito de Lince	\N	1	f	\N	14	1583	1	2026-01-07 09:45:35.443767-05	\N	\N
1599	Sectores del distrito de Lince	\N	1	f	\N	14	1583	1	2026-01-07 09:45:35.443767-05	\N	\N
1600	Vías del distrito de Lince	\N	1	f	\N	14	1583	1	2026-01-07 09:45:35.443767-05	\N	\N
1601	Ubicación	\N	1	t	\N	14	1584	1	2026-01-07 09:45:35.443767-05	\N	\N
1602	Ubicación	\N	1	t	\N	14	1587	1	2026-01-07 09:45:35.443767-05	\N	\N
1603	Ubicación	\N	1	t	\N	14	1588	1	2026-01-07 09:45:35.443767-05	\N	\N
1604	Áreas Recreacionales	\N	1	f	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1605	Componentes de Vía	\N	1	f	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1606	Construcciones	\N	1	f	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1607	Lotes Catastrales	\N	1	t	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1608	Manzanas Catastrales	\N	1	t	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1609	Numeración de puertas	\N	1	f	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1610	Ortofotografia Aerea del año 2022	\N	1	f	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1611	Vías	\N	1	t	\N	14	1589	1	2026-01-07 09:45:35.443767-05	\N	\N
1612	Ubicación	\N	1	t	\N	14	1592	1	2026-01-07 09:45:35.443767-05	\N	\N
1613	Ubicación	\N	1	t	\N	14	1647	1	2026-01-07 09:45:35.443767-05	\N	\N
1614	Vaso de Leche	\N	1	t	\N	14	1657	1	2026-01-07 09:45:35.443767-05	\N	\N
1615	Vaso de Leche	\N	1	t	\N	14	1686	1	2026-01-07 09:45:35.443767-05	\N	\N
1616	Ubicación	\N	1	t	\N	14	1763	1	2026-01-07 09:45:35.443767-05	\N	\N
1617	Ubicación	\N	1	t	\N	14	1834	1	2026-01-07 09:45:35.443767-05	\N	\N
1618	Ubicación	\N	1	t	\N	14	1837	1	2026-01-07 09:45:35.443767-05	\N	\N
1619	Manzanas	\N	1	t	\N	14	1861	1	2026-01-07 09:45:35.443767-05	\N	\N
1620	Ubicación	\N	1	t	\N	14	1884	1	2026-01-07 09:45:35.443767-05	\N	\N
1621	Ubicación	\N	1	t	\N	14	1948	1	2026-01-07 09:45:35.443767-05	\N	\N
1622	Ubicación	\N	1	t	\N	14	1958	1	2026-01-07 09:45:35.443767-05	\N	\N
1623	Ubicación	\N	1	t	\N	14	1978	1	2026-01-07 09:45:35.443767-05	\N	\N
1624	Ubicación	\N	1	t	\N	14	1997	1	2026-01-07 09:45:35.443767-05	\N	\N
1625	Ubicación	\N	1	t	\N	14	2001	1	2026-01-07 09:45:35.443767-05	\N	\N
1626	Ubicación	\N	1	t	\N	14	2058	1	2026-01-07 09:45:35.443767-05	\N	\N
1627	Red Vial de la Provincia de Rioja	\N	1	t	\N	19	2077	1	2026-01-07 09:45:35.443767-05	\N	\N
1628	Ubicación	\N	1	t	\N	14	2106	1	2026-01-07 09:45:35.443767-05	\N	\N
1629	Centros de atención	\N	1	t	\N	17	2147	1	2026-01-07 09:45:35.443767-05	\N	\N
1630	Centros de cobranza	\N	1	t	\N	20	2147	1	2026-01-07 09:45:35.443767-05	\N	\N
1631	Calidad de Agua Subterranea 2022 - Descenso	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1632	Calidad de Agua Subterranea 2022 - Estiaje	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1633	Calidad de Agua Subterranea 2022 - Incremento	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1634	Calidad de Agua Subterranea 2023 - Descenso	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1635	Calidad de Agua Subterranea 2023 - Estiaje	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1636	Calidad de Agua Subterranea 2023 - Incremento	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1637	Calidad de Agua Subterranea 2024 - Estiaje	\N	1	f	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1638	Calidad de Agua Subterranea 2024 - Incremento	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1639	Calidad de Agua Subterranea 2024 Descenso	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1640	Comportamiento Conductividad Eléctrica 2022 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1641	Comportamiento Conductividad Eléctrica 2022 - Estiaje	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1642	Comportamiento Conductividad Eléctrica 2023 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1643	Comportamiento Conductividad Eléctrica 2024 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1644	Comportamiento Nivel Freático 2022 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1645	Comportamiento Nivel Freático 2022 - Estiaje	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1646	Comportamiento Nivel Freático 2023 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1647	Comportamiento Nivel Freático 2024 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1648	Monitoreo Drenaje Anual 2022	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1649	Monitoreo Drenaje Anual 2023	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1650	Monitoreo Drenaje Anual 2024	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1651	Monitoreo Superficial Anual 2022	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1652	Monitoreo Superficial Anual 2023	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1653	Monitoreo Superficial Anual 2024	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1654	Red Monitoreo de Pozos 2022 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1655	Red Monitoreo de Pozos 2022 - Estiaje	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1656	Red Monitoreo de Pozos 2023 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1657	Red Monitoreo de Pozos 2024 - Avenida	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1658	Red Monitoreo de Pozos 2024 - Estiaje	\N	1	t	\N	2	2148	1	2026-01-07 09:45:35.443767-05	\N	\N
1659	Afiliados activos del seguro SALUDPOL (Derechohabiente)	\N	1	t	\N	17	2149	1	2026-01-07 09:45:35.443767-05	\N	\N
1660	Afiliados activos del seguro SALUDPOL (Titular)	\N	1	t	\N	17	2149	1	2026-01-07 09:45:35.443767-05	\N	\N
1661	Pasivo ambiental minero Aladino VI	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1662	Pasivo ambiental minero Caridad	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1663	Pasivo ambiental minero Huacrish	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1664	Pasivo ambiental minero La Florida I	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1665	Pasivo ambiental minero Pushaquilca	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1666	Pasivo ambiental minero San Antonio de Esquilache	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1667	Pasivo ambiental minero Santa Rosa 2	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1668	Pasivo ambiental minero Santa Teresita	\N	1	t	\N	5	2150	1	2026-01-07 09:45:35.443767-05	\N	\N
1669	Actividades culturales	\N	1	t	\N	5	2151	1	2026-01-07 09:45:35.443767-05	\N	\N
1670	Actividades deportivas	\N	1	t	\N	5	2151	1	2026-01-07 09:45:35.443767-05	\N	\N
1671	Convenios e intervenciones interinstitucionales	\N	1	t	\N	5	2151	1	2026-01-07 09:45:35.443767-05	\N	\N
1672	Escuelas culturales	\N	1	t	\N	5	2151	1	2026-01-07 09:45:35.443767-05	\N	\N
1673	Escuelas deportivas	\N	1	t	\N	5	2151	1	2026-01-07 09:45:35.443767-05	\N	\N
1674	Becas otorgadas año 2012	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1675	Becas otorgadas año 2013	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1676	Becas otorgadas año 2014	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1677	Becas otorgadas año 2015	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1678	Becas otorgadas año 2016	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1679	Becas otorgadas año 2017	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1680	Becas otorgadas año 2018	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1681	Becas otorgadas año 2019	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1682	Becas otorgadas año 2020	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1683	Becas otorgadas año 2021	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1684	Becas otorgadas año 2022	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1685	Becas otorgadas año 2023	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1686	Becas otorgadas año 2024	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
1687	Becas otorgadas año 2025	\N	1	t	\N	17	2153	1	2026-01-07 09:45:35.443767-05	\N	\N
\.


--
-- TOC entry 5873 (class 0 OID 373805)
-- Dependencies: 229
-- Data for Name: def_categorias; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_categorias (id, codigo, nombre, sigla, definicion, id_padre, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	1	Categoría ISO 19115	ISO19115	Es una norma internacional que define un esquema estándar para la creación de metadatos, que son descripciones detalladas de los datos geográficos	0	1	2025-08-15 00:00:00-05	\N	\N
2	001	Agricultura	farming	Cría de animales y/o cultivo de plantas. Ejemplos: agricultura, irrigación, acuicultura, plantaciones, plagas, epidemias y enfermedades que afectan a las cosechas y al ganado	1	1	2025-08-15 00:00:00-05	\N	\N
3	002	Biología	biota	Flora y fauna en el medio natural. Ejemplos: fauna, vegetación, ciencias biológicas, ecología, vida salvaje, vida marina, pantanos, hábitat	1	1	2025-08-15 00:00:00-05	\N	\N
4	003	Límites	boundaries	Descripciones legales del terreno. Ejemplos: límites administrativos y políticos	1	1	2025-08-15 00:00:00-05	\N	\N
5	004	Atmósfera, Climatología, Meteorología	climatologyMeteorologyAtmosphere	Procesos y fenómenos de la atmósfera. Ejemplos: cobertura nubosa, tiempo, clima, condiciones atmosféricas, cambio climático, precipitación	1	1	2025-08-15 00:00:00-05	\N	\N
6	005	Economía	economy	Actividades económicas, condiciones y empleo. Ejemplos: producción, trabajo, ingresos, comercio, industria, turismo y ecoturismo, silvicultura, políticas pesqueras, caza comercial y de subsistencia, exploración y explotación de recursos tales como minerales, aceite y gas	1	1	2025-08-15 00:00:00-05	\N	\N
7	006	Elevación	elevation	Altura sobre o bajo el nivel del mar. Ejemplos: altitud, batimetría, modelos digitales del terreno, pendiente y productos derivados	1	1	2025-08-15 00:00:00-05	\N	\N
8	007	Medio Ambiente	environment	Recursos medio ambientales, protección y conservación. Ejemplos: contaminación ambiental, tratamiento y almacenamiento de desechos, valoración del impacto ambiental, monitoreo del riesgo medioambiental, reservas naturales, paisaje	1	1	2025-08-15 00:00:00-05	\N	\N
9	008	Información Geocientífica	geoscientificInformation	Información perteneciente a las ciencias de la Tierra. Ejemplos: procesos y fenómenos geofísicos, geología, minerales, ciencias relacionadas con la composición, estructura y origen de las rocas de la Tierra, riesgo sísmico, actividad volcánica, corrimiento de tierras, gravimetría, suelos, permafrost, hidrología y erosión	1	1	2025-08-15 00:00:00-05	\N	\N
10	009	Salud	health	Salud, servicios de salud, ecología humana y seguridad. Ejemplos: dolencias y enfermedades, factores que afectan a la salud, higiene, abusos de sustancias, salud mental y física, servicios de salud	1	1	2025-08-15 00:00:00-05	\N	\N
11	010	Cobertura de la Tierra con Mapas Básicos e Imágenes	imageBaseMapsEarthCover	Cartografía básica. Ejemplos: usos del suelo, mapas topográficos, imágenes, imágenes sin clasificar, anotaciones	1	1	2025-08-15 00:00:00-05	\N	\N
12	011	Inteligencia Militar	intelligenceMilitary	Redes militares, estructuras, actividades. Ejemplos: cuarteles, zonas de instrucción, transporte militar, alistamiento	1	1	2025-08-15 00:00:00-05	\N	\N
13	012	Aguas Interiores	inlandWaters	Fenómenos de agua interior, sistemas de drenaje y sus características. Ejemplos: ríos y glaciares, lagos de agua salada, planes de utilización de aguas, presas, corrientes, inundaciones, calidad de agua, planes hidrológicos	1	1	2025-08-15 00:00:00-05	\N	\N
14	013	Localización	location	Información posicional y servicios. Ejemplos: direcciones, redes geodésicas, puntos de control, servicios y zonas postales, nombres de lugares	1	1	2025-08-15 00:00:00-05	\N	\N
15	014	Océanos	oceans	Fenómenos y características de las aguas saladas (excluyendo las aguas interiores). Ejemplos: mareas, movimientos de marea, información de costa, arrecifes	1	1	2025-08-15 00:00:00-05	\N	\N
16	015	Planeamiento Catastral	planningCadastre	Información usada para tomar las acciones más apropiadas para el uso futuro de la tierra. Ejemplos: mapas de uso de suelo, mapas de zonas, levantamientos catastrales, propiedad del terreno	1	1	2025-08-15 00:00:00-05	\N	\N
17	016	Sociedad	society	Características de la sociedad y las culturas. Ejemplos: asentamientos, antropología, arqueología, educación, creencias tradicionales, modos y costumbres, datos demográficos, áreas y actividades recreativas, valoraciones de impacto social, crimen y justicia, información censal	1	1	2025-08-15 00:00:00-05	\N	\N
18	017	Estructuras	structure	Construcciones hechas por el hombre. Ejemplos: construcciones, museos, iglesias, fábricas, viviendas, monumentos, tiendas, torres	1	1	2025-08-15 00:00:00-05	\N	\N
19	018	Transporte	transportation	Medios y ayudas para transportar personas y mercancías. Ejemplos: carreteras, aeropuertos, pistas de aterrizaje, rutas, vías marítimas, túneles, cartas náuticas, localización de barcos o vehículos, cartas aeronáuticas, ferrocarriles	1	1	2025-08-15 00:00:00-05	\N	\N
20	019	Redes de Suministro	utilitiesCommunication	Redes de agua, de energía, de retirada de residuos, de infraestructura de comunicaciones y servicios. Ejemplos: hidroeléctricas, fuentes de energía geotermal, solar y nuclear, distribución y depuración de agua, recogida y almacenamiento de aguas residuales, distribución de gas y energía, comunicación de datos, telecomunicaciones, radio, redes de comunicación	1	1	2025-08-15 00:00:00-05	\N	\N
\.


--
-- TOC entry 5885 (class 0 OID 373890)
-- Dependencies: 241
-- Data for Name: def_herramientas_digitales; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_herramientas_digitales (id, id_tipo_servicio, nombre, descripcion, estado, recurso, id_categoria, id_institucion, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
426	10	Ecozonas	Cobertura de Ecozonas del Perú, corresponde a subpoblaciones usadas para el inventario nacional forestal y de fauna silvestre, definido en base en criterios fisiográfico, fisionómico, florístico, capacidad de almacenamiento de carbono y accesibilidad. Esta cobertura es empleada por los administrados en comunidades para aplicar al mecanismo de compensación de multas por conservación de bosques.	t	https://sisfor.osinfor.gob.pe/visor/	5	56	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:49:49.325484-05
429	10	Itinerarios de la Red Vial Nacional	Itinerarios de la Red Vial Nacional en formato KML	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Itinerario/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:05.5116-05
430	10	Mantenimien to de la Red Vial Nacional	Mantenimiento de la Red Vial Nacional en formato KML	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Mantenimiento/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:42.188905-05
431	10	Mapa de Oficina Zonales 2019	Ámbito geográfico de Oficinas Zonales de DEVIDA	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=2	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:43.215039-05
432	10	Mapa de Población Objetivo PIRDAIS 2019	Ámbito geográfico de intervención de la Población Objetiva del Programa Presupuestal del PIRDAIS 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=3	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:44.258151-05
433	10	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Corredor Amazónico	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona estratégica del Corredor Amazónico año 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=4	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:45.270142-05
434	10	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Huallaga	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica del Huallaga año 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=5	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:52.289579-05
435	10	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI La Convención-Kosñipata	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica La Convención-Kosñipata año 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=6	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:51:59.211388-05
436	10	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Sur Amazónico	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica Sur Amazónico año 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=7	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:00.21102-05
437	10	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI Triple Frontera	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica La Convención-Kosñipata año 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=8	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:01.092698-05
438	10	Mapa de Proyectos y Actividades PIRDAIS 2020 - ZEI VRAEM	Ubicación de Proyectos y Actividades del PIRDAIS en la Zona Estratégica VRAEM año 2020	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=9	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:02.088768-05
439	10	Mapas temáticos de Ayacucho	Mapas temáticos del departamento de Ayacucho para descargar	t	https://www.regionayacucho.gob.pe/SIGWEB/	14	246	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:02.801867-05
440	10	Monitoreo de la Superficie Cultivada con Arbusto de hoja de Coca en producción 2017	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio Peruano, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2017.	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=10	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:03.72233-05
441	10	Monitoreo de la Superficie Cultivada con Arbusto de hoja de Coca en producción 2018	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio Peruano, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2018.	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=11	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:04.670996-05
442	10	Monitoreo de la Superficie Cultivada en Áreas Naturales Protegidas 2017	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio de Áreas Naturales Protegidas, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2017.	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=13	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:05.611046-05
227	5	GEOMININTER	Web con información espacial de datos dirigidos a la seguridad ciudadana	t	https://geoportal.mininter.gob.pe/	17	81	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:32:59.092007-05
335	6	SIN NOMBRE	El observatorio actualmente muestra información de la criminalidad en el Perú	t	http://atlas.indaga.minjus.gob.pe:8080/visor/	17	76	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:37.366551-05
384	8	Aplicativo de Historia de los penales del Perú	Es un plataforma con enfoque de StoryMap donde se presenta la historia, cartografia y localización de cada penal del Perú.	t	https://storymaps.arcgis.com/stories/bedfb2ba0aec41d8a649808a6e51c364	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:41:02.102428-05
228	5	Geoportal del Gobierno Regional Loreto	Es una plataforma de Servicios que permite la difusión e intercambio de información geoespacial.	t	https://geoportal.regionloreto.gob.pe/	14	255	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:01.341011-05
229	5	Geoportal del MIDAGRI	Es el medio oficial para el acceso, uso e intercambio de información espacial que genera el MIDAGRI. Aprobado por R.M. N.° 451-2019-MINAGRI.	t	https://geo.midagri.gob.pe/#	2	168	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:20.081214-05
385	8	Carreteras concesionadas por OSITRAN	OSITRAN supervisa 16 contratos de concesión de carreteras a nivel nacional, que permiten el crecimiento económico conectado de las poblaciones más alejadas del país.	t	https://www.ositran.gob.pe/carreteras/	19	54	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:41:33.511557-05
449	10	Puentes de la Red Vial Nacional	Puentes de la Red Vial Nacional en formato KML	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Puentes/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:54:38.601978-05
230	5	Geoportal IDER UCAYALI	El Geoportal de la Infraestructura de Datos Espaciales - IDE del Gobierno Regional de Ucayali, como medio oficial para el acceso, uso e intercambio de información geoespacial  establecida mediante  Resolución Ejecutiva Regional N° 468-2018-GRU-GR	t	http://ider.regionucayali.gob.pe/	14	264	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:40.032463-05
231	5	Geoportal IDERSan Martín	Es una plataforma de Servicios que permite la difusión e intercambio de información geoespacial.	t	https://geoportal.regionsanmartin.gob.pe/	14	261	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:45.40641-05
232	5	Geoportal INGEMMET	Portal de información georreferenciada de la geología y el catastro minero nacional.	t	https://ingemmet-peru.maps.arcgis.com/home/index.html	20	176	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:50.018031-05
233	5	GEOSERFOR	Portal web de la Infraestructura de Datos Espaciales del SERFOR, cuya finalidad es ofrecer a los usuarios el acceso a una serie de recursos y servicios basados en la información geográfica espacial forestal y de fauna silvestre.	t	https://geo.serfor.gob.pe/geoserfor/	5	173	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:53.720439-05
234	5	IDE IGP	Mostrar la información generada por el Instituto Geofísico del Perú e impulsar los estudios y/o productos que se derivan de estos.	t	https://www.igp.gob.pe/servicios/infraestructura-de-datos-espaciales/	8	74	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:55.001512-05
333	6	SedapalWeb	Mostrar a los usuarios la información cartográfica de los activos de SEDAPAL, la cual permite gestionar, analizar y realizar actividades preventivas o correctivas sobre nuestros activos enlazando con información comercial y operativa.	t	http://gisprd.sedapal.com.pe/sedapalweb/	20	221	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:06.973033-05
235	5	IDESEP	La infraestructura de Datos Espaciales del SENAMHI PERU (IDESEP) es un conjunto de políticas, estándares, procesos, tecnologías y recursos humanos que se encuentran integrados y destinados a facilitar la producción, estandarización, uso y acceso a la información geoespacial del SENAMHI, teniendo como base la información estandarizada, oficial y oportuna para la toma de decisiones.	t	https://idesep.senamhi.gob.pe/portalidesep/	8	75	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:33:56.31241-05
236	5	Infraestructur a de Datos Espaciales del Gobierno Regional Cajamarca	Consolida los enlaces a los distintos sistemas de información, además de brindar los serviciox WMS y los archivos KMZ	t	http://ide.regioncajamarca.gob.pe/	14	247	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:01.17921-05
237	5	Mapa Audiovisual del Patrimonio Cultural Inmaterial Peruano	Mapa Audiovisual del Patrimonio Cultural Inmaterial Peruano	t	https://geoportal.cultura.gob.pe/audiovisual/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:03.276932-05
238	5	Portal interactivo de fiscalización ambiental (PIFA)	El Portal Interactivo de Fiscalización Ambiental (PIFA) es una plataforma  de información proveniente desde diversas fuentes y tecnologías en campo y gabinete; registrada, sistematizada, procesada y actualizada sobre el estado del ambiente y las acciones de fiscalización ambiental en el Perú.	t	https://sistemas.oefa.gob.pe/pifa/mfe/#/	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:34.626149-05
240	6	Atlas de Energia Solar del Peru -2003	Sistema que tiene como objetivo promover la aplicación sostenible de energía fotovoltaica en zonas rurales del país, como una alternativa limpia, libre de la emisión de gases de efecto invernadero	t	http://dger.minem.gob.pe/vista/informacion_geografica.html	20	174	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:36.656112-05
241	6	Biodiversidad y ecosistemas	La aplicación Biodiversidad y Ecosistemas tiene la finalidad de mostrar información de los parques de la ciudad que tienen rutas de observación de aves, las especies que se pueden avistar por cada parque, entre otros datos geográficos de interés relacionados al tema de biodiversidad y ecosistemas	t	https://sit.icl.gob.pe/biodiversidad_smia/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:38.986654-05
242	6	Carta educativa	Carta educativa de las Direcciones Regionales de Educación y Unidades de Gestión Educativa Local en formato PDF. La oferta educativa se ubica a nivel del centro poblado.	t	http://escale.minedu.gob.pe/carta-educativa	17	97	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:39.684812-05
243	6	Catálogo de Datos y Servicios	El catálogo de datos y servicios es una herramienta que aprovecha los datos sobre todo el conjunto de activos de datos y servicios web que mantiene OEFA para crear entradas que concentran toda la información relevante sobre un activo de datos en un solo lugar.	t	https://pifa.oefa.gob.pe/catalogo/main	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:55.158225-05
244	6	Catastro Virtual	Visor de Mapas Temáticos	t	http://cvc.cofopri.gob.pe/(S(x4iy51zeolu2or55awfp55jn))/webRecomendaciones.aspx	20	219	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:56.139195-05
245	6	Centro histórico de Lima	La aplicación web denominada PROLIMA se realizó en coordinación con la Gerencia de Cartografía y Tecnologías de la Información con el objetivo de mostrar los diversos monumentos y predios con Valor Monumental en Cercado de Lima y los distritos colindantes, dentro de estos inmuebles de carácter monumental y con valor monumental	t	https://sit.icl.gob.pe/prolima/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:02.792956-05
246	6	Cobertura Movil	Aplicativo informatico, mediante el cual el usuario puede conocer la cobertura del servicio movil en cada una de las localidades declaradas por las empresas operadoras ante el OSIPTEL.	t	https://serviciosweb.osiptel.gob.pe/CoberturaMovil/	17	51	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:06.005549-05
247	6	Código Postal Nacional  - Ministerio de Transportes y Comunicaciones	Plataforma oficial del Ministerio de Transportes y Comunicaciones (MTC) para consultar el Código Postal Nacional del Perú, permitiendo buscar y verificar el código postal de cualquier dirección en el país.	t	http://www.codigopostal.gob.pe/pages/invitado/consulta.jsf	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:08.324091-05
248	6	Conecta Lima - Programa Nacional de Telecomunicaciones	Mapa interactivo del Programa Nacional de Telecomunicaciones (PRONATEL) que visualiza las localidades y el avance del Proyecto de Instalación de Banda Ancha para la Conectividad Integral y Desarrollo Social en la Región Lima.	t	http://pronatelconectalima.pe/mapa	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:18.954955-05
249	6	Consulta de suministro de abastecimiento	Consulta de suministro de abastecimiento. Información proporcionada por SEDAPAL	t	https://sedapal.maps.arcgis.com/apps/webappviewer/index.html?Íd=90b9ac00a9d843o28f9536380a854000	20	221	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:24.42092-05
250	6	Cordilleras Glaciares	Mapa de Cordilleras Glaciares	t	https://www.arcgis.com/home/webscene/viewer.html?webscene=aa4e314afb4d4558a12f51fdb021bb7c&viewpoint=cam:-72.21665555,-23.73000922,2176541.167;360,24.93	8	73	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:27.299789-05
251	6	Datacrim	Sistema de información de estadisticas de la criminalidad	t	https://datacrim.inei.gob.pe/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:28.403455-05
252	6	Datass -Modelo para la toma de decisiones en Saneamiento	Aplicativo informático que registra datos de acceso, calidad y sostenibilidad de los servicios de saneamiento en el ámbito rural, fortaleciendo la toma de decisiones del sector.	t	https://datass.vivienda.gob.pe/#	20	215	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:35:40.997721-05
253	6	Descarga de información espacial del MED	Descarga de información espacial del MED	t	http://sigmed.minedu.gob.pe/descargas/	17	97	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:36:11.552663-05
254	6	Emergencias 24 horas	Muestra la relación de las últimas emergencias registradas en la Central de Emergencias.	t	https://sgonorte.bomberosperu.gob.pe/24horas	17	82	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:36:18.634596-05
255	6	Emergencias Viales - Provias Nacional	Visor de Emergencias Viales de Provías Nacional que muestra el estado de las carreteras en tiempo real, reportando alertas de tránsito (normal, restringido, interrumpido) por diversos factores como fenómenos naturales, accidentes o disturbios sociales.	t	http://wsgcv.proviasnac.gob.pe/sgcv_emergenciavial	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:36:19.733252-05
256	6	ESCALE	Sistema georreferenciado para la ubicacion de centros poblados con servicios educativos, indicadores de educacion, mapas de Direcciones Regionales de Educacion y UGEL	t	http://escale.minedu.gob.pe/mapas	17	97	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:36:22.435492-05
257	6	ESTADIST	Sistema de información distrital para la gestión publica	t	https://estadist.inei.gob.pe/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:36:23.556751-05
258	6	Expedición Huascarán 2019	En esta ocasión el equipo liderado por Lonnie Thompson, investigador experto en paleoclimatologia, y su equipo llegaron hasta las faldas del nevado mas imponente del Perú.	t	https://inaigem.maps.arcgis.com/apps/MapJournal/index.html?appid=e17070683caf4072aa756636dff345d8	8	73	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:36:30.652283-05
334	6	SIGEO PRODUCE	Sistema que permite identificar los agrupamientos empresariales con el fin de focalizar mejor las intervenciones del Estado	t	http://sigeo.produce.gob.pe/appgis/	6	223	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:18.58321-05
336	6	SIN NOMBRE	Observatorio Nacional de Política Criminal	t	https://indagaweb.minjus.gob.pe/	17	76	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:38.099908-05
259	6	Geo Transportes y Comunicaciones - Ministerio de Transportes y Comunicaciones	El visor geográfico "Geo Transportes y Comunicaciones" es una herramienta tecnológica interactiva que facilita la visualización y consulta de capas de información del Sector Transportes y Comunicaciones, en los siguientes grupos temáticos: transportes, comunicaciones, logística, gestión del riesgo de desastres e información básica territorial.	t	https://vgeoportal.mtc.gob.pe/index.php	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:37:27.19187-05
260	6	Geo visor IDER Ucayali	Permite visualizar, realizar consultas, descargar informacion de un modo sencillo accediendo a la información de diferentes ámbitos administrativos.	t	https://ider.regionucayali.gob.pe/visor	14	264	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:37:37.617078-05
271	6	Geoportal del Ministerio de Transportes y Comunicaciones	El Geoportal del Ministerio de Transportes y Comunicaciones es la plataforma oficial para el acceso y consulta a los datos, mapas, servicios y aplicaciones de información geográfica espacial y estadística producidos o administrados por el sector Transportes y Comunicaciones. En este espacio digital encontrarás la información sobre la ubicación de las diversas infraestructuras de transportes y de telecomunicaciones desplegadas a nivel nacional, así como la distribución y cobertura de los principales servicios de transportes y comunicaciones. La plataforma contiene de forma complementaria, información básica territorial producida por las entidades públicas productoras.	t	https://geoportal.mtc.gob.pe	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:20.19074-05
274	6	Geoportal SERNANP	Herramienta online, desarrollada como parte de la implementación de la infraestructura de datos espaciales (IDE) del SERNANP, a través de la cual podrás acceder a las aplicaciones y servicios de información geoespacial.	t	https://geoportal.sernanp.gob.pe/	8	69	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:28.468803-05
275	6	GEOPORTAL SISCOD	Accede a información cartográfica y georreferenciada sobre la Política Nacional Contra las Drogas	t	https://sistemas.devida.gob.pe/geoportal/inicio.html	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:30.135072-05
313	6	MONITOREO DE LA VEGETACIÓN PARA LA PREVENCIÓN DE INCENDIOS FORESTALES	Aplicación que muestra el monitoreo de la humedad relativa de la vegetación	t	https://ide.igp.gob.pe/geovisor/ndvi/	8	74	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:50.246001-05
314	6	MONITOREO DE PELIGRO VOLCÁNICO	Aplicación que muestra escenarios de riesgo del volcán Misti en una posible actividad	t	https://ide.igp.gob.pe/portal/apps/dashboards/1c26d652f18f4771b218afa82fc94897	8	74	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:57.782983-05
315	6	MONITOREO DE RIESGO DE DESASTRES	La aplicación web de Gestión de Riesgo de Desastres muestra la información de Estudios de Riesgo que viene realizando la Subgerencia de Estimación, Prevención, Reducción y Reconstrucción en los diversos distritos de Lima Metropolitana	t	https://sit.icl.gob.pe/gdcgdr_app/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:00.725803-05
316	6	MONITOREO SÍSMICO	Tablero de monitoreo de simos reportados en tiempo real del presente año	t	https://ide-igp.maps.arcgis.com/apps/dashboards/1ee1b5f32a424426aca0b1b81660e34c	8	74	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:04.201353-05
317	6	Obras municipales	Mapa con ubicación geográfica de obras municipales publicado por la Municipalidad de San Borja	t	http://www.munisanborja.gob.pe/mapa-de-obras/	14	1597	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:05.816419-05
318	6	Observatorio del Agua	Plataforma digital interactiva que recopila información hidrica a nivel nacional para una mejor gestión de los recursos hídricos, tales como estadísticas de la demanda del agua a nivel de cuencas, información de proyectos de formalización de uso del agua, embalses histórica, data sobre inventarios de pozos con datos detallados y otros.	t	https://snirh.ana.gob.pe/ObservatorioSNIRH/	2	172	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:07.659762-05
319	6	Peligros hidrometeorológicos en unidades fiscalizables	Visualización, consulta y análisis de los peligros hidrometeorológicos (activación de quebradas y precipitaciones)en unidades fiscalizables	t	https://pifa.oefa.gob.pe/AppPeligrosUF/	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:14.842661-05
320	6	Planos estratificados por ingresos a nivel de manzanas de las grandes ciudades	Sistema de información a nivel de manzana del ingreso per cápita para las grandes ciudades.	t	https://planoestratificado.inei.gob.pe/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:16.310694-05
321	6	Plataforma del Geoservidor del MINAM	Es una plataforma de Servicios que cuenta con mecanismos de difusion e intercambio de informacion geoespacial que se pone a disposicion de los profesionales, sectores de gobierno, gobiernos regionales, gobiernos locales y sociedad civil en general.	t	https://geoservidor.minam.gob.pe/	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:19.873514-05
322	6	Plataforma Digital FONDEPES	Mapa online que permite conocer el estado actual de los desembarcaderos pesqueros artesanales.	t	https://plataformadigital.fondepes.gob.pe/mapa	6	224	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:22.753745-05
323	6	Plataforma GEOBOSQUES	Es una plataforma de servicios de información sobre el monitoreo de los cambios de la cobertura de los bosques, que cuenta con cinco sub-módulos de información temática: Bosque y pérdida de bosque, Alertas tempranas, Uso y cambio de uso de la tierra, Degradación, Escenarios de referencia.	t	https://geobosques.minam.gob.pe/geobosque/view/index.php	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:25.895623-05
324	6	Portal Cartográfico GeoCallao	Difusión de contenidos de lugares de interés, rutas de transporte público, calles y AAHH del Callao	t	https://geocallao-regioncallao.hub.arcgis.com/	14	464	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:33.81914-05
325	6	Portal de Datos Espaciales del Peru GeoIDEP	Proporciona un servicio de acceso unificado a datos, servicios y aplicaciones geoespaciales de la informacion territorial que producen y usan todas las entidades del sector publico y privado.	t	https://www.gob.pe/idep	17	45	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:42.453149-05
326	6	Portal de Infraestructura de Datos Espaciales del INEI	El presente geoportal tiene como objetivo promover el uso y diseminación de la información geoespacial relevante, para la planificación, el desarrollo sostenible y el impulso de las Infraestructuras de Datos Espaciales. Ofrecemos a nuestros usuarios el acceso a aplicaciones y servicios para encontrar, compartir, procesar y utilizar de manera gratuita e interactiva la información.	t	https://ide.inei.gob.pe/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:44.419368-05
327	6	RED DE CICLOVÍAS	El presente aplicativo web denominado Red de Ciclovías se realizó en coordinación con la Subgerencia de Transporte No Motorizado de la Municipalidad de Lima	t	https://sit.icl.gob.pe/ciclovias_app/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:53.372961-05
328	6	RED DE PANELES PUBLICITARIOS	El aplicativo web denominado Paneles Publicitarios se realizó en coordinación con la Gerencia de Cartografía y Tecnologías de la Información con el objetivo de acercar a los usuarios, gobiernos locales, entidades públicas, privadas, comunidad académica y público en general a un mayor conocimiento de los anuncios y avisos publicitarios autorizados y ubicados en Lima Metropolitana.	t	https://sit.icl.gob.pe/gdu_paneles/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:32:55.465912-05
337	6	SIRTOD	Sistema regional para la toma de decisiones	t	https://systems.inei.gob.pe/SIRTOD/#	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:40.0631-05
424	10	Conservación por Niveles de Servicios	Conservación por Niveles de Servicios en formato KML	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_CNS/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:49:38.786755-05
425	10	Demarcación Territorial	Brinda la información correspondiente a Limites Interdepartamentales, EDZ, SOT y categorizaciones.	t	https://dt.regioncajamarca.gob.pe/	14	247	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:49:42.105905-05
443	10	Monitoreo de la Superficie Cultivada en Áreas Naturales Protegidas 2018	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio de Áreas Naturales Protegidas, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2018.	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=14	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:06.506864-05
444	10	Monitoreo de la Superficie Cultivada en Áreas Naturales Protegidas 2019	Mapa de densidad de cultivos muestra la concentración de las áreas que han sido sembradas con cultivos de coca en el territorio de Áreas Naturales Protegidas, su valor se calcula a partir de las hectáreas de los polígonos cultivados que se encuentran en un kilómetro cuadrado año 2019.	t	https://sistemas.devida.gob.pe/geoporta1/vl/RepositorioMapas/descargarDocu?idArchivo=15	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:07.540583-05
445	10	Obras de la Red Vial Nacional	Obras de la Red Vial Nacional	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Obras/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:52:44.187202-05
446	10	Peajes concesionados de la Red Vial Nacional	Peajes concesionados de la Red Vial Nacional en formato KML	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_PeajesConcesionados/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:53:20.816254-05
447	10	Peajes no concesionados de la Red Vial Nacional	Peajes no concesionados de la Red Vial Nacional en formato KML	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_PeajesNoConcesionados/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:53:57.488851-05
448	10	Portal Principal Ordenamiento Territorial GRC	Contiene toda la información correspondiente al proceso de Ordenamiento Territorial de Cajamarca incluyendo mapas y shapefiles	t	http://zeeot.regioncajamarca.gob.pe/	14	247	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:54:01.957336-05
450	10	Red Vial Nacional	Red Vial Nacional	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_InfraestructuraVial/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:55:15.266144-05
261	6	GEO ZEE-OT Cajamarca	Muestra los mapas correspondientes al proceso de Ordenamiento Territorial	t	http://sigr.regioncajamarca.gob.pe/	14	247	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:37:38.332999-05
262	6	GeoAMAZONAS	Portal de la Infraestructura de Datos Espaciales del Gobierno Regional Amazonas	t	http://geoportal.regionamazonas.gob.pe/	14	242	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:37:57.135444-05
263	6	GeoANP	Herramienta interactiva que permite a los usuarios localizar, visualizar y descargar información espacial que se genera como parte de la gestión de las Áreas Naturales Protegidas (ANP); además brinda acceso al servicio de superposición de áreas de interés o coordenadas con el catastro de ANP y sus zonas de amortiguamiento (ZA)	t	https://geo.sernanp.gob.pe	8	69	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:38:28.007588-05
264	6	GEOCATASTRO	Representar información catastral del distrito de Miraflores mediante diferentes tipos de capas	t	https://geocatastro.miraflores.gob.pe/#/	14	1589	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:38:59.039119-05
265	6	GEOCATMIN	Sistema de Información Geológico y Catastral Minero	t	https://geocatmin.ingemmet.gob.pe/	20	176	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:04.345714-05
266	6	GeoJusticia	Sistema para la Visualizacion de las Dependencias Judiciales, Distritos Judiciales, Corte suprema, etc.	t	https://geojusticia.pj.gob.pe/basegispj/index.php	17	66	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:06.00409-05
267	6	Geollaqta	Plataforma de Catastro Multipropósito. Cofopri implementa, gestiona, actualiza y ejecuta el Catastro Urbano Nacional. Promueve y establece mecanismos de intercambios de información proveniente de diferentes Entidades Generadores de Catastro.	t	https://catastro.cofopri.gob.pe/geollaqta/	20	219	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:07.337991-05
268	6	GeoPerú	GeoPerú, es el Sistema Nacional de Información Geográfica que integra los datos espaciales e información de los diversos sectores del Estado, para la toma de decisiones a nivel territorial.	t	http://www.geoperu.gob.pe/	17	45	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:14.246749-05
269	6	GeoPortal de Datos Fundamentales del IGN	Geoportal del Instituto Geográfico Nacional	t	http://www.idep.gob.pe/	12	189	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:17.482192-05
270	6	Geoportal del Ministerio de Cultura	El Geoportal del Ministerio de Cultura, es una Infraestructura de Datos Espaciales que integra información geográfica y estadística del sector cultura. Con un acceso dinámico y de fácil manejo, para apoyar en la toma de decisiones e informar al ciudadano.	t	https://geoportal.cultura.gob.pe/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:19.577236-05
272	6	Geoportal del OTASS	El geoportal del OTASS es una herramienta que permite visualizar y enlazar con todos los productos GIS generados por el OTASS, meviante la ejecución de sus estrategias, proyectos y/o programas en marcha.	t	https://sig.otass.gob.pe/portal/apps/experiencebuilder/experience/?id=a60b271320d2452aa35e986ff2998059	20	218	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:22.658168-05
273	6	Geoportal INAIGEM	Geoportal del Instituto Nacional de Investigación en Glaciares y Ecosistemas de Montaña INAIGEM.	t	https://inaigem.gob.pe/web2/geoportal/	8	73	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:26.027177-05
276	6	GeoSunass	GeoSunass ha sido diseñado para ser de fácil acceso y uso. Permite al usuario manejar adecuadamente sus funcionalidades y herramientas de manera intuitiva. Asimismo, permite almacenar, integrar y compartir información interoperable de otras entidades relacionadas a los servicios de saneamiento.	t	https://geosunass.sunass.gob.pe/	17	53	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:31.33963-05
277	6	GeoVisor	Visor de mapas de información climatologica del Servicio Nacional de Meteorología e Hidrología del Perú (SENAMHI)	t	https://idesep.senamhi.gob.pe/geovisoridesep/	8	75	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:39:58.136961-05
329	6	RED DE SEMAFOROS	La aplicación web de la gestión de la Red Semafórica no Centralizada nos muestra la información en un panel de control como una herramienta de gestión, esta aplicación la viene realizando la GERENCIA DE MOVILIDAD URBANA en los diversos distritos de Lima metropolitana	t	https://sit.icl.gob.pe/gmu/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:33:04.096333-05
330	6	Registro de denuncias ambientales	Información georreferenciada sobre denuncias ambientales registradas ante el OEFA	t	https://oefa.maps.arcgis.com/apps/dashboards/9d24b76e3b6c4c7cb4035ff36d93902c	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:33:14.032573-05
331	6	Reporta Residuos Ciudadano	Conoce las alertas de Residuos sólidos reportadas en tu distrito y las acciones de limpieza realizadas por las municipalidades	t	https://oefa.maps.arcgis.com/apps/webappviewer/index.html?id=7618e413435d495baf20c2e0167eab0e	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:33:27.921021-05
332	6	Retroceso Glaciar 1989 -2018	Mapa de Retroceso Glaciar 1989 - 2018	t	https://inaigem.maps.arcgis.com/apps/StorytellingSwipe/index.html?appid=fdb720b1e2c542ae933f872a2babd63e	8	73	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:33:48.256081-05
360	6	Visor de Alertas de Siniestros Viales - Ministerio de Transportes y Comunicaciones	Mapa interactivo del Ministerio de Transportes y Comunicaciones (MTC) que permite a los ciudadanos conocer el estado de las carreteras a nivel nacional en tiempo real.	t	https://sratma.mtc.gob.pe/SRATMA/mapa/	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:26.092986-05
278	6	GeoVisor Cartográfico	Visor de Mapas que proporciona toda la información que genera el ministerio en temas de saneamiento urbano y rural, así como los temas de vivienda.	t	https://geo2.vivienda.gob.pe/enlaces/geovisor.html	20	215	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:40:26.87719-05
418	9	Portal de metadatos geográficos del SERNANP	Esta aplicación desarrollada permite acceder a información descriptiva (metadatos) de los datos geográficos. Esta información puede ser de mucha utilidad para trabajos de geoprocesamiento y análisis.	t	https://metadatosgeograficos.sernanp.gob.pe/metadatos/srv/spa/catalog.search#/home	8	69	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:41.342628-05
419	10	Compendio de Mapas 2022	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	t	https://www.gob.pe/institucion/mtc/informes-publicaciones/4517084	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:50.879449-05
420	10	Compendio de Mapas 2023 - I Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	t	https://www.gob.pe/institucion/mtc/informes-publicaciones/5137608	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:53.869675-05
421	10	Compendio de Mapas 2023 - II Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	t	https://www.gob.pe/institucion/mtc/informes-publicaciones/5987687	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:56.582318-05
422	10	Compendio de Mapas 2024 - I Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	t	https://www.gob.pe/institucion/mtc/informes-publicaciones/6161466	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:59.346291-05
312	6	Mapas Viales	Permite acceder a información sobre las Rutas Viales del Sistema Nacional de Carreteras (SINAC), puentes, ríos, abras, ciudades, centros poblados, otros puntos de interés	t	https://portal.mtc.gob.pe/transportes/caminos/normas_carreteras/mapas_viales.html	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:40.616586-05
279	6	Geovisor de cartografia de peligro aplicado en los penales del Perú	El GEOVISOR de cartografía de peligro aplicado a los penales, es una plataforma geoespacial en la web, de libre acceso, diseñada para consultar, compartir, analizar y monitorear la información relacionada a peligros originados por fenómenos naturales.	t	https://www.arcgis.com/apps/webappviewer/index.html?id=5cbec598dc0c4e27b03579eb083b6a23	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:40:57.766326-05
280	6	Geovisor de mapeo de Lugar de Procedencia de los internos del Perú	El Geovisor de Lugar de Procedencia de la Población Penitenciaria es una plataforma geoespacial en la web de libre acceso diseñada para consultar, compartir, analizar y monitorear la información georreferenciada de la Población Penitenciaria. Se han georreferenciado 81,988 datos de la variable Lugar de Procedencia de los PPL a nivel nacional al mes de Marzo 2022.	t	https://inpe.maps.arcgis.com/apps/webappviewer/index.html?id=7ca61cba81b642978a44840ec0770390	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:41:01.370018-05
281	6	GeoVivienda	Plataforma que proporciona acceso unificado a información, servicios y aplicaciones geoespaciales de la información territorial que viene produciendo y usando el MVCS, como soporte al diseño, planificación, seguimiento de intervenciones y contribuir al cierre de brechas y la mejora de la calidad de los servicios.	t	http://geo.vivienda.gob.pe	20	215	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:41:05.703206-05
282	6	GESTION DE CERCADO DE LIMA	Este aplicativo muestra la información catastral y el grupo de capas temáticos en el cual se carga la información enviada por otras entidades públicas o privadas, gerencias de MML y otras dependencias vinculadas a la MML en el ámbito de Cercado de Lima	t	https://sit.icl.gob.pe/cercado_lima_app/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:41:07.783557-05
283	6	Gestión integral de residuos sólidos	Identifica las áreas degradadas por residuos sólidos municipales y no municipales	t	https://pifa.oefa.gob.pe/AppResiduos/	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:41:31.455526-05
284	6	Grifo con tienda	El visor permite ubicar los grifos y restaurantes, utilizando GPS del aplicativo para visualizar grifos y tiendas cercanas, para el abastecimiento de productos para los transportistas de carga, la cual se abastecen a la población en época de la emergencia sanitaria COVID-19, Dicha información es coordinada con la Dirección de Políticas y Normas en Transporte Acuático.	t	https://vgrifos.mtc.gob.pe/	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:42:12.319737-05
285	6	Info-MIDIS	La plataforma de información geo-referenciada INFOMIDIS permite la visualizacion y disposición de información sobre cobertura (usuarios) de los programas sociales MIDIS, indicadores socioeconómicos, desnutrición crónica infantil, y vulnerabilidad.	t	https://sdv.midis.gob.pe/Infomidis/	17	233	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:42:12.934184-05
286	6	Intervenciones por Ámbito de interés	Búsqueda por Departamento, Provincias, Distritos,  cuencas hidrográficas, comunidades campesinas, comunidades nativas.	t	https://sistemas.oefa.gob.pe/Portalpifa/Intervenciones.do	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:42:44.307809-05
287	6	Investigación en Ecosistemas de Montaña	INAIGEM hace investigación para recuperar y conservar los ecosistemas de montaña y los servicios que estos brindan. Busca rescatar, revalorar y potenciar los conocimientos tradicionales para quienes viven cerca de estos ecosistemas, ya sean instituciones o pobladores, complementándolos y fortaleciéndolos con innovaciones y conocimientos científicos.	t	https://inaigem.maps.arcgis.com/apps/MapSeries/index.html?appid=8e1b90922fdc4fcc94ee41eld44b61a6	8	73	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:42:48.012624-05
288	6	LICENCIAS DE EDIFICACIÓN	La aplicación Licencia de Edificaciones se realizo en conjunto con la Gerencia de Desarrollo Urbano y tiene como objetivo facilitar la información de licencia de edificaciones de los predios de Cercado de Lima en los años 2016 y 2019.	t	https://sit.icl.gob.pe/gdu_app/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:42:49.772682-05
289	6	Mapa Base de Información urbana	Base de información del equipamiento socioeconomico y urbano del GORE Callao.	t	https://regioncallao.maps.arcgis.com/apps/webappviewer/index.html?id=8cbfbc1802e14dc7bef5db4dcef096ff	14	464	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:42:59.345235-05
290	6	Mapa Cultural del Sur	Sistema integrado de información cultural de los siguientes estados: Argentina, Bolivia, Brasil, Chile, Colombia, Ecuador, Paraguay, Perú, Uruguay.\nPaís invitado: Costa Rica.	t	https://geoportal.cultura.gob.pe/mapa_cultural_del_sur/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:01.582164-05
291	6	Mapa de alertas de la Superintendencia de transporte terreste de personas, carga y mercancías - SUTRAN	Mapa interactivo de alertas de SUTRAN que informa en tiempo real sobre el estado del tránsito a nivel nacional, incluyendo bloqueos por accidentes, daños en infraestructura o disturbios, manteniendo la información actualizada las 24 horas.	t	http://gis.sutran.gob.pe/alerta_sutran/	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:05.310836-05
292	6	Mapa de alertas de la Superintendencia de transporte terrestre de personas, carga y mercancías - SUTRAN (centro de gestión y monitoreo)	Plataforma virtual de la SUTRAN que ofrece información y servicios relacionados con la supervisión y fiscalización del transporte terrestre de personas, carga y mercancías en ámbitos nacional e internacional.	t	https://gis.sutran.gob.pe/STR_web/	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:06.548247-05
293	6	Mapa de ciclovias	Mapa de ciclovias disponibles publicado por la Municipalidad de San Borja	t	http://www.munisanborja.gob.pe/mapa-de-las-ciclovias/	14	1597	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:08.151442-05
427	10	Estudios de la Red Vial Nacional	Estudios de la Red Vial Nacional	t	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_Estudios/MapServer/generateKML	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:50:25.975581-05
226	5	GEOINPE	El GEOINPE, es la plataforma oficial para el acceso, uso y visualización de la información georreferenciada de la Población Penitenciaria que genera el Instituto Nacional Penitenciario.	t	https://arcg.is/0yXC1e	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:32:57.943722-05
294	6	Mapa de Ciudadanía y Patrimonio Cultural	El presente visor de mapas virtual permite conocer el ecosistema social (sociedad civil, instituciones, empresas y otros) que participan activamente en dichas estrategias y proyectos que implementa la Dirección de Participación Ciudadana a nivel nacional, además de las acciones que realizan por su legado cultural local, generando desarrollo local en sus territorios.	t	https://geoportal.cultura.gob.pe/participacion/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:10.077441-05
295	6	Mapa de Escuelas	Esta es una herramienta interactiva que permite a usuarios en línea, localizar la oferta del servicio educativo en cada centro poblado o localidad del Perú, así como conocer las características territoriales en la que las instituciones educativas están insertas.	t	http://sigmed.minedu.gob.pe/mapaeducativo/	17	97	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:11.130989-05
296	6	Mapa de Evacuación y Señalética ante ocurrencia de Tsunamis	Rutas de evacuación, señalética de evacuación, refugios y albergues temporales ante ocurrencia de sismos que generan Tsunami en la Prov.Constitucional del Callao.	t	https://regioncallao.maps.arcgis.com/apps/webappviewer/index.html?id=c131439ec6754be3b8eac75305355623	14	464	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:43:18.541214-05
297	6	Mapa de fiscalización ambiental	Conoce las acciones de supervisión por subsectores fiscalizables del OEFA y por ámbito territorial	t	https://pifa.oefa.gob.pe/mfiscamb/index.html#	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:29:20.790237-05
298	6	Mapa de Paisajes Naturales	El presente visor de mapas virtual permite conocer la distribución de los paisajes culturales declarados e identificados hasta hoy, así como los elementos culturales que lo caracterizan, su relación con otras categorías de patrimonio y otros detalles de la administración del territorio, con el propósito de contribuir en el conocimiento del patrimonio cultural del país y como una herramienta para la toma de decisiones	t	https://geoportal.cultura.gob.pe/mapa_paisajes_culturales/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:29:33.939506-05
299	6	MAPA DE UBICA TU COMISARIA	Visor web que permite al usuario ubicar la comisaría mas cercana y trazar la ruta más optima para llegar a ella.	t	https://geomininter.mininter.gob.pe/portal/apps/webappviewer/index.html?id=4b3387e1beaf4f919925dcc013bb4cd7	17	81	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:29:35.454808-05
300	6	Mapa de ubicación de recursos turísticos y emprendimientos de turismo rural	Sistema de información georeferencial de los atractivos turísticos y emprendimientos de turismo rural comunitario del Perú, ofreciendo una búsqueda por criterio geográfico, actividades a desarrollar en el recurso. u otros.	t	https://sigmincetur.mincetur.gob.pe/turismo/	17	206	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:29:37.807141-05
301	6	MAPA DEL DELITO GEORREFERENCIADO	Visor web que permite al usuario ubicar las zonas de mayor concentración de delitos georreferenciados y conocer las zonas de mayor inseguridad y tomar medidas preventivas. Ademas el aplicativo permite mayores funcionabilidades dependiendo del nivel técnico que realice consultas.	t	https://geomininter.mininter.gob.pe/portal/apps/webappviewer/index.html?id=4b3387e1beaf4f919925dcc013bb4cd7	17	81	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:29:39.288639-05
302	6	Mapa Energético Minero	Presenta información de los sistemas energéticos por sub sector (Electricidad, Gas Natural, Hidrocarburos y RER) en beneficio de todos los actores que tienen interacción u operan en dichos sistemas así como del público en general.	t	https://gisem.osinergmin.gob.pe/menergetico/	17	52	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:30:10.231118-05
303	6	Mapa Etnolingüístico del Perú	Sistema informativo y herramienta de planificación para una adecuada toma de decisiones en materia de uso, promoción, recuperación y preservación de las lenguas indígenas u originarias del Perú	t	https://geoportal.cultura.gob.pe/mapa_etnolinguistico/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:30:22.859817-05
304	6	Mapa Geoétnico	Mapa Geoétnico de Presencia Concentrada del Pueblo Afroperuano en el Territorio Nacional”, documento que contiene información actualizada sobre la cantidad de hogares afroperuanos y centros poblados con presencia del pueblo afroperuano en el territorio nacional, basado en los datos proporcionados por el Censo Nacional 2017: XII Censo Nacional de Población, VII de Vivienda y III de Comunidades Indígenas	t	https://geoportal.cultura.gob.pe/mapa_afroperuano/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:30:25.531138-05
305	6	Mapa Global de Publicaciones (Amazonia)	La Colección Ictiológica del IIAP es un acervo científico que resguarda ejemplares de peces amazónicos recolectados en diversos ecosistemas acuáticos de la cuenca amazónica peruana, con el fin de conservar y documentar su biodiversidad; cada espécimen cuenta con datos de colecta que permiten su uso en estudios taxonómicos, ecológicos y de conservación, convirtiéndose en una referencia clave para investigadores, estudiantes y gestores en el manejo sostenible de los recursos pesqueros de la Amazonía.	t	https://visores.iiap.gob.pe/publicaciones/	8	72	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:30:30.055381-05
306	6	Mapa interactivo	Mapa interactivo con información del Ministerio de Comercio Exterior y Turismo	t	https://www.mincetur.gob.pe/centro_de_Informacion/mapa_interactivo/	17	206	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:30:31.824483-05
307	6	Mapa interactivo de la BDPI	En este mapa podrá realizar consultas sobre la ubicación referencial de los pueblos indígenas u originarios y sus localidades, tales como comunidades nativas, comunidades campesinas y Reservas Territoriales Indígenas. Asimismo, podrá observar elementos de ubicación geográfica como vías asfaltadas, ríos principales, capitales departamentales, provinciales y distritales	t	https://bdpi.cultura.gob.pe/mapa-interactivo	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:30:43.421671-05
308	6	Mapa SEIN	Visor de infraestructura de generación y transmisión electrica a nivel nacional	t	https://gisem.osinergmin.gob.pe/nuevo_mapasein	17	52	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:15.109564-05
309	6	Mapa Sonoro	Mapa que muestra la distribucipon de hablantes de las lenguas indígenas del Perú.	t	https://geoportal.cultura.gob.pe/mapa_sonoro/	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:17.940827-05
310	6	Mapas de la Infraestructura de Transporte	Información acerca de mapas de la Infraestructura de Transporte proporcionada por el Ministerio de Transportes y Comunicaciones.	t	https://portal.mtc.gob.pe/estadisticas/transportes.html	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:19.923741-05
311	6	Mapas Perú	Sistema que permite la exploracion y valoracion visual de mapas que son provistos por las entidades publicas y privadas que conforman la Infraestructura de Datos Espaciales del Peru.	t	http://mapas.geoidep.gob.pe/mapasperu/	17	45	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:31:38.555915-05
338	6	SISFOR	Plataforma web donde se publica información de títulos habilitantes forestales y de fauna silvestre supervisados por el OSINFOR y otros relacionados, permitiendo fortalecer la transparencia de nuestras actividades ante los administrados y público en general.	t	https://sisfor.osinfor.gob.pe/visor/	5	56	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:47.587013-05
339	6	Sistema de Consulta de Agua Potable	Sistema que cobertura información de manzana para la cobertura de agua potable	t	https://agua.inei.gob.pe/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:34:49.110066-05
340	6	Sistema de Consulta de centros poblados	Sistema de consulta con indicadores relevantes para los centros poblados	t	http://atlas.inei.gob.pe/inei/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:07.769714-05
341	6	Sistema de Consulta de Centros Poblados	Sistema de Consulta de Centros Poblados que brinda información geográfica, demográfica y social de los centros poblados del país.	t	http://sige.inei.gob.pe/test/atlas/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:11.003985-05
342	6	Sistema de Datos Micro Regionales VRAEM	Sistema de datos en cooperación con CENTROGEO-México para la generación de indicadores en el VRAEM.	t	https://sdmr.inei.gob.pe/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:12.220154-05
343	6	Sistema de Fenómeno el Niño	Permite conocer los riesgos y vulnerabilidad a que está expuesta la población peruana ante la llegada del fenómeno de El Niño y otros fenómenos naturales	t	http://webinei.inei.gob.pe/nino/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:13.287737-05
344	6	Sistema de Información Ambiental Regional SIAR	Sistema de Información Ambiental Regional SIAR administrado por la Gerencia de Recursos Naturales y Gestión del Medio Ambiente	t	http://siar.regioncajamarca.gob.pe/visor/	14	247	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:15.776506-05
345	6	Sistema de Información de Lucha Contra las Drogas -SISCOD	SISCOD es una herramienta de gestión destinada a integrar y estandarizar la recolección, registro, manejo y consulta de datos, bases de datos y estadísticas, a través de la interacción con otros sistemas que gestionen la información en el ámbito institucional y multisectorial de la lucha contra las drogas, que faciliten el seguimiento, monitoreo y evaluación de la Política Nacional Contra las Drogas.	t	https://sistemas.devida.gob.pe/siscod/	17	49	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:17.175262-05
346	6	Sistema de Información GeoCOSTA	El Sistema de Información para zonas marino costeras -GeoCOSTA es una herramienta de aplicación web geoespacial, diseñado para la visualización, análisis de cartografía georreferenciada y almacenamiento de soporte digital de las diferentes capas espaciales de información temática que contribuirán en el proceso de planificación para la toma de decisiones y desarrollo sostenible de las zonas marino costeras del país.	t	https://geoservidor.minam.gob.pe/geocostas/	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:20.974725-05
347	6	Sistema de Información Geográfica para Emprendedores	Permite identificar a nivel de áreas geográficas personalizadas las potencialidades del mismo, ya sea identificando las características de las viviendas y de población distribuida por sexo, edad, nivel educativo e ingresos promedio	t	http://sige.inei.gob.pe/sige/	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:22.178722-05
348	6	Sistema de Información para la Gestión del Riesgo y Desastre	El objetivo principal del sistema es brindar información geoespacial y registros administrativos referidos al riesgo de desastres así como herramientas y/o funcionalidades que permitan a los usuarios acceder, consultar, analizar, monitorear, procesas modelos, cargar y descargar información fundamental que sirva de apoyo para el planeamiento y formulación de proyectos de inversión pública vinculados a la estimación, prevención, reducción de riesgo de desastres y la reconstrucción.	t	https://sigrid.cenepred.gob.pe/sigridv3/	12	188	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:23.272526-05
349	6	Sistema de Información para la Planificación Urbana -Territorial	El Sistema de Información para la Planificación Urbana -Territorial (GEOPLAN), es una herramienta Web que permite interactuar con la Información Geográfica Referenciada disponible en cada uno de los Planes Urbano Territoriales.	t	https://geo2.vivienda.gob.pe/enlaces/geoplan.html	20	215	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:27.145784-05
350	6	SISTEMA DE INFORMACIÓN TERRITORIAL -SIT	Es un visor que muestra una serie de servicios que produce la institución a nivel de Cercado de Lima e información de otras entidades a nivel de Lima Metropolitana.	t	https://sit.icl.gob.pe/sit/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:34.44612-05
351	6	SISTEMA DE MANTENIMIENTO	Este aplicativo muestra información de los mantenimientos programados por la MML y de esta forma, mantenerse al tanto de las acciones que se vienen realizando ello en el marco de los servicios que esta comuna brinda.	t	https://sit.icl.gob.pe/planificacion_mml/	14	268	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:37.197582-05
352	6	Sistema de toma de decisiones	Sistema de Informacion Regional para la toma de decisiones.	t	https://systems.inei.gob.pe/SIRTOD/#	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:38.163112-05
353	6	Sistema Georeferenciado de Redes de Telecomunicaciones	Aplicativo basado en un Visor Web que permite visualizar la informacion publica Georreferenciada de las Redes de Telecomunicaciones desplegadas en el territorio peruano, incluyendo las zonas rurales.	t	https://serviciosweb.osiptel.gob.pe/VISORGIS/Visor/VisorPublico.aspx	17	51	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:40.520874-05
354	6	Sistema Regional de Gestión Territorial de Madre de Dios	Geoportal de la Infraestructura de Datos Espaciales del Gobierno Regional de Madre de Dios	t	http://ide.regionmadrededios.gob.pe/	14	256	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:35:43.281542-05
355	6	SUSALUD map	Aplicativo informático en el cual podrá consultar sobre las condiciones de funcionamiento de los Establecimientos de Salud y Servicios Médicos de Apoyo que se encuentran registrados en el RENIPRESS y cuentan con datos de georreferenciación.	t	http://mapa.susalud.gob.pe/	10	161	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:02.018024-05
356	6	Ubícanos a Nivel Nacional	Muestra la ubicación de las compañías y comandancias departamentales del CGBVP a nivel nacional.	t	http://www.bomberosperu.gob.pe/cgbvp_maps.asp	17	82	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:03.602466-05
357	6	Vigilancia ambiental de la calidad de aire	Consulta la calidad de aire en tiempo real a nivel nacional.	t	https://pifa.oefa.gob.pe/VigilanciaAmbiental/	5	70	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:12.754282-05
358	6	Visor Cartográfico -GEOSERFOR	El GEOSERFOR es una herramienta tecnológica web, para disponer y consultar en internet la información geográfica sobre la gestión forestal. El GEOSERFOR cuenta con varias capas de información como son: las concesiones forestales, los bosques de producción permanente, las unidades de aprovechamiento, los bosques locales, la zonificación forestal y más.	t	https://geo.serfor.gob.pe/visor/#	5	173	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:17.678349-05
359	6	Visor Cartográfico Institucional GOTASS	El GOTASS es una herramienta de tipo geovisor que permite visualizar, consultar, actualizar y analizar información georeferenciada del OTASS y otras entidades técnico científicas generadoras de información georeferenciada. Asimismo, el OTASS desarrolla de manera continua aplicativos web con tecnología GIS de acuerdo a las necesidades generadas en las áreas usuarias competentes, considerando las estrategias, proyectos y/o programas en marcha.	t	https://app.otass.gob.pe/gotass	20	218	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:20.221177-05
239	6	Área Funcional de Sensoramien to Remoto (AFSR)	Sistema que permite acceder a información del mar peruano.	t	https://satelite.imarpe.gob.pe/#/	6	225	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 12:34:35.878127-05
361	6	Visor de colección ictiologia	La Colección Ictiológica del IIAP es un acervo científico que resguarda ejemplares de peces amazónicos recolectados en diversos ecosistemas acuáticos de la cuenca amazónica peruana, con el fin de conservar y documentar su biodiversidad; cada espécimen cuenta con datos de colecta que permiten su uso en estudios taxonómicos, ecológicos y de conservación, convirtiéndose en una referencia clave para investigadores, estudiantes y gestores en el manejo sostenible de los recursos pesqueros de la Amazonía.	t	https://ictiologicas.iiap.gob.pe/lotes/index/visor	8	72	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:31.398702-05
362	6	Visor de Emergencias del Centro de Operaciones de Emergencias del Ministerio de Transportes y Comunicaciones	Mapa interactivo del Ministerio de Transportes y Comunicaciones (MTC) que pemite a los ciudadanos contar con información sobre las incidencias en carreteras, vías férreas, puertos y aeropuertos. La información se actualiza permanentemente las 24 horas del día.	t	https://saecoe.mtc.gob.pe/visor	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:48.541784-05
363	6	Visor de Emergencias Hidricas	Monitorea y brinda información sobre peligros, emergencias y desastres relacionados a los recursos hídricos	t	https://snirh.ana.gob.pe/onrh/Index2.aspx?IdVar=39	2	172	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:36:50.303295-05
364	6	Visor de la Infraestructura de Datos Espaciales de Loreto	Sistema que permite la exploración y descarga de mapas de la Región Loreto	t	http://visor.regionloreto.gob.pe/	14	255	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:37:08.955958-05
365	6	Visor de la Red Vial Nacional - Provias Nacional	Visor geográfico (WEBMAP) de Provías Nacional que permite consultar y visualizar la Red Vial Nacional y las intervenciones realizadas por Provías Nacional.	t	https://spwgm.proviasnac.gob.pe/webmap	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:37:13.212142-05
366	6	Visor de Mapas de Electrificación Rural - DGER	Sistema de Consulta Web de Datos Espaciales de los Sistemas Eléctricos Rurales	t	https://mapas.minem.gob.pe/map_dger/	20	174	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:37:18.433879-05
367	6	Visor de Mapas de GeoSunass	Visor de mapas de GeoSunass que permite visualizar información georreferenciada publicada por SUNASS y diversas entidades relacionadas a los servicios de saneamiento, generar reportes y descargar información en línea.	t	https://experience.arcgis.com/experience/12dd1e86bc3046eca8ba0b82b77ca508/	17	53	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:37:21.778983-05
368	6	Visor de mapas de la IDE Madre de Dios	Visor de mapas de la Infraestructura de Datos Espaciales del Gobierno Regional de Madre de Dios	t	http://ide.regionmadrededios.gob.pe/geohub/default/home/index	14	256	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:37:24.037975-05
369	6	Visor de mapas de la Infraestructur a de Datos Espaciales de Amazonas	Visor de mapas de la Infraestructura de Datos Espaciales de Amazonas	t	http://visor.regionamazonas.gob.pe/indexv.php	14	242	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:37:42.785902-05
370	6	Visor de mapas del INAIGEM	Visor de mapas que concentra las investigaciones de los glaciares y ecosistemas de montaña elaborados por el Instituto Nacional de Investigación en Glaciares y Ecosistemas de Montaña (Inaigem).	t	https://visor.inaigem.gob.pe/	8	73	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:38:04.262754-05
371	6	Visor de mapas del potencial eólico del Perú 2016	Ubicación con estadísticas de monitoreo sobre el Potencial Eólico del Perú	t	https://mapas.minem.gob.pe/map_eolico/	20	174	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:38:07.839518-05
372	6	Visor de mapas del Potencial Hidroeléctric o en la cuentas del Apurímac, Madre de Dios, Purús, Grande	Ubicación y descripción de Proyectos con Potencial Hidroeléctrico en la cuentas del Apurímac, Madre de Dios, Purús, Grande, Chili, Tambo y Titicaca	t	https://mapas.minem.gob.pe/map_hidroelectrico/	20	174	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:38:18.508413-05
373	6	Visor de mapas del SIG-DGER, referida al sistema de electrificació n rural	Elaborado con el fin de consultar y compartir información de los sistemas de electrificación rural a nivel nacional	t	https://mapas.minem.gob.pe/map_dger/	20	174	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:38:22.254924-05
374	6	Visor de mapas del Sistema Nacional de Informacion Ambiental	Sistema que permite la visualizacion de informacion ambiental del SINIA	t	https://sinia.minam.gob.pe/portal/mapas-sinia/	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:38:53.443391-05
375	6	Visor de Mapas IDERSAM	El visor de mapas brinda acceso a información espacial generada por el Gobierno Regional de San Martín en el cumplimiento de sus funciones. Estos datos tiene carácter oficial y están a disposición de la comunidad.	t	https://geoportal.regionsanmartin.gob.pe/visor/	14	261	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:38:54.909364-05
423	10	Compendio de Mapas 2024 - II Semestre	El Compendio de Mapas del Ministerio de Transportes y Comunicaciones, es una publicación periódica de mapas cuyo fin es difundir la información geográfica del sector Transportes y Comunicaciones, para dar a conocer la infraestructura de los diferentes modos de transportes a escala nacional y departamental, así como temáticas referidas a las inversiones en ejecución e indicadores de brechas de infraestructura.	t	https://www.gob.pe/institucion/mtc/informes-publicaciones/6763678	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:49:02.037345-05
428	10	Información disponible Geoservidor	Esta herramienta permite disponer de información en formato shapefiles, a fin de ser utilizadas por los espacialistas en los diferentes analisis espaciales.	t	https://geoservidor.minam.gob.pe/recursos/intercambio-de-datos/	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:50:28.836689-05
376	6	Visor del Geoservidor del MINAM	Es una Plataforma de Servicios que cuenta con mecanismos de difusión e intercambio de información geoespacial que se pone a disposición de profesionales, sectores de gobierno, gobiernos regionales, gobiernos locales y sociedad civil en general; para que a través del internet puedan acceder a información relevante sobre la situación territorial y ambiental del país de manera transparente y actualizada.	t	https://gis.bosques.gob.pe/portal/apps/webappviewer/index.html?id=5ba3d89b65b94912a81158020a81acaf	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:02.278324-05
377	6	Visor del Sistema de Información para la Planificación Urbana -Territorial	El Sistema de Información para la Planificación Urbana -Territorial (GEOPLAN), es una herramienta Web que permite interactuar con la Información Geográfica Referenciada disponible en cada uno de los Planes Urbano Territoriales.	t	https://geo2.vivienda.gob.pe/mvcs/index.php	20	215	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:07.898822-05
378	6	Visor GEOBOSQUES	El visor muestra las Alertas Tempranas de Deforestación, la cual es actualizada semanalmente, si un usuario se inscribe al sistema de alertas puede desde este visor gestionar sus áreas de monitoreo y saber cuantas alertas ocurren semanalmente.	t	https://geobosques.minam.gob.pe/geobosque/visor/	8	68	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:11.229509-05
379	6	Visor Geográfico de Publicaciones Amazónicas	Este visor permite mostrar los inventarios realizados por el Instituto en el ámbito de la Amazonia Peruana. Se encuentra clasificado en grupos de Fauna, Flora, Suelos. El usuario podrá hacer uso de otras capas temáticas asi como descargar los datos de los inventarios.	t	https://visores.iiap.gob.pe/inventarios/	8	72	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:15.206122-05
380	6	Visor geográfico del MIDAGRI	Repositorio centralizado y oficial de la información geográfica producida por el sector agrario y de riego.	t	https://geovisor.midagri.gob.pe/	2	168	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:33.935423-05
381	6	Visor GIS - Autoridad Portuaria Nacional	Visor GIS de la Autoridad Portuaria Nacional (APN) que proporciona información geográfica sobre instalaciones portuarias, áreas otorgadas, edificaciones, equipamiento y desarrollo portuario.	t	https://gis.apn.gob.pe/visor_gis/	19	210	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:58.528237-05
382	6	Visor SIAR Cusco	El SIAR, constituye una red de integración tecnológica, institucional y humana que facilita la sistematización, acceso y distribución de la información ambiental en el ámbito territorial de la Región.	t	http://siar.regioncusco.gob.pe/	14	248	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:39:59.313594-05
383	8	Aeropuertos concesionad os por OSITRAN	OSITRAN supervisa y regula 19 aeropuertos concesionados ubicados en distintas ciudades del territorio peruano. La seguridad, calidad de los servicios, tecnología e infraestructura implementada en estos terminales son la base para el desarrollo de la actividad turística y de negocios de nuestro país.	t	https://www.ositran.gob.pe/aeropuertos/	17	54	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:40:30.708939-05
386	8	Dashboard sociodemográfico de Lugar de Procedencia de los internos del Perú	El mapeo de la Población Penitenciaria a nivel nacional, muestra los principales indicadores estadísticos sociodemográfico de la Población Penitenciaria mapeada. Se han georreferenciado 85,448 datos de la variable lugar de procedencia de los internos al mes de marzo 2022.	t	https://arcg.is/LqjaH0	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:41:45.626316-05
387	8	Datos abiertos de la Población Penitenciaria	Es una plataforma donde se ubica la data georrefernciada de la Población Penitenciaria, ubicación de los penales y Medios libres para descargar en todas los formatos de GIS y Ciencia de datos.	t	https://portal-inpe.opendata.arcgis.com/search?collection=dataset&layout=grid	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:41:53.574671-05
388	8	Población con algún tipo de discapacidad en la Prov.Constitucional del Callao	Storymap con Información del Censo de Poblacion y Vivienda 2017 del INEI, donde se muestra poblacion con algun tipo de discapacidad: ver, oir, entender, relacionarse, hablar y moverse.	t	https://storymaps.arcgis.com/stories/16e5e48d32fe4ade887911aa8070c5b5	14	464	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:42:25.05755-05
389	8	Puertos concesionad os que son supervisados por OSITRAN	El OSITRAN supervisa y regula 7 terminales portuarios ubicados en diversas regiones del país, que brindan servicios a exportadores e importadores, permitiendo el intercambio de productos peruanos a nivel internacional.	t	https://www.ositran.gob.pe/puertos/	17	54	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:42:56.149252-05
390	8	Repositorio de Datasets con geoinformacion regional para consulta y descarga libre	Biblioteca de contenidos del GORE Callao con Datasets disponibles para descarga	t	https://geocallao-regioncallao.hub.arcgis.com/search	14	464	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:43:01.507688-05
391	8	Tablero estadístico de Ingresos y Egresos de la Población Penitenciaria	Tablero estadístico de Ingresos y Egresos muestra información estadística de Egreso por Tipos de Libertades e Ingreso por Delitos Específicos.	t	https://www.arcgis.com/apps/dashboards/0096e3f27ee04658aa63aa9a26f34104	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:43:14.353292-05
392	8	Tablero estadístico de la Población Extranjera (Carácteristicas sociodemográficas)	El Geoportal muestra información estadística de la población penal de nacionalidad extranjera por delitos específicos, situación jurídica, evolución histórica y sexo.	t	https://www.arcgis.com/apps/dashboards/72896bfdedf04ac99bb775917f4924e2	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:43:27.133469-05
393	8	Tablero estadistico de los Establecimientos de Medio Libre	Se muestra la ubicación geográfica de los Establecimientos de los Medios Libres del Perú según Oficinas Regionales, departamento, provincia y distrito.	t	https://arcg.is/ynu5z0	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:43:34.215727-05
394	8	Tablero estadistico de los Establecimientos Penitenciarios	Se muestra la ubicación geográfica de los penales del Perú según Oficinas Regionales, departamento, provincia y distrito.	t	https://www.arcgis.com/apps/dashboards/af652684d4e345c1847a4873edab4d80	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:43:37.053554-05
395	8	Tablero estadístico de los Establecimientos Penitenciarios ( Carácteristicas sociodemográficas de los internos del Perú)	Tablero estadístico de los Establecimientos Penitenciarios muestra información estadística de la población penitenciaria	t	https://www.arcgis.com/apps/dashboards/9bfb61bd506f4162b97e3c2fefb53ee2	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:43:53.319543-05
396	8	Tablero Estadístico de los Venezolanos	Este tablero estadistico muestra la información estadística de la población penal de venezolanos por delitos específicos, situación jurídica, evolución histórica y sexo.	t	https://www.arcgis.com/apps/dashboards/b9453691b14d4ff6bf34c2d26d4637ac	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:44:24.421203-05
397	8	Tablero estadístico de Lugar de Procedencia de la Población de Sentenciados de Medio Libre del distrito de San Martín de Porres	Para el distrito de San Martín de Porres se presentan los siguientes análisis:\n1) La problemática de procedencia en función a los delitos generales y específicos.\n2) Los núcleos urbanos con altos índices de densidad de lugar de procedencia.\nEn total se han georreferenciado 731 sentenciados de Medio Libre	t	https://inpe.maps.arcgis.com/apps/MapJournal/index.html?appid=c36a49b7e9304116a109ba9f5c1d3ad4	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:44:28.987217-05
398	8	Tablero estadístico de Lugar de Procedencia de Sentenciados de Medio Libre	Principales indicadores sociodemográficos y focos de concentración del lugar de Procedencia en los distritos de San Juan de Lurigancho, San Martin de Porres, Ate y La Victoria. En total se han georreferenciado 3,039 sentenciados de Medio Libre.	t	https://inpe.maps.arcgis.com/apps/webappviewer/index.html?id=e18032b3eada4470880d7481baadc242&extent=-8600907.8126%2C-1364065.1396%2C-8496724.143%2C-1322330.5222%2C102100	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:44:40.097618-05
399	8	Tablero Estadístico de mapeo de Lugar de Procedencia	El Tablero Estadístico de mapeo de la Población Penitenciaria a nivel nacional, muestra los principales indicadores estadísticos sociodemográfico de la Población Penitenciaria mapeada. Se han georreferenciado 85,448 datos de la variable lugar de procedencia de los internos al mes de Marzo 2022	t	https://www.arcgis.com/apps/dashboards/1bf4a5b854df4d59b7b54326ce9a5629	17	77	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:45:11.308367-05
400	8	Vías férreas concesionadas por OSITRAN	El transporte ferroviario ofrece grandes ventajas como la gran capacidad de carga por eje, la menor tasa de accidentabilidad, el ahorro de combustible, la menor cantidad de emisiones contaminantes y la descongestión de las carreteras. Además constituye el transporte masivo más eficiente de los últimos años.	t	https://www.ositran.gob.pe/vias-ferreas/	19	54	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:45:42.740772-05
401	9	Catálogo de Metadatos Cajamarca	En el portal de metadatos se comparte toda la información producida durante en proceso de Ordenamiento Territorial de Cajamarca, además de mapas y metadatos en XML	t	https://metadatos.regioncajamarca.gob.pe/geonetwork/srv/spa/catalog.search#/home	14	247	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:01.502851-05
402	9	Catálogo de Metadatos de Datos Fundamentales	El objetivo de la gestión de Metadatos de Datos Fundamentales es proporcionar el acceso a la información, facilitando la integración de los mismos (interoperabilidad), enfatizando los beneficios que proporciona la comprensión de la información geográfica. Promueve que se comparta la información temática y georeferenciada disponible entre las organizaciones.	t	https://portalgeo.idep.gob.pe:8443/geonetwork/srv/spa/catalog.search#/home	12	189	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:04.530147-05
403	9	Catálogo de Metadatos de SUNASS	Catálogo de metadatos de información geográfica de la Superintendencia Nacional de Servicios de Saneamiento -SUNASS	t	https://geosunass.sunass.gob.pe/geonetwork/srv/spa/catalog.search#/home	17	53	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:06.300417-05
404	9	Catálogo de Metadatos del Gobierno Regional de Amazonas	Catálogo de metadatos de información geográfica implementado por el Gobierno Regional de Amazonas	t	http://geoportal.regionamazonas.gob.pe/geonetwork/srv/spa/catalog.search#/home	14	242	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:25.03337-05
405	9	Catálogo de Metadatos del GOREU	Información descriptiva de los conjuntos de datos y servicios geográficos: cartografía, fotografías, modelos digitales del terreno, estudios, etc., a través de servicios WMS, WFS .	t	https://ider.regionucayali.gob.pe/geonetwork/srv/spa/catalog.search	14	264	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:38.228888-05
406	9	Catálogo de Metadatos del Instituto Geofísico del Perú	Catálogo con información de metadatos de información geográfica proporcionada por el Instituto Geofísico del Perú	t	https://ide.igp.gob.pe/geonetwork/srv/spa/catalog.search#/home	8	74	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:46.46621-05
407	9	Catálogo de Metadatos del Instituto Nacional de Estadística e Informática	Catalogo de Metadatos de los principales productos que elabora el INEI	t	https://metadatogis.inei.gob.pe/geonetwork/srv/spa/catalog.search#/home	17	46	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:48.048994-05
408	9	Catálogo de Metadatos del MIDAGRI	Integraga la información para distribución del MIDAGRI, a través de servicios WMS, WFS y KML.	t	https://metadatos.midagri.gob.pe/geonetwork/srv/spa/catalog.search#/home	2	168	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:48.760607-05
409	9	Catálogo de metadatos del Ministerio de Cultura	El Catálogo de Metadatos del Ministerio de Cultura contiene la lista de los datos geográficos disponibles de la infraestructura de Datos Espaciales del Sector Cultura.	t	https://catalogo.cultura.gob.pe/geonetwork/srv/spa/catalog.search#/home	17	62	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:46:51.365865-05
410	9	Catálogo de Metadatos del SENAMHI	Catalogo de Metadatos del Servicio Nacional de Meteorología e Hidrología del Perú (SENAMHI)	t	https://idesep.senamhi.gob.pe/geonetwork/srv/spa/catalog.search#/home	8	75	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:47:22.429445-05
411	9	Catálogo de Metadatos Geográficos del OTASS	El catálogo de metadatos geográficos del OTASS es una herramienta que permite buscar metadatos y obtener información detallada sobre la información georeferenciada o geoespacial generada por el OTASS. Los metadatos son datos sobre datos, es decir, información estructurada que describe otra información. La Gestión de Metadatos permite organizar, gestionar, administrar, conocer les características y preservar en el tiempo un conjunto de datos.	t	https://geo.otass.gob.pe/geonetwork/srv/spa/catalog.search#/search?	20	218	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:47:53.69527-05
412	9	Catálogo de Metadatos IDE Madre de Dios	Catálogo de metadatos de la Infraestructura de Datos Espaciales del Gobierno Regional de Madre de Dios.	t	http://ide.regionmadrededios.gob.pe/geonetwork/srv/spa/catalog.search#/home	14	256	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:47:56.452609-05
413	9	Catálogo de Metadatos IDERSAM	El Catálogo de Metadatos permite la documentación y descarga de las diferentes productos cartográficos y geoespaciales proveídos.	t	http://geo.regionsanmartin.gob.pe:8089/geonetwork/srv/spa/catalog.search#/home	14	261	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:47:57.159131-05
414	9	Catalogo Nacional de Metadatos	Sistema de gestion que centraliza y administra la produccion de metadatos de las diferentes entidades publicas.	t	https://catalogo.geoidep.gob.pe/metadatos/srv/spa/catalog.search#/home	17	45	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:00.350759-05
415	9	Geonetwork	Los Servicios de Catálogo constituyen uno de los tres servicios básicos de una Infraestructura de Datos Espaciales - IDE, (conjuntamente con los servicios de visualización - WMS y WMTS - y los servicios de descarga - WFS y WCS) puesto que con este servicio es posible acceder y consultar todos los recursos de informaciones disponibles en una o varias entidades públicas o privadas.	t	http://metadatos.serfor.gob.pe:8080/geonetwork/srv/spa/catalog.search#/home	2	173	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:19.070633-05
416	9	Infraestructur a de Datos Espaciales -SNIRH	Plataforma digital interactiva donde se publica información geográfica relacionada a la gestión de los recursos hídricos para que instituciones publicas y privadas puedan acceder y descargar la información a través de servcios web (WMS y WFS) y Shapefile.	t	https://snirh.ana.gob.pe/ConsultaIDE/	2	172	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:20.73914-05
417	9	Metadatos INGEMMET	Sistema que permite la búsqueda y el acceso a información producida por INGEMMET	t	https://metadatos.ingemmet.gob.pe:8443/geonetwork/srv/spa/catalog.search#/home	20	176	1	2026-01-07 09:44:13.394757-05	\N	2026-01-07 13:48:26.935505-05
\.


--
-- TOC entry 5875 (class 0 OID 373819)
-- Dependencies: 231
-- Data for Name: def_instituciones; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_instituciones (id, codigo, ubigeo, nombre, nro_ruc, direccion_web, sigla, logotipo, orden, estado, id_padre, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	ENTIDAD	\N	PODER EJECUTIVO	\N	\N	PE	\N	1	t	0	1	2025-08-01 00:00:00-05	\N	\N
2	ENTIDAD	\N	PODER LEGISLATIVO	\N	\N	PL	\N	2	t	0	1	2025-08-01 00:00:00-05	\N	\N
3	ENTIDAD	\N	PODER JUDICIAL	\N	\N	PJ	\N	3	t	0	1	2025-08-01 00:00:00-05	\N	\N
4	ENTIDAD	\N	ORGANISMOS AUTÓNOMOS	\N	\N	OA	\N	4	t	0	1	2025-08-01 00:00:00-05	\N	\N
5	ENTIDAD	\N	GOBIERNOS REGIONALES	\N	\N	GR	\N	5	t	0	1	2025-08-01 00:00:00-05	\N	\N
6	ENTIDAD	\N	GOBIERNOS LOCALES	\N	\N	GL	\N	6	t	0	1	2025-08-01 00:00:00-05	\N	\N
7	ENTIDAD	\N	ORGANISMOS NO GUBERNAMENTALES	\N	\N	ONG	\N	7	t	0	1	2025-08-01 00:00:00-05	\N	\N
8	ENTIDAD	\N	ORGANISMOS INTERNACIONALES	\N	\N	I	\N	8	t	0	1	2025-08-01 00:00:00-05	\N	\N
9	ENTIDAD	\N	INSTITUCIONES PRIVADAS	\N	\N	P	\N	9	t	0	1	2025-08-01 00:00:00-05	\N	\N
10	01	\N	PRESIDENCIA CONSEJO MINISTROS	\N	\N	\N	\N	1	t	1	1	2025-01-08 00:00:00-05	\N	\N
11	03	\N	CULTURA	\N	\N	\N	\N	2	t	1	1	2025-01-08 00:00:00-05	\N	\N
12	04	\N	PODER JUDICIAL	\N	\N	\N	\N	3	t	1	1	2025-01-08 00:00:00-05	\N	\N
13	05	\N	AMBIENTAL	\N	\N	\N	\N	4	t	1	1	2025-01-08 00:00:00-05	\N	\N
14	06	\N	JUSTICIA	\N	\N	\N	\N	5	t	1	1	2025-01-08 00:00:00-05	\N	\N
15	07	\N	INTERIOR	\N	\N	\N	\N	6	t	1	1	2025-01-08 00:00:00-05	\N	\N
16	08	\N	RELACIONES EXTERIORES	\N	\N	\N	\N	7	t	1	1	2025-01-08 00:00:00-05	\N	\N
17	09	\N	ECONOMIA Y FINANZAS	\N	\N	\N	\N	8	t	1	1	2025-01-08 00:00:00-05	\N	\N
18	10	\N	EDUCACION	\N	\N	\N	\N	9	t	1	1	2025-01-08 00:00:00-05	\N	\N
19	11	\N	SALUD	\N	\N	\N	\N	10	t	1	1	2025-01-08 00:00:00-05	\N	\N
20	12	\N	TRABAJO Y PROMOCION DEL EMPLEO	\N	\N	\N	\N	11	t	1	1	2025-01-08 00:00:00-05	\N	\N
21	13	\N	AGRARIO Y DE RIEGO	\N	\N	\N	\N	12	t	1	1	2025-01-08 00:00:00-05	\N	\N
22	16	\N	ENERGIA Y MINAS	\N	\N	\N	\N	13	t	1	1	2025-01-08 00:00:00-05	\N	\N
23	19	\N	CONTRALORIA GENERAL	\N	\N	\N	\N	14	t	4	1	2025-01-08 00:00:00-05	\N	\N
24	20	\N	DEFENSORIA DEL PUEBLO	\N	\N	\N	\N	15	t	4	1	2025-01-08 00:00:00-05	\N	\N
25	21	\N	JUNTA NACIONAL DE JUSTICIA	\N	\N	\N	\N	16	t	4	1	2025-01-08 00:00:00-05	\N	\N
26	22	\N	MINISTERIO PUBLICO	\N	\N	\N	\N	17	t	1	1	2025-01-08 00:00:00-05	\N	\N
27	24	\N	TRIBUNAL CONSTITUCIONAL	\N	\N	\N	\N	18	t	4	1	2025-01-08 00:00:00-05	\N	\N
28	26	\N	DEFENSA	\N	\N	\N	\N	19	t	1	1	2025-01-08 00:00:00-05	\N	\N
29	27	\N	FUERO MILITAR POLICIAL	\N	\N	\N	\N	20	t	4	1	2025-01-08 00:00:00-05	\N	\N
30	28	\N	CONGRESO DE LA REPUBLICA	\N	\N	\N	\N	21	t	2	1	2025-01-08 00:00:00-05	\N	\N
31	31	\N	JURADO NACIONAL DE ELECCIONES	\N	\N	\N	\N	22	t	4	1	2025-01-08 00:00:00-05	\N	\N
32	32	\N	OFICINA NACIONAL DE PROCESOS ELECTORALES	\N	\N	\N	\N	23	t	4	1	2025-01-08 00:00:00-05	\N	\N
33	33	\N	REGISTRO NACIONAL DE IDENTIFICACION Y ESTADO CIVIL	\N	\N	\N	\N	24	t	4	1	2025-01-08 00:00:00-05	\N	\N
34	35	\N	COMERCIO EXTERIOR Y TURISMO	\N	\N	\N	\N	25	t	1	1	2025-01-08 00:00:00-05	\N	\N
35	36	\N	TRANSPORTES Y COMUNICACIONES	\N	\N	\N	\N	26	t	1	1	2025-01-08 00:00:00-05	\N	\N
36	37	\N	VIVIENDA CONSTRUCCION Y SANEAMIENTO	\N	\N	\N	\N	27	t	1	1	2025-01-08 00:00:00-05	\N	\N
37	38	\N	PRODUCCION	\N	\N	\N	\N	28	t	1	1	2025-01-08 00:00:00-05	\N	\N
38	39	\N	MUJER Y POBLACIONES VULNERABLES	\N	\N	\N	\N	29	t	1	1	2025-01-08 00:00:00-05	\N	\N
39	40	\N	DESARROLLO E INCLUSION SOCIAL	\N	\N	\N	\N	30	t	1	1	2025-01-08 00:00:00-05	\N	\N
40	99	\N	GOBIERNOS REGIONALES	\N	\N	\N	\N	31	t	5	1	2025-01-08 00:00:00-05	\N	\N
41	M	\N	GOBIERNOS MUNICIPALES	\N	\N	\N	\N	32	t	6	1	2025-01-08 00:00:00-05	\N	\N
42	ONG	\N	ORGANISMOS NO GUBERNAMENTALES	\N	\N	\N	\N	33	t	7	1	2025-01-08 00:00:00-05	\N	\N
43	I	\N	ORGANIZACIONES INTERNACIONALES	\N	\N	\N	\N	34	t	8	1	2025-01-08 00:00:00-05	\N	\N
44	P	\N	PRIVADO	\N	\N	\N	\N	35	t	9	1	2025-01-08 00:00:00-05	\N	\N
45	1	\N	Presidencia del Consejo de Ministros	\N	\N	PCM	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
46	2	\N	Instituto Nacional de Estadística e Informática	\N	\N	INEI	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
47	10	\N	Dirección Nacional de Inteligencia	\N	\N	DINI	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
48	11	\N	Despacho Presidencial	\N	\N	DP	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
49	12	\N	Comisión Nacional para el Desarrollo y Vida sin Drogas	\N	\N	DEVIDA	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
50	16	\N	Centro Nacional de Planeamiento Estratégico	\N	\N	CEPLAN	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
51	19	\N	Organismo Supervisor de la Inversión Privada en Telecomunicaciones	\N	\N	OSIPTEL	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
52	20	\N	Organismo Supervisor de la Inversión en Energía y Minería	\N	\N	OSINERGMIN	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
53	21	\N	Superintendencia Nacional de Servicios de Saneamiento	\N	\N	SUNASS	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
54	22	\N	Organismo Supervisor de la Inversión en Infraestructura de Transporte de Uso Público	\N	\N	OSITRAN	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
55	23	\N	Autoridad Nacional del Servicio Civil	\N	\N	SERVIR	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
56	24	\N	Organismo de Supervisión de los Recursos Forestales y de Fauna Silvestre	\N	\N	OSINFOR	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
57	29	\N	Autoridad Nacional de Infraestructura	\N	\N	ANIN	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
58	31	\N	Organismo de Estudios y Diseño de Proyectos de Inversión	\N	\N	OEDI	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
59	114	\N	Consejo Nacional de Ciencia, Tecnología e Innovación Tecnológica	\N	\N	CONCYTEC	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
60	183	\N	Instituto Nacional de Defensa de la Competencia y de la Protección de la Propiedad Intelectual	\N	\N	INDECOPI	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
61	\N	\N	Proyecto Especial Legado	\N	\N	LEGADO	\N	1	t	10	1	2025-08-01 00:00:00-05	\N	\N
62	3	\N	Ministerio de Cultura	\N	\N	MC	\N	1	t	11	1	2025-08-01 00:00:00-05	\N	\N
63	60	\N	Archivo General de la Nación	\N	\N	CULTURA	\N	1	t	11	1	2025-08-01 00:00:00-05	\N	\N
64	113	\N	Biblioteca Nacional del Peru	\N	\N	BNP	\N	1	t	11	1	2025-08-01 00:00:00-05	\N	\N
65	116	\N	Instituto Nacional de Radio y Televisión del Perú	\N	\N	IRTP	\N	1	t	11	1	2025-08-01 00:00:00-05	\N	\N
66	4	\N	Poder Judicial	\N	\N	PJ	\N	1	t	12	1	2025-08-01 00:00:00-05	\N	\N
67	40	\N	Academia de la Magistratura	\N	\N	AMAG	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
68	5	\N	Ministerio del Ambiente	\N	\N	MINAM	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
69	50	\N	Servicio Nacional de Áreas Naturales Protegidas por el Estado	\N	\N	SERNANP	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
70	51	\N	Organismo de Evaluación y Fiscalización Ambiental	\N	\N	OEFA	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
71	52	\N	Servicio Nacional de Certificación Ambiental para las Inversiones Sostenibles	\N	\N	SENACE	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
72	55	\N	Instituto de Investigaciones de la Amazonia Peruana	\N	\N	IIAP	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
73	56	\N	Instituto Nacional de Investigación en Glaciares y Ecosistemas de Montaña	\N	\N	INAIGEM	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
74	112	\N	Instituto Geofísico del Peru	\N	\N	IGP	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
75	331	\N	Servicio Nacional de Meteorología e Hidrología	\N	\N	SENAMHI	\N	1	t	13	1	2025-08-01 00:00:00-05	\N	\N
76	6	\N	Ministerio de Justicia y Derechos Humanos	\N	\N	MINJUS	\N	1	t	14	1	2025-08-01 00:00:00-05	\N	\N
77	61	\N	Instituto Nacional Penitenciario	\N	\N	INPE	\N	1	t	14	1	2025-08-01 00:00:00-05	\N	\N
78	67	\N	Superintendencia Nacional de los Registros Públicos	\N	\N	SUNARP	\N	1	t	14	1	2025-08-01 00:00:00-05	\N	\N
79	68	\N	Procuraduría General del Estado	\N	\N	PGE	\N	1	t	14	1	2025-08-01 00:00:00-05	\N	\N
80	\N	\N	Programa Nacional de Centros Juveniles	\N	\N	PRONACEJ	\N	1	t	14	1	2025-08-01 00:00:00-05	\N	\N
81	7	\N	Ministerio del Interior	\N	\N	MININTER	\N	1	t	15	1	2025-08-01 00:00:00-05	\N	\N
82	70	\N	Intendencia Nacional de Bomberos del Perú	\N	\N	INBP	\N	1	t	15	1	2025-08-01 00:00:00-05	\N	\N
83	72	\N	Superintendencia Nacional de Control de Servicios de Seguridad, Armas, Municiones y Explosivos de Uso Civil	\N	\N	SUCAMEC	\N	1	t	15	1	2025-08-01 00:00:00-05	\N	\N
84	73	\N	Superintendencia Nacional de Migraciones	\N	\N	MIGRACIONES	\N	1	t	15	1	2025-08-01 00:00:00-05	\N	\N
85	8	\N	Ministerio de Relaciones Exteriores	\N	\N	RR.EE.	\N	1	t	16	1	2025-08-01 00:00:00-05	\N	\N
86	80	\N	Agencia Peruana de Cooperación Internacional	\N	\N	APCI	\N	1	t	16	1	2025-08-01 00:00:00-05	\N	\N
87	\N	\N	Plan Binacional de Desarrollo de la Región Fronteriza Perú - Ecuador	\N	\N	BINACIONAL	\N	1	t	16	1	2025-08-01 00:00:00-05	\N	\N
88	9	\N	Ministerio de Economía y Finanzas	\N	\N	MEF	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
89	55	\N	Agencia de Promoción de la Inversión Privada	\N	\N	PROINVERSION	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
90	57	\N	Superintendencia Nacional de Aduanas y de Administración Tributaria	\N	\N	SUNAT	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
91	58	\N	Superintendencia del Mercado de Valores	\N	\N	SMV	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
92	59	\N	Organismo Especializado para las Contrataciones Publicas Eficientes	\N	\N	OECE	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
93	95	\N	Oficina de Normalización Previsional	\N	\N	ONP	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
94	96	\N	Central de Compras Públicas	\N	\N	PERU COMPRAS	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
95	\N	\N	Banco de la Nación	\N	\N	BN	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
96	\N	\N	Superintendencia de Banca, Seguros y Administradoras Privadas de Fondos de Pensiones	\N	\N	SBS	\N	1	t	17	1	2025-08-01 00:00:00-05	\N	\N
97	10	\N	Ministerio de Educación	\N	\N	MINEDU	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
98	111	\N	Centro Vacacional Huampani	\N	\N	HUAMPANI	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
99	117	\N	Sistema Nacional de Evaluación, Acreditación y Certificación de la Calidad Educativa	\N	\N	SINEACE	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
100	118	\N	Superintendencia Nacional de Educación Superior Universitaria	\N	\N	SUNEDU	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
101	342	\N	Instituto Peruano del Deporte	\N	\N	IPD	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
102	\N	\N	Proyecto Especial de Inversión Pública Escuelas Bicentenario	\N	\N	ESCUELAS BICENTENARIO	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
103	510	\N	Universidad Nacional Mayor de San Marcos	\N	\N	UNMSM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
104	511	\N	Universidad Nacional de San Antonio Abad del Cusco	\N	\N	UNSAAC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
105	512	\N	Universidad Nacional de Trujillo	\N	\N	UNT	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
106	513	\N	Universidad Nacional de San Agustin	\N	\N	UNSA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
107	514	\N	Universidad Nacional de Ingeniería	\N	\N	UNI	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
108	515	\N	Universidad Nacional San Luis Gonzaga de Ica	\N	\N	UNSLG	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
109	516	\N	Universidad Nacional San Cristóbal de Huamanga	\N	\N	UNSCH	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
110	517	\N	Universidad Nacional del Centro del Perú	\N	\N	UNCP	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
111	518	\N	Universidad Nacional Agraria la Molina	\N	\N	UNALM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
112	519	\N	Universidad Nacional de la Amazonia Peruana	\N	\N	UNAP	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
113	520	\N	Universidad Nacional del Altiplano	\N	\N	UNA PUNO	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
114	521	\N	Universidad Nacional de Piura	\N	\N	UNP	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
115	522	\N	Universidad Nacional de Cajamarca	\N	\N	UNC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
116	523	\N	Universidad Nacional Pedro Ruiz Gallo	\N	\N	UNPRG	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
117	524	\N	Universidad Nacional Federico Villarreal	\N	\N	UNFV	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
118	525	\N	Universidad Nacional Hermilio Valdizan	\N	\N	UNHV	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
119	526	\N	Universidad Nacional Agraria de la Selva	\N	\N	UNAS	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
120	527	\N	Universidad Nacional Daniel Alcides Carrion	\N	\N	UNDAC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
121	528	\N	Universidad Nacional de Educación Enrique Guzmán y Valle	\N	\N	UNE	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
122	529	\N	Universidad Nacional del Callao	\N	\N	UNAC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
123	530	\N	Universidad Nacional José Faustino Sánchez Carrion	\N	\N	UNJFSC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
124	531	\N	Universidad Nacional Jorge Basadre Grohmann	\N	\N	UNJBG	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
125	532	\N	Universidad Nacional Santiago Antúnez de Mayolo	\N	\N	UNSAM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
126	533	\N	Universidad Nacional de San Martin	\N	\N	UNSM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
127	534	\N	Universidad Nacional de Ucayali	\N	\N	UNU	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
128	535	\N	Universidad Nacional de Tumbes	\N	\N	UNT	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
129	536	\N	Universidad Nacional del Santa	\N	\N	UNS	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
130	537	\N	Universidad Nacional de Huancavelica	\N	\N	UNH	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
131	538	\N	Universidad Nacional Amazónica de Madre de Dios	\N	\N	UNAMAD	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
132	539	\N	Universidad Nacional Micaela Bastidas de Apurímac	\N	\N	UNAMBA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
133	541	\N	Universidad Nacional Toribio Rodríguez de Mendoza de Amazonas	\N	\N	UNTRM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
134	542	\N	Universidad Nacional Intercultural de la Amazonia	\N	\N	UNIA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
135	543	\N	Universidad Nacional Tecnológica de Lima Sur	\N	\N	UNTELS	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
136	544	\N	Universidad Nacional José María Arguedas	\N	\N	UNAJMA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
137	545	\N	Universidad Nacional de Moquegua	\N	\N	UNM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
138	546	\N	Universidad Nacional de Jaen	\N	\N	UNJ	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
139	547	\N	Universidad Nacional de Cañete	\N	\N	UNDC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
140	548	\N	Universidad Nacional de Frontera	\N	\N	UNF	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
141	549	\N	Universidad Nacional de Barranca	\N	\N	UNAB	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
142	550	\N	Universidad Nacional Autónoma de Chota	\N	\N	UNACH	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
143	551	\N	Universidad Nacional Intercultural de la Selva Central Juan Santos Atahualpa	\N	\N	UNISCJSA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
144	552	\N	Universidad Nacional de Juliaca	\N	\N	UNAJ	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
145	553	\N	Universidad Nacional Autónoma Altoandina de Tarma	\N	\N	UNAAT	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
146	554	\N	Universidad Nacional Autónoma de Huanta	\N	\N	UNAH	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
147	555	\N	Universidad Nacional Intercultural Fabiola Salazar Leguía de Bagua	\N	\N	UNIFSLB	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
148	556	\N	Universidad Nacional Intercultural de Quillabamba	\N	\N	UNIQ	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
149	557	\N	Universidad Nacional Autónoma de Alto Amazonas	\N	\N	UNAAA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
150	558	\N	Universidad Nacional Autónoma de Tayacaja Daniel Hernández Morillo	\N	\N	UNAT	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
151	559	\N	Universidad Nacional Ciro Alegria	\N	\N	UNCA	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
152	560	\N	Universidad Nacional de Arte Diego Quispe Tito del Cusco	\N	\N	UNADQTC	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
153	561	\N	Universidad Nacional de Música	\N	\N	UNM	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
154	562	\N	Universidad Nacional Daniel Alomia Robles	\N	\N	UNDAR	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
155	563	\N	Universidad Nacional Tecnológica de Frontera San Ignacio de Loyola	\N	\N	UNATEFSIL	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
156	564	\N	Universidad Nacional Tecnológica de San Juan de Lurigancho	\N	\N	UNTSJL	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
157	567	\N	Universidad Nacional del Vraem	\N	\N	\N	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
158	569	\N	Universidad Nacional Autónoma de Cutervo	\N	\N	\N	\N	1	t	18	1	2025-08-01 00:00:00-05	\N	\N
159	11	\N	Ministerio de Salud	\N	\N	MINSA	\N	1	t	19	1	2025-08-01 00:00:00-05	\N	\N
160	131	\N	Instituto Nacional de Salud	\N	\N	INS	\N	1	t	19	1	2025-08-01 00:00:00-05	\N	\N
161	134	\N	Superintendencia Nacional de Salud	\N	\N	SUSALUD	\N	1	t	19	1	2025-08-01 00:00:00-05	\N	\N
162	135	\N	Seguro Integral de Salud	\N	\N	SIS	\N	1	t	19	1	2025-08-01 00:00:00-05	\N	\N
163	136	\N	Instituto Nacional de Enfermedades Neoplasicas	\N	\N	INEN	\N	1	t	19	1	2025-08-01 00:00:00-05	\N	\N
164	\N	\N	Instituto Nacional de Rehabilitación	\N	\N	INR	\N	1	t	19	1	2025-08-01 00:00:00-05	\N	\N
165	12	\N	Ministerio de Trabajo y Promoción del Empleo	\N	\N	MTPE	\N	1	t	20	1	2025-08-01 00:00:00-05	\N	\N
166	121	\N	Superintendencia Nacional de Fiscalización Laboral	\N	\N	SUNAFIL	\N	1	t	20	1	2025-08-01 00:00:00-05	\N	\N
167	\N	\N	Programa de Empleo Temporal	\N	\N	LLAMKASUN PERÚ	\N	1	t	20	1	2025-08-01 00:00:00-05	\N	\N
168	13	\N	Ministerio de Desarrollo Agrario y Riego	\N	\N	MIDAGRI	\N	1	t	21	1	2025-08-01 00:00:00-05	\N	\N
169	18	\N	Agromercado	\N	\N	AGROMERCADO	\N	1	t	21	1	2025-08-01 00:00:00-05	\N	\N
170	160	\N	Servicio Nacional de Sanidad Agraria	\N	\N	SENASA	\N	1	t	21	1	2025-08-01 00:00:00-05	\N	\N
171	163	\N	Instituto Nacional de Innovación Agraria	\N	\N	INIA	\N	1	t	21	1	2025-08-01 00:00:00-05	\N	\N
172	164	\N	Autoridad Nacional del Agua	\N	\N	ANA	\N	1	t	21	1	2025-08-01 00:00:00-05	\N	\N
173	165	\N	Servicio Nacional Forestal y de Fauna Silvestre	\N	\N	SERFOR	\N	1	t	21	1	2025-08-01 00:00:00-05	\N	\N
174	16	\N	Ministerio de Energía y Minas	\N	\N	MINEM	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
175	220	\N	Instituto Peruano de Energía Nuclear	\N	\N	IPEN	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
176	221	\N	Instituto Geológico Minero y Metalurgico	\N	\N	INGEMMET	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
177	\N	\N	Empresa de Administración de Infraestructura Eléctrica S.A.	\N	\N	ADINELSA	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
178	\N	\N	Empresa de Servicio Público de Electricidad del Nor Oeste del Perú S.A.	\N	\N	ENOSA	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
179	\N	\N	Empresa de Servicio Público de Electricidad Electro Norte Medio S.A	\N	\N	HIDRANDINA	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
180	\N	\N	Grupo ISA	\N	\N	ISA REP	\N	1	t	22	1	2025-08-01 00:00:00-05	\N	\N
181	19	\N	Contraloría General de la República	\N	\N	CGR	\N	1	t	23	1	2025-08-01 00:00:00-05	\N	\N
182	20	\N	Defensoría del Pueblo	\N	\N	DEFENSORIA	\N	1	t	24	1	2025-08-01 00:00:00-05	\N	\N
183	21	\N	Junta Nacional de Justicia	\N	\N	JNJ	\N	1	t	25	1	2025-08-01 00:00:00-05	\N	\N
184	22	\N	Ministerio Público	\N	\N	MP	\N	1	t	26	1	2025-08-01 00:00:00-05	\N	\N
185	24	\N	Tribunal Constitucional	\N	\N	TC	\N	1	t	27	1	2025-08-01 00:00:00-05	\N	\N
186	26	\N	Ministerio de Defensa	\N	\N	MINDEF	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
187	6	\N	Instituto Nacional de Defensa Civil	\N	\N	INDECI	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
188	25	\N	Centro Nacional de Estimación, Prevención y Reducción del Riesgo de Desastres	\N	\N	CENEPRED	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
189	332	\N	Instituto Geográfico Nacional	\N	\N	IGN	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
190	335	\N	Agencia de Compras de las Fuerzas Armadas	\N	\N	ACFFAA	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
191	002-469	\N	Comando Conjunto de las Fuerzas Armadas	\N	\N	CCFFAA	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
192	003-470	\N	Ejército Peruano	\N	\N	EP	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
193	004-471	\N	Marina de Guerra del Perú	\N	\N	MGP	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
194	005-472	\N	Fuerza Aérea del Perú	\N	\N	FAP	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
195	006-1122	\N	Comision Nacional de Investigación y Desarrollo Aeroespacial	\N	\N	CONIDA	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
196	008-1123	\N	Escuela Nacional de Marina Mercante	\N	\N	ENAMM	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
197	009-1124	\N	Oficina Previsional de las Fuerzas Armadas	\N	\N	OPREFA	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
198	011-1761	\N	Centro de Altos Estudios Nacionales	\N	\N	CAEN-EPG	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
199	\N	\N	Caja de Pensiones Militar Policial	\N	\N	CPMP	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
200	\N	\N	Servicios Industriales de la Marina S.A.	\N	\N	SIMA	\N	1	t	28	1	2025-08-01 00:00:00-05	\N	\N
201	27	\N	Fuero Militar Policial	\N	\N	FMP	\N	1	t	29	1	2025-08-01 00:00:00-05	\N	\N
202	28	\N	Congreso de la Republica	\N	\N	CONGRESO	\N	1	t	30	1	2025-08-01 00:00:00-05	\N	\N
203	31	\N	Jurado Nacional de Elecciones	\N	\N	JNE	\N	1	t	31	1	2025-08-01 00:00:00-05	\N	\N
204	32	\N	Oficina Nacional de Procesos Electorales	\N	\N	ONPE	\N	1	t	32	1	2025-08-01 00:00:00-05	\N	\N
205	33	\N	Registro Nacional de Identificación y Estado Civil	\N	\N	RENIEC	\N	1	t	33	1	2025-08-01 00:00:00-05	\N	\N
206	35	\N	Ministerio de Comercio Exterior y Turismo	\N	\N	MINCETUR	\N	1	t	34	1	2025-08-01 00:00:00-05	\N	\N
207	8	\N	Comisión de Promoción del Perú para la Exportación y el Turismo	\N	\N	PROMPERU	\N	1	t	34	1	2025-08-01 00:00:00-05	\N	\N
208	180	\N	Centro de Formación en Turismo	\N	\N	CENFOTUR	\N	1	t	34	1	2025-08-01 00:00:00-05	\N	\N
209	\N	\N	Unidad Ejecutora de Inversión en Comercio Exterior y Turismo	\N	\N	COPESCO NACIONAL	\N	1	t	24	1	2025-08-01 00:00:00-05	\N	\N
210	36	\N	Ministerio de Transportes y Comunicaciones	\N	\N	MTC	\N	1	t	35	1	2025-08-01 00:00:00-05	\N	\N
211	202	\N	Superintendencia de Transporte Terrestre de Personas, Carga y Mercancias	\N	\N	SUTRAN	\N	1	t	35	1	2025-08-01 00:00:00-05	\N	\N
212	203	\N	Autoridad de Transporte Urbano para Lima y Callao	\N	\N	ATU	\N	1	t	35	1	2025-08-01 00:00:00-05	\N	\N
213	214	\N	Autoridad Portuaria Nacional	\N	\N	APN	\N	1	t	35	1	2025-08-01 00:00:00-05	\N	\N
214	\N	\N	Programa Nacional de Telecomunicaciones	\N	\N	PRONATEL	\N	1	t	35	1	2025-08-01 00:00:00-05	\N	\N
215	37	\N	Ministerio de Vivienda, Construcción y Saneamiento	\N	\N	MVCS	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
216	56	\N	Superintendencia Nacional de Bienes Estatales	\N	\N	SBN	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
217	205	\N	Servicio Nacional de Capacitación para la Industria de la Construcción	\N	\N	SENCICO	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
218	207	\N	Organismo Técnico de la Administración de los Servicios de Saneamiento	\N	\N	OTASS	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
219	211	\N	Organismo de Formalización de la Propiedad Informal	\N	\N	COFOPRI	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
220	\N	\N	Fondo Mivivienda S.A.	\N	\N	FMV	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
221	\N	\N	Servicio de Agua Potable y Alcantarillado de Lima	\N	\N	SEDAPAL	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
222	\N	\N	Programa Nacional de Saneamiento Rural	\N	\N	PNSR	\N	1	t	36	1	2025-08-01 00:00:00-05	\N	\N
223	38	\N	Ministerio de la Producción	\N	\N	PRODUCE	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
224	59	\N	Fondo Nacional de Desarrollo Pesquero	\N	\N	FONDEPES	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
225	240	\N	Instituto del Mar del Peru	\N	\N	IMARPE	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
226	241	\N	Instituto Tecnológico de la Producción	\N	\N	ITP	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
227	243	\N	Autoridad Nacional de Sanidad e Inocuidad en Pesca y Acuicultura	\N	\N	SANIPES	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
228	244	\N	Instituto Nacional de Calidad	\N	\N	INACAL	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
229	\N	\N	Programa Nacional A Comer Pescado	\N	\N	PNACP	\N	1	t	37	1	2025-08-01 00:00:00-05	\N	\N
230	39	\N	Ministerio de la Mujer y Poblaciones Vulnerables	\N	\N	MIMP	\N	1	t	38	1	2025-08-01 00:00:00-05	\N	\N
231	345	\N	Consejo Nacional para la Integración de la Persona con Discapacidad	\N	\N	CONADIS	\N	1	t	38	1	2025-08-01 00:00:00-05	\N	\N
232	\N	\N	Programa Integral Nacional para el Bienestar Familiar	\N	\N	INABIF	\N	1	t	38	1	2025-08-01 00:00:00-05	\N	\N
233	40	\N	Ministerio de Desarrollo e Inclusión Social	\N	\N	MIDIS	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
234	41	\N	Organismo de Focalización e Información Social	\N	\N	OFIS	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
235	003-1426	\N	Programa Nacional Cuna Mas	\N	\N	PNCM	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
236	004-1427	\N	Fondo de Cooperación para el Desarrollo Social	\N	\N	FONCODES	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
237	005-1428	\N	Programa Nacional de Apoyo Directo A los Mas Pobres	\N	\N	JUNTOS	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
238	006-1441	\N	Programa Nacional de Asistencia Solidaria	\N	\N	PENSION 65	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
239	007-1456	\N	Programa Nacional de Alimentación Escolar Comunitaria	\N	\N	WASI MIKUNA	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
240	008-1674	\N	Programa Nacional Plataformas de Acción para la Inclusión Social	\N	\N	PAIS	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
241	010-1723	\N	Programa Nacional de Entrega de la Pensión No Contributiva A Personas con Discapacidad Severa en Situación de Pobreza	\N	\N	CONTIGO	\N	1	t	39	1	2025-08-01 00:00:00-05	\N	\N
242	440	\N	Gobierno Regional del Departamento de Amazonas	\N	\N	GORE AMAZONAS	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
243	441	\N	Gobierno Regional del Departamento de Ancash	\N	\N	GORE ANCASH	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
244	442	\N	Gobierno Regional del Departamento de Apurímac	\N	\N	GORE APURIMAC	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
245	443	\N	Gobierno Regional del Departamento de Arequipa	\N	\N	GORE AREQUIPA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
246	444	\N	Gobierno Regional del Departamento de Ayacucho	\N	\N	GORE AYACUCHO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
247	445	\N	Gobierno Regional del Departamento de Cajamarca	\N	\N	GORE CAJAMARCA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
248	446	\N	Gobierno Regional del Departamento de Cusco	\N	\N	GORE CUSCO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
249	447	\N	Gobierno Regional del Departamento de Huancavelica	\N	\N	GORE HUANCAVELICA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
250	448	\N	Gobierno Regional del Departamento de Huánuco	\N	\N	GORE HUANUCO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
251	449	\N	Gobierno Regional del Departamento de Ica	\N	\N	GORE ICA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
252	450	\N	Gobierno Regional del Departamento de Junin	\N	\N	GORE JUNIN	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
253	451	\N	Gobierno Regional del Departamento de la Libertad	\N	\N	GORE LIBERTAD	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
254	452	\N	Gobierno Regional del Departamento de Lambayeque	\N	\N	GORE LAMBAYEQUE	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
255	453	\N	Gobierno Regional del Departamento de Loreto	\N	\N	GORE LORETO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
256	454	\N	Gobierno Regional del Departamento de Madre de Dios	\N	\N	GORE DIOS	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
257	455	\N	Gobierno Regional del Departamento de Moquegua	\N	\N	GORE MOQUEGUA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
258	456	\N	Gobierno Regional del Departamento de Pasco	\N	\N	GORE PASCO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
259	457	\N	Gobierno Regional del Departamento de Piura	\N	\N	GORE PIURA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
260	458	\N	Gobierno Regional del Departamento de Puno	\N	\N	GORE PUNO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
261	459	\N	Gobierno Regional del Departamento de San Martin	\N	\N	GORE MARTIN	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
262	460	\N	Gobierno Regional del Departamento de Tacna	\N	\N	GORE TACNA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
263	461	\N	Gobierno Regional del Departamento de Tumbes	\N	\N	GORE TUMBES	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
264	462	\N	Gobierno Regional del Departamento de Ucayali	\N	\N	GORE UCAYALI	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
265	463	\N	Gobierno Regional del Departamento de Lima	\N	\N	GORE LIMA	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
266	464	\N	Gobierno Regional de la Provincia Constitucional del Callao	\N	\N	GORE CALLAO	\N	1	t	40	1	2025-08-01 00:00:00-05	\N	\N
267	465	\N	Municipalidad Metropolitana de Lima	\N	\N	MML	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
268	\N	\N	Instituto Catastral de Lima	\N	\N	ICL	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
269	\N	\N	Centro de Información y Educación para la Prevención del Abuso de Drogas	\N	\N	CEDRO	\N	1	t	42	1	2025-08-01 00:00:00-05	\N	\N
270	\N	\N	Sociedad Nacional de Minería, Petróleo y Energía	\N	\N	SNMPE	\N	1	t	42	1	2025-08-01 00:00:00-05	\N	\N
271	\N	\N	Fondo de Población de las Naciones Unidas	\N	\N	UNFPA	\N	1	t	43	1	2025-08-01 00:00:00-05	\N	\N
272	\N	\N	Programa de las Naciones Unidas para el Desarrollo	\N	\N	PNUD	\N	1	t	43	1	2025-08-01 00:00:00-05	\N	\N
273	\N	\N	Programa Mundial de Alimentos	\N	\N	PMA	\N	1	t	43	1	2025-08-01 00:00:00-05	\N	\N
274	\N	\N	Telefónica del Perú	\N	\N	TELEFONICA	\N	1	t	44	1	2025-08-01 00:00:00-05	\N	\N
275	300001	10101	Municipalidad Provincial de Chachapoyas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
276	300002	10102	Municipalidad Distrital de Asuncion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
277	300003	10103	Municipalidad Distrital de Balsas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
278	300004	10104	Municipalidad Distrital de Cheto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
279	300005	10105	Municipalidad Distrital de Chiliquin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
280	300006	10106	Municipalidad Distrital de Chuquibamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
281	300007	10107	Municipalidad Distrital de Granada	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
282	300008	10108	Municipalidad Distrital de Huancas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
283	300009	10109	Municipalidad Distrital de la Jalca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
284	300010	10110	Municipalidad Distrital de Leimebamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
285	300011	10111	Municipalidad Distrital de Levanto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
286	300012	10112	Municipalidad Distrital de Magdalena	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
287	300013	10113	Municipalidad Distrital de Mariscal Castilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
288	300014	10114	Municipalidad Distrital de Molinopampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
289	300015	10115	Municipalidad Distrital de Montevideo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
290	300016	10116	Municipalidad Distrital de Olleros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
291	300017	10117	Municipalidad Distrital de Quinjalca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
292	300018	10118	Municipalidad Distrital de San Francisco de Daguas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
293	300019	10119	Municipalidad Distrital de San Isidro de Maino	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
294	300020	10120	Municipalidad Distrital de Soloco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
295	300021	10121	Municipalidad Distrital de Sonche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
296	300022	10201	Municipalidad Provincial de Bagua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
297	300023	10202	Municipalidad Distrital de Aramango	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
298	300024	10203	Municipalidad Distrital de Copallin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
299	300025	10204	Municipalidad Distrital de El Parco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
300	300026	10205	Municipalidad Distrital de Imaza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
301	300027	10206	Municipalidad Distrital de la Peca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
302	300028	10301	Municipalidad Provincial de Bogará - Jumbilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
303	300029	10302	Municipalidad Distrital de Chisquilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
304	300030	10303	Municipalidad Distrital de Churuja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
305	300031	10304	Municipalidad Distrital de Corosha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
306	300032	10305	Municipalidad Distrital de Cuispes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
307	300033	10306	Municipalidad Distrital de Florida	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
308	300034	10307	Municipalidad Distrital de Jazan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
309	300035	10308	Municipalidad Distrital de Recta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
310	300036	10309	Municipalidad Distrital de San Carlos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
311	300037	10310	Municipalidad Distrital de Shipasbamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
312	300038	10311	Municipalidad Distrital de Valera	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
313	300039	10312	Municipalidad Distrital de Yambrasbamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
314	300040	10401	Municipalidad Provincial de Condorcanqui - Nieva	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
315	300041	10402	Municipalidad Distrital de El Cenepa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
316	300042	10403	Municipalidad Distrital de Rio Santiago	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
317	300043	10501	Municipalidad Provincial de Luya - Lamud	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
318	300044	10502	Municipalidad Distrital de Camporredondo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
319	300045	10503	Municipalidad Distrital de Cocabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
320	300046	10504	Municipalidad Distrital de Colcamar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
321	300047	10505	Municipalidad Distrital de Conila	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
322	300048	10506	Municipalidad Distrital de Inguilpata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
323	300049	10507	Municipalidad Distrital de Longuita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
324	300050	10508	Municipalidad Distrital de Lonya Chico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
325	300051	10509	Municipalidad Distrital de Luya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
326	300052	10510	Municipalidad Distrital de Luya Viejo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
327	300053	10511	Municipalidad Distrital de Maria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
328	300054	10512	Municipalidad Distrital de Ocalli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
329	300055	10513	Municipalidad Distrital de Ocumal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
330	300056	10514	Municipalidad Distrital de Pisuquia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
331	300057	10515	Municipalidad Distrital de Providencia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
332	300058	10516	Municipalidad Distrital de San Cristobal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
333	300059	10517	Municipalidad Distrital de San Francisco del Yeso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
334	300060	10518	Municipalidad Distrital de San Jerónimo de Paclas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
335	300061	10519	Municipalidad Distrital de San Juan de Lopecancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
336	300062	10520	Municipalidad Distrital de Santa Catalina	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
337	300063	10521	Municipalidad Distrital de Santo Tomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
338	300064	10522	Municipalidad Distrital de Tingo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
339	300065	10523	Municipalidad Distrital de Trita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
340	300066	10601	Municipalidad Provincial de Rodríguez de Mendoza - San Nicolas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
341	300067	10602	Municipalidad Distrital de Chirimoto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
342	300068	10603	Municipalidad Distrital de Cochamal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
343	300069	10604	Municipalidad Distrital de Huambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
344	300070	10605	Municipalidad Distrital de Limabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
345	300071	10606	Municipalidad Distrital de Longar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
346	300072	10607	Municipalidad Distrital de Mariscal Benavides	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
347	300073	10608	Municipalidad Distrital de Milpuc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
348	300074	10609	Municipalidad Distrital de Omia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
349	300075	10610	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
350	300076	10611	Municipalidad Distrital de Totora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
351	300077	10612	Municipalidad Distrital de Vista Alegre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
352	300078	10701	Municipalidad Provincial de Utcubamba - Bagua Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
353	300079	10702	Municipalidad Distrital de Cajaruro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
354	300080	10703	Municipalidad Distrital de Cumba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
355	300081	10704	Municipalidad Distrital de El Milagro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
356	300082	10705	Municipalidad Distrital de Jamalca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
357	300083	10706	Municipalidad Distrital de Lonya Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
358	300084	10707	Municipalidad Distrital de Yamon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
359	300085	20101	Municipalidad Provincial de Huaraz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
360	300086	20102	Municipalidad Distrital de Cochabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
361	300087	20103	Municipalidad Distrital de Colcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
362	300088	20104	Municipalidad Distrital de Huanchay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
363	300089	20105	Municipalidad Distrital de Independencia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
364	300090	20106	Municipalidad Distrital de Jangas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
365	300091	20107	Municipalidad Distrital de la Libertad	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
366	300092	20108	Municipalidad Distrital de Olleros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
367	300093	20109	Municipalidad Distrital de Pampas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
368	300094	20110	Municipalidad Distrital de Pariacoto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
369	300095	20111	Municipalidad Distrital de Pira	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
370	300096	20112	Municipalidad Distrital de Tarica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
371	300097	20201	Municipalidad Provincial de Aija	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
372	300098	20202	Municipalidad Distrital de Coris	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
373	300099	20203	Municipalidad Distrital de Huacllan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
374	300100	20204	Municipalidad Distrital de la Merced	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
375	300101	20205	Municipalidad Distrital de Succha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
376	300102	20301	Municipalidad Provincial de Antonio Raymondi - Llamellin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
377	300103	20302	Municipalidad Distrital de Aczo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
378	300104	20303	Municipalidad Distrital de Chaccho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
379	300105	20304	Municipalidad Distrital de Chingas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
380	300106	20305	Municipalidad Distrital de Mirgas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
381	300107	20306	Municipalidad Distrital de San Juan de Rontoy	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
382	300108	20401	Municipalidad Provincial de Asunción - Chacas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
383	300109	20402	Municipalidad Distrital de Acochaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
384	300110	20501	Municipalidad Provincial de Bolognesi - Chiquian	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
385	300111	20502	Municipalidad Distrital de Abelardo Pardo Lezameta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
386	300112	20503	Municipalidad Distrital de Antonio Raymondi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
387	300113	20504	Municipalidad Distrital de Aquia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
388	300114	20505	Municipalidad Distrital de Cajacay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
389	300115	20506	Municipalidad Distrital de Canis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
390	300116	20507	Municipalidad Distrital de Colquioc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
391	300117	20508	Municipalidad Distrital de Huallanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
392	300118	20509	Municipalidad Distrital de Huasta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
393	300119	20510	Municipalidad Distrital de Huayllacayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
394	300120	20511	Municipalidad Distrital de la Primavera	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
395	300121	20512	Municipalidad Distrital de Mangas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
396	300122	20513	Municipalidad Distrital de Pacllon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
397	300123	20514	Municipalidad Distrital de San Miguel de Corpanqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
398	300124	20515	Municipalidad Distrital de Ticllos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
399	300125	20601	Municipalidad Provincial de Carhuaz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
400	300126	20602	Municipalidad Distrital de Acopampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
401	300127	20603	Municipalidad Distrital de Amashca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
402	300128	20604	Municipalidad Distrital de Anta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
403	300129	20605	Municipalidad Distrital de Ataquero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
404	300130	20606	Municipalidad Distrital de Marcara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
405	300131	20607	Municipalidad Distrital de Pariahuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
406	300132	20608	Municipalidad Distrital de San Miguel de Aco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
407	300133	20609	Municipalidad Distrital de Shilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
408	300134	20610	Municipalidad Distrital de Tinco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
409	300135	20611	Municipalidad Distrital de Yungar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
410	300136	20701	Municipalidad Provincial de Carlos Fermín Fitzcarrald	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
411	300137	20702	Municipalidad Distrital de San Nicolas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
412	300138	20703	Municipalidad Distrital de Yauya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
413	300139	20801	Municipalidad Provincial de Casma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
414	300140	20802	Municipalidad Distrital de Buena Vista Alta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
415	300141	20803	Municipalidad Distrital de Comandante Noel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
416	300142	20804	Municipalidad Distrital de Yautan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
417	300143	20901	Municipalidad Provincial de Corongo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
418	300144	20902	Municipalidad Distrital de Aco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
419	300145	20903	Municipalidad Distrital de Bambas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
420	300146	20904	Municipalidad Distrital de Cusca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
421	300147	20905	Municipalidad Distrital de la Pampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
422	300148	20906	Municipalidad Distrital de Yanac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
423	300149	20907	Municipalidad Distrital de Yupan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
424	300150	21001	Municipalidad Provincial de Huari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
425	300151	21002	Municipalidad Distrital de Anra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
426	300152	21003	Municipalidad Distrital de Cajay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
427	300153	21004	Municipalidad Distrital de Chavín de Huantar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
428	300154	21005	Municipalidad Distrital de Huacachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
429	300155	21006	Municipalidad Distrital de Huacchis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
430	300156	21007	Municipalidad Distrital de Huachis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
431	300157	21008	Municipalidad Distrital de Huantar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
432	300158	21009	Municipalidad Distrital de Masin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
433	300159	21010	Municipalidad Distrital de Paucas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
434	300160	21011	Municipalidad Distrital de Ponto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
435	300161	21012	Municipalidad Distrital de Rahuapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
436	300162	21013	Municipalidad Distrital de Rapayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
437	300163	21014	Municipalidad Distrital de San Marcos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
438	300164	21015	Municipalidad Distrital de San Pedro de Chana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
439	300165	21016	Municipalidad Distrital de Uco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
440	300166	21101	Municipalidad Provincial de Huarmey	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
441	300167	21102	Municipalidad Distrital de Cochapeti	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
442	300168	21103	Municipalidad Distrital de Culebras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
443	300169	21104	Municipalidad Distrital de Huayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
444	300170	21105	Municipalidad Distrital de Malvas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
445	300171	21201	Municipalidad Provincial de Huaylas - Caraz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
446	300172	21202	Municipalidad Distrital de Huallanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
447	300173	21203	Municipalidad Distrital de Huata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
448	300174	21204	Municipalidad Distrital de Huaylas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
449	300175	21205	Municipalidad Distrital de Mato	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
450	300176	21206	Municipalidad Distrital de Pamparomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
451	300177	21207	Municipalidad Distrital de Pueblo Libre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
452	300178	21208	Municipalidad Distrital de Santa Cruz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
453	300179	21209	Municipalidad Distrital de Santo Toribio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
454	300180	21210	Municipalidad Distrital de Yuracmarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
455	300181	21301	Municipalidad Provincial de Mariscal Luzuriaga - Piscobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
456	300182	21302	Municipalidad Distrital de Casca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
457	300183	21303	Municipalidad Distrital de Eleazar Guzman Barron	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
458	300184	21304	Municipalidad Distrital de Fidel Olivas Escudero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
459	300185	21305	Municipalidad Distrital de Llama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
460	300186	21306	Municipalidad Distrital de Llumpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
461	300187	21307	Municipalidad Distrital de Lucma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
462	300188	21308	Municipalidad Distrital de Musga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
463	300189	21401	Municipalidad Provincial de Ocros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
464	300190	21402	Municipalidad Distrital de Acas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
465	300191	21403	Municipalidad Distrital de Cajamarquilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
466	300192	21404	Municipalidad Distrital de Carhuapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
467	300193	21405	Municipalidad Distrital de Cochas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
468	300194	21406	Municipalidad Distrital de Congas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
469	300195	21407	Municipalidad Distrital de Llipa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
470	300196	21408	Municipalidad Distrital de San Cristobal de Rajan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
471	300197	21409	Municipalidad Distrital de San Pedro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
472	300198	21410	Municipalidad Distrital de Santiago de Chilcas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
473	300199	21501	Municipalidad Provincial de Pallasca - Cabana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
474	300200	21502	Municipalidad Distrital de Bolognesi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
475	300201	21503	Municipalidad Distrital de Conchucos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
476	300202	21504	Municipalidad Distrital de Huacaschuque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
477	300203	21505	Municipalidad Distrital de Huandoval	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
478	300204	21506	Municipalidad Distrital de Lacabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
479	300205	21507	Municipalidad Distrital de Llapo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
480	300206	21508	Municipalidad Distrital de Pallasca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
481	300207	21509	Municipalidad Distrital de Pampas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
482	300208	21510	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
483	300209	21511	Municipalidad Distrital de Tauca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
484	300210	21601	Municipalidad Provincial de Pomabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
485	300211	21602	Municipalidad Distrital de Huayllan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
486	300212	21603	Municipalidad Distrital de Parobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
487	300213	21604	Municipalidad Distrital de Quinuabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
488	300214	21701	Municipalidad Provincial de Recuay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
489	300215	21702	Municipalidad Distrital de Catac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
490	300216	21703	Municipalidad Distrital de Cotaparaco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
491	300217	21704	Municipalidad Distrital de Huayllapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
492	300218	21705	Municipalidad Distrital de Llacllin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
493	300219	21706	Municipalidad Distrital de Marca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
494	300220	21707	Municipalidad Distrital de Pampas Chico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
495	300221	21708	Municipalidad Distrital de Pararin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
496	300222	21709	Municipalidad Distrital de Tapacocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
497	300223	21710	Municipalidad Distrital de Ticapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
498	300224	21801	Municipalidad Provincial del Santa - Chimbote	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
499	300225	21802	Municipalidad Distrital de Caceres del Perú	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
500	300226	21803	Municipalidad Distrital de Coishco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
501	300227	21804	Municipalidad Distrital de Macate	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
502	300228	21805	Municipalidad Distrital de Moro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
503	300229	21806	Municipalidad Distrital de Nepeña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
504	300230	21807	Municipalidad Distrital de Samanco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
505	300231	21808	Municipalidad Distrital de Santa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
506	300232	21809	Municipalidad Distrital de Nuevo Chimbote	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
507	300233	21901	Municipalidad Provincial de Sihuas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
508	300234	21902	Municipalidad Distrital de Acobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
509	300235	21903	Municipalidad Distrital de Alfonso Ugarte	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
510	300236	21904	Municipalidad Distrital de Cashapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
511	300237	21905	Municipalidad Distrital de Chingalpo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
512	300238	21906	Municipalidad Distrital de Huayllabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
513	300239	21907	Municipalidad Distrital de Quiches	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
514	300240	21908	Municipalidad Distrital de Ragash	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
515	300241	21909	Municipalidad Distrital de San Juan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
516	300242	21910	Municipalidad Distrital de Sicsibamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
517	300243	22001	Municipalidad Provincial de Yungay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
518	300244	22002	Municipalidad Distrital de Cascapara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
519	300245	22003	Municipalidad Distrital de Mancos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
520	300246	22004	Municipalidad Distrital de Matacoto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
521	300247	22005	Municipalidad Distrital de Quillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
522	300248	22006	Municipalidad Distrital de Ranrahirca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
523	300249	22007	Municipalidad Distrital de Shupluy	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
524	300250	22008	Municipalidad Distrital de Yanama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
525	300251	30101	Municipalidad Provincial de Abancay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
526	300252	30102	Municipalidad Distrital de Chacoche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
527	300253	30103	Municipalidad Distrital de Circa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
528	300254	30104	Municipalidad Distrital de Curahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
529	300255	30105	Municipalidad Distrital de Huanipaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
530	300256	30106	Municipalidad Distrital de Lambrama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
531	300257	30107	Municipalidad Distrital de Pichirhua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
532	300258	30108	Municipalidad Distrital de San Pedro de Cachora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
533	300259	30109	Municipalidad Distrital de Tamburco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
534	300260	30201	Municipalidad Provincial de Andahuaylas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
535	300261	30202	Municipalidad Distrital de Andarapa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
536	300262	30203	Municipalidad Distrital de Chiara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
537	300263	30204	Municipalidad Distrital de Huancarama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
538	300264	30205	Municipalidad Distrital de Huancaray	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
539	300265	30206	Municipalidad Distrital de Huayana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
540	300266	30207	Municipalidad Distrital de Kishuara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
541	300267	30208	Municipalidad Distrital de Pacobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
542	300268	30209	Municipalidad Distrital de Pacucha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
543	300269	30210	Municipalidad Distrital de Pampachiri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
544	300270	30211	Municipalidad Distrital de Pomacocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
545	300271	30212	Municipalidad Distrital de San Antonio de Cachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
546	300272	30213	Municipalidad Distrital de San Jeronimo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
547	300273	30214	Municipalidad Distrital de San Miguel Chaccrampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
548	300274	30215	Municipalidad Distrital de Santa Maria de Chicmo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
549	300275	30216	Municipalidad Distrital de Talavera	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
550	300276	30217	Municipalidad Distrital de Tumay Huaraca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
551	300277	30218	Municipalidad Distrital de Turpo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
552	300278	30219	Municipalidad Distrital de Kaquiabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
553	301863	30220	Municipalidad Distrital de José María Arguedas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
554	300279	30301	Municipalidad Provincial de Antabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
555	300280	30302	Municipalidad Distrital de el Oro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
556	300281	30303	Municipalidad Distrital de Huaquirca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
557	300282	30304	Municipalidad Distrital de Juan Espinoza Medrano	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
558	300283	30305	Municipalidad Distrital de Oropesa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
559	300284	30306	Municipalidad Distrital de Pachaconas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
560	300285	30307	Municipalidad Distrital de Sabaino	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
561	300286	30401	Municipalidad Provincial de Aymaraes - Chalhuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
562	300287	30402	Municipalidad Distrital de Capaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
563	300288	30403	Municipalidad Distrital de Caraybamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
564	300289	30404	Municipalidad Distrital de Chapimarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
565	300290	30405	Municipalidad Distrital de Colcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
566	300291	30406	Municipalidad Distrital de Cotaruse	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
567	300292	30407	Municipalidad Distrital de Ihuayllo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
568	300293	30408	Municipalidad Distrital de Justo Apu Sahuaraura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
569	300294	30409	Municipalidad Distrital de Lucre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
570	300295	30410	Municipalidad Distrital de Pocohuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
571	300296	30411	Municipalidad Distrital de San Juan de Chacña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
572	300297	30412	Municipalidad Distrital de Sañayca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
573	300298	30413	Municipalidad Distrital de Soraya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
574	300299	30414	Municipalidad Distrital de Tapairihua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
575	300300	30415	Municipalidad Distrital de Tintay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
576	300301	30416	Municipalidad Distrital de Toraya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
577	300302	30417	Municipalidad Distrital de Yanaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
578	300303	30501	Municipalidad Provincial de Cotabambas - Tambobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
579	300304	30502	Municipalidad Distrital de Cotabambas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
580	300305	30503	Municipalidad Distrital de Coyllurqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
581	300306	30504	Municipalidad Distrital de Haquira	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
582	300307	30505	Municipalidad Distrital de Mara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
583	300308	30506	Municipalidad Distrital de Challhuahuacho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
584	300309	30601	Municipalidad Provincial de Chincheros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
585	300310	30602	Municipalidad Distrital de Anco Huallo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
586	300311	30603	Municipalidad Distrital de Cocharcas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
587	300312	30604	Municipalidad Distrital de Huaccana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
588	300313	30605	Municipalidad Distrital de Ocobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
589	300314	30606	Municipalidad Distrital de Ongoy	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
590	300315	30607	Municipalidad Distrital de Uranmarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
591	300316	30608	Municipalidad Distrital de Ranracancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
592	301877	30609	Municipalidad Distrital de Rocchacc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
593	301878	30610	Municipalidad Distrital de El Porvenir	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
594	301880	30611	Municipalidad Distrital de los Chankas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
595	301900	30612	Municipalidad Distrital de Ahuayro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
596	300317	30701	Municipalidad Provincial de Grau - Chuquibambilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
597	300318	30702	Municipalidad Distrital de Curpahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
598	300319	30703	Municipalidad Distrital de Gamarra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
599	300320	30704	Municipalidad Distrital de Huayllati	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
600	300321	30705	Municipalidad Distrital de Mamara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
601	300322	30706	Municipalidad Distrital de Micaela Bastidas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
602	300323	30707	Municipalidad Distrital de Pataypampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
603	300324	30708	Municipalidad Distrital de Progreso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
604	300325	30709	Municipalidad Distrital de San Antonio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
605	300326	30710	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
606	300327	30711	Municipalidad Distrital de Turpay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
607	300328	30712	Municipalidad Distrital de Vilcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
608	300329	30713	Municipalidad Distrital de Virundo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
609	300330	30714	Municipalidad Distrital de Curasco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
610	300331	40101	Municipalidad Provincial de Arequipa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
611	300332	40102	Municipalidad Distrital de Alto Selva Alegre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
612	300333	40103	Municipalidad Distrital de Cayma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
613	300334	40104	Municipalidad Distrital de Cerro Colorado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
614	300335	40105	Municipalidad Distrital de Characato	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
615	300336	40106	Municipalidad Distrital de Chiguata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
616	300337	40107	Municipalidad Distrital de Jacobo Hunter	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
617	300338	40108	Municipalidad Distrital de la Joya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
618	300339	40109	Municipalidad Distrital de Mariano Melgar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
619	300340	40110	Municipalidad Distrital de Miraflores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
620	300341	40111	Municipalidad Distrital de Mollebaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
621	300342	40112	Municipalidad Distrital de Paucarpata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
622	300343	40113	Municipalidad Distrital de Pocsi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
623	300344	40114	Municipalidad Distrital de Polobaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
624	300345	40115	Municipalidad Distrital de Queque¥a	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
625	300346	40116	Municipalidad Distrital de Sabandia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
626	300347	40117	Municipalidad Distrital de Sachaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
627	300348	40118	Municipalidad Distrital de San Juan de Siguas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
628	300349	40119	Municipalidad Distrital de San Juan de Tarucani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
629	300350	40120	Municipalidad Distrital de Santa Isabel de Siguas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
630	300351	40121	Municipalidad Distrital de Santa Rita de Siguas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
631	300352	40122	Municipalidad Distrital de Socabaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
632	300353	40123	Municipalidad Distrital de Tiabaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
633	300354	40124	Municipalidad Distrital de Uchumayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
634	300355	40125	Municipalidad Distrital de Vitor	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
635	300356	40126	Municipalidad Distrital de Yanahuara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
636	300357	40127	Municipalidad Distrital de Yarabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
637	300358	40128	Municipalidad Distrital de Yura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
638	300359	40129	Municipalidad Distrital de José Luis Bustamante y Rivero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
639	300360	40201	Municipalidad Provincial de Camana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
640	300361	40202	Municipalidad Distrital de José María Quimper	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
641	300362	40203	Municipalidad Distrital de Mariano Nicolas Valcarcel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
642	300363	40204	Municipalidad Distrital de Mariscal Caceres	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
643	300364	40205	Municipalidad Distrital de Nicolas de Pierola	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
644	300365	40206	Municipalidad Distrital de Ocoña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
645	300366	40207	Municipalidad Distrital de Quilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
646	300367	40208	Municipalidad Distrital de Samuel Pastor	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
647	300368	40301	Municipalidad Provincial de Caraveli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
648	300369	40302	Municipalidad Distrital de Acari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
649	300370	40303	Municipalidad Distrital de Atico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
650	300371	40304	Municipalidad Distrital de Atiquipa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
651	300372	40305	Municipalidad Distrital de Bella Union	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
652	300373	40306	Municipalidad Distrital de Cahuacho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
653	300374	40307	Municipalidad Distrital de Chala	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
654	300375	40308	Municipalidad Distrital de Chaparra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
655	300376	40309	Municipalidad Distrital de Huanuhuanu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
656	300377	40310	Municipalidad Distrital de Jaqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
657	300378	40311	Municipalidad Distrital de Lomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
658	300379	40312	Municipalidad Distrital de Quicacha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
659	300380	40313	Municipalidad Distrital de Yauca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
660	300381	40401	Municipalidad Provincial de Castilla - Aplao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
661	300382	40402	Municipalidad Distrital de Andagua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
662	300383	40403	Municipalidad Distrital de Ayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
663	300384	40404	Municipalidad Distrital de Chachas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
664	300385	40405	Municipalidad Distrital de Chilcaymarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
665	300386	40406	Municipalidad Distrital de Choco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
666	300387	40407	Municipalidad Distrital de Huancarqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
667	300388	40408	Municipalidad Distrital de Machaguay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
668	300389	40409	Municipalidad Distrital de Orcopampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
669	300390	40410	Municipalidad Distrital de Pampacolca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
670	300391	40411	Municipalidad Distrital de Tipan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
671	300392	40412	Municipalidad Distrital de Uñon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
672	300393	40413	Municipalidad Distrital de Uraca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
673	300394	40414	Municipalidad Distrital de Viraco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
674	300395	40501	Municipalidad Provincial de Caylloma - Chivay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
675	300396	40502	Municipalidad Distrital de Achoma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
676	300397	40503	Municipalidad Distrital de Cabanaconde	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
677	300398	40504	Municipalidad Distrital de Callalli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
678	300399	40505	Municipalidad Distrital de Caylloma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
679	300400	40506	Municipalidad Distrital de Coporaque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
680	300401	40507	Municipalidad Distrital de Huambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
681	300402	40508	Municipalidad Distrital de Huanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
682	300403	40509	Municipalidad Distrital de Ichupampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
683	300404	40510	Municipalidad Distrital de Lari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
684	300405	40511	Municipalidad Distrital de Lluta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
685	300406	40512	Municipalidad Distrital de Maca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
686	300407	40513	Municipalidad Distrital de Madrigal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
687	300408	40514	Municipalidad Distrital de San Antonio de Chuca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
688	300409	40515	Municipalidad Distrital de Sibayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
689	300410	40516	Municipalidad Distrital de Tapay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
690	300411	40517	Municipalidad Distrital de Tisco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
691	300412	40518	Municipalidad Distrital de Tuti	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
692	300413	40519	Municipalidad Distrital de Yanque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
693	300414	40520	Municipalidad Distrital de Majes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
694	300415	40601	Municipalidad Provincial de Condesuyos - Chuquibamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
695	300416	40602	Municipalidad Distrital de Andaray	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
696	300417	40603	Municipalidad Distrital de Cayarani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
697	300418	40604	Municipalidad Distrital de Chichas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
698	300419	40605	Municipalidad Distrital de Iray	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
699	300420	40606	Municipalidad Distrital de Rio Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
700	300421	40607	Municipalidad Distrital de Salamanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
701	300422	40608	Municipalidad Distrital de Yanaquihua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
702	300423	40701	Municipalidad Provincial de Islay - Mollendo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
703	300424	40702	Municipalidad Distrital de Cocachacra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
704	300425	40703	Municipalidad Distrital de Dean Valdivia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
705	300426	40704	Municipalidad Distrital de Islay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
706	300427	40705	Municipalidad Distrital de Mejia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
707	300428	40706	Municipalidad Distrital de Punta de Bombon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
708	300429	40801	Municipalidad Provincial de la Union - Cotahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
709	300430	40802	Municipalidad Distrital de Alca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
710	300431	40803	Municipalidad Distrital de Charcana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
711	300432	40804	Municipalidad Distrital de Huaynacotas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
712	300433	40805	Municipalidad Distrital de Pampamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
713	300434	40806	Municipalidad Distrital de Puyca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
714	300435	40807	Municipalidad Distrital de Quechualla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
715	300436	40808	Municipalidad Distrital de Sayla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
716	300437	40809	Municipalidad Distrital de Tauria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
717	300438	40810	Municipalidad Distrital de Tomepampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
718	300439	40811	Municipalidad Distrital de Toro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
719	300440	50101	Municipalidad Provincial de Huamanga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
720	300441	50102	Municipalidad Distrital de Acocro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
721	300442	50103	Municipalidad Distrital de Acos Vinchos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
722	300443	50104	Municipalidad Distrital de Carmen Alto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
723	300444	50105	Municipalidad Distrital de Chiara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
724	300445	50106	Municipalidad Distrital de Ocros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
725	300446	50107	Municipalidad Distrital de Pacaicasa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
726	300447	50108	Municipalidad Distrital de Quinua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
727	300448	50109	Municipalidad Distrital de San José de Ticllas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
728	300449	50110	Municipalidad Distrital de San Juan Bautista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
729	300450	50111	Municipalidad Distrital de Santiago de Pischa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
730	300451	50112	Municipalidad Distrital de Socos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
731	300452	50113	Municipalidad Distrital de Tambillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
732	300453	50114	Municipalidad Distrital de Vinchos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
733	301830	50115	Municipalidad Distrital Jesus Nazareno	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
734	301852	50116	Municipalidad Distrital de Andres Avelino Caceres Dorregaray	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
735	300454	50201	Municipalidad Provincial de Cangallo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
736	300455	50202	Municipalidad Distrital de Chuschi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
737	300456	50203	Municipalidad Distrital de los Morochucos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
738	300457	50204	Municipalidad Distrital de Maria Parado de Bellido	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
739	300458	50205	Municipalidad Distrital de Paras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
740	300459	50206	Municipalidad Distrital de Totos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
741	300460	50301	Municipalidad Provincial de Huanca Sancos - Sancos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
742	300461	50302	Municipalidad Distrital de Carapo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
743	300462	50303	Municipalidad Distrital de Sacsamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
744	300463	50304	Municipalidad Distrital de Santiago de Lucanamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
745	300464	50401	Municipalidad Provincial de Huanta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
746	300465	50402	Municipalidad Distrital de Ayahuanco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
747	300466	50403	Municipalidad Distrital de Huamanguilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
748	300467	50404	Municipalidad Distrital de Iguain	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
749	300468	50405	Municipalidad Distrital de Luricocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
750	300469	50406	Municipalidad Distrital de Santillana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
751	300470	50407	Municipalidad Distrital de Sivia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
752	301837	50408	Municipalidad Distrital de Llochegua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
753	301850	50409	Municipalidad Distrital de Canayre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
754	301862	50410	Municipalidad Distrital de Uchuraccay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
755	301866	50411	Municipalidad Distrital de Pucacolpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
756	301874	50412	Municipalidad Distrital de Chaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
757	301888	50413	Municipalidad Distrital de Putis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
758	300471	50501	Municipalidad Provincial de la Mar - San Miguel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
759	300472	50502	Municipalidad Distrital de Anco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
760	300473	50503	Municipalidad Distrital de Ayna	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
761	300474	50504	Municipalidad Distrital de Chilcas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
762	300475	50505	Municipalidad Distrital de Chungui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
763	300476	50506	Municipalidad Distrital de Luis Carranza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
764	300477	50507	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
765	300478	50508	Municipalidad Distrital de Tambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
766	301848	50509	Municipalidad Distrital de Samugari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
767	301851	50510	Municipalidad Distrital de Anchihuay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
768	301882	50511	Municipalidad Distrital de Oronccoy	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
769	301889	50512	Municipalidad Distrital de Union Progreso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
770	301890	50513	Municipalidad Distrital de Rio Magdalena	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
771	301891	50514	Municipalidad Distrital de Ninabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
772	301892	50515	Municipalidad Distrital de Patibamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
773	300479	50601	Municipalidad Provincial de Lucanas - Puquio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
774	300480	50602	Municipalidad Distrital de Aucara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
775	300481	50603	Municipalidad Distrital de Cabana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
776	300482	50604	Municipalidad Distrital de Carmen Salcedo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
777	300483	50605	Municipalidad Distrital de Chaviña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
778	300484	50606	Municipalidad Distrital de Chipao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
779	300485	50607	Municipalidad Distrital de Huac - Huas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
780	300486	50608	Municipalidad Distrital de Laramate	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
781	300487	50609	Municipalidad Distrital de Leoncio Prado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
782	300488	50610	Municipalidad Distrital de Llauta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
783	300489	50611	Municipalidad Distrital de Lucanas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
784	300490	50612	Municipalidad Distrital de Ocaña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
785	300491	50613	Municipalidad Distrital de Otoca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
786	300492	50614	Municipalidad Distrital de Saisa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
787	300493	50615	Municipalidad Distrital de San Cristobal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
788	300494	50616	Municipalidad Distrital de San Juan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
789	300495	50617	Municipalidad Distrital de San Pedro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
790	300496	50618	Municipalidad Distrital de San Pedro de Palco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
791	300497	50619	Municipalidad Distrital de Sancos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
792	300498	50620	Municipalidad Distrital de Santa Ana de Huaycahuacho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
793	300499	50621	Municipalidad Distrital de Santa Lucia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
794	300500	50701	Municipalidad Provincial de Parinacochas - Coracora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
795	300501	50702	Municipalidad Distrital de Chumpi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
796	300502	50703	Municipalidad Distrital de Coronel Castañeda	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
797	300503	50704	Municipalidad Distrital de Pacapausa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
798	300504	50705	Municipalidad Distrital de Pullo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
799	300505	50706	Municipalidad Distrital de Puyusca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
800	300506	50707	Municipalidad Distrital de San Francisco de Rivacayco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
801	300507	50708	Municipalidad Distrital de Upahuacho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
802	300508	50801	Municipalidad Provincial de Paucar del Sara Sara - Pausa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
803	300509	50802	Municipalidad Distrital de Colta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
804	300510	50803	Municipalidad Distrital de Corculla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
805	300511	50804	Municipalidad Distrital de Lampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
806	300512	50805	Municipalidad Distrital de Marcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
807	300513	50806	Municipalidad Distrital de Oyolo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
808	300514	50807	Municipalidad Distrital de Pararca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
809	300515	50808	Municipalidad Distrital de San Javier de Alpabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
810	300516	50809	Municipalidad Distrital de San José de Ushua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
811	300517	50810	Municipalidad Distrital de Sara Sara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
812	300518	50901	Municipalidad Provincial de Sucre - Querobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
813	300519	50902	Municipalidad Distrital de Belen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
814	300520	50903	Municipalidad Distrital de Chalcos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
815	300521	50904	Municipalidad Distrital de Chilcayoc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
816	300522	50905	Municipalidad Distrital de Huacaña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
817	300523	50906	Municipalidad Distrital de Morcolla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
818	300524	50907	Municipalidad Distrital de Paico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
819	300525	50908	Municipalidad Distrital de San Pedro de Larcay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
820	300526	50909	Municipalidad Distrital de San Salvador de Quije	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
821	300527	50910	Municipalidad Distrital de Santiago de Paucaray	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
822	300528	50911	Municipalidad Distrital de Soras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
823	300529	51001	Municipalidad Provincial de Victor Fajardo - Huancapi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
824	300530	51002	Municipalidad Distrital de Alcamenca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
825	300531	51003	Municipalidad Distrital de Apongo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
826	300532	51004	Municipalidad Distrital de Asquipata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
827	300533	51005	Municipalidad Distrital de Canaria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
828	300534	51006	Municipalidad Distrital de Cayara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
829	300535	51007	Municipalidad Distrital de Colca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
830	300536	51008	Municipalidad Distrital de Huamanquiquia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
831	300537	51009	Municipalidad Distrital de Huancaraylla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
832	300538	51010	Municipalidad Distrital de Hualla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
833	300539	51011	Municipalidad Distrital de Sarhua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
834	300540	51012	Municipalidad Distrital de Vilcanchos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
835	300541	51101	Municipalidad Provincial de Vilcas Huaman	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
836	300542	51102	Municipalidad Distrital de Accomarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
837	300543	51103	Municipalidad Distrital de Carhuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
838	300544	51104	Municipalidad Distrital de Concepcion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
839	300545	51105	Municipalidad Distrital de Huambalpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
840	300546	51106	Municipalidad Distrital de Independencia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
841	300547	51107	Municipalidad Distrital de Saurama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
842	300548	51108	Municipalidad Distrital de Vischongo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
843	300549	60101	Municipalidad Provincial de Cajamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
844	300550	60102	Municipalidad Distrital de Asuncion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
845	300551	60103	Municipalidad Distrital de Chetilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
846	300552	60104	Municipalidad Distrital de Cospan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
847	300553	60105	Municipalidad Distrital de Encañada	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
848	300554	60106	Municipalidad Distrital de Jesus	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
849	300555	60107	Municipalidad Distrital de Llacanora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
850	300556	60108	Municipalidad Distrital de los Baños del Inca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
851	300557	60109	Municipalidad Distrital de Magdalena	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
852	300558	60110	Municipalidad Distrital de Matara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
853	300559	60111	Municipalidad Distrital de Namora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
854	300560	60112	Municipalidad Distrital de San Juan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
855	300562	60201	Municipalidad Provincial de Cajabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
856	300563	60202	Municipalidad Distrital de Cachachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
857	300564	60203	Municipalidad Distrital de Condebamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
858	300565	60204	Municipalidad Distrital de Sitacocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
859	300566	60301	Municipalidad Provincial de Celendin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
860	300567	60302	Municipalidad Distrital de Chumuch	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
861	300568	60303	Municipalidad Distrital de Cortegana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
862	300569	60304	Municipalidad Distrital de Huasmin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
863	300570	60305	Municipalidad Distrital de Jorge Chavez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
864	300571	60306	Municipalidad Distrital de José Galvez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
865	300572	60307	Municipalidad Distrital de Miguel Iglesias	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
866	300573	60308	Municipalidad Distrital de Oxamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
867	300574	60309	Municipalidad Distrital de Sorochuco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
868	300575	60310	Municipalidad Distrital de Sucre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
869	300576	60311	Municipalidad Distrital de Utco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
870	300577	60312	Municipalidad Distrital de la Libertad de Pallan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
871	300578	60401	Municipalidad Provincial de Chota	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
872	300579	60402	Municipalidad Distrital de Anguia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
873	300580	60403	Municipalidad Distrital de Chadin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
874	300581	60404	Municipalidad Distrital de Chiguirip	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
875	300582	60405	Municipalidad Distrital de Chimban	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
876	300583	60406	Municipalidad Distrital de Choropampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
877	300584	60407	Municipalidad Distrital de Cochabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
878	300585	60408	Municipalidad Distrital de Conchan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
879	300586	60409	Municipalidad Distrital de Huambos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
880	300587	60410	Municipalidad Distrital de Lajas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
881	300588	60411	Municipalidad Distrital de Llama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
882	300589	60412	Municipalidad Distrital de Miracosta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
883	300590	60413	Municipalidad Distrital de Paccha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
884	300591	60414	Municipalidad Distrital de Pion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
885	300592	60415	Municipalidad Distrital de Querocoto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
886	300593	60416	Municipalidad Distrital de San Juan de Licupis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
887	300594	60417	Municipalidad Distrital de Tacabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
888	300595	60418	Municipalidad Distrital de Tocmoche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
889	300596	60419	Municipalidad Distrital de Chalamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
890	300597	60501	Municipalidad Provincial de Contumaza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
891	300598	60502	Municipalidad Distrital de Chilete	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
892	300599	60503	Municipalidad Distrital de Cupisnique	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
893	300600	60504	Municipalidad Distrital de Guzmango	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
894	300601	60505	Municipalidad Distrital de San Benito	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
895	300602	60506	Municipalidad Distrital de Santa Cruz de Toledo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
896	300603	60507	Municipalidad Distrital de Tantarica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
897	300604	60508	Municipalidad Distrital de Yonan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
898	300605	60601	Municipalidad Provincial de Cutervo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
899	300606	60602	Municipalidad Distrital de Callayuc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
900	300607	60603	Municipalidad Distrital de Choros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
901	300608	60604	Municipalidad Distrital de Cujillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
902	300609	60605	Municipalidad Distrital de la Ramada	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
903	300610	60606	Municipalidad Distrital de Pimpingos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
904	300611	60607	Municipalidad Distrital de Querocotillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
905	300612	60608	Municipalidad Distrital de San Andrés de Cutervo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
906	300613	60609	Municipalidad Distrital de San Juan de Cutervo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
907	300614	60610	Municipalidad Distrital de San Luis de Lucma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
908	300615	60611	Municipalidad Distrital de Santa Cruz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
909	300616	60612	Municipalidad Distrital de Santo Domingo de la Capilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
910	300617	60613	Municipalidad Distrital de Santo Tomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
911	300618	60614	Municipalidad Distrital de Socota	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
912	300619	60615	Municipalidad Distrital de Toribio Casanova	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
913	300620	60701	Municipalidad Provincial de Hualgayoc - Bambamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
914	300621	60702	Municipalidad Distrital de Chugur	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
915	300622	60703	Municipalidad Distrital de Hualgayoc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
916	300623	60801	Municipalidad Provincial de Jaen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
917	300624	60802	Municipalidad Distrital de Bellavista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
918	300625	60803	Municipalidad Distrital de Chontali	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
919	300626	60804	Municipalidad Distrital de Colasay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
920	300627	60805	Municipalidad Distrital de Huabal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
921	300628	60806	Municipalidad Distrital de las Pirias	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
922	300629	60807	Municipalidad Distrital de Pomahuaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
923	300630	60808	Municipalidad Distrital de Pucara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
924	300631	60809	Municipalidad Distrital de Sallique	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
925	300632	60810	Municipalidad Distrital de San Felipe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
926	300633	60811	Municipalidad Distrital de San José del Alto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
927	300634	60812	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
928	300635	60901	Municipalidad Provincial de San Ignacio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
929	300636	60902	Municipalidad Distrital de Chirinos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
930	300637	60903	Municipalidad Distrital de Huarango	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
931	300638	60904	Municipalidad Distrital de la Coipa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
932	300639	60905	Municipalidad Distrital de Namballe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
933	300640	60906	Municipalidad Distrital de San José de Lourdes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
934	300641	60907	Municipalidad Distrital de Tabaconas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
935	300642	61001	Municipalidad Provincial de San Marcos - Pedro Galvez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
936	300643	61002	Municipalidad Distrital de Chancay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
937	300644	61003	Municipalidad Distrital de Eduardo Villanueva	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
938	300645	61004	Municipalidad Distrital de Gregorio Pita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
939	300646	61005	Municipalidad Distrital de Ichocan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
940	300647	61006	Municipalidad Distrital de José Manuel Quiroz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
941	300648	61007	Municipalidad Distrital de José Sabogal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
942	300649	61101	Municipalidad Provincial de San Miguel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
943	300650	61102	Municipalidad Distrital de Bolivar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
944	300651	61103	Municipalidad Distrital de Calquis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
945	300652	61104	Municipalidad Distrital de Catilluc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
946	300653	61105	Municipalidad Distrital de El Prado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
947	300654	61106	Municipalidad Distrital de la Florida	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
948	300655	61107	Municipalidad Distrital de Llapa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
949	300656	61108	Municipalidad Distrital de Nanchoc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
950	300657	61109	Municipalidad Distrital de Niepos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
951	300658	61110	Municipalidad Distrital de San Gregorio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
952	300659	61111	Municipalidad Distrital de San Silvestre de Cochan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
953	300660	61112	Municipalidad Distrital de Tongod	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
954	300661	61113	Municipalidad Distrital de Unión Agua Blanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
955	300662	61201	Municipalidad Provincial de San Pablo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
956	300663	61202	Municipalidad Distrital de San Bernardino	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
957	300664	61203	Municipalidad Distrital de San Luis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
958	300665	61204	Municipalidad Distrital de Tumbaden	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
959	300666	61301	Municipalidad Provincial de Santa Cruz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
960	300667	61302	Municipalidad Distrital de Andabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
961	300668	61303	Municipalidad Distrital de Catache	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
962	300669	61304	Municipalidad Distrital de Chancaybaños	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
963	300670	61305	Municipalidad Distrital de la Esperanza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
964	300671	61306	Municipalidad Distrital de Ninabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
965	300672	61307	Municipalidad Distrital de Pulan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
966	300673	61308	Municipalidad Distrital de Saucepampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
967	300674	61309	Municipalidad Distrital de Sexi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
968	300675	61310	Municipalidad Distrital de Uticyacu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
969	300676	61311	Municipalidad Distrital de Yauyucan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
970	300677	70101	Municipalidad Provincial del Callao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
971	300678	70102	Municipalidad Distrital de Bellavista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
972	300679	70103	Municipalidad Distrital de Carmen de la Legua Reynoso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
973	300680	70104	Municipalidad Distrital de la Perla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
974	300681	70105	Municipalidad Distrital de la Punta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
975	300682	70106	Municipalidad Distrital de Ventanilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
976	301853	70107	Municipalidad Distrital de Mi Perú	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
977	300684	80101	Municipalidad Provincial del Cusco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
978	300685	80102	Municipalidad Distrital de Ccorcca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
979	300686	80103	Municipalidad Distrital de Poroy	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
980	300687	80104	Municipalidad Distrital de San Jeronimo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
981	300688	80105	Municipalidad Distrital de San Sebastián	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
982	300689	80106	Municipalidad Distrital de Santiago	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
983	300690	80107	Municipalidad Distrital de Saylla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
984	300691	80108	Municipalidad Distrital de Wanchaq	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
985	300692	80201	Municipalidad Provincial de Acomayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
986	300693	80202	Municipalidad Distrital de Acopia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
987	300694	80203	Municipalidad Distrital de Acos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
988	300695	80204	Municipalidad Distrital de Mosoc Llacta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
989	300696	80205	Municipalidad Distrital de Pomacanchi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
990	300697	80206	Municipalidad Distrital de Rondocan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
991	300698	80207	Municipalidad Distrital de Sangarara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
992	300699	80301	Municipalidad Provincial de Anta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
993	300700	80302	Municipalidad Distrital de Ancahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
994	300701	80303	Municipalidad Distrital de Cachimayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
995	300702	80304	Municipalidad Distrital de Chinchaypujio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
996	300703	80305	Municipalidad Distrital de Huarocondo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
997	300704	80306	Municipalidad Distrital de Limatambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
998	300705	80307	Municipalidad Distrital de Mollepata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
999	300706	80308	Municipalidad Distrital de Pucyura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1000	300707	80309	Municipalidad Distrital de Zurite	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1001	300708	80401	Municipalidad Provincial de Calca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1002	300709	80402	Municipalidad Distrital de Coya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1003	300710	80403	Municipalidad Distrital de Lamay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1004	300711	80404	Municipalidad Distrital de Lares	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1005	300712	80405	Municipalidad Distrital de Pisac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1006	300713	80406	Municipalidad Distrital de San Salvador	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1007	300714	80407	Municipalidad Distrital de Taray	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1008	300715	80408	Municipalidad Distrital de Yanatile	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1009	300716	80501	Municipalidad Provincial de Canas - Yanaoca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1010	300717	80502	Municipalidad Distrital de Checca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1011	300718	80503	Municipalidad Distrital de Kunturkanki	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1012	300719	80504	Municipalidad Distrital de Langui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1013	300720	80505	Municipalidad Distrital de Layo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1014	300721	80506	Municipalidad Distrital de Pampamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1015	300722	80507	Municipalidad Distrital de Quehue	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1016	300723	80508	Municipalidad Distrital de Tupac Amaru	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1017	300724	80601	Municipalidad Provincial de Canchis - Sicuani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1018	300725	80602	Municipalidad Distrital de Checacupe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1019	300726	80603	Municipalidad Distrital de Combapata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1020	300727	80604	Municipalidad Distrital de Marangani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1021	300728	80605	Municipalidad Distrital de Pitumarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1022	300729	80606	Municipalidad Distrital de San Pablo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1023	300730	80607	Municipalidad Distrital de San Pedro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1024	300731	80608	Municipalidad Distrital de Tinta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1025	300732	80701	Municipalidad Provincial de Chumbivilcas - Santo Tomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1026	300733	80702	Municipalidad Distrital de Capacmarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1027	300734	80703	Municipalidad Distrital de Chamaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1028	300735	80704	Municipalidad Distrital de Colquemarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1029	300736	80705	Municipalidad Distrital de Livitaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1030	300737	80706	Municipalidad Distrital de Llusco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1031	300738	80707	Municipalidad Distrital de Quiñota	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1032	300739	80708	Municipalidad Distrital de Velille	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1033	300740	80801	Municipalidad Provincial de Espinar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1034	300741	80802	Municipalidad Distrital de Condoroma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1035	300742	80803	Municipalidad Distrital de Coporaque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1036	300743	80804	Municipalidad Distrital de Ocoruro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1037	300744	80805	Municipalidad Distrital de Pallpata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1038	300745	80806	Municipalidad Distrital de Pichigua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1039	300746	80807	Municipalidad Distrital de Suyckutambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1040	300747	80808	Municipalidad Distrital de Alto Pichigua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1041	300748	80901	Municipalidad Provincial de la Convención - Santa Ana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1042	300749	80902	Municipalidad Distrital de Echarati	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1043	300750	80903	Municipalidad Distrital de Huayopata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1044	300751	80904	Municipalidad Distrital de Maranura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1045	300752	80905	Municipalidad Distrital de Ocobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1046	300753	80906	Municipalidad Distrital de Quellouno	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1047	300754	80907	Municipalidad Distrital de Quimbiri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1048	300755	80908	Municipalidad Distrital de Santa Teresa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1049	300756	80909	Municipalidad Distrital de Vilcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1050	300757	80910	Municipalidad Distrital de Pichari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1051	301859	80911	Municipalidad Distrital de Inkawasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1052	301858	80912	Municipalidad Distrital de Villa Virgen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1053	301867	80913	Municipalidad Distrital de Villa Kintiarina	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1054	301884	80914	Municipalidad Distrital de Megantoni	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1055	301893	80915	Municipalidad Distrital de Kumpirushiato	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1056	301894	80916	Municipalidad Distrital de Cielo Punco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1057	301895	80917	Municipalidad Distrital de Manitea	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1058	301902	80918	Municipalidad Distrital de Unión Ashaninka	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1059	300758	81001	Municipalidad Provincial de Paruro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1060	300759	81002	Municipalidad Distrital de Accha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1061	300760	81003	Municipalidad Distrital de Ccapi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1062	300761	81004	Municipalidad Distrital de Colcha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1063	300762	81005	Municipalidad Distrital de Huanoquite	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1064	300763	81006	Municipalidad Distrital de Omacha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1065	300764	81007	Municipalidad Distrital de Paccaritambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1066	300765	81008	Municipalidad Distrital de Pillpinto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1067	300766	81009	Municipalidad Distrital de Yaurisque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1068	300767	81101	Municipalidad Provincial de Paucartambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1069	300768	81102	Municipalidad Distrital de Caicay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1070	300769	81103	Municipalidad Distrital de Challabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1071	300770	81104	Municipalidad Distrital de Colquepata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1072	300771	81105	Municipalidad Distrital de Huancarani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1073	300772	81106	Municipalidad Distrital de Kosñipata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1074	300773	81201	Municipalidad Provincial de Quispicanchis - Urcos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1075	300774	81202	Municipalidad Distrital de Andahuaylillas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1076	300775	81203	Municipalidad Distrital de Camanti	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1077	300776	81204	Municipalidad Distrital de Ccarhuayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1078	300777	81205	Municipalidad Distrital de Ccatca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1079	300778	81206	Municipalidad Distrital de Cusipata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1080	300779	81207	Municipalidad Distrital de Huaro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1081	300780	81208	Municipalidad Distrital de Lucre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1082	300781	81209	Municipalidad Distrital de Marcapata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1083	300782	81210	Municipalidad Distrital de Ocongate	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1084	300783	81211	Municipalidad Distrital de Oropesa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1085	300784	81212	Municipalidad Distrital de Quiquijana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1086	300785	81301	Municipalidad Provincial de Urubamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1087	300786	81302	Municipalidad Distrital de Chinchero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1088	300787	81303	Municipalidad Distrital de Huayllabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1089	300788	81304	Municipalidad Distrital de Machupicchu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1090	300789	81305	Municipalidad Distrital de Maras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1091	300790	81306	Municipalidad Distrital de Ollantaytambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1092	300791	81307	Municipalidad Distrital de Yucay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1093	300792	90101	Municipalidad Provincial de Huancavelica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1094	300793	90102	Municipalidad Distrital de Acobambilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1095	300794	90103	Municipalidad Distrital de Acoria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1096	300795	90104	Municipalidad Distrital de Conayca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1097	300796	90105	Municipalidad Distrital de Cuenca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1098	300797	90106	Municipalidad Distrital de Huachocolpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1099	300798	90107	Municipalidad Distrital de Huayllahuara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1100	300799	90108	Municipalidad Distrital de Izcuchaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1101	300800	90109	Municipalidad Distrital de Laria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1102	300801	90110	Municipalidad Distrital de Manta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1103	300802	90111	Municipalidad Distrital de Mariscal Cáceres	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1104	300803	90112	Municipalidad Distrital de Moya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1105	300804	90113	Municipalidad Distrital de Nuevo Occoro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1106	300805	90114	Municipalidad Distrital de Palca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1107	300806	90115	Municipalidad Distrital de Pilchaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1108	300807	90116	Municipalidad Distrital de Vilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1109	300808	90117	Municipalidad Distrital de Yauli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1110	301831	90118	Municipalidad Distrital Ascension	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1111	300875	90119	Municipalidad Distrital de Huando	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1112	300809	90201	Municipalidad Provincial de Acobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1113	300810	90202	Municipalidad Distrital de Andabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1114	300811	90203	Municipalidad Distrital de Anta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1115	300812	90204	Municipalidad Distrital de Caja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1116	300813	90205	Municipalidad Distrital de Marcas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1117	300814	90206	Municipalidad Distrital de Paucara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1118	300815	90207	Municipalidad Distrital de Pomacocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1119	300816	90208	Municipalidad Distrital de Rosario	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1120	300817	90301	Municipalidad Provincial de Angaraes - Lircay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1121	300818	90302	Municipalidad Distrital de Anchonga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1122	300819	90303	Municipalidad Distrital de Callanmarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1123	300820	90304	Municipalidad Distrital de Ccochaccasa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1124	300821	90305	Municipalidad Distrital de Chincho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1125	300822	90306	Municipalidad Distrital de Congalla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1126	300823	90307	Municipalidad Distrital de Huanca Huanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1127	300824	90308	Municipalidad Distrital de Huayllay Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1128	300825	90309	Municipalidad Distrital de Julcamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1129	300826	90310	Municipalidad Distrital de San Antonio de Antaparco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1130	300827	90311	Municipalidad Distrital de Santo Tomas de Pata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1131	300828	90312	Municipalidad Distrital de Secclla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1132	300829	90401	Municipalidad Provincial de Castrovirreyna	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1133	300830	90402	Municipalidad Distrital de Arma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1134	300831	90403	Municipalidad Distrital de Aurahua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1135	300832	90404	Municipalidad Distrital de Capillas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1136	300833	90405	Municipalidad Distrital de Chupamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1137	300834	90406	Municipalidad Distrital de Cocas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1138	300835	90407	Municipalidad Distrital de Huachos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1139	300836	90408	Municipalidad Distrital de Huamatambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1140	300837	90409	Municipalidad Distrital de Mollepampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1141	300838	90410	Municipalidad Distrital de San Juan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1142	300839	90411	Municipalidad Distrital de Santa Ana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1143	300840	90412	Municipalidad Distrital de Tantara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1144	300841	90413	Municipalidad Distrital de Ticrapo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1145	300842	90501	Municipalidad Provincial de Churcampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1146	300843	90502	Municipalidad Distrital de Anco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1147	300844	90503	Municipalidad Distrital de Chinchihuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1148	300845	90504	Municipalidad Distrital de el Carmen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1149	300846	90505	Municipalidad Distrital de la Merced	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1150	300847	90506	Municipalidad Distrital de Locroja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1151	300848	90507	Municipalidad Distrital de Paucarbamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1152	300849	90508	Municipalidad Distrital de San Miguel de Mayocc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1153	300850	90509	Municipalidad Distrital de San Pedro de Coris	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1154	300851	90510	Municipalidad Distrital de Pachamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1155	301845	90511	Municipalidad Distrital de Cosme	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1156	300852	90601	Municipalidad Provincial de Huaytara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1157	300853	90602	Municipalidad Distrital de Ayavi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1158	300854	90603	Municipalidad Distrital de Cordova	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1159	300855	90604	Municipalidad Distrital de Huayacundo Arma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1160	300856	90605	Municipalidad Distrital de Laramarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1161	300857	90606	Municipalidad Distrital de Ocoyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1162	300858	90607	Municipalidad Distrital de Pilpichaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1163	300859	90608	Municipalidad Distrital de Querco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1164	300860	90609	Municipalidad Distrital de Quito Arma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1165	300861	90610	Municipalidad Distrital de San Antonio de Cusicancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1166	300862	90611	Municipalidad Distrital de San Francisco de Sangayaico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1167	300863	90612	Municipalidad Distrital de San Isidro - Huirpacancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1168	300864	90613	Municipalidad Distrital de Santiago de Chocorvos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1169	300865	90614	Municipalidad Distrital de Santiago de Quirahuara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1170	300866	90615	Municipalidad Distrital de Santo Domingo de Capillas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1171	300867	90616	Municipalidad Distrital de Tambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1172	300868	90701	Municipalidad Provincial de Tayacaja - Pampas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1173	300869	90702	Municipalidad Distrital de Acostambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1174	300870	90703	Municipalidad Distrital de Acraquia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1175	300871	90704	Municipalidad Distrital de Ahuaycha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1176	300872	90705	Municipalidad Distrital de Colcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1177	300873	90706	Municipalidad Distrital de Daniel Hernandes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1178	300874	90707	Municipalidad Distrital de Huachocolpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1179	300876	90709	Municipalidad Distrital de Huaribamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1180	300877	90710	Municipalidad Distrital de Ñahuimpuquio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1181	300878	90711	Municipalidad Distrital de Pazos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1182	300879	90713	Municipalidad Distrital de Quishuar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1183	300880	90714	Municipalidad Distrital de Salcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1184	300881	90715	Municipalidad Distrital de Salcahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1185	300882	90716	Municipalidad Distrital de San Marcos Rocchac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1186	300883	90717	Municipalidad Distrital de Surcubamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1187	300884	90718	Municipalidad Distrital de Tintay Puncu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1188	301860	90719	Municipalidad Distrital de Quichuas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1189	301861	90720	Municipalidad Distrital de Andaymarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1190	301876	90721	Municipalidad Distrital de Roble	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1191	301871	90722	Municipalidad Distrital de Pichos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1192	301883	90723	Municipalidad Distrital de Santiago de Tucuma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1193	301887	90724	Municipalidad Distrital de Lambras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1194	301896	90725	Municipalidad Distrital de Cochabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1195	300885	100101	Municipalidad Provincial de Huanuco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1196	300886	100102	Municipalidad Distrital de Amarilis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1197	300887	100103	Municipalidad Distrital de Chinchao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1198	300888	100104	Municipalidad Distrital de Churubamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1199	300889	100105	Municipalidad Distrital de Margos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1200	300890	100106	Municipalidad Distrital de Quisqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1201	300891	100107	Municipalidad Distrital de San Francisco de Cayran	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1202	300892	100108	Municipalidad Distrital de San Pedro de Chaulan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1203	300893	100109	Municipalidad Distrital de Santa María del Valle	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1204	300894	100110	Municipalidad Distrital de Yarumayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1205	301835	100111	Municipalidad Distrital de Pillco Marca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1206	301846	100112	Municipalidad Distrital de Yacus	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1207	301875	100113	Municipalidad Distrital de San Pablo de Pillao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1208	300895	100201	Municipalidad Provincial de Ambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1209	300896	100202	Municipalidad Distrital de Cayna	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1210	300897	100203	Municipalidad Distrital de Colpas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1211	300898	100204	Municipalidad Distrital de Conchamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1212	300899	100205	Municipalidad Distrital de Huacar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1213	300900	100206	Municipalidad Distrital de San Francisco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1214	300901	100207	Municipalidad Distrital de San Rafael	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1215	300902	100208	Municipalidad Distrital de Tomay Kichwa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1216	300903	100301	Municipalidad Provincial de Dos de Mayo - la Union	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1217	300904	100307	Municipalidad Distrital de Chuquis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1218	300905	100311	Municipalidad Distrital de Marias	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1219	300906	100313	Municipalidad Distrital de Pachas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1220	300907	100316	Municipalidad Distrital de Quivilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1221	300908	100317	Municipalidad Distrital de Ripan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1222	300909	100321	Municipalidad Distrital de Shunqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1223	300910	100322	Municipalidad Distrital de Sillapata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1224	300911	100323	Municipalidad Distrital de Yanas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1225	300912	100401	Municipalidad Provincial de Huacaybamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1226	300913	100402	Municipalidad Distrital de Canchabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1227	300914	100403	Municipalidad Distrital de Cochabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1228	300915	100404	Municipalidad Distrital de Pinra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1229	300916	100501	Municipalidad Provincial de Huamalies - Llata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1230	300917	100502	Municipalidad Distrital de Arancay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1231	300918	100503	Municipalidad Distrital de Chavín de Pariarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1232	300919	100504	Municipalidad Distrital de Jacas Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1233	300920	100505	Municipalidad Distrital de Jircan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1234	300921	100506	Municipalidad Distrital de Miraflores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1235	300922	100507	Municipalidad Distrital de Monzon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1236	300923	100508	Municipalidad Distrital de Punchao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1237	300924	100509	Municipalidad Distrital de Puños	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1238	300925	100510	Municipalidad Distrital de Singa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1239	300926	100511	Municipalidad Distrital de Tantamayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1240	300927	100601	Municipalidad Provincial de Leoncio Prado - Rupa Rupa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1241	300928	100602	Municipalidad Distrital de Daniel Alomia Robles	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1242	300929	100603	Municipalidad Distrital de Hermilio Valdizan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1243	300930	100604	Municipalidad Distrital de Crespo y Castillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1244	300931	100605	Municipalidad Distrital de Luyando	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1245	300932	100606	Municipalidad Distrital de Mariano Damaso Beraun	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1246	301879	100607	Municipalidad Distrital de Pucayacu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1247	301870	100608	Municipalidad Distrital de Castillo Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1248	301881	100609	Municipalidad Distrital de Pueblo Nuevo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1249	301885	100610	Municipalidad Distrital de Santo Domingo de Anda	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1250	300934	100701	Municipalidad Provincial de Marañon - Huacrachuco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1251	300935	100702	Municipalidad Distrital de Cholon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1252	300936	100703	Municipalidad Distrital de San Buenaventura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1253	301872	100704	Municipalidad Distrital de la Morada	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1254	301873	100705	Municipalidad Distrital de Santa Rosa de Alto Yanajanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1255	300937	100801	Municipalidad Provincial de Pachitea - Panao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1256	300938	100802	Municipalidad Distrital de Chaglla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1257	300939	100803	Municipalidad Distrital de Molino	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1258	300940	100804	Municipalidad Distrital de Umari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1259	300941	100901	Municipalidad Provincial de Puerto Inca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1260	300942	100902	Municipalidad Distrital de Codo de Pozuzo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1261	300943	100903	Municipalidad Distrital de Honoria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1262	300944	100904	Municipalidad Distrital de Tournavista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1263	300945	100905	Municipalidad Distrital de Yuyapichis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1264	300946	101001	Municipalidad Provincial de Lauricocha - Jesus	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1265	300947	101002	Municipalidad Distrital de Baños	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1266	300948	101003	Municipalidad Distrital de Jivia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1267	300949	101004	Municipalidad Distrital de Queropalca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1268	300950	101005	Municipalidad Distrital de Rondos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1269	300951	101006	Municipalidad Distrital de San Francisco de Asis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1270	300952	101007	Municipalidad Distrital de San Miguel de Cauri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1271	300953	101101	Municipalidad Provincial de Yarowilca - Chavinillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1272	300954	101102	Municipalidad Distrital de Cahuac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1273	300955	101103	Municipalidad Distrital de Chacabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1274	300956	101104	Municipalidad Distrital Aparicio Pomares	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1275	300957	101105	Municipalidad Distrital de Jacas Chico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1276	300958	101106	Municipalidad Distrital de Obas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1277	300959	101107	Municipalidad Distrital de Pampamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1278	301839	101108	Municipalidad Distrital de Choras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1279	300960	110101	Municipalidad Provincial de Ica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1280	300961	110102	Municipalidad Distrital de Tinguiña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1281	300962	110103	Municipalidad Distrital de los Aquijes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1282	300963	110104	Municipalidad Distrital de Ocucaje	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1283	300964	110105	Municipalidad Distrital de Pachacutec	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1284	300965	110106	Municipalidad Distrital de Parcona	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1285	300966	110107	Municipalidad Distrital de Pueblo Nuevo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1286	300967	110108	Municipalidad Distrital de Salas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1287	300968	110109	Municipalidad Distrital de San José de los Molinos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1288	300969	110110	Municipalidad Distrital de San Juan Bautista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1289	300970	110111	Municipalidad Distrital de Santiago	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1290	300971	110112	Municipalidad Distrital de Subtanjalla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1291	300972	110113	Municipalidad Distrital de Tate	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1292	300973	110114	Municipalidad Distrital de Yauca del Rosario	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1293	300974	110201	Municipalidad Provincial de Chincha - Chincha Alta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1294	300975	110202	Municipalidad Distrital de Alto Laran	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1295	300976	110203	Municipalidad Distrital de Chavin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1296	300977	110204	Municipalidad Distrital de Chincha Baja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1297	300978	110205	Municipalidad Distrital de el Carmen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1298	300979	110206	Municipalidad Distrital de Grocio Prado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1299	300980	110207	Municipalidad Distrital de Pueblo Nuevo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1300	300981	110208	Municipalidad Distrital de San Juan de Yanac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1301	300982	110209	Municipalidad Distrital de San Pedro de Huacarpana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1302	300983	110210	Municipalidad Distrital de Sunampe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1303	300984	110211	Municipalidad Distrital de Tambo de Mora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1304	300985	110301	Municipalidad Provincial de Nasca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1305	300986	110302	Municipalidad Distrital de Changuillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1306	300987	110303	Municipalidad Distrital de El Ingenio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1307	300988	110304	Municipalidad Distrital de Marcona	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1308	300989	110305	Municipalidad Distrital de Vista Alegre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1309	300990	110401	Municipalidad Provincial de Palpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1310	300991	110402	Municipalidad Distrital de Llipata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1311	300992	110403	Municipalidad Distrital de Rio Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1312	300993	110404	Municipalidad Distrital de Santa Cruz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1313	300994	110405	Municipalidad Distrital de Tibillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1314	300995	110501	Municipalidad Provincial de Pisco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1315	300996	110502	Municipalidad Distrital de Huancano	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1316	300997	110503	Municipalidad Distrital de Humay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1317	300998	110504	Municipalidad Distrital de Independencia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1318	300999	110505	Municipalidad Distrital de Paracas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1319	301000	110506	Municipalidad Distrital de San Andres	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1320	301001	110507	Municipalidad Distrital de San Clemente	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1321	301002	110508	Municipalidad Distrital de Tupac Amaru Inca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1322	301003	120101	Municipalidad Provincial de Huancayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1323	301004	120104	Municipalidad Distrital de Carhuacallanga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1324	301005	120105	Municipalidad Distrital de Chacapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1325	301006	120106	Municipalidad Distrital de Chicche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1326	301007	120107	Municipalidad Distrital de Chilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1327	301008	120108	Municipalidad Distrital de Chongos Alto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1328	301009	120111	Municipalidad Distrital de Chupuro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1329	301010	120112	Municipalidad Distrital de Colca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1330	301011	120113	Municipalidad Distrital de Cullhuas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1331	301012	120114	Municipalidad Distrital de el Tambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1332	301013	120116	Municipalidad Distrital de Huacrapuquio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1333	301014	120117	Municipalidad Distrital de Hualhuas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1334	301015	120119	Municipalidad Distrital de Huancan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1335	301016	120120	Municipalidad Distrital de Huasicancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1336	301017	120121	Municipalidad Distrital de Huayucachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1337	301018	120122	Municipalidad Distrital de Ingenio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1338	301019	120124	Municipalidad Distrital de Pariahuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1339	301020	120125	Municipalidad Distrital de Pilcomayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1340	301021	120126	Municipalidad Distrital de Pucara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1341	301022	120127	Municipalidad Distrital de Quichuay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1342	301023	120128	Municipalidad Distrital de Quilcas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1343	301024	120129	Municipalidad Distrital de San Agustín	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1344	301025	120130	Municipalidad Distrital de San Jerónimo de Tunan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1345	301026	120132	Municipalidad Distrital de Saño	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1346	301027	120133	Municipalidad Distrital de Sapallanga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1347	301028	120134	Municipalidad Distrital de Sicaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1348	301029	120135	Municipalidad Distrital de Santo Domingo de Acobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1349	301030	120136	Municipalidad Distrital de Viques	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1350	301031	120201	Municipalidad Provincial de Concepcion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1351	301032	120202	Municipalidad Distrital de Aco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1352	301033	120203	Municipalidad Distrital de Andamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1353	301034	120204	Municipalidad Distrital de Chambara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1354	301035	120205	Municipalidad Distrital de Cochas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1355	301036	120206	Municipalidad Distrital de Comas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1356	301037	120207	Municipalidad Distrital de Heroínas Toledo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1357	301038	120208	Municipalidad Distrital de Manzanares	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1358	301039	120209	Municipalidad Distrital de Mariscal Castilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1359	301040	120210	Municipalidad Distrital de Matahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1360	301041	120211	Municipalidad Distrital de Mito	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1361	301042	120212	Municipalidad Distrital de Nueve de Julio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1362	301043	120213	Municipalidad Distrital de Orcotuna	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1363	301044	120214	Municipalidad Distrital de San José de Quero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1364	301045	120215	Municipalidad Distrital de Santa Rosa de Ocopa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1365	301046	120301	Municipalidad Provincial de Chanchamayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1366	301047	120302	Municipalidad Distrital de Perene	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1367	301048	120303	Municipalidad Distrital de Pichanaqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1368	301049	120304	Municipalidad Distrital de San Luis de Shuaro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1369	301050	120305	Municipalidad Distrital de San Ramón	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1370	301051	120306	Municipalidad Distrital de Vitoc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1371	301052	120401	Municipalidad Provincial de Jauja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1372	301053	120402	Municipalidad Distrital de Acolla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1373	301054	120403	Municipalidad Distrital de Apata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1374	301055	120404	Municipalidad Distrital de Ataura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1375	301056	120405	Municipalidad Distrital de Canchayllo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1376	301057	120406	Municipalidad Distrital de Curicaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1377	301058	120407	Municipalidad Distrital de El Mantaro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1378	301059	120408	Municipalidad Distrital de Huamali	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1379	301060	120409	Municipalidad Distrital de Huaripampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1380	301061	120410	Municipalidad Distrital de Huertas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1381	301062	120411	Municipalidad Distrital de Janjaillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1382	301063	120412	Municipalidad Distrital de Julcan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1383	301064	120413	Municipalidad Distrital de Leonor Ordo¥ez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1384	301065	120414	Municipalidad Distrital de Llocllapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1385	301066	120415	Municipalidad Distrital de Marco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1386	301067	120416	Municipalidad Distrital de Masma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1387	301068	120417	Municipalidad Distrital de Masma Chicche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1388	301069	120418	Municipalidad Distrital de Molinos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1389	301070	120419	Municipalidad Distrital de Monobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1390	301071	120420	Municipalidad Distrital de Muqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1391	301072	120421	Municipalidad Distrital de Muquiyauyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1392	301073	120422	Municipalidad Distrital de Paca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1393	301074	120423	Municipalidad Distrital de Paccha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1394	301075	120424	Municipalidad Distrital de Pancan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1395	301076	120425	Municipalidad Distrital de Parco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1396	301077	120426	Municipalidad Distrital de Pomacancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1397	301078	120427	Municipalidad Distrital de Ricran	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1398	301079	120428	Municipalidad Distrital de San Lorenzo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1399	301080	120429	Municipalidad Distrital de San Pedro de Chunan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1400	301081	120430	Municipalidad Distrital de Sausa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1401	301082	120431	Municipalidad Distrital de Sincos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1402	301083	120432	Municipalidad Distrital de Tunan Marca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1403	301084	120433	Municipalidad Distrital de Yauli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1404	301085	120434	Municipalidad Distrital de Yauyos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1405	301086	120501	Municipalidad Provincial de Junin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1406	301087	120502	Municipalidad Distrital de Carhuamayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1407	301088	120503	Municipalidad Distrital de Ondores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1408	301089	120504	Municipalidad Distrital de Ulcumayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1409	301090	120601	Municipalidad Provincial de Satipo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1410	301091	120602	Municipalidad Distrital de Coviriali	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1411	301092	120603	Municipalidad Distrital de Llaylla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1412	301093	120604	Municipalidad Distrital de Mazamari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1413	301094	120605	Municipalidad Distrital Pampa Hermosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1414	301095	120606	Municipalidad Distrital de Pangoa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1415	301096	120607	Municipalidad Distrital de Rio Negro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1416	301097	120608	Municipalidad Distrital de Rio Tambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1417	301868	120609	Municipalidad Distrital de Vizcatan del Ene	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1418	301098	120701	Municipalidad Provincial de Tarma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1419	301099	120702	Municipalidad Distrital de Acobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1420	301100	120703	Municipalidad Distrital de Huaricolca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1421	301101	120704	Municipalidad Distrital de Huasahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1422	301102	120705	Municipalidad Distrital de la Union	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1423	301103	120706	Municipalidad Distrital de Palca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1424	301104	120707	Municipalidad Distrital de Palcamayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1425	301105	120708	Municipalidad Distrital de San Pedro de Cajas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1426	301106	120709	Municipalidad Distrital de Tapo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1427	301108	120801	Municipalidad Provincial de Yauli - la Oroya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1428	301109	120802	Municipalidad Distrital de Chacapalpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1429	301110	120803	Municipalidad Distrital de Huay - Huay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1430	301111	120804	Municipalidad Distrital de Marcapomacocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1431	301112	120805	Municipalidad Distrital de Morococha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1432	301113	120806	Municipalidad Distrital de Paccha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1433	301114	120807	Municipalidad Distrital de Santa Barbara de Carhuacayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1434	301115	120808	Municipalidad Distrital de Santa Rosa de Sacco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1435	301116	120809	Municipalidad Distrital de Suitucancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1436	301117	120810	Municipalidad Distrital de Yauli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1437	301118	120901	Municipalidad Provincial de Chupaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1438	301119	120902	Municipalidad Distrital de Ahuac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1439	301120	120903	Municipalidad Distrital de Chongos Bajo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1440	301121	120904	Municipalidad Distrital de Huachac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1441	301122	120905	Municipalidad Distrital de Huamancaca Chico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1442	301123	120906	Municipalidad Distrital de San Juan de Iscos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1443	301124	120907	Municipalidad Distrital de San Juan de Jarpa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1444	301125	120908	Municipalidad Distrital de Tres de Diciembre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1445	301126	120909	Municipalidad Distrital de Yanacancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1446	301127	130101	Municipalidad Provincial de Trujillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1447	301128	130102	Municipalidad Distrital de El Porvenir	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1448	301129	130103	Municipalidad Distrital de Florencia de Mora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1449	301130	130104	Municipalidad Distrital de Huanchaco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1450	301131	130105	Municipalidad Distrital de la Esperanza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1451	301132	130106	Municipalidad Distrital de Laredo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1452	301133	130107	Municipalidad Distrital de Moche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1453	301134	130108	Municipalidad Distrital de Poroto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1454	301135	130109	Municipalidad Distrital de Salaverry	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1455	301136	130110	Municipalidad Distrital de Simbal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1456	301137	130111	Municipalidad Distrital de Víctor Larco Herrera	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1457	301903	130112	Municipalidad Distrital de Alto Trujillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1458	301140	130201	Municipalidad Provincial de Ascope	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1459	301141	130202	Municipalidad Distrital de Chicama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1460	301142	130203	Municipalidad Distrital de Chocope	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1461	301143	130204	Municipalidad Distrital de Magdalena de Cao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1462	301144	130205	Municipalidad Distrital de Paijan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1463	301145	130206	Municipalidad Distrital de Razuri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1464	301146	130207	Municipalidad Distrital de Santiago de Cao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1465	301147	130208	Municipalidad Distrital de Casa Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1466	301148	130301	Municipalidad Provincial de Bolivar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1467	301149	130302	Municipalidad Distrital de Bambamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1468	301150	130303	Municipalidad Distrital de Condormarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1469	301151	130304	Municipalidad Distrital de Longotea	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1470	301152	130305	Municipalidad Distrital de Uchumarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1471	301153	130306	Municipalidad Distrital de Ucuncha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1472	301154	130401	Municipalidad Provincial de Chepen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1473	301155	130402	Municipalidad Distrital de Pacanga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1474	301156	130403	Municipalidad Distrital de Pueblo Nuevo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1475	301157	130501	Municipalidad Provincial de Julcan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1476	301158	130502	Municipalidad Distrital de Calamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1477	301159	130503	Municipalidad Distrital de Carabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1478	301160	130504	Municipalidad Distrital de Huaso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1479	301161	130601	Municipalidad Provincial de Otuzco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1480	301162	130602	Municipalidad Distrital de Agallpampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1481	301163	130604	Municipalidad Distrital de Charat	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1482	301164	130605	Municipalidad Distrital de Huaranchal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1483	301165	130606	Municipalidad Distrital de la Cuesta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1484	301166	130608	Municipalidad Distrital de Mache	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1485	301167	130610	Municipalidad Distrital de Paranday	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1486	301168	130611	Municipalidad Distrital de Salpo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1487	301169	130613	Municipalidad Distrital de Sinsicap	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1488	301170	130614	Municipalidad Distrital de Usquil	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1489	301171	130701	Municipalidad Provincial de Pacasmayo - San Pedro de Lloc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1490	301172	130702	Municipalidad Distrital de Guadalupe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1491	301173	130703	Municipalidad Distrital de Jequetepeque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1492	301174	130704	Municipalidad Distrital de Pacasmayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1493	301175	130705	Municipalidad Distrital de San José	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1494	301176	130801	Municipalidad Provincial de Pataz - Tayabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1495	301177	130802	Municipalidad Distrital de Buldibuyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1496	301178	130803	Municipalidad Distrital de Chillia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1497	301179	130804	Municipalidad Distrital de Huancaspata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1498	301180	130805	Municipalidad Distrital de Huaylillas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1499	301181	130806	Municipalidad Distrital de Huayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1500	301182	130807	Municipalidad Distrital de Ongon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1501	301183	130808	Municipalidad Distrital de Parcoy	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1502	301184	130809	Municipalidad Distrital de Pataz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1503	301185	130810	Municipalidad Distrital de Pias	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1504	301186	130811	Municipalidad Distrital de Santiago de Challas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1505	301187	130812	Municipalidad Distrital de Taurija	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1506	301188	130813	Municipalidad Distrital de Urpay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1507	301189	130901	Municipalidad Provincial de Sánchez Carrión - Huamachuco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1508	301190	130902	Municipalidad Distrital de Chugay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1509	301191	130903	Municipalidad Distrital de Cochorco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1510	301192	130904	Municipalidad Distrital de Curgos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1511	301193	130905	Municipalidad Distrital de Marcabal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1512	301194	130906	Municipalidad Distrital de Sanagoran	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1513	301195	130907	Municipalidad Distrital de Sarin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1514	301196	130908	Municipalidad Distrital de Sartimbamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1515	301197	131001	Municipalidad Provincial de Santiago de Chuco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1516	301198	131002	Municipalidad Distrital de Angasmarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1517	301199	131003	Municipalidad Distrital de Cachicadan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1518	301200	131004	Municipalidad Distrital de Mollebamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1519	301201	131005	Municipalidad Distrital de Mollepata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1520	301202	131006	Municipalidad Distrital de Quiruvilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1521	301203	131007	Municipalidad Distrital de Santa Cruz de Chuca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1522	301204	131008	Municipalidad Distrital de Sitabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1523	301205	131101	Municipalidad Provincial Gran Chimú - Cascas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1524	301206	131102	Municipalidad Distrital de Lucma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1525	301207	131103	Municipalidad Distrital de Marmot	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1526	301208	131104	Municipalidad Distrital de Sayapullo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1527	301209	131201	Municipalidad Provincial de Viru	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1528	301210	131202	Municipalidad Distrital de Chao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1529	301211	131203	Municipalidad Distrital de Guadalupito	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1530	301212	140101	Municipalidad Provincial de Chiclayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1531	301213	140102	Municipalidad Distrital de Chongoyape	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1532	301214	140103	Municipalidad Distrital de Eten	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1533	301215	140104	Municipalidad Distrital de Eten Puerto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1534	301216	140105	Municipalidad Distrital de José Leonardo Ortiz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1535	301217	140106	Municipalidad Distrital de la Victoria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1536	301218	140107	Municipalidad Distrital de Lagunas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1537	301219	140108	Municipalidad Distrital de Monsefu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1538	301220	140109	Municipalidad Distrital de Nueva Arica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1539	301221	140110	Municipalidad Distrital de Oyotun	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1540	301222	140111	Municipalidad Distrital de Picsi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1541	301223	140112	Municipalidad Distrital de Pimentel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1542	301224	140113	Municipalidad Distrital de Reque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1543	301225	140114	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1544	301226	140115	Municipalidad Distrital de Zaña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1545	301227	140116	Municipalidad Distrital de Cayalti	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1546	301228	140117	Municipalidad Distrital de Patapo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1547	301229	140118	Municipalidad Distrital de Pomalca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1548	301230	140119	Municipalidad Distrital de Pucala	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1549	301231	140120	Municipalidad Distrital de Tuman	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1550	301232	140201	Municipalidad Provincial de Ferreñafe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1551	301233	140202	Municipalidad Distrital de Kañaris	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1552	301234	140203	Municipalidad Distrital de Incahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1553	301235	140204	Municipalidad Distrital de Manuel Antonio Mesones Muro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1554	301236	140205	Municipalidad Distrital de Pitipo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1555	301237	140206	Municipalidad Distrital de Pueblo Nuevo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1556	301238	140301	Municipalidad Provincial de Lambayeque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1557	301239	140302	Municipalidad Distrital de Chochope	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1558	301240	140303	Municipalidad Distrital de Illimo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1559	301241	140304	Municipalidad Distrital de Jayanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1560	301242	140305	Municipalidad Distrital de Mochumi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1561	301243	140306	Municipalidad Distrital de Morrope	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1562	301244	140307	Municipalidad Distrital de Motupe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1563	301245	140308	Municipalidad Distrital de Olmos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1564	301246	140309	Municipalidad Distrital de Pacora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1565	301247	140310	Municipalidad Distrital de Salas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1566	301248	140311	Municipalidad Distrital de San José	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1567	301249	140312	Municipalidad Distrital de Tucume	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1568	301250	150101	Municipalidad Metropolitana de Lima	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1569	301251	150102	Municipalidad Distrital de Ancon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1570	301252	150103	Municipalidad Distrital de Ate - Vitarte	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1571	301253	150104	Municipalidad Distrital de Barranco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1572	301254	150105	Municipalidad Distrital de Breña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1573	301255	150106	Municipalidad Distrital de Carabayllo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1574	301256	150107	Municipalidad Distrital de Chaclacayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1575	301257	150108	Municipalidad Distrital de Chorrillos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1576	301258	150109	Municipalidad Distrital de Cieneguilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1577	301259	150110	Municipalidad Distrital de Comas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1578	301260	150111	Municipalidad Distrital de El Agustino	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1579	301261	150112	Municipalidad Distrital de Independencia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1580	301262	150113	Municipalidad Distrital de Jesús Maria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1581	301263	150114	Municipalidad Distrital de la Molina	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1582	301264	150115	Municipalidad Distrital de la Victoria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1583	301265	150116	Municipalidad Distrital de Lince	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1584	301266	150117	Municipalidad Distrital de los Olivos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1585	301267	150118	Municipalidad Distrital de Lurigancho (Chosica)	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1586	301268	150119	Municipalidad Distrital de Lurin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1587	301269	150120	Municipalidad Distrital de Magdalena del Mar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1588	301270	150121	Municipalidad Distrital de Pueblo Libre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1589	301271	150122	Municipalidad Distrital de Miraflores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1590	301272	150123	Municipalidad Distrital de Pachacamac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1591	301273	150124	Municipalidad Distrital de Pucusana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1592	301274	150125	Municipalidad Distrital de Puente Piedra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1593	301275	150126	Municipalidad Distrital de Punta Hermosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1594	301276	150127	Municipalidad Distrital de Punta Negra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1595	301277	150128	Municipalidad Distrital de Rimac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1596	301278	150129	Municipalidad Distrital de San Bartolo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1597	301279	150130	Municipalidad Distrital de San Borja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1598	301280	150131	Municipalidad Distrital de San Isidro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1599	301281	150132	Municipalidad Distrital de San Juan de Lurigancho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1600	301282	150133	Municipalidad Distrital de San Juan de Miraflores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1601	301283	150134	Municipalidad Distrital de San Luis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1602	301284	150135	Municipalidad Distrital de San Martín de Porres	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1603	301285	150136	Municipalidad Distrital de San Miguel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1604	301286	150137	Municipalidad Distrital de Santa Anita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1605	301287	150138	Municipalidad Distrital de Santa María del Mar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1606	301288	150139	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1607	301289	150140	Municipalidad Distrital de Santiago de Surco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1608	301290	150141	Municipalidad Distrital de Surquillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1609	301291	150142	Municipalidad Distrital de Villa el Salvador	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1610	301292	150143	Municipalidad Distrital de Villa María del Triunfo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1611	301294	150201	Municipalidad Provincial de Barranca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1612	301295	150202	Municipalidad Distrital de Paramonga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1613	301296	150203	Municipalidad Distrital de Pativilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1614	301297	150204	Municipalidad Distrital de Supe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1615	301298	150205	Municipalidad Distrital de Supe Puerto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1616	301299	150301	Municipalidad Provincial de Cajatambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1617	301300	150302	Municipalidad Distrital de Copa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1618	301301	150303	Municipalidad Distrital de Gorgor	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1619	301302	150304	Municipalidad Distrital de Huancapon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1620	301303	150305	Municipalidad Distrital de Manas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1621	301304	150401	Municipalidad Provincial de Canta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1622	301305	150402	Municipalidad Distrital de Arahuay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1623	301306	150403	Municipalidad Distrital de Huamantanga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1624	301307	150404	Municipalidad Distrital de Huaros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1625	301308	150405	Municipalidad Distrital de Lachaqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1626	301309	150406	Municipalidad Distrital de San Buenaventura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1627	301310	150407	Municipalidad Distrital de Santa Rosa de Quives	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1628	301311	150501	Municipalidad Provincial de Cañete - San Vicente de Cañete	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1629	301312	150502	Municipalidad Distrital de Asia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1630	301313	150503	Municipalidad Distrital de Calango	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1631	301314	150504	Municipalidad Distrital de Cerro Azul	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1632	301315	150505	Municipalidad Distrital de Chilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1633	301316	150506	Municipalidad Distrital de Coayllo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1634	301317	150507	Municipalidad Distrital de Imperial	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1635	301318	150508	Municipalidad Distrital de Lunahuana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1636	301319	150509	Municipalidad Distrital de Mala	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1637	301320	150510	Municipalidad Distrital de Nuevo Imperial	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1638	301321	150511	Municipalidad Distrital de Pacaran	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1639	301322	150512	Municipalidad Distrital de Quilmana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1640	301323	150513	Municipalidad Distrital de San Antonio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1641	301324	150514	Municipalidad Distrital de San Luis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1642	301325	150515	Municipalidad Distrital de Santa Cruz de Flores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1643	301326	150516	Municipalidad Distrital de Zuñiga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1644	301327	150601	Municipalidad Provincial de Huaral	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1645	301328	150602	Municipalidad Distrital de Atavillos Alto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1646	301329	150603	Municipalidad Distrital de Atavillos Bajo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1647	301330	150604	Municipalidad Distrital de Aucallama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1648	301331	150605	Municipalidad Distrital de Chancay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1649	301332	150606	Municipalidad Distrital de Ihuari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1650	301333	150607	Municipalidad Distrital de Lampian	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1651	301334	150608	Municipalidad Distrital de Pacaraos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1652	301335	150609	Municipalidad Distrital de San Miguel de Acos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1653	301336	150610	Municipalidad Distrital de Santa Cruz de Andamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1654	301337	150611	Municipalidad Distrital de Sumbilca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1655	301338	150612	Municipalidad Distrital Veintisiete de Noviembre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1656	301339	150701	Municipalidad Provincial de Huarochiri - Matucana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1657	301340	150702	Municipalidad Distrital de Antioquia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1658	301341	150703	Municipalidad Distrital de Callahuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1659	301342	150704	Municipalidad Distrital de Carampoma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1660	301343	150705	Municipalidad Distrital de Chicla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1661	301344	150706	Municipalidad Distrital de San José de los Chorrillos - Cuenca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1662	301345	150707	Municipalidad Distrital de Huachupampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1663	301346	150708	Municipalidad Distrital de Huanza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1664	301347	150709	Municipalidad Distrital de Huarochiri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1665	301348	150710	Municipalidad Distrital de Lahuaytambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1666	301349	150711	Municipalidad Distrital de Langa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1667	301350	150712	Municipalidad Distrital de San Pedro de Laraos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1668	301351	150713	Municipalidad Distrital de Mariatana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1669	301352	150714	Municipalidad Distrital de Ricardo Palma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1670	301353	150715	Municipalidad Distrital de San Andres de Tupicocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1671	301354	150716	Municipalidad Distrital de San Antonio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1672	301355	150717	Municipalidad Distrital de San Bartolome	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1673	301356	150718	Municipalidad Distrital de San Damian	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1674	301357	150719	Municipalidad Distrital de San Juan de Iris	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1675	301358	150720	Municipalidad Distrital de San Juan de Tantaranche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1676	301359	150721	Municipalidad Distrital de San Lorenzo de Quinti	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1677	301360	150722	Municipalidad Distrital de San Mateo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1678	301361	150723	Municipalidad Distrital de San Mateo de Otao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1679	301362	150724	Municipalidad Distrital de Casta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1680	301363	150725	Municipalidad Distrital de San Pedro de Huancayre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1681	301364	150726	Municipalidad Distrital de Sangallaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1682	301365	150727	Municipalidad Distrital de Santa Cruz de Cocachacra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1683	301366	150728	Municipalidad Distrital de Santa Eulalia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1684	301367	150729	Municipalidad Distrital de Santiago de Anchucaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1685	301368	150730	Municipalidad Distrital de Santiago de Tuna	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1686	301369	150731	Municipalidad Distrital de Santo Domingo de los Olleros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1687	301370	150732	Municipalidad Distrital de Surco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1688	301371	150801	Municipalidad Provincial de Huaura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1689	301372	150802	Municipalidad Distrital de Ambar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1690	301373	150803	Municipalidad Distrital de Caleta de Carquin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1691	301374	150804	Municipalidad Distrital de Checras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1692	301375	150805	Municipalidad Distrital de Hualmay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1693	301376	150806	Municipalidad Distrital de Huaura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1694	301377	150807	Municipalidad Distrital de Leoncio Prado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1695	301378	150808	Municipalidad Distrital de Paccho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1696	301379	150809	Municipalidad Distrital de Santa Leonor	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1697	301380	150810	Municipalidad Distrital de Santa Maria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1698	301381	150811	Municipalidad Distrital de Sayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1699	301382	150812	Municipalidad Distrital de Vegueta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1700	301383	150901	Municipalidad Provincial de Oyon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1701	301384	150902	Municipalidad Distrital de Andajes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1702	301385	150903	Municipalidad Distrital de Caujul	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1703	301386	150904	Municipalidad Distrital de Cochamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1704	301387	150905	Municipalidad Distrital de Navan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1705	301388	150906	Municipalidad Distrital de Pachangara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1706	301389	151001	Municipalidad Provincial de Yauyos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1707	301390	151002	Municipalidad Distrital de Alis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1708	301391	151003	Municipalidad Distrital de Ayauca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1709	301392	151004	Municipalidad Distrital de Ayaviri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1710	301393	151005	Municipalidad Distrital de Azangaro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1711	301394	151006	Municipalidad Distrital de Cacra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1712	301395	151007	Municipalidad Distrital de Carania	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1713	301396	151008	Municipalidad Distrital de Catahuasi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1714	301397	151009	Municipalidad Distrital de Chocos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1715	301398	151010	Municipalidad Distrital de Cochas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1716	301399	151011	Municipalidad Distrital de Colonia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1717	301400	151012	Municipalidad Distrital de Hongos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1718	301401	151013	Municipalidad Distrital de Huampara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1719	301402	151014	Municipalidad Distrital de Huancaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1720	301403	151015	Municipalidad Distrital de Huangascar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1721	301404	151016	Municipalidad Distrital de Huantan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1722	301405	151017	Municipalidad Distrital de Huañec	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1723	301406	151018	Municipalidad Distrital de Laraos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1724	301407	151019	Municipalidad Distrital de Lincha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1725	301408	151020	Municipalidad Distrital de Madean	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1726	301409	151021	Municipalidad Distrital de Miraflores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1727	301410	151022	Municipalidad Distrital de Omas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1728	301411	151023	Municipalidad Distrital de Putinza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1729	301412	151024	Municipalidad Distrital de Quinches	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1730	301413	151025	Municipalidad Distrital de Quinocay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1731	301414	151026	Municipalidad Distrital de San Joaquin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1732	301415	151027	Municipalidad Distrital de San Pedro de Pilas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1733	301416	151028	Municipalidad Distrital de Tanta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1734	301417	151029	Municipalidad Distrital de Tauripampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1735	301418	151030	Municipalidad Distrital de Tomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1736	301419	151031	Municipalidad Distrital de Tupe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1737	301420	151032	Municipalidad Distrital de Viñac	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1738	301421	151033	Municipalidad Distrital de Vitis	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1739	301422	160101	Municipalidad Provincial de Maynas - Iquitos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1740	301423	160102	Municipalidad Distrital de Alto Nanay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1741	301424	160103	Municipalidad Distrital de Fernando Lores	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1742	301425	160104	Municipalidad Distrital de Indiana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1743	301426	160105	Municipalidad Distrital de las Amazonas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1744	301427	160106	Municipalidad Distrital de Mazan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1745	301428	160107	Municipalidad Distrital de Napo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1746	301429	160108	Municipalidad Distrital de Punchana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1747	301431	160110	Municipalidad Distrital de Torres Causana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1748	301432	160112	Municipalidad Distrital de Belen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1749	301433	160113	Municipalidad Distrital de San Juan Bautista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1750	301434	160201	Municipalidad Provincial del Alto Amazonas - Yurimaguas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1751	301435	160202	Municipalidad Distrital de Balsapuerto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1752	301438	160205	Municipalidad Distrital de Jeberos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1753	301439	160206	Municipalidad Distrital de Lagunas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1754	301443	160210	Municipalidad Distrital de Santa Cruz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1755	301444	160211	Municipalidad Distrital de Teniente Cesar López Rojas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1756	301445	160301	Municipalidad Provincial de Loreto - Nauta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1757	301446	160302	Municipalidad Distrital de Parinari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1758	301447	160303	Municipalidad Distrital de Tigre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1759	301448	160304	Municipalidad Distrital de Trompeteros	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1760	301449	160305	Municipalidad Distrital de Urarinas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1761	301450	160401	Municipalidad Provincial de Mariscal Ramón Castilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1762	301451	160402	Municipalidad Distrital de Pevas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1763	301452	160403	Municipalidad Distrital de Yavari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1764	301453	160404	Municipalidad Distrital de San Pablo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1765	301454	160501	Municipalidad Provincial de Requena	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1766	301455	160502	Municipalidad Distrital de Alto Tapiche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1767	301456	160503	Municipalidad Distrital de Capelo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1768	301457	160504	Municipalidad Distrital de Emilio San Martín	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1769	301458	160505	Municipalidad Distrital de Maquia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1770	301459	160506	Municipalidad Distrital de Puinahua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1771	301460	160507	Municipalidad Distrital de Saquena	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1772	301461	160508	Municipalidad Distrital de Soplin	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1773	301462	160509	Municipalidad Distrital de Tapiche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1774	301463	160510	Municipalidad Distrital de Jenaro Herrera	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1775	301464	160511	Municipalidad Distrital de Yaquerana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1776	301465	160601	Municipalidad Provincial de Ucayali - Contamana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1777	301466	160602	Municipalidad Distrital de Inahuaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1778	301467	160603	Municipalidad Distrital de Padre Marquez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1779	301468	160604	Municipalidad Distrital de Pampa Hermoza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1780	301469	160605	Municipalidad Distrital de Sarayacu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1781	301470	160606	Municipalidad Distrital de Vargas Guerra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1782	301436	160701	Municipalidad Provincial de Datem del Marañon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1783	301437	160702	Municipalidad Distrital de Cahuapanas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1784	301440	160703	Municipalidad Distrital de Manseriche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1785	301441	160704	Municipalidad Distrital de Morona	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1786	301442	160705	Municipalidad Distrital de Pastaza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1787	301842	160706	Municipalidad Distrital de Andoas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1788	301854	160801	Municipalidad Provincial de Putumayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1789	301856	160802	Municipalidad Distrital de Rosa Panduro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1790	301855	160803	Municipalidad Distrital de Teniente Manuel Clavero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1791	301857	160804	Municipalidad Distrital de Yaguas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1792	301471	170101	Municipalidad Provincial de Tambopata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1793	301472	170102	Municipalidad Distrital de Inambari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1794	301473	170103	Municipalidad Distrital de las Piedras	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1795	301474	170104	Municipalidad Distrital de Laberinto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1796	301475	170201	Municipalidad Provincial de Manu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1797	301476	170202	Municipalidad Distrital de Fitzcarrald	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1798	301477	170203	Municipalidad Distrital de Madre de Dios	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1799	301836	170204	Municipalidad Distrital de Huepetuhe	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1800	301478	170301	Municipalidad Provincial de Tahuamanu - Iñapari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1801	301479	170302	Municipalidad Distrital de Iberia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1802	301480	170303	Municipalidad Distrital de Tahuamanu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1803	301481	180101	Municipalidad Provincial de Mariscal Nieto - Moquegua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1804	301482	180102	Municipalidad Distrital de Carumas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1805	301483	180103	Municipalidad Distrital de Cuchumbaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1806	301484	180104	Municipalidad Distrital de Samegua	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1807	301485	180105	Municipalidad Distrital de San Cristobal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1808	301486	180106	Municipalidad Distrital de Torata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1809	301901	180107	Municipalidad Distrital de San Antonio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1810	301487	180201	Municipalidad Provincial de Sánchez Cerro - Omate	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1811	301488	180202	Municipalidad Distrital de Chojata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1812	301489	180203	Municipalidad Distrital de Coalaque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1813	301490	180204	Municipalidad Distrital de Ichuña	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1814	301491	180205	Municipalidad Distrital de la Capilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1815	301492	180206	Municipalidad Distrital de Lloque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1816	301493	180207	Municipalidad Distrital de Matalaque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1817	301494	180208	Municipalidad Distrital de Puquina	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1818	301495	180209	Municipalidad Distrital de Quinistaquillas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1819	301496	180210	Municipalidad Distrital de Ubinas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1820	301497	180211	Municipalidad Distrital de Yunga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1821	301498	180301	Municipalidad Provincial de Ilo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1822	301499	180302	Municipalidad Distrital de El Algarrobal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1823	301500	180303	Municipalidad Distrital de Pacocha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1824	301501	190101	Municipalidad Provincial de Pasco - Chaupimarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1825	301502	190102	Municipalidad Distrital de Huachon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1826	301503	190103	Municipalidad Distrital de Huariaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1827	301504	190104	Municipalidad Distrital de Huayllay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1828	301505	190105	Municipalidad Distrital de Ninacaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1829	301506	190106	Municipalidad Distrital de Pallanchacra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1830	301507	190107	Municipalidad Distrital de Paucartambo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1831	301508	190108	Municipalidad Distrital de San Francisco de Asís de Yarusyacan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1832	301509	190109	Municipalidad Distrital de Simón Bolivar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1833	301510	190110	Municipalidad Distrital de Ticlacayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1834	301511	190111	Municipalidad Distrital de Tinyahuarco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1835	301512	190112	Municipalidad Distrital de Vicco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1836	301513	190113	Municipalidad Distrital de Yanacancha	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1837	301514	190201	Municipalidad Provincial de Daniel A. Carrión - Yanahuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1838	301515	190202	Municipalidad Distrital de Chacayan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1839	301516	190203	Municipalidad Distrital de Goyllarisquizga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1840	301517	190204	Municipalidad Distrital de Paucar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1841	301518	190205	Municipalidad Distrital de San Pedro de Pillao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1842	301519	190206	Municipalidad Distrital de Santa Ana de Tusi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1843	301520	190207	Municipalidad Distrital de Tapuc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1844	301521	190208	Municipalidad Distrital de Vilcabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1845	301522	190301	Municipalidad Provincial de Oxapampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1846	301523	190302	Municipalidad Distrital de Chontabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1847	301524	190303	Municipalidad Distrital de Huancabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1848	301525	190304	Municipalidad Distrital de Palcazu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1849	301526	190305	Municipalidad Distrital de Pozuzo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1850	301527	190306	Municipalidad Distrital de Puerto Bermudez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1851	301528	190307	Municipalidad Distrital de Villa Rica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1852	301847	190308	Municipalidad Distrital de Constitucion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1853	301529	200101	Municipalidad Provincial de Piura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1854	301530	200104	Municipalidad Distrital de Castilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1855	301531	200105	Municipalidad Distrital de Catacaos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1856	301532	200107	Municipalidad Distrital de Cura Mori	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1857	301533	200108	Municipalidad Distrital de El Tallan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1858	301534	200109	Municipalidad Distrital de la Arena	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1859	301535	200110	Municipalidad Distrital de la Union	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1860	301536	200111	Municipalidad Distrital de las Lomas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1861	301537	200114	Municipalidad Distrital de Tambo Grande	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1862	301849	200115	Municipalidad Distrital Veintiséis de Octubre	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1863	301538	200201	Municipalidad Provincial de Ayabaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1864	301539	200202	Municipalidad Distrital de Frias	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1865	301540	200203	Municipalidad Distrital de Jilili	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1866	301541	200204	Municipalidad Distrital de Lagunas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1867	301542	200205	Municipalidad Distrital de Montero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1868	301543	200206	Municipalidad Distrital de Pacaipampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1869	301544	200207	Municipalidad Distrital de Paimas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1870	301545	200208	Municipalidad Distrital de Sapillica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1871	301546	200209	Municipalidad Distrital de Sicchez	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1872	301547	200210	Municipalidad Distrital de Suyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1873	301548	200301	Municipalidad Provincial de Huancabamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1874	301549	200302	Municipalidad Distrital de Canchaque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1875	301550	200303	Municipalidad Distrital de el Carmen de la Frontera	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1876	301551	200304	Municipalidad Distrital de Huarmaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1877	301552	200305	Municipalidad Distrital de Lalaquiz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1878	301553	200306	Municipalidad Distrital de San Miguel de El Faique	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1879	301554	200307	Municipalidad Distrital de Sondor	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1880	301555	200308	Municipalidad Distrital de Sondorillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1881	301556	200401	Municipalidad Provincial de Morropón - Chulucanas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1882	301557	200402	Municipalidad Distrital de Buenos Aires	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1883	301558	200403	Municipalidad Distrital de Chalaco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1884	301559	200404	Municipalidad Distrital de la Matanza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1885	301560	200405	Municipalidad Distrital de Morropon	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1886	301561	200406	Municipalidad Distrital de Salitral	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1887	301562	200407	Municipalidad Distrital de San Juan de Bigote	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1888	301563	200408	Municipalidad Distrital de Santa Catalina de Mossa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1889	301564	200409	Municipalidad Distrital de Santo Domingo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1890	301565	200410	Municipalidad Distrital de Yamango	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1891	301566	200501	Municipalidad Provincial de Paita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1892	301567	200502	Municipalidad Distrital de Amotape	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1893	301568	200503	Municipalidad Distrital de el Arenal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1894	301569	200504	Municipalidad Distrital de Colan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1895	301570	200505	Municipalidad Distrital de la Huaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1896	301571	200506	Municipalidad Distrital de Tamarindo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1897	301572	200507	Municipalidad Distrital de Vichayal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1898	301573	200601	Municipalidad Provincial de Sullana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1899	301574	200602	Municipalidad Distrital de Bellavista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1900	301575	200603	Municipalidad Distrital de Ignacio Escudero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1901	301576	200604	Municipalidad Distrital de Lancones	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1902	301577	200605	Municipalidad Distrital de Marcavelica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1903	301578	200606	Municipalidad Distrital de Miguel Checa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1904	301579	200607	Municipalidad Distrital de Querecotillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1905	301580	200608	Municipalidad Distrital de Salitral	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1906	301581	200701	Municipalidad Provincial de Talara - Pariñas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1907	301582	200702	Municipalidad Distrital de el Alto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1908	301583	200703	Municipalidad Distrital de la Brea	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1909	301584	200704	Municipalidad Distrital de Lobitos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1910	301585	200705	Municipalidad Distrital de los Organos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1911	301586	200706	Municipalidad Distrital de Mancora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1912	301587	200801	Municipalidad Provincial de Sechura	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1913	301588	200802	Municipalidad Distrital de Bellavista de la Union	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1914	301589	200803	Municipalidad Distrital de Bernal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1915	301590	200804	Municipalidad Distrital de Cristo Nos Valga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1916	301591	200805	Municipalidad Distrital de Vice	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1917	301592	200806	Municipalidad Distrital de Rinconada Llicuar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1918	301593	210101	Municipalidad Provincial de Puno	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1919	301594	210102	Municipalidad Distrital de Acora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1920	301595	210103	Municipalidad Distrital de Amantani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1921	301596	210104	Municipalidad Distrital de Atuncolla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1922	301597	210105	Municipalidad Distrital de Capachica	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1923	301598	210106	Municipalidad Distrital de Chucuito	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1924	301599	210107	Municipalidad Distrital de Coata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1925	301600	210108	Municipalidad Distrital Huata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1926	301601	210109	Municipalidad Distrital de Mañazo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1927	301602	210110	Municipalidad Distrital de Paucarcolla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1928	301603	210111	Municipalidad Distrital de Pichacani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1929	301604	210112	Municipalidad Distrital de Plateria	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1930	301605	210113	Municipalidad Distrital de San Antonio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1931	301606	210114	Municipalidad Distrital de Tiquillaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1932	301607	210115	Municipalidad Distrital de Vilque	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1933	301608	210201	Municipalidad Provincial de Azangaro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1934	301609	210202	Municipalidad Distrital de Achaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1935	301610	210203	Municipalidad Distrital de Arapa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1936	301611	210204	Municipalidad Distrital de Asillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1937	301612	210205	Municipalidad Distrital de Caminaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1938	301613	210206	Municipalidad Distrital de Chupa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1939	301614	210207	Municipalidad Distrital de José Domingo Choquehuanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1940	301615	210208	Municipalidad Distrital de Muñani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1941	301616	210209	Municipalidad Distrital de Potoni	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1942	301617	210210	Municipalidad Distrital de Saman	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1943	301618	210211	Municipalidad Distrital de San Anton	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1944	301619	210212	Municipalidad Distrital de San José	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1945	301620	210213	Municipalidad Distrital de San Juan de Salinas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1946	301621	210214	Municipalidad Distrital de Santiago de Pupuja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1947	301622	210215	Municipalidad Distrital de Tirapata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1948	301623	210301	Municipalidad Provincial de Carabaya - Macusani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1949	301624	210302	Municipalidad Distrital de Ajoyani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1950	301625	210303	Municipalidad Distrital de Ayapata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1951	301626	210304	Municipalidad Distrital de Coasa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1952	301627	210305	Municipalidad Distrital de Corani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1953	301628	210306	Municipalidad Distrital de Crucero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1954	301629	210307	Municipalidad Distrital de Ituata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1955	301630	210308	Municipalidad Distrital de Ollachea	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1956	301631	210309	Municipalidad Distrital de San Gaban	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1957	301632	210310	Municipalidad Distrital de Usicayos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1958	301633	210401	Municipalidad Provincial de Chucuito - Juli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1959	301634	210402	Municipalidad Distrital de Desaguadero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1960	301635	210403	Municipalidad Distrital de Huacullani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1961	301636	210404	Municipalidad Distrital de Kelluyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1962	301637	210405	Municipalidad Distrital de Pisacoma	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1963	301638	210406	Municipalidad Distrital de Pomata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1964	301639	210407	Municipalidad Distrital de Zepita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1965	301640	210501	Municipalidad Provincial el Collao - Ilave	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1966	301641	210502	Municipalidad Distrital de Capaso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1967	301642	210503	Municipalidad Distrital de Pilcuyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1968	301643	210504	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1969	301644	210505	Municipalidad Distrital de Conduriri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1970	301645	210601	Municipalidad Provincial de Huancane	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1971	301646	210602	Municipalidad Distrital de Cojata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1972	301647	210603	Municipalidad Distrital de Huatasani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1973	301648	210604	Municipalidad Distrital de Inchupalla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1974	301649	210605	Municipalidad Distrital de Pusi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1975	301650	210606	Municipalidad Distrital de Rosaspata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1976	301651	210607	Municipalidad Distrital de Taraco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1977	301652	210608	Municipalidad Distrital de Vilque Chico	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1978	301653	210701	Municipalidad Provincial de Lampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1979	301654	210702	Municipalidad Distrital de Cabanilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1980	301655	210703	Municipalidad Distrital de Calapuja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1981	301656	210704	Municipalidad Distrital de Nicasio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1982	301657	210705	Municipalidad Distrital de Ocuviri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1983	301658	210706	Municipalidad Distrital de Palca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1984	301659	210707	Municipalidad Distrital de Paratia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1985	301660	210708	Municipalidad Distrital de Pucara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1986	301661	210709	Municipalidad Distrital de Santa Lucia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1987	301662	210710	Municipalidad Distrital de Vilavila	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1988	301663	210801	Municipalidad Provincial de Melgar - Ayaviri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1989	301664	210802	Municipalidad Distrital de Antauta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1990	301665	210803	Municipalidad Distrital de Cupi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1991	301666	210804	Municipalidad Distrital de Llalli	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1992	301667	210805	Municipalidad Distrital de Macari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1993	301668	210806	Municipalidad Distrital de Nuñoa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1994	301669	210807	Municipalidad Distrital de Orurillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1995	301670	210808	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1996	301671	210809	Municipalidad Distrital de Umachiri	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1997	301672	210901	Municipalidad Provincial de Moho	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1998	301673	210902	Municipalidad Distrital de Conima	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
1999	301674	210903	Municipalidad Distrital de Huayrapata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2000	301675	210904	Municipalidad Distrital de Tilali	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2001	301676	211001	Municipalidad Provincial de San Antonio de Putina	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2002	301677	211002	Municipalidad Distrital de Ananea	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2003	301678	211003	Municipalidad Distrital de Pedro Vilca Apaza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2004	301679	211004	Municipalidad Distrital de Quilcapuncu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2005	301680	211005	Municipalidad Distrital de Sina	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2006	301681	211101	Municipalidad Provincial de San Roman - Juliaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2007	301682	211102	Municipalidad Distrital de Cabana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2008	301683	211103	Municipalidad Distrital de Cabanillas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2009	301684	211104	Municipalidad Distrital de Caracoto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2010	301886	211105	Municipalidad Distrital de San Miguel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2011	301685	211201	Municipalidad Provincial de Sandia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2012	301686	211202	Municipalidad Distrital de Cuyocuyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2013	301687	211203	Municipalidad Distrital de Limbani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2014	301688	211204	Municipalidad Distrital de Patambuco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2015	301689	211205	Municipalidad Distrital de Phara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2016	301690	211206	Municipalidad Distrital de Quiaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2017	301691	211207	Municipalidad Distrital de San Juan del Oro	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2018	301692	211208	Municipalidad Distrital de Yanahuaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2019	301693	211209	Municipalidad Distrital de Alto Inambari	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2020	301841	211210	Municipalidad Distrital de San Pedro de Putina Punco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2021	301694	211301	Municipalidad Provincial de Yunguyo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2022	301695	211302	Municipalidad Distrital de Anapia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2023	301696	211303	Municipalidad Distrital de Copani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2024	301697	211304	Municipalidad Distrital de Cuturapi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2025	301698	211305	Municipalidad Distrital de Ollaraya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2026	301699	211306	Municipalidad Distrital de Tinicachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2027	301700	211307	Municipalidad Distrital de Unicachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2028	301701	220101	Municipalidad Provincial de Moyobamba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2029	301702	220102	Municipalidad Distrital de Calzada	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2030	301703	220103	Municipalidad Distrital de Habana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2031	301704	220104	Municipalidad Distrital de Jepelacio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2032	301705	220105	Municipalidad Distrital de Soritor	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2033	301706	220106	Municipalidad Distrital de Yantalo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2034	301707	220201	Municipalidad Provincial de Bellavista	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2035	301708	220202	Municipalidad Distrital de Alto Biavo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2036	301709	220203	Municipalidad Distrital de Bajo Biavo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2037	301710	220204	Municipalidad Distrital de Huallaga	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2038	301711	220205	Municipalidad Distrital de San Pablo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2039	301712	220206	Municipalidad Distrital de San Rafael	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2040	301713	220301	Municipalidad Provincial de el Dorado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2041	301714	220302	Municipalidad Distrital de Agua Blanca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2042	301715	220303	Municipalidad Distrital de San Martín	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2043	301716	220304	Municipalidad Distrital de Santa Rosa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2044	301717	220305	Municipalidad Distrital de Shatoja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2045	301718	220401	Municipalidad Provincial de Huallaga - Saposoa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2046	301719	220402	Municipalidad Distrital de Alto Saposoa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2047	301720	220403	Municipalidad Distrital de El Eslabón	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2048	301721	220404	Municipalidad Distrital de Piscoyacu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2049	301722	220405	Municipalidad Distrital de Sacanche	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2050	301723	220406	Municipalidad Distrital de Tingo de Saposoa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2051	301724	220501	Municipalidad Provincial de Lamas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2052	301725	220502	Municipalidad Distrital de Alonso de Alvarado	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2053	301726	220503	Municipalidad Distrital de Barranquita	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2054	301727	220504	Municipalidad Distrital de Caynarachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2055	301728	220505	Municipalidad Distrital de Cuñumbuqui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2056	301729	220506	Municipalidad Distrital de Pinto Recodo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2057	301730	220507	Municipalidad Distrital de Rumisapa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2058	301731	220508	Municipalidad Distrital de San Roque de Cumbaza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2059	301732	220509	Municipalidad Distrital de Shanao	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2060	301733	220510	Municipalidad Distrital de Tabalosos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2061	301734	220511	Municipalidad Distrital de Zapatero	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2062	301735	220601	Municipalidad Provincial de Mariscal Cáceres - Juanjui	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2063	301736	220602	Municipalidad Distrital de Campanilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2064	301737	220603	Municipalidad Distrital de Huicungo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2065	301738	220604	Municipalidad Distrital de Pachiza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2066	301739	220605	Municipalidad Distrital de Pajarillo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2067	301740	220701	Municipalidad Provincial de Picota	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2068	301741	220702	Municipalidad Distrital de Buenos Aires	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2069	301742	220703	Municipalidad Distrital de Caspisapa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2070	301743	220704	Municipalidad Distrital de Pilluana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2071	301744	220705	Municipalidad Distrital de Pucacaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2072	301745	220706	Municipalidad Distrital de San Cristobal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2073	301746	220707	Municipalidad Distrital de San Hilarion	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2074	301747	220708	Municipalidad Distrital de Shamboyacu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2075	301748	220709	Municipalidad Distrital de Tingo de Ponasa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2076	301749	220710	Municipalidad Distrital de Tres Unidos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2077	301750	220801	Municipalidad Provincial de Rioja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2078	301751	220802	Municipalidad Distrital de Awajun	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2079	301752	220803	Municipalidad Distrital de Elías Soplin Vargas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2080	301753	220804	Municipalidad Distrital de Nueva Cajamarca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2081	301754	220805	Municipalidad Distrital de Pardo Miguel	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2082	301755	220806	Municipalidad Distrital de Posic	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2083	301756	220807	Municipalidad Distrital de San Fernando	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2084	301757	220808	Municipalidad Distrital de Yorongos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2085	301758	220809	Municipalidad Distrital de Yuracyacu	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2086	301759	220901	Municipalidad Provincial de San Martín - Tarapoto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2087	301760	220902	Municipalidad Distrital de Alberto Leveau	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2088	301761	220903	Municipalidad Distrital de Cacatachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2089	301762	220904	Municipalidad Distrital de Chazuta	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2090	301763	220905	Municipalidad Distrital de Chipurana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2091	301764	220906	Municipalidad Distrital de El Porvenir	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2092	301765	220907	Municipalidad Distrital de Huimbayoc	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2093	301766	220908	Municipalidad Distrital de Juan Guerra	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2094	301767	220909	Municipalidad Distrital de la Banda de Shilcayo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2095	301768	220910	Municipalidad Distrital de Morales	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2096	301769	220911	Municipalidad Distrital de Papaplaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2097	301770	220912	Municipalidad Distrital de San Antonio	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2098	301771	220913	Municipalidad Distrital de Sauce	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2099	301772	220914	Municipalidad Distrital de Shapaja	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2100	301773	221001	Municipalidad Provincial de Tocache	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2101	301774	221002	Municipalidad Distrital de Nuevo Progreso	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2102	301775	221003	Municipalidad Distrital de Polvora	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2103	301776	221004	Municipalidad Distrital de Shunte	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2104	301777	221005	Municipalidad Distrital de Uchiza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2105	301897	221006	Municipalidad Distrital de Santa Lucia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2106	301778	230101	Municipalidad Provincial de Tacna	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2107	301779	230102	Municipalidad Distrital de Alto de la Alianza	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2108	301780	230103	Municipalidad Distrital de Calana	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2109	301781	230104	Municipalidad Distrital de Ciudad Nueva	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2110	301782	230105	Municipalidad Distrital de Inclan	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2111	301783	230106	Municipalidad Distrital de Pachia	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2112	301784	230107	Municipalidad Distrital de Palca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2113	301785	230108	Municipalidad Distrital de Pocollay	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2114	301786	230109	Municipalidad Distrital de Sama	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2115	301838	230110	Municipalidad Distrital de Coronel Gregorio Albarracín Lanchipa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2116	301869	230111	Municipalidad Distrital de la Yarada los Palos	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2117	301787	230201	Municipalidad Provincial de Candarave	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2118	301788	230202	Municipalidad Distrital de Cairani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2119	301789	230203	Municipalidad Distrital de Camilaca	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2120	301790	230204	Municipalidad Distrital de Curibaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2121	301791	230205	Municipalidad Distrital de Huanuara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2122	301792	230206	Municipalidad Distrital de Quilahuani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2123	301793	230301	Municipalidad Provincial de Jorge Basadre - Locumba	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2124	301794	230302	Municipalidad Distrital de Ilabaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2125	301795	230303	Municipalidad Distrital de Ite	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2126	301796	230401	Municipalidad Provincial de Tarata	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2127	301797	230402	Municipalidad Distrital Héroes Albarracín - Chucatamani	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2128	301798	230403	Municipalidad Distrital de Estique	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2129	301799	230404	Municipalidad Distrital de Estique Pampa	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2130	301800	230405	Municipalidad Distrital de Sitajara	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2131	301801	230406	Municipalidad Distrital de Susapaya	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2132	301802	230407	Municipalidad Distrital de Tarucachi	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2133	301803	230408	Municipalidad Distrital de Ticaco	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2134	301804	240101	Municipalidad Provincial de Tumbes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2135	301805	240102	Municipalidad Distrital de Corrales	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2136	301806	240103	Municipalidad Distrital de la Cruz	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2137	301807	240104	Municipalidad Distrital de Pampas de Hospital	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2138	301808	240105	Municipalidad Distrital de San Jacinto	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2139	301809	240106	Municipalidad Distrital de San Juan de la Virgen	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2140	301810	240201	Municipalidad Provincial de Contralmirante Villar	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2141	301811	240202	Municipalidad Distrital de Casitas	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2142	301843	240203	Municipalidad Distrital Canoas de Punta Sal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2143	301812	240301	Municipalidad Provincial de Zarumilla	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2144	301813	240302	Municipalidad Distrital de Aguas Verdes	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2145	301814	240303	Municipalidad Distrital de Matapalo	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2146	301815	240304	Municipalidad Distrital de Papayal	\N	\N	\N	\N	1	t	41	1	2025-08-01 00:00:00-05	\N	\N
2147	\N	\N	Empresa Regional de Servicio Público de Electricidad de Puno S.A.A.	\N	\N	ELECTRO PUNO S.A.A	\N	1	t	22	1	2025-11-19 00:00:00-05	\N	\N
2148	\N	\N	Proyecto Especial CHAVIMOCHIC	\N	\N	PROYECTO CHAVIMOCHIC	\N	1	t	40	1	2025-11-27 00:00:00-05	\N	\N
2149	\N	\N	Fondo de Aseguramiento en Salud de la Policía Nacional del Perú	\N	\N	SALUDPOL	\N	1	t	81	1	2026-01-06 00:00:00-05	\N	\N
2150	\N	\N	Activos Mineros S.A.C	\N	\N	AMSAC	\N	1	t	174	1	2026-01-06 00:00:00-05	\N	\N
2151	\N	\N	Servicio de Parques de Lima	\N	\N	SERPAR Lima	\N	1	t	267	1	2026-01-06 00:00:00-05	\N	\N
2152	\N	\N	Instituto Nacional de Salud del Niño de San Borja	\N	\N	INSNSB	\N	1	t	159	1	2026-01-06 00:00:00-05	\N	\N
2153	\N	\N	Programa Nacional de Becas y Crédito Educativo	\N	\N	PRONABEC	\N	1	t	97	1	2026-01-06 00:00:00-05	\N	\N
\.


--
-- TOC entry 5877 (class 0 OID 373832)
-- Dependencies: 233
-- Data for Name: def_perfiles; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_perfiles (id, nombre, estado, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	Administrador	t	1	2025-08-01 00:00:00-05	\N	\N
2	Coordinador	t	1	2025-08-01 00:00:00-05	\N	\N
3	Especialista	t	1	2025-08-01 00:00:00-05	\N	\N
4	Gestor de información	t	1	2025-08-01 00:00:00-05	\N	\N
\.


--
-- TOC entry 5879 (class 0 OID 373844)
-- Dependencies: 235
-- Data for Name: def_personas; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_personas (id, id_tipo_documento, numero_documento, nombres_apellidos, celular, fotografia, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	0	00000000	Super administrador	\N	\N	1	2025-08-15 00:00:00-05	\N	\N
2	1	41140454	Darwin Denis Quispe Llancacuro	984723609	\N	1	2025-08-15 00:00:00-05	\N	\N
3	1	10422958	Mario Richard Flores Hinostroza	991666195	\N	1	2025-08-15 00:00:00-05	\N	\N
4	1	40178103	Connie Judith Castro Gutierrez	958966678	\N	1	2025-08-15 00:00:00-05	\N	\N
5	1	46900886	Luis Eloy Rodriguez Canchaya	948713373	\N	1	2025-08-15 00:00:00-05	\N	\N
6	1	43124813	Luis Amos Valer Villegas	961241598	\N	1	2025-08-15 00:00:00-05	\N	\N
\.


--
-- TOC entry 5889 (class 0 OID 373943)
-- Dependencies: 245
-- Data for Name: def_servicios_geograficos; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_servicios_geograficos (id, id_capa, id_tipo_servicio, direccion_web, nombre_capa, titulo_capa, estado, id_layer, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
4	325	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Generacion_Aislada_Concesion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Generación sistemas eléctricos aislados	t	41978	1	2026-01-07 09:50:44.642837-05	\N	\N
5	245	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_institu_servir_convenios_colectivos_local_/wms?	peru_institu_servir_convenios_colectivos_local_	Convenios Colectivos - Local	t	39276	1	2026-01-07 09:50:44.642837-05	\N	\N
6	1037	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-50000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
7	709	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Junio.	t	41805	1	2026-01-07 09:50:44.642837-05	\N	\N
8	1532	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_salud_maternidad_tnv_m10a14_/wms?	peru_salud_maternidad_tnv_m10a14_	Cambio en tasa de nacidos vivos en mujeres de 10 a 14 años	t	37198	1	2026-01-07 09:50:44.642837-05	\N	\N
9	705	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_012_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Diciembre.	t	41812	1	2026-01-07 09:50:44.642837-05	\N	\N
10	94	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618170843___Casos_al_27_de_enero_del_2025/wms?	capa_000000_1848	Casos al 27 de enero del 2025	t	41070	1	2026-01-07 09:50:44.642837-05	\N	\N
11	570	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_98/05_98_002_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización del Fin de Lluvias del Departamento de Puno.	t	41765	1	2026-01-07 09:50:44.642837-05	\N	\N
12	1369	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250520123945___CEM_2024_REG/wms?	capa_000000_1735	CEM Regulares (2024)	t	40853	1	2026-01-07 09:50:44.642837-05	\N	\N
13	487	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_013_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Anual.	t	41708	1	2026-01-07 09:50:44.642837-05	\N	\N
14	191	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccpp_1_/wms?	peru_ccpp_1_	Menos de 151 Habitantes	t	765	1	2026-01-07 09:50:44.642837-05	\N	\N
15	1067	12	https://geosnirh.ana.gob.pe/server/services/Público/FajaMarginal/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Faja Marginal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
16	1560	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
17	209	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251020143300___Departamentos_Proy_2025/wms?	capa_000000_2223	Proyectada Departamentos	t	41593	1	2026-01-07 09:50:44.642837-05	\N	\N
18	1351	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_alimen_nutric_pesca_educa_2022_/wms?	peru_econo_educ_alimen_nutric_pesca_educa_2022_	Educación Alimentaria y Nutricional (PESCAEduca) - 2022	t	39051	1	2026-01-07 09:50:44.642837-05	\N	\N
19	941	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510144137___Accidentes_transito_ene_oct2023/wms?	capa_000000_840	Defunciones por accidentes de tránsito	t	39672	1	2026-01-07 09:50:44.642837-05	\N	\N
20	819	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Económica o Patrimonial (18 – 59 años)	t	27710	1	2026-01-07 09:50:44.642837-05	\N	\N
21	1238	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_puentes/wms?service=wms&request=GetCapabilities	0	Puentes	t	35828	1	2026-01-07 09:50:44.642837-05	\N	\N
22	1420	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250717103929___Capa8_Pais_Tambos_Mayo2025/wms?	capa_000000_1952	PAIS (TAMBOS)	t	41217	1	2026-01-07 09:50:44.642837-05	\N	\N
23	1387	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241127172716___1_Pob_con_sin_discapacidad_censo2017/wms?	capa_000000_1441	% Población por sexo (2017)	t	40458	1	2026-01-07 09:50:44.642837-05	\N	\N
24	1484	11	http://ide.regionmadrededios.gob.pe/geoserver/forestal/unidad_aprov/wms?service=WMS&request=GetCapabilities	0	Unidades de Aprovechamiento	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
25	692	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_02/11_02_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Maiz	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
26	74	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619093245___Casos_al_21_de_abril_del_2025/wms?	capa_000000_1859	Casos al 21 de abril del 2025	t	41081	1	2026-01-07 09:50:44.642837-05	\N	\N
27	1257	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_peajes_dic23/wms?service=wms&request=GetCapabilities	0	Unidades de peaje 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
28	641	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_01/02_01_003_03_001_512_1983_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 82 - 83 - Precipitación FMA	t	41557	1	2026-01-07 09:50:44.642837-05	\N	\N
29	8	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230808145720___Casos_al_02_de_junio_del_2023/wms?	capa_A00012_344	Casos al 02 de junio del 2023	t	38149	1	2026-01-07 09:50:44.642837-05	\N	\N
30	1513	11	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0802/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Conseciones	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
31	1347	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/vw_peru_inacal_tn/wms?	vw_peru_inacal_tn	Organismos de Evaluación Acreditados	t	16155	1	2026-01-07 09:50:44.642837-05	\N	\N
32	1211	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704122420___islas_islotes/wms?	capa_A00052_20	Islas e Islotes	t	41179	1	2026-01-07 09:50:44.642837-05	\N	\N
33	990	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510164637___Atendidos_INR_Proced_Edad_xdpto_2023/wms?	capa_000000_854	Pacientes INR atendidos según grupos de edad - Departamental	t	39686	1	2026-01-07 09:50:44.642837-05	\N	\N
34	235	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019RedesBajaTension/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Red de baja tensión - Tramos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
35	526	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Abril.	t	41601	1	2026-01-07 09:50:44.642837-05	\N	\N
36	1547	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_prov_/wms?	peru_epci_prov_	EPCI Provincial	t	1169	1	2026-01-07 09:50:44.642837-05	\N	\N
37	1490	11	https://portal.regionsanmartin.gob.pe:6443/arcgis/services/IDERSAM/Bosque_y_No_Bosque2019/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Bosque y No Bosque	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
38	1248	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_vecinal_dic22/wms?service=wms&request=GetCapabilities	0	Red vial vecinal 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
39	1292	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAHUARAL/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPAHUARAL	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
40	896	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250714142330___ATM_junio2025/wms?	capa_000000_1949	Cajeros Automáticos (ATM)	t	41213	1	2026-01-07 09:50:44.642837-05	\N	\N
41	868	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251112153302___Companias_set2025/wms?	capa_000000_2523	Compañías de bomberos	t	41897	1	2026-01-07 09:50:44.642837-05	\N	\N
42	751	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_013_establecimientos_penitenciarios/wfs?service=WFS&request=GetCapabilities	0	Establecimientos Penitenciarios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
43	1200	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/TOPONIMIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Toponimia - Cerro (Escala 1:500 000)	t	39453	1	2026-01-07 09:50:44.642837-05	\N	\N
44	153	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240711144458___DISTRITO_ICL/wms?	capa_000000_1012	CCL - Distrital	t	39896	1	2026-01-07 09:50:44.642837-05	\N	\N
45	595	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_07/01_07_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Eventos Olas de Calor - Primavera	t	41544	1	2026-01-07 09:50:44.642837-05	\N	\N
46	1201	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/TOPONIMIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Toponimia - Nevado (Escala 1:500 000)	t	39452	1	2026-01-07 09:50:44.642837-05	\N	\N
47	733	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Febrero.	t	41776	1	2026-01-07 09:50:44.642837-05	\N	\N
48	400	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_07/wms?request=GetCapabilities&service=WMS	0	Cambio Climático (Proyección de Disponibilidad Hídrica 2020)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
49	44	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618170731___Casos_al_13_de_enero_del_2025/wms?	capa_000000_1846	Casos al 13 de enero del 2025	t	41068	1	2026-01-07 09:50:44.642837-05	\N	\N
50	725	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_011_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Noviembre.	t	41797	1	2026-01-07 09:50:44.642837-05	\N	\N
51	934	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250626172745___Uni_Bagua/wms?	capa_000000_1931	UNIFSLB	t	41162	1	2026-01-07 09:50:44.642837-05	\N	\N
52	648	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_001_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Enero.	t	41866	1	2026-01-07 09:50:44.642837-05	\N	\N
53	645	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_004_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Abril.	t	41869	1	2026-01-07 09:50:44.642837-05	\N	\N
54	1003	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818221516___Autoempleo_Productivo_Ene_Mar_2025/wms?	capa_000000_2014	Capacitación y asistencia técnica para el autoempleo productivo (Enero - Marzo 2025)	t	41297	1	2026-01-07 09:50:44.642837-05	\N	\N
55	1251	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250926103924___Terminal_port_jun25/wms?	capa_000000_2101	Terminal Portuario	t	41442	1	2026-01-07 09:50:44.642837-05	\N	\N
56	1050	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Agrario/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Agrarios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
57	1575	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250604163442___cam_segur_mpch/wms?	capa_1304_8	Cámaras de seguridad	t	40964	1	2026-01-07 09:50:44.642837-05	\N	\N
58	1594	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
59	1182	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/INDUSTRIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Industria	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
60	405	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_13/06_13_005_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Precipitación 2050 Primavera.	t	41827	1	2026-01-07 09:50:44.642837-05	\N	\N
61	453	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_013_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Anual.	t	41725	1	2026-01-07 09:50:44.642837-05	\N	\N
62	842	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Robo de Dinero Cartera y Celular	t	26523	1	2026-01-07 09:50:44.642837-05	\N	\N
63	1000	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240923161308___Capacitacion_Laboral_Nov_Dic_2023/wms?	capa_000000_1222	Capacitación laboral (Nov - Dic 2023)	t	40157	1	2026-01-07 09:50:44.642837-05	\N	\N
64	1550	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_site_code_itp_/wms?	peru_site_code_itp_	Perimetro site code - IPT	t	8304	1	2026-01-07 09:50:44.642837-05	\N	\N
65	756	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_013_sedes_regionales/wms?service=WMS&request=GetCapabilities	0	Sedes Regionales	t	41953	1	2026-01-07 09:50:44.642837-05	\N	\N
66	1254	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_terminales_terrestres/wms?service=wms&request=GetCapabilities	0	Terminales terrestres	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
67	1238	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_puentes/wfs?service=wfs&request=GetCapabilities	0	Puentes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
68	1409	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241118151515___1_Por_Sexo_Set2024/wms?	capa_000000_1423	Por sexo	t	40430	1	2026-01-07 09:50:44.642837-05	\N	\N
69	1101	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Autorizaciones de Productos Forestales Diferentes a la Madera (PFDM) en Asociaciones Vegetales No Boscosas (AVNB)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
70	797	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	GPS- Propio y operativo	t	27691	1	2026-01-07 09:50:44.642837-05	\N	\N
71	1443	11	http://geoportal.regionamazonas.gob.pe/geoserver/geonode/cuerpos_de_agua/wms?service=WMS&request=GetCapabilities	0	Cuerpos de Agua	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
72	989	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510170839___Atendidos_INR_por_mes_prov_2023/wms?	capa_000000_858	Pacientes atendidos en el INR por mes - Nivel Provincial	t	39690	1	2026-01-07 09:50:44.642837-05	\N	\N
73	1024	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Detallado 1-10000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
74	1047	11	https://geosnirh.ana.gob.pe/server/services/Público/Acuiferos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Acuíferos	t	19415	1	2026-01-07 09:50:44.642837-05	\N	\N
75	937	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_vacunados_mayor_covid19_dist_/wms?	peru_vacunados_mayor_covid19_dist_	Adultos Mayores Vacunados	t	8488	1	2026-01-07 09:50:44.642837-05	\N	\N
76	769	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de proyectores propios y operativos	t	27682	1	2026-01-07 09:50:44.642837-05	\N	\N
77	25	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230809093509___Casos_al_07_de_julio_del_2023/wms?	capa_A00012_350	Casos al 07 de julio del 2023	t	38155	1	2026-01-07 09:50:44.642837-05	\N	\N
78	139	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721170105___EDICION_4/wms?	capa_000000_1967	Programa Niñas Digitales - Edición 4	t	41235	1	2026-01-07 09:50:44.642837-05	\N	\N
79	1057	11	https://geosnirh.ana.gob.pe/server/services/Público/CanalAduccion/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Canales de Aducción	t	38836	1	2026-01-07 09:50:44.642837-05	\N	\N
80	1216	11	http://200.60.23.226:8080/geoserver/PCM/wms?service=WMS&request=GetCapabilities	ProvContralmiranteVillar	Provincia Contralmirante Villar - Tumbes	t	8534	1	2026-01-07 09:50:44.642837-05	\N	\N
81	226	11	https://geoservicios.devida.gob.pe/arcgis_server/rest/services/Geoperu/Geoperu_v2/MapServer/1	0	Zonas Estratégicas de Intervención	t	40114	1	2026-01-07 09:50:44.642837-05	\N	\N
82	323	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Derechos_Acuicolas_Pto/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Derechos acuícolas (punto)	t	42004	1	2026-01-07 09:50:44.642837-05	\N	\N
83	169	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_viv_PITIERRA_/wms?	peru_viv_PITIERRA_	Con Piso de Tierra	t	1053	1	2026-01-07 09:50:44.642837-05	\N	\N
84	1116	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/sitios_interes_centrales_electricas_/wms?	sitios_interes_centrales_electricas_	Centrales Hidroeléctricas	t	588	1	2026-01-07 09:50:44.642837-05	\N	\N
85	1497	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/Ecosistema_Fragil/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ecosistemas frágiles	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
86	1202	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/TOPONIMIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Toponimia - Volcán (Escala 1:500 000)	t	39449	1	2026-01-07 09:50:44.642837-05	\N	\N
87	851	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/proyectos_inversion_publica_seguridad_ciudadana/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Total de Proyectos Finalizados	t	26558	1	2026-01-07 09:50:44.642837-05	\N	\N
88	665	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_02/01_02_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 5 - Tmin Extrema - Agosto	t	41523	1	2026-01-07 09:50:44.642837-05	\N	\N
89	383	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_04/04_04_007_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Mínima 03 Década del mes.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
90	672	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_02/wms?request=GetCapabilities&service=WMS	0	Pronostico climático	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
91	510	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_008_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Agosto.	t	41754	1	2026-01-07 09:50:44.642837-05	\N	\N
92	107	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230404144424___Casos20230331/wms?	capa_A00012_308	Casos al 31 de marzo del 2023	t	35905	1	2026-01-07 09:50:44.642837-05	\N	\N
93	600	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_012_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Diciembre	t	41849	1	2026-01-07 09:50:44.642837-05	\N	\N
94	63	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619115828___Casos_al_18_de_agosto_del_2024/wms?	capa_000000_1863	Casos al 18 de agosto del 2024	t	41085	1	2026-01-07 09:50:44.642837-05	\N	\N
95	1451	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/gf_puestossedes/wms?service=WMS&request=GetCapabilities	0	Sedes y Puestos de control	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
96	1166	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/FISIOGRAFIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Fisiografia (Escala 1:500 000)	t	39448	1	2026-01-07 09:50:44.642837-05	\N	\N
97	1104	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Concesión Forestal	t	40771	1	2026-01-07 09:50:44.642837-05	\N	\N
98	446	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_007_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Julio.	t	41638	1	2026-01-07 09:50:44.642837-05	\N	\N
99	22	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231110112316___Casos_al_06_de_octubre_del_2023/wms?	capa_A00012_368	Casos al 06 de octubre del 2023	t	39200	1	2026-01-07 09:50:44.642837-05	\N	\N
100	298	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_oefa_grifos_/wms?	peru_oefa_grifos_	Grifos y EESS. Gasocentros	t	19000	1	2026-01-07 09:50:44.642837-05	\N	\N
101	304	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Estaciones_Calidad_Aire/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Red de vigilancia ambiental de la calidad del aire	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
102	1593	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
103	1637	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2024/peru_pech_007_red_pozos_monitoreo_casub_2024/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2024 - Estiaje	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
104	857	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Vigilancia	t	26528	1	2026-01-07 09:50:44.642837-05	\N	\N
105	740	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_009_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Septiembre.	t	41783	1	2026-01-07 09:50:44.642837-05	\N	\N
106	932	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250722165343___Universidad_Intercultural_Amazonia/wms?	capa_000000_1971	Universidad Nacional Intercultural de la Amazonía	t	41242	1	2026-01-07 09:50:44.642837-05	\N	\N
107	58	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829161050___Casos_al_16_de_junio_del_2025/wms?	capa_000000_2041	Casos al 16 de junio del 2025	t	41348	1	2026-01-07 09:50:44.642837-05	\N	\N
108	786	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que tienen techos en buen estado de conservación	t	27677	1	2026-01-07 09:50:44.642837-05	\N	\N
109	34	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206171542___Casos_al_10_de_diciembre_del_2024/wms?	capa_000000_1632	Casos al 10 de diciembre del 2024	t	40743	1	2026-01-07 09:50:44.642837-05	\N	\N
110	1424	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/pma_fenomenos_dpto_/wms?	pma_fenomenos_dpto_	Vul. Inseguridad Alimentaria RFN Dpto.	t	957	1	2026-01-07 09:50:44.642837-05	\N	\N
111	1078	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Poblacional/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Poblacional	t	38814	1	2026-01-07 09:50:44.642837-05	\N	\N
112	1574	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
113	1430	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240903091948___Capa2_Plataformas_itinerantes_2023/wms?	capa_000000_1141	Plataformas Itinerantes (PIAS) 2023	t	40045	1	2026-01-07 09:50:44.642837-05	\N	\N
114	884	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240430181111___Tributos_Aduaneros_Recaudados_Set2023/wms?	capa_000000_813	Tributos Aduaneros Recaudados	t	39645	1	2026-01-07 09:50:44.642837-05	\N	\N
115	597	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_013_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas Anual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
116	662	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_01/01_01_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 10 - Tmin Extrema - Julio	t	41517	1	2026-01-07 09:50:44.642837-05	\N	\N
117	337	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Procesamiento_GasN/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas de procesamiento de gas natural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
118	1437	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_acr/wms?service=WMS&request=GetCapabilities	0	Áreas de Conservación Regional	t	36867	1	2026-01-07 09:50:44.642837-05	\N	\N
119	341	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Industriales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas industriales (punto)	t	41986	1	2026-01-07 09:50:44.642837-05	\N	\N
120	353	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240424142747___Glaciares_Comp/wms?	capa_000000_749	Inventario Nacional de glaciares de origen glaciar	t	39569	1	2026-01-07 09:50:44.642837-05	\N	\N
121	1591	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330154313___vaso_de_leche/wms?	capa_24_336	Vaso de Leche	t	35837	1	2026-01-07 09:50:44.642837-05	\N	\N
122	627	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Octubre	t	38997	1	2026-01-07 09:50:44.642837-05	\N	\N
123	337	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Plantas_Procesamiento_GasN/MapServer/generateKml	0	Unidades fiscalizables - Plantas de procesamiento de gas natural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
124	128	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721155846___LAB_PUB/wms?	capa_000000_1958	Laboratorios del Sector Público	t	41225	1	2026-01-07 09:50:44.642837-05	\N	\N
125	1058	11	https://geosnirh.ana.gob.pe/server/services/Público/CanalDerivacion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Canales de Derivación	t	38834	1	2026-01-07 09:50:44.642837-05	\N	\N
126	395	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_005_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Mayo.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
127	656	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_009_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Septiembre.	t	41874	1	2026-01-07 09:50:44.642837-05	\N	\N
128	922	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330154347___instituciones_educativas/wms?	capa_24_338	Instituciones Educativas	t	35839	1	2026-01-07 09:50:44.642837-05	\N	\N
129	162	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudadania_digital_/wms?	peru_ciudadania_digital_	Ciudadanía Digital Per cápita (%)	t	4938	1	2026-01-07 09:50:44.642837-05	\N	\N
130	1686	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251212141407___Total_Becarios_2024/wms?	capa_000000_2665	Becas otorgadas año 2024	t	42072	1	2026-01-07 09:50:44.642837-05	\N	\N
131	407	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_15/06_15_001_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Máxima 2050 Anual.	t	41833	1	2026-01-07 09:50:44.642837-05	\N	\N
132	319	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Consultoras_Ambientales_Linea/MapServer/generateKml	0	Unidades fiscalizables - Consultoras ambientales (línea)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
133	1580	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
134	160	12	https://maps.inei.gob.pe/geoserver/T10Limites/ig_cpoblado/wfs?service=WFS&request=GetCapabilities	0	Centro Poblado (ámbito geográfico)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
135	1073	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Minero/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Minero	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
136	1277	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_villa_/wms?	peru_villa_	Villa	t	8076	1	2026-01-07 09:50:44.642837-05	\N	\N
137	1091	11	https://geosnirh.ana.gob.pe/server/services/Público/SectorHidraulicoMenorB/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sector Menor Clase B	t	38794	1	2026-01-07 09:50:44.642837-05	\N	\N
138	696	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_07/11_07_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Quinua	t	41883	1	2026-01-07 09:50:44.642837-05	\N	\N
139	308	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Red_Distribucion_Contugas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidad fiscalizable - Red de distribución Contugas	t	41996	1	2026-01-07 09:50:44.642837-05	\N	\N
140	344	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Recurso_Energetico_Renovable_Pto/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Recurso energético renovable (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
141	1349	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_alimen_nutric_coc_pesc_2023_/wms?	peru_econo_educ_alimen_nutric_coc_pesc_2023_	Educación Alimentaria y Nutricional (Cocinando con Pescado) - 2023	t	39047	1	2026-01-07 09:50:44.642837-05	\N	\N
142	1152	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_riesgos_minedu_/wms?	peru_riesgos_minedu_	Heladas y friaje sector Educación	t	1180	1	2026-01-07 09:50:44.642837-05	\N	\N
143	304	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Estaciones_Calidad_Aire/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Red de vigilancia ambiental de la calidad del aire	t	42015	1	2026-01-07 09:50:44.642837-05	\N	\N
144	1638	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2024/peru_pech_007_red_pozos_monitoreo_casub_2024/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2024 - Incremento	t	41941	1	2026-01-07 09:50:44.642837-05	\N	\N
145	1626	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
146	451	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_010_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Octubre.	t	41641	1	2026-01-07 09:50:44.642837-05	\N	\N
147	142	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721170523___PERU_EDUCA/wms?	capa_000000_1970	Programa Niñas Digitales - Perú EDUCA	t	41238	1	2026-01-07 09:50:44.642837-05	\N	\N
148	1659	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251110092145___Asegurados_derechohabientes_oct2025/wms?	capa_000000_2519	Afiliados activos del seguro SALUDPOL (Derechohabiente)	t	41893	1	2026-01-07 09:50:44.642837-05	\N	\N
149	332	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Lotes_Hidrocarburos_Liquidos/MapServer/generateKml	0	Unidades fiscalizables - Lotes de hidrocarburos líquidos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
150	629	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/wms?request=GetCapabilities&service=WMS	0	Monitoreo de la Precipitación	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
151	114	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_conflictos_sociales_gestionrecursos_nuevo_/wms?	peru_conflictos_sociales_gestionrecursos_nuevo_	Gestión de Recursos Públicos	t	4930	1	2026-01-07 09:50:44.642837-05	\N	\N
152	111	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251014152547___Delimitacion_Territorial/wms?	capa_000000_2133	Delimitación Territorial	t	41500	1	2026-01-07 09:50:44.642837-05	\N	\N
153	573	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_04/01_04_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Descenso Tmin - Agosto	t	41531	1	2026-01-07 09:50:44.642837-05	\N	\N
154	1002	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818233115___Autoempleo_Productivo_Abril_Junio_2025/wms?	capa_000000_2018	Capacitación y asistencia técnica para el autoempleo productivo (Abril - Junio 2025)	t	41301	1	2026-01-07 09:50:44.642837-05	\N	\N
155	1215	11	http://200.60.23.226:8080/geoserver/PCM/wms?service=WMS&request=GetCapabilities	TumbesDpto	Departamento de Tumbes	t	8538	1	2026-01-07 09:50:44.642837-05	\N	\N
156	1284	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAHUARAL/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Huaral	t	41018	1	2026-01-07 09:50:44.642837-05	\N	\N
157	901	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241112145705___3_Hombres_afiliados_SPP_Dic2023/wms?	capa_000000_1416	Hombres afiliados al sistema privado de pensiones (% PEA)	t	40423	1	2026-01-07 09:50:44.642837-05	\N	\N
158	936	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_fallecidos_covid_/wms?	peru_fallecidos_covid_	Adultos Mayores Fallecidos	t	8252	1	2026-01-07 09:50:44.642837-05	\N	\N
159	184	11	https://maps.inei.gob.pe/geoserver/T10Limites/ig_departamento/wms?service=WMS&request=GetCapabilities	0	Límite Departamental	t	36986	1	2026-01-07 09:50:44.642837-05	\N	\N
160	1191	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_NASCA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Nasca	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
161	721	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Julio.	t	41793	1	2026-01-07 09:50:44.642837-05	\N	\N
162	86	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618174233___Casos_al_24_de_marzo_del_2025/wms?	capa_000000_1854	Casos al 24 de marzo del 2025	t	41076	1	2026-01-07 09:50:44.642837-05	\N	\N
163	1243	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_0104_53	Red Vial Nacional	t	2200	1	2026-01-07 09:50:44.642837-05	\N	\N
164	814	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/barrio_seguro/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Incidencias Barrios Seguros	t	26518	1	2026-01-07 09:50:44.642837-05	\N	\N
165	1064	11	https://geosnirh.ana.gob.pe/server/services/Público/Drenes/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Drenes	t	30796	1	2026-01-07 09:50:44.642837-05	\N	\N
166	598	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_004_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Abril	t	41841	1	2026-01-07 09:50:44.642837-05	\N	\N
167	684	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_99/01_99_001_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Periodo Retorno Sequías - 2019 - Retorno SPI (Moderado)	t	41553	1	2026-01-07 09:50:44.642837-05	\N	\N
168	547	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_006_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Junio.	t	41654	1	2026-01-07 09:50:44.642837-05	\N	\N
169	132	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230404150336___CasosMarzo/wms?	capa_A00012_309	Marzo 2023	t	35906	1	2026-01-07 09:50:44.642837-05	\N	\N
170	1344	11	https://geoservidor.fondepes.gob.pe/geoserver/FONDEPES/Muelle%20Pesquero%20Artesanal/wms?service=WMS&request=GetCapabilities	0	Muelle Pesquero Artesanal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
171	1326	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Tuberías Primaria	Tuberías Primaria	t	8313	1	2026-01-07 09:50:44.642837-05	\N	\N
172	296	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Conflictos_Socioambientales/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Conflictos socioambientales - Mesas de diálogo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
173	976	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240424165918___Vacuna_regular_feb2024/wms?	capa_000000_755	Vacuna Antituberculosa (BCG)	t	39575	1	2026-01-07 09:50:44.642837-05	\N	\N
174	1261	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_24_16	Establecimientos de Salud	t	2700	1	2026-01-07 09:50:44.642837-05	\N	\N
175	1035	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-25000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
176	165	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_comedores_populares_/wms?	peru_comedores_populares_	Comedores Populares	t	4818	1	2026-01-07 09:50:44.642837-05	\N	\N
177	1576	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
178	251	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_instit_servir_talento_peru_local_/wms?	peru_instit_servir_talento_peru_local_	Local	t	39026	1	2026-01-07 09:50:44.642837-05	\N	\N
179	1643	11	https://gis.chavimochic.gob.pe/geoserver/comportamientoce2024/peru_pech_007_ce_periodo_avenida_estiaje_2024/wms?request=GetCapabilities&service=WMS	0	Comportamiento Conductividad Eléctrica 2024 - Avenida	t	41932	1	2026-01-07 09:50:44.642837-05	\N	\N
180	970	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027175303___Tecnico_Esp_Distrito_Julio_2025/wms?	capa_000000_2323	Técnico Especializado por distrito	t	41695	1	2026-01-07 09:50:44.642837-05	\N	\N
181	1428	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_banco_agencias_/wms?	peru_banco_agencias_	Agencias	t	19001	1	2026-01-07 09:50:44.642837-05	\N	\N
182	1459	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/Medio_SEconomico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sector Económico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
183	1076	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Pecuario/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Pecuario	t	38812	1	2026-01-07 09:50:44.642837-05	\N	\N
184	1568	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
185	1153	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_riesgos_mimp_/wms?	peru_riesgos_mimp_	Heladas y friaje sector MIMP	t	1177	1	2026-01-07 09:50:44.642837-05	\N	\N
186	364	11	https://ide.igp.gob.pe/geoserver/ZonificacionSismica/wms?	0	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Zonificación Sísmica	t	39444	1	2026-01-07 09:50:44.642837-05	\N	\N
187	1310	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_nuv_cred_mivivienda_bbp_sost_2022_/wms?	peru_finan_nuv_cred_mivivienda_bbp_sost_2022_	Créditos Mivivienda con BBP Sostenible	t	38336	1	2026-01-07 09:50:44.642837-05	\N	\N
188	521	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_013_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Anual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
189	393	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_006_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Junio.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
190	991	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510165644___Atendidos_INR_Proced_Edad_xdist_2023/wms?	capa_000000_856	Pacientes INR atendidos según grupos de edad - Distrital	t	39688	1	2026-01-07 09:50:44.642837-05	\N	\N
191	593	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_07/01_07_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Eventos Olas de Calor - Invierno	t	41542	1	2026-01-07 09:50:44.642837-05	\N	\N
192	343	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Recurso_Energetico_Renovable_Pol/MapServer/generateKml	0	Unidades fiscalizables - Recurso energético renovable (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
193	953	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240428154013___Medicos_XEESS_Feb2024/wms?	capa_000000_796	Médicos por EESS	t	39616	1	2026-01-07 09:50:44.642837-05	\N	\N
194	886	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240903163025___Adjudicado_OSCE/wms?	capa_000000_1151	Datos de la convocatoria o invitación - Adjudicado	t	40055	1	2026-01-07 09:50:44.642837-05	\N	\N
195	1381	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241204162434___6_Pob_con_sin_sec_econ_2023/wms?	capa_000000_1455	% Población de 14 años a más ocupada, por sectores económicos (2023)	t	40483	1	2026-01-07 09:50:44.642837-05	\N	\N
196	21	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618170655___Casos_al_06_de_enero_del_2025/wms?	capa_000000_1845	Casos al 06 de enero del 2025	t	41067	1	2026-01-07 09:50:44.642837-05	\N	\N
197	877	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_foncomun_distrital_/wms?	peru_foncomun_distrital_	Distribución del FONCOMUN	t	1079	1	2026-01-07 09:50:44.642837-05	\N	\N
198	1623	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
199	739	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_0010_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Octubre.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
200	1661	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119091904___PAM_Aladino_VI_04_11_25/wms?	capa_000000_2527	Pasivo ambiental minero Aladino VI	t	41914	1	2026-01-07 09:50:44.642837-05	\N	\N
201	1161	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/FISIOGRAFIA_100K/MapServer/WMSServer?request=getcapabilities&service=WMS	1	Cota	t	39033	1	2026-01-07 09:50:44.642837-05	\N	\N
202	302	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_oefa_lotes_explotacion_/wms?	peru_oefa_lotes_explotacion_	Lotes Explotación	t	18994	1	2026-01-07 09:50:44.642837-05	\N	\N
203	308	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Red_Distribucion_Contugas/MapServer/generateKml	0	Unidad fiscalizable - Red de distribución Contugas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
204	374	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_02/04_02_006_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Precipitación 02 Década del mes.	t	41814	1	2026-01-07 09:50:44.642837-05	\N	\N
205	1566	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
206	1389	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241203162845___7_Pob_con_sin_cen_salud_2023/wms?	capa_000000_1453	% Población que no se atendieron en un centro de salud (2014 al 2023)	t	40477	1	2026-01-07 09:50:44.642837-05	\N	\N
207	1570	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
208	340	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Area_Unidad_Industrial/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas industriales (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
209	299	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_No_Municipales_Invt/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Inventario de áreas degradadas por RRSS no municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
210	630	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_05/wms?request=GetCapabilities&service=WMS	0	Monitoreo de Temperatura Máxima (Mar)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
211	416	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_14/06_14_002_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Mínima 2050 Verano.	t	41829	1	2026-01-07 09:50:44.642837-05	\N	\N
212	38	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619115911___Casos_al_11_de_agosto_del_2024/wms?	capa_000000_1864	Casos al 11 de agosto del 2024	t	41086	1	2026-01-07 09:50:44.642837-05	\N	\N
213	945	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027164527___Enfermeros_Distrito_Julio_2025/wms?	capa_000000_2307	Enfermeros por distrito	t	41679	1	2026-01-07 09:50:44.642837-05	\N	\N
214	1129	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240424155105___CENTRO_DE_TRANSFORMACION/wms?	capa_000000_753	Centros de transformación (P.E)	t	39573	1	2026-01-07 09:50:44.642837-05	\N	\N
215	468	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_010_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Octubre.	t	41722	1	2026-01-07 09:50:44.642837-05	\N	\N
216	1293	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR1/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR1	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
217	668	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_02/01_02_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 5 - Tmin Extrema - Mayo	t	41520	1	2026-01-07 09:50:44.642837-05	\N	\N
218	1249	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_vecinal_dic23/wms?service=wms&request=GetCapabilities	0	Red vial vecinal 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
219	666	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_02/01_02_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 5 - Tmin Extrema - Julio	t	41522	1	2026-01-07 09:50:44.642837-05	\N	\N
220	1559	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
221	261	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_caminos_inka_/wms?	peru_caminos_inka_	Caminos del Inca	t	1017	1	2026-01-07 09:50:44.642837-05	\N	\N
222	1505	11	https://portal.regionsanmartin.gob.pe/server/services/DRASAM/Productores_Lideres/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Productores asistidos técnicamente del Proyecto "Cacao"	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
223	448	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_003_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Marzo.	t	41634	1	2026-01-07 09:50:44.642837-05	\N	\N
224	1598	11	https://ws.munilince.gob.pe:9094/geoserver/GEOPERU/peru_munilince_015_manzanas/wms?service=WMS&request=Getcapabilities\n	0	Manzanas del distrito de Lince	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
225	775	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías con servicio de agua potable (24 horas)	t	26560	1	2026-01-07 09:50:44.642837-05	\N	\N
226	732	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Enero.	t	41775	1	2026-01-07 09:50:44.642837-05	\N	\N
227	1581	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
228	1440	11	http://geoportal.regionamazonas.gob.pe/geoserver/geonode/areas_urbanas/wms?service=WMS&request=GetCapabilities	0	Áreas Urbanas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
229	311	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_No_Muni/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Áreas degrad. por RRSS no municipales	t	42007	1	2026-01-07 09:50:44.642837-05	\N	\N
230	1545	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_dpto_rf_/wms?	peru_epci_dpto_rf_	Componente de Recursos Financieros	t	1166	1	2026-01-07 09:50:44.642837-05	\N	\N
231	1367	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521100510___CEM_2025_CM/wms?	capa_000000_1743	CEM en Comisarías (2025)	t	40867	1	2026-01-07 09:50:44.642837-05	\N	\N
232	1441	11	http://geoportal.regionamazonas.gob.pe/geoserver/geonode/autorizaciones_pfdmavnb/wms?service=WMS&request=GetCapabilities	0	Autorización es PFDMAVNB	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
233	562	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_002_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Febrero.	t	41731	1	2026-01-07 09:50:44.642837-05	\N	\N
234	72	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128222921___Casos_al_20_de_octubre_del_2025/wms?	capa_000000_2645	Casos al 20 de octubre del 2025	t	42041	1	2026-01-07 09:50:44.642837-05	\N	\N
235	105	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230809091246___Casos_al_30_de_junio_del_2023/wms?	capa_A00012_349	Casos al 30 de junio del 2023	t	38154	1	2026-01-07 09:50:44.642837-05	\N	\N
236	29	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231003110918___Casos_al_08_de_setiembre_del_2023/wms?	capa_A00012_363	Casos al 08 de setiembre del 2023	t	38885	1	2026-01-07 09:50:44.642837-05	\N	\N
237	1561	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240523172803___Area_inunda/wms?	capa_000000_886	Área de inundación por Tsunami - GORE CALLAO	t	39738	1	2026-01-07 09:50:44.642837-05	\N	\N
238	660	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_03/01_03_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 1 - Tmin Extrema - Mayo	t	41524	1	2026-01-07 09:50:44.642837-05	\N	\N
239	1346	11	https://geoserver.sanipes.gob.pe/geoserver/general/peru_sanipes_013_ode/wms?service=WMS&request=GetCapabilities	0	Oficinas Desconcentradas de SANIPES	t	40818	1	2026-01-07 09:50:44.642837-05	\N	\N
240	987	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510170445___Dep/wms?	capa_000000_857	Pacientes atendidos en el INR por mes - Nivel Departamental	t	39689	1	2026-01-07 09:50:44.642837-05	\N	\N
241	1353	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241210170510___Capa1_Educ_Alimen_Nutric_Pesca_Educa_2024/wms?	capa_000000_1468	Educación Alimentaria y Nutricional (PESCAEduca) - 2024	t	40520	1	2026-01-07 09:50:44.642837-05	\N	\N
242	759	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_seguciu_adolesinfra_infrac_distrito_cjdr_/wms?	peru_seguciu_adolesinfra_infrac_distrito_cjdr_	Infracciones por distrito según CJDR	t	39230	1	2026-01-07 09:50:44.642837-05	\N	\N
243	333	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Derechos_Mineros/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Minería	t	42001	1	2026-01-07 09:50:44.642837-05	\N	\N
244	755	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_oficinas_regionales/wms?service=WMS&request=GetCapabilities	0	Oficinas Regionales	t	41952	1	2026-01-07 09:50:44.642837-05	\N	\N
245	1432	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250724182111___Capa2_Puntos_de_atencion_300625/wms?	capa_000000_1975	Plataformas Itinerantes (PIAS) 2025	t	41247	1	2026-01-07 09:50:44.642837-05	\N	\N
246	1013	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818221442___Moodle_Ene_Mar_2025/wms?	capa_000000_2013	Moodle (Enero - Marzo 2025)	t	41296	1	2026-01-07 09:50:44.642837-05	\N	\N
247	508	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_014_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Verano.	t	41760	1	2026-01-07 09:50:44.642837-05	\N	\N
248	41	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804145634___Casos_al_12_de_mayo_del_2023/wms?	capa_A00012_340	Casos al 12 de mayo del 2023	t	38143	1	2026-01-07 09:50:44.642837-05	\N	\N
249	838	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Radio móvil- Propio y operativo	t	27689	1	2026-01-07 09:50:44.642837-05	\N	\N
286	291	11	https://geoservicios.sernanp.gob.pe/arcgis/services/gestion_de_anp/peru_sernanp_0213/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Zonificación ACP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
250	800	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Económica o Patrimonial (60 años a más)	t	27713	1	2026-01-07 09:50:44.642837-05	\N	\N
251	117	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_A00012_192	Hídricos	t	23928	1	2026-01-07 09:50:44.642837-05	\N	\N
252	319	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Consultoras_Ambientales_Linea/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Consultoras ambientales (línea)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
253	1125	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241113161239___Unidades_min_produccion_jun2024/wms?	capa_000000_1418	Unidades Mineras en Producción	t	40425	1	2026-01-07 09:50:44.642837-05	\N	\N
254	1016	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625115414___Moodle_Oct_Dic_2024/wms?	capa_000000_1905	Moodle (Oct - Dic 2024)	t	41135	1	2026-01-07 09:50:44.642837-05	\N	\N
255	292	17	https://geoservicios.sernanp.gob.pe/arcgis/rest/services/servicios_ogc/peru_sernanp_0213/MapServer	0	Zonificación ACR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
256	1595	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
257	1158	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_suscep_friaje_group_/wms?	peru_suscep_friaje_group_	Riesgos por friaje	t	1183	1	2026-01-07 09:50:44.642837-05	\N	\N
258	231	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_infra_internet_movil_/wms?	peru_infra_internet_movil_	Todos los operadores Internet Móvil	t	39034	1	2026-01-07 09:50:44.642837-05	\N	\N
259	482	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Marzo.	t	41616	1	2026-01-07 09:50:44.642837-05	\N	\N
260	1333	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Áreas Disponibles	t	8327	1	2026-01-07 09:50:44.642837-05	\N	\N
261	969	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240513185149___Quimico_XEESS_Feb2024/wms?	capa_000000_877	Químicos por EESS	t	39709	1	2026-01-07 09:50:44.642837-05	\N	\N
262	1072	12	https://geosnirh.ana.gob.pe/server/services/Público/Lagunas/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Lagunas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
263	1141	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_seg_ciud_delitos_cont_adm_pub_2023_/wms?	peru_seg_ciud_delitos_cont_adm_pub_2023_	Delitos contra la Administración Pública	t	39180	1	2026-01-07 09:50:44.642837-05	\N	\N
264	811	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Sexual (18 – 59 años)	t	27705	1	2026-01-07 09:50:44.642837-05	\N	\N
265	1480	11	http://ide.regionmadrededios.gob.pe/geoserver/forestal/diferentes_madera/wms?service=WMS&request=GetCapabilities	0	Concesiones para Productos Forestales Diferentes a la Madera	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
266	365	11	https://ide.igp.gob.pe/geoserver/SacudimientoSuelo/wms?request=GetCapabilities&service=WMS	0	Mapa de sacudimiento real	t	41014	1	2026-01-07 09:50:44.642837-05	\N	\N
267	866	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_demografica_salud_familiar/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Sexual (Últimos 12 Meses)	t	26539	1	2026-01-07 09:50:44.642837-05	\N	\N
268	178	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_ferias_/wms?	peru_sitios_interes_ferias_	Ferias	t	2809	1	2026-01-07 09:50:44.642837-05	\N	\N
269	1397	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_discapacidad_muni_distritales_/wms?	peru_discapacidad_muni_distritales_	En las Municipalidades Distritales	t	27879	1	2026-01-07 09:50:44.642837-05	\N	\N
270	1392	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241211202725___14_Pob_con_sin_elect_2023/wms?	capa_000000_1488	% Población que tiene electricidad en su vivienda (2014 al 2023)	t	40544	1	2026-01-07 09:50:44.642837-05	\N	\N
271	118	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_20_20	Hidrocarburos	t	16282	1	2026-01-07 09:50:44.642837-05	\N	\N
272	619	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Diciembre	t	38999	1	2026-01-07 09:50:44.642837-05	\N	\N
273	927	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241107115040___EB_SHAPE/wms?	capa_000000_1406	Escuelas Bicentenario	t	40409	1	2026-01-07 09:50:44.642837-05	\N	\N
274	338	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Limites_Plantas_Distribucion/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas distribución de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
275	480	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Julio.	t	41620	1	2026-01-07 09:50:44.642837-05	\N	\N
276	1423	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/pma_fenomenos_dist_VIAFFNN_/wms?	pma_fenomenos_dist_VIAFFNN_	Vul. Inseguridad Alimentaria RFN Dist.	t	959	1	2026-01-07 09:50:44.642837-05	\N	\N
277	511	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_012_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Diciembre.	t	41758	1	2026-01-07 09:50:44.642837-05	\N	\N
278	677	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_002_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Antes de 1960 (1941)	t	41546	1	2026-01-07 09:50:44.642837-05	\N	\N
279	545	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_002_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Febrero.	t	41650	1	2026-01-07 09:50:44.642837-05	\N	\N
280	4	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251014152517___Bienes_y_Servicios_Publicos/wms?	capa_000000_2132	Bienes y servicios	t	41499	1	2026-01-07 09:50:44.642837-05	\N	\N
281	491	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_014_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Verano.	t	41709	1	2026-01-07 09:50:44.642837-05	\N	\N
282	822	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Familiar (18 – 59 años)	t	27698	1	2026-01-07 09:50:44.642837-05	\N	\N
283	365	12	https://ide.igp.gob.pe/geoserver/SacudimientoSuelo/wfs?request=GetCapabilities&service=WFS	0	Mapa de sacudimiento real	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
284	1531	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_rep_/wms?	peru_rep_	ISA REP	t	5745	1	2026-01-07 09:50:44.642837-05	\N	\N
285	1044	11	https://geosnirh.ana.gob.pe/server/services/Público/AcreDispHidrica/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Acreditación de Disponibilidad Hídrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
287	1263	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_infraestuctura_nodos_red_regional_foptica_/wms?	peru_infraestuctura_nodos_red_regional_foptica_	Nodos de la Red Regional	t	23989	1	2026-01-07 09:50:44.642837-05	\N	\N
288	893	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251006103224___punto_atencion_set25/wms?	capa_000000_2126	Puntos de Atención	t	41476	1	2026-01-07 09:50:44.642837-05	\N	\N
289	625	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Mayo	t	38992	1	2026-01-07 09:50:44.642837-05	\N	\N
290	429	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Julio.	t	41584	1	2026-01-07 09:50:44.642837-05	\N	\N
291	1629	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251006162527___Centros_atencion_2025/wms?	capa_000000_2129	Centros de atención	t	41479	1	2026-01-07 09:50:44.642837-05	\N	\N
292	1056	11	https://geosnirh.ana.gob.pe/server/services/Público/Bocatomas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Bocatomas	t	38832	1	2026-01-07 09:50:44.642837-05	\N	\N
293	544	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_001_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Enero.	t	41649	1	2026-01-07 09:50:44.642837-05	\N	\N
294	326	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Establecimientos_Industriales_Pesqueros/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Industrias pesqueras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
295	657	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_03/01_03_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 1 - Tmin Extrema - Agosto	t	41527	1	2026-01-07 09:50:44.642837-05	\N	\N
296	1612	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
297	486	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_009_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Septiembre.	t	41622	1	2026-01-07 09:50:44.642837-05	\N	\N
298	1380	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241205120254___2_Pob_disc_por_dificultad_censo2017/wms?	capa_000000_1462	% Población con discapacidad por tipo de dificultad o limitación permanente (2017)	t	40504	1	2026-01-07 09:50:44.642837-05	\N	\N
299	763	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de computadoras propio y operativo	t	27678	1	2026-01-07 09:50:44.642837-05	\N	\N
300	745	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_07/04_07_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Variable de Índice de Humedad 01 Década del mes.	t	41577	1	2026-01-07 09:50:44.642837-05	\N	\N
301	794	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Estafas	t	26546	1	2026-01-07 09:50:44.642837-05	\N	\N
302	553	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_013_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Anual.	t	41742	1	2026-01-07 09:50:44.642837-05	\N	\N
303	1652	11	https://gis.chavimochic.gob.pe/geoserver/calidadaguasuperficial2023/peru_pech_007_monitoreo_superficial_anual_2023/wms?request=GetCapabilities&service=WMS	0	Monitoreo Superficial Anual 2023	t	41946	1	2026-01-07 09:50:44.642837-05	\N	\N
304	691	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_10/11_10_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Frijol	t	41885	1	2026-01-07 09:50:44.642837-05	\N	\N
305	915	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250128122604___Capa10_IE_Ocupacional_130125/wms?	capa_000000_1598	I.E. Ocupacional	t	40672	1	2026-01-07 09:50:44.642837-05	\N	\N
306	12	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230905104815___Casos_al_04_de_agosto_del_2023/wms?	capa_A00012_357	Casos al 04 de agosto del 2023	t	38385	1	2026-01-07 09:50:44.642837-05	\N	\N
307	1006	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240924231418___Competencias_Laborales_Ene_Mar_2024/wms?	capa_000000_1230	Certificación de competencias laborales (Enero - Marzo 2024)	t	40172	1	2026-01-07 09:50:44.642837-05	\N	\N
308	1506	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908164750___PUESTOS_CONTROL/wms?	capa_22_8	Puestos de control	t	41375	1	2026-01-07 09:50:44.642837-05	\N	\N
309	1669	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251124104234___Actividades_Cul_Oct2025/wms?	capa_000000_2575	Actividades culturales	t	41966	1	2026-01-07 09:50:44.642837-05	\N	\N
310	951	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240528112815___Medico_Vet_XEESS_Feb2024/wms?	capa_000000_890	Médico Veterinario por EESS	t	39742	1	2026-01-07 09:50:44.642837-05	\N	\N
311	1416	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250523000459___Capa7_Servicio_Educadores_Calle_Feb2025/wms?	capa_000000_1752	Reporte Servicio Educadores de Calle	t	40880	1	2026-01-07 09:50:44.642837-05	\N	\N
312	1444	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/cb_drenaje_superficial/wms?service=WMS&request=GetCapabilities	0	Drenaje superficial	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
313	698	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_99/05_99_006_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Lluvia, Duración 1989/90 a 2018/19 del Departamento de Puno.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
314	575	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_04/01_04_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Descenso Tmin - Junio	t	41529	1	2026-01-07 09:50:44.642837-05	\N	\N
315	1337	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Formulario de Reserva	t	8324	1	2026-01-07 09:50:44.642837-05	\N	\N
316	1175	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_TUMBES/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágen Satelital de Tumbes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
317	95	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231110110113___Casos_al_27_de_octubre_del_2023/wms?	capa_A00012_365	Casos al 27 de octubre del 2023	t	39197	1	2026-01-07 09:50:44.642837-05	\N	\N
318	308	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Red_Distribucion_Contugas/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidad fiscalizable - Red de distribución Contugas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
319	230	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250901100357___Capa1_Movistar_1er_Trim_2025/wms?	capa_000000_2050	Movistar	t	41357	1	2026-01-07 09:50:44.642837-05	\N	\N
320	314	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Hidroelectricas_Proyectadas/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Centrales hidroeléctricas proyectada	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
321	1359	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241210180821___Capa5_Fom_Prod_Pesq_Cons_Hum_Dir_2024/wms?	capa_000000_1472	Fomento de la Producción Pesquera para el Consumo Humano Directo - 2024	t	40524	1	2026-01-07 09:50:44.642837-05	\N	\N
322	299	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_No_Municipales_Invt/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Inventario de áreas degradadas por RRSS no municipales	t	42018	1	2026-01-07 09:50:44.642837-05	\N	\N
323	466	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_005_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Mayo.	t	41717	1	2026-01-07 09:50:44.642837-05	\N	\N
324	188	12	https://maps.inei.gob.pe/geoserver/T10Limites/ig_manzana/wfs?service=WFS&request=GetCapabilities	0	Manzana	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
325	1476	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_conflictos_sociales_transporte_nuevo_/wms?	peru_conflictos_sociales_transporte_nuevo_	Transporte	t	4936	1	2026-01-07 09:50:44.642837-05	\N	\N
326	887	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240903164110___Consentido_OSCE/wms?	capa_000000_1152	Datos de la convocatoria o invitación - Consentido	t	40056	1	2026-01-07 09:50:44.642837-05	\N	\N
327	1453	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_zonas_reservadas/wms?service=WMS&request=GetCapabilities	0	Zonas Reservadas	t	1309	1	2026-01-07 09:50:44.642837-05	\N	\N
328	1096	11	https://geosnirh.ana.gob.pe/server/services/ws_UnidadesHidro/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades Hidrográficas	t	30659	1	2026-01-07 09:50:44.642837-05	\N	\N
329	368	11	https://ide.igp.gob.pe/arcgis/services/monitoreocensis/Sismicidad/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sismos reportados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
330	1385	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241211204402___12_Pob_con_sin_pob_mon_2022/wms?	capa_000000_1490	% Población en situación de pobreza monetaria (2014 al 2023)	t	40546	1	2026-01-07 09:50:44.642837-05	\N	\N
331	1172	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_HUANCAYO/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imagen Satelital de Huancayo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
332	64	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022083703___Casos_al_18_de_agosto_del_2025/wms?	capa_000000_2299	Casos al 18 de agosto del 2025	t	41671	1	2026-01-07 09:50:44.642837-05	\N	\N
333	1131	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240416122656___Capa1_Redes_Media_Tension_2023/wms?	capa_000000_666	Redes media tensión - Sistemas eléctricos	t	39486	1	2026-01-07 09:50:44.642837-05	\N	\N
334	1217	11	http://200.60.23.226:8080/geoserver/PCM/wms?service=WMS&request=GetCapabilities	ProvTumbes	Provincia de Tumbes	t	8535	1	2026-01-07 09:50:44.642837-05	\N	\N
335	1408	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241120181225___4_Por_Nivel_Gravedad_Severo_Set2024/wms?	capa_000000_1438	Por nivel de gravedad severo	t	40445	1	2026-01-07 09:50:44.642837-05	\N	\N
336	829	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Psicológica (60 años a más)	t	27718	1	2026-01-07 09:50:44.642837-05	\N	\N
337	664	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_01/01_01_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 10 - Tmin Extrema - Mayo	t	41515	1	2026-01-07 09:50:44.642837-05	\N	\N
338	19	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128223144___Casos_al_05_de_octubre_del_2025/wms?	capa_000000_2647	Casos al 05 de octubre del 2025	t	42043	1	2026-01-07 09:50:44.642837-05	\N	\N
339	2	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_A00012_188	Agrarios	t	23924	1	2026-01-07 09:50:44.642837-05	\N	\N
340	338	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Limites_Plantas_Distribucion/MapServer/generateKml	0	Unidades fiscalizables - Plantas distribución de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
341	1074	12	https://geosnirh.ana.gob.pe/server/services/P%C3%BAblico/ObrasdeArte/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Obras de Arte	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
342	1682	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251211155204___Total_Becarios_2020/wms?	capa_000000_2661	Becas otorgadas año 2020	t	42068	1	2026-01-07 09:50:44.642837-05	\N	\N
343	1052	11	https://geosnirh.ana.gob.pe/server/services/Público/Consejos_de_Cuencas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Aprobados	t	38790	1	2026-01-07 09:50:44.642837-05	\N	\N
344	1083	11	https://geosnirh.ana.gob.pe/server/services/Público/Propuesta_CRHC/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Propuesta	t	38791	1	2026-01-07 09:50:44.642837-05	\N	\N
345	1170	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hidrografía (Escala 1:500 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
346	1323	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Hidrantes	Hidrantes	t	8316	1	2026-01-07 09:50:44.642837-05	\N	\N
347	305	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Alertas_Reporta_Residuos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Reporta Residuos - Alertas de residuos sólidos	t	42016	1	2026-01-07 09:50:44.642837-05	\N	\N
348	957	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510122729___CNV_minsa_xdist_oct2023/wms?	capa_000000_838	Mujeres con recién nacido vivo	t	39670	1	2026-01-07 09:50:44.642837-05	\N	\N
349	724	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Mayo.	t	41791	1	2026-01-07 09:50:44.642837-05	\N	\N
350	409	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_15/06_15_003_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Máxima 2050 Otoño.	t	41835	1	2026-01-07 09:50:44.642837-05	\N	\N
351	52	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1115	Casos al 15 de Noviembre 2021	t	17348	1	2026-01-07 09:50:44.642837-05	\N	\N
352	1586	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
353	1030	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Reconocimiento 1-50000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
354	1294	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR2/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR2	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
355	1647	11	https://gis.chavimochic.gob.pe/geoserver/comportamientonf2024/peru_pech_007_nf_periodo_avenida_estiaje_2024/wms?request=GetCapabilities&service=WMS	0	Comportamiento Nivel Freático 2024 - Avenida	t	41923	1	2026-01-07 09:50:44.642837-05	\N	\N
356	1243	17	http://giserver.proviasnac.gob.pe/arcgis/rest/services/PROVIAS/MTC_InfraestructuraVial/MapServer	capa_0104_53	Red Vial Nacional	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
357	328	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Infraestructura_RRSS_Pto/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Infraestructuras de RRSS (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
358	1501	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/Modalidades_de_acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Modalidades de acceso	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
359	148	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330114110___Capital_Departamento/wms?	capa_24_322	Capital de Departamento	t	35816	1	2026-01-07 09:50:44.642837-05	\N	\N
360	1527	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_puerta/wms?service=WMS&request=GetCapabilities	0	Puertas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
361	1321	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAL/MapServer/WMSServer?request=GetCapabilities&service=WMS	Colectores Red Secundaria	Colectores Red Secundaria	t	8320	1	2026-01-07 09:50:44.642837-05	\N	\N
362	751	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_013_establecimientos_penitenciarios/wms?service=WMS&request=GetCapabilities	0	Establecimientos Penitenciarios	t	41950	1	2026-01-07 09:50:44.642837-05	\N	\N
363	1229	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_11_40	Aeroportuaria	t	3023	1	2026-01-07 09:50:44.642837-05	\N	\N
364	1146	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Delitos Informáticos	t	26556	1	2026-01-07 09:50:44.642837-05	\N	\N
365	1627	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240611145842___Red_Vial_Prov_Rioja_2022_2026/wms?	capa_000000_941	Red Vial de la Provincia de Rioja	t	39817	1	2026-01-07 09:50:44.642837-05	\N	\N
366	1684	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251212141231___Total_Becarios_2022/wms?	capa_000000_2663	Becas otorgadas año 2022	t	42070	1	2026-01-07 09:50:44.642837-05	\N	\N
367	624	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Marzo	t	38990	1	2026-01-07 09:50:44.642837-05	\N	\N
368	1562	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
369	697	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_99/05_99_003_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Lluvia, Duración 1964/65 a 2018/19 del Departamento de Puno.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
370	330	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lineas_Transmision_Proyectada/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Línea de transmisión proyectada	t	41982	1	2026-01-07 09:50:44.642837-05	\N	\N
371	99	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230809112629___Casos_al_28_de_julio_del_2023/wms?	capa_A00012_353	Casos al 28 de julio del 2023	t	38158	1	2026-01-07 09:50:44.642837-05	\N	\N
372	1433	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250724151032___Capa1_Tambos_Operativos_210725/wms?	capa_000000_1972	Tambos Operativos	t	41244	1	2026-01-07 09:50:44.642837-05	\N	\N
373	1324	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_lotes_nieva_/wms?	peru_lotes_nieva_	Lotes	t	2658	1	2026-01-07 09:50:44.642837-05	\N	\N
374	910	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625173243___Capa3_EME_Cien_2doSec_2023/wms?	capa_000000_1924	Ciencia y Tecnología - Regional	t	41154	1	2026-01-07 09:50:44.642837-05	\N	\N
375	144	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_averdes_/wms?	peru_averdes_	Áreas Verdes	t	1238	1	2026-01-07 09:50:44.642837-05	\N	\N
376	1379	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521105352___CEM_2025_SEXUAL/wms?	capa_000000_1749	Violencia Sexual (2025)	t	40873	1	2026-01-07 09:50:44.642837-05	\N	\N
377	1023	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251031093142___prog_llamkasun_set25/wms?	capa_000000_2448	Empleos temporales - Setiembre 2025	t	41821	1	2026-01-07 09:50:44.642837-05	\N	\N
378	299	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Areas_Degradadas_RRSS_No_Municipales_Invt/MapServer/generateKml	0	Inventario de áreas degradadas por RRSS no municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
379	728	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_013_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Anual.	t	41786	1	2026-01-07 09:50:44.642837-05	\N	\N
380	1509	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/ZoCRES/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	ZoCRES	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
381	1455	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/Medio_Ambiental/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Medio Ambiental	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
382	249	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_servir_dota_mpp_aprob_/wms?	peru_servir_dota_mpp_aprob_	E.P. con dotación y MPP aprobados	t	20263	1	2026-01-07 09:50:44.642837-05	\N	\N
383	62	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230905103502___Casos_al_18_de_agosto_del_2023/wms?	capa_A00012_355	Casos al 18 de agosto del 2023	t	38383	1	2026-01-07 09:50:44.642837-05	\N	\N
384	1534	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_idh_anios_edu_/wms?	peru_idh_anios_edu_	Años de educación (Población de 25 años y más)	t	8203	1	2026-01-07 09:50:44.642837-05	\N	\N
385	49	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230809111559___Casos_al_14_de_julio_del_2023/wms?	capa_A00012_351	Casos al 14 de julio del 2023	t	38156	1	2026-01-07 09:50:44.642837-05	\N	\N
386	1621	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
387	1583	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
388	1639	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2024/peru_pech_007_red_pozos_monitoreo_casub_2024/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2024 Descenso	t	41939	1	2026-01-07 09:50:44.642837-05	\N	\N
389	481	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Junio.	t	41619	1	2026-01-07 09:50:44.642837-05	\N	\N
390	1130	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_adinelsa_lineas_transmision_/wms?	peru_adinelsa_lineas_transmision_	Líneas de transmisión	t	35726	1	2026-01-07 09:50:44.642837-05	\N	\N
391	15	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20220707151541___Casos0704/wms?	capa_A00012_220	Casos al 04 de julio 2022	t	27932	1	2026-01-07 09:50:44.642837-05	\N	\N
392	1645	11	https://gis.chavimochic.gob.pe/geoserver/comportamientonf2022/peru_pech_007_nf_periodo_avenida_estiaje_2022/wms?request=GetCapabilities&service=WMS	0	Comportamiento Nivel Freático 2022 - Estiaje	t	41921	1	2026-01-07 09:50:44.642837-05	\N	\N
393	1257	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_peajes_dic22	0	Unidades de peaje 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
394	1376	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521104926___CEM_2025_PSICO/wms?	capa_000000_1748	Violencia Psicológica (2025)	t	40872	1	2026-01-07 09:50:44.642837-05	\N	\N
395	297	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Denuncias_Ambientales/MapServer/generateKml	0	Denuncias ambientales registradas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
396	1258	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_localidad_cad_/wms?	peru_localidad_cad_	Centros de Acceso Digital (CAD)	t	11271	1	2026-01-07 09:50:44.642837-05	\N	\N
397	586	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_03/08_03_031_03_001_522_2011_12_31/ows?service=WMS&request=GetCapabilities	0	Erosión Hídrica del Suelo del año 2011.	t	41851	1	2026-01-07 09:50:44.642837-05	\N	\N
398	131	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_centros_mac_expres_tambos_/wms?	peru_centros_mac_expres_tambos_	MAC Express TAMBOS	t	11269	1	2026-01-07 09:50:44.642837-05	\N	\N
399	1468	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_Vulnerabilidad/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM Vulnerabilidad	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
400	871	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pip_ppr_030_2_3_/wms?	peru_pip_ppr_030_2_3_	Actividades - Provincial	t	23732	1	2026-01-07 09:50:44.642837-05	\N	\N
401	703	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Abril.	t	41803	1	2026-01-07 09:50:44.642837-05	\N	\N
402	159	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_actores_sociales_corredor_ccpp_/wms?	peru_actores_sociales_corredor_ccpp_	Centro Poblado	t	4963	1	2026-01-07 09:50:44.642837-05	\N	\N
403	623	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Junio	t	4819	1	2026-01-07 09:50:44.642837-05	\N	\N
404	70	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618170812___Casos_al_20_de_enero_del_2025/wms?	capa_000000_1847	Casos al 20 de enero del 2025	t	41069	1	2026-01-07 09:50:44.642837-05	\N	\N
405	923	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625172802___Capa1_EME_Lec_4toPri_2023/wms?	capa_000000_1920	Lectura - Regional	t	41150	1	2026-01-07 09:50:44.642837-05	\N	\N
406	524	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_017_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Estación de Primavera.	t	41613	1	2026-01-07 09:50:44.642837-05	\N	\N
407	639	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_01/02_01_001_03_001_512_1983_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 82 - 83 - Precipitación DEF	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
408	532	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Marzo.	t	41600	1	2026-01-07 09:50:44.642837-05	\N	\N
409	679	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_004_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Después de 1960 (1966)	t	41548	1	2026-01-07 09:50:44.642837-05	\N	\N
410	321	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Depositos_Concentrados/MapServer/generateKml	0	Unidades fiscalizables - Depósitos concentrados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
411	1538	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_idh_provincial_/wms?	peru_idh_provincial_	IDH Provincial 2019	t	8190	1	2026-01-07 09:50:44.642837-05	\N	\N
412	1289	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAB/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPAB	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
413	716	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Abril.	t	41790	1	2026-01-07 09:50:44.642837-05	\N	\N
414	963	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510173104___Obstetras_CNV_oct2023/wms?	capa_000000_863	Obstetras que certifican el nacimiento	t	39695	1	2026-01-07 09:50:44.642837-05	\N	\N
415	1479	11	http://ide.regionmadrededios.gob.pe/geoserver/forestal/conservacion/wms?service=WMS&request=GetCapabilities	0	Concesiones para Conservación	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
416	1241	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_departamental_dic23/wms?service=wms&request=GetCapabilities	0	Red vial departamental 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
417	356	11	https://ide.igp.gob.pe/geoserver/CTS_sismohistorico/wms?service=WMS&request=GetCapabilities	0	Base Histórica de sismos (1475 -1960)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
418	550	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_011_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Noviembre.	t	41659	1	2026-01-07 09:50:44.642837-05	\N	\N
419	182	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_estrato_nacional_/wms?	peru_estrato_nacional_	Ingreso per cápita del Hogar	t	4815	1	2026-01-07 09:50:44.642837-05	\N	\N
420	1103	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cesiones en Uso	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
421	1065	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Energetico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Energético	t	38808	1	2026-01-07 09:50:44.642837-05	\N	\N
422	929	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251203093825___Educacion_2025/wms?	capa_000000_2649	Sede de Educación	t	42045	1	2026-01-07 09:50:44.642837-05	\N	\N
423	1435	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_areas_conservacion_ambiental/wms?service=WMS&request=GetCapabilities	0	Áreas de Conservación Ambiental	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
424	816	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Jurisdicciones Comisarias Familia	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
425	539	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_017_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Primavera.	t	41665	1	2026-01-07 09:50:44.642837-05	\N	\N
426	1485	11	http://ide.regionmadrededios.gob.pe/geoserver/idemdd/climas/wms?service=WMS&request=GetCapabilities	0	Zonas climáticas Madre de Dios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
427	284	11	https://geoservicios.sernanp.gob.pe/arcgis/services/base_fisica/peru_sernanp_0102/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	ANP de Administracion Nacional Definitiva	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
428	315	20	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Termoelectricas_Existentes/generateKml	0	Unidades fiscalizables - Centrales termoeléctricas existentes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
429	403	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_13/06_13_004_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Precipitación 2050 Invierno.	t	41826	1	2026-01-07 09:50:44.642837-05	\N	\N
430	1664	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119092105___PAM_La_Florida_I_04_11_25/wms?	capa_000000_2530	Pasivo ambiental minero La Florida I	t	41917	1	2026-01-07 09:50:44.642837-05	\N	\N
431	1382	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241205102426___5_Pob_ocup_con_sin_discap_2023/wms?	capa_000000_1458	% Población de 14 años a más, ocupada (2014 al 2023)	t	40499	1	2026-01-07 09:50:44.642837-05	\N	\N
432	1080	11	https://geosnirh.ana.gob.pe/server/services/Público/Pozos/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Pozos	t	35806	1	2026-01-07 09:50:44.642837-05	\N	\N
433	1477	11	http://ide.regionmadrededios.gob.pe/geoserver/idemdd/aeropuertos/wms?service=WMS&request=GetCapabilities	0	Aeroportuaria	t	3023	1	2026-01-07 09:50:44.642837-05	\N	\N
434	1267	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudad_mayor_principal_/wms?	peru_ciudad_mayor_principal_	Ciudad Mayor Principal	t	8070	1	2026-01-07 09:50:44.642837-05	\N	\N
435	832	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Sexual (60 años a más)	t	27706	1	2026-01-07 09:50:44.642837-05	\N	\N
436	1406	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241120181104___4_Por_Nivel_Gravedad_Moderado_Set2024/wms?	capa_000000_1437	Por nivel de gravedad moderado	t	40444	1	2026-01-07 09:50:44.642837-05	\N	\N
437	1402	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_discapacidad_pobla_discap_/wms?	peru_discapacidad_pobla_discap_	Población con discapacidad	t	28061	1	2026-01-07 09:50:44.642837-05	\N	\N
438	659	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_03/01_03_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 1 - Tmin Extrema - Junio	t	41525	1	2026-01-07 09:50:44.642837-05	\N	\N
439	331	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lotes_Gas_Natural/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Lotes de gas natural	t	41999	1	2026-01-07 09:50:44.642837-05	\N	\N
440	596	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_07/01_07_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Eventos Olas de Calor - Verano	t	41540	1	2026-01-07 09:50:44.642837-05	\N	\N
441	156	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_cementerio_/wms?	peru_sitios_interes_cementerio_	Cementerio	t	2804	1	2026-01-07 09:50:44.642837-05	\N	\N
442	1642	11	https://gis.chavimochic.gob.pe/geoserver/comportamientoce2023/peru_pech_007_ce_periodo_avenida_2023/wms?request=GetCapabilities&service=WMS	0	Comportamiento Conductividad Eléctrica 2023 - Avenida	t	41931	1	2026-01-07 09:50:44.642837-05	\N	\N
443	582	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_05/01_05_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Duración Olas de Calor - Verano	t	41532	1	2026-01-07 09:50:44.642837-05	\N	\N
444	246	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_institu_servir_convenios_colectivos_nacional_/wms?	peru_institu_servir_convenios_colectivos_nacional_	Convenios Colectivos - Nacional	t	39277	1	2026-01-07 09:50:44.642837-05	\N	\N
445	928	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251203093750___Cultural_2025/wms?	capa_000000_2648	Sede Cultural	t	42044	1	2026-01-07 09:50:44.642837-05	\N	\N
446	782	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que realizan patrullaje integrado en el distrito	t	27676	1	2026-01-07 09:50:44.642837-05	\N	\N
447	1400	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_cuota_empleo_enti_publicas_2022_/wms?	peru_cuota_empleo_enti_publicas_2022_	En Otras Entidades Públicas	t	32297	1	2026-01-07 09:50:44.642837-05	\N	\N
448	1398	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_discapacidad_muni_provinciales_/wms?	peru_discapacidad_muni_provinciales_	En las Municipalidades Provinciales	t	27880	1	2026-01-07 09:50:44.642837-05	\N	\N
449	535	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_009_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Septiembre.	t	41606	1	2026-01-07 09:50:44.642837-05	\N	\N
450	460	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_012_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Diciembre.	t	41724	1	2026-01-07 09:50:44.642837-05	\N	\N
451	812	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Sexual (60 años a más)	t	27707	1	2026-01-07 09:50:44.642837-05	\N	\N
452	313	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Hidroelectricas_Existentes/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Centrales hidroeléctricas existente	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
453	865	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Sexual	t	26543	1	2026-01-07 09:50:44.642837-05	\N	\N
454	479	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Febrero.	t	41615	1	2026-01-07 09:50:44.642837-05	\N	\N
455	1235	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_pesajes_dic22/wms?service=wms&request=GetCapabilities	0	Estaciones de pesaje 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
456	890	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251006103442___autoservicio_ser25/wms?	capa_000000_2128	Autoservicio	t	41478	1	2026-01-07 09:50:44.642837-05	\N	\N
457	311	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_No_Muni/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Áreas degrad. por RRSS no municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
458	840	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Región Policial	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
459	318	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Generacion_Concesiones/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Concesiones de generación electrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
460	1489	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908164926___CUA/wms?	capa_22_9	Autorización de cambio de uso actual	t	41376	1	2026-01-07 09:50:44.642837-05	\N	\N
461	1496	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908104629___desb_aut_sm/wms?	capa_22_6	Desbosques autorizados	t	41373	1	2026-01-07 09:50:44.642837-05	\N	\N
462	1680	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251211154925___Total_Becarios_2018/wms?	capa_000000_2659	Becas otorgadas año 2018	t	42066	1	2026-01-07 09:50:44.642837-05	\N	\N
463	650	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_007_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Julio.	t	41872	1	2026-01-07 09:50:44.642837-05	\N	\N
464	903	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250923122337___1_Oficinas_Dic2024/wms?	capa_000000_2064	Oficinas del Sistema Financiero	t	41404	1	2026-01-07 09:50:44.642837-05	\N	\N
465	475	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Abril.	t	41617	1	2026-01-07 09:50:44.642837-05	\N	\N
466	1063	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_DomesticoPoblacional/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Doméstico – Poblacional	t	38842	1	2026-01-07 09:50:44.642837-05	\N	\N
467	859	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Familiar	t	26550	1	2026-01-07 09:50:44.642837-05	\N	\N
468	40	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206171757___Casos_al_11_de_noviembre_del_2024/wms?	capa_000000_1635	Casos al 11 de noviembre del 2024	t	40746	1	2026-01-07 09:50:44.642837-05	\N	\N
469	1108	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Modalidades de acceso	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
470	414	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_14/06_14_003_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Mínima 2050 Otoño.	t	41830	1	2026-01-07 09:50:44.642837-05	\N	\N
471	577	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_07/06_07_001_03_001_521_2020_00_00/ows?service=WMS&request=GetCapabilities	0	Disponibilidad Hídrica 2020.	t	41773	1	2026-01-07 09:50:44.642837-05	\N	\N
472	1454	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/lnformacion_Base/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Información Base	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
473	912	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250130102645___Capa4_IE_Basica_Alternativa_130125/wms?	capa_000000_1610	I.E. Básica Alternativa - CEBA	t	40684	1	2026-01-07 09:50:44.642837-05	\N	\N
474	1354	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_alimen_nutric_pesca_nutric_2022_/wms?	peru_econo_educ_alimen_nutric_pesca_nutric_2022_	Educación Alimentaria y Nutricional (PESCANutrición) - 2022	t	39053	1	2026-01-07 09:50:44.642837-05	\N	\N
475	774	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías con al menos un equipo de comunicación operativo y propio	t	27686	1	2026-01-07 09:50:44.642837-05	\N	\N
476	1579	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
477	277	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioCFOI_MINAM/MapServer	0	Condiciones Favorables para la Ocurrencia de Incendios	t	41000	1	2026-01-07 09:50:44.642837-05	\N	\N
478	1147	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distrito_fiscales/wms?	peru_distrito_fiscales	Distritos Fiscales	t	16164	1	2026-01-07 09:50:44.642837-05	\N	\N
479	456	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_017_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Estación de Primavera.	t	41729	1	2026-01-07 09:50:44.642837-05	\N	\N
480	980	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_vacunados_covid19_dist_/wms?	peru_vacunados_covid19_dist_	Vacunados	t	8282	1	2026-01-07 09:50:44.642837-05	\N	\N
481	854	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Victimización	t	26520	1	2026-01-07 09:50:44.642837-05	\N	\N
482	1384	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241212095742___11_Pob_con_sin_internet_2023/wms?	capa_000000_1492	% Población de 6 años a más que accede y usa internet (2014 al 2023)	t	40548	1	2026-01-07 09:50:44.642837-05	\N	\N
483	1094	12	https://geosnirh.ana.gob.pe/server/services/Público/Tuneles/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Túneles	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
484	294	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Depositos_Relave/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Componentes fiscalizables - Depósito de relave mineros	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
485	846	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	RPM - Propio y operativo	t	27692	1	2026-01-07 09:50:44.642837-05	\N	\N
486	1037	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-50000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
487	179	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distnbi_hog_alta_depnd_econ_/wms?	peru_distnbi_hog_alta_depnd_econ_	Hog. con Alta Dependencia Económica	t	1027	1	2026-01-07 09:50:44.642837-05	\N	\N
488	322	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Derechos_Acuicolas_Pol/MapServer/generateKml	0	Unidades fiscalizables - Derechos acuícolas (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
489	55	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022084018___Casos_al_15_de_setiembre_del_2025/wms?	capa_000000_2303	Casos al 15 de setiembre del 2025	t	41675	1	2026-01-07 09:50:44.642837-05	\N	\N
490	1457	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/Medio_Cultural/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Medio Cultural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
491	1608	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_manzanas/wms?request=GetCapabilities&service=WMS	0	Manzanas Catastrales	t	32289	1	2026-01-07 09:50:44.642837-05	\N	\N
492	788	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_hogares/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Confianza en Institución - Poder Judicial	t	26534	1	2026-01-07 09:50:44.642837-05	\N	\N
493	1345	11	https://geoserver.sanipes.gob.pe/geoserver/general/peru_sanipes_017_infraestructura/wms?service=WMS&request=GetCapabilities	0	Infraestructuras habilitadas por SANIPES	t	40817	1	2026-01-07 09:50:44.642837-05	\N	\N
494	311	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Areas_Degradadas_RRSS_No_Muni/MapServer/generateKml	0	Unidades fiscalizables - Áreas degrad. por RRSS no municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
495	341	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Industriales/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas industriales (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
496	328	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Infraestructura_RRSS_Pto/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Infraestructuras de RRSS (punto)	t	42010	1	2026-01-07 09:50:44.642837-05	\N	\N
497	1026	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Reconocimiento 1-20000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
498	1436	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_areas_conservacion_privada/wms?service=WMS&request=GetCapabilities	0	Áreas de Conservación Privada	t	40136	1	2026-01-07 09:50:44.642837-05	\N	\N
499	36	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618174359___Casos_al_10_de_marzo_del_2025/wms?	capa_000000_1856	Casos al 10 de marzo del 2025	t	41078	1	2026-01-07 09:50:44.642837-05	\N	\N
500	378	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_05/04_05_006_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Máxima 02 Década del mes.	t	41816	1	2026-01-07 09:50:44.642837-05	\N	\N
501	1189	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_HUARAZ/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Huaraz	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
502	500	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_005_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Mayo.	t	41700	1	2026-01-07 09:50:44.642837-05	\N	\N
503	833	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Número de Centros de Emergencia Mujer	t	27695	1	2026-01-07 09:50:44.642837-05	\N	\N
504	1378	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521092910___CEM_2024_SEXUAL/wms?	capa_000000_1741	Violencia Sexual (2024)	t	40864	1	2026-01-07 09:50:44.642837-05	\N	\N
505	795	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Extorsiones	t	26552	1	2026-01-07 09:50:44.642837-05	\N	\N
506	742	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_06/04_06_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Variable de Evapotranspiración 01 Década del mes.	t	41576	1	2026-01-07 09:50:44.642837-05	\N	\N
507	54	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20241016162701___Casos_al_15_de_setiembre_del_2024/wms?	capa_A00012_413	Casos al 15 de setiembre del 2024	t	40294	1	2026-01-07 09:50:44.642837-05	\N	\N
508	1603	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
509	1236	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_estaciones_ferroviarias/wfs?service=wfs&request=GetCapabilities	0	Estaciones ferroviarias	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
510	30	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206175623___Casos_al_08_de_setiembre_del_2024/wms?	capa_000000_1645	Casos al 08 de setiembre del 2024	t	40756	1	2026-01-07 09:50:44.642837-05	\N	\N
511	1544	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_prov_planif_/wms?	peru_epci_prov_planif_	Componente de Planificación	t	1170	1	2026-01-07 09:50:44.642837-05	\N	\N
512	706	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Enero.	t	41800	1	2026-01-07 09:50:44.642837-05	\N	\N
513	391	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_002_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Febrero.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
514	219	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/indicad_urb_cerros_mz17_/wms?	indicad_urb_cerros_mz17_	Viviendas en Cerros - Manzanas	t	4817	1	2026-01-07 09:50:44.642837-05	\N	\N
515	289	11	https://geoservicios.sernanp.gob.pe/arcgis/services/base_fisica/peru_sernanp_0102/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Áreas Naturales Protegidas de Administración Nacional Transitoria	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
516	81	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20241016162746___Casos_al_22_de_setiembre_del_2024/wms?	capa_A00012_414	Casos al 22 de setiembre del 2024	t	40295	1	2026-01-07 09:50:44.642837-05	\N	\N
517	1114	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Zonificacion_Forestal/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Zonificación Forestal	t	8309	1	2026-01-07 09:50:44.642837-05	\N	\N
518	270	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_map/wms?service=WMS&version=1.1.0&request=GetCapabilities	cultura_map	Monumentos arqueológicos prehispánicos	t	39109	1	2026-01-07 09:50:44.642837-05	\N	\N
519	336	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Almacenamiento_GasN/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas almacenamiento de gas natural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
520	1530	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240426165014___Cedro_final/wms?	capa_000000_788	Telecentros - CEDRO	t	39608	1	2026-01-07 09:50:44.642837-05	\N	\N
521	785	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que tienen servicio de energía eléctrica (Permanente)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
522	422	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_017_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Estación de Primavera.	t	41595	1	2026-01-07 09:50:44.642837-05	\N	\N
523	804	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Física (0 – 17 años)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
524	455	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_015_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Estación de Otoño.	t	41727	1	2026-01-07 09:50:44.642837-05	\N	\N
525	876	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_canon_distrito_/wms?	peru_canon_distrito_	Distribución del Canon	t	1078	1	2026-01-07 09:50:44.642837-05	\N	\N
526	1065	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Energetico/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Energético	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
527	907	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250923155531___3_Hombres_Adultos_cuenta_Dic2024/wms?	capa_000000_2070	Porcentaje de hombres adultos con cuenta en el sistema financiero	t	41410	1	2026-01-07 09:50:44.642837-05	\N	\N
528	333	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Derechos_Mineros/MapServer/generateKml	0	Unidades fiscalizables - Minería	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
529	955	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510124327___Mujeres_Secundaria_CNV_oct2023/wms?	capa_000000_839	Mujeres con nivel de instrucción secundario	t	39671	1	2026-01-07 09:50:44.642837-05	\N	\N
530	1127	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	SERV_GEOLOGIA_AUX___default028mm	Mapa Geológico del Perú	t	38945	1	2026-01-07 09:50:44.642837-05	\N	\N
531	1650	11	https://gis.chavimochic.gob.pe/geoserver/calidadaguadrenada2024/peru_pech_007_monitoreo_drenaje_anual_2024/wms?request=GetCapabilities&service=WMS	0	Monitoreo Drenaje Anual 2024	t	41944	1	2026-01-07 09:50:44.642837-05	\N	\N
532	1113	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Zonificacion_Forestal/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Zonificación forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
533	516	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_003_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Marzo.	t	41749	1	2026-01-07 09:50:44.642837-05	\N	\N
534	304	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Estaciones_Calidad_Aire/MapServer/generateKml	0	Red de vigilancia ambiental de la calidad del aire	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
535	387	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_004_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Abril.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
536	328	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Infraestructura_RRSS_Pto/MapServer/generateKml	0	Unidades fiscalizables - Infraestructuras de RRSS (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
537	1196	11	https://www.idep.gob.pe/geoportal/services/MAPA_BASE/PER%C3%9A_RASTER_50K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	PERÚ_RASTE R_50K	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
538	1425	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/pma_fenomenos_prov_/wms?	pma_fenomenos_prov_	Vul. Inseguridad Alimentaria RFN Prov.	t	958	1	2026-01-07 09:50:44.642837-05	\N	\N
539	661	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_01/01_01_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 10 - Tmin Extrema - Agosto	t	41518	1	2026-01-07 09:50:44.642837-05	\N	\N
540	1296	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR4/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR4	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
541	1636	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2023/peru_pech_007_red_pozos_monitoreo_casub_2023/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2023 - Incremento	t	41938	1	2026-01-07 09:50:44.642837-05	\N	\N
542	465	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_003_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Marzo.	t	41715	1	2026-01-07 09:50:44.642837-05	\N	\N
543	938	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_positivos_covid_dist_/wms?	peru_positivos_covid_dist_	Casos Positivos	t	8280	1	2026-01-07 09:50:44.642837-05	\N	\N
544	445	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_002_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Febrero.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
545	210	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251020143552___Distritos_Proy_2025/wms?	capa_000000_2228	Proyectada Distritos	t	41598	1	2026-01-07 09:50:44.642837-05	\N	\N
546	1180	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/IMAGEN_DRONE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágenes RPA - Río Rímac	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
547	1230	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250924155041___Asfaltado_jun25/wms?	capa_000000_2085	Asfaltado - 2025	t	41425	1	2026-01-07 09:50:44.642837-05	\N	\N
548	554	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_016_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Invierno.	t	41745	1	2026-01-07 09:50:44.642837-05	\N	\N
549	89	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022083735___Casos_al_25_de_agosto_del_2025/wms?	capa_000000_2300	Casos al 25 de agosto del 2025	t	41672	1	2026-01-07 09:50:44.642837-05	\N	\N
550	499	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_003_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Marzo.	t	41698	1	2026-01-07 09:50:44.642837-05	\N	\N
551	379	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_05/04_05_007_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Máxima 03 Década del mes.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
552	1185	11	https://www.idep.gob.pe/geoportal/services/DATOS_GEOESPACIALES/L%C3%8DMITES/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Límites Cartointerpretables	t	39028	1	2026-01-07 09:50:44.642837-05	\N	\N
553	459	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_008_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Agosto.	t	41720	1	2026-01-07 09:50:44.642837-05	\N	\N
554	898	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241111192856___5_Credito_promedio_hombres_Dic2023/wms?	capa_000000_1407	Crédito promedio en el sistema financiero – hombres	t	40414	1	2026-01-07 09:50:44.642837-05	\N	\N
555	1632	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2022/peru_pech_007_red_pozos_monitoreo_casub_2022/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2022 - Estiaje	t	41934	1	2026-01-07 09:50:44.642837-05	\N	\N
556	601	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_001_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Enero	t	41838	1	2026-01-07 09:50:44.642837-05	\N	\N
557	711	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Mayo.	t	41804	1	2026-01-07 09:50:44.642837-05	\N	\N
558	1520	11	https://ider.regionucayali.gob.pe/geoservicios/services/dgt/transportes/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Transporte	t	4936	1	2026-01-07 09:50:44.642837-05	\N	\N
559	418	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_98/05_98_003_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de la Duración de Lluvias del Departamento de Puno.	t	41766	1	2026-01-07 09:50:44.642837-05	\N	\N
560	1139	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240513102339___contraloria/wms?	capa_000000_869	Sedes	t	39701	1	2026-01-07 09:50:44.642837-05	\N	\N
561	1014	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241024123141___Moodle_Jul_Set_2024/wms?	capa_000000_1380	Moodle (Jul - Set 2024)	t	40381	1	2026-01-07 09:50:44.642837-05	\N	\N
562	581	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_05/01_05_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Duración Olas de Calor - Primavera	t	41535	1	2026-01-07 09:50:44.642837-05	\N	\N
563	341	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Plantas_Industriales/MapServer/generateKml	0	Unidades fiscalizables - Plantas industriales (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
564	1426	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250714175720___Capa5_Cunamas_Mayo2025/wms?	capa_000000_1950	CUNA MÁS	t	41214	1	2026-01-07 09:50:44.642837-05	\N	\N
565	1094	11	https://geosnirh.ana.gob.pe/server/services/Público/Tuneles/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Túneles	t	38828	1	2026-01-07 09:50:44.642837-05	\N	\N
566	186	12	https://maps.inei.gob.pe/geoserver/T10Limites/ig_provincia/ows?service=WFS&request=GetCapabilities	0	Límite Provincial	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
567	1029	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Reconocimiento 1-35000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
637	431	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Marzo.	t	41580	1	2026-01-07 09:50:44.642837-05	\N	\N
568	858	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_especializada_sobre_victimizacion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Vigilancia Tipo de Vigilancia	t	26532	1	2026-01-07 09:50:44.642837-05	\N	\N
569	1046	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Acuicola/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Acuícola	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
570	1334	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Áreas en Trámite de Derecho Acuícola	t	8326	1	2026-01-07 09:50:44.642837-05	\N	\N
571	175	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pobreza_distritos_/wms?	peru_pobreza_distritos_	Distritos más pobres	t	19429	1	2026-01-07 09:50:44.642837-05	\N	\N
572	823	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Familiar (60 años a más)	t	27700	1	2026-01-07 09:50:44.642837-05	\N	\N
573	91	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1025	Casos al 25 de Octubre 2021	t	16285	1	2026-01-07 09:50:44.642837-05	\N	\N
574	1340	11	https://geoservidor.fondepes.gob.pe/geoserver/FONDEPES/Centro%20Acuicola/wms?service=WMS&version=1.3.0&request=GetCapabilities	0	Centro de Acuicultura	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
575	1119	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250725104638___Distribucion_electrica_Jul25/wms?	capa_000000_1978	Distribución Eléctrica	t	41250	1	2026-01-07 09:50:44.642837-05	\N	\N
576	396	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_011_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Noviembre.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
577	494	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_012_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Diciembre.	t	41707	1	2026-01-07 09:50:44.642837-05	\N	\N
578	879	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pip_ppr_030_3_2_/wms?	peru_pip_ppr_030_3_2_	Proyectos - Distrital	t	23736	1	2026-01-07 09:50:44.642837-05	\N	\N
579	949	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510171950___Mujeres_m17a_CNV_oct2023/wms?	capa_000000_860	Madres menores de 17 años	t	39692	1	2026-01-07 09:50:44.642837-05	\N	\N
580	558	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_004_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Abril.	t	41733	1	2026-01-07 09:50:44.642837-05	\N	\N
581	93	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250627143324___Casos_al_26_de_mayo_del_2025/wms?	capa_000000_1935	Casos al 26 de mayo del 2025	t	41169	1	2026-01-07 09:50:44.642837-05	\N	\N
582	1470	11	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_ider/Peru_GOREL_01/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Circunscripción política	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
583	948	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_fallecidos_covid19_dist_/wms?	peru_fallecidos_covid19_dist_	Fallecidos	t	8281	1	2026-01-07 09:50:44.642837-05	\N	\N
584	1235	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_pesajes_dic22	0	Estaciones de pesaje 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
585	1472	12	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_wfs/ComunidadesNativas/MapServer/WFSServer?request=GetCapabilities&service=WFS	capa_0104_536	Comunidades Nativas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
586	1356	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241210170724___Capa3_Educ_Alimen_Nutric_Pesca_Nutric_2024/wms?	capa_000000_1470	Educación Alimentaria y Nutricional (PESCANutrición) - 2024	t	40522	1	2026-01-07 09:50:44.642837-05	\N	\N
587	683	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_99/01_99_003_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Periodo Retorno Sequías - 2019 - Retorno SPI (Extrema)	t	41555	1	2026-01-07 09:50:44.642837-05	\N	\N
588	170	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_viv_PHAB1_/wms?	peru_viv_PHAB1_	Con una Habitación	t	1054	1	2026-01-07 09:50:44.642837-05	\N	\N
589	345	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Sistema_Ductos_Gas_Natural/MapServer/generateKml	0	Unidades fiscalizables - Sistema de ductos de transporte de gas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
590	1474	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_hidrografia_0104_/wms?	peru_hidrografia_0104_	Hidrografía	t	1292	1	2026-01-07 09:50:44.642837-05	\N	\N
591	421	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_015_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Estación de Otoño.	t	41592	1	2026-01-07 09:50:44.642837-05	\N	\N
592	415	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_14/06_14_005_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Mínima 2050 Primavera.	t	41832	1	2026-01-07 09:50:44.642837-05	\N	\N
593	1325	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Surtidores	Surtidores	t	8315	1	2026-01-07 09:50:44.642837-05	\N	\N
594	1482	11	http://ide.regionmadrededios.gob.pe/geoserver/idemdd/puertos/wms?service=WMS&request=GetCapabilities	0	Instalaciones Portuarias	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
595	994	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510162955___Atendidos_INR_Proced_Sexo_xdist_2023/wms?	capa_000000_853	Pacientes INR atendidos según sexo - Distrital	t	39685	1	2026-01-07 09:50:44.642837-05	\N	\N
596	1068	12	https://geosnirh.ana.gob.pe/server/services/Público/SERV_Formalizacion/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Formalización	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
597	1508	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/Registro_Forestal/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Registro Forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
598	265	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_localidad/wms?service=WMS&request=GetCapabilities	0	cultura_localidad	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
599	1082	12	https://geosnirh.ana.gob.pe/server/services/Público/PrincipalesPresas/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Principales Presas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
600	1087	12	https://geosnirh.ana.gob.pe/server/services/Público/Reservorios/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Reservorios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
601	531	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Junio.	t	41603	1	2026-01-07 09:50:44.642837-05	\N	\N
602	1260	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_localidad_epad_/wms?	peru_localidad_epad_	Espacios Públicos de Acceso Digital (EPAD)	t	11272	1	2026-01-07 09:50:44.642837-05	\N	\N
603	849	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Teléfono fijo - Propio y operativo	t	27687	1	2026-01-07 09:50:44.642837-05	\N	\N
604	1024	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Detallado 1-10000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
605	1233	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251001142216___Ejes_integracion/wms?	capa_000000_2106	Ejes de integración	t	41450	1	2026-01-07 09:50:44.642837-05	\N	\N
606	406	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_13/06_13_002_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Precipitación 2050 Verano.	t	41824	1	2026-01-07 09:50:44.642837-05	\N	\N
607	394	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_003_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Marzo.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
608	1476	12	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_wfs/Transporte/MapServer/WFSServer?request=GetCapabilities&service=WFS	peru_conflictos_sociales_transporte_nuevo_	Transporte	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
609	1634	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2023/peru_pech_007_red_pozos_monitoreo_casub_2023/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2023 - Descenso	t	41936	1	2026-01-07 09:50:44.642837-05	\N	\N
610	347	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Subestacion_Transmision_Existente/MapServer/generateKml	0	Unidades fiscalizables - Subestación de transmision existente	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
611	1442	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_concesiones_conservacion/wms?service=WMS&request=GetCapabilities	0	Concesiones para Conservación	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
612	1155	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_riesgos_mvcs_/wms?	peru_riesgos_mvcs_	Heladas y friaje sector Vivienda	t	1179	1	2026-01-07 09:50:44.642837-05	\N	\N
613	1602	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
614	75	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230809112148___Casos_al_21_de_julio_del_2023/wms?	capa_A00012_352	Casos al 21 de julio del 2023	t	38157	1	2026-01-07 09:50:44.642837-05	\N	\N
615	1625	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
616	137	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721165518___EDICION_1/wms?	capa_000000_1965	Programa Niñas Digitales - Edición 1	t	41232	1	2026-01-07 09:50:44.642837-05	\N	\N
617	262	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_localidad/wms?service=WMS&version=1.1.0&request=GetCapabilities	cultura_localidad	Comunidades Nativas y Campesinas	t	39112	1	2026-01-07 09:50:44.642837-05	\N	\N
618	1665	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119144402___PAM_Pushaquilca_04_11_25/wms?	capa_000000_2531	Pasivo ambiental minero Pushaquilca	t	41918	1	2026-01-07 09:50:44.642837-05	\N	\N
619	1493	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908165006___CESIONES_OTORGADAS/wms?	capa_22_10	Cesiones otorgadas	t	41377	1	2026-01-07 09:50:44.642837-05	\N	\N
620	97	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804142059___Casos_al_28_de_abril_del_2023/wms?	capa_A00012_338	Casos al 28 de abril del 2023	t	38141	1	2026-01-07 09:50:44.642837-05	\N	\N
621	1478	11	http://ide.regionmadrededios.gob.pe/geoserver/saneamiento/comunidad_tit/wms?service=WMS&request=GetCapabilities	0	Comunidades Nativas	t	32237	1	2026-01-07 09:50:44.642837-05	\N	\N
622	1648	11	https://gis.chavimochic.gob.pe/geoserver/calidadaguadrenada2022/peru_pech_007_monitoreo_drenaje_anual_2022/wms?request=GetCapabilities&service=WMS	0	Monitoreo Drenaje Anual 2022	t	41942	1	2026-01-07 09:50:44.642837-05	\N	\N
623	359	11	https://ide.igp.gob.pe/geoserver/CapacidadPortante/wms?	0	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Capacidad Portante	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
624	735	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Junio.	t	41780	1	2026-01-07 09:50:44.642837-05	\N	\N
625	1396	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_cuota_empleo_ministerios_2022_/wms?	peru_cuota_empleo_ministerios_2022_	En la PCM y Ministerios	t	32295	1	2026-01-07 09:50:44.642837-05	\N	\N
626	897	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250923122511___3_Cajeros_corresponsales_Dic2024/wms?	capa_000000_2066	Cajeros Corresponsales del Sistema Financiero (POS)	t	41406	1	2026-01-07 09:50:44.642837-05	\N	\N
627	158	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_centro_acopio_/wms?	peru_sitios_interes_centro_acopio_	Centro de Acopio	t	2810	1	2026-01-07 09:50:44.642837-05	\N	\N
628	834	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/proyectos_inversion_publica_seguridad_ciudadana/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Número de Proyectos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
629	918	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250129112623___Capa8_IE_Sup_Artistica_130125/wms?	capa_000000_1601	I.E. Superior Artística - ESFA	t	40675	1	2026-01-07 09:50:44.642837-05	\N	\N
630	254	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_institu_servir_seguimiento_sst_local_/wms?	peru_institu_servir_seguimiento_sst_local_	Seguimiento a Seguridad y Salud en el Trabajo - Local	t	39279	1	2026-01-07 09:50:44.642837-05	\N	\N
631	13	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619115953___Casos_al_04_de_agosto_del_2024/wms?	capa_000000_1865	Casos al 04 de agosto del 2024	t	41087	1	2026-01-07 09:50:44.642837-05	\N	\N
632	316	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Termoelectricas_Proyectadas/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Centrales termoeléctricas proyectadas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
633	1184	11	https://www.idep.gob.pe/geoportal/services/DATOS_GEOESPACIALES/L%C3%8DMITES/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Límites (Escala 1:100 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
634	863	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_demografica_salud_familiar/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Psicológica y-o Verbal	t	26540	1	2026-01-07 09:50:44.642837-05	\N	\N
635	807	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Psicológica (0 – 17 años)	t	27715	1	2026-01-07 09:50:44.642837-05	\N	\N
636	119	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	INDUSTRIA_SOCIOAMBIENTAL	Industria Socioambiental	t	16200	1	2026-01-07 09:50:44.642837-05	\N	\N
744	916	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250606174539___Capa2_IE_Primaria_130125/wms?	capa_000000_1810	I.E. Primaria	t	40978	1	2026-01-07 09:50:44.642837-05	\N	\N
638	1033	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-2000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
639	1195	11	https://www.idep.gob.pe/geoportal/services/MAPA_BASE/PER%C3%9A_RASTER_25K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	PERÚ_RASTE R_25K	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
640	825	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Física (18 – 59 años)	t	27722	1	2026-01-07 09:50:44.642837-05	\N	\N
641	779	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que disponen al menos un equipo informático operativas y propias	t	27694	1	2026-01-07 09:50:44.642837-05	\N	\N
642	1079	11	https://geosnirh.ana.gob.pe/server/services/Emergencias/Poblaciones_vulnerables_2016_2017/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Poblaciones Vulnerables por Activación de Quebradas	t	38841	1	2026-01-07 09:50:44.642837-05	\N	\N
643	136	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250730115806___Otros_jul25/wms?	capa_000000_1988	Otros	t	41260	1	2026-01-07 09:50:44.642837-05	\N	\N
644	344	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Recurso_Energetico_Renovable_Pto/MapServer/generateKml	0	Unidades fiscalizables - Recurso energético renovable (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
645	1313	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_desmbolso_modalidad_avn_reconst_2022_/wms?	peru_finan_desmbolso_modalidad_avn_reconst_2022_	Modalidad AVN Reconstrucción (AVN-r)	t	38335	1	2026-01-07 09:50:44.642837-05	\N	\N
646	651	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_006_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Junio.	t	41871	1	2026-01-07 09:50:44.642837-05	\N	\N
647	909	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250923155329___2_Mujeres_Adultas_cuenta_Dic2024/wms?	capa_000000_2069	Porcentaje de mujeres adultas con cuenta en el sistema financiero	t	41409	1	2026-01-07 09:50:44.642837-05	\N	\N
648	252	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_dini_20oct_nac_/wms?	peru_dini_20oct_nac_	Nacional	t	4954	1	2026-01-07 09:50:44.642837-05	\N	\N
649	187	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_local_comunal_otros_/wms?	peru_sitios_interes_local_comunal_otros_	Local Comunal y Otros	t	2802	1	2026-01-07 09:50:44.642837-05	\N	\N
650	1618	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
651	747	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_07/04_07_003_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Variable de Índice de Humedad 03 Década del mes.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
652	1095	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Turistico/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Turístico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
653	628	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Septiembre	t	4821	1	2026-01-07 09:50:44.642837-05	\N	\N
654	351	11	https://geoservicios.iiap.gob.pe/geoserver/publicaciones_cientificas/wms?request=Getcapabilities&service=WMS	0	Servicio de mapa de publicaciones de la Amazonía	t	41391	1	2026-01-07 09:50:44.642837-05	\N	\N
655	1418	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250710170913___Capa3_Foncodes_Mayo2025/wms?	capa_000000_1946	FONCODES	t	41210	1	2026-01-07 09:50:44.642837-05	\N	\N
656	1361	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_prom_cons_prod_hidrobiol_2023_/wms?	peru_econo_prom_cons_prod_hidrobiol_2023_	Promoción de Consumos de Productos Hidrobiológicos - 2023	t	39049	1	2026-01-07 09:50:44.642837-05	\N	\N
657	771	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centro_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Centro de Emergencia Mujer	t	26519	1	2026-01-07 09:50:44.642837-05	\N	\N
658	366	12	https://ide.igp.gob.pe/geoserver/PGA/wfs?request=GetCapabilities&service=WFS	0	Mapa de sacudimiento teórico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
659	753	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_mapeo_de_procedencia/wms?service=WMS&request=GetCapabilities	0	Mapeo de Lugar de Procedencia de la Población Penitenciaria	t	41954	1	2026-01-07 09:50:44.642837-05	\N	\N
660	1241	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_departamental_dic23&maxFeatures=1000&	0	Red vial departamental 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
661	166	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_complejo_/wms?	peru_sitios_interes_complejo_	Complejo	t	2806	1	2026-01-07 09:50:44.642837-05	\N	\N
662	1628	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
663	766	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de Fotocopiadoras propias y operativas	t	27683	1	2026-01-07 09:50:44.642837-05	\N	\N
664	830	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Sexual (0 – 17 años)	t	27702	1	2026-01-07 09:50:44.642837-05	\N	\N
665	995	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510162356___Atendidos_INR_Proced_Sexo_xprov_2023/wms?	capa_000000_852	Pacientes INR atendidos según sexo - Provincial	t	39684	1	2026-01-07 09:50:44.642837-05	\N	\N
666	837	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Radio fijo base- Propio y operativo	t	27688	1	2026-01-07 09:50:44.642837-05	\N	\N
667	217	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_pob_servicios_viv_tierra_/wms?	data_pob_servicios_viv_tierra_	Viviendas con Piso de Tierra	t	949	1	2026-01-07 09:50:44.642837-05	\N	\N
668	1511	11	https://ider.regionucayali.gob.pe/geoservicios/services/dgt/area_politicos_administrativo/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Área Político Administrativa	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
669	956	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510171540___Mujeres_Superior_CNV_oct2023/wms?	capa_000000_859	Mujeres con nivel de instrucción superior	t	39691	1	2026-01-07 09:50:44.642837-05	\N	\N
670	1009	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625115303___Competencias_Laborales_Oct_Dic_2024/wms?	capa_000000_1904	Certificación de competencias laborales (Oct - Dic 2024)	t	41134	1	2026-01-07 09:50:44.642837-05	\N	\N
671	611	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_06/01_06_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia Olas de Calor - Otoño	t	41537	1	2026-01-07 09:50:44.642837-05	\N	\N
672	317	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Area_Concesion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Concesiones de distribución eléctrica	t	41980	1	2026-01-07 09:50:44.642837-05	\N	\N
673	1082	11	https://geosnirh.ana.gob.pe/server/services/Público/PrincipalesPresas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Principales Presas	t	38799	1	2026-01-07 09:50:44.642837-05	\N	\N
674	620	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Enero	t	38988	1	2026-01-07 09:50:44.642837-05	\N	\N
675	746	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_07/04_07_002_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Variable de Índice de Humedad 02 Década del mes.	t	41818	1	2026-01-07 09:50:44.642837-05	\N	\N
676	1029	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Reconocimiento 1-35000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
677	495	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_001_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Enero.	t	41666	1	2026-01-07 09:50:44.642837-05	\N	\N
678	296	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Conflictos_Socioambientales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Conflictos socioambientales - Mesas de diálogo	t	42020	1	2026-01-07 09:50:44.642837-05	\N	\N
679	895	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_banco_agencias_/wms?	peru_banco_agencias_	Agencias	t	19001	1	2026-01-07 09:50:44.642837-05	\N	\N
680	103	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022084142___Casos_al_29_de_setiembre_del_2025/wms?	capa_000000_2305	Casos al 29 de setiembre del 2025	t	41677	1	2026-01-07 09:50:44.642837-05	\N	\N
681	613	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_06/01_06_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia Olas de Calor - Verano	t	41536	1	2026-01-07 09:50:44.642837-05	\N	\N
682	1564	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
683	463	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_007_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Julio.	t	41719	1	2026-01-07 09:50:44.642837-05	\N	\N
684	207	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_cenagro_sea_capacitacion_/wms?	peru_cenagro_sea_capacitacion_	Productores - SEA	t	1147	1	2026-01-07 09:50:44.642837-05	\N	\N
685	1033	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-2000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
686	1679	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251211154851___Total_Becarios_2017/wms?	capa_000000_2658	Becas otorgadas año 2017	t	42065	1	2026-01-07 09:50:44.642837-05	\N	\N
687	640	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_01/02_01_002_03_001_512_1983_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 82 - 83 - Precipitación EFM	t	41556	1	2026-01-07 09:50:44.642837-05	\N	\N
688	1042	12	https://geosnirh.ana.gob.pe/server/services/ws_UnidadesHidro/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	UnidadesHidrograficas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
689	1492	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908103721___bosques_prep_sm/wms?	capa_22_4	Bosques preparados	t	41371	1	2026-01-07 09:50:44.642837-05	\N	\N
690	440	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_014_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Estación de Verano.	t	41645	1	2026-01-07 09:50:44.642837-05	\N	\N
691	47	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804125638___Casos_al_14_de_abril_del_2023/wms?	capa_A00012_336	Casos al 14 de abril del 2023	t	38139	1	2026-01-07 09:50:44.642837-05	\N	\N
692	57	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230808161843___Casos_al_16_de_junio_del_2023/wms?	capa_A00012_347	Casos al 16 de junio del 2023	t	38152	1	2026-01-07 09:50:44.642837-05	\N	\N
693	1328	11	https://gisprd.sedapal.com.pe/arcgis/services/movilCC/MapServer/WMSServer?request=GetCapabilities&service=WMS	1	Vías	t	8311	1	2026-01-07 09:50:44.642837-05	\N	\N
694	1514	12	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_1101/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Division admnistrativa del bosque(bloques quinquenales, parcela de corta)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
695	911	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240417164102___Direcciones_Regionales_13nov2023/wms?	capa_000000_685	Dirección Regional de Educación (DRE)	t	39505	1	2026-01-07 09:50:44.642837-05	\N	\N
696	513	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_002_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Febrero.	t	41748	1	2026-01-07 09:50:44.642837-05	\N	\N
697	279	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioEcosistemas_MINAM/MapServer	0	Ecosistemas	t	23813	1	2026-01-07 09:50:44.642837-05	\N	\N
698	1631	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2022/peru_pech_007_red_pozos_monitoreo_casub_2022/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2022 - Descenso	t	41933	1	2026-01-07 09:50:44.642837-05	\N	\N
699	1510	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/ZEE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Zonificación Ecológica y Económica	t	36959	1	2026-01-07 09:50:44.642837-05	\N	\N
700	997	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818232750___Capacitacion_Laboral_Abril_Junio_2025/wms?	capa_000000_2015	Capacitación laboral (Abril - Junio 2025)	t	41298	1	2026-01-07 09:50:44.642837-05	\N	\N
701	685	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_99/01_99_002_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Periodo Retorno Sequías - 2019 - Retorno SPI (Severa)	t	41554	1	2026-01-07 09:50:44.642837-05	\N	\N
702	583	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/wms?request=GetCapabilities&service=WMS	0	Energía Solar	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
703	3	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_vraem_ambito_/wms?	peru_vraem_ambito_	Ámbito VRAEM	t	1205	1	2026-01-07 09:50:44.642837-05	\N	\N
704	988	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240422153512___DIST/wms?	capa_000000_714	Pacientes atendidos en el INR por mes - Nivel Distrital	t	39534	1	2026-01-07 09:50:44.642837-05	\N	\N
705	11	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618174446___Casos_al_03_de_marzo_del_2025/wms?	capa_000000_1857	Casos al 03 de marzo del 2025	t	41079	1	2026-01-07 09:50:44.642837-05	\N	\N
706	681	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_006_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Después de 1960 (1990)	t	41550	1	2026-01-07 09:50:44.642837-05	\N	\N
707	643	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_02/02_02_002_03_001_512_1998_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 97 - 98 - Precipitación EFM	t	41558	1	2026-01-07 09:50:44.642837-05	\N	\N
708	484	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_011_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Noviembre.	t	41624	1	2026-01-07 09:50:44.642837-05	\N	\N
709	787	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_hogares/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Confianza en Institución - Ministerio Público	t	26535	1	2026-01-07 09:50:44.642837-05	\N	\N
710	1001	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625115124___Capacitacion_Laboral_Oct_Dic_2024/wms?	capa_000000_1903	Capacitación laboral (Oct - Dic 2024)	t	41133	1	2026-01-07 09:50:44.642837-05	\N	\N
711	1317	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Accesorios	Accesorios	t	8318	1	2026-01-07 09:50:44.642837-05	\N	\N
712	140	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721170227___EDICION_5/wms?	capa_000000_1968	Programa Niñas Digitales - Edición 5	t	41236	1	2026-01-07 09:50:44.642837-05	\N	\N
713	312	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Areas_Degradadas_RRSS_Municipales/MapServer/generateKml	0	Unidades fiscalizables - Áreas degradadas por RRSS municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
714	1622	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
715	1306	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSSMU/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EPSSMU	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
716	1021	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250826150110___prog_llamkasun_jul25/wms?	capa_000000_2025	Empleos temporales - Julio 2025	t	41325	1	2026-01-07 09:50:44.642837-05	\N	\N
717	344	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Recurso_Energetico_Renovable_Pto/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Recurso energético renovable (punto)	t	41976	1	2026-01-07 09:50:44.642837-05	\N	\N
718	1584	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
719	113	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251014152619___Educacion/wms?	capa_000000_2134	Educación	t	41501	1	2026-01-07 09:50:44.642837-05	\N	\N
720	734	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Julio.	t	41781	1	2026-01-07 09:50:44.642837-05	\N	\N
721	931	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231107161317___redacis_cismid/wms?	capa_A00044_0	Estaciones acelerográficas	t	39158	1	2026-01-07 09:50:44.642837-05	\N	\N
722	401	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_07/wms?request=GetCapabilities&service=WMS	0	Cambio Climático (Proyección de Disponibilidad Hídrica 2030)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
723	1464	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_V_Bioecologico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM V Bioecológico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
724	1221	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_jne_departamento_/wms?	peru_jne_departamento_	Participación Electoral - Regiones	t	1070	1	2026-01-07 09:50:44.642837-05	\N	\N
725	1061	12	https://geosnirh.ana.gob.pe/server/services/Público/Consejos_de_Cuencas/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Consejos de Recursos Hidricos de Cuenca	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
726	633	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_04/02_04_002_03_001_512_2017_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2017 - Precipitación EFM	t	41560	1	2026-01-07 09:50:44.642837-05	\N	\N
727	618	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Agosto	t	38995	1	2026-01-07 09:50:44.642837-05	\N	\N
728	177	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240813094033___Orden_urbano/wms?	capa_000000_1100	Esquema de Ordenamiento Urbano	t	40001	1	2026-01-07 09:50:44.642837-05	\N	\N
729	1105	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Inventario_Forestal/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ecosistemas frágiles	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
730	473	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_017_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Estación de Primavera.	t	41629	1	2026-01-07 09:50:44.642837-05	\N	\N
731	1343	11	https://geoservidor.fondepes.gob.pe/geoserver/FONDEPES/Infraestructura%20Pesquera%20Artesanal/wms?service=WMS&version=1.3.0&request=GetCapabilities	0	Infraestructura Pesquera Artesanal	t	35754	1	2026-01-07 09:50:44.642837-05	\N	\N
732	940	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510151531___Ignorado_dist_ene_oct2023/wms?	capa_000000_847	Defunciones personas no identificadas	t	39679	1	2026-01-07 09:50:44.642837-05	\N	\N
733	1471	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230301172825___pat_truji_comunidades_campesinas/wms?	capa_1301_214	Comunidades Campesinas	t	35708	1	2026-01-07 09:50:44.642837-05	\N	\N
734	702	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_013_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Anual.	t	41813	1	2026-01-07 09:50:44.642837-05	\N	\N
735	330	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Lineas_Transmision_Proyectada/MapServer/generateKml	0	Unidades fiscalizables - Línea de transmisión proyectada	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
736	53	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231003110535___Casos_al_15_de_setiembre_del_2023/wms?	capa_A00012_362	Casos al 15 de setiembre del 2023	t	38884	1	2026-01-07 09:50:44.642837-05	\N	\N
737	1413	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241119165231___3_Por_Deficiencia_Sensorial_Set2024/wms?	capa_000000_1433	Por tipo de deficiencia en la discapacidad sensorial	t	40440	1	2026-01-07 09:50:44.642837-05	\N	\N
738	737	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Mayo.	t	41779	1	2026-01-07 09:50:44.642837-05	\N	\N
739	1656	11	https://gis.chavimochic.gob.pe/geoserver/redpozos2023/peru_pech_007_red_pozos_monitoreo_avenida_2023/wms?request=GetCapabilities&service=WMS	0	Red Monitoreo de Pozos 2023 - Avenida	t	41926	1	2026-01-07 09:50:44.642837-05	\N	\N
740	1654	11	https://gis.chavimochic.gob.pe/geoserver/redpozos2022/peru_pech_007_red_monitoreo_avenida_estiaje_2022/wms?request=GetCapabilities&service=WMS	0	Red Monitoreo de Pozos 2022 - Avenida	t	41924	1	2026-01-07 09:50:44.642837-05	\N	\N
741	382	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_04/04_04_006_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Mínima 02 Década del mes.	t	41815	1	2026-01-07 09:50:44.642837-05	\N	\N
742	670	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_05/03_05_002_03_000_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Predicción Numérica - Modelo Pp 48 Hrs.	t	41571	1	2026-01-07 09:50:44.642837-05	\N	\N
743	1372	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250520145803___CEM_2024_ECONO/wms?	capa_000000_1737	Violencia Económica o Patrimonial (2024)	t	40858	1	2026-01-07 09:50:44.642837-05	\N	\N
745	45	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231110111556___Casos_al_13_de_octubre_del_2023/wms?	capa_A00012_367	Casos al 13 de octubre del 2023	t	39199	1	2026-01-07 09:50:44.642837-05	\N	\N
746	913	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250130113746___Capa5_IE_Basica_Especial_130125/wms?	capa_000000_1611	I.E. Básica Especial - CEBE	t	40685	1	2026-01-07 09:50:44.642837-05	\N	\N
747	1312	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_desmbolso_modalidad_avn_2022_/wms?	peru_finan_desmbolso_modalidad_avn_2022_	Modalidad Adquisición de Vivienda Nueva (AVN)	t	38334	1	2026-01-07 09:50:44.642837-05	\N	\N
748	1213	11	http://200.60.23.226:8080/geoserver/PCM/wms?service=WMS&request=GetCapabilities	Jaen_Ciudad	Ciudad de Jaén - Cajamarca	t	8533	1	2026-01-07 09:50:44.642837-05	\N	\N
749	1187	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_CARAL/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Caral	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
750	718	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_012_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Diciembre.	t	41798	1	2026-01-07 09:50:44.642837-05	\N	\N
751	343	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Recurso_Energetico_Renovable_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Recurso energético renovable (polígono)	t	41977	1	2026-01-07 09:50:44.642837-05	\N	\N
752	1275	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sistema_urbano_/wms?	peru_sistema_urbano_	Sistema Urbano	t	8078	1	2026-01-07 09:50:44.642837-05	\N	\N
753	1556	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20221209222339___Zonificacion_urbana/wms?	capa_0104_389	Zonificación Urbana	t	30823	1	2026-01-07 09:50:44.642837-05	\N	\N
754	588	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_03/08_03_033_03_001_522_2013_12_31/ows?service=WMS&request=GetCapabilities	0	Erosión Hídrica del Suelo del año 2013.	t	41853	1	2026-01-07 09:50:44.642837-05	\N	\N
755	924	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_locales_educativos_/wms?	peru_locales_educativos_	Locales Educativos	t	5743	1	2026-01-07 09:50:44.642837-05	\N	\N
756	1483	11	http://ide.regionmadrededios.gob.pe/geoserver/idemdd/lugares_poblados/wms?service=WMS&request=GetCapabilities	0	Lugares Poblados Madre de Dios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
757	968	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027175408___Quimico_Distrito_Julio_2025/wms?	capa_000000_2324	Químico por distrito	t	41696	1	2026-01-07 09:50:44.642837-05	\N	\N
758	712	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_011_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Noviembre.	t	41811	1	2026-01-07 09:50:44.642837-05	\N	\N
759	112	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_A00012_128	Demarcación territorial	t	16217	1	2026-01-07 09:50:44.642837-05	\N	\N
760	1674	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251205110234___Total_Becarios_2012/wms?	capa_000000_2652	Becas otorgadas año 2012	t	42059	1	2026-01-07 09:50:44.642837-05	\N	\N
761	1614	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330154313___vaso_de_leche/wms?	capa_24_336	Vaso de Leche	t	35837	1	2026-01-07 09:50:44.642837-05	\N	\N
762	336	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Almacenamiento_GasN/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas almacenamiento de gas natural	t	41997	1	2026-01-07 09:50:44.642837-05	\N	\N
763	1208	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704122100___estacion_meteorologica/wms?	capa_A00052_17	Estación Meteorológica	t	41176	1	2026-01-07 09:50:44.642837-05	\N	\N
764	501	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_011_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Noviembre.	t	41706	1	2026-01-07 09:50:44.642837-05	\N	\N
765	1551	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330154313___vaso_de_leche/wms?	capa_24_336	Vaso de Leche	t	35837	1	2026-01-07 09:50:44.642837-05	\N	\N
766	313	20	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Hidroelectricas_Existentes/generateKml	0	Unidades fiscalizables - Centrales hidroeléctricas existente	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
767	727	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_009_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Septiembre.	t	41795	1	2026-01-07 09:50:44.642837-05	\N	\N
768	372	12	https://ide.igp.gob.pe/geoserver/CTS_alertavolcan/wfs?request=GetCapabilities&service=WFS	0	Volcanes: Nivel de alerta	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
769	1371	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241018101425___CEM_E_2023_ECONO/wms?	capa_000000_1348	Violencia Económica o Patrimonial (2023)	t	40335	1	2026-01-07 09:50:44.642837-05	\N	\N
770	349	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Unidades_Menores_Pto/MapServer/generateKml	0	Unidades fiscalizables - Unid.menores hidrocarburos (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
771	9	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829160902___Casos_al_02_de_junio_del_2025/wms?	capa_000000_2039	Casos al 02 de junio del 2025	t	41346	1	2026-01-07 09:50:44.642837-05	\N	\N
772	24	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619103501___Casos_al_07_de_abril_del_2025/wms?	capa_000000_1861	Casos al 07 de abril del 2025	t	41083	1	2026-01-07 09:50:44.642837-05	\N	\N
773	880	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pip_ppr_030_2_2_ /wms?	peru_pip_ppr_030_2_2_ 	Proyectos - Provincial	t	31188	1	2026-01-07 09:50:44.642837-05	\N	\N
774	256	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_institu_servir_seguimiento_sst_regional_/wms?	peru_institu_servir_seguimiento_sst_regional_	Seguimiento a Seguridad y Salud en el Trabajo - Regional	t	39281	1	2026-01-07 09:50:44.642837-05	\N	\N
775	1088	11	https://geosnirh.ana.gob.pe/server/services/Público/Rios/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ríos	t	30791	1	2026-01-07 09:50:44.642837-05	\N	\N
776	781	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que disponen de servicios básicos adecuados	t	27674	1	2026-01-07 09:50:44.642837-05	\N	\N
777	346	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Subestacion_Distribucion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Subestación de distribución	t	41983	1	2026-01-07 09:50:44.642837-05	\N	\N
778	1044	12	https://geosnirh.ana.gob.pe/server/services/Público/AcreDispHidrica/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Acreditación de Disponibilidad Hídrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
779	1486	11	http://ide.regionmadrededios.gob.pe/geoserver/idemdd/zee/wms?service=WMS&request=GetCapabilities	0	Zonificación Ecológica y Económica	t	36959	1	2026-01-07 09:50:44.642837-05	\N	\N
780	1157	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_inundacion_mmasa_group_/wms?	peru_inundacion_mmasa_group_	Movimientos en masa por lluvias fuertes	t	1186	1	2026-01-07 09:50:44.642837-05	\N	\N
781	293	12	https://geoservicios.sernanp.gob.pe/arcgis/services/servicios_ogc/peru_sernanp_0213/MapServer/WFSServer?SERVICE=WFS&REQUEST=GetCapabilities	0	Zonificación ANP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
782	1472	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230209175920___B_0104_Com_nativas/wms?	capa_0104_536	Comunidades Nativas	t	32237	1	2026-01-07 09:50:44.642837-05	\N	\N
783	947	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_0104_46	Establecimientos de salud	t	2190	1	2026-01-07 09:50:44.642837-05	\N	\N
784	467	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_011_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Noviembre.	t	41723	1	2026-01-07 09:50:44.642837-05	\N	\N
785	196	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/lima_pob_PEA_/wms?	lima_pob_PEA_	PEA	t	1060	1	2026-01-07 09:50:44.642837-05	\N	\N
786	1062	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_DeTransporte/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	De Transporte	t	38806	1	2026-01-07 09:50:44.642837-05	\N	\N
787	626	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Noviembre	t	38998	1	2026-01-07 09:50:44.642837-05	\N	\N
788	798	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Económica o Patrimonial (0 – 17 años)	t	27709	1	2026-01-07 09:50:44.642837-05	\N	\N
789	489	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_015_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Otoño.	t	41710	1	2026-01-07 09:50:44.642837-05	\N	\N
790	1149	12	https://geosinpad.indeci.gob.pe/indeci/services/Emergencias/SDE_EMERGENCIAS_SINPAD_PCM/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Emergencias	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
791	347	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Subestacion_Transmision_Existente/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Subestación de transmision existente	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
792	1035	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-25000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
793	606	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_005_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Mayo	t	41842	1	2026-01-07 09:50:44.642837-05	\N	\N
794	348	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Unidades_Menores_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Unid. menores hidrocarburos (polígono)	t	41994	1	2026-01-07 09:50:44.642837-05	\N	\N
795	707	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Febrero.	t	41801	1	2026-01-07 09:50:44.642837-05	\N	\N
796	673	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_02/03_02_001_03_000_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Pronóstico Climático de Precipitacion Trimestral	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
797	979	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510160522___Vacuna_TDAP_xdist_sep2023/wms?	capa_000000_850	Vacuna para tétanos, toxoide diftérico (TDAP)	t	39682	1	2026-01-07 09:50:44.642837-05	\N	\N
798	1197	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_PUENTE_PIEDRA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Puente Piedra	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
799	790	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Delitos Informáticos	t	26556	1	2026-01-07 09:50:44.642837-05	\N	\N
800	56	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206170133___Casos_al_16_de_diciembre_del_2024/wms?	capa_000000_1631	Casos al 16 de diciembre del 2024	t	40742	1	2026-01-07 09:50:44.642837-05	\N	\N
801	1582	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
802	1004	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240924233022___Competencias_Laborales_Abr_Jun_2024/wms?	capa_000000_1232	Certificación de competencias laborales (Abril - Junio 2024)	t	40174	1	2026-01-07 09:50:44.642837-05	\N	\N
803	1537	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20240429214629___IDH_ambito/wms?	capa_A00034_166	IDH Distrital 2019	t	39636	1	2026-01-07 09:50:44.642837-05	\N	\N
804	680	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_005_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Después de 1960 (1983)	t	41549	1	2026-01-07 09:50:44.642837-05	\N	\N
805	293	11	https://geoservicios.sernanp.gob.pe/arcgis/services/gestion_de_anp/peru_sernanp_0213/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Zonificación ANP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
806	723	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Marzo.	t	41789	1	2026-01-07 09:50:44.642837-05	\N	\N
807	233	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019AlumbradoPublico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Alumbrado público - Tramos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
808	810	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Sexual (0 – 17 años)	t	27703	1	2026-01-07 09:50:44.642837-05	\N	\N
809	1417	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618114201___Capa9_Reporte_Ma_Abr_2025/wms?	capa_000000_1844	Reporte Servicio PUNCHE FAMILIA	t	41065	1	2026-01-07 09:50:44.642837-05	\N	\N
810	608	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_010_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Octubre	t	41847	1	2026-01-07 09:50:44.642837-05	\N	\N
811	671	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_05/03_05_003_03_000_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Predicción Numérica - Modelo Pp 72 Hrs.	t	41572	1	2026-01-07 09:50:44.642837-05	\N	\N
812	278	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioDegradacion_MINAM/MapServer	0	Degradación de ecosistemas 2022	t	41002	1	2026-01-07 09:50:44.642837-05	\N	\N
813	965	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240428164741___Odontologos_XEESS_Feb2024/wms?	capa_000000_798	Odontólogos por EESS	t	39618	1	2026-01-07 09:50:44.642837-05	\N	\N
814	404	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_13/06_13_003_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Precipitación 2050 Otoño.	t	41825	1	2026-01-07 09:50:44.642837-05	\N	\N
815	1596	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
816	731	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_012_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Diciembre.	t	41785	1	2026-01-07 09:50:44.642837-05	\N	\N
817	242	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019TuberiaConexionGN/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Tubería de conexión gas natural	t	40831	1	2026-01-07 09:50:44.642837-05	\N	\N
818	457	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_014_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Estación de Verano.	t	41726	1	2026-01-07 09:50:44.642837-05	\N	\N
819	326	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Establecimientos_Industriales_Pesqueros/MapServer/generateKml	0	Unidades fiscalizables - Industrias pesqueras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
820	1571	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
821	428	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Febrero.	t	41579	1	2026-01-07 09:50:44.642837-05	\N	\N
822	1641	11	https://gis.chavimochic.gob.pe/geoserver/comportamientoce2022/peru_pech_007_ce_periodo_avenida_estiaje_2022/wms?request=GetCapabilities&service=WMS	0	Comportamiento Conductividad Eléctrica 2022 - Estiaje	t	41930	1	2026-01-07 09:50:44.642837-05	\N	\N
823	101	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1129	Casos al 29 de Noviembre 2021	t	19380	1	2026-01-07 09:50:44.642837-05	\N	\N
824	1169	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hidrografía (Escala 1:100 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
825	752	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_mapeo_casos_tb/wms?service=WMS&request=GetCapabilities	0	Mapeo de Lugar de Procedencia de internos con casos TB	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
826	1026	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Reconocimiento 1-20000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
827	652	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_003_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Marzo.	t	41868	1	2026-01-07 09:50:44.642837-05	\N	\N
828	300	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Infraestructura_Residuos_Solidos_Invt/MapServer/generateKml	0	Inventario nacional de áreas de infraestructura de RRSS	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
829	331	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lotes_Gas_Natural/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Lotes de gas natural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
830	655	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_010_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Octubre.	t	41875	1	2026-01-07 09:50:44.642837-05	\N	\N
831	413	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_14/06_14_004_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Mínima 2050 Invierno.	t	41831	1	2026-01-07 09:50:44.642837-05	\N	\N
832	1373	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521103050___CEM_2025_ECONO/wms?	capa_000000_1746	Violencia Económica o Patrimonial (2025)	t	40870	1	2026-01-07 09:50:44.642837-05	\N	\N
833	435	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_009_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Septiembre.	t	41586	1	2026-01-07 09:50:44.642837-05	\N	\N
834	815	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Jurisdicciones Comisarias Básicas	t	41330	1	2026-01-07 09:50:44.642837-05	\N	\N
835	883	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240118151120___CSC_Provincias_2023/wms?	capa_000000_606	Centros de Servicios al Contribuyente - Provincias	t	39422	1	2026-01-07 09:50:44.642837-05	\N	\N
836	1370	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521101708___CEM_2025_REG/wms?	capa_000000_1744	CEM Regulares (2025)	t	40868	1	2026-01-07 09:50:44.642837-05	\N	\N
837	1163	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/CULTURAL_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cultural (Escala 1:500 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
838	477	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_012_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Diciembre.	t	41625	1	2026-01-07 09:50:44.642837-05	\N	\N
839	848	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sustracción de Menores	t	26551	1	2026-01-07 09:50:44.642837-05	\N	\N
840	371	11	http://ide.igp.gob.pe/geoserver/CTS_alertavolcan/wms?request=getcapabilities&service=WMS	0	Volcanes activos y potencialmente activos del Perú	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
841	300	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Infraestructura_Residuos_Solidos_Invt/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Inventario nacional de áreas de infraestructura de RRSS	t	42019	1	2026-01-07 09:50:44.642837-05	\N	\N
842	1458	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/Medio_Fisico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Medio Físico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
843	972	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027180136___Tecnol_Med_Distrito_Julio_2025/wms?	capa_000000_2325	Tecnólogo Médico por distrito	t	41697	1	2026-01-07 09:50:44.642837-05	\N	\N
844	1254	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_terminales_terrestres/wfs?service=wfs&request=GetCapabilities	0	Terminales terrestres	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
845	1475	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_A00013_25	Relieve	t	10981	1	2026-01-07 09:50:44.642837-05	\N	\N
846	635	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_05/02_05_002_03_001_512_2023_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2023 - Precipitación EFM	t	41562	1	2026-01-07 09:50:44.642837-05	\N	\N
847	1481	11	http://ide.regionmadrededios.gob.pe/geoserver/idemdd/lagos/wms?service=WMS&request=GetCapabilities	0	Cuerpos de Agua en Reposo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
848	799	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Económica o Patrimonial (18 – 59 años)	t	27711	1	2026-01-07 09:50:44.642837-05	\N	\N
849	452	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_009_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Septiembre.	t	41640	1	2026-01-07 09:50:44.642837-05	\N	\N
850	1028	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Reconocimiento 1-30000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
851	123	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251014152841___Laboral/wms?	capa_000000_2139	Laboral	t	41506	1	2026-01-07 09:50:44.642837-05	\N	\N
852	339	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Envasadoras_Hidrocarburos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas envasadora de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
853	1097	11	https://geosnirh.ana.gob.pe/server/services/Público/vVertimientos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Vertimientos	t	38802	1	2026-01-07 09:50:44.642837-05	\N	\N
854	1121	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250725093704___Generacion_electrica_Jul25/wms?	capa_000000_1976	Generación Eléctrica	t	41248	1	2026-01-07 09:50:44.642837-05	\N	\N
855	1518	11	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0903/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Puesto de control	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
856	1585	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
857	1059	11	https://geosnirh.ana.gob.pe/server/services/Público/CanalTrasvase/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Canales de Trasvase	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
858	921	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/educacion_superior_tecnico/wms?	educacion_superior_tecnico	I.E. Técnico Prod. - CETPRO	t	354	1	2026-01-07 09:50:44.642837-05	\N	\N
859	386	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_013_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar Anual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
860	973	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240513184941___Tecnol_Med_XEESS_Feb2024/wms?	capa_000000_875	Tecnólogo Médico por EESS	t	39707	1	2026-01-07 09:50:44.642837-05	\N	\N
861	355	11	http://ide.igp.gob.pe/geoserver/SCAH_NDVI/wms?request=getcapabilities&service=WMS	0	Anomalías de NDVI (%) (últimos 30 días)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
862	663	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_01/01_01_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 10 - Tmin Extrema - Junio	t	41516	1	2026-01-07 09:50:44.642837-05	\N	\N
863	1282	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSBARRANCA/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Barranca	t	41020	1	2026-01-07 09:50:44.642837-05	\N	\N
864	1269	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudad_menor_principal_/wms?	peru_ciudad_menor_principal_	Ciudad Menor Principal	t	8074	1	2026-01-07 09:50:44.642837-05	\N	\N
865	87	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230905102702___Casos_al_25_de_agosto_del_2023/wms?	capa_A00012_354	Casos al 25 de agosto del 2023	t	38382	1	2026-01-07 09:50:44.642837-05	\N	\N
866	1167	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hidrografía - Islas (Escala 1:500 000)	t	39450	1	2026-01-07 09:50:44.642837-05	\N	\N
867	48	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619093334___Casos_al_14_de_abril_del_2025/wms?	capa_000000_1860	Casos al 14 de abril del 2025	t	41082	1	2026-01-07 09:50:44.642837-05	\N	\N
868	1212	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704122526___trafico_marino/wms?	capa_A00052_21	Tráfico Marítimo	t	41180	1	2026-01-07 09:50:44.642837-05	\N	\N
869	146	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_calles_/wms?	peru_calles_	Calles	t	1239	1	2026-01-07 09:50:44.642837-05	\N	\N
870	342	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Refinerias_Hidrocarburos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas procesamiento de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
871	1512	11	https://ider.regionucayali.gob.pe/geoservicios/services/dgt/ccpp_categorizados/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Centros poblados	t	37167	1	2026-01-07 09:50:44.642837-05	\N	\N
872	190	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_viv_MATERIAL_/wms?	peru_viv_MATERIAL_	Material de la Vivienda	t	1055	1	2026-01-07 09:50:44.642837-05	\N	\N
873	1137	11	https://sidephdna.distriluz.com.pe/geoserver/CentrosAtencionHidrandina/centrosac_hdna/wms?Request=GetCapabilities&Service=WMS	0	Centros de Atención al Cliente de Hidrandina S.A.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
874	1533	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_salud_maternidad_tnv_m15a19_/wms?	peru_salud_maternidad_tnv_m15a19_	Cambio en tasa de nacidos vivos en mujeres de 15 a 19 años	t	37199	1	2026-01-07 09:50:44.642837-05	\N	\N
875	1122	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_20_20	Hidrocarburos	t	16282	1	2026-01-07 09:50:44.642837-05	\N	\N
876	1358	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_fom_prod_pesq_cons_hum_dir_2023_/wms?	peru_econo_fom_prod_pesq_cons_hum_dir_2023_	Fomento de la Producción Pesquera para el Consumo Humano Directo - 2023	t	39050	1	2026-01-07 09:50:44.642837-05	\N	\N
877	276	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioCoberturaVegetal_MINAM/MapServer	0	Cobertura Vegetal	t	30626	1	2026-01-07 09:50:44.642837-05	\N	\N
878	297	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Denuncias_Ambientales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Denuncias ambientales registradas	t	42022	1	2026-01-07 09:50:44.642837-05	\N	\N
879	925	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625172838___Capa2_EME_Mat_4toPri_2023/wms?	capa_000000_1921	Matemática - Regional	t	41151	1	2026-01-07 09:50:44.642837-05	\N	\N
880	236	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019RedesMediaTension/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Red de media tensión - Estructuras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
881	1495	11	https://portal.regionsanmartin.gob.pe:6443/arcgis/services/IDERSAM/Cuencas_Hidrograficas_ANA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cuencas hidrodráficas (ANA)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
882	1540	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_idh_sec_completa_/wms?	peru_idh_sec_completa_	Población (18 años) con secundaria completa (%)	t	8202	1	2026-01-07 09:50:44.642837-05	\N	\N
883	320	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Consultoras_Ambientales_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Consultoras ambientales (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
884	332	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lotes_Hidrocarburos_Liquidos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Lotes de hidrocarburos líquidos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
885	1651	11	https://gis.chavimochic.gob.pe/geoserver/calidadaguasuperficial2022/peru_pech_007_monitoreo_superficial_anual_2022/wms?request=GetCapabilities&service=WMS	0	Monitoreo Superficial Anual 2022	t	41945	1	2026-01-07 09:50:44.642837-05	\N	\N
886	689	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_04/11_04_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Cacao	t	41880	1	2026-01-07 09:50:44.642837-05	\N	\N
887	1405	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241120181004___4_Por_Nivel_Gravedad_Leve_Set2024/wms?	capa_000000_1436	Por nivel de gravedad leve	t	40443	1	2026-01-07 09:50:44.642837-05	\N	\N
888	147	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_campo_instalacion_deport_/wms?	peru_sitios_interes_campo_instalacion_deport_	Campo o Instalación Deportiva	t	2801	1	2026-01-07 09:50:44.642837-05	\N	\N
889	1617	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
890	342	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Refinerias_Hidrocarburos/MapServer/generateKml	0	Unidades fiscalizables - Plantas procesamiento de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
891	1117	11	http://geoportal.minem.gob.pe/minem/services/WMS/DGER_VISOR/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Centros de carga, centros registrados en la DGER, redes de alta tensión y de media tensión	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
892	181	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_pob_servicios_hogares_sin_internet_/wms?	data_pob_servicios_hogares_sin_internet_	Hogares sin Internet	t	20228	1	2026-01-07 09:50:44.642837-05	\N	\N
893	470	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_013_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Anual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
894	1403	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241212100904___10_Pob_con_nivel_edu_2017/wms?	capa_000000_1493	Población de 3 años a más, por nivel educativo alcanzado (2017)	t	40549	1	2026-01-07 09:50:44.642837-05	\N	\N
895	1675	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251205112756___Total_Becarios_2013/wms?	capa_000000_2653	Becas otorgadas año 2013	t	42060	1	2026-01-07 09:50:44.642837-05	\N	\N
896	1500	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908102726___limite_region_arrfs/wms?	capa_22_2	Límite departamental	t	41369	1	2026-01-07 09:50:44.642837-05	\N	\N
897	350	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_proy_senace_/wms?	peru_proy_senace_	Proyectos del SENACE	t	1104	1	2026-01-07 09:50:44.642837-05	\N	\N
898	1657	11	https://gis.chavimochic.gob.pe/geoserver/redpozos2024/peru_pech_007_red_monitoreo_avenida_estiaje_2024/wms?request=GetCapabilities&service=WMS	0	Red Monitoreo de Pozos 2024 - Avenida	t	41927	1	2026-01-07 09:50:44.642837-05	\N	\N
899	686	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_98/01_98_001_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Tendencia Sequías 1964 - 2019	t	41552	1	2026-01-07 09:50:44.642837-05	\N	\N
900	1460	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_Aptitud_UrbanoJndustrial/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM Aptitud Urbano Industrial	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
901	1154	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_riesgos_minsa_/wms?	peru_riesgos_minsa_	Heladas y friaje sector Salud	t	1178	1	2026-01-07 09:50:44.642837-05	\N	\N
902	312	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_Municipales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Áreas degradadas por RRSS municipales	t	42008	1	2026-01-07 09:50:44.642837-05	\N	\N
903	80	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231003105925___Casos_al_22_de_setiembre_del_2023/wms?	capa_A00012_361	Casos al 22 de setiembre del 2023	t	38883	1	2026-01-07 09:50:44.642837-05	\N	\N
904	1145	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_delitos_vcs_/wms?	peru_delitos_vcs_	Delitos contra la Vida, el Cuerpo y la Salud	t	23895	1	2026-01-07 09:50:44.642837-05	\N	\N
905	870	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pip_ppr_030_3_3_/wms?	peru_pip_ppr_030_3_3_	Actividades - Distrital	t	23735	1	2026-01-07 09:50:44.642837-05	\N	\N
906	325	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Generacion_Aislada_Concesion/MapServer/generateKml	0	Unidades fiscalizables - Generación sistemas eléctricos aislados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
907	1352	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_alimen_nutric_pesca_educa_2023_/wms?	peru_econo_educ_alimen_nutric_pesca_educa_2023_	Educación Alimentaria y Nutricional (PESCAEduca) - 2023	t	39046	1	2026-01-07 09:50:44.642837-05	\N	\N
908	68	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250627143239___Casos_al_19_de_mayo_del_2025/wms?	capa_000000_1934	Casos al 19 de mayo del 2025	t	41168	1	2026-01-07 09:50:44.642837-05	\N	\N
909	773	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarias Básicas	t	41332	1	2026-01-07 09:50:44.642837-05	\N	\N
910	295	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Conflictos_Socioambientales_Area_Influencia/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Conflictos socioambientales - Áreas de influencia	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
911	1186	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_CAÑETE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Cañete	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
912	1032	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-12000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
913	1644	11	https://gis.chavimochic.gob.pe/geoserver/comportamientonf2022/peru_pech_007_nf_periodo_avenida_estiaje_2022/wms?request=GetCapabilities&service=WMS	0	Comportamiento Nivel Freático 2022 - Avenida	t	41920	1	2026-01-07 09:50:44.642837-05	\N	\N
914	1054	12	https://geosnirh.ana.gob.pe/server/services/Público/AutorizacionEjecObras/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Autorización de Ejecución de Obras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
915	1377	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241018105840___CEM_E_2023_SEXUAL/wms?	capa_000000_1352	Violencia Sexual (2023)	t	40339	1	2026-01-07 09:50:44.642837-05	\N	\N
916	220	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_pob_servicios_agua_/wms?	data_pob_servicios_agua_	Viviendas sin Abastecimiento de Agua	t	946	1	2026-01-07 09:50:44.642837-05	\N	\N
917	654	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_011_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Noviembre.	t	41876	1	2026-01-07 09:50:44.642837-05	\N	\N
918	399	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_01/wms?request=GetCapabilities&service=WMS	0	Cambio Climático (Proyección 2030 Anual)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
919	33	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829161001___Casos_al_09_de_junio_del_2025/wms?	capa_000000_2040	Casos al 09 de junio del 2025	t	41347	1	2026-01-07 09:50:44.642837-05	\N	\N
920	1262	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_infraestuctura_nodos_rdnfo_/wms?	peru_infraestuctura_nodos_rdnfo_	Nodos de la Red Nacional	t	23990	1	2026-01-07 09:50:44.642837-05	\N	\N
921	1075	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_OtrosUsos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Otros Usos	t	38811	1	2026-01-07 09:50:44.642837-05	\N	\N
922	1045	11	https://geosnirh.ana.gob.pe/server/services/Público/Acueductos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Acueductos	t	38829	1	2026-01-07 09:50:44.642837-05	\N	\N
923	977	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510155325___Vacuna_Contra_Rotavirus_xdist_sep2023/wms?	capa_000000_848	Vacuna contra Rotavirus	t	39680	1	2026-01-07 09:50:44.642837-05	\N	\N
924	23	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804124640___Casos_al_07_de_abril_del_2023/wms?	capa_A00012_335	Casos al 07 de abril del 2023	t	38138	1	2026-01-07 09:50:44.642837-05	\N	\N
925	1219	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_jne_distrito_/wms?	peru_jne_distrito_	Participación Electoral - Distritos	t	1074	1	2026-01-07 09:50:44.642837-05	\N	\N
926	1077	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Pesquero/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Pesquero	t	38813	1	2026-01-07 09:50:44.642837-05	\N	\N
927	419	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_013_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Anual.	t	41590	1	2026-01-07 09:50:44.642837-05	\N	\N
928	172	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccpp_2_/wms?	peru_ccpp_2_	De 151 a 1,000 Habitantes	t	766	1	2026-01-07 09:50:44.642837-05	\N	\N
929	20	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1206	Casos al 06 de Diciembre 2021	t	19381	1	2026-01-07 09:50:44.642837-05	\N	\N
930	1088	12	https://geosnirh.ana.gob.pe/server/services/Público/Rios/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Ríos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
931	208	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240419093947___Participacion_Cuidadana_Renamu_2022/wms?	capa_000000_700	Programa del Vaso de Leche	t	39520	1	2026-01-07 09:50:44.642837-05	\N	\N
932	309	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Agricultura_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Agricultura (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
933	186	11	https://maps.inei.gob.pe/geoserver/T10Limites/ig_provincia/wms?service=WMS&request=GetCapabilities	0	Límite Provincial	t	35813	1	2026-01-07 09:50:44.642837-05	\N	\N
934	1068	11	https://geosnirh.ana.gob.pe/server/services/Público/SERV_Formalizacion/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Formalización	t	38820	1	2026-01-07 09:50:44.642837-05	\N	\N
935	1446	11	http://geoportal.regionamazonas.gob.pe/geoserver/geonode/wms?service=WMS&request=GetCapabilities&layers=geonode:limite_departamental	0	Límite Departamental	t	36986	1	2026-01-07 09:50:44.642837-05	\N	\N
936	1514	11	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_1101/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Division admnistrativa del bosque(bloques quinquenales, parcela de corta)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
937	966	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027165009___Psicologos_Distrito_Julio_2025/wms?	capa_000000_2310	Psicólogos por distrito	t	41682	1	2026-01-07 09:50:44.642837-05	\N	\N
938	631	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_04/wms?request=GetCapabilities&service=WMS	0	Monitoreo de Temperatura Mínima (Mar)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
939	1273	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_info_gl_pat_2022_/wms?	peru_info_gl_pat_2022_	Plan de Acondicionamiento Territorial	t	1085	1	2026-01-07 09:50:44.642837-05	\N	\N
940	636	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_05/02_05_003_03_001_512_2023_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2023 - Precipitación FMA	t	41563	1	2026-01-07 09:50:44.642837-05	\N	\N
941	1085	11	https://geosnirh.ana.gob.pe/server/services/Público/PuntosdeMuestreo/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Puntos de Muestreo	t	38800	1	2026-01-07 09:50:44.642837-05	\N	\N
942	590	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_04/wms?request=GetCapabilities&service=WMS	0	Evento El Niño / La Niña 2017	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
943	809	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Psicológica (60 años a más)	t	27719	1	2026-01-07 09:50:44.642837-05	\N	\N
944	1503	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/Ordenamiento_forestalWMS/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ordenamiento Forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
945	701	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_99/05_99_001_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Lluvia, Inicio 1964/65 a 2018/19 del Departamento de Puno.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
946	1350	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241210170606___Capa2_Educ_Alimen_Nutric_Coc_Pesc_2024/wms?	capa_000000_1469	Educación Alimentaria y Nutricional (Cocinando con Pescado) - 2024	t	40521	1	2026-01-07 09:50:44.642837-05	\N	\N
947	498	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_006_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Junio.	t	41701	1	2026-01-07 09:50:44.642837-05	\N	\N
948	346	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Subestacion_Distribucion/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Subestación de distribución	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
949	1412	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241119165442___3_Por_Deficiencia_Mental_Set2024/wms?	capa_000000_1435	Por tipo de deficiencia en la discapacidad mental	t	40442	1	2026-01-07 09:50:44.642837-05	\N	\N
950	377	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_05/04_05_005_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Máxima 01 Década del mes.	t	41575	1	2026-01-07 09:50:44.642837-05	\N	\N
951	1278	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAB_AR/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de Alta Resolución de la ciudad de Bagua	t	41017	1	2026-01-07 09:50:44.642837-05	\N	\N
952	283	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioSitiosRAMSAR_MINAM/MapServer	0	Sitios RAMSAR	t	41005	1	2026-01-07 09:50:44.642837-05	\N	\N
953	282	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioRHI_MINAM/MapServer	0	Registro histórico de incendios en la cobertura vegetal	t	41001	1	2026-01-07 09:50:44.642837-05	\N	\N
954	1488	11	https://portal.regionsanmartin.gob.pe/server/services/DRASAM/AMBITO_NARANJA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ámbito de Intervención del "Proyecto Naranja"	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
955	999	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241024122925___Capacitacion_Laboral_Jul_Set_2024/wms?	capa_000000_1378	Capacitación laboral (Jul - Set 2024)	t	40379	1	2026-01-07 09:50:44.642837-05	\N	\N
1766	155	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240711143936___PROV_ICL_IMP/wms?	capa_000000_1011	CCL - Provincial - (Impl.)	t	39895	1	2026-01-07 09:50:44.642837-05	\N	\N
956	604	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_006_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Junio	t	41843	1	2026-01-07 09:50:44.642837-05	\N	\N
957	439	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_017_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Estación de Primavera.	t	41648	1	2026-01-07 09:50:44.642837-05	\N	\N
958	1600	11	https://ws.munilince.gob.pe:9094/geoserver/GEOPERU/peru_munilince_013_vias/wms?service=WMS&request=Getcapabilities\n	0	Vías del distrito de Lince	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
959	243	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019ValvulasGasNatural/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Válvulas de gas natural	t	40832	1	2026-01-07 09:50:44.642837-05	\N	\N
960	1070	11	https://geosnirh.ana.gob.pe/server/services/Público/Glaciares/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Glaciares	t	38825	1	2026-01-07 09:50:44.642837-05	\N	\N
961	762	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/barrioseguro/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Barrio Seguro	t	26517	1	2026-01-07 09:50:44.642837-05	\N	\N
962	1032	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-12000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
963	589	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_03/08_03_034_03_001_522_2014_12_31/ows?service=WMS&request=GetCapabilities	0	Erosión Hídrica del Suelo del año 2014	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
964	483	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Mayo.	t	41618	1	2026-01-07 09:50:44.642837-05	\N	\N
965	317	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Area_Concesion/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Concesiones de distribución eléctrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
966	215	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distnbi_viv_fisinad_/wms?	peru_distnbi_viv_fisinad_	Viv. con Caract. Físicas Inadecuadas	t	1023	1	2026-01-07 09:50:44.642837-05	\N	\N
967	366	11	https://ide.igp.gob.pe/geoserver/PGA/wms?request=GetCapabilities&service=WMS	0	Mapa de sacudimiento teórico	t	41013	1	2026-01-07 09:50:44.642837-05	\N	\N
968	1025	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Reconocimiento 1-100000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
969	50	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829163400___Casos_al_14_de_julio_del_2025/wms?	capa_000000_2045	Casos al 14 de julio del 2025	t	41352	1	2026-01-07 09:50:44.642837-05	\N	\N
970	1179	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/IMAGEN_DRONE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágenes RPA - Frontera Perú - Brasil	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
971	1042	11	https://geosnirh.ana.gob.pe/server/services/ws_UnidadesHidro/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	UnidadesHidrograficas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
972	1620	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
973	917	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250130143935___Capa3_IE_Secundaria_130125/wms?	capa_000000_1612	I.E. Secundaria	t	40686	1	2026-01-07 09:50:44.642837-05	\N	\N
974	39	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022083627___Casos_al_11_de_agosto_del_2025/wms?	capa_000000_2298	Casos al 11 de agosto del 2025	t	41670	1	2026-01-07 09:50:44.642837-05	\N	\N
975	519	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_010_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Octubre.	t	41756	1	2026-01-07 09:50:44.642837-05	\N	\N
976	1060	12	https://geosnirh.ana.gob.pe/server/services/Público/CanalLateral/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Canales Laterales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
977	579	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_05/01_05_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Duración Olas de Calor - Invierno	t	41534	1	2026-01-07 09:50:44.642837-05	\N	\N
978	1452	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_zonas_amortiguamiento/wms?service=WMS&request=GetCapabilities	0	Zonas de amortiguamiento en Áreas Naturales Protegidas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
979	875	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pre_e_00_04_mvcs_/wms?	peru_pre_e_00_04_mvcs_	Actividades y Proyectos - Regional	t	740	1	2026-01-07 09:50:44.642837-05	\N	\N
980	678	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_003_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Antes de 1960 (1956)	t	41547	1	2026-01-07 09:50:44.642837-05	\N	\N
981	157	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_centro_abastos_/wms?	peru_sitios_interes_centro_abastos_	Centro de Abastos	t	2811	1	2026-01-07 09:50:44.642837-05	\N	\N
982	1630	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251009154044___Centros_cobranza_2025/wms?	capa_000000_2130	Centros de cobranza	t	41483	1	2026-01-07 09:50:44.642837-05	\N	\N
983	488	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_016_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Invierno.	t	41711	1	2026-01-07 09:50:44.642837-05	\N	\N
984	1439	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/sicre_anp_nacional_definitivas/wms?service=WMS&request=GetCapabilities	0	Áreas Naturales Protegidas de Administración Nacional Definitiva	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
985	384	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_04/04_04_008_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Mínima Mensual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
986	1605	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_comp_via/wms?request=GetCapabilities&service=WMS	0	Componentes de Vía	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
987	644	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_02/02_02_003_03_001_512_1998_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 97 - 98 - Precipitación FMA	t	41559	1	2026-01-07 09:50:44.642837-05	\N	\N
988	1529	12	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_hab_urb/wfs?service=WFS&version=2.0.0&request=GetCapabilities	0	tg_hab_urb	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
989	238	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019RedesDistribucionGN/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Redes distribución de gas natural	t	40830	1	2026-01-07 09:50:44.642837-05	\N	\N
990	772	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250604162745___comisaria_chepen_prov/wms?	capa_1304_6	Comisarías	t	40962	1	2026-01-07 09:50:44.642837-05	\N	\N
991	1043	11	https://geosnirh.ana.gob.pe/server/services/Público/Autoridad_Administrativa_del_Agua/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	AAA	t	38797	1	2026-01-07 09:50:44.642837-05	\N	\N
992	1271	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_metropoli_nacional_/wms?	peru_metropoli_nacional_	Metrópoli Nacional	t	8068	1	2026-01-07 09:50:44.642837-05	\N	\N
993	920	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250129145655___Capa7_IE_Sup_Tecnologica_130125/wms?	capa_000000_1607	I.E. Superior Tecnológica - IST	t	40681	1	2026-01-07 09:50:44.642837-05	\N	\N
994	145	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250707160811___Directorio_MP_MD_mar2025/wms?	capa_000000_1945	Autoridades por Género	t	41190	1	2026-01-07 09:50:44.642837-05	\N	\N
995	1047	12	https://geosnirh.ana.gob.pe/server/services/Público/Acuiferos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Acuíferos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
996	906	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241105120355___3_Hombres_credito_Dic2023/wms?	capa_000000_1402	Porcentaje de hombres adultos con crédito en el sistema financiero	t	40405	1	2026-01-07 09:50:44.642837-05	\N	\N
997	1194	11	https://www.idep.gob.pe/geoportal/services/MAPA_BASE/PER%C3%9A_RASTER_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	PERÚ_RASTE R_100K	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
998	1619	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_mza_nieva_/wms?	peru_mza_nieva_	Manzanas	t	2657	1	2026-01-07 09:50:44.642837-05	\N	\N
999	5	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231003111250___Casos_al_01_de_setiembre_del_2023/wms?	capa_A00012_364	Casos al 01 de setiembre del 2023	t	38886	1	2026-01-07 09:50:44.642837-05	\N	\N
1000	1112	12	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Unidad_Monitoreo_Satelital/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidad de Monitoreo Satelital	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1001	1253	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_terminales_portuarios_dic23	0	Terminales portuarios y embarcaderos 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1002	1498	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908164703___ESTABLECIMIENTOS_AUTORIZADOS/wms?	capa_22_7	Establecimientos autorizados	t	41374	1	2026-01-07 09:50:44.642837-05	\N	\N
1003	1059	12	https://geosnirh.ana.gob.pe/server/services/Público/CanalTrasvase/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Canales de Trasvase	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1004	1529	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_hab_urb/wms?service=WMS&request=GetCapabilities	0	tg_hab_urb	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1005	313	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Hidroelectricas_Existentes/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Centrales hidroeléctricas existente	t	41974	1	2026-01-07 09:50:44.642837-05	\N	\N
1006	1279	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSSMU_AR/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de Alta Resolución de la ciudad de Bagua Grande	t	41026	1	2026-01-07 09:50:44.642837-05	\N	\N
1007	1465	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_V_Historico_Cultural/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM V Histórico Cultural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1008	1407	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241120181415___4_Por_Nivel_Gravedad_No_Esp_Set2024/wms?	capa_000000_1439	Por nivel de gravedad no especificado	t	40446	1	2026-01-07 09:50:44.642837-05	\N	\N
1009	1027	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Reconocimiento 1-25000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1010	555	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_015_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Otoño.	t	41744	1	2026-01-07 09:50:44.642837-05	\N	\N
1011	183	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_cenec_/wms?	data_cenec_	IV Censo Nacional Económico 2008	t	1037	1	2026-01-07 09:50:44.642837-05	\N	\N
1012	197	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_censo_pesquero_/wms?	peru_censo_pesquero_	Pesquería Artesanal	t	1036	1	2026-01-07 09:50:44.642837-05	\N	\N
1013	331	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Lotes_Gas_Natural/MapServer/generateKml	0	Unidades fiscalizables - Lotes de gas natural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1014	1445	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/zf_ecos_fragiles/wms?service=WMS&request=GetCapabilities	0	Ecosistemas frágiles	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1015	392	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_007_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Julio.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1016	1236	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_estaciones_ferroviarias/wms?service=wms&request=GetCapabilities	0	Estaciones ferroviarias	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1017	614	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_04/03_04_001_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	índice de Radiación UV - 48 Hrs	t	41568	1	2026-01-07 09:50:44.642837-05	\N	\N
1018	1305	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSMOYOBAMBA/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EPSMOYOBAMBA	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1019	232	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019AlumbradoPublico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Alumbrado público - Equipos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1020	349	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Unidades_Menores_Pto/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Unid.menores hidrocarburos (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1021	899	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241105154908___4_Credito_promedio_mujeres_Dic2023/wms?	capa_000000_1404	Crédito promedio en el sistema financiero – mujeres	t	40407	1	2026-01-07 09:50:44.642837-05	\N	\N
1022	1017	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240924233242___Promocion_Autoempleo_Abr_Jun_2024/wms?	capa_000000_1234	Promoción del autoempleo (Abril - Junio 2024)	t	40176	1	2026-01-07 09:50:44.642837-05	\N	\N
1023	1207	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704121852___cartas_nauticas/wms?	capa_A00052_16	Cartas Náuticas	t	41175	1	2026-01-07 09:50:44.642837-05	\N	\N
1024	76	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829163443___Casos_al_21_de_julio_del_2025/wms?	capa_000000_2046	Casos al 21 de julio del 2025	t	41353	1	2026-01-07 09:50:44.642837-05	\N	\N
1025	1227	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_aerodromos_dic22	0	Aeródromos 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1131	1667	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119163124___PAM_Santa_Rosa_2_04_11_2025/wms?	capa_000000_2561	Pasivo ambiental minero Santa Rosa 2	t	41948	1	2026-01-07 09:50:44.642837-05	\N	\N
1026	902	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241112145622___2_Mujeres_afiliadas_SPP_Dic2023/wms?	capa_000000_1415	Mujeres afiliadas al sistema privado de pensiones (% PEA)	t	40422	1	2026-01-07 09:50:44.642837-05	\N	\N
1027	1174	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_TRUJILLO/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imagen Satelital de Trujillo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1028	218	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/indicad_urb_cerros_dist17_/wms?	indicad_urb_cerros_dist17_	Viviendas en Cerros - Distritos	t	2999	1	2026-01-07 09:50:44.642837-05	\N	\N
1029	213	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/lima_pob_P_NOSEGUR_/wms?	lima_pob_P_NOSEGUR_	Sin Seguro de Salud	t	1049	1	2026-01-07 09:50:44.642837-05	\N	\N
1030	363	11	https://ide.igp.gob.pe/geoserver/Suelos/wms?	0	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Suelos	t	39443	1	2026-01-07 09:50:44.642837-05	\N	\N
1031	1224	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250731160931___Atrac_tur_jul2025/wms?	capa_000000_1990	Inventario Turístico	t	41262	1	2026-01-07 09:50:44.642837-05	\N	\N
1032	1307	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSSMU_AR/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EPSSMU_AR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1033	622	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Julio	t	4820	1	2026-01-07 09:50:44.642837-05	\N	\N
1034	1106	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Unidad_Monitoreo_Satelital/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Focos de Calor	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1035	1210	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704122325___faros_boyas/wms?	capa_A00052_19	Faros y Boyas	t	41178	1	2026-01-07 09:50:44.642837-05	\N	\N
1036	964	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027164648___Odontologos_Distrito_Julio_2025/wms?	capa_000000_2308	Odontólogos (Cirujano Dentista) por distrito	t	41680	1	2026-01-07 09:50:44.642837-05	\N	\N
1037	71	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20231110110937___Casos_al_20_de_octubre_del_2023/wms?	capa_A00012_366	Casos al 20 de octubre del 2023	t	39198	1	2026-01-07 09:50:44.642837-05	\N	\N
1038	564	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_006_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Junio.	t	41735	1	2026-01-07 09:50:44.642837-05	\N	\N
1039	753	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_mapeo_de_procedencia/wfs?service=WFS&request=GetCapabilities	0	Mapeo de Lugar de Procedencia de la Población Penitenciaria	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1040	1558	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1041	817	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Microcomercialización	t	26555	1	2026-01-07 09:50:44.642837-05	\N	\N
1042	1419	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250707123426___Capa1_Progr_Soc_Distrito_Mayo2025/wms?	capa_000000_1939	Número de PPSS por distritos	t	41183	1	2026-01-07 09:50:44.642837-05	\N	\N
1043	1178	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/IMAGEN_DRONE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágenes RPA - Frontera Perú - Bolivia	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1044	520	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_009_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Septiembre.	t	41755	1	2026-01-07 09:50:44.642837-05	\N	\N
1045	824	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Física (0 – 17 años)	t	27720	1	2026-01-07 09:50:44.642837-05	\N	\N
1046	274	11	https://serviciobosque.minam.gob.pe/geoserver/servicio_bnb2023/wms	0	Bosque y pérdida de bosques al 2023	t	41007	1	2026-01-07 09:50:44.642837-05	\N	\N
1047	1237	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250925163149___Lineas_ferreas_jun25/wms?	capa_000000_2097	Líneas Férreas	t	41437	1	2026-01-07 09:50:44.642837-05	\N	\N
1048	982	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20221012121736___e_hospital/wms?	capa_0701_74	Hospital	t	28417	1	2026-01-07 09:50:44.642837-05	\N	\N
1049	152	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_info_gl_camu_/wms?	peru_info_gl_camu_	Catastro Municipal	t	1091	1	2026-01-07 09:50:44.642837-05	\N	\N
1050	240	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019SuministrosElectricos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Suministros eléctricos - Acometida	t	40828	1	2026-01-07 09:50:44.642837-05	\N	\N
1051	458	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_004_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Abril.	t	41716	1	2026-01-07 09:50:44.642837-05	\N	\N
1052	358	11	https://ide.igp.gob.pe/geoserver/CTS_sismohistorico/wms?service=WMS&request=GetCapabilities	0	Catálogo Sísmico Histórico de 1471 a 1959	t	39138	1	2026-01-07 09:50:44.642837-05	\N	\N
1053	1246	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_nacional_dic24/wms?service=wms&request=GetCapabilities	0	Red vial nacional 2024	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1054	322	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Derechos_Acuicolas_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Derechos acuícolas (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1055	1297	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR5/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR5	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1056	239	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019SubestacionDistribucionElectrica/MapServer/WMSServer?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities	0	Subestación de distribución eléctrica	t	40821	1	2026-01-07 09:50:44.642837-05	\N	\N
1057	1365	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521105700___CEM_2025_TOTAL/wms?	capa_000000_1750	Casos atendidos total CEM (2025)	t	40874	1	2026-01-07 09:50:44.642837-05	\N	\N
1058	743	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_06/04_06_002_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Variable de Evapotranspiración 02 Década del mes.	t	41817	1	2026-01-07 09:50:44.642837-05	\N	\N
1059	839	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Radio portátil - Propio y operativo	t	27690	1	2026-01-07 09:50:44.642837-05	\N	\N
1060	180	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_pob_servicios_coc_lenia_/wms?	data_pob_servicios_coc_lenia_	Hogares que Cocinan con Leña	t	950	1	2026-01-07 09:50:44.642837-05	\N	\N
1132	1399	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_cuota_empleo_gob_region_2022_/wms?	peru_cuota_empleo_gob_region_2022_	En los Gobiernos Regionales	t	32296	1	2026-01-07 09:50:44.642837-05	\N	\N
1061	346	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Subestacion_Distribucion/MapServer/generateKml	0	Unidades fiscalizables - Subestación de distribución	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1062	1244	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_nacional_dic22/wms?service=wms&request=GetCapabilities	0	Red vial nacional 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1063	1240	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_departamental_dic22/wms?service=wms&request=GetCapabilities	0	Red vial departamental 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1064	326	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Establecimientos_Industriales_Pesqueros/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Industrias pesqueras	t	42006	1	2026-01-07 09:50:44.642837-05	\N	\N
1065	765	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de escáner propios y operativos	t	27681	1	2026-01-07 09:50:44.642837-05	\N	\N
1066	345	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Gasoducto_Aguaytia_Sur/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Sistema de ductos de transporte de gas	t	42000	1	2026-01-07 09:50:44.642837-05	\N	\N
1067	574	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_04/01_04_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Descenso Tmin - Julio	t	41530	1	2026-01-07 09:50:44.642837-05	\N	\N
1068	1363	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241018110302___CEM_E_2023_TOTAL/wms?	capa_000000_1353	Casos atendidos total CEM (2023)	t	40340	1	2026-01-07 09:50:44.642837-05	\N	\N
1069	408	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_15/06_15_004_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Máxima 2050 Invierno.	t	41836	1	2026-01-07 09:50:44.642837-05	\N	\N
1070	1554	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_mza_nieva_/wms?	peru_mza_nieva_	Manzanas	t	2657	1	2026-01-07 09:50:44.642837-05	\N	\N
1071	1300	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAVIGS/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPAVIGS	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1072	1109	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Ordenamiento_Forestal/MapServer/WMSServer	0	Ordenamiento Forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1073	1578	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1074	200	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_info_gl_pdgrc_/wms?	peru_info_gl_pdgrc_	Plan de Gestión de Riesgos de Desastres	t	1089	1	2026-01-07 09:50:44.642837-05	\N	\N
1075	1252	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_terminales_portuarios_dic22	0	Terminales portuarios y embarcaderos 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1076	1517	12	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0803/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Permisos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1077	1524	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_lote/wms?service=WMS&request=GetCapabilities	0	Lotes catastrales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1078	523	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_015_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Estación de Otoño.	t	41611	1	2026-01-07 09:50:44.642837-05	\N	\N
1079	176	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_viv_COMBUSTIBLE_/wms?	peru_viv_COMBUSTIBLE_	Energía o Combustible para Cocinar	t	1056	1	2026-01-07 09:50:44.642837-05	\N	\N
1080	312	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_Municipales/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Áreas degradadas por RRSS municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1081	1123	11	http://geoportal.minem.gob.pe/minem/services/ATLASHIDROL/MAPA_POTENCIAL_TECNICO_Y_PROYECTOS_PRIORITARIOS/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Proyectos con Potencial Hidroeléctrico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1082	184	12	https://maps.inei.gob.pe/geoserver/T10Limites/ig_departamento/ows?service=WFS&request=GetCapabilities	0	Límite Departamental	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1083	266	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_map/wms?service=WMS&request=GetCapabilities	0	cultura_map	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1084	616	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_06/05_06_001_03_001_521_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Mapa de Zonas de Vida.	t	41630	1	2026-01-07 09:50:44.642837-05	\N	\N
1085	138	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721165904___EDICION_3/wms?	capa_000000_1966	Programa Niñas Digitales - Edición 3	t	41233	1	2026-01-07 09:50:44.642837-05	\N	\N
1086	340	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Area_Unidad_Industrial/MapServer/generateKml	0	Unidades fiscalizables - Plantas industriales (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1087	462	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_002_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Febrero.	t	41714	1	2026-01-07 09:50:44.642837-05	\N	\N
1088	1635	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2023/peru_pech_007_red_pozos_monitoreo_casub_2023/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2023 - Estiaje	t	41937	1	2026-01-07 09:50:44.642837-05	\N	\N
1089	88	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619115748___Casos_al_25_de_agosto_del_2024/wms?	capa_000000_1862	Casos al 25 de agosto del 2024	t	41084	1	2026-01-07 09:50:44.642837-05	\N	\N
1090	1552	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1091	576	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_04/01_04_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Descenso Tmin - Mayo	t	41528	1	2026-01-07 09:50:44.642837-05	\N	\N
1092	1553	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230220104232___LotesCatastralesMsbGeoPeru/wms?	capa_150130_5	Lotes Catastrales	t	32288	1	2026-01-07 09:50:44.642837-05	\N	\N
1093	130	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_centros_mac_expres_pias_/wms?	peru_centros_mac_expres_pias_	MAC Express PIAS	t	11268	1	2026-01-07 09:50:44.642837-05	\N	\N
1094	1055	11	https://geosnirh.ana.gob.pe/server/services/Público/vVertimientos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Autorización de Vertimientos de Aguas Residuales Tratadas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1095	518	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_011_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Noviembre.	t	41757	1	2026-01-07 09:50:44.642837-05	\N	\N
1096	474	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_014_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Estación de Verano.	t	41626	1	2026-01-07 09:50:44.642837-05	\N	\N
1097	1362	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241210174946___Capa4_Promocion_Cons_Prod_Hidrobiol_2024/wms?	capa_000000_1471	Promoción de Consumos de Productos Hidrobiológicos - 2024	t	40523	1	2026-01-07 09:50:44.642837-05	\N	\N
1098	151	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_violenciagenero_femenicidios_/wms?	peru_violenciagenero_femenicidios_	Casos de Feminicidio	t	843	1	2026-01-07 09:50:44.642837-05	\N	\N
1099	1447	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/cb_distritos/wms?service=WMS&request=GetCapabilities	0	Límite Distrital	t	35815	1	2026-01-07 09:50:44.642837-05	\N	\N
1100	1504	11	https://portal.regionsanmartin.gob.pe/server/services/DRASAM/Parcelas_y_Modulos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Parcelas demostrativa s e investigación y Módulos de post-cosecha del proyecto Cacao	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1101	1319	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAL/MapServer/WMSServer?request=GetCapabilities&service=WMS	Colectores por presión	Colectores por presión	t	8319	1	2026-01-07 09:50:44.642837-05	\N	\N
1102	316	20	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Termoelectricas_Proyectadas/generateKml	0	Unidades fiscalizables - Centrales termoeléctricas proyectadas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1103	1616	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1104	1128	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240424145726___CENTRALES_DE_GENERACION/wms?	capa_000000_751	Centros de generación	t	39571	1	2026-01-07 09:50:44.642837-05	\N	\N
1105	1046	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Acuicola/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Acuícola	t	38804	1	2026-01-07 09:50:44.642837-05	\N	\N
1106	303	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_oefa_oleoducto_/wms?	peru_oefa_oleoducto_	Oleoducto Nor Peruano	t	18996	1	2026-01-07 09:50:44.642837-05	\N	\N
1107	571	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_98/05_98_001_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización del Inicio de Lluvias del Departamento de Puno.	t	41764	1	2026-01-07 09:50:44.642837-05	\N	\N
1108	160	11	https://maps.inei.gob.pe/geoserver/T10Limites/ig_cpoblado/wms?service=WMS&request=GetCapabilities	0	Centro Poblado (ámbito geográfico)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1109	952	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027164420___Medicos_Distrito_Julio_2025/wms?	capa_000000_2306	Médicos por distrito	t	41678	1	2026-01-07 09:50:44.642837-05	\N	\N
1110	1226	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241227094410___Plan_Copesco_dic24/wms?	capa_000000_1530	Proyectos Plan COPESCO Nacional	t	40595	1	2026-01-07 09:50:44.642837-05	\N	\N
1111	59	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618172655___Casos_al_17_de_febrero_del_2025/wms?	capa_000000_1850	Casos al 17 de febrero del 2025	t	41072	1	2026-01-07 09:50:44.642837-05	\N	\N
1112	333	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Derechos_Mineros/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Minería	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1113	540	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_014_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Verano.	t	41662	1	2026-01-07 09:50:44.642837-05	\N	\N
1114	1036	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-45000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1115	193	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pob_mujer_/wms?	peru_pob_mujer_	Mujer	t	1048	1	2026-01-07 09:50:44.642837-05	\N	\N
1116	287	11	https://geoservicios.sernanp.gob.pe/arcgis/services/base_fisica/peru_sernanp_0102/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Área de Conservación Regional	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1117	761	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pronacej_soa_/wms?	peru_pronacej_soa_	Servicio de Orientación al Adolescente (SOA)	t	23916	1	2026-01-07 09:50:44.642837-05	\N	\N
1118	164	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240626145525___CLUB_MADRES/wms?	capa_000000_950	Club de Madres	t	39833	1	2026-01-07 09:50:44.642837-05	\N	\N
1119	856	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Victimización con Arma de Fuego	t	26521	1	2026-01-07 09:50:44.642837-05	\N	\N
1120	66	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1018	Casos al 18 de Octubre 2021	t	16284	1	2026-01-07 09:50:44.642837-05	\N	\N
1121	373	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_02/04_02_005_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Precipitación 01 Década del mes.	t	41573	1	2026-01-07 09:50:44.642837-05	\N	\N
1122	1314	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_desmbolso_modalidad_csp_2022_/wms?	peru_finan_desmbolso_modalidad_csp_2022_	Modalidad Construcción en Sitio Propio (CSP)	t	38332	1	2026-01-07 09:50:44.642837-05	\N	\N
1123	1332	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Áreas de Derechos Acuícolas	t	8323	1	2026-01-07 09:50:44.642837-05	\N	\N
1124	314	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Hidroelectricas_Proyectadas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Centrales hidroeléctricas proyectada	t	41975	1	2026-01-07 09:50:44.642837-05	\N	\N
1125	704	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Agosto.	t	41807	1	2026-01-07 09:50:44.642837-05	\N	\N
1126	1368	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241017150351___CEM_2023_REGULAR/wms?	capa_000000_1341	CEM Regulares (2023)	t	40327	1	2026-01-07 09:50:44.642837-05	\N	\N
1127	820	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Económica o Patrimonial (60 años a más)	t	27712	1	2026-01-07 09:50:44.642837-05	\N	\N
1128	362	11	https://ide.igp.gob.pe/geoserver/Geomorfologia/wms?	0	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Geomorfología	t	39440	1	2026-01-07 09:50:44.642837-05	\N	\N
1129	1415	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_discapacidad_regiones_/wms?	peru_discapacidad_regiones_	Según Regiones	t	27876	1	2026-01-07 09:50:44.642837-05	\N	\N
1130	224	11	https://geoservicios.devida.gob.pe/arcgis_server/rest/services/Geoperu/Geoperu_v2/MapServer/3	0	Densidad de Cultivos de Coca 2012-2020	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1626	1159	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_suscep_heladas_group_/wms?	peru_suscep_heladas_group_	Riesgos por heladas	t	1187	1	2026-01-07 09:50:44.642837-05	\N	\N
1133	449	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_005_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Mayo.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1134	1281	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAVIGS/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Bagua Grande	t	41025	1	2026-01-07 09:50:44.642837-05	\N	\N
1135	476	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Agosto.	t	41621	1	2026-01-07 09:50:44.642837-05	\N	\N
1136	194	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pob_P_ALFABET_/wms?	peru_pob_P_ALFABET_	No Sabe Escribir/Leer	t	1050	1	2026-01-07 09:50:44.642837-05	\N	\N
1137	1391	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241211201433___15_Pob_con_sin_ac_agua_2023/wms?	capa_000000_1487	% Población que tiene acceso a agua potable (2014 al 2023)	t	40543	1	2026-01-07 09:50:44.642837-05	\N	\N
1138	1078	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Poblacional/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Poblacional	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1139	286	11	https://geoservicios.sernanp.gob.pe/arcgis/services/base_fisica/peru_sernanp_0102/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Área de Conservación Privada	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1140	1462	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_Peligros_Poten_Multiples/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM Peligros Potenciales Múltiples	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1141	985	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128161609___Afiliados_reg_finan_oct2025/wms?	capa_000000_2642	Afiliados activos por régimen de financiamiento	t	42038	1	2026-01-07 09:50:44.642837-05	\N	\N
1142	1375	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521091849___CEM_2024_PSICO/wms?	capa_000000_1740	Violencia Psicológica (2024)	t	40863	1	2026-01-07 09:50:44.642837-05	\N	\N
1143	1011	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818233037___Moodle_Abril_Junio_2025/wms?	capa_000000_2017	Moodle (Abril - Junio 2025)	t	41300	1	2026-01-07 09:50:44.642837-05	\N	\N
1144	1676	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251205115720___Total_Becarios_2014/wms?	capa_000000_2654	Becas otorgadas año 2014	t	42061	1	2026-01-07 09:50:44.642837-05	\N	\N
1145	617	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Abril	t	38991	1	2026-01-07 09:50:44.642837-05	\N	\N
1146	17	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804143040___Casos_al_05_de_mayo_del_2023/wms?	capa_A00012_339	Casos al 05 de mayo del 2023	t	38142	1	2026-01-07 09:50:44.642837-05	\N	\N
1147	1225	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/puntos_atencion_iperu_/wms?	puntos_atencion_iperu_	Puntos de atención IPERÚ	t	39157	1	2026-01-07 09:50:44.642837-05	\N	\N
1148	1339	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Solicitud de Habilitación Acuática	t	8331	1	2026-01-07 09:50:44.642837-05	\N	\N
1149	1084	12	https://geosnirh.ana.gob.pe/server/services/Público/PuntosCriticos/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Puntos Críticos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1150	1519	11	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_1201/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Registro forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1151	1199	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_100K/MapServer/WMSServer?request=getcapabilities&service=WMS	2	Río Lineal	t	39031	1	2026-01-07 09:50:44.642837-05	\N	\N
1152	507	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_017_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Primavera.	t	41763	1	2026-01-07 09:50:44.642837-05	\N	\N
1153	1076	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Pecuario/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Pecuario	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1154	185	11	https://maps.inei.gob.pe/geoserver/T10Limites/ig_distrito/wms?service=WMS&request=GetCapabilities	0	Límite Distrital	t	35815	1	2026-01-07 09:50:44.642837-05	\N	\N
1155	229	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250901112938___Capa3_Entel_1er_Trim_2025/wms?	capa_000000_2054	Entel	t	41361	1	2026-01-07 09:50:44.642837-05	\N	\N
1156	241	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019SuministrosElectricos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Suministros eléctricos - Suministro	t	40829	1	2026-01-07 09:50:44.642837-05	\N	\N
1157	469	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_009_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Septiembre.	t	41721	1	2026-01-07 09:50:44.642837-05	\N	\N
1158	1060	11	https://geosnirh.ana.gob.pe/server/services/Público/CanalLateral/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Canales Laterales	t	38837	1	2026-01-07 09:50:44.642837-05	\N	\N
1159	853	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Trata de Personas	t	26549	1	2026-01-07 09:50:44.642837-05	\N	\N
1160	767	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de impresoras propias y operativas	t	27680	1	2026-01-07 09:50:44.642837-05	\N	\N
1161	1577	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1162	472	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_015_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Estación de Otoño.	t	41627	1	2026-01-07 09:50:44.642837-05	\N	\N
1163	867	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251112154547___Comandancias_set2025/wms?	capa_000000_2524	Comandancias departamentales de bomberos	t	41898	1	2026-01-07 09:50:44.642837-05	\N	\N
1164	1115	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241118122131___cp_inversion_miner_2024/wms?	capa_000000_1422	Cartera de Proyectos de Inversión Minera	t	40429	1	2026-01-07 09:50:44.642837-05	\N	\N
1165	1246	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_nacional_dic24&maxFeatures=1000&	0	Red vial nacional 2024	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1166	1543	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_dpto_organiz_/wms?	peru_epci_dpto_organiz_	Componente de Organización	t	1164	1	2026-01-07 09:50:44.642837-05	\N	\N
1167	195	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240711145758___JUVENIL/wms?	capa_000000_1014	Organizaciones Juveniles	t	39898	1	2026-01-07 09:50:44.642837-05	\N	\N
1168	632	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_04/02_04_001_03_001_512_2017_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2017 - Precipitación DEF	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1169	992	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510165018___Atendidos_INR_Proced_Edad_xprov_2023/wms?	capa_000000_855	Pacientes INR atendidos según grupos de edad - Provincial	t	39687	1	2026-01-07 09:50:44.642837-05	\N	\N
1170	585	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_03/08_03_030_03_001_522_2010_12_31/ows?service=WMS&request=GetCapabilities	0	Erosión Hídrica del Suelo del año 2010.	t	41850	1	2026-01-07 09:50:44.642837-05	\N	\N
1171	1019	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250625121303___Autoempleo_Productivo_Oct_Dic_2024/wms?	capa_000000_1909	Promoción del autoempleo productivo (Oct - Dic 2024)	t	41139	1	2026-01-07 09:50:44.642837-05	\N	\N
1172	1515	11	https://ider.regionucayali.gob.pe/geoservicios/services/dgt/hidrografia/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hidrografía	t	1292	1	2026-01-07 09:50:44.642837-05	\N	\N
1173	1093	11	https://geosnirh.ana.gob.pe/server/services/Público/Tomas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Tomas	t	39438	1	2026-01-07 09:50:44.642837-05	\N	\N
1174	347	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Subestacion_Transmision_Existente/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Subestación de transmision existente	t	41984	1	2026-01-07 09:50:44.642837-05	\N	\N
1175	78	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829161153___Casos_al_22_de_junio_del_2025/wms?	capa_000000_2042	Casos al 22 de junio del 2025	t	41349	1	2026-01-07 09:50:44.642837-05	\N	\N
1176	334	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plan_Manejo_RRSS_Municipales/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plan de manejo de RRSS municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1177	610	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_06/01_06_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia Olas de Calor - Invierno	t	41538	1	2026-01-07 09:50:44.642837-05	\N	\N
1178	1272	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_metropoli_regional_/wms?	peru_metropoli_regional_	Metrópoli Regional	t	8069	1	2026-01-07 09:50:44.642837-05	\N	\N
1179	1663	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119092021___PAM_Huacrish_04_11_25/wms?	capa_000000_2529	Pasivo ambiental minero Huacrish	t	41916	1	2026-01-07 09:50:44.642837-05	\N	\N
1180	1173	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_ICA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imagen Satelital de Ica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1181	1548	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_dpto_/wms?	peru_epci_dpto_	EPCI Regional	t	1162	1	2026-01-07 09:50:44.642837-05	\N	\N
1182	1513	12	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0802/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Conseciones	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1183	237	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019RedesMediaTension/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Red de media tensión - Tramos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1184	1220	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_jne_provincia_/wms?	peru_jne_provincia_	Participación Electoral - Provincias	t	1073	1	2026-01-07 09:50:44.642837-05	\N	\N
1185	708	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Julio.	t	41806	1	2026-01-07 09:50:44.642837-05	\N	\N
1186	269	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_reserva_indigena/wms?service=WMS&&version=1.1.0&request=GetCapabilities	0	cultura_reserva_indigena	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1187	754	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_mapeo_de_venezolanos/wfs?service=WFS&request=GetCapabilities	0	Mapeo de Lugar de Procedencia de los Venezolanos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1188	542	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_008_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Agosto.	t	41656	1	2026-01-07 09:50:44.642837-05	\N	\N
1189	385	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Anual	t	39000	1	2026-01-07 09:50:44.642837-05	\N	\N
1190	126	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721160108___LAB_CIVIL/wms?	capa_000000_1959	Laboratorios de la Sociedad Civil	t	41226	1	2026-01-07 09:50:44.642837-05	\N	\N
1191	16	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206171840___Casos_al_04_de_noviembre_del_2024/wms?	capa_000000_1636	Casos al 04 de noviembre del 2024	t	40747	1	2026-01-07 09:50:44.642837-05	\N	\N
1192	1633	11	https://gis.chavimochic.gob.pe/geoserver/redpozoscasub2022/peru_pech_007_red_pozos_monitoreo_casub_2022/wms?request=GetCapabilities&service=WMS	0	Calidad de Agua Subterranea 2022 - Incremento	t	41935	1	2026-01-07 09:50:44.642837-05	\N	\N
1193	1528	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_sectores/wms?service=WMS&request=GetCapabilities	0	Sectores catastrales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1194	31	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022083944___Casos_al_08_de_setiembre_del_2025/wms?	capa_000000_2302	Casos al 08 de setiembre del 2025	t	41674	1	2026-01-07 09:50:44.642837-05	\N	\N
1195	411	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_15/06_15_002_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Máxima 2050 Verano.	t	41834	1	2026-01-07 09:50:44.642837-05	\N	\N
1196	881	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pre_e_00_02_mindef_/wms?	peru_pre_e_00_02_mindef_	Proyectos - Regional	t	707	1	2026-01-07 09:50:44.642837-05	\N	\N
1197	1308	11	https://sig.otass.gob.pe/server/services/CAPAS/WMS_OTASS_AREASINFLUENClA/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	WMSJ3TASS _AREASINFLUENCIA	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1198	609	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_009_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Septiembre	t	41846	1	2026-01-07 09:50:44.642837-05	\N	\N
1199	845	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	RPC - Propio y operativo	t	27693	1	2026-01-07 09:50:44.642837-05	\N	\N
1200	317	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Area_Concesion/MapServer/generateKml	0	Unidades fiscalizables - Concesiones de distribución eléctrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1201	935	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240715160820___un_music/wms?	capa_000000_1031	Universidad Nacional de Música	t	39915	1	2026-01-07 09:50:44.642837-05	\N	\N
1202	1072	11	https://geosnirh.ana.gob.pe/server/services/Público/Lagunas/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Lagunas	t	6578	1	2026-01-07 09:50:44.642837-05	\N	\N
1203	336	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Plantas_Almacenamiento_GasN/MapServer/generateKml	0	Unidades fiscalizables - Plantas almacenamiento de gas natural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1204	612	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_06/01_06_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia Olas de Calor - Primavera	t	41539	1	2026-01-07 09:50:44.642837-05	\N	\N
1205	1090	11	https://geosnirh.ana.gob.pe/server/services/Público/SectorHidraulicoMenorA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sector Menor Clase A	t	38793	1	2026-01-07 09:50:44.642837-05	\N	\N
1206	368	17	https://ide.igp.gob.pe/arcgis/rest/services/monitoreocensis/SismosReportados/MapServer/0	0	Sismos reportados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1207	443	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_012_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Diciembre.	t	41643	1	2026-01-07 09:50:44.642837-05	\N	\N
1208	592	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_02/wms?request=GetCapabilities&service=WMS	0	Evento Niño 97-98	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1209	129	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_centros_mac_expres_muni_/wms?	peru_centros_mac_expres_muni_	MAC Express Municipalidades	t	11270	1	2026-01-07 09:50:44.642837-05	\N	\N
1210	1569	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1211	844	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Robo de Vehículos	t	26522	1	2026-01-07 09:50:44.642837-05	\N	\N
1212	828	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Psicológica (18 – 59 años)	t	27716	1	2026-01-07 09:50:44.642837-05	\N	\N
1213	719	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Enero.	t	41787	1	2026-01-07 09:50:44.642837-05	\N	\N
1214	584	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_03/wms?request=GetCapabilities&service=WMS	0	Erosión del Suelo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1215	755	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_oficinas_regionales/wfs?service=WFS&request=GetCapabilities	0	Oficinas Regionales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1216	357	11	https://ide.igp.gob.pe/geoserver/CTS_sismoinstrumental/wms?service=WMS&request=GetCapabilities	0	Base Histórica de sismos desde 1960	t	39446	1	2026-01-07 09:50:44.642837-05	\N	\N
1217	412	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_14/06_14_001_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Mínima 2050 Anual.	t	41828	1	2026-01-07 09:50:44.642837-05	\N	\N
1218	1678	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251211154812___Total_Becarios_2016/wms?	capa_000000_2657	Becas otorgadas año 2016	t	42064	1	2026-01-07 09:50:44.642837-05	\N	\N
1219	700	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_99/05_99_005_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Lluvia, Fin 1989/90 a 2018/19 del Departamento de Puno.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1220	1461	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_Conflictos_Uso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM Conflictos Uso	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1221	1067	11	https://geosnirh.ana.gob.pe/server/services/Público/FajaMarginal/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Faja Marginal	t	28185	1	2026-01-07 09:50:44.642837-05	\N	\N
1222	729	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Abril.	t	41778	1	2026-01-07 09:50:44.642837-05	\N	\N
1223	821	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Familiar (0 – 17 años)	t	27696	1	2026-01-07 09:50:44.642837-05	\N	\N
1224	1111	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidad de aprovechamiento	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1225	295	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Conflictos_Socioambientales_Area_Influencia/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Conflictos socioambientales - Áreas de influencia	t	42021	1	2026-01-07 09:50:44.642837-05	\N	\N
1226	376	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_02/04_02_008_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Precipitación Mensual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1227	1027	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Reconocimiento 1-25000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1228	1034	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-20000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1229	253	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_actores_politicos_posicion_conflicto_reg_/wms?	peru_actores_politicos_posicion_conflicto_reg_	Regional	t	4951	1	2026-01-07 09:50:44.642837-05	\N	\N
1230	263	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_artes/wms?service=WMS&request=GetCapabilities	0	cultura_arte	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1231	1301	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMUSAP/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMUSAP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1232	115	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251003152833___Gobernabilidad/wms?	capa_000000_2115	Gobernabilidad	t	41465	1	2026-01-07 09:50:44.642837-05	\N	\N
1233	228	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250901105737___Capa2_Claro_1er_Trim_2025/wms?	capa_000000_2052	Claro	t	41359	1	2026-01-07 09:50:44.642837-05	\N	\N
1234	290	11	https://geoservicios.sernanp.gob.pe/arcgis/services/gestion_de_anp/peru_sernanp_021401/MapServer/WMSServer?	0	Zonas de amortiguamiento en Áreas Naturales Protegidas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1235	1268	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudad_menor_/wms?	peru_ciudad_menor_	Ciudad Menor	t	8075	1	2026-01-07 09:50:44.642837-05	\N	\N
1236	493	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_008_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Agosto.	t	41703	1	2026-01-07 09:50:44.642837-05	\N	\N
1237	83	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230808163209___Casos_al_23_de_junio_del_2023/wms?	capa_A00012_348	Casos al 23 de junio del 2023	t	38153	1	2026-01-07 09:50:44.642837-05	\N	\N
1238	1242	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_departamental_jul24/wms?service=wms&request=GetCapabilities	0	Red vial departamental 2024	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1239	1234	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250926104005___Embarcadero_jun25/wms?	capa_000000_2103	Embarcadero	t	41444	1	2026-01-07 09:50:44.642837-05	\N	\N
1240	943	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510150039___Otro_accidente_dist_ene_oct2023/wms?	capa_000000_844	Defunciones por otro accidente	t	39676	1	2026-01-07 09:50:44.642837-05	\N	\N
1241	509	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_004_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Abril.	t	41750	1	2026-01-07 09:50:44.642837-05	\N	\N
1242	841	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Robo	t	26544	1	2026-01-07 09:50:44.642837-05	\N	\N
1243	1429	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250725153759___Usuarios/wms?	capa_000000_1979	Cantidad de usuarios por distrito	t	41251	1	2026-01-07 09:50:44.642837-05	\N	\N
1244	255	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_institu_servir_seguimiento_sst_nacional_/wms?	peru_institu_servir_seguimiento_sst_nacional_	Seguimiento a Seguridad y Salud en el Trabajo - Nacional	t	39280	1	2026-01-07 09:50:44.642837-05	\N	\N
1245	1214	11	http://200.60.23.226:8080/geoserver/PCM/wms?service=WMS&request=GetCapabilities	Tumbes_Ciudad	Ciudad de Tumbes	t	8537	1	2026-01-07 09:50:44.642837-05	\N	\N
1246	1640	11	https://gis.chavimochic.gob.pe/geoserver/comportamientoce2022/peru_pech_007_ce_periodo_avenida_estiaje_2022/wms?request=GetCapabilities&service=WMS	0	Comportamiento Conductividad Eléctrica 2022 - Avenida	t	41929	1	2026-01-07 09:50:44.642837-05	\N	\N
1247	730	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Agosto.	t	41782	1	2026-01-07 09:50:44.642837-05	\N	\N
1248	1156	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_inundacion_group_/wms?	peru_inundacion_group_	Inundaciones por lluvias fuertes	t	1184	1	2026-01-07 09:50:44.642837-05	\N	\N
1249	7	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022083907___Casos_al_01_de_setiembre_del_2025/wms?	capa_000000_2301	Casos al 01 de setiembre del 2025	t	41673	1	2026-01-07 09:50:44.642837-05	\N	\N
1250	1542	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_prov_complog_/wms?	peru_epci_prov_complog_	Componente de Logística	t	1174	1	2026-01-07 09:50:44.642837-05	\N	\N
1251	1160	11	https://www.idep.gob.pe/geoportal/services/DATOS_GEOESPACIALES/CENTROS_POBLADOS/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Centros Poblados	t	1287	1	2026-01-07 09:50:44.642837-05	\N	\N
1252	1244	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_nacional_dic22&maxFeatures=1000&	0	Red vial nacional 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1253	335	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Almacenamiento_Hidrocarburos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas almacenam. de hidrocarburos	t	41988	1	2026-01-07 09:50:44.642837-05	\N	\N
1254	1280	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAB/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Bagua	t	41016	1	2026-01-07 09:50:44.642837-05	\N	\N
1255	188	11	https://maps.inei.gob.pe/geoserver/T10Limites/ig_manzana/wms?service=WMS&request=GetCapabilities	0	Manzana	t	11255	1	2026-01-07 09:50:44.642837-05	\N	\N
1256	591	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_01/wms?request=GetCapabilities&service=WMS	0	Evento Niño 82-83	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1257	1357	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_fom_prod_pesq_cons_hum_dir_2022_/wms?	peru_econo_fom_prod_pesq_cons_hum_dir_2022_	Fomento de la Producción Pesquera para el Consumo Humano Directo - 2022	t	39055	1	2026-01-07 09:50:44.642837-05	\N	\N
1258	1555	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1259	1	11	https://geosnirh.ana.gob.pe/server/services/P%C3%BAblico/DUA_Agrario/MapServer/WMSServer?request=getcapabilities&service=WMS	0	Agrario	t	38805	1	2026-01-07 09:50:44.642837-05	\N	\N
1260	674	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_02/03_02_003_03_000_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Pronóstico Climático de Temperatura Máxima Trimestral.	t	41567	1	2026-01-07 09:50:44.642837-05	\N	\N
1261	310	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Agricultura_Pto/MapServer/generateKml	0	Unidades fiscalizables - Agricultura (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1262	778	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que cuentan con servicio de desagüe en buen estado	t	26561	1	2026-01-07 09:50:44.642837-05	\N	\N
1263	1075	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_OtrosUsos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Otros Usos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1264	667	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_02/01_02_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 5 - Tmin Extrema - Junio	t	41521	1	2026-01-07 09:50:44.642837-05	\N	\N
1265	984	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128154617___Afiliados_edad_oct2025/wms?	capa_000000_2641	Afiliados activos por grupo de edad	t	42037	1	2026-01-07 09:50:44.642837-05	\N	\N
1266	835	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Percepción de Inseguridad (Próximos 12 Meses)	t	26527	1	2026-01-07 09:50:44.642837-05	\N	\N
1267	1394	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241220092038___2_Acceb_med_trans_ene_dic_2023/wms?	capa_000000_1521	En el transporte, tránsito y seguridad vial según regiones y entidades (2023)	t	40586	1	2026-01-07 09:50:44.642837-05	\N	\N
1268	806	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Física (60 años a más)	t	27725	1	2026-01-07 09:50:44.642837-05	\N	\N
1269	1193	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_TINGO_MARÍA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Tingo María	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1270	1100	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Autorización de cambio de uso actual de las tierras a fines agropecuarios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1271	1036	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-45000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1272	1098	12	https://geosnirh.ana.gob.pe/server/services/Público/VolumenUtilizado/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Volúmenes Utilizados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1273	1395	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241220121536___3_Acceb_Comun_ene_dic_2023/wms?	capa_000000_1524	En la comunicación, según regiones y entidades (2023)	t	40589	1	2026-01-07 09:50:44.642837-05	\N	\N
1274	1038	11	https://winlmprap09.midagri.gob.pe/winlmprap13/services/ogc/CODESLTERR/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	DESLTERR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1275	1604	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_area_rec/wms?request=GetCapabilities&service=WMS	0	Áreas Recreacionales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1276	1030	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Reconocimiento 1-50000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1277	292	12	https://geoservicios.sernanp.gob.pe/arcgis/services/servicios_ogc/peru_sernanp_0213/MapServer/WFSServer?SERVICE=WFS&REQUEST=GetCapabilities	0	Zonificación ACR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1278	1148	11	https://geoserver.indeci.gob.pe/geoserver/siraim/ows?service=WMS&request=GetCapabilities	0	Almacenes - INDECI	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1279	1592	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250604095732___Com_vl_mp_sc/wms?	capa_1309_0	Comités de Vaso de Leche	t	40955	1	2026-01-07 09:50:44.642837-05	\N	\N
1280	1012	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240924224750___Moodle_Ene_Mar_2024/wms?	capa_000000_1229	Moodle (Enero - Marzo 2024)	t	40171	1	2026-01-07 09:50:44.642837-05	\N	\N
1281	658	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_03/01_03_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Percentil 1 - Tmin Extrema - Julio	t	41526	1	2026-01-07 09:50:44.642837-05	\N	\N
1282	447	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_006_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Junio.	t	41637	1	2026-01-07 09:50:44.642837-05	\N	\N
1283	1557	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1284	1450	11	http://geoportal.regionamazonas.gob.pe/geoserver/geonode/permisos_forestales/wms?service=WMS&request=GetCapabilities	0	Permisos Forestales	t	40088	1	2026-01-07 09:50:44.642837-05	\N	\N
1285	96	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128222835___Casos_al_27_de_octubre_del_2025/wms?	capa_000000_2644	Casos al 27 de octubre del 2025	t	42040	1	2026-01-07 09:50:44.642837-05	\N	\N
1286	914	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250610094220___Capa1_IE_Inicial_130125/wms?	capa_000000_1815	I.E. Inicial	t	40998	1	2026-01-07 09:50:44.642837-05	\N	\N
1287	1255	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_tuneles/wms?service=wms&request=GetCapabilities	0	Túneles	t	38828	1	2026-01-07 09:50:44.642837-05	\N	\N
1288	1028	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Reconocimiento 1-30000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1289	436	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_013_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Anual.	t	41644	1	2026-01-07 09:50:44.642837-05	\N	\N
1290	1073	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Minero/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Minero	t	38810	1	2026-01-07 09:50:44.642837-05	\N	\N
1291	1410	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241119165107___3_Por_Deficiencia_Fisica_Set2024/wms?	capa_000000_1432	Por tipo de deficiencia en la discapacidad física	t	40439	1	2026-01-07 09:50:44.642837-05	\N	\N
1292	836	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/puestos_fronterizos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Puestos Fronterizos	t	26515	1	2026-01-07 09:50:44.642837-05	\N	\N
1293	803	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Familiar (60 años a más)	t	27701	1	2026-01-07 09:50:44.642837-05	\N	\N
1294	1045	12	https://geosnirh.ana.gob.pe/server/services/Público/Acueductos/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Acueductos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1295	1683	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251212141128___Total_Becarios_2021/wms?	capa_000000_2662	Becas otorgadas año 2021	t	42069	1	2026-01-07 09:50:44.642837-05	\N	\N
1296	1658	11	https://gis.chavimochic.gob.pe/geoserver/redpozos2024/peru_pech_007_red_monitoreo_avenida_estiaje_2024/wms?request=GetCapabilities&service=WMS	0	Red Monitoreo de Pozos 2024 - Estiaje	t	41928	1	2026-01-07 09:50:44.642837-05	\N	\N
1297	776	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías en buen estado de conservación	t	27672	1	2026-01-07 09:50:44.642837-05	\N	\N
1298	280	11	https://geoservidorperu.minam.gob.pe/arcgis/rest/services/Servicios_GeoPERU/ServicioRRSS_MINAM/MapServer	0	Infraestructura sanitaria	t	41006	1	2026-01-07 09:50:44.642837-05	\N	\N
1299	380	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_05/04_05_008_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Máxima Mensual	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1300	161	12	https://maps.inei.gob.pe/geoserver/T10Limites/pi_cpoblado/wfs?service=WFS&request=GetCapabilities	0	Centro Poblado (población censada)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1301	1299	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_TOCACHE/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_TOCACHE	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1302	106	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829161225___Casos_al_30_de_junio_del_2025/wms?	capa_000000_2043	Casos al 30 de junio del 2025	t	41350	1	2026-01-07 09:50:44.642837-05	\N	\N
1303	1521	11	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_06/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Zonificación forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1304	1671	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251205160808___Convenios_2025/wms?	capa_000000_2656	Convenios e intervenciones interinstitucionales	t	42063	1	2026-01-07 09:50:44.642837-05	\N	\N
1305	430	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Junio.	t	41583	1	2026-01-07 09:50:44.642837-05	\N	\N
1306	335	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Plantas_Almacenamiento_Hidrocarburos/MapServer/generateKml	0	Unidades fiscalizables - Plantas almacenam. de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1307	1228	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_aerodromos_dic23/wms?service=wms&request=GetCapabilities	0	Aeródromos 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1308	1074	11	https://geosnirh.ana.gob.pe/server/services/Público/ObrasdeArte/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Obras de Arte	t	38830	1	2026-01-07 09:50:44.642837-05	\N	\N
1309	1069	11	https://geosnirh.ana.gob.pe/server/services/Público/FuentesContaminantes/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Fuentes Contaminantes	t	38801	1	2026-01-07 09:50:44.642837-05	\N	\N
1310	874	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pip_ppr_030_2_1_/wms?	peru_pip_ppr_030_2_1_	Actividades y Proyectos - Provincial	t	23731	1	2026-01-07 09:50:44.642837-05	\N	\N
1311	348	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Unidades_Menores_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Unid. menores hidrocarburos (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1312	334	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plan_Manejo_RRSS_Municipales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plan de manejo de RRSS municipales	t	42011	1	2026-01-07 09:50:44.642837-05	\N	\N
1313	108	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618174148___Casos_al_31_de_marzo_del_2025/wms?	capa_000000_1853	Casos al 31 de marzo del 2025	t	41075	1	2026-01-07 09:50:44.642837-05	\N	\N
1314	1066	12	https://geosnirh.ana.gob.pe/server/services/Público/EstacionBombeo/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Estación de Bombeo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1315	1248	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_vecinal_dic22&maxFeatures=1000&	0	Red vial vecinal 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1316	1507	11	https://portal.regionsanmartin.gob.pe/server/services/DRASAM/BENEFICIARIOS_NARANJA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Registro de Productores Beneficiarios Asistidos por el Proyecto Naranja	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1317	1466	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_V_Prod_RRNN_No_Renovales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM V Prod RRNN No Renovables	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1318	427	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Enero.	t	41578	1	2026-01-07 09:50:44.642837-05	\N	\N
1319	424	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_004_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Abril.	t	41581	1	2026-01-07 09:50:44.642837-05	\N	\N
1320	367	11	https://ide.igp.gob.pe/geoserver/SCAH_NDVI/wms?request=GetCapabilities&service=WMS	0	Monitoreo NDVI	t	39436	1	2026-01-07 09:50:44.642837-05	\N	\N
1321	1469	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/ZEE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	ZEE	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1322	360	11	https://ide.igp.gob.pe/geoserver/Geodinamica/wms?	0	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Geodinámica	t	39442	1	2026-01-07 09:50:44.642837-05	\N	\N
1323	1150	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_riesgos_agricultura_/wms?	peru_riesgos_agricultura_	Heladas y friaje sector Agricultura Agrícola	t	1182	1	2026-01-07 09:50:44.642837-05	\N	\N
1324	1673	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251124094743___Escuelas_Dep_Oct2025/wms?	capa_000000_2572	Escuelas deportivas	t	41963	1	2026-01-07 09:50:44.642837-05	\N	\N
1325	1274	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_info_gl_pdu_2022_/wms?	peru_info_gl_pdu_2022_	Plan de Desarrollo Urbano	t	1086	1	2026-01-07 09:50:44.642837-05	\N	\N
1326	1206	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704121610___cartas_lacustres/wms?	capa_A00052_14	Cartas Lacustres	t	41173	1	2026-01-07 09:50:44.642837-05	\N	\N
1327	1366	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241017145501___CEM_2023_COMISARIA/wms?	capa_000000_1340	CEM en Comisarías (2023)	t	40325	1	2026-01-07 09:50:44.642837-05	\N	\N
1328	1056	12	https://geosnirh.ana.gob.pe/server/services/Público/Bocatomas/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Bocatomas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1329	1588	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250604163442___cam_segur_mpch/wms?	capa_1304_8	Cámaras de seguridad	t	40964	1	2026-01-07 09:50:44.642837-05	\N	\N
1330	1048	12	https://geosnirh.ana.gob.pe/server/services/Público/AcuiferosVeda/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Acuíferos en veda	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1331	1066	11	https://geosnirh.ana.gob.pe/server/services/Público/EstacionBombeo/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Estación de Bombeo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1332	1517	11	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0803/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Permisos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1333	324	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Educacion_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Educación (polígono)	t	42012	1	2026-01-07 09:50:44.642837-05	\N	\N
1334	548	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_003_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Marzo.	t	41651	1	2026-01-07 09:50:44.642837-05	\N	\N
1335	1573	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1336	497	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_007_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Julio.	t	41702	1	2026-01-07 09:50:44.642837-05	\N	\N
1337	904	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241105120232___1_Adultos_credito_Dic2023/wms?	capa_000000_1400	Porcentaje de adultos con crédito en el sistema financiero	t	40403	1	2026-01-07 09:50:44.642837-05	\N	\N
1338	264	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_centros_poblados/wms?service=WMS&request=GetCapabilities	0	cultura_centros_poblados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1339	1051	11	https://geosnirh.ana.gob.pe/server/services/Público/Adminitracion_Local_Agua/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	ALA	t	38798	1	2026-01-07 09:50:44.642837-05	\N	\N
1340	1335	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Áreas Habilitadas	t	8328	1	2026-01-07 09:50:44.642837-05	\N	\N
1341	26	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829163311___Casos_al_07_de_julio_del_2025/wms?	capa_000000_2044	Casos al 07 de julio del 2025	t	41351	1	2026-01-07 09:50:44.642837-05	\N	\N
1342	1687	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251212141458___Total_Becarios_2025/wms?	capa_000000_2666	Becas otorgadas año 2025	t	42073	1	2026-01-07 09:50:44.642837-05	\N	\N
1343	1048	11	https://geosnirh.ana.gob.pe/server/services/Público/Acuiferos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Acuíferos en veda	t	38823	1	2026-01-07 09:50:44.642837-05	\N	\N
1344	855	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_especializada_sobre_victimizacion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Victimización a Hogares (Últimos 12 Meses)	t	26531	1	2026-01-07 09:50:44.642837-05	\N	\N
1345	1031	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Semidetallado 1-10000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1346	1008	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240923162214___Competencias_Laborales_Nov_Dic_2023/wms?	capa_000000_1223	Certificación de competencias laborales (Nov - Dic 2023)	t	40158	1	2026-01-07 09:50:44.642837-05	\N	\N
1347	919	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250129171833___Capa6_IE_Sup_Pedagogica_130125/wms?	capa_000000_1608	I.E. Superior Pedagógica - ISP	t	40682	1	2026-01-07 09:50:44.642837-05	\N	\N
1348	1022	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250813110716___prog_llamkasun_jun25/wms?	capa_000000_2011	Empleos temporales - Junio 2025	t	41288	1	2026-01-07 09:50:44.642837-05	\N	\N
1349	981	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20221012121704___e_centro_salud/wms?	capa_0701_73	Centro de Salud	t	28416	1	2026-01-07 09:50:44.642837-05	\N	\N
1350	351	12	https://geoservicios.iiap.gob.pe/geoserver/publicaciones_cientificas/wfs?request=Getcapabilities&service=WFS	0	Servicio de mapa de publicaciones de la Amazonía	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1351	225	11	https://geoservicios.devida.gob.pe/arcgis_server/services/Geoperu/Geoperu_v2/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Zonas Cocaleras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1352	714	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_009_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Septiembre.	t	41808	1	2026-01-07 09:50:44.642837-05	\N	\N
1353	1025	11	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	CUM Reconocimiento 1-100000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1354	315	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Termoelectricas_Existentes/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Centrales termoeléctricas existentes	t	41972	1	2026-01-07 09:50:44.642837-05	\N	\N
1355	738	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_011_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Noviembre.	t	41784	1	2026-01-07 09:50:44.642837-05	\N	\N
1356	754	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_mapeo_de_venezolanos/wms?service=WMS&request=GetCapabilities	0	Mapeo de Lugar de Procedencia de los Venezolanos	t	41956	1	2026-01-07 09:50:44.642837-05	\N	\N
1357	77	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206174031___Casos_al_21_de_octubre_del_2024/wms?	capa_000000_1639	Casos al 21 de octubre del 2024	t	40750	1	2026-01-07 09:50:44.642837-05	\N	\N
1358	1474	12	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_wfs/Hidrografia/MapServer/WFSServer?request=GetCapabilities&service=WFS	peru_hidrografia_0104_	Hidrografía	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1359	318	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Generacion_Concesiones/MapServer/generateKml	0	Unidades fiscalizables - Concesiones de generación electrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1360	748	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_03/09_03_999_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Vigilancia de Incendios	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1361	381	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_04/04_04_005_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Temperatura Mínima 01 Década del mes.	t	41574	1	2026-01-07 09:50:44.642837-05	\N	\N
1362	885	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240430204425___TIR_SUNAT2023/wms?	capa_000000_819	Tributos Internos Recaudados	t	39651	1	2026-01-07 09:50:44.642837-05	\N	\N
1363	534	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_010_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Octubre.	t	41607	1	2026-01-07 09:50:44.642837-05	\N	\N
1364	752	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_016_mapeo_casos_tb/wfs?service=WFS&request=GetCapabilities	0	Mapeo de Lugar de Procedencia de internos con casos TB	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1365	850	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Tipo de Vigilancia	t	26529	1	2026-01-07 09:50:44.642837-05	\N	\N
1366	1491	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908103011___Bosques_locales_sm/wms?	capa_22_3	Bosques locales	t	41370	1	2026-01-07 09:50:44.642837-05	\N	\N
1367	110	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccr_/wms?	peru_ccr_	Consejo de Coordinación Regional (CCR)	t	6597	1	2026-01-07 09:50:44.642837-05	\N	\N
1368	321	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Depositos_Concentrados/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Depósitos concentrados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1369	307	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Red_Distribucion_Calidda/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidad fiscalizable - Red de distribución Calidda	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1370	1467	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_V_Prod_RRNN_Renovales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM V Prod RRNN Renovables	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1371	1599	11	https://ws.munilince.gob.pe:9094/geoserver/GEOPERU/peru_munilince_003_sector/wms?service=WMS&request=Getcapabilities\n	0	Sectores del distrito de Lince	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1372	891	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251006103328___mac_express_set25/wms?	capa_000000_2127	MAC Express	t	41477	1	2026-01-07 09:50:44.642837-05	\N	\N
1373	330	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lineas_Transmision_Proyectada/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Línea de transmisión proyectada	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1374	506	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_015_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Otoño.	t	41761	1	2026-01-07 09:50:44.642837-05	\N	\N
1375	133	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251003153125___Mineria/wms?	capa_000000_2119	Minería	t	41469	1	2026-01-07 09:50:44.642837-05	\N	\N
1376	323	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Derechos_Acuicolas_Pto/MapServer/generateKml	0	Unidades fiscalizables - Derechos acuícolas (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1377	1079	12	https://geosnirh.ana.gob.pe/server/services/Emergencias/Poblaciones_vulnerables_2016_2017/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Poblaciones Vulnerables por Activación de Quebradas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1378	248	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_servir_dota_aprob_/wms?	peru_servir_dota_aprob_	E.P. con dotación aprobada	t	20262	1	2026-01-07 09:50:44.642837-05	\N	\N
1379	104	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250829163523___Casos_al_30_de_julio_del_2025/wms?	capa_000000_2047	Casos al 30 de julio del 2025	t	41354	1	2026-01-07 09:50:44.642837-05	\N	\N
1380	1276	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_subsistema_urbano_/wms?	peru_subsistema_urbano_	Subsistema Urbano	t	8079	1	2026-01-07 09:50:44.642837-05	\N	\N
1381	310	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Agricultura_Pto/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Agricultura (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1382	297	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Denuncias_Ambientales/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Denuncias ambientales registradas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1383	615	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_04/03_04_002_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	índice de Radiación UV - 72 Hrs	t	41569	1	2026-01-07 09:50:44.642837-05	\N	\N
1384	1050	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Agrario/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Agrarios	t	23924	1	2026-01-07 09:50:44.642837-05	\N	\N
1385	647	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_012_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Diciembre	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1386	862	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_demografica_salud_familiar/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Física (Últimos 12 Meses)	t	26538	1	2026-01-07 09:50:44.642837-05	\N	\N
1387	1176	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/IMAGEN_DRONE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágenes RPA	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1388	192	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_mercado_/wms?	peru_sitios_interes_mercado_	Mercado	t	2803	1	2026-01-07 09:50:44.642837-05	\N	\N
1389	1330	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/CCPP_cob_agua_2024/wms?	CCPP_cob_agua_2024	Viviendas con Cobertura de Agua	t	40738	1	2026-01-07 09:50:44.642837-05	\N	\N
1390	843	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_programas_presupuestales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Robo de Negocio	t	26525	1	2026-01-07 09:50:44.642837-05	\N	\N
1391	693	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_08/11_08_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Palto	t	41884	1	2026-01-07 09:50:44.642837-05	\N	\N
1392	749	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_03/wms?request=GetCapabilities&service=WMS	0	Vigilancia Meteorológica de Incendios FWI	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1393	1519	12	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_1201/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Registro forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1394	1348	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_alimen_nutric_coc_pesc_2022_/wms?	peru_econo_educ_alimen_nutric_coc_pesc_2022_	Educación Alimentaria y Nutricional (Cocinando con Pescado) - 2022	t	39052	1	2026-01-07 09:50:44.642837-05	\N	\N
1395	517	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_005_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Mayo.	t	41751	1	2026-01-07 09:50:44.642837-05	\N	\N
1396	1338	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Solicitud de Formulario de Reserva	t	8325	1	2026-01-07 09:50:44.642837-05	\N	\N
1397	1205	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/TRANSPORTES_Y_COMUNICACIONES_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Transportes y Comunicaciones 500K	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1398	247	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_servir_enti_publicas_at_mcc_cap_/wms?	peru_servir_enti_publicas_at_mcc_cap_	E.P. con asistencia técnica MCC y CAP	t	20259	1	2026-01-07 09:50:44.642837-05	\N	\N
1399	538	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_015_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Otoño.	t	41663	1	2026-01-07 09:50:44.642837-05	\N	\N
1400	1266	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudad_mayor_/wms?	peru_ciudad_mayor_	Ciudad Mayor	t	8071	1	2026-01-07 09:50:44.642837-05	\N	\N
1401	390	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_001_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Enero.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1402	802	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Familiar (18 – 59 años)	t	27699	1	2026-01-07 09:50:44.642837-05	\N	\N
1403	1422	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/pma_fenomenos_mza_/wms?	pma_fenomenos_mza_	Vul. Inseguridad Alimentaria Mza.	t	2660	1	2026-01-07 09:50:44.642837-05	\N	\N
1404	1054	11	https://geosnirh.ana.gob.pe/server/services/Público/AutorizacionEjecObras/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Autorización de Ejecución de Obras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1405	872	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pre_e_00_03_mincetur_/wms?	peru_pre_e_00_03_mincetur_	Actividades - Regional	t	719	1	2026-01-07 09:50:44.642837-05	\N	\N
1406	324	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Educacion_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Educación (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1407	37	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230905104136___Casos_al_11_de_agosto_del_2023/wms?	capa_A00012_356	Casos al 11 de agosto del 2023	t	38384	1	2026-01-07 09:50:44.642837-05	\N	\N
1408	605	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_003_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Marzo	t	41840	1	2026-01-07 09:50:44.642837-05	\N	\N
1409	1541	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_dpto_comunic_/wms?	peru_epci_dpto_comunic_	Componente de Comunicaciones	t	1168	1	2026-01-07 09:50:44.642837-05	\N	\N
1410	134	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_A00012_197	Minería Ilegal	t	23933	1	2026-01-07 09:50:44.642837-05	\N	\N
1411	32	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230808161250___Casos_al_09_de_junio_del_2023/wms?	capa_A00012_346	Casos al 09 de junio del 2023	t	38151	1	2026-01-07 09:50:44.642837-05	\N	\N
1412	121	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	INFRAESTRUCTURA_SOCIOAMBIENTAL	Infraestructura Socioambiental	t	16201	1	2026-01-07 09:50:44.642837-05	\N	\N
1413	533	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Mayo.	t	41602	1	2026-01-07 09:50:44.642837-05	\N	\N
1414	1677	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251205115749___Total_Becarios_2015/wms?	capa_000000_2655	Becas otorgadas año 2015	t	42062	1	2026-01-07 09:50:44.642837-05	\N	\N
1415	1077	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Pesquero/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Pesquero	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1416	805	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Física (18 – 59 años)	t	27723	1	2026-01-07 09:50:44.642837-05	\N	\N
1417	1055	12	https://geosnirh.ana.gob.pe/server/services/Público/vVertimientos/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Autorización de Vertimientos de Aguas Residuales Tratadas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1418	325	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Generacion_Aislada_Concesion/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Generación sistemas eléctricos aislados	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1419	512	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_001_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Enero.	t	41747	1	2026-01-07 09:50:44.642837-05	\N	\N
1420	454	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_016_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Estación de Invierno.	t	41728	1	2026-01-07 09:50:44.642837-05	\N	\N
1421	1120	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_huamanga_gaseoducto_/wms?	peru_huamanga_gaseoducto_	Gaseoducto	t	19569	1	2026-01-07 09:50:44.642837-05	\N	\N
1422	167	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distnbi_mza_/wms?	peru_distnbi_mza_	Con al menos una NBI	t	1061	1	2026-01-07 09:50:44.642837-05	\N	\N
1423	189	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccpp_6_/wms?	peru_ccpp_6_	Más de 500,000 Habitantes	t	770	1	2026-01-07 09:50:44.642837-05	\N	\N
1424	84	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618172624___Casos_al_24_de_febrero_del_2025/wms?	capa_000000_1849	Casos al 24 de febrero del 2025	t	41071	1	2026-01-07 09:50:44.642837-05	\N	\N
1425	1291	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPACOP_CAMPOVERDE/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPACOP_CAMPOVERDE	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1426	309	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Agricultura_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Agricultura (polígono)	t	41970	1	2026-01-07 09:50:44.642837-05	\N	\N
1427	1610	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_ortofotografia_2022/wms?request=GetCapabilities&service=WMS	0	Ortofotografia Aerea del año 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1428	578	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_07/06_07_001_03_001_521_2030_00_00/ows?service=WMS&request=GetCapabilities	0	Disponibilidad Hídrica 2030.	t	41774	1	2026-01-07 09:50:44.642837-05	\N	\N
1429	1331	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/CCPP_cob_desague_2024/wms?	CCPP_cob_desague_2024	Viviendas con Cobertura de Desagüe	t	40739	1	2026-01-07 09:50:44.642837-05	\N	\N
1430	98	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250619093207___Casos_al_28_de_abril_del_2025/wms?	capa_000000_1858	Casos al 28 de abril del 2025	t	41080	1	2026-01-07 09:50:44.642837-05	\N	\N
1431	768	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de laptop - notebook - propio y operativo	t	27679	1	2026-01-07 09:50:44.642837-05	\N	\N
1432	161	11	https://maps.inei.gob.pe/geoserver/T10Limites/pi_cpoblado/wms?service=WMS&request=GetCapabilities	0	Centro Poblado (población censada)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1433	417	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_01/wms?request=GetCapabilities&service=WMS	0	Caracterización de Clasificación Climática	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1434	1135	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250116173050___Capa3_Sub_Estaciones_Dic2024/wms?	capa_000000_1593	Subestación de transmisión	t	40660	1	2026-01-07 09:50:44.642837-05	\N	\N
1435	1096	12	https://geosnirh.ana.gob.pe/server/services/ws_UnidadesHidro/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades Hidrográficas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1436	1283	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMUSAP/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Chachapoyas	t	41019	1	2026-01-07 09:50:44.642837-05	\N	\N
1437	1563	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250604163442___cam_segur_mpch/wms?	capa_1304_8	Cámaras de seguridad	t	40964	1	2026-01-07 09:50:44.642837-05	\N	\N
1438	1265	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudad_intermedia_principal_/wms?	peru_ciudad_intermedia_principal_	Ciudad Intermedia Principal	t	8072	1	2026-01-07 09:50:44.642837-05	\N	\N
1439	873	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pre_e_00_04_dist_minsa_/wms?	peru_pre_e_00_04_dist_minsa_	Actividades y Proyectos - Distrital	t	679	1	2026-01-07 09:50:44.642837-05	\N	\N
1440	433	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_011_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Noviembre.	t	41588	1	2026-01-07 09:50:44.642837-05	\N	\N
1441	293	17	https://geoservicios.sernanp.gob.pe/arcgis/rest/services/servicios_ogc/peru_sernanp_0213/MapServer	0	Zonificación ANP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1442	85	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230404143513___Casos20230324/wms?	capa_A00012_307	Casos al 24 de marzo del 2023	t	35904	1	2026-01-07 09:50:44.642837-05	\N	\N
1443	869	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distritos_frontera_/wms?	peru_distritos_frontera_	Distritos de Frontera	t	32278	1	2026-01-07 09:50:44.642837-05	\N	\N
1444	42	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250627143204___Casos_al_12_de_mayo_del_2025/wms?	capa_000000_1933	Casos al 12 de mayo del 2025	t	41167	1	2026-01-07 09:50:44.642837-05	\N	\N
1445	227	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250901125658___Capa4_Bitel_1er_Trim_2025/wms?	capa_000000_2057	Bitel	t	41364	1	2026-01-07 09:50:44.642837-05	\N	\N
1446	1086	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Recreativo/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Recreativo	t	38815	1	2026-01-07 09:50:44.642837-05	\N	\N
1447	1168	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hidrografía - Rocas Flor Agua (Escala 1:500 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1448	515	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_006_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Junio.	t	41752	1	2026-01-07 09:50:44.642837-05	\N	\N
1449	637	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_06/02_06_001_03_001_512_2024_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2024 - Precipitación DEF	t	41564	1	2026-01-07 09:50:44.642837-05	\N	\N
1450	335	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Almacenamiento_Hidrocarburos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Plantas almacenam. de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1451	1386	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241211203523___13_Pob_con_sin_pob_mon_extr_2023/wms?	capa_000000_1489	% Población en situación de pobreza monetaria extrema (2014 al 2023)	t	40545	1	2026-01-07 09:50:44.642837-05	\N	\N
1452	1670	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251124104300___Actividades_Dep_Oct2025/wms?	capa_000000_2576	Actividades deportivas	t	41967	1	2026-01-07 09:50:44.642837-05	\N	\N
1453	1099	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Unidad_Monitoreo_Satelital/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Alertas de incendio forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1454	744	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_06/04_06_003_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Variable de Evapotranspiración 03 Década del mes.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1455	352	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/bofedales_inaigem/wms?	bofedales_inaigem	Inventario Nacional de Bofedales	t	41457	1	2026-01-07 09:50:44.642837-05	\N	\N
1456	1303	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSMARANON_JAEN/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EPSMARANON_JAEN	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1457	1107	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Inventario_Forestal/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Inventario Forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1458	307	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Red_Distribucion_Calidda/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidad fiscalizable - Red de distribución Calidda	t	41995	1	2026-01-07 09:50:44.642837-05	\N	\N
1459	1049	12	https://geosnirh.ana.gob.pe/server/services/Público/Adminitracion_Local_Agua/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Administración Local del Agua	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1460	389	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_012_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Diciembre.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1461	1231	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250926115656___Corredor_log_jun25/wms?	capa_000000_2104	Corredores Logísticos	t	41445	1	2026-01-07 09:50:44.642837-05	\N	\N
1462	642	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_02/02_02_001_03_001_512_1998_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 97 - 98 - Precipitación DEF	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1463	127	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721154613___LAB_PRIVADO/wms?	capa_000000_1957	Laboratorios del Sector Privado	t	41224	1	2026-01-07 09:50:44.642837-05	\N	\N
1464	342	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Refinerias_Hidrocarburos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas procesamiento de hidrocarburos	t	41990	1	2026-01-07 09:50:44.642837-05	\N	\N
1465	998	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818221348___Capacitacion_Laboral_Ene_Mar_2025/wms?	capa_000000_2012	Capacitación laboral (Enero - Marzo 2025)	t	41295	1	2026-01-07 09:50:44.642837-05	\N	\N
1466	826	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Física (60 años a más)	t	27724	1	2026-01-07 09:50:44.642837-05	\N	\N
1467	46	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128223046___Casos_al_13_de_octubre_del_2025/wms?	capa_000000_2646	Casos al 13 de octubre del 2025	t	42042	1	2026-01-07 09:50:44.642837-05	\N	\N
1468	27	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206174150___Casos_al_07_de_octubre_del_2024/wms?	capa_000000_1641	Casos al 07 de octubre del 2024	t	40752	1	2026-01-07 09:50:44.642837-05	\N	\N
1469	65	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206172541___Casos_al_18_de_noviembre_del_2024/wms?	capa_000000_1637	Casos al 18 de noviembre del 2024	t	40748	1	2026-01-07 09:50:44.642837-05	\N	\N
1470	442	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_008_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Agosto.	t	41639	1	2026-01-07 09:50:44.642837-05	\N	\N
1471	930	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251203093848___Residencia_2025/wms?	capa_000000_2650	Sede de Residencia	t	42046	1	2026-01-07 09:50:44.642837-05	\N	\N
1472	1295	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR3/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR3	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1473	1662	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119091943___PAM_Caridad_04_11_25/wms?	capa_000000_2528	Pasivo ambiental minero Caridad	t	41915	1	2026-01-07 09:50:44.642837-05	\N	\N
1474	1253	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_terminales_portuarios_dic23/wms?service=wms&request=GetCapabilities	0	Terminales portuarios y embarcaderos 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1475	993	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510162033___Atendidos_INR_Proced_Sexo_xdpto_2023/wms?	capa_000000_851	Pacientes INR atendidos según sexo - Departamental	t	39683	1	2026-01-07 09:50:44.642837-05	\N	\N
1476	1087	11	https://geosnirh.ana.gob.pe/server/services/Público/Reservorios/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Reservorios	t	35864	1	2026-01-07 09:50:44.642837-05	\N	\N
1477	1624	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1478	1242	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_departamental_jul24&maxFeatures=1000&	0	Red vial departamental 2024	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1479	211	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_viv_NOAGUA_/wms?	peru_viv_NOAGUA_	Sin Abastecimiento de Agua	t	1052	1	2026-01-07 09:50:44.642837-05	\N	\N
1480	1427	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250710180325___Capa4_Juntos_Abril2025/wms?	capa_000000_1947	JUNTOS	t	41211	1	2026-01-07 09:50:44.642837-05	\N	\N
1481	1286	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSMOYOBAMBA/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Moyobamba	t	41023	1	2026-01-07 09:50:44.642837-05	\N	\N
1482	1142	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_seg_ciud_delitos_cont_familia_2023_/wms?	peru_seg_ciud_delitos_cont_familia_2023_	Delitos contra La Familia	t	39179	1	2026-01-07 09:50:44.642837-05	\N	\N
1483	960	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240528111502___Nutricionistas_XEESS_Feb2024/wms?	capa_000000_889	Nutricionistas por EESS	t	39741	1	2026-01-07 09:50:44.642837-05	\N	\N
1484	1615	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330154313___vaso_de_leche/wms?	capa_24_336	Vaso de Leche	t	35837	1	2026-01-07 09:50:44.642837-05	\N	\N
1485	905	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250923155235___1_Adultos_con_cuenta_Dic2024/wms?	capa_000000_2068	Porcentaje de adultos con cuenta en el sistema financiero	t	41408	1	2026-01-07 09:50:44.642837-05	\N	\N
1486	438	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_015_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Estación de Otoño.	t	41646	1	2026-01-07 09:50:44.642837-05	\N	\N
1487	143	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_conflictos_sociales_transporte_nuevo_/wms?	peru_conflictos_sociales_transporte_nuevo_	Transporte	t	4936	1	2026-01-07 09:50:44.642837-05	\N	\N
1488	783	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que tienen paredes en buen estado de conservación	t	27670	1	2026-01-07 09:50:44.642837-05	\N	\N
1489	1053	11	https://geosnirh.ana.gob.pe/server/services/Público/Autoridad_Administrativa_del_Agua/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Autoridad Administrativa del Agua	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1490	634	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_04/02_04_003_03_001_512_2017_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2017 - Precipitación FMA	t	41561	1	2026-01-07 09:50:44.642837-05	\N	\N
1491	310	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Agricultura_Pto/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Agricultura (punto)	t	41971	1	2026-01-07 09:50:44.642837-05	\N	\N
1492	496	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_002_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Febrero.	t	41667	1	2026-01-07 09:50:44.642837-05	\N	\N
1493	285	11	https://geoservicios.sernanp.gob.pe/arcgis/services/base_fisica/peru_sernanp_0102/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	ANP de Administracion Nacional Transitoria	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1494	327	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Infraestructura_RRSS_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Infraestructuras de RRSS (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1495	338	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Limites_Plantas_Distribucion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas distribución de hidrocarburos	t	41987	1	2026-01-07 09:50:44.642837-05	\N	\N
1496	1521	12	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_06/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Zonificación forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1497	1018	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241024124155___Autoempleo_Productivo_Jul_Set_2024/wms?	capa_000000_1381	Promoción del autoempleo productivo (Jul - Set 2024)	t	40382	1	2026-01-07 09:50:44.642837-05	\N	\N
1498	713	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_010_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Octubre.	t	41809	1	2026-01-07 09:50:44.642837-05	\N	\N
1499	60	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230404142150___Casos20230317/wms?	capa_A00012_306	Casos al 17 de marzo del 2023	t	35903	1	2026-01-07 09:50:44.642837-05	\N	\N
1500	1192	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_PUNO/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Puno	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1501	1138	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_operaciones_isa_/wms?	peru_operaciones_isa_	Operaciones del Grupo ISA	t	8583	1	2026-01-07 09:50:44.642837-05	\N	\N
1502	530	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_007_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Julio.	t	41604	1	2026-01-07 09:50:44.642837-05	\N	\N
1503	198	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240711151244___DESARROLLO/wms?	capa_000000_1016	Plan de Desarrollo de Capacidades	t	39900	1	2026-01-07 09:50:44.642837-05	\N	\N
1504	1256	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_peajes_dic22	0	Unidades de peaje 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1505	372	11	https://ide.igp.gob.pe/geoserver/CTS_alertavolcan/wms?request=GetCapabilities&service=WMS	0	Volcanes: Nivel de alerta	t	41015	1	2026-01-07 09:50:44.642837-05	\N	\N
1506	82	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022084055___Casos_al_22_de_setiembre_del_2025/wms?	capa_000000_2304	Casos al 22 de setiembre del 2025	t	41676	1	2026-01-07 09:50:44.642837-05	\N	\N
1507	73	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804141417___Casos_al_21_de_abril_del_2023/wms?	capa_A00012_337	Casos al 21 de abril del 2023	t	38140	1	2026-01-07 09:50:44.642837-05	\N	\N
1508	1383	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241205114306___4_Pob_con_sin_14_PEA_2023/wms?	capa_000000_1460	% Población de 14 años a más, por condición de PEA y no PEA (2023)	t	40502	1	2026-01-07 09:50:44.642837-05	\N	\N
1509	1336	11	http://sigeo.produce.gob.pe:6080/arcgis/services/acuicultura/CATASTRO_ACUICOLA_GDB_WEB_WMS/MapServer/WMSServer?	0	Derechos Acuícolas	t	17384	1	2026-01-07 09:50:44.642837-05	\N	\N
1510	1015	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240923162855___Moodle_Nov_Dic_2023/wms?	capa_000000_1224	Moodle (Nov - Dic 2023)	t	40159	1	2026-01-07 09:50:44.642837-05	\N	\N
1511	801	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Familiar (0 – 17 años)	t	27697	1	2026-01-07 09:50:44.642837-05	\N	\N
1512	1475	12	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_wfs/Relieve/MapServer/WFSServer?request=GetCapabilities&service=WFS	capa_A00013_25	Relieve	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1513	983	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250730115806___Otros_jul25/wms?	capa_000000_1988	Otros	t	41260	1	2026-01-07 09:50:44.642837-05	\N	\N
1514	653	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_005_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Mayo.	t	41870	1	2026-01-07 09:50:44.642837-05	\N	\N
1515	1649	11	https://gis.chavimochic.gob.pe/geoserver/calidadaguadrenada2023/peru_pech_007_monitoreo_drenaje_anual_2023/wms?request=GetCapabilities&service=WMS	0	Monitoreo Drenaje Anual 2023	t	41943	1	2026-01-07 09:50:44.642837-05	\N	\N
1516	1143	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_seg_ciud_delitos_cont_libertad_2023_/wms?	peru_seg_ciud_delitos_cont_libertad_2023_	Delitos contra La Libertad	t	39178	1	2026-01-07 09:50:44.642837-05	\N	\N
1517	306	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Sistema_Ductos_Hidrocarburos_Liquidos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidad fiscalizable - Ductos de transporte de hidrocarburos líquidos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1518	1177	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/IMAGEN_DRONE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágenes RPA - Costa Verde	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1519	173	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccpp_4_/wms?	peru_ccpp_4_	De 2,501 a 5,000 Habitantes	t	768	1	2026-01-07 09:50:44.642837-05	\N	\N
1520	306	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Sistema_Ductos_Hidrocarburos_Liquidos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidad fiscalizable - Ductos de transporte de hidrocarburos líquidos	t	41992	1	2026-01-07 09:50:44.642837-05	\N	\N
1521	1034	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-20000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1522	1311	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_nuv_financ_compl_tp_fctp_2022_/wms?	peru_finan_nuv_financ_compl_tp_fctp_2022_	Financiamiento Complementario Techo Propio (FCTP)	t	38338	1	2026-01-07 09:50:44.642837-05	\N	\N
1523	301	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_Municipales_Invt/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Inventario nacional de áreas degradadas por RRSS municipales	t	42017	1	2026-01-07 09:50:44.642837-05	\N	\N
1524	699	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_99/05_99_002_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Lluvia, Fin 1964/65 a 2018/19 del Departamento de Puno.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1525	1239	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_ferroviaria_dic22	0	Red ferroviaria 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1526	1646	11	https://gis.chavimochic.gob.pe/geoserver/comportamientonf2023/peru_pech_007_nf_periodo_avenida_2023/wms?request=GetCapabilities&service=WMS	0	Comportamiento Nivel Freático 2023 - Avenida	t	41922	1	2026-01-07 09:50:44.642837-05	\N	\N
1527	1264	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ciudad_intermedia_/wms?	peru_ciudad_intermedia_	Ciudad Intermedia	t	8073	1	2026-01-07 09:50:44.642837-05	\N	\N
1528	1539	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_idh_ingreso_fami_/wms?	peru_idh_ingreso_fami_	Ingreso familiar per cápita (soles por mes)	t	8204	1	2026-01-07 09:50:44.642837-05	\N	\N
1529	1259	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_infraestructura_dependencias_policiales_feb2022_/wms?	peru_infraestructura_dependencias_policiales_feb2022_	Dependencias Policiales	t	27987	1	2026-01-07 09:50:44.642837-05	\N	\N
1530	1473	12	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_wfs/CuerposdeAgua/MapServer/WFSServer?request=GetCapabilities&service=WFS	capa_0501_27	Cuerpos de agua	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1531	1223	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240507163155___Poblacion_electoral_ERM2022_edades/wms?	capa_000000_824	Población Electoral Total	t	39656	1	2026-01-07 09:50:44.642837-05	\N	\N
1532	1188	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_CARHUAZ/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Carhuaz	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1533	1255	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_tuneles	0	Túneles	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1534	334	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Plan_Manejo_RRSS_Municipales/MapServer/generateKml	0	Unidades fiscalizables - Plan de manejo de RRSS municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1535	1431	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250205182035___Capa2_Puntos_de_atencion_Dic2024/wms?	capa_000000_1626	Plataformas Itinerantes (PIAS) 2024	t	40705	1	2026-01-07 09:50:44.642837-05	\N	\N
1536	478	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Enero.	t	41614	1	2026-01-07 09:50:44.642837-05	\N	\N
1537	1374	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241018105306___CEM_E_2023_PSIC/wms?	capa_000000_1351	Violencia Psicológica (2023)	t	40338	1	2026-01-07 09:50:44.642837-05	\N	\N
1538	1198	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_100K/MapServer/WMSServer?request=getcapabilities&service=WMS	0	Río Área	t	39029	1	2026-01-07 09:50:44.642837-05	\N	\N
1539	527	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Agosto.	t	41605	1	2026-01-07 09:50:44.642837-05	\N	\N
1540	109	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250131121333___Capa1_Centros_MAC_Enero2025/wms?	capa_000000_1623	Centros MAC	t	40699	1	2026-01-07 09:50:44.642837-05	\N	\N
1541	715	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_013_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Anual.	t	41799	1	2026-01-07 09:50:44.642837-05	\N	\N
1542	1546	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_epci_dpto_rrhh_/wms?	peru_epci_dpto_rrhh_	Componente de Recursos Humanos	t	1165	1	2026-01-07 09:50:44.642837-05	\N	\N
1543	1613	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1544	1118	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250730085820___Conc_ele_SFVD_Jul25/wms?	capa_000000_1980	Concesión Eléctrica del SFVD	t	41252	1	2026-01-07 09:50:44.642837-05	\N	\N
1545	354	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240422162030___Lagunas_2020/wms?	capa_000000_717	Inventario Nacional de Lagunas de origen glaciar	t	39537	1	2026-01-07 09:50:44.642837-05	\N	\N
1546	291	12	https://geoservicios.sernanp.gob.pe/arcgis/services/servicios_ogc/peru_sernanp_0213/MapServer/WFSServer?SERVICE=WFS&REQUEST=GetCapabilities	0	Zonificación ACP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1547	1449	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/gf_permisos/wms?service=WMS&request=GetCapabilities	0	Permisos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1548	426	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_012_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Diciembre.	t	41589	1	2026-01-07 09:50:44.642837-05	\N	\N
1549	1522	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_construccion/wms?service=WMS&request=GetCapabilities	0	Construcciónes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1550	690	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_05/11_05_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Café	t	41881	1	2026-01-07 09:50:44.642837-05	\N	\N
1551	90	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206171628___Casos_al_25_de_noviembre_del_2024/wms?	capa_000000_1633	Casos al 25 de noviembre del 2024	t	40744	1	2026-01-07 09:50:44.642837-05	\N	\N
1552	722	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_006_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Junio.	t	41792	1	2026-01-07 09:50:44.642837-05	\N	\N
1553	1463	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/SM_Poten_Socioeconomicas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	SM Potencialidades Socioeconómicas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1554	461	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_001_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Enero.	t	41713	1	2026-01-07 09:50:44.642837-05	\N	\N
1555	1329	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241128124842___Accesibilidad_centros_poblados_2024/wms?	capa_000000_1443	Accesibilidad entre Centros Poblados	t	40460	1	2026-01-07 09:50:44.642837-05	\N	\N
1556	1341	11	https://geoservidor.fondepes.gob.pe/geoserver/FONDEPES/Centro%20de%20Educacion%20Tecnico/wms?service=WMS&version=1.3.0&request=GetCapabilities	0	Centro de Educación Técnico	t	35753	1	2026-01-07 09:50:44.642837-05	\N	\N
1557	1245	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_nacional_dic23&maxFeatures=1000&	0	Red vial nacional 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1558	986	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251128150318___Afiliados_sexo_oct2025/wms?	capa_000000_2640	Afiliados activos según sexo	t	42036	1	2026-01-07 09:50:44.642837-05	\N	\N
1559	329	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lineas_Transmision_Existentes/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Línea de transmisión existente	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1560	760	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_seguciu_adolesinfra_infrac_distrito_soa_/wms?	peru_seguciu_adolesinfra_infrac_distrito_soa_	Infracciones por distrito según SOA	t	39231	1	2026-01-07 09:50:44.642837-05	\N	\N
1561	1494	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250908165125___COBERTURA_FORESTAL_RESERVA/wms?	capa_22_11	Cobertura forestal en reserva	t	41378	1	2026-01-07 09:50:44.642837-05	\N	\N
1562	892	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251003163733___pensionistas_snp_set_cortejun25/wms?	capa_000000_2124	Pensionistas del Sistema Nacional de Pensiones (SNP)	t	41474	1	2026-01-07 09:50:44.642837-05	\N	\N
1563	1438	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/zf_anps/wms?service=WMS&request=GetCapabilities	0	Áreas Naturales Protegidas	t	8188	1	2026-01-07 09:50:44.642837-05	\N	\N
1564	163	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_sitios_interes_club_/wms?	peru_sitios_interes_club_	Club	t	2807	1	2026-01-07 09:50:44.642837-05	\N	\N
1565	1165	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/FISIOGRAFIA_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Fisiografía (Escala 1:100 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1566	720	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Febrero.	t	41788	1	2026-01-07 09:50:44.642837-05	\N	\N
1567	1070	12	https://geosnirh.ana.gob.pe/server/services/Público/Glaciares/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Glaciares	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1568	320	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Consultoras_Ambientales_Pol/MapServer/generateKml	0	Unidades fiscalizables - Consultoras ambientales (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1569	1535	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_idh_esp_vida_/wms?	peru_idh_esp_vida_	Esperanza de vida al nacer (años)	t	8201	1	2026-01-07 09:50:44.642837-05	\N	\N
1570	154	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240711143159___PROV_ICL/wms?	capa_000000_1010	CCL - Provincial	t	39894	1	2026-01-07 09:50:44.642837-05	\N	\N
1571	272	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_reserva_indigena/wms?service=WMS&version=1.1.0&request=GetCapabilities	cultura_reserva_indigena	Reservas Indígenas (PIACI)	t	39111	1	2026-01-07 09:50:44.642837-05	\N	\N
1572	135	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	MINERIA_LABORAL	Minería Laboral	t	16206	1	2026-01-07 09:50:44.642837-05	\N	\N
1573	259	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250730150624___Proyectos_anin_jul25/wms?	capa_000000_1989	Proyectos de Inversión - ANIN	t	41261	1	2026-01-07 09:50:44.642837-05	\N	\N
1574	1136	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250602002948___Unidad_negocios_abril2025/wms?	capa_000000_1799	Unidad de negocios	t	40933	1	2026-01-07 09:50:44.642837-05	\N	\N
1575	1007	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241024123034___Competencias_Laborales_Jul_Set_2024/wms?	capa_000000_1379	Certificación de competencias laborales (Jul - Set 2024)	t	40380	1	2026-01-07 09:50:44.642837-05	\N	\N
1576	789	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_nacional_hogares/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Confianza en Institución - Policía Nacional del Perú	t	26533	1	2026-01-07 09:50:44.642837-05	\N	\N
1577	1660	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251110092035___Asegurados_titulares_oct2025/wms?	capa_000000_2518	Afiliados activos del seguro SALUDPOL (Titular)	t	41892	1	2026-01-07 09:50:44.642837-05	\N	\N
1578	502	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_010_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Octubre.	t	41705	1	2026-01-07 09:50:44.642837-05	\N	\N
1579	1058	12	https://geosnirh.ana.gob.pe/server/services/Público/CanalDerivacion/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Canales de Derivación	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1580	332	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lotes_Hidrocarburos_Liquidos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Lotes de hidrocarburos líquidos	t	41991	1	2026-01-07 09:50:44.642837-05	\N	\N
1581	316	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Termoelectricas_Proyectadas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Centrales termoeléctricas proyectadas	t	41973	1	2026-01-07 09:50:44.642837-05	\N	\N
1582	1084	11	https://geosnirh.ana.gob.pe/server/services/Público/PuntosCriticos/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Puntos Críticos	t	30792	1	2026-01-07 09:50:44.642837-05	\N	\N
1583	1086	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Recreativo/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Recreativo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1584	695	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_06/11_06_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Pasto	t	41882	1	2026-01-07 09:50:44.642837-05	\N	\N
1585	546	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_007_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Julio.	t	41655	1	2026-01-07 09:50:44.642837-05	\N	\N
1586	882	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240930155029___cs_lima_set24/wms?	capa_000000_1241	Centros de Servicios al Contribuyente - Lima y Callao	t	40183	1	2026-01-07 09:50:44.642837-05	\N	\N
1587	827	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Psicológica (0 – 17 años)	t	27714	1	2026-01-07 09:50:44.642837-05	\N	\N
1588	791	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/denuncias/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Denuncias	t	26514	1	2026-01-07 09:50:44.642837-05	\N	\N
1589	1140	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_seg_ciud_delitos_cont_patrimonio_2023_/wms?	peru_seg_ciud_delitos_cont_patrimonio_2023_	Delitos contra el Patrimonio	t	39177	1	2026-01-07 09:50:44.642837-05	\N	\N
1590	51	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206174109___Casos_al_14_de_octubre_del_2024/wms?	capa_000000_1640	Casos al 14 de octubre del 2024	t	40751	1	2026-01-07 09:50:44.642837-05	\N	\N
1591	35	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618172735___Casos_al_10_de_febrero_del_2025/wms?	capa_000000_1851	Casos al 10 de febrero del 2025	t	41073	1	2026-01-07 09:50:44.642837-05	\N	\N
1592	321	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Depositos_Concentrados/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Depósitos concentrados	t	42002	1	2026-01-07 09:50:44.642837-05	\N	\N
1593	996	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240924232809___Capacitacion_Laboral_Abr_Jun_2024/wms?	capa_000000_1231	Capacitación laboral (Abril - Junio 2024)	t	40173	1	2026-01-07 09:50:44.642837-05	\N	\N
1594	607	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_011_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Noviembre	t	41848	1	2026-01-07 09:50:44.642837-05	\N	\N
1595	1071	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Indunstrial/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Industrial	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1596	221	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_pob_servicios_alumbrado_elect_/wms?	data_pob_servicios_alumbrado_elect_	Viviendas sin Alumbrado Eléctrico	t	947	1	2026-01-07 09:50:44.642837-05	\N	\N
1597	1098	11	https://geosnirh.ana.gob.pe/server/services/Público/VolumenUtilizado/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Volúmenes Utilizados	t	38817	1	2026-01-07 09:50:44.642837-05	\N	\N
1598	594	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_07/01_07_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Eventos Olas de Calor - Otoño	t	41541	1	2026-01-07 09:50:44.642837-05	\N	\N
1599	1256	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_peajes_dic22/wms?service=wms&request=GetCapabilities	0	Unidades de peaje 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1600	318	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Generacion_Concesiones/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Concesiones de generación electrica	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1601	92	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804155016___Casos_al_26_de_mayo_del_2023/wms?	capa_A00012_343	Casos al 26 de mayo del 2023	t	38146	1	2026-01-07 09:50:44.642837-05	\N	\N
1602	946	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240428161525___Enfermeros_XEESS_Feb2024/wms?	capa_000000_797	Enfermeros por EESS	t	39617	1	2026-01-07 09:50:44.642837-05	\N	\N
1603	1102	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Bosques Locales (Título Habilitante)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1604	750	11	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_013_medios_libres/wms?service=WMS&request=GetCapabilities	0	Establecimientos de Medios Libres	t	41951	1	2026-01-07 09:50:44.642837-05	\N	\N
1605	216	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distnbi_viv_conhac_/wms?	peru_distnbi_viv_conhac_	Viv. con Hacinamiento	t	1024	1	2026-01-07 09:50:44.642837-05	\N	\N
1606	603	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_007_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Julio	t	41844	1	2026-01-07 09:50:44.642837-05	\N	\N
1607	1204	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/TRANSPORTES_Y_COMUNICACIONES_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Transportes y Comunicaciones 100K	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1608	120	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20220714183149___d_2203_infraestructura_p/wms?	capa_2203_17	Infraestructura	t	27955	1	2026-01-07 09:50:44.642837-05	\N	\N
1609	291	17	https://geoservicios.sernanp.gob.pe/arcgis/rest/services/servicios_ogc/peru_sernanp_0213/MapServer	0	Zonificación ACP	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1610	492	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_004_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Abril.	t	41699	1	2026-01-07 09:50:44.642837-05	\N	\N
1611	1655	11	https://gis.chavimochic.gob.pe/geoserver/redpozos2022/peru_pech_007_red_monitoreo_avenida_estiaje_2022/wms?request=GetCapabilities&service=WMS	0	Red Monitoreo de Pozos 2022 - Estiaje	t	41925	1	2026-01-07 09:50:44.642837-05	\N	\N
1612	974	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_telemedicina_/wms?	peru_telemedicina_	Telemedicina	t	1243	1	2026-01-07 09:50:44.642837-05	\N	\N
1613	847	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sectores Comisarias Básicas	t	41331	1	2026-01-07 09:50:44.642837-05	\N	\N
1614	1473	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_0501_27	Cuerpos de agua	t	23967	1	2026-01-07 09:50:44.642837-05	\N	\N
1615	1565	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1616	818	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Económica o Patrimonial (0 – 17 años)	t	27708	1	2026-01-07 09:50:44.642837-05	\N	\N
1617	726	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_010_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Octubre.	t	41796	1	2026-01-07 09:50:44.642837-05	\N	\N
1618	471	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_016_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Estación de Invierno.	t	41628	1	2026-01-07 09:50:44.642837-05	\N	\N
1619	1590	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230308201436___serenazgo/wms?	capa_150138_6	Serenazgo	t	35730	1	2026-01-07 09:50:44.642837-05	\N	\N
1620	1609	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_numeracion/wms?request=GetCapabilities&service=WMS	0	Numeración de puertas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1621	1549	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_greenfield_itp_/wms?	peru_greenfield_itp_	Greenfield - IPT	t	8303	1	2026-01-07 09:50:44.642837-05	\N	\N
1622	687	11	https://idesep.senamhi.gob.pe:443/geoserver/g_99_01/wms?request=GetCapabilities&service=WMS	0	Red de Estaciones	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1623	541	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_004_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Abril.	t	41652	1	2026-01-07 09:50:44.642837-05	\N	\N
1624	1171	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_AREQUIPA/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imagen Satelital de Arequipa	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1625	301	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Areas_Degradadas_RRSS_Municipales_Invt/MapServer/generateKml	0	Inventario nacional de áreas degradadas por RRSS municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1627	572	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_01/05_01_001_03_001_512_2021_00_00/ows?service=WMS&request=GetCapabilities	0	Clasificación Climática	t	8471	1	2026-01-07 09:50:44.642837-05	\N	\N
1628	1203	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/TOPONIMIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Toponimia (Escala 1:500 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1629	273	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_1301_51	Zonas Arqueológicas	t	11221	1	2026-01-07 09:50:44.642837-05	\N	\N
1630	320	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Consultoras_Ambientales_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Consultoras ambientales (polígono)	t	42014	1	2026-01-07 09:50:44.642837-05	\N	\N
1631	1053	12	https://geosnirh.ana.gob.pe/server/services/Público/Autoridad_Administrativa_del_Agua/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Autoridad Administrativa del Agua	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1632	764	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de equipos multifuncionales propios y operativos	t	27684	1	2026-01-07 09:50:44.642837-05	\N	\N
1633	959	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027170250___Nutricionistas_Distrito_Julio_2025/wms?	capa_000000_2311	Nutricionistas por distrito	t	41683	1	2026-01-07 09:50:44.642837-05	\N	\N
1634	1526	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_parques/wms?service=WMS&request=GetCapabilities	0	Parques	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1635	124	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	LABORALES_GREMIALES	Laborales Gremiales	t	16205	1	2026-01-07 09:50:44.642837-05	\N	\N
1636	1681	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251211155028___Total_Becarios_2019/wms?	capa_000000_2660	Becas otorgadas año 2019	t	42067	1	2026-01-07 09:50:44.642837-05	\N	\N
1637	199	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240813093327___Plan_econo/wms?	capa_000000_1099	Plan de Desarrollo Económico Local	t	40000	1	2026-01-07 09:50:44.642837-05	\N	\N
1638	1685	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251212141322___Total_Becarios_2023/wms?	capa_000000_2664	Becas otorgadas año 2023	t	42071	1	2026-01-07 09:50:44.642837-05	\N	\N
1639	204	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema//wms?	capa_20_16	Pobreza Monetaria - Dist. 2018	t	16269	1	2026-01-07 09:50:44.642837-05	\N	\N
1640	529	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Febrero.	t	41599	1	2026-01-07 09:50:44.642837-05	\N	\N
1641	1456	11	http://sigr.regioncajamarca.gob.pe:6080/arcgis/services/Map/Medio_Biologico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Medio Biológico	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1642	319	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Consultoras_Ambientales_Linea/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Consultoras ambientales (línea)	t	42013	1	2026-01-07 09:50:44.642837-05	\N	\N
1643	150	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/lima_pob_1a14_/wms?	lima_pob_1a14_	Capital Humano	t	1059	1	2026-01-07 09:50:44.642837-05	\N	\N
1644	1304	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSMARANON_SAN_IGNACIO/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EPSMARANON_SAN_IGNACIO	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1645	1062	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_DeTransporte/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	De Transporte	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1646	1587	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1647	1134	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250602002916___Oficina_atencion_abril2025/wms?	capa_000000_1798	Oficinas de atención al cliente	t	40932	1	2026-01-07 09:50:44.642837-05	\N	\N
1648	322	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Derechos_Acuicolas_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Derechos acuícolas (polígono)	t	42005	1	2026-01-07 09:50:44.642837-05	\N	\N
1649	757	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250813091550___local_pge_080825/wms?	capa_000000_2009	Locales de la PGE	t	41286	1	2026-01-07 09:50:44.642837-05	\N	\N
1650	361	11	https://ide.igp.gob.pe/geoserver/Geologia/wms?	0	Estudios sobre Comportamiento Dinámico de Suelos-Mapa de Geología	t	39441	1	2026-01-07 09:50:44.642837-05	\N	\N
1651	257	11	https://sisfor.osinfor.gob.pe/osinfor/services/capas_osinfor/CONCESION_FORESTAL_v2/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Concesión Forestal	t	40771	1	2026-01-07 09:50:44.642837-05	\N	\N
1652	260	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240712174015___Sedes_legado/wms?	capa_000000_1024	Infraestructura deportiva - Sedes legado	t	39908	1	2026-01-07 09:50:44.642837-05	\N	\N
1653	852	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/proyectos_inversion_publica_seguridad_ciudadana/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Total de Proyectos No Finalizados	t	26559	1	2026-01-07 09:50:44.642837-05	\N	\N
1654	258	11	https://sisfor.osinfor.gob.pe/osinfor/services/tematicas_osinfor/SUPERVISIONES_FORESTALES/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Supervisiones Forestales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1655	1318	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Acometidas	Acometidas	t	8314	1	2026-01-07 09:50:44.642837-05	\N	\N
1656	1290	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPAB_AR/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPAB_AR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1657	1164	11	https://www.idep.gob.pe/geoportal/services/MAPA_BASE/PER%C3%9A_DEM/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	DEM Y Regiones del Perú	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1658	1601	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1659	1388	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241203120738___8_Pob_con_sin_seguro_2023/wms?	capa_000000_1452	% Población por tenencia de seguro de salud (2014 al 2023)	t	40475	1	2026-01-07 09:50:44.642837-05	\N	\N
1660	813	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hurto	t	26545	1	2026-01-07 09:50:44.642837-05	\N	\N
1661	122	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	INVASION_TERRENOS	Invasión de Terrenos	t	16208	1	2026-01-07 09:50:44.642837-05	\N	\N
1662	268	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_paisaje_cultural/wms?service=WMS&request=GetCapabilities	0	cultura_paisaje_cultural	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1663	1240	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_departamental_dic22&maxFeatures=1000&	0	Red vial departamental 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1664	1342	11	https://geoservidor.fondepes.gob.pe/geoserver/FONDEPES/Centro%20de%20Procesamiento%20Artesanal/wms?service=WMS&version=1.3.0&request=GetCapabilities	0	Centro de Procesamiento Pesquero Artesanal	t	35751	1	2026-01-07 09:50:44.642837-05	\N	\N
1665	388	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_008_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Agosto.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1666	343	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Recurso_Energetico_Renovable_Pol/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Recurso energético renovable (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1667	1081	12	https://geosnirh.ana.gob.pe/server/services/Público/Presas/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Presas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1668	485	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_04/05_04_010_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima - Mes de Octubre.	t	41623	1	2026-01-07 09:50:44.642837-05	\N	\N
1669	1421	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pma_via_ccpp_/wms?	peru_pma_via_ccpp_	Vul. Inseguridad Alimentaria - CCPP	t	955	1	2026-01-07 09:50:44.642837-05	\N	\N
1670	1010	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240924233110___Moodle_Abr_Jun_2024/wms?	capa_000000_1233	Moodle (Abril - Junio 2024)	t	40175	1	2026-01-07 09:50:44.642837-05	\N	\N
1671	1516	11	https://ider.regionucayali.gob.pe/geoservicios/services/dgt/Limites_politicos_administrativo/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Límite Político Administrativo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1672	271	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_museos/wms?service=WMS&request=GetCapabilities	cultura_museos	Museos	t	39101	1	2026-01-07 09:50:44.642837-05	\N	\N
1673	79	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1122	Casos al 22 de Noviembre 2021	t	17349	1	2026-01-07 09:50:44.642837-05	\N	\N
1674	954	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510172739___Medicos_CNV_oct2023/wms?	capa_000000_862	Médicos que certifican el nacimiento	t	39694	1	2026-01-07 09:50:44.642837-05	\N	\N
1675	206	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_cenagro_asistecnica_/wms?	peru_cenagro_asistecnica_	Productores - Distrito	t	1148	1	2026-01-07 09:50:44.642837-05	\N	\N
1676	894	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240513120556___peru_compras_dep_2023/wms?	capa_000000_871	Estadísticas por catálogo - 2023	t	39703	1	2026-01-07 09:50:44.642837-05	\N	\N
1677	214	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250205170318___Renamu_2024_PM_TyA/wms?	capa_000000_1625	Técnicos y Auxiliares	t	40703	1	2026-01-07 09:50:44.642837-05	\N	\N
1678	750	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_013_medios_libres/wfs?service=WFS&request=GetCapabilities	0	Establecimientos de Medios Libres	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1679	646	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_008_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Agosto.	t	41873	1	2026-01-07 09:50:44.642837-05	\N	\N
1680	203	11	http://mapas.geoidep.gob.pe/geoidep/services/Sistema_de_Centros_Poblados/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Población Dispersa	t	1286	1	2026-01-07 09:50:44.642837-05	\N	\N
1681	1063	12	https://geosnirh.ana.gob.pe/server/services/Público/DUA_DomesticoPoblacional/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Doméstico – Poblacional	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1682	102	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20241016162911___Casos_al_29_de_setiembre_del_2024/wms?	capa_A00012_415	Casos al 29 de setiembre del 2024	t	40296	1	2026-01-07 09:50:44.642837-05	\N	\N
1683	888	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240903165033___Contratado_OSCE/wms?	capa_000000_1155	Datos de la convocatoria o invitación - Contratado	t	40059	1	2026-01-07 09:50:44.642837-05	\N	\N
1684	294	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Depositos_Relave/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Componentes fiscalizables - Depósito de relave mineros	t	42003	1	2026-01-07 09:50:44.642837-05	\N	\N
1685	420	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_016_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Estación de Invierno.	t	41594	1	2026-01-07 09:50:44.642837-05	\N	\N
1686	402	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_13/06_13_001_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Precipitación 2050 Anual.	t	41823	1	2026-01-07 09:50:44.642837-05	\N	\N
1687	329	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Lineas_Transmision_Existentes/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Línea de transmisión existente	t	41981	1	2026-01-07 09:50:44.642837-05	\N	\N
1688	1411	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241119165342___3_Por_Deficiencia_Intelectual_Set2024/wms?	capa_000000_1434	Por tipo de deficiencia en la discapacidad intelectual	t	40441	1	2026-01-07 09:50:44.642837-05	\N	\N
1689	1132	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250116154737___Capa2_Centro_aten_clie_Dic2024/wms?	capa_000000_1590	Centro de atención al cliente	t	40657	1	2026-01-07 09:50:44.642837-05	\N	\N
1690	1302	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSBARRANCA/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EPSBARRANCA	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1691	1126	11	https://geocatmin.ingemmet.gob.pe/arcgis/services/SERV_CATASTRO_MINERO_WGS84/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Catastro Minero	t	30288	1	2026-01-07 09:50:44.642837-05	\N	\N
1692	1061	11	https://geosnirh.ana.gob.pe/server/services/Público/Consejos_de_Cuencas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Consejos de Recursos Hidricos de Cuenca	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1693	975	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240424110519___Vacuna_regular_feb2024/wms?	capa_000000_742	Vacuna Antineumocócica	t	39562	1	2026-01-07 09:50:44.642837-05	\N	\N
1694	1247	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251127091814___Red_Vial_Vecinal/wms?	capa_000000_2638	Red Vial Vecinal	t	42031	1	2026-01-07 09:50:44.642837-05	\N	\N
1695	1287	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSMARANON_SAN_IGNACIO/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de San Ignacio	t	41022	1	2026-01-07 09:50:44.642837-05	\N	\N
1696	275	11	https://geoservidorperu.minam.gob.pe/arcgis/services/ServiciosGeneticos_Bioseguridad/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Capas de servicios genéticos y bioseguridad	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1697	1285	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EPSMARANON_JAEN/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Jaén	t	41021	1	2026-01-07 09:50:44.642837-05	\N	\N
1698	777	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarias Familia	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1699	1653	11	https://gis.chavimochic.gob.pe/geoserver/calidadaguasuperficial2024/peru_pech_007_monitoreo_superficial_anual_2024/wms?request=GetCapabilities&service=WMS	0	Monitoreo Superficial Anual 2024	t	41947	1	2026-01-07 09:50:44.642837-05	\N	\N
1700	410	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_15/06_15_005_03_001_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Cambio de Temperatura Máxima 2050 Primavera.	t	41837	1	2026-01-07 09:50:44.642837-05	\N	\N
1701	770	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cantidad de servidores propios y operativos	t	27685	1	2026-01-07 09:50:44.642837-05	\N	\N
1702	756	12	https://geoinpe.inpe.gob.pe:8443/geoserver/geoinpe/peru_inpe_013_sedes_regionales/wfs?service=WFS&request=GetCapabilities	0	Sedes Regionales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1703	793	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/establecimientos_penitenciarios/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Establecimientos penitenciarios	t	26516	1	2026-01-07 09:50:44.642837-05	\N	\N
1704	638	11	https://idesep.senamhi.gob.pe:443/geoserver/g_02_06/02_06_002_03_001_512_2024_00_00/ows?service=WMS&request=GetCapabilities	0	Niño 2024 - Precipitación EFM	t	41565	1	2026-01-07 09:50:44.642837-05	\N	\N
1705	1502	11	https://portal.regionsanmartin.gob.pe/server/services/IDERSAM/Monitoreo_y_controLforestal/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Monitoreo y Control Forestal	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1706	1133	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250116154629___Capa1_Oficina_principal_Dic2024/wms?	capa_000000_1589	Oficina principal	t	40656	1	2026-01-07 09:50:44.642837-05	\N	\N
1707	337	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Procesamiento_GasN/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas de procesamiento de gas natural	t	41998	1	2026-01-07 09:50:44.642837-05	\N	\N
1708	967	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240428172958___Psicologos_XEESS_Feb2024/wms?	capa_000000_800	Psicólogos por EESS	t	39620	1	2026-01-07 09:50:44.642837-05	\N	\N
1709	6	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20241016161517___Casos_al_01_de_setiembre_del_2024/wms?	capa_A00012_411	Casos al 01 de setiembre del 2024	t	40292	1	2026-01-07 09:50:44.642837-05	\N	\N
1710	900	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250923122704___4_EOB_Dic2024/wms?	capa_000000_2067	Establecimientos de operaciones básicas (EOB)	t	41407	1	2026-01-07 09:50:44.642837-05	\N	\N
1711	171	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccpp_3_/wms?	peru_ccpp_3_	De 1,001 a 2,500 Habitantes	t	767	1	2026-01-07 09:50:44.642837-05	\N	\N
1712	1064	12	https://geosnirh.ana.gob.pe/server/services/Público/Drenes/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Drenes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1713	1005	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250818233000___Competencias_Laborales_Abril_Junio_2025/wms?	capa_000000_2016	Certificación de competencias laborales (Abril - Junio 2025)	t	41299	1	2026-01-07 09:50:44.642837-05	\N	\N
1714	174	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_ccpp_5_/wms?	peru_ccpp_5_	De 5,001 a 500,000 Habitantes	t	769	1	2026-01-07 09:50:44.642837-05	\N	\N
1715	889	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251003163542___afiliados_snp_set_cortejun25/wms?	capa_000000_2123	Afiliados del Sistema Nacional de Pensiones (SNP)	t	41473	1	2026-01-07 09:50:44.642837-05	\N	\N
1716	514	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_007_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Mes de Julio.	t	41753	1	2026-01-07 09:50:44.642837-05	\N	\N
1717	1239	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_ferroviaria_dic22/wms?service=wms&request=GetCapabilities	0	Red ferroviaria 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1718	339	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Plantas_Envasadoras_Hidrocarburos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas envasadora de hidrocarburos	t	41989	1	2026-01-07 09:50:44.642837-05	\N	\N
1719	43	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1213	Casos al 13 de Diciembre 2021	t	19384	1	2026-01-07 09:50:44.642837-05	\N	\N
1720	1611	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_vias/wms?request=GetCapabilities&service=WMS	0	Vías	t	8311	1	2026-01-07 09:50:44.642837-05	\N	\N
1721	1393	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241226152033___1_Acceb_ent_fisico_ene_dic_2023/wms?	capa_000000_1526	Al medio físico según entidades, puntos de intervención y regiones (2023)	t	40591	1	2026-01-07 09:50:44.642837-05	\N	\N
1722	323	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Derechos_Acuicolas_Pto/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Derechos acuícolas (punto)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1723	100	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250206173945___Casos_al_28_de_octubre_del_2024/wms?	capa_000000_1638	Casos al 28 de octubre del 2024	t	40749	1	2026-01-07 09:50:44.642837-05	\N	\N
1724	565	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_003_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Marzo.	t	41732	1	2026-01-07 09:50:44.642837-05	\N	\N
1725	551	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_010_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Octubre.	t	41658	1	2026-01-07 09:50:44.642837-05	\N	\N
1726	1414	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241212104737___9_Pob_con_sin_prom_est_2023/wms?	capa_000000_1494	Promedio de años de estudio de la población de 15 años a más (2014 al 2023)	t	40550	1	2026-01-07 09:50:44.642837-05	\N	\N
1727	67	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230804150825___Casos_al_19_de_mayo_del_2023/wms?	capa_A00012_341	Casos al 19 de mayo del 2023	t	38144	1	2026-01-07 09:50:44.642837-05	\N	\N
1728	1364	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250521093435___CEM_2024_TOTAL/wms?	capa_000000_1742	Casos atendidos total CEM (2024)	t	40865	1	2026-01-07 09:50:44.642837-05	\N	\N
1729	688	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_01/11_01_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Arroz	t	41877	1	2026-01-07 09:50:44.642837-05	\N	\N
1730	444	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_001_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Enero.	t	41631	1	2026-01-07 09:50:44.642837-05	\N	\N
1731	432	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_005_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Mayo.	t	41582	1	2026-01-07 09:50:44.642837-05	\N	\N
1732	398	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_009_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Septiembre.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1733	1606	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_construccion/wms?request=GetCapabilities&service=WMS	0	Construcciones	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1734	1360	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_promocion_cons_prod_hidrobiol_2022_/wms?	peru_econo_educ_promocion_cons_prod_hidrobiol_2022_	Promoción de Consumos de Productos Hidrobiológicos - 2022	t	39054	1	2026-01-07 09:50:44.642837-05	\N	\N
1735	1316	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_nuv_cred_mivivienda_ncmv_2022_/wms?	peru_finan_nuv_cred_mivivienda_ncmv_2022_	Nuevo Crédito MIVIVIENDA (NCMV)	t	38337	1	2026-01-07 09:50:44.642837-05	\N	\N
1736	222	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/data_pob_servicios_higienicos_/wms?	data_pob_servicios_higienicos_	Viviendas sin Servicios Higiénicos	t	948	1	2026-01-07 09:50:44.642837-05	\N	\N
1737	942	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510144635___Homicidios_dist_ene_oct2023/wms?	capa_000000_841	Defunciones por homicidio	t	39673	1	2026-01-07 09:50:44.642837-05	\N	\N
1738	796	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_denuncias_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Feminicidios	t	26547	1	2026-01-07 09:50:44.642837-05	\N	\N
1739	792	11	https://geomininter.mininter.gob.pe/arcgis/services/ogc/lineabase/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	División Policial	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1740	675	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_02/03_02_002_03_000_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Pronóstico Climático de Temperatura Mínima Trimestral.	t	41566	1	2026-01-07 09:50:44.642837-05	\N	\N
1741	962	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240428165904___Obstetras_XEESS_Feb2024/wms?	capa_000000_799	Obstetras por EESS	t	39619	1	2026-01-07 09:50:44.642837-05	\N	\N
1742	525	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_014_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Estación de Verano.	t	41610	1	2026-01-07 09:50:44.642837-05	\N	\N
1743	1487	11	https://portal.regionsanmartin.gob.pe/server/services/DRASAM/ambitointervencion/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ámbito de Intervención del "Proyecto Cacao"	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1744	301	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Areas_Degradadas_RRSS_Municipales_Invt/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Inventario nacional de áreas degradadas por RRSS municipales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1745	1250	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250926103947___Terminal_pesq_jun25/wms?	capa_000000_2102	Terminal Pesquero	t	41443	1	2026-01-07 09:50:44.642837-05	\N	\N
1746	1039	11	https://winlmprap09.midagri.gob.pe/winlmprap13/services/ogc/COPREDRUST/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	PREDRUST	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1747	201	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240813094708___Plan_institucional/wms?	capa_000000_1101	Plan Estratégico Institucional	t	40002	1	2026-01-07 09:50:44.642837-05	\N	\N
1748	168	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_distnbi_/wms?	peru_distnbi_	Con al Menos una NBI	t	4813	1	2026-01-07 09:50:44.642837-05	\N	\N
1749	1607	11	https://geoserver.miraflores.gob.pe:8443/geoserver/idep/wms_tg_lotes/wms?request=GetCapabilities&service=WMS	0	Lotes Catastrales	t	32288	1	2026-01-07 09:50:44.642837-05	\N	\N
1750	563	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_007_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Julio.	t	41736	1	2026-01-07 09:50:44.642837-05	\N	\N
1751	1249	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_red_vial_vecinal_dic23&maxFeatures=1000&	0	Red vial vecinal 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1752	1390	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241205115112___3_Pob_con_sin_disc_org_soc_2023/wms?	capa_000000_1461	% Población que participa en organizaciones sociales por año (2014 al 2023)	t	40503	1	2026-01-07 09:50:44.642837-05	\N	\N
1753	1270	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_macro_sistema_/wms?	peru_macro_sistema_	Macro Sistema	t	8077	1	2026-01-07 09:50:44.642837-05	\N	\N
1754	1309	11	https://sig.otass.gob.pe/server/services/CAPAS/WMS_OTASS_EPS/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	WMSJ3TASS _EPS	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1755	1434	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250716171804___Capa7_Contigo_Abril2025/wms?	capa_000000_1951	CONTIGO	t	41215	1	2026-01-07 09:50:44.642837-05	\N	\N
1756	441	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_004_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Abril.	t	41635	1	2026-01-07 09:50:44.642837-05	\N	\N
1757	522	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_016_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Estación de Invierno.	t	41612	1	2026-01-07 09:50:44.642837-05	\N	\N
1758	288	11	https://geoservicios.sernanp.gob.pe/arcgis/services/base_fisica/peru_sernanp_0102/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Áreas Naturales Protegidas de Administración Nacional Definitiva	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1759	185	12	https://maps.inei.gob.pe/geoserver/T10Limites/ig_distrito/ows?service=WFS&request=GetCapabilities	0	Límite Distrital	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1760	599	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_008_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Agosto	t	41845	1	2026-01-07 09:50:44.642837-05	\N	\N
1761	349	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Unidades_Menores_Pto/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Unid.menores hidrocarburos (punto)	t	41993	1	2026-01-07 09:50:44.642837-05	\N	\N
1762	1071	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Indunstrial/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Industrial	t	38809	1	2026-01-07 09:50:44.642837-05	\N	\N
1763	864	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_demografica_salud_familiar/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Psicológica y-o Verbal (Últimos 12 Meses)	t	26541	1	2026-01-07 09:50:44.642837-05	\N	\N
1764	1228	12	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=pe_mtc_018_aerodromos_dic23	0	Aeródromos 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1765	557	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_014_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Verano.	t	41743	1	2026-01-07 09:50:44.642837-05	\N	\N
1767	1245	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_red_vial_nacional_dic23/wms?service=wms&request=GetCapabilities	0	Red vial nacional 2023	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1768	682	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_007_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Después de 1960 (1992)	t	41551	1	2026-01-07 09:50:44.642837-05	\N	\N
1769	649	11	https://idesep.senamhi.gob.pe:443/geoserver/g_09_02/09_02_002_03_002_511_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Número de Eventos de Nevadas Promedio Mensual de Febrero.	t	41867	1	2026-01-07 09:50:44.642837-05	\N	\N
1770	587	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_03/08_03_032_03_001_522_2012_12_31/ows?service=WMS&request=GetCapabilities	0	Erosión Hídrica del Suelo del año 2012.	t	41852	1	2026-01-07 09:50:44.642837-05	\N	\N
1771	295	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Conflictos_Socioambientales_Area_Influencia/MapServer/generateKml	0	Conflictos socioambientales - Áreas de influencia	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1772	1404	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241118182047___2_Por_Grupo_Edad_Set2024/wms?	capa_000000_1426	Por grupo de edad	t	40433	1	2026-01-07 09:50:44.642837-05	\N	\N
1773	758	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pronacej_cdjr_/wms?	peru_pronacej_cdjr_	Centros Juveniles de Diagnóstico y Rehabilitación (CDJR)	t	23917	1	2026-01-07 09:50:44.642837-05	\N	\N
1774	306	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Sistema_Ductos_Hidrocarburos_Liquidos/MapServer/generateKml	0	Unidad fiscalizable - Ductos de transporte de hidrocarburos líquidos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1775	1668	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251120102130___PAM_Santa_Teresita_04_11_25/wms?	capa_000000_2570	Pasivo ambiental minero Santa Teresita	t	41957	1	2026-01-07 09:50:44.642837-05	\N	\N
1776	340	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Area_Unidad_Industrial/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Plantas industriales (polígono)	t	41985	1	2026-01-07 09:50:44.642837-05	\N	\N
1777	537	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_016_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Estación de Invierno.	t	41664	1	2026-01-07 09:50:44.642837-05	\N	\N
1778	125	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721154151___LAB_ACADEMIA/wms?	capa_000000_1956	Laboratorios de la Academia	t	41223	1	2026-01-07 09:50:44.642837-05	\N	\N
1779	694	11	https://idesep.senamhi.gob.pe:443/geoserver/g_11_03/11_03_001_03_001_531_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Riesgo de cultivo de Papa	t	41879	1	2026-01-07 09:50:44.642837-05	\N	\N
1780	370	11	https://ide.igp.gob.pe/geoserver/CTS_ultimosismo/wms?service=WMS&request=GetCapabilities	0	Último Sismo	t	17335	1	2026-01-07 09:50:44.642837-05	\N	\N
1781	1525	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_manzana/wms?service=WMS&request=GetCapabilities	0	Manzanas catastrales	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1782	1518	12	https://ider.regionucayali.gob.pe/geoservicios/services/servicios_ogc/Peru_GRU_0903/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Puesto de control	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1783	397	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_04/08_04_010_03_001_514_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Atlas de Energia Solar del mes de Octubre.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1784	61	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618174311___Casos_al_17_de_marzo_del_2025/wms?	capa_000000_1855	Casos al 17 de marzo del 2025	t	41077	1	2026-01-07 09:50:44.642837-05	\N	\N
1785	212	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_viv_ALUMBRADO_/wms?	peru_viv_ALUMBRADO_	Sin Alumbrado Eléctrico	t	1051	1	2026-01-07 09:50:44.642837-05	\N	\N
1786	437	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_016_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Estación de Invierno.	t	41647	1	2026-01-07 09:50:44.642837-05	\N	\N
1787	244	11	https://geosunass.sunass.gob.pe/gisserver/services/GeoPeru_ags/Area_de_prestacion_de_servicios/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Área de la prestación de servicios de saneamiento	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1788	329	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Lineas_Transmision_Existentes/MapServer/generateKml	0	Unidades fiscalizables - Línea de transmisión existente	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1789	717	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_09/06_09_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Media Mensual de Agosto.	t	41794	1	2026-01-07 09:50:44.642837-05	\N	\N
1790	10	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250618172807___Casos_al_03_de_febrero_del_2025/wms?	capa_000000_1852	Casos al 03 de febrero del 2025	t	41074	1	2026-01-07 09:50:44.642837-05	\N	\N
1791	1057	12	https://geosnirh.ana.gob.pe/server/services/Público/CanalAduccion/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Canales de Aducción	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1792	1536	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_idh_departamental_/wms?	peru_idh_departamental_	IDH Departamental 2019	t	8191	1	2026-01-07 09:50:44.642837-05	\N	\N
1793	568	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_010_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Octubre.	t	41739	1	2026-01-07 09:50:44.642837-05	\N	\N
1794	294	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Depositos_Relave/MapServer/generateKml	0	Componentes fiscalizables - Depósito de relave mineros	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1795	490	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_017_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Estación de Primavera.	t	41712	1	2026-01-07 09:50:44.642837-05	\N	\N
1796	669	11	https://idesep.senamhi.gob.pe:443/geoserver/g_03_05/03_05_001_03_000_513_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Predicción Numérica - Modelo Pp 24 Hrs.	t	41570	1	2026-01-07 09:50:44.642837-05	\N	\N
1797	528	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_03/05_03_001_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima - Mes de Enero.	t	41596	1	2026-01-07 09:50:44.642837-05	\N	\N
1798	234	11	https://gisem.osinergmin.gob.pe/serverosih/services/OGC/PeruOsinergmin019RedesBajaTension/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Red de baja tensión - Estructuras	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1799	504	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_013_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Anual.	t	41759	1	2026-01-07 09:50:44.642837-05	\N	\N
1800	602	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/08_01_002_03_001_532_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Frecuencia de Heladas del mes de Febrero	t	41839	1	2026-01-07 09:50:44.642837-05	\N	\N
1801	327	11	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Infraestructura_RRSS_Pol/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidades fiscalizables - Infraestructuras de RRSS (polígono)	t	42009	1	2026-01-07 09:50:44.642837-05	\N	\N
1802	1124	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250724155634___Transmision_electrica_Jul25/wms?	capa_000000_1974	Transmisión Eléctrica	t	41246	1	2026-01-07 09:50:44.642837-05	\N	\N
1803	549	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_005_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Mayo.	t	41653	1	2026-01-07 09:50:44.642837-05	\N	\N
1804	961	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027164805___Obstetras_Distrito_Julio_2025/wms?	capa_000000_2309	Obstetras por distrito	t	41681	1	2026-01-07 09:50:44.642837-05	\N	\N
1805	878	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_presupuesto_regional_/wms?	peru_presupuesto_regional_	Presupuesto Regional	t	1071	1	2026-01-07 09:50:44.642837-05	\N	\N
1806	780	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que disponen con serenazgo en el distrito	t	27675	1	2026-01-07 09:50:44.642837-05	\N	\N
1807	1666	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251119144452___PAM_San_Antonio_Esquilache_04_11_25/wms?	capa_000000_2532	Pasivo ambiental minero San Antonio de Esquilache	t	41919	1	2026-01-07 09:50:44.642837-05	\N	\N
1808	369	11	https://ide.igp.gob.pe/arcgis/services/monitoreocensis/Sismicidad/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sismos reportados en tiempo real	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1809	1031	12	https://winlmprap09.midagri.gob.pe/winlmprap14/services/servicios_ogc/Peru_midagri_0702/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	CUM Semidetallado 1-10000	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1810	116	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251014152716___Hidrico/wms?	capa_000000_2136	Hídrico	t	41503	1	2026-01-07 09:50:44.642837-05	\N	\N
1811	1672	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251124094712___Escuelas_Cul_Oct2025/wms?	capa_000000_2571	Escuelas culturales	t	41962	1	2026-01-07 09:50:44.642837-05	\N	\N
1812	1589	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250604162745___comisaria_chepen_prov/wms?	capa_1304_6	Comisarías	t	40962	1	2026-01-07 09:50:44.642837-05	\N	\N
1813	327	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Infraestructura_RRSS_Pol/MapServer/generateKml	0	Unidades fiscalizables - Infraestructuras de RRSS (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1814	315	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Centrales_Termoelectricas_Existentes/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Unidades fiscalizables - Centrales termoeléctricas existentes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1815	1471	12	https://geoserviciosider.regionloreto.gob.pe/server/services/servicios_wfs/ComunidadesCampesinas/MapServer/WFSServer?request=GetCapabilities&service=WFS	capa_1301_214	Comunidades Campesinas	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1816	1288	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_TOCACHE/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	Ortofoto de la ciudad de Tocache	t	41024	1	2026-01-07 09:50:44.642837-05	\N	\N
1817	1448	11	http://geoportal.regionamazonas.gob.pe/geoserver/visor/cb_provincias/wms?service=WMS&request=GetCapabilities	0	Límite Provincial	t	35813	1	2026-01-07 09:50:44.642837-05	\N	\N
1818	1020	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251002150501___prog_llamkasun_ago25/wms?	capa_000000_2112	Empleos temporales - Agosto 2025	t	41462	1	2026-01-07 09:50:44.642837-05	\N	\N
1819	536	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_013_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Anual.	t	41661	1	2026-01-07 09:50:44.642837-05	\N	\N
1820	710	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_10/06_10_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Máxima Mensual de Marzo.	t	41802	1	2026-01-07 09:50:44.642837-05	\N	\N
1821	569	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_009_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Septiembre.	t	41738	1	2026-01-07 09:50:44.642837-05	\N	\N
1822	202	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/ peru_adulto_mayor_65mas_/wms?	 peru_adulto_mayor_65mas_	Población Adulto Mayor de 65 años y más	t	8279	1	2026-01-07 09:50:44.642837-05	\N	\N
1823	1355	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_econo_educ_alimen_nutric_pesca_nutric_2023_/wms?	peru_econo_educ_alimen_nutric_pesca_nutric_2023_	Educación Alimentaria y Nutricional (PESCANutrición) - 2023	t	39048	1	2026-01-07 09:50:44.642837-05	\N	\N
1824	944	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510150455___Suicidios_dist_ene_oct2023/wms?	capa_000000_845	Defunciones por suicidio	t	39677	1	2026-01-07 09:50:44.642837-05	\N	\N
1825	1523	11	https://ide.icl.gob.pe:8443/geoserver/IDEP/idep_tg_eje_via/wms?service=WMS&request=GetCapabilities	0	Eje de vía	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1826	1095	11	https://geosnirh.ana.gob.pe/server/services/Público/DUA_Turistico/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Turístico	t	38816	1	2026-01-07 09:50:44.642837-05	\N	\N
1827	339	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Plantas_Envasadoras_Hidrocarburos/MapServer/generateKml	0	Unidades fiscalizables - Plantas envasadora de hidrocarburos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1828	1162	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/CULTURAL_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Cultural (Escala 1:100 000)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1829	561	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_001_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Enero.	t	41730	1	2026-01-07 09:50:44.642837-05	\N	\N
1830	149	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20230330115816___Capital_Provincia/wms?	capa_24_325	Capital de Provincia	t	35819	1	2026-01-07 09:50:44.642837-05	\N	\N
1831	1089	11	https://geosnirh.ana.gob.pe/server/services/Público/SectorHidraulicoMayor/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sector Mayor	t	38792	1	2026-01-07 09:50:44.642837-05	\N	\N
1832	1252	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_terminales_portuarios_dic22/wms?service=wms&request=GetCapabilities	0	Terminales portuarios y embarcaderos 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1833	324	20	\thttps://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Educacion_Pol/MapServer/generateKml	0	Unidades fiscalizables - Educación (polígono)	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1834	223	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pointmza_congl_/wms?	peru_pointmza_congl_	Zonas Urbanas	t	563	1	2026-01-07 09:50:44.642837-05	\N	\N
1835	580	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_05/01_05_002_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Duración Olas de Calor - Otoño	t	41533	1	2026-01-07 09:50:44.642837-05	\N	\N
1836	860	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_demografica_salud_familiar/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Familiar contra la Mujer	t	26536	1	2026-01-07 09:50:44.642837-05	\N	\N
1837	1040	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_uso_may_tierras_2_/wms?	peru_uso_may_tierras_2_	TACL - Cultivos Permanentes	t	1131	1	2026-01-07 09:50:44.642837-05	\N	\N
1838	1222	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_accesibilidad_capitales_/wms?	peru_accesibilidad_capitales_	Accesibilidad entre Capitales	t	764	1	2026-01-07 09:50:44.642837-05	\N	\N
1839	1112	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Unidad_Monitoreo_Satelital/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Unidad de Monitoreo Satelital	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1840	1110	11	https://geo.serfor.gob.pe/geoservicios/services/Servicios_OGC/Modalidad_Acceso/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Permisos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1841	1190	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/ORTOFOTO_ILO/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Ortofoto Ilo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1842	926	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250530171750___IPD_20250211/wms?	capa_000000_1793	Infraestructuras Deportivas del IPD	t	40927	1	2026-01-07 09:50:44.642837-05	\N	\N
1843	1183	11	https://www.idep.gob.pe/geoportal/services/SERVICIOS_IGN/HIDROGRAFIA_100K/MapServer/WMSServer?request=getcapabilities&service=WMS	1	Lago y Laguna	t	39030	1	2026-01-07 09:50:44.642837-05	\N	\N
1844	978	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510155923___Vacuna_DPT-HVB-HIB_xdist_sep2023/wms?	capa_000000_849	Vacuna DPT-HVB-HIB	t	39681	1	2026-01-07 09:50:44.642837-05	\N	\N
1845	908	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241105120314___2_Mujeres_credito_Dic2023/wms?	capa_000000_1401	Porcentaje de mujeres adultas con crédito en el sistema financiero	t	40404	1	2026-01-07 09:50:44.642837-05	\N	\N
1846	244	12	https://geosunass.sunass.gob.pe/gisserver/services/GeoPeru_ags/Area_de_prestacion_de_servicios/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Área de la prestación de servicios de saneamiento	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1847	736	11	https://idesep.senamhi.gob.pe:443/geoserver/g_06_08/06_08_003_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia de Temperatura Mínima Mensual de Marzo.	t	41777	1	2026-01-07 09:50:44.642837-05	\N	\N
1848	292	11	https://geoservicios.sernanp.gob.pe/arcgis/services/gestion_de_anp/peru_sernanp_0213/MapServer/WMSServer?request=Getcapabilities&service=WMS	0	Zonificación ACR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1849	1218	11	http://200.60.23.226:8080/geoserver/PCM/wms?service=WMS&request=GetCapabilities	ProvZarumilla	Provincia de Zarumilla - Tumbes	t	8536	1	2026-01-07 09:50:44.642837-05	\N	\N
1850	1597	11	https://ws.munilince.gob.pe:9094/geoserver/GEOPERU/peru_munilince_015_lotes/wms?service=WMS&request=Getcapabilities\n	0	Lotes del distrito de Lince	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1851	18	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250627143132___Casos_al_05_de_mayo_del_2025/wms?	capa_000000_1932	Casos al 05 de mayo del 2025	t	41166	1	2026-01-07 09:50:44.642837-05	\N	\N
1852	305	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Alertas_Reporta_Residuos/MapServer/generateKml	0	Reporta Residuos - Alertas de residuos sólidos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1853	784	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/sistema_informacion_unidades_policiales/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Comisarías que tienen pisos en buen estado de conservación	t	27671	1	2026-01-07 09:50:44.642837-05	\N	\N
1854	1327	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Tuberías Secundaria	Tuberías Secundaria	t	8312	1	2026-01-07 09:50:44.642837-05	\N	\N
1855	1315	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_finan_desmbolso_modalidad_csp_reconst_2022_/wms?	peru_finan_desmbolso_modalidad_csp_reconst_2022_	Modalidad CSP Reconstrucción (CSP-r)	t	38333	1	2026-01-07 09:50:44.642837-05	\N	\N
1856	307	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Red_Distribucion_Calidda/MapServer/generateKml	0	Unidad fiscalizable - Red de distribución Calidda	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1857	567	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_011_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Noviembre.	t	41740	1	2026-01-07 09:50:44.642837-05	\N	\N
1858	1567	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1859	933	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250828115129___Univ_JMA/wms?	capa_000000_2038	Universidad Nacional José María Arguedas	t	41340	1	2026-01-07 09:50:44.642837-05	\N	\N
1860	14	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251022083551___Casos_al_04_de_agosto_del_2025/wms?	capa_000000_2297	Casos al 04 de agosto del 2025	t	41669	1	2026-01-07 09:50:44.642837-05	\N	\N
1861	1227	11	https://swmapas.mtc.gob.pe:8443/geoserver/geoportal/pe_mtc_018_aerodromos_dic22/wms?service=wms&request=GetCapabilities	0	Aeródromos 2022	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1862	1149	11	https://geosinpad.indeci.gob.pe/indeci/services/Emergencias/SDE_EMERGENCIAS_SINPAD_PCM/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Emergencias	t	31170	1	2026-01-07 09:50:44.642837-05	\N	\N
1863	305	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Alertas_Reporta_Residuos/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Reporta Residuos - Alertas de residuos sólidos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1864	560	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_012_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Diciembre.	t	41741	1	2026-01-07 09:50:44.642837-05	\N	\N
1865	464	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_95/05_95_006_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de San Martín - Mes de Junio.	t	41718	1	2026-01-07 09:50:44.642837-05	\N	\N
1866	1232	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250926115820___Corredor_vial_alim_jun25/wms?	capa_000000_2105	Corredores Viales Alimentadores	t	41446	1	2026-01-07 09:50:44.642837-05	\N	\N
1867	296	20	ttps://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Conflictos_Socioambientales/MapServer/generateKml	0	Conflictos socioambientales - Mesas de diálogo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1868	434	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_010_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Octubre.	t	41587	1	2026-01-07 09:50:44.642837-05	\N	\N
1869	28	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1108	Casos al 08 de Noviembre 2021	t	17347	1	2026-01-07 09:50:44.642837-05	\N	\N
1870	450	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_92/05_92_011_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación del Departamento de Lima - Mes de Noviembre.	t	41642	1	2026-01-07 09:50:44.642837-05	\N	\N
1871	741	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_99/05_99_004_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Tendencia Lluvia, de Inicio 1989/90 a 2018/19 del Departamento de Puno.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1872	141	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20250721170358___ORACLE/wms?	capa_000000_1969	Programa Niñas Digitales - ORACLE	t	41237	1	2026-01-07 09:50:44.642837-05	\N	\N
1873	1322	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAP/MapServer/WMSServer?request=GetCapabilities&service=WMS	Conexión domiciliaria	Conexión domiciliaria	t	8317	1	2026-01-07 09:50:44.642837-05	\N	\N
1874	1049	11	https://geosnirh.ana.gob.pe/server/services/Público/Adminitracion_Local_Agua/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Administración Local del Agua	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1875	1572	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250624201808___MD_Antioquia/wms?	capa_150702_2	Ubicación	t	41129	1	2026-01-07 09:50:44.642837-05	\N	\N
1876	556	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_017_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Estación de Primavera.	t	41746	1	2026-01-07 09:50:44.642837-05	\N	\N
1877	1151	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_riesgos_minagri_/wms?	peru_riesgos_minagri_	Heladas y friaje sector Agricultura Pecuaria	t	1181	1	2026-01-07 09:50:44.642837-05	\N	\N
1878	559	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_008_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Agosto.	t	41737	1	2026-01-07 09:50:44.642837-05	\N	\N
1879	425	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_008_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Mes de Agosto.	t	41585	1	2026-01-07 09:50:44.642837-05	\N	\N
1880	552	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_009_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Septiembre.	t	41657	1	2026-01-07 09:50:44.642837-05	\N	\N
1881	566	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_96/05_96_005_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de San Martín - Mes de Mayo.	t	41734	1	2026-01-07 09:50:44.642837-05	\N	\N
1882	375	11	https://idesep.senamhi.gob.pe:443/geoserver/g_04_02/04_02_007_03_002_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Anomalía de Precipitación 03 Década del mes.	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1883	1085	12	https://geosnirh.ana.gob.pe/server/services/Público/PuntosdeMuestreo/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Puntos de Muestreo	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1884	1081	11	https://geosnirh.ana.gob.pe/server/services/Público/Presas/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Presas	t	38826	1	2026-01-07 09:50:44.642837-05	\N	\N
1885	543	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_93/05_93_012_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Mínima del Departamento de Lima - Mes de Diciembre.	t	41660	1	2026-01-07 09:50:44.642837-05	\N	\N
1886	958	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240510172322___Nacidos_bajo_peso_CNV_oct2023/wms?	capa_000000_861	Nacidos vivos con bajo peso	t	39693	1	2026-01-07 09:50:44.642837-05	\N	\N
1887	1401	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20241216123259___Ins_Educ_Fisc_ene_dic_2023/wms?	capa_000000_1501	Instituciones Educativas Fiscalizadas (2023)	t	40563	1	2026-01-07 09:50:44.642837-05	\N	\N
1888	69	11	https://espacialg.geoperu.gob.pe/geoserver/subsistemas/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetCapabilities	Casos1220	Casos al 20 de Diciembre 2021	t	19438	1	2026-01-07 09:50:44.642837-05	\N	\N
1889	1144	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_delitos_sp_/wms?	peru_delitos_sp_	Delitos contra la Seguridad Pública	t	23894	1	2026-01-07 09:50:44.642837-05	\N	\N
1890	676	11	https://idesep.senamhi.gob.pe:443/geoserver/g_01_97/01_97_001_04_001_512_2022_00_00/ows?service=WMS&request=GetCapabilities	0	Puno Años Secos - Antes de 1960 (1940)	t	41545	1	2026-01-07 09:50:44.642837-05	\N	\N
1891	423	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_02/05_02_014_03_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Precipitación - Estación de Verano.	t	41591	1	2026-01-07 09:50:44.642837-05	\N	\N
1892	1069	12	https://geosnirh.ana.gob.pe/server/services/Público/FuentesContaminantes/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Fuentes Contaminantes	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1893	939	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/vw_peru_centros_covid_/wms?	vw_peru_centros_covid_	Centros de Vacunación	t	11249	1	2026-01-07 09:50:44.642837-05	\N	\N
1894	621	11	https://idesep.senamhi.gob.pe:443/geoserver/g_08_01/wms?	0	Mes de Febrero	t	38989	1	2026-01-07 09:50:44.642837-05	\N	\N
1895	1092	11	https://geosnirh.ana.gob.pe/server/services/Público/SectorHidraulicoMenorC/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Sector Menor Clase C	t	38795	1	2026-01-07 09:50:44.642837-05	\N	\N
1896	808	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hombres atendidos por Violencia Psicológica (18 – 59 años)	t	27717	1	2026-01-07 09:50:44.642837-05	\N	\N
1897	831	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/centros_emergencia_mujer/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Mujeres atendidas por Violencia Sexual (18 – 59 años)	t	27704	1	2026-01-07 09:50:44.642837-05	\N	\N
1898	250	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_servir_enti_publicas_cap_provisional_\t/wms?	peru_servir_enti_publicas_cap_provisional_\t	Entidades Públicas (E.P.) con CAP Provisional	t	20247	1	2026-01-07 09:50:44.642837-05	\N	\N
1899	281	11	https://serviciobosque.minam.gob.pe/geoserver/servicio_perdida_2001_2023/wms	0	Pérdida de Bosque 2001 al 2023	t	41008	1	2026-01-07 09:50:44.642837-05	\N	\N
1900	505	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_97/05_97_016_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de San Martín - Estación de Invierno.	t	41762	1	2026-01-07 09:50:44.642837-05	\N	\N
1901	950	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20251027170422___Medico_Vet_Distrito_Julio_2025/wms?	capa_000000_2312	Médico Veterinario por distrito	t	41684	1	2026-01-07 09:50:44.642837-05	\N	\N
1902	314	20	https://pifa.oefa.gob.pe/server_gis/rest/services/Metadatos/Centrales_Hidroelectricas_Proyectadas/MapServer/generateKml\t	0	Unidades fiscalizables - Centrales hidroeléctricas proyectada	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1903	1298	11	https://sig.otass.gob.pe/server/services/IMAGENES/ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR6/MapServer/WMSServer?service=WMS&request=GetCapabilities	0	ORTOFOTO_EMAPASANMARTIN_PICOTA_SECTOR6	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1904	503	11	https://idesep.senamhi.gob.pe:443/geoserver/g_05_94/05_94_009_04_001_512_0000_00_00/ows?service=WMS&request=GetCapabilities	0	Caracterización de Temperatura Máxima del Departamento de Lima - Mes de Septiembre.	t	41704	1	2026-01-07 09:50:44.642837-05	\N	\N
1905	1499	11	https://portal.regionsanmartin.gob.pe:6443/arcgis/services/IDERSAM/Habitats_cr°/oC3°/oADticos/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Hábitats Críticos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1906	1041	11	https://winlmprap09.midagri.gob.pe/winlmprap13/services/ogc/COTERRDEMAR/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	TERRDEMAR	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1907	267	11	https://geoservicios.cultura.gob.pe/geoserver/interoperabilidad/cultura_museos/wms?service=WMS&request=GetCapabilities	0	cultura_museos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1908	971	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/20240513185345___Tecnico_Esp_XEESS_Feb2024/wms?	capa_000000_878	Técnico Especializado por EESS	t	39710	1	2026-01-07 09:50:44.642837-05	\N	\N
1909	1320	11	https://gisprd.sedapal.com.pe/arcgis/services/movilAL/MapServer/WMSServer?request=GetCapabilities&service=WMS	Colectores Red Primaria	Colectores Red Primaria	t	8321	1	2026-01-07 09:50:44.642837-05	\N	\N
1910	1080	12	https://geosnirh.ana.gob.pe/server/services/Público/Pozos/MapServer/WFSServer?service=WFS&request=GetCapabilities	0	Pozos	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1911	205	11	https://espacialg.geoperu.gob.pe/geoserver/geoperu/peru_pobreza_mapa_pobrezareg_/wms?	peru_pobreza_mapa_pobrezareg_	Pobreza Monetaria - Regional 2022	t	38946	1	2026-01-07 09:50:44.642837-05	\N	\N
1912	300	12	https://pifa.oefa.gob.pe/server_gis/services/Metadatos/Infraestructura_Residuos_Solidos_Invt/MapServer/WFSServer?request=GetCapabilities&service=WFS	0	Inventario nacional de áreas de infraestructura de RRSS	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1913	1209	11	https://espacialg.geoperu.gob.pe/geoserver/subsistema/20250704122220___facilidades_portuarias/wms?	capa_A00052_18	Facilidades Portuarias	t	41177	1	2026-01-07 09:50:44.642837-05	\N	\N
1914	1181	11	https://www.idep.gob.pe/geoportal/services/IMAGENES/IMAGEN_DRONE/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Imágenes RPA - San Isidro	t	0	1	2026-01-07 09:50:44.642837-05	\N	\N
1915	861	11	https://seguridadciudadana.mininter.gob.pe/arcgis/services/servicios_ogc/encuesta_demografica_salud_familiar/MapServer/WMSServer?request=GetCapabilities&service=WMS	0	Violencia Física	t	26542	1	2026-01-07 09:50:44.642837-05	\N	\N
\.


--
-- TOC entry 5881 (class 0 OID 373855)
-- Dependencies: 237
-- Data for Name: def_tipos_servicios; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_tipos_servicios (id, tag, sigla, nombre, descripcion, estado, logotipo, orden, id_padre, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	herramientas_digitales	\N	Herramientas digitales	Son un conjunto de herramientas GIS que pertite compartir diferentes datos geográficos.	t	\N	1	0	1	2025-08-01 00:00:00-05	\N	\N
2	servicios_ogc	\N	Servicios OGC	Los servicios del Open Geospatial Consortium son estándares internacionales que permiten a diferentes sistemas compartir y acceder a datos e información geográfica a través de la web de forma abierta e interoperable.	t	\N	2	0	1	2025-08-01 00:00:00-05	\N	\N
3	servicios_rest_arcgis	\N	Servicios Rest de ArcGIS	Los Servicios REST de ArcGIS son una tecnología que permite a las aplicaciones conectarse y consultar datos y funcionalidades geográficas a través de la red usando el protocolo HTTP	t	\N	3	0	1	2025-08-01 00:00:00-05	\N	\N
4	servicios_rest	\N	Servicios Rest	Son servicios desarrollados propiamente por la entidad	t	\N	4	0	1	2025-08-01 00:00:00-05	\N	\N
5	geoportales	Geoportales	Geoportales de entidades públicas	Portales públicos que comparten información geográfica y servicios especializados.	t	captive_portal	1	1	1	2025-08-01 00:00:00-05	\N	\N
6	visores-de-mapas	Visores	Visores de mapas	Visores de mapas desarrollados por las instituciones públicas.	t	jamboard_kiosk	2	1	1	2025-08-01 00:00:00-05	\N	\N
7	observatorios	Observatorio	Observatorios digitales	Un observatorio digital es una plataforma o sistema diseñado para recopilar, procesar, analizar y clasificar información de diversos entornos digitales con el fin de extraer conocimiento.	f	mystery	11	1	1	2025-08-01 00:00:00-05	\N	\N
8	apps	Apps	Aplicaciones y módulos	Son los programas y herramientas de software que a través de módulos geográficos permiten crear, gestionar, analizar y visualizar datos georreferenciados en mapas.	t	apps	3	1	1	2025-08-01 00:00:00-05	\N	\N
9	metadatos	Metadatos	Portal de metadatos	Es una aplicación en línea que permite a los usuarios buscar y acceder a información descriptiva (metadatos) sobre conjuntos de datos geográficos, como mapas, imágenes y capas de un Sistema de Información Geográfica (SIG).	t	quick_reference_all	16	1	1	2025-08-01 00:00:00-05	\N	\N
10	descargas	Descargas GIS	Descarga GIS (HTTPS, FTP)	Es transferencia de archivos de Sistemas de Información Geográfica (GIS) a través de protocolos FTP y/o HTTPS.	t	browser_updated	17	1	1	2025-08-01 00:00:00-05	\N	\N
11	servicio-de-visualizacion-wms	OGC:WMS	Servicio de visualización de mapas	El servicio OGC:WMS permite visualizar mapas en un visor o un software de Sistema de Información Geográfica - GIS.	t	travel_explore	4	2	1	2025-08-01 00:00:00-05	\N	\N
12	servicio-de-descarga-wfs	OGC:WFS	Servicio de descarga por la web	El servicio OGC:WFS permite la descarga de datos vectoriales a través de la web en formatos compatibles.	t	cloud_download	5	2	1	2025-08-01 00:00:00-05	\N	\N
13	servicios_ogc_wcs	OGC:WCS	Servicio de imagenes de mapas	El servicio OGC:WCS permite acceder a datos ráster georreferenciados en su formato de datos original.	f	image_search	9	2	1	2025-08-01 00:00:00-05	\N	\N
14	servicios_ogc_wmts	OGC:WMTS	Servicio de mosaicos de mapas	El servicio OGC:WMTS permite almacenar los datos (caché) para agilizar la carga de los mismos para una visualización en base a las peticiones de fecha y hora.	t	satellite	7	2	1	2025-08-01 00:00:00-05	\N	\N
15	servicios_ogc_csw	OGC:CSW	Servicio de catalogación de metadatos.	El servicio OGC:CSW permite publicar y generar metadatos geográficos a través de la web.	f	description	8	2	1	2025-08-01 00:00:00-05	\N	\N
16	servicios_ogc_wps	OGC:WPS	Servicio de geoprocesamiento	El servicio OGC:WPS permite procesar solicitudes para el procesamiento geoespacial.	f	subtitles_gear	10	2	1	2025-08-01 00:00:00-05	\N	\N
17	servicios_rest_arcgis_mapserver	REST:ArcGIS MapServer	Servicio REST:ArcGIS MapServer	Es un conjunto de especificaciones de API que permiten a las aplicaciones comunicarse con los servicios de ubicación de ArcGIS a través de solicitudes HTTPS.	t	map_search	6	3	1	2025-08-01 00:00:00-05	\N	\N
18	servicios_rest_arcgis_feature	REST:ArcGIS FeatureServer	Servicio REST:ArcGIS FeatureServer	Servicio Rest de acceso a mapas	f	\N	12	3	1	2025-08-01 00:00:00-05	\N	\N
19	servicios_rest_arcgis_image	REST:ArcGIS ImageServer	Servicio REST:ArcGIS ImageServer	Servicio Rest de imagenes	f	\N	13	3	1	2025-08-01 00:00:00-05	\N	\N
20	servicios_rest_arcgis_kml	REST:ArcGIS KML	Servicio REST:ArcGIS KML	Servicio Rest de ArcGIS que permite la exportación de datos en formato KML.	f	file_json	14	3	1	2025-08-01 00:00:00-05	\N	\N
21	servicios_rest_arcgis_processing	REST:ArcGIS Geoprocessing	Servicio REST:ArcGIS Geoprocessing	Servicio Rest de ArcGIS de geoprocesamiento es una interfaz de servicios web que permite acceder y ejecutar herramientas de geoprocesamiento a través de una URL. Se basa en un modelo de recursos jerárquico.	f	\N	15	3	1	2025-08-01 00:00:00-05	\N	\N
22	servicios_rest_api	REST:Api	Servicio REST:Api	Servicios Rest:Api es una interfaz de programación de aplicaciones (API) que se basa en el estilo arquitectónico REST (Transferencia de Estado Representacional) para permitir la comunicación entre sistemas a través de Internet.	t	\N	16	4	1	2025-08-01 00:00:00-05	\N	\N
\.


--
-- TOC entry 5887 (class 0 OID 373916)
-- Dependencies: 243
-- Data for Name: def_usuarios; Type: TABLE DATA; Schema: ide; Owner: usrgeoperuprd
--

COPY ide.def_usuarios (id, correo_electronico, contrasena, estado, fecha_baja, geoidep, geoperu, metadatos, id_perfil, id_persona, id_institucion, usuario_crea, fecha_crea, usuario_modifica, fecha_modifica) FROM stdin;
1	dquispe@pcm.gob.pe	scrypt:32768:8:1$R2VwxaFFqhLMZ2GZ$a87e56342ff475edd0d064fd6545100bcf88bbe062ae04a4be937db5cb236b3dba9d12c75e1e5a489e3bb9dd26cd5e37e85109f588792f4776e6d7ee61ecb21a	t	\N	t	t	t	2	2	45	1	2025-08-01 00:00:00-05	\N	\N
2	lvaler@pcm.gob.pe	scrypt:32768:8:1$aDkj3nFyaBU1xCpz$ebd75029e7932c1569e351ebed1910af7fe47cbc2fcd89d7238557fc5845c7625e14754f373704d004e9675a196d6b020bb488fca456009b828fb0db28fb9bd4	t	\N	t	t	f	3	6	45	1	2025-08-01 00:00:00-05	\N	\N
3	mfloresh@pcm.gob.pe	scrypt:32768:8:1$RhEjqzN2dHk7Zn4e$ee7402882ca399c5a24b818cab9c86d427a5e20d59b844f88457838597f79266c9ed253568e25c999653efa6c101c9fff4e0f70f8d02940be1cd5800de1f6ad4	t	\N	t	t	f	3	3	45	1	2025-08-01 00:00:00-05	\N	\N
4	lrodriguez@pcm.gob.pe	scrypt:32768:8:1$R2VwxaFFqhLMZ2GZ$a87e56342ff475edd0d064fd6545100bcf88bbe062ae04a4be937db5cb236b3dba9d12c75e1e5a489e3bb9dd26cd5e37e85109f588792f4776e6d7ee61ecb21a	t	\N	t	t	t	3	5	45	1	2025-11-21 00:00:00-05	\N	\N
\.


--
-- TOC entry 5904 (class 0 OID 0)
-- Dependencies: 238
-- Name: def_capas_geograficas_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_capas_geograficas_id_seq', 1, false);


--
-- TOC entry 5905 (class 0 OID 0)
-- Dependencies: 228
-- Name: def_categorias_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_categorias_id_seq', 20, true);


--
-- TOC entry 5906 (class 0 OID 0)
-- Dependencies: 240
-- Name: def_herramientas_digitales_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_herramientas_digitales_id_seq', 450, true);


--
-- TOC entry 5907 (class 0 OID 0)
-- Dependencies: 230
-- Name: def_instituciones_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_instituciones_id_seq', 2153, true);


--
-- TOC entry 5908 (class 0 OID 0)
-- Dependencies: 232
-- Name: def_perfiles_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_perfiles_id_seq', 4, true);


--
-- TOC entry 5909 (class 0 OID 0)
-- Dependencies: 234
-- Name: def_personas_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_personas_id_seq', 6, true);


--
-- TOC entry 5910 (class 0 OID 0)
-- Dependencies: 244
-- Name: def_servicios_geograficos_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_servicios_geograficos_id_seq', 1915, true);


--
-- TOC entry 5911 (class 0 OID 0)
-- Dependencies: 236
-- Name: def_tipos_servicios_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_tipos_servicios_id_seq', 22, true);


--
-- TOC entry 5912 (class 0 OID 0)
-- Dependencies: 242
-- Name: def_usuarios_id_seq; Type: SEQUENCE SET; Schema: ide; Owner: usrgeoperuprd
--

SELECT pg_catalog.setval('ide.def_usuarios_id_seq', 4, true);


--
-- TOC entry 5705 (class 2606 OID 373878)
-- Name: def_capas_geograficas def_capas_geograficas_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_capas_geograficas
    ADD CONSTRAINT def_capas_geograficas_pkey PRIMARY KEY (id);


--
-- TOC entry 5689 (class 2606 OID 373817)
-- Name: def_categorias def_categorias_codigo_key; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_categorias
    ADD CONSTRAINT def_categorias_codigo_key UNIQUE (codigo);


--
-- TOC entry 5691 (class 2606 OID 373815)
-- Name: def_categorias def_categorias_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_categorias
    ADD CONSTRAINT def_categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 5707 (class 2606 OID 373899)
-- Name: def_herramientas_digitales def_herramientas_digitales_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_pkey PRIMARY KEY (id);


--
-- TOC entry 5693 (class 2606 OID 373830)
-- Name: def_instituciones def_instituciones_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_instituciones
    ADD CONSTRAINT def_instituciones_pkey PRIMARY KEY (id);


--
-- TOC entry 5695 (class 2606 OID 373842)
-- Name: def_perfiles def_perfiles_nombre_key; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_perfiles
    ADD CONSTRAINT def_perfiles_nombre_key UNIQUE (nombre);


--
-- TOC entry 5697 (class 2606 OID 373840)
-- Name: def_perfiles def_perfiles_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_perfiles
    ADD CONSTRAINT def_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5699 (class 2606 OID 373853)
-- Name: def_personas def_personas_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_personas
    ADD CONSTRAINT def_personas_pkey PRIMARY KEY (id);


--
-- TOC entry 5713 (class 2606 OID 373952)
-- Name: def_servicios_geograficos def_servicios_geograficos_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_servicios_geograficos
    ADD CONSTRAINT def_servicios_geograficos_pkey PRIMARY KEY (id);


--
-- TOC entry 5701 (class 2606 OID 373867)
-- Name: def_tipos_servicios def_tipos_servicios_nombre_key; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_tipos_servicios
    ADD CONSTRAINT def_tipos_servicios_nombre_key UNIQUE (nombre);


--
-- TOC entry 5703 (class 2606 OID 373865)
-- Name: def_tipos_servicios def_tipos_servicios_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_tipos_servicios
    ADD CONSTRAINT def_tipos_servicios_pkey PRIMARY KEY (id);


--
-- TOC entry 5709 (class 2606 OID 373926)
-- Name: def_usuarios def_usuarios_correo_electronico_key; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_correo_electronico_key UNIQUE (correo_electronico);


--
-- TOC entry 5711 (class 2606 OID 373924)
-- Name: def_usuarios def_usuarios_pkey; Type: CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 5714 (class 2606 OID 373879)
-- Name: def_capas_geograficas def_capas_geograficas_id_categoria_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_capas_geograficas
    ADD CONSTRAINT def_capas_geograficas_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES ide.def_categorias(id);


--
-- TOC entry 5715 (class 2606 OID 373884)
-- Name: def_capas_geograficas def_capas_geograficas_id_institucion_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_capas_geograficas
    ADD CONSTRAINT def_capas_geograficas_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES ide.def_instituciones(id);


--
-- TOC entry 5716 (class 2606 OID 373900)
-- Name: def_herramientas_digitales def_herramientas_digitales_id_categoria_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES ide.def_categorias(id);


--
-- TOC entry 5717 (class 2606 OID 373905)
-- Name: def_herramientas_digitales def_herramientas_digitales_id_institucion_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES ide.def_instituciones(id);


--
-- TOC entry 5718 (class 2606 OID 373910)
-- Name: def_herramientas_digitales def_herramientas_digitales_id_tipo_servicio_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_herramientas_digitales
    ADD CONSTRAINT def_herramientas_digitales_id_tipo_servicio_fkey FOREIGN KEY (id_tipo_servicio) REFERENCES ide.def_tipos_servicios(id);


--
-- TOC entry 5722 (class 2606 OID 373953)
-- Name: def_servicios_geograficos def_servicios_geograficos_id_capa_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_servicios_geograficos
    ADD CONSTRAINT def_servicios_geograficos_id_capa_fkey FOREIGN KEY (id_capa) REFERENCES ide.def_capas_geograficas(id);


--
-- TOC entry 5723 (class 2606 OID 373958)
-- Name: def_servicios_geograficos def_servicios_geograficos_id_tipo_servicio_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_servicios_geograficos
    ADD CONSTRAINT def_servicios_geograficos_id_tipo_servicio_fkey FOREIGN KEY (id_tipo_servicio) REFERENCES ide.def_tipos_servicios(id);


--
-- TOC entry 5719 (class 2606 OID 373927)
-- Name: def_usuarios def_usuarios_id_institucion_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES ide.def_instituciones(id);


--
-- TOC entry 5720 (class 2606 OID 373932)
-- Name: def_usuarios def_usuarios_id_perfil_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES ide.def_perfiles(id);


--
-- TOC entry 5721 (class 2606 OID 373937)
-- Name: def_usuarios def_usuarios_id_persona_fkey; Type: FK CONSTRAINT; Schema: ide; Owner: usrgeoperuprd
--

ALTER TABLE ONLY ide.def_usuarios
    ADD CONSTRAINT def_usuarios_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES ide.def_personas(id);


-- Completed on 2026-01-07 14:25:09

--
-- PostgreSQL database dump complete
--

\unrestrict h1Ob3z60u5uDIbj10qrf4dnvBt6SkDEGBQNZBtlYdPIfWneLdukPtQ8X7jK2pY7

