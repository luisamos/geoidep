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
  id_padre = db.Column(db.Integer)
  id_usuario = db.Column(db.Integer, nullable=False)
  fecha_crea = db.Column(db.Date)

  capas = db.relationship('CapaGeografica', back_populates='categoria')
  herramientas = db.relationship('HerramientaDigital', back_populates='categoria')
