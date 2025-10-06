from __future__ import annotations

import secrets
from datetime import datetime, timedelta

from app import db
from werkzeug.security import generate_password_hash, check_password_hash
from models import SCHEMA_IDE
from models.niveles_gobierno import Institucion


class Usuario(db.Model):
    __tablename__ = 'def_usuarios'
    __table_args__ = {"schema": "ide"}

    id = db.Column(db.Integer, primary_key=True)
    id_tipo_documento = db.Column(db.Integer)
    numero_documento = db.Column(db.String(20))
    apellidos = db.Column(db.String(256))
    nombres = db.Column(db.String(256))
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)
    fotografia = db.Column(db.String(256))
    id_tipo = db.Column(db.Integer)
    id_institucion = db.Column(
        db.Integer,
        db.ForeignKey(f"{SCHEMA_IDE}.def_instituciones.id"),
        nullable=False,
        default=1,
    )
    norma_designacion = db.Column(db.Text)
    fecha = db.Column(db.Date)
    estado = db.Column(db.Boolean, default=True, nullable=False)
    geoidep = db.Column(db.Boolean, default=False, nullable=False)
    geoperu = db.Column(db.Boolean, default=False, nullable=False)
    confirmed = db.Column(db.Boolean, default=False, nullable=False)
    confirmation_token = db.Column(db.String(255), unique=True)
    reset_token = db.Column(db.String(255), unique=True)
    reset_token_expiration = db.Column(db.DateTime)

    institucion = db.relationship(Institucion, back_populates='usuarios')

    @property
    def nombre_completo(self) -> str:
        partes = [self.nombres or '', self.apellidos or '']
        return ' '.join(p for p in partes if p).strip() or self.email

    def set_password(self, raw: str) -> None:
        self.password_hash = generate_password_hash(raw)

    def check_password(self, raw: str) -> bool:
        return check_password_hash(self.password_hash, raw)

    def generar_token_confirmacion(self) -> str:
        self.confirmation_token = secrets.token_urlsafe(32)
        return self.confirmation_token

    def generar_token_recuperacion(self, duracion_horas: int = 2) -> str:
        self.reset_token = secrets.token_urlsafe(32)
        self.reset_token_expiration = datetime.utcnow() + timedelta(hours=duracion_horas)
        return self.reset_token

    def token_recuperacion_valido(self, token: str) -> bool:
        if not token or not self.reset_token or token != self.reset_token:
            return False
        if not self.reset_token_expiration:
            return False
        return datetime.utcnow() <= self.reset_token_expiration

    def limpiar_token_recuperacion(self) -> None:
        self.reset_token = None
        self.reset_token_expiration = None