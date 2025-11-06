from __future__ import annotations
from flask import Flask

import apps.config as config
from .extensions import db, migrate, jwt, mail, cache
from .routes import register_routes

def create_app() -> Flask:
  app = Flask(__name__)
  app.config.from_object(config)

  db.init_app(app)
  migrate.init_app(app, db)
  jwt.init_app(app)
  mail.init_app(app)
  cache.init_app(app)

  register_routes(app)

  return app

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