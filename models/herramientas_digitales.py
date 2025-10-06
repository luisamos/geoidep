from app import db

class HerramientaDigital(db.Model):
    __tablename__ = 'def_herramientas_digitales'
    __table_args__ = {"schema": "ide"}

    id = db.Column(db.Integer, primary_key=True)
    id_tipo_servicio = db.Column('id_tipo_servicio', db.Integer, db.ForeignKey('def_tipos_servicios.id'), nullable=False)
    nombre = db.Column(db.String(200), nullable=False)
    descripcion = db.Column(db.Text)
    estado = db.Column(db.Integer)
    recurso = db.Column(db.Text)
    id_institucion = db.Column('id_institucion', db.Integer, db.ForeignKey('def_instituciones.id'), nullable=False)
    id_categoria = db.Column('id_categoria', db.Integer, db.ForeignKey('def_categorias.id'), nullable=False)

    tipo_servicio = db.relationship('TipoServicio', back_populates='herramientas')
    institucion = db.relationship('Institucion', back_populates='herramientas')
    categoria = db.relationship('Categoria', back_populates='herramientas')