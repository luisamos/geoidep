from app import db

class CapaGeografica(db.Model):
    __tablename__ = 'def_capas_geograficas'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(200), nullable=False)
    descripcion = db.Column(db.String(500))
    tipo_capa = db.Column(db.Boolean, default=True)
    publicar_geoperu = db.Column(db.Boolean, default=False)
    id_categoria = db.Column('id_categoria', db.Integer, db.ForeignKey('def_categorias.id'), nullable=False)
    id_institucion = db.Column('id_institucion', db.Integer, db.ForeignKey('def_instituciones.id'), nullable=False)

    categoria = db.relationship('Categoria', back_populates='capas')
    institucion = db.relationship('Institucion', back_populates='capas')
    servicios = db.relationship('ServicioGeografico', back_populates='capa', cascade='all, delete-orphan')


class ServicioGeografico(db.Model):
    __tablename__ = 'def_servicios_geograficos'

    id = db.Column(db.Integer, primary_key=True)
    id_capa = db.Column(db.Integer, db.ForeignKey('def_capas_geograficas.id'), nullable=False)
    id_tipo_servicio = db.Column(db.Integer, db.ForeignKey('def_tipos_servicios.id'), nullable=False)
    direccion_web = db.Column(db.Text, nullable=False)
    nombre_layer = db.Column(db.String(200))
    visible = db.Column(db.Boolean, default=True)

    capa = db.relationship('CapaGeografica', back_populates='servicios')
    tipo_servicio = db.relationship('TipoServicio', back_populates='servicios_geograficos')