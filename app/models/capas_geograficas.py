from app import db
from app.config import SCHEMA_IDE
from app.models import Categoria, Institucion, Tipo
from sqlalchemy.orm import synonym

class CapaGeografica(db.Model):
  __tablename__ = 'def_capas_geograficas'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(200), nullable=False)
  descripcion = db.Column(db.String(2500))
  fecha_inicio = db.Column(db.Date, nullable=True)
  fecha_fin = db.Column(db.Date, nullable=True)
  proyeccion= db.Column(db.Integer, nullable=True)
  tipo_capa = db.Column(db.Integer, nullable=False)
  id_metadato = db.Column(db.String(200), nullable=True)

  id_categoria = db.Column(
      'id_categoria',
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_categorias.id"),
      nullable=False,
  )
  id_institucion = db.Column(
      'id_institucion',
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_instituciones.id"),
      nullable=False,
  )
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  categoria = db.relationship(Categoria, back_populates='capas')
  institucion = db.relationship(Institucion, back_populates='capas')
  servicios = db.relationship('ServicioGeografico', back_populates='capa_geografica')
  servicios_geograficos = synonym('servicios')

class ServicioGeografico(db.Model):
  __tablename__ = 'def_servicios_geograficos'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_capa_geografica = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_capas_geograficas.id"),
      nullable=False,
  )
  id_tipo = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_tipos.id"),
      nullable=False,
  )
  direccion_web = db.Column(db.Text, nullable=False)
  nombre_capa = db.Column(db.String(200))
  titulo_capa = db.Column(db.String(500))
  estado = db.Column(db.Boolean, default=True)
  id_layer = db.Column(db.Integer, nullable=False, default=0, server_default='0')
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  capa_geografica = db.relationship(CapaGeografica, back_populates='servicios')
  tipo = db.relationship(Tipo, back_populates='servicios_geograficos')

class HCapaGeografica(db.Model):
  __tablename__ = 'his_capas_geograficas'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_capa_geografica = db.Column(db.Integer, nullable=False)
  nombre = db.Column(db.String(200), nullable=False)
  descripcion = db.Column(db.String(2500))
  fecha_inicio = db.Column(db.Date, nullable=True)
  fecha_fin = db.Column(db.Date, nullable=True)
  proyeccion= db.Column(db.Integer, nullable=True)
  tipo_capa = db.Column(db.Integer, nullable=False)
  id_metadato = db.Column(db.String(200), nullable=True)
  id_categoria = db.Column(db.Integer, nullable=False)
  id_institucion = db.Column(db.Integer, nullable=False)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  accion = db.Column(db.String(length=10), nullable=False)
  usuario_accion = db.Column(db.Integer(), nullable=True)
  fecha_accion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)


class HServicioGeografico(db.Model):
  __tablename__ = 'his_servicios_geograficos'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_servicio_geografico = db.Column(db.Integer, nullable=False)
  id_capa_geografica = db.Column(db.Integer, nullable=False)
  id_tipo = db.Column(db.Integer, nullable=False)
  direccion_web = db.Column(db.Text, nullable=False)
  nombre_capa = db.Column(db.String(200))
  titulo_capa = db.Column(db.String(500))
  estado = db.Column(db.Boolean, default=True)
  id_layer = db.Column(db.Integer, nullable=False, default=0, server_default='0')
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  accion = db.Column(db.String(length=10), nullable=False)
  usuario_accion = db.Column(db.Integer(), nullable=True)
  fecha_accion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
