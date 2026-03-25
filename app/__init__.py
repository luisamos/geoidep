from __future__ import annotations
from flask import Flask, jsonify, redirect, render_template, request, url_for
from flask_jwt_extended import unset_jwt_cookies

import app.config as config
from .extensions import cache, db, jwt, mail, migrate
from .routes import register_routes


def _es_peticion_ajax():
  return (
      request.headers.get('X-Requested-With') == 'XMLHttpRequest'
      or 'application/json' in request.headers.get('Accept', '')
  )


def _redirigir_login():
  resp = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(resp)
  return resp


def create_app() -> Flask:
  app = Flask(__name__)
  app.config.from_object(config)

  db.init_app(app)
  migrate.init_app(app, db)
  jwt.init_app(app)
  mail.init_app(app)
  cache.init_app(app)

  @jwt.expired_token_loader
  def token_expirado(jwt_header, jwt_payload):
    if _es_peticion_ajax():
      return jsonify({"msg": "Token has expired"}), 401
    return _redirigir_login()

  @jwt.invalid_token_loader
  def token_invalido(error):
    if _es_peticion_ajax():
      return jsonify({"msg": "Invalid token"}), 401
    return _redirigir_login()

  @jwt.unauthorized_loader
  def token_ausente(error):
    if _es_peticion_ajax():
      return jsonify({"msg": "Missing token"}), 401
    return _redirigir_login()

  register_routes(app)

  @app.errorhandler(404)
  def pagina_no_encontrada(error):
    return render_template('geoportal/404.html'), 404

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