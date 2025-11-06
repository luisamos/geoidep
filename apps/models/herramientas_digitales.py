from apps import db
from apps.config import SCHEMA_IDE

class HerramientaDigital(db.Model):
  __tablename__ = 'def_herramientas_digitales'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_tipo_servicio = db.Column(
      'id_tipo_servicio',
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_tipos_servicios.id"),
      nullable=False,
  )
  nombre = db.Column(db.String(200), nullable=False)
  descripcion = db.Column(db.Text)
  estado = db.Column(db.Boolean, default=True)
  recurso = db.Column(db.Text)
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
  fecha_crea = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime(timezone=True), onupdate=db.func.now())

  tipo_servicio = db.relationship('TipoServicio', back_populates='herramientas')
  institucion = db.relationship('Institucion', back_populates='herramientas')
  categoria = db.relationship('Categoria', back_populates='herramientas')

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