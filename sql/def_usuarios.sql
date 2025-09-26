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

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE OR REPLACE FUNCTION fn_login_usuario(p_username TEXT, p_password TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    v_password TEXT;
BEGIN
    SELECT password_hash INTO v_password FROM def_usuario WHERE username = p_username;

    IF v_password IS NULL THEN
        RETURN FALSE;
    END IF;

    IF crypt(p_password, v_password) = v_password THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_registrar_usuario(p_username TEXT, p_password TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO def_usuario (username, password_hash)
    VALUES (p_username, crypt(p_password, gen_salt('bf')));
    RETURN TRUE;
EXCEPTION
    WHEN unique_violation THEN
        RETURN FALSE; -- Usuario ya existe
END;
$$ LANGUAGE plpgsql;
