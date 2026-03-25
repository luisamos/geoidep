from app import db
from app.config import SCHEMA_IDE
from app.models import Tipo, Categoria, Institucion

class HerramientaGeografica(db.Model):
  __tablename__ = 'def_herramientas_geograficas'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  nombre = db.Column(db.String(200), nullable=False)
  descripcion = db.Column(db.Text)
  estado = db.Column(db.Boolean, default=True)
  recurso = db.Column(db.Text)
  id_tipo = db.Column(
      'id_tipo',
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_tipos.id"),
      nullable=False,
  )
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

  tipo = db.relationship(Tipo, back_populates='herramientas_geograficas')
  categoria = db.relationship(Categoria, back_populates='herramientas_geograficas')
  institucion = db.relationship(Institucion, back_populates='herramientas_geograficas')


  @property
  def esta_activa(self) -> bool:
    return self.estado == True

  @property
  def esta_inactiva(self) -> bool:
    return self.estado == False

  @property
  def estado_icono(self) -> str:
    if self.esta_activa:
      return '🟢'
    if self.esta_inactiva:
      return '🔴'

class HHerramientaGeografica(db.Model):
  __tablename__ = 'his_herramientas_geograficas'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True, autoincrement=True)
  id_herramienta_geografica = db.Column(db.Integer, nullable=False)
  nombre = db.Column(db.String(200), nullable=False)
  descripcion = db.Column(db.Text)
  estado = db.Column(db.Boolean, default=True)
  recurso = db.Column(db.Text)
  id_tipo = db.Column(db.Integer, nullable=False)
  id_categoria = db.Column(db.Integer, nullable=False)
  id_institucion = db.Column(db.Integer, nullable=False)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  accion = db.Column(db.String(length=10), nullable=False)
  usuario_accion = db.Column(db.Integer(), nullable=True)
  fecha_accion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

