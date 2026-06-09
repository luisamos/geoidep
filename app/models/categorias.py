from app import db
from app.config import SCHEMA_IDE

class Categoria(db.Model):
  __tablename__ = 'dom_categorias'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  codigo = db.Column(db.String(5), unique=True, nullable=False)
  nombre = db.Column(db.String(500), nullable=False)
  sigla = db.Column(db.String(500), nullable=False)
  definicion = db.Column(db.Text)
  id_padre = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  herramientas_geograficas = db.relationship('HerramientaGeografica', back_populates='categoria')
  capas = db.relationship('CapaGeografica', back_populates='categoria')