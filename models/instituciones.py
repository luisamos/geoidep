from __future__ import annotations

from datetime import datetime

from app import db
from models import SCHEMA_IDE


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
  id_padre = db.Column(db.Integer, nullable=False)
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime, server_default=db.func.current_timestamp(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(
    db.DateTime,
    nullable=True,
    default=datetime.utcnow,
    onupdate=datetime.utcnow,
  )

  capas = db.relationship('CapaGeografica', back_populates='institucion')
  herramientas = db.relationship('HerramientaDigital', back_populates='institucion')
  usuarios = db.relationship('Usuario', back_populates='institucion')

  sector = db.relationship(
    'Institucion',
    remote_side=[id],
    primaryjoin='Institucion.id == foreign(Institucion.id_padre)',
    uselist=False,
  )

  @property
  def es_sector(self) -> bool:
    return self.id in SECTOR_IDS

  @property
  def nombre_sector(self) -> str | None:
    if self.sector:
      return self.sector.nombre
    return None