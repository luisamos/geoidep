from app import db

class TipoServicio(db.Model):
    __tablename__ = 'def_tipos_servicios'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)
    id_padre = db.Column(db.Integer, nullable=False)

    servicios_geograficos = db.relationship('ServicioGeografico', back_populates='tipo_servicio', cascade='all, delete-orphan')
    herramientas = db.relationship('HerramientaDigital', back_populates='tipo_servicio', cascade='all, delete-orphan')