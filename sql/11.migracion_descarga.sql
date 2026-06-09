-- Migración: refactor capas geográficas
-- 1) Retirar columna id_metadato de def_capas_geograficas e his_capas_geograficas
-- 2) Añadir columna `descarga` (booleano) y `url_doc_descarga` (texto opcional)
--    al servicio geográfico, manteniendo el histórico alineado.

BEGIN;

-- def_capas_geograficas: eliminar id_metadato
ALTER TABLE ide.def_capas_geograficas
  DROP COLUMN IF EXISTS id_metadato;

-- his_capas_geograficas: eliminar id_metadato
ALTER TABLE ide.his_capas_geograficas
  DROP COLUMN IF EXISTS id_metadato;

-- def_servicios_geograficos: añadir descarga + url_doc_descarga
ALTER TABLE ide.def_servicios_geograficos
  ADD COLUMN IF NOT EXISTS descarga boolean NOT NULL DEFAULT false;
ALTER TABLE ide.def_servicios_geograficos
  ADD COLUMN IF NOT EXISTS url_doc_descarga text;

-- his_servicios_geograficos: replicar descarga + url_doc_descarga
ALTER TABLE ide.his_servicios_geograficos
  ADD COLUMN IF NOT EXISTS descarga boolean NOT NULL DEFAULT false;
ALTER TABLE ide.his_servicios_geograficos
  ADD COLUMN IF NOT EXISTS url_doc_descarga text;

-- Pre-marcar los servicios alojados en el servidor de mapas oficial.
-- Es seguro re-ejecutarlo: el `WHERE` filtra por host actual.
UPDATE ide.def_servicios_geograficos
SET descarga = true
WHERE direccion_web ILIKE '%espacialg.geoperu.gob.pe%'
  AND descarga = false;

COMMIT;
