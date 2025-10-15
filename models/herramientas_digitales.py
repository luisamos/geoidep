from app import db
from models import SCHEMA_IDE


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
  estado = db.Column(db.Integer)
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
  id_usuario = db.Column(db.Integer, nullable=False)
  fecha_crea = db.Column(db.Date)

  tipo_servicio = db.relationship('TipoServicio', back_populates='herramientas')
  institucion = db.relationship('Institucion', back_populates='herramientas')
  categoria = db.relationship('Categoria', back_populates='herramientas')

  @property
  def esta_activa(self) -> bool:
    return self.estado == 1

  @property
  def esta_inactiva(self) -> bool:
    return self.estado == 0

  @property
  def estado_icono(self) -> str:
    if self.esta_activa:
      return '🟢'
    if self.esta_inactiva:
      return '🔴'