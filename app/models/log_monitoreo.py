from app import db
from app.config import SCHEMA_IDE

class LogMonitoreo(db.Model):
  __tablename__ = 'log_monitoreo'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  tipo_recurso = db.Column(db.String(50), nullable=False)
  id_recurso = db.Column(db.Integer, nullable=False)
  nombre_recurso = db.Column(db.String(500), nullable=True)
  url_verificada = db.Column(db.Text, nullable=True)
  estado_anterior = db.Column(db.Boolean, nullable=True)
  estado_nuevo = db.Column(db.Boolean, nullable=False)
  codigo_http = db.Column(db.Integer, nullable=True)
  mensaje_error = db.Column(db.Text, nullable=True)
  fecha_verificacion = db.Column(
      db.DateTime(timezone=True),
      server_default=db.func.now(),
      nullable=False,
  )

class HLogMonitoreo(db.Model):
  __tablename__ = 'his_log_monitoreo'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  tipo_recurso = db.Column(db.String(50), nullable=False)
  id_recurso = db.Column(db.Integer, nullable=False)
  nombre_recurso = db.Column(db.String(500), nullable=True)
  url_verificada = db.Column(db.Text, nullable=True)
  estado_anterior = db.Column(db.Boolean, nullable=True)
  estado_nuevo = db.Column(db.Boolean, nullable=False)
  codigo_http = db.Column(db.Integer, nullable=True)
  mensaje_error = db.Column(db.Text, nullable=True)
  fecha_verificacion = db.Column(
      db.DateTime(timezone=True),
      server_default=db.func.now(),
      nullable=False,
  )
