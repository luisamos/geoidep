from flask import Flask, flash, redirect, url_for

import config
from extensions import db, jwt, mail, migrate
from flask_jwt_extended import unset_jwt_cookies

def create_app():
  app = Flask(__name__)
  app.config.from_object(config)

  db.init_app(app)
  migrate.init_app(app, db)
  jwt.init_app(app)
  mail.init_app(app)

  @jwt.expired_token_loader
  def manejar_token_expirado(jwt_header, jwt_payload):
    flash('Tu sesión ha expirado. Vuelve a iniciar sesión.', 'warning')
    respuesta = redirect(url_for('gestion.ingreso'))
    unset_jwt_cookies(respuesta)
    return respuesta

  from routes.capas_geograficas import bp as capas_geograficas_bp
  from routes.gestion import bp as gestion_bp
  from routes.geoportal import bp as geoportal_bp
  from routes.herramientas_digitales import bp as herramientas_digitales_bp
  from routes.usuarios import bp as usuarios_bp

  app.register_blueprint(gestion_bp)
  app.register_blueprint(usuarios_bp)
  app.register_blueprint(herramientas_digitales_bp)
  app.register_blueprint(capas_geograficas_bp)
  app.register_blueprint(geoportal_bp)

  def asegurar_perfiles_basicos():
    from sqlalchemy import func, inspect

    from models.perfiles import Perfil

    inspector = inspect(db.engine)
    schema = Perfil.__table__.schema
    if not inspector.has_table(Perfil.__table__.name, schema=schema):
        return

    nombres_basicos = ["Administrador", "Especialista","Gestor de información"]
    creados = False
    for nombre in nombres_basicos:
        existe = (
            Perfil.query.filter(func.lower(Perfil.nombre) == nombre.lower())
            .filter_by(estado=True)
            .first()
        )
        if existe:
            continue

        perfil_existente = (
            Perfil.query.filter(func.lower(Perfil.nombre) == nombre.lower()).first()
        )
        if perfil_existente:
            perfil_existente.estado = True
            creados = True
            continue

        db.session.add(Perfil(nombre=nombre, estado=True))
        creados = True

    if creados:
        db.session.commit()

  with app.app_context():
      asegurar_perfiles_basicos()

  @app.context_processor
  def inyectar_usuario_actual():
    from routes._helpers import obtener_usuario_actual

    return {"usuario_actual": obtener_usuario_actual()}

  @app.after_request
  def aplicar_cabeceras_seguridad(response):
    response.headers.pop("Server", None)
    response.headers["Server"] = "GEOIDEP-GEOPORTAL"

    csp_directives = [
        "default-src 'self'",
        "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://code.jquery.com https://www.googletagmanager.com https://www.clarity.ms https://www.youtube.com https://www.google.com https://www.gstatic.com http://127.0.0.7",
        "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com http://127.0.0.7",
        "font-src 'self' data: https://fonts.gstatic.com",
        "img-src 'self' data: blob: https://*.gob.pe https://cdn.www.gob.pe https://www.youtube.com https://i.ytimg.com https://www.facebook.com https://twitter.com https://play.google.com https://www.google.com https://www.gstatic.com http://127.0.0.4 http://127.0.0.7",
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
          port=80,
          debug=True,
          host="0.0.0.0",
          use_reloader=True,
          threaded=True,
      )