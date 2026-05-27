from app import db
from app.config import SCHEMA_IDE

class Tipo(db.Model):
  __tablename__ = 'dom_tipos'
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
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  herramientas_geograficas = db.relationship('HerramientaGeografica', back_populates='tipo')
  servicios_geograficos = db.relationship('ServicioGeografico', back_populates='tipo')
