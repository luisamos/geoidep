from app import db
from werkzeug.security import generate_password_hash, check_password_hash

from models.niveles_gobierno import Institucion

class Usuario(db.Model):
    __tablename__ = 'def_usuarios'
    __table_args__ = {"schema": "geo"}
    id              = db.Column(db.Integer, primary_key=True)
    username        = db.Column(db.String(80), unique=True, nullable=False)
    email           = db.Column(db.String(255), unique=True, nullable=False)
    password        = db.Column(db.String(256), nullable=False)
    confirmed       = db.Column(db.Boolean, default=False, nullable=False)
    confirmation_token = db.Column(db.String(255), unique=True, nullable=True)
    id_institucion  = db.Column(
        db.Integer,
        db.ForeignKey('def_instituciones.id'),
        nullable=False,
        default=1,
    )

    institucion = db.relationship(Institucion, back_populates='usuarios')

    def set_password(self, raw):
        self.password = generate_password_hash(raw)

    def check_password(self, raw):
        return check_password_hash(self.password, raw)