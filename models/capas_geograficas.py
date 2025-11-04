from datetime import datetime
from sqlalchemy.sql import func

from app import db
from models import SCHEMA_IDE

class CapaGeografica(db.Model):
  __tablename__ = 'def_capas_geograficas'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(200), nullable=False)
  descripcion = db.Column(db.String(500))
  tipo_capa = db.Column(db.Integer, nullable=False)
  publicar_geoperu = db.Column(db.Boolean, default=False)
  id_categoria = db.Column(
      'id_categoria',
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_categorias.id"),
      nullable=False,
  )
  id_institucion = db.Column(
      'id_institucion',
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_instituciones.id"),
      nullable=False,
  )
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime, server_default=db.func.current_timestamp(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime, nullable=True, default=datetime.utcnow, onupdate=datetime.utcnow)

  categoria = db.relationship('Categoria', back_populates='capas')
  institucion = db.relationship('Institucion', back_populates='capas')
  servicios = db.relationship('ServicioGeografico', back_populates='capa', cascade='all, delete-orphan')


class ServicioGeografico(db.Model):
  __tablename__ = 'def_servicios_geograficos'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_capa = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_capas_geograficas.id"),
      nullable=False,
  )
  id_tipo_servicio = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_tipos_servicios.id"),
      nullable=False,
  )
  direccion_web = db.Column(db.Text, nullable=False)
  nombre_capa = db.Column(db.String(200))
  titulo_capa = db.Column(db.String(500))
  estado = db.Column(db.Boolean, default=True)
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime(timezone=True), onupdate=db.func.now())

  capa = db.relationship('CapaGeografica', back_populates='servicios')
  tipo_servicio = db.relationship('TipoServicio', back_populates='servicios_geograficos')