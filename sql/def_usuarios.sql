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

CREATE INDEX IF NOT EXISTS idx_def_usuarios_email ON ide.def_usuarios (LOWER(email));
CREATE INDEX IF NOT EXISTS idx_def_usuarios_reset_token ON ide.def_usuarios (reset_token);

CREATE OR REPLACE FUNCTION ide.trg_def_usuarios_set_updated_at()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_def_usuarios_set_updated_at ON ide.def_usuarios;
CREATE TRIGGER trg_def_usuarios_set_updated_at
BEFORE UPDATE ON ide.def_usuarios
FOR EACH ROW
EXECUTE FUNCTION ide.trg_def_usuarios_set_updated_at();

SELECT * FROM ide.def_usuarios;

UPDATE ide.def_usuarios SET confirmed=True;