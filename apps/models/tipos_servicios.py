from apps import db
from apps.config import SCHEMA_IDE

class TipoServicio(db.Model):
  __tablename__ = 'def_tipos_servicios'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  tag = db.Column(db.String(40), nullable=True)
  sigla = db.Column(db.String(30), nullable=True)
  nombre = db.Column(db.String(100), unique=True, nullable=False)
  descripcion = db.Column(db.Text, nullable=True)
  estado = db.Column(db.Boolean, default=True, server_default='True')
  logotipo = db.Column(db.Text, nullable=True)
  orden = db.Column(db.Integer, nullable=False)
  id_padre = db.Column(db.Integer, nullable=False)
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime(timezone=True), onupdate=db.func.now())

  servicios_geograficos = db.relationship('ServicioGeografico', back_populates='tipo_servicio', cascade='all, delete-orphan')
  herramientas = db.relationship('HerramientaDigital', back_populates='tipo_servicio', cascade='all, delete-orphan')
