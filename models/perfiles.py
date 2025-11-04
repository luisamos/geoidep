from __future__ import annotations

from datetime import datetime

from app import db
from models import SCHEMA_IDE

class Perfil(db.Model):
  __tablename__ = 'def_perfiles'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(120), nullable=False, unique=True)
  estado = db.Column(db.Boolean, nullable=False, default=True)
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime(timezone=True), onupdate=db.func.now())

  usuarios = db.relationship('Usuario', back_populates='perfil')

  def __repr__(self) -> str:
    return f"<Perfil {self.id} {self.nombre!r}>"