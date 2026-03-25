from app import db
from app.config import SCHEMA_IDE
from app.models import Documento, Institucion, Actividad

class Seguimiento(db.Model):
  __tablename__ = 'def_seguimientos'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_documento = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_documentos.id"),
      nullable=False,
  )
  id_institucion = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_instituciones.id"),
      nullable=False,
  )
  id_actividad = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_actividades.id"),
      nullable=False,
  )
  observacion = db.Column(db.Text, nullable=True)
  estado = db.Column(db.Boolean, default=True, nullable=False)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  documento = db.relationship(Documento, back_populates='seguimientos')
  institucion = db.relationship(Institucion, back_populates='seguimientos')
  actividad = db.relationship(Actividad, back_populates='seguimientos')