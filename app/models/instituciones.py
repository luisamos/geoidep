from __future__ import annotations

from app import db
from app.config import SCHEMA_IDE

SECTOR_IDS = tuple(range(1, 10))

class Institucion(db.Model):
  __tablename__ = 'def_instituciones'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  codigo = db.Column(db.String(20), nullable=True)
  ubigeo = db.Column(db.String(20), nullable=True)
  nombre = db.Column(db.String(800), nullable=False)
  nro_ruc = db.Column(db.String(11), nullable=True)
  direccion_web = db.Column(db.String(255), nullable=True)
  sigla = db.Column(db.String(50))
  logotipo = db.Column(db.Text)
  orden = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  estado = db.Column(db.Boolean, default=True, server_default='True')
  id_padre = db.Column(db.Integer, nullable=False)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  sector = db.relationship(
    'Institucion',
    remote_side=[id],
    primaryjoin='Institucion.id == foreign(Institucion.id_padre)',
    uselist=False,
  )
  herramientas_geograficas = db.relationship('HerramientaGeografica', back_populates='institucion')
  capas = db.relationship('CapaGeografica', back_populates='institucion')
  usuarios = db.relationship('Usuario', back_populates='institucion')
  seguimientos = db.relationship('Seguimiento', back_populates='institucion')

  @property
  def es_sector(self) -> bool:
    return self.id in SECTOR_IDS

  @property
  def nombre_sector(self) -> str | None:
    if self.sector:
      return self.sector.nombre
    return None