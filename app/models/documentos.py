from app import db
from app.config import SCHEMA_IDE

class Documento(db.Model):
  __tablename__ = 'def_documentos'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  n_documento = db.Column(db.String(1000), nullable=False, unique=True)
  f_documento = db.Column(db.Date, nullable=True)
  cod_expediente = db.Column(db.String(100), nullable=True)
  f_recepcion = db.Column(db.Date, nullable=True)
  url_documento = db.Column(db.String(1000), nullable=True)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  actividades = db.relationship('Actividad', back_populates='documento')
  usuarios = db.relationship('Usuario', back_populates='documento')