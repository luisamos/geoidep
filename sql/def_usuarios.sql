--
-- USUARIOS
--
DROP TABLE IF EXISTS public.def_usuario;
CREATE TABLE IF NOT EXISTS public.def_usuario
(
	id SERIAL PRIMARY KEY,
	id_tipo_documento integer,
	numero_documento character varying(20),
	apellidos character varying(256),
	nombres character varying(256),
	correo_electronico character varying(80),
	clave character varying(256),
	fotografia character varying(256),
	id_tipo integer, -- Titular y Alterno
	id_institucion integer,
	norma_designacion text,
	fecha date,
	estado boolean,
	CONSTRAINT def_institucion_usuario_fkey FOREIGN KEY (id_institucion)
        REFERENCES public.def_institucion (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

