# app.py
from flask import Flask

import config
from extensions import db, jwt, mail, migrate


def create_app():
  app = Flask(__name__)
  app.config.from_object(config)

  db.init_app(app)
  migrate.init_app(app, db)
  jwt.init_app(app)
  mail.init_app(app)

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

  @app.before_first_request
  def asegurar_perfiles_basicos():
    from sqlalchemy import func
    from models.perfiles import Perfil

    nombres_basicos = ['Administrador', 'Gestor de información']
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

  @app.context_processor
  def inyectar_usuario_actual():
    from routes._helpers import obtener_usuario_actual

    return {'usuario_actual': obtener_usuario_actual()}

  @app.after_request
  def aplicar_cabeceras_seguridad(response):
      response.headers.pop("Server", None)
      response.headers["Server"] = "GEOIDEP-GEOPORTAL"
      response.headers[
          "Content-Security-Policy"
      ] = "default-src 'none'; frame-ancestors 'none';"
      response.headers["X-Frame-Options"] = "DENY"
      response.headers["X-Content-Type-Options"] = "nosniff"
      response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "0"
      return response

  return app

if __name__ == "__main__":
  if config.IS_DEV:
    print('\n🔴\t[DESAROLLO] - GEOIDEP | Registro\n')
    create_app().run(port=5000, debug=True, host='127.0.0.8', use_reloader=True, threaded=True)
  else:
    print('\n🟢\t[PRODUCCIÓN] - GEOIDEP | Registro\n')
    create_app().run(port=80, debug=True, host='0.0.0.0', use_reloader=True, threaded=True)
