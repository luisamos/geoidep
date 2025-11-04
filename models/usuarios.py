from __future__ import annotations

from datetime import datetime
from typing import Optional

from app import db
from werkzeug.security import check_password_hash, generate_password_hash

from models import SCHEMA_IDE
from models.instituciones import Institucion
from models.perfiles import Perfil


class Persona(db.Model):
  __tablename__ = 'def_personas'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_tipo_documento = db.Column(db.Integer)
  numero_documento = db.Column(db.String(20))
  nombres_apellidos = db.Column(db.Text)
  celular = db.Column(db.String(20))
  fotografia = db.Column(db.String(256))
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime, server_default=db.func.current_timestamp(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime, nullable=True, default=datetime.utcnow, onupdate=datetime.utcnow)

  usuarios = db.relationship('Usuario', back_populates='persona')

  @property
  def nombre_completo(self) -> str:
      return self.nombres_apellidos


class Usuario(db.Model):
  __tablename__ = 'def_usuarios'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  correo_electronico = db.Column(db.String(120), unique=True, nullable=False)
  contrasena = db.Column(db.String(256), nullable=False)
  estado = db.Column(db.Boolean, default=True, nullable=False)
  fecha_baja = db.Column(db.Date, nullable=True)
  geoidep = db.Column(db.Boolean, default=False, nullable=False)
  geoperu = db.Column(db.Boolean, default=False, nullable=False)
  metadatos = db.Column(db.Boolean, default=False, nullable=False)
  id_perfil = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_perfiles.id"),
      nullable=False,
      default=1,
  )
  id_persona = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_personas.id"),
      nullable=False,
      default=1,
  )
  id_institucion = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_instituciones.id"),
      nullable=False,
      default=1,
  )
  usuario_crea = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_crea = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)
  usuario_modifica = db.Column(db.Integer, nullable=True)
  fecha_modifica = db.Column(db.DateTime(timezone=True), onupdate=db.func.now())

  persona = db.relationship(Persona, back_populates='usuarios')
  institucion = db.relationship(Institucion, back_populates='usuarios')
  perfil = db.relationship(Perfil, back_populates='usuarios')

  # Helpers y propiedades de compatibilidad
  def _asegurar_persona(self) -> Persona:
      if not self.persona:
          self.persona = Persona()
      return self.persona

  @property
  def email(self) -> str:
      return self.correo_electronico

  @email.setter
  def email(self, value: Optional[str]) -> None:
      self.correo_electronico = (value or '').strip().lower()

  @property
  def nombre_completo(self) -> str:
      if self.persona:
          return self.persona.nombre_completo
      return self.correo_electronico

  @property
  def nombres(self) -> Optional[str]:
      return self.persona.nombres if self.persona else None

  @nombres.setter
  def nombres(self, value: Optional[str]) -> None:
      persona = self._asegurar_persona()
      persona.nombres = (value or '').strip() or None

  @property
  def apellidos(self) -> Optional[str]:
      return self.persona.apellidos if self.persona else None

  @apellidos.setter
  def apellidos(self, value: Optional[str]) -> None:
      persona = self._asegurar_persona()
      persona.apellidos = (value or '').strip() or None

  @property
  def numero_documento(self) -> Optional[str]:
      return self.persona.numero_documento if self.persona else None

  @numero_documento.setter
  def numero_documento(self, value: Optional[str]) -> None:
      persona = self._asegurar_persona()
      persona.numero_documento = (value or '').strip() or None

  # Gestión de contraseñas
  def set_password(self, raw: str) -> None:
      self.contrasena = generate_password_hash(raw)

  def check_password(self, raw: str) -> bool:
      if not self.contrasena:
          return False
      return check_password_hash(self.contrasena, raw)

  # Propiedades de perfiles y accesos
  @property
  def nombre_perfil(self) -> str:
      return self.perfil.nombre if self.perfil else ''

  @property
  def es_administrador(self) -> bool:
      return self.id_perfil == 1

  @property
  def es_especialista(self) -> bool:
      return self.id_perfil == 2

  @property
  def es_gestor(self) -> bool:
      return self.id_perfil == 3

  @property
  def puede_gestionar_multiples_instituciones(self) -> bool:
      return self.es_administrador or self.es_especialista

  @property
  def menus_permitidos(self) -> set[str]:
      if self.es_administrador:
          return {f"menu{indice:02d}" for indice in range(1, 11)}
      if self.es_especialista:
          return {f"menu{indice:02d}" for indice in (1, 2, 3, 4, 5, 6, 7, 10)}
      if self.es_gestor:
          return {f"menu{indice:02d}" for indice in (1, 2, 3, 10)}
      return set()

  def __repr__(self) -> str:
      return f"<Usuario {self.id} {self.correo_electronico!r}>"