from flask import Flask
import config
from extensions import db, jwt, mail, migrate, cache

def create_app():
  app = Flask(__name__)
  app.config.from_object(config)

  db.init_app(app)
  migrate.init_app(app, db)
  jwt.init_app(app)
  mail.init_app(app)
  cache.init_app(app)

  from routes.capas_geograficas import bp as capas_geograficas_bp
  from routes.gestion import bp as gestion_bp
  from routes.geoportal import bp as geoportal_bp
  from routes.herramientas_digitales import bp as herramientas_digitales_bp
  from routes.instituciones import bp as instituciones_bp
  from routes.categorias import bp as categorias_bp
  from routes.personal import bp as personal_bp
  from routes.usuarios import bp as usuarios_bp
  from routes.tipos_servicios import bp as tipos_servicios_bp

  app.register_blueprint(gestion_bp)
  app.register_blueprint(usuarios_bp)
  app.register_blueprint(herramientas_digitales_bp)
  app.register_blueprint(instituciones_bp)
  app.register_blueprint(categorias_bp)
  app.register_blueprint(personal_bp)
  app.register_blueprint(capas_geograficas_bp)
  app.register_blueprint(geoportal_bp)
  app.register_blueprint(tipos_servicios_bp)

  @app.after_request
  def aplicar_cabeceras_seguridad(response):
    response.headers.pop("Server", None)
    response.headers["Server"] = "GEOIDEP-GEOPORTAL"

    csp_directives = [
        "default-src 'self'",
        "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://code.jquery.com https://www.googletagmanager.com https://www.clarity.ms https://www.youtube.com https://www.google.com https://www.gstatic.com",
        "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
        "font-src 'self' data: https://fonts.gstatic.com",
        "img-src 'self' data: blob: https://*.gob.pe https://cdn.www.gob.pe https://www.youtube.com https://i.ytimg.com https://www.facebook.com https://twitter.com https://play.google.com https://www.google.com https://www.gstatic.com",
        "connect-src 'self' https://www.gob.pe https://www.googletagmanager.com https://www.clarity.ms https://www.google.com https://www.gstatic.com",
        "frame-src https://www.youtube.com https://www.googletagmanager.com https://www.google.com https://www.gstatic.com",
        "object-src 'none'",
        "base-uri 'self'",
        "frame-ancestors 'none'",
    ]
    response.headers["Content-Security-Policy"] = "; ".join(csp_directives)
    response.headers["X-Frame-Options"] = "DENY"
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response

  return app

if __name__ == "__main__":
  if config.IS_DEV:
    print("\n🔴\t[DESAROLLO] - GEOIDEP | GEOPORTAL | GESTION\n")
    create_app().run(
        port=5000,
        debug=True,
        host="127.0.0.8",
        use_reloader=True,
        threaded=True,
    )
  else:
    print("\n🟢\t[PRODUCCIÓN] - GEOIDEP | GEOPORTAL | GESTION\n")
    create_app().run(
        port=81,
        debug=True,
        host="0.0.0.0",
        use_reloader=True,
        threaded=True,
    )