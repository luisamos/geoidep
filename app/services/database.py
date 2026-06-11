"""Utilidades compartidas para operaciones de base de datos."""
from __future__ import annotations

from sqlalchemy import func, select

from app.extensions import db


def sincronizar_secuencia(modelo) -> None:
  """Resetea la secuencia PostgreSQL del PK al valor MAX(pk)+1.

  Útil después de inserciones masivas con IDs explícitos para evitar
  conflictos de claves duplicadas en futuras inserciones automáticas.
  """
  tabla = modelo.__table__
  pk_columna = next(iter(tabla.primary_key.columns))
  atributo_pk = getattr(modelo, pk_columna.name)
  max_id = db.session.query(func.coalesce(func.max(atributo_pk), 0)).scalar()
  nombre_secuencia = f"{tabla.name}_{pk_columna.name}_seq"
  if tabla.schema:
    nombre_secuencia = f"{tabla.schema}.{nombre_secuencia}"
  valor = max_id if max_id else 1
  db.session.execute(
    select(func.setval(func.to_regclass(nombre_secuencia), valor, bool(max_id)))
  )
