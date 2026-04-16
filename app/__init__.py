from __future__ import annotations
import re
import secrets

from flask import Flask, Response, abort, g, jsonify, redirect, render_template, request, url_for
from flask_jwt_extended import unset_jwt_cookies

from app import config
from app.extensions import cache, db, jwt, mail, migrate
from app.routes import register_routes

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

  @app.before_request
  def generar_nonce_csp():
    if app.config.get("DISABLE_OPTIONS_METHOD", True) and request.method == "OPTIONS":
      abort(404)
    g.csp_nonce = secrets.token_urlsafe(16)

  @app.context_processor
  def inyectar_nonce_csp():
    return {"csp_nonce": getattr(g, "csp_nonce", "")}

  @app.errorhandler(404)
  def pagina_no_encontrada(error):
    return render_template('geoportal/404.html'), 404

  @app.route("/.well-known/security.txt")
  def security_txt():
    contenido = "\n".join([
        f"Contact: {app.config['SECURITY_TXT_CONTACT']}",
        f"Expires: {app.config['SECURITY_TXT_EXPIRES']}",
        f"Policy: {app.config['SECURITY_TXT_POLICY']}",
        f"Preferred-Languages: {app.config['SECURITY_TXT_LANG']}",
        f"Canonical: {request.url_root.rstrip('/')}/.well-known/security.txt",
    ]) + "\n"
    return Response(contenido, mimetype="text/plain")

  @app.route("/security.txt")
  def security_txt_raiz():
    return redirect(url_for("security_txt"), code=301)

  @app.after_request
  def aplicar_cabeceras_seguridad(response):
    response.headers.pop("Server", None)
    response.headers.pop("Allow", None)
    response.headers["Server"] = "GEOIDEP-GEOPORTAL"
    csp_nonce = getattr(g, "csp_nonce", "")

    if csp_nonce and response.mimetype == "text/html":
      contenido = response.get_data(as_text=True)
      contenido = re.sub(
          r"<script(?![^>]*\bnonce=)",
          f'<script nonce="{csp_nonce}"',
          contenido,
          flags=re.IGNORECASE,
      )
      response.set_data(contenido)

    csp_directives = [
        "default-src 'self'",
        f"script-src 'self' 'nonce-{csp_nonce}' https://code.jquery.com https://www.googletagmanager.com https://www.clarity.ms https://www.youtube.com https://www.google.com https://www.gstatic.com",
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
    response.headers["Referrer-Policy"] = app.config["REFERRER_POLICY"]
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response

  return app