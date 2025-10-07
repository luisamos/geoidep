from __future__ import annotations

from app import db
from models import SCHEMA_IDE

class Perfil(db.Model):
  __tablename__ = 'def_rol'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(120), nullable=False, unique=True)
  estado = db.Column(db.Boolean, nullable=False, default=True)

  usuarios = db.relationship('Usuario', back_populates='perfil')

  def __repr__(self) -> str:
    return f"<Perfil {self.id} {self.nombre!r}>"