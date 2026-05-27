from .gestion import bp as gestion_bp

from .documentos import bp as documentos_bp
from .actividades import bp as actividades_bp
from .herramientas_geograficas import bp as herramientas_geograficas_bp
from .capas_geograficas import bp as capas_geograficas_bp
from .monitoreos import bp as monitoreos_bp
from .instituciones import bp as instituciones_bp
from .personal import bp as personal_bp
from .usuarios import bp as usuarios_bp
from .categorias import bp as categorias_bp
from .tipos import bp as tipos_bp
from .roles import bp as roles_bp
from .mi_cuenta import bp as mi_cuenta_bp

from .geoportal import bp as geoportal_bp

from .helpers import obtener_usuario_actual

__all__ = [
  'obtener_usuario_actual'
]

def register_routes(app):
  app.register_blueprint(gestion_bp)
  app.register_blueprint(documentos_bp)
  app.register_blueprint(actividades_bp)
  app.register_blueprint(herramientas_geograficas_bp)
  app.register_blueprint(capas_geograficas_bp)
  app.register_blueprint(monitoreos_bp)
  app.register_blueprint(instituciones_bp)
  app.register_blueprint(personal_bp)
  app.register_blueprint(usuarios_bp)
  app.register_blueprint(categorias_bp)
  app.register_blueprint(tipos_bp)
  app.register_blueprint(roles_bp)
  app.register_blueprint(mi_cuenta_bp)

  app.register_blueprint(geoportal_bp)