import asyncio
import logging

from flask import (
    Blueprint,
    flash,
    jsonify,
    redirect,
    render_template,
    request,
    url_for,
)
from flask_jwt_extended import (
    create_access_token,
    jwt_required,
    set_access_cookies,
    unset_jwt_cookies,
)

from sqlalchemy import and_, func, or_
from sqlalchemy.orm import joinedload

from app.extensions import db

from app.forms.autenticacion import LoginForm
from app.models import (
    CapaGeografica,
    HerramientaGeografica,
    Institucion,
    LogMonitoreo,
    ServicioGeografico,
    Tipo,
)
from app.models.usuarios import Usuario
from app.routes.helpers import obtener_usuario_actual, usuario_puede_ver_todas_entidades
from app.services.monitoreo import RequestConfig, ejecutar_monitoreo

bp = Blueprint('gestion', __name__)

def redirect_to_login():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta

@bp.route('/gestion', methods=['GET', 'POST'])
def ingreso():
  usuario_actual = obtener_usuario_actual()
  if usuario_actual:
    return redirect(url_for('monitoreos.principal'))

  form = LoginForm()
  if form.validate_on_submit():
    email = form.email.data.strip().lower()
    usuario = Usuario.query.filter(
        func.lower(Usuario.correo_electronico) == email
    ).first()
    if not usuario or not usuario.check_password(form.password.data):
      flash('Correo o contraseña inválidos', 'error')
    elif not usuario.estado:
      flash('La cuenta se encuentra deshabilitada. Contacta al administrador.', 'error')
    elif not usuario.idep:
      flash('Tu usuario no cuenta con acceso a la geoIDEP.', 'error')
    else:
      access_token = create_access_token(
        identity=str(usuario.id),
        additional_claims={
          'id_rol': usuario.id_perfil,
          'id_institucion': usuario.id_institucion,
        },
      )
      respuesta = redirect(url_for('monitoreos.principal'))
      set_access_cookies(respuesta, access_token)
      return respuesta
  elif form.is_submitted():
    for errores in form.errors.values():
      for mensaje in errores:
        flash(mensaje, 'error')
  return render_template('gestion/ingreso.html', form=form)

@bp.route('/salir', endpoint='logout')
@jwt_required(optional=True)
def salir():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta
