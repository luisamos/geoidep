--
-- USUARIOS
--
DROP TABLE IF EXISTS ide.def_usuarios CASCADE;
CREATE TABLE ide.def_usuarios
(
    id SERIAL PRIMARY KEY,
    id_tipo_documento INTEGER,
    numero_documento VARCHAR(20),
    apellidos VARCHAR(256),
    nombres VARCHAR(256),
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(256) NOT NULL,
    fotografia VARCHAR(256),
    id_tipo INTEGER,
    id_institucion INTEGER NOT NULL,
    norma_designacion TEXT,
    fecha DATE,
    estado BOOLEAN NOT NULL DEFAULT TRUE,
    geoidep BOOLEAN NOT NULL DEFAULT FALSE,
    geoperu BOOLEAN NOT NULL DEFAULT FALSE,
    confirmed BOOLEAN NOT NULL DEFAULT FALSE,
    confirmation_token VARCHAR(255),
    reset_token VARCHAR(255),
    reset_token_expiration TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT def_institucion_usuario_fkey FOREIGN KEY (id_institucion)
        REFERENCES ide.def_instituciones (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

SELECT * FROM ide.def_usuarios;

SELECT * FROM ide.def_rol;

UPDATE ide.def_usuarios SET confirmed=True;

UPDATE ide.def_usuarios SET id_perfil=1 WHERE id= 1;


