from app import db
from models import SCHEMA_IDE

class TipoServicio(db.Model):
  __tablename__ = 'def_tipos_servicios'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(100), unique=True, nullable=False)
  descripcion = db.Column(db.Text, nullable=True)
  estado = db.Column(db.Boolean)
  logotipo = db.Column(db.String(500), nullable=True)
  orden = db.Column(db.Integer, nullable=False)
  id_padre = db.Column(db.Integer, nullable=False)
  id_usuario = db.Column(db.Integer, nullable=False)
  fecha_crea = db.Column(db.Date)

  servicios_geograficos = db.relationship('ServicioGeografico', back_populates='tipo_servicio', cascade='all, delete-orphan')
  herramientas = db.relationship('HerramientaDigital', back_populates='tipo_servicio', cascade='all, delete-orphan')
