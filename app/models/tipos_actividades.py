from app import db
from app.config import SCHEMA_IDE

class TipoActividad(db.Model):
  __tablename__ = 'dom_tipos_actividades'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.Text, nullable=True)
  estado = db.Column(db.Boolean, default=True, nullable=False)
  orden = db.Column(db.Integer, nullable=False)
  id_perfil = db.Column(db.Integer, nullable=False)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  actividades = db.relationship('Actividad', back_populates='tipoActividad')
