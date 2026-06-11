from app import db
from app.config import SCHEMA_IDE


class EstadoMonitoreo(db.Model):
  __tablename__ = 'estado_monitoreo'
  __table_args__ = (
    db.CheckConstraint('id = 1', name='estado_monitoreo_id_check'),
    {'schema': SCHEMA_IDE},
  )

  id = db.Column(db.Integer, primary_key=True, server_default='1')
  estado = db.Column(db.String(20), nullable=False, default='idle', server_default='idle')
  tipo = db.Column(db.String(40), nullable=True)
  iniciado_por = db.Column(db.String(255), nullable=True)
  inicio = db.Column(db.DateTime(timezone=True), nullable=True)
  fin = db.Column(db.DateTime(timezone=True), nullable=True)
  actualizado_en = db.Column(db.DateTime(timezone=True), nullable=True)
  total = db.Column(db.Integer, nullable=False, default=0, server_default='0')
  verificados = db.Column(db.Integer, nullable=False, default=0, server_default='0')
  resultado = db.Column(db.Text, nullable=True)
  error = db.Column(db.Text, nullable=True)
