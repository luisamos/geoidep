from __future__ import annotations

from app import db
from app.config import SCHEMA_IDE

class Rol(db.Model):
  __tablename__ = 'dom_roles'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(120), nullable=False)
  logotipo = db.Column(db.String(15), nullable=True)
  enlace = db.Column(db.String(50), nullable=True)
  orden = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  id_padre = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  roles = db.relationship('UsuarioRol', back_populates='roles')

  def __repr__(self) -> str:
    return f"<Roles {self.id} {self.nombre!r}>"