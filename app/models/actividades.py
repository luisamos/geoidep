from app import db
from app.config import SCHEMA_IDE
from app.models import Documento, Institucion, TipoActividad
from sqlalchemy import UniqueConstraint

class Actividad(db.Model):
  __tablename__ = 'def_actividades'
  __table_args__ = (
      UniqueConstraint(
          'id_documento',
          'id_tipo_actividad',
          'estado',
          name='uq_documento_tipo_actividad_estado',
      ),
      {'schema': SCHEMA_IDE},
  )

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
  id_tipo_actividad = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_tipos_actividades.id"),
      nullable=False,
  )
  f_atencion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  estado = db.Column(db.Integer, nullable=False)
  description = db.Column(db.Text, nullable=True)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  documento = db.relationship(Documento, back_populates='actividades')
  institucion = db.relationship(Institucion, back_populates='actividades')
  tipo_actividad = db.relationship(TipoActividad, back_populates='actividades')

class HActividad(db.Model):
  __tablename__ = 'his_actividades'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_documento = db.Column(db.Integer, nullable=False)
  id_institucion = db.Column(db.Integer, nullable=False)
  id_tipo_actividad = db.Column(db.Integer, nullable=False)
  f_atencion = db.Column(db.DateTime(timezone=True), nullable=False)
  estado = db.Column(db.Integer, nullable=False)
  description = db.Column(db.Text, nullable=True)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  accion = db.Column(db.String(length=10), nullable=False)
  usuario_accion = db.Column(db.Integer(), nullable=True)
  fecha_accion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)