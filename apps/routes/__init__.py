from .capas_geograficas import bp as capas_geograficas_bp
from .gestion import bp as gestion_bp
from .geoportal import bp as geoportal_bp
from .herramientas_digitales import bp as herramientas_digitales_bp
from .instituciones import bp as instituciones_bp
from .categorias import bp as categorias_bp
from .personal import bp as personal_bp
from .usuarios import bp as usuarios_bp
from .tipos_servicios import bp as tipos_servicios_bp

from .helpers import obtener_usuario_actual

__all__ = [
  'obtener_usuario_actual'
]

def register_routes(app):
  app.register_blueprint(gestion_bp)
  app.register_blueprint(usuarios_bp)
  app.register_blueprint(herramientas_digitales_bp)
  app.register_blueprint(instituciones_bp)
  app.register_blueprint(categorias_bp)
  app.register_blueprint(personal_bp)
  app.register_blueprint(capas_geograficas_bp)
  app.register_blueprint(geoportal_bp)
  app.register_blueprint(tipos_servicios_bp)