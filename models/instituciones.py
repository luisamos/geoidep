from app import db
from models import SCHEMA_IDE

class Institucion(db.Model):
  __tablename__ = 'def_instituciones'
  __table_args__ = {'schema': SCHEMA_IDE}

  id = db.Column(db.Integer, primary_key=True)
  codigo = db.Column(db.String(20), nullable=True)
  ubigeo = db.Column(db.String(20), nullable=True)
  nombre = db.Column(db.String(800), nullable=False)
  nro_ruc = db.Column(db.String(11), nullable=True)
  sigla = db.Column(db.String(50))
  logotipo = db.Column(db.Text)
  orden = db.Column(db.Integer, nullable=False, default=1, server_default='1')
  id_padre = db.Column(db.Integer, nullable=False)
  id_usuario = db.Column(
    'id_usuario',
    db.Integer,
    db.ForeignKey(
        f"{SCHEMA_IDE}.def_usuarios.id",
        name='fk_def_instituciones_id_usuario',
        use_alter=True,
    ),
    nullable=False,
  )
  fecha_crea = db.Column(db.Date)

  usuarios = db.relationship('Usuario', back_populates='institucion', cascade='all, delete-orphan')
