"""Consultas compartidas sobre el catálogo de instituciones."""
from __future__ import annotations

from app.models.instituciones import Institucion
from app.routes.helpers import usuario_restringido_a_su_entidad

EXCLUDED_PARENT_IDS = tuple(range(10))


def obtener_instituciones_para(
  usuario,
  *,
  excluir_sectores: bool = False,
  excluir_padres: bool = True,
  orden_por_sigla: bool = False,
) -> list[Institucion]:
  """Lista instituciones visibles para `usuario`.

  - `excluir_sectores=True`: filtra `id >= 45` (descarta sectores/padres
    que se almacenan en el mismo catálogo).
  - `excluir_padres=True`: filtra `id_padre NOT IN [0..9]` (omite nodos
    raíz del árbol institucional).
  - `orden_por_sigla=True`: ordena por sigla y nombre; por defecto se
    ordena por id ascendente.

  Si `usuario` está restringido a su entidad, devuelve únicamente esa
  institución. Si `usuario` es `None`, devuelve una lista vacía.
  """
  if not usuario:
    return []

  consulta = Institucion.query
  if excluir_sectores:
    consulta = consulta.filter(Institucion.id >= 45)

  if usuario_restringido_a_su_entidad(usuario):
    consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  elif excluir_padres:
    consulta = consulta.filter(~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS))

  if orden_por_sigla:
    return consulta.order_by(
      Institucion.sigla.asc(), Institucion.nombre.asc()
    ).all()
  return consulta.order_by(Institucion.id.asc()).all()
