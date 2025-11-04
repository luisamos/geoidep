from datetime import datetime
from sqlalchemy.sql import func

from app import db
from models import SCHEMA_IDE

class Categoria(db.Model):
  __tablename__ = 'def_categorias'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  codigo = db.Column(db.String(5), unique=True, nullable=False)
  nombre = db.Column(db.String(500), nullable=False)
  sigla = db.Column(db.String(500), nullable=False)
  definicion = db.Column(db.Text)
  id_padre = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime(timezone=True), onupdate=db.func.now())

  capas = db.relationship('CapaGeografica', back_populates='categoria')
  herramientas = db.relationship('HerramientaDigital', back_populates='categoria')
