from flask import (
    Blueprint,
    flash,
    redirect,
    render_template,
    url_for,
)
from flask_jwt_extended import (
    create_access_token,
    jwt_required,
    set_access_cookies,
    unset_jwt_cookies,
)

from sqlalchemy import func

from extensions import db

from models.perfiles import Perfil
from forms.autenticacion import LoginForm
from models.usuarios import Usuario
from routes._helpers import obtener_usuario_actual

bp = Blueprint('gestion', __name__)

def redirect_to_login():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta

@bp.route('/gestion', methods=['GET', 'POST'])
def ingreso():
  usuario_actual = obtener_usuario_actual()
  if usuario_actual:
    return redirect(url_for('gestion.principal'))

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
    elif not usuario.geoidep or not usuario.tiene_perfil_gestion:
      flash('Tu usuario no cuenta con acceso a GEOIDEP.', 'error')
    else:
      access_token = create_access_token(
        identity=str(usuario.id),
        additional_claims={
          'id_rol': usuario.id_perfil,
          'id_institucion': usuario.id_institucion,
        },
      )
      respuesta = redirect(url_for('gestion.principal'))
      set_access_cookies(respuesta, access_token)
      return respuesta
  elif form.is_submitted():
    for errores in form.errors.values():
      for mensaje in errores:
        flash(mensaje, 'error')
  return render_template('gestion/ingreso.html', form=form)

@bp.route('/principal')
@jwt_required()
def principal():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return redirect_to_login()
  return render_template('gestion/principal.html', usuario_actual=usuario)

@bp.route('/salir', endpoint='logout')
@jwt_required(optional=True)
def salir():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta