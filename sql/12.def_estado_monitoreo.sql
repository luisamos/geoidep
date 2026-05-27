-- Estado global del proceso de monitoreo (una sola fila, id = 1).
--
-- Comparte el estado "en ejecución" y el progreso entre todos los workers de
-- gunicorn. Sin esta tabla, el estado vivía en memoria por-proceso y cada
-- worker reportaba un valor distinto al hacer polling a /principal/estado,
-- provocando que la UI parpadeara entre "Ejecutar monitoreo" y la ejecución.
--
-- La aplicación crea esta tabla de forma idempotente al arrancar; este script
-- documenta el esquema y permite crearla manualmente si se prefiere.

CREATE TABLE IF NOT EXISTS ide.estado_monitoreo (
    id              integer PRIMARY KEY DEFAULT 1 CHECK (id = 1),
    estado          character varying(20) NOT NULL DEFAULT 'idle',
    tipo            character varying(40),
    iniciado_por    character varying(255),
    inicio          timestamp with time zone,
    fin             timestamp with time zone,
    actualizado_en  timestamp with time zone,
    total           integer NOT NULL DEFAULT 0,
    verificados     integer NOT NULL DEFAULT 0,
    resultado       text,
    error           text
);

ALTER TABLE ide.estado_monitoreo OWNER TO usrgeoperuprd;

INSERT INTO ide.estado_monitoreo (id, estado) VALUES (1, 'idle')
ON CONFLICT (id) DO NOTHING;
