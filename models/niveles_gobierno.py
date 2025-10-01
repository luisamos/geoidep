from app import db

class Entidad(db.Model):
    __tablename__ = 'def_entidades'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3), nullable=False)
    nombre = db.Column(db.String(100), nullable=False)

    sectores = db.relationship('Sector', back_populates='entidad', cascade='all, delete-orphan')


class Sector(db.Model):
    __tablename__ = 'def_sectores'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3), nullable=False)
    nombre = db.Column(db.String(100), nullable=False)
    id_entidad = db.Column('id_entidad', db.Integer, db.ForeignKey('def_entidades.id'), nullable=False)

    entidad = db.relationship('Entidad', back_populates='sectores')
    instituciones = db.relationship('Institucion', back_populates='sector', cascade='all, delete-orphan')


class Institucion(db.Model):
    __tablename__ = 'def_instituciones'

    id = db.Column(db.Integer, primary_key=True)
    pliego = db.Column(db.String(20))
    nombre = db.Column(db.String(800), nullable=False)
    logotipo = db.Column(db.Text)
    sigla = db.Column(db.String(20))
    id_sector = db.Column('id_sector', db.Integer, db.ForeignKey('def_sectores.id'), nullable=False)

    sector = db.relationship('Sector', back_populates='instituciones')
    capas = db.relationship('CapaGeografica', back_populates='institucion', cascade='all, delete-orphan')
    herramientas = db.relationship('HerramientaDigital', back_populates='institucion', cascade='all, delete-orphan')
    usuarios = db.relationship('Usuario', back_populates='institucion', cascade='all, delete-orphan')