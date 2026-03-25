from __future__ import annotations
from typing import Optional

from app import db
from werkzeug.security import check_password_hash, generate_password_hash

from app.config import SCHEMA_IDE
from app.models import Perfil, Rol, Institucion, Documento

class Persona(db.Model):
  __tablename__ = 'def_personas'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_tipo_documento = db.Column(db.Integer)
  numero_documento = db.Column(db.String(20))
  nombres_apellidos = db.Column(db.Text)
  celular = db.Column(db.String(20))
  fotografia = db.Column(db.String(256))
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

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
  cargo = db.Column(db.String(100), nullable=True)
  estado = db.Column(db.Boolean, default=True, server_default='True')
  cnd = db.Column(db.Boolean, default=False, nullable=False)
  idep = db.Column(db.Boolean, default=False, nullable=False)
  geoperu = db.Column(db.Boolean, default=False, nullable=False)
  pnda = db.Column(db.Boolean, default=False, nullable=False)
  cnm = db.Column(db.Boolean, default=False, nullable=False)
  fecha_baja = db.Column(db.Date, nullable=True)
  id_perfil = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_perfiles.id"),
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
  id_documento = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_documentos.id"),
      nullable=True,
      default=1,
  )
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  perfil = db.relationship(Perfil, back_populates='usuarios')
  persona = db.relationship(Persona, back_populates='usuarios')
  institucion = db.relationship(Institucion, back_populates='usuarios')
  documento = db.relationship(Documento, back_populates='usuarios')
  usuarios = db.relationship('UsuarioRol', back_populates='usuarios')

  # Helpers y propiedades de compatibilidad
  def asegurar_persona(self) -> Persona:
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
      persona = self.asegurar_persona()
      persona.nombres = (value or '').strip() or None

  @property
  def apellidos(self) -> Optional[str]:
      return self.persona.apellidos if self.persona else None

  @apellidos.setter
  def apellidos(self, value: Optional[str]) -> None:
      persona = self.asegurar_persona()
      persona.apellidos = (value or '').strip() or None

  @property
  def numero_documento(self) -> Optional[str]:
      return self.persona.numero_documento if self.persona else None

  @numero_documento.setter
  def numero_documento(self, value: Optional[str]) -> None:
      persona = self.asegurar_persona()
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
  def es_coordinador(self) -> bool:
      return self.id_perfil == 2

  @property
  def es_especialista(self) -> bool:
      return self.id_perfil == 3

  @property
  def es_gestor(self) -> bool:
      return self.id_perfil == 4

  @property
  def tiene_perfil_gestion(self) -> bool:
      return self.es_coordinador or self.es_especialista or self.es_gestor

  @property
  def tiene_roles_gestion(self) -> bool:
      return any(asignacion.roles and asignacion.roles.id_padre > 0 for asignacion in self.usuarios)

  @property
  def tiene_acceso_gestion(self) -> bool:
      return self.tiene_perfil_gestion or self.tiene_roles_gestion

  @property
  def puede_gestionar_multiples_instituciones(self) -> bool:
      return self.es_coordinador or self.es_especialista

  def __repr__(self) -> str:
      return f"<Usuario {self.id} {self.correo_electronico!r}>"

class UsuarioRol(db.Model):
  __tablename__ = 'aso_usuarios_roles'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_usuario = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.def_usuarios.id"),
      nullable=False,
  )
  id_rol = db.Column(
      db.Integer,
      db.ForeignKey(f"{SCHEMA_IDE}.dom_roles.id"),
      nullable=False,
  )
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  usuarios = db.relationship(Usuario, back_populates='usuarios')
  roles = db.relationship(Rol, back_populates='roles')

  def __repr__(self) -> str:
    return f"<UsuarioRol {self.id} Usuario ID: {self.id_usuario} Rol ID: {self.id_rol}>"

class HPersona(db.Model):
  __tablename__ = 'his_personas'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  id_tipo_documento = db.Column(db.Integer)
  numero_documento = db.Column(db.String(20))
  nombres_apellidos = db.Column(db.Text)
  celular = db.Column(db.String(20))
  fotografia = db.Column(db.String(256))
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  accion = db.Column(db.String(length=10), nullable=False)
  usuario_accion = db.Column(db.Integer(), nullable=True)
  fecha_accion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

class HUsuario(db.Model):
  __tablename__ = 'his_usuarios'
  __table_args__ = {"schema": SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  correo_electronico = db.Column(db.String(120), nullable=False)
  contrasena = db.Column(db.String(256), nullable=False)
  cargo = db.Column(db.String(100))
  estado = db.Column(db.Boolean, default=True, server_default='True')
  fecha_baja = db.Column(db.Date, nullable=True)
  id_perfil = db.Column(db.Integer, nullable=False, default=1)
  id_persona = db.Column(db.Integer, nullable=False, default=1)
  id_institucion = db.Column(db.Integer, nullable=False, default=1)
  id_documento = db.Column(db.Integer, nullable=False, default=1)
  usuario_registro = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  fecha_registro = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)

  accion = db.Column(db.String(length=10), nullable=False)
  usuario_accion = db.Column(db.Integer(), nullable=True)
  fecha_accion = db.Column(db.DateTime(timezone=True), server_default=db.func.now(), nullable=False)