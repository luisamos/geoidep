from __future__ import annotations

import secrets
from datetime import datetime, timedelta
from sqlalchemy.sql import func

from app import db
from werkzeug.security import generate_password_hash, check_password_hash

from models import SCHEMA_IDE
from models.instituciones import Institucion
from models.perfiles import Perfil

class Persona(db.Model):
  __tablename__ = 'def_personas'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_tipo_documento = db.Column(db.Integer)
  numero_documento = db.Column(db.String(11))
  nombres_apellidos = db.Column(db.String(256))
  correo_electronico = db.Column(db.String(120), unique=True, nullable=False)
  celular = db.Column(db.String(20))
  fotografia = db.Column(db.String(256))
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.Date, server_default=db.func.current_date(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.Date, nullable=True, default=datetime.utcnow, onupdate=datetime.utcnow)

  @property
  def nombre_completo(self) -> str:
    partes = [self.nombres or '', self.apellidos or '']
    return ' '.join(p for p in partes if p).strip() or self.correo_electronico

class Usuario(db.Model):
  __tablename__ = 'def_usuarios'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  password_hash = db.Column(db.String(256), nullable=False)
  confirmed = db.Column(db.Boolean, default=False, nullable=False)
  confirmation_token = db.Column(db.String(255), unique=True)
  reset_token = db.Column(db.String(255), unique=True)
  reset_token_expiration = db.Column(db.DateTime)
  geoidep = db.Column(db.Boolean, default=False, nullable=False)
  geoperu = db.Column(db.Boolean, default=False, nullable=False)
  metadatos = db.Column(db.Boolean, default=False, nullable=False)
  id_perfil = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_perfiles.id"),
      nullable=False,
      default=1,
  )
  id_persona = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_personas.id"),
      nullable=False,
      default=1,
  )
  id_institucion = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_instituciones.id"),
      nullable=False,
      default=1,
  )
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.Date, server_default=db.func.current_date(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.Date, nullable=True, default=datetime.utcnow, onupdate=datetime.utcnow)

  persona = db.relationship(Persona, back_populates='usuarios')
  institucion = db.relationship(Institucion, back_populates='usuarios')
  perfil = db.relationship(Perfil, back_populates='usuarios')

  def set_password(self, raw: str) -> None:
    self.password_hash = generate_password_hash(raw)

  def check_password(self, raw: str) -> bool:
    return check_password_hash(self.password_hash, raw)

  def generar_token_confirmacion(self) -> str:
    self.confirmation_token = secrets.token_urlsafe(32)
    return self.confirmation_token

  def generar_token_recuperacion(self, duracion_horas: int = 2) -> str:
    self.reset_token = secrets.token_urlsafe(32)
    self.reset_token_expiration = datetime.utcnow() + timedelta(hours=duracion_horas)
    return self.reset_token

  def token_recuperacion_valido(self, token: str) -> bool:
    if not token or not self.reset_token or token != self.reset_token:
        return False
    if not self.reset_token_expiration:
        return False
    return datetime.utcnow() <= self.reset_token_expiration

  def limpiar_token_recuperacion(self) -> None:
    self.reset_token = None
    self.reset_token_expiration = None