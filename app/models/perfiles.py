from __future__ import annotations

from app import db
from app.config import SCHEMA_IDE

class Perfil(db.Model):
  __tablename__ = 'dom_perfiles'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(120), nullable=False, unique=True)
  estado = db.Column(db.Boolean, default=True, nullable=False)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  usuarios = db.relationship('Usuario', back_populates='perfil')

  def __repr__(self) -> str:
    return f"<Perfil {self.id} {self.nombre!r}>"