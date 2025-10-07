from flask import (
    Blueprint,
    current_app,
    flash,
    redirect,
    render_template,
    session,
    url_for,
)
from flask_jwt_extended import (
    create_access_token,
    jwt_required,
    set_access_cookies,
    unset_jwt_cookies,
)

from sqlalchemy import func

from extensions import db, mail
from forms.autenticacion import LoginForm, RegisterForm

from models.perfiles import Perfil
from models.usuarios import Usuario
from routes._helpers import obtener_usuario_actual
from routes.usuarios import enviar_correo_confirmacion

bp = Blueprint('gestion', __name__, url_prefix='/gestion')

@bp.route('/', methods=['GET', 'POST'])
def ingreso():
  form = LoginForm()
  if form.validate_on_submit():
    email = form.email.data.strip().lower()
    usuario = Usuario.query.filter(func.lower(Usuario.email) == email).first()
    if not usuario or not usuario.check_password(form.password.data):
      flash('Correo o contraseña inválidos', 'error')
    elif not usuario.estado:
      flash('La cuenta se encuentra deshabilitada. Contacta al administrador.', 'error')
    elif not usuario.confirmed:
      flash('Debes confirmar tu correo antes de ingresar.', 'error')
    else:
      session['usuario'] = usuario.email
      session['id_usuario'] = usuario.id
      session['id_perfil'] = usuario.id_perfil
      session['rol'] = usuario.nombre_perfil
      session['id_institucion'] = usuario.id_institucion

      token_identity = {
        'id_usuario': usuario.id,
        'id_rol': usuario.id_perfil,
        'id_institucion': usuario.id_institucion,
      }
      access_token = create_access_token(identity=token_identity)
      respuesta = redirect(url_for('gestion.principal'))
      set_access_cookies(respuesta, access_token)
      return respuesta
  return render_template('gestion/ingreso.html', form=form)

@bp.route('/principal')
@jwt_required()
def principal():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    session.clear()
    return redirect(url_for('gestion.ingreso'))
  if 'usuario' not in session:
    session['usuario'] = usuario.email
    session['id_usuario'] = usuario.id
    session['id_perfil'] = usuario.id_perfil
    session['rol'] = usuario.nombre_perfil
    session['id_institucion'] = usuario.id_institucion
  return render_template('gestion/principal.html')

@bp.route('/registro', methods=['GET', 'POST'])
def registro():
  form = RegisterForm()
  if form.validate_on_submit():
    email = form.email.data.strip().lower()
    if Usuario.query.filter(func.lower(Usuario.email) == email).first():
      flash('El correo electrónico ya está siendo utilizado.', 'error')
    else:
      nuevo_usuario = Usuario(
        nombres=form.nombres.data,
        apellidos=form.apellidos.data,
        email=email,
        confirmed=False,
        estado=True,
        geoidep=False,
        geoperu=False,
        id_institucion=1,
      )
      perfil_gestor = (
        Perfil.query.filter(func.lower(Perfil.nombre) == 'gestor de información')
        .filter_by(estado=True)
        .first()
      )
      if not perfil_gestor:
        perfil_gestor = (
            Perfil.query.filter_by(estado=True).order_by(Perfil.id).first()
        )
      if perfil_gestor:
        nuevo_usuario.id_perfil = perfil_gestor.id
      nuevo_usuario.set_password(form.password.data)
      nuevo_usuario.generar_token_confirmacion()
      db.session.add(nuevo_usuario)
      db.session.commit()

      correo_enviado = enviar_correo_confirmacion(nuevo_usuario)
      if correo_enviado:
        flash('Tu cuenta ha sido creada. Revisa tu correo para confirmar el registro.', 'success')
      else:
        flash(
          'Tu cuenta ha sido creada, pero no pudimos enviar el correo de confirmación. '
          'Contacta al administrador para completar la activación.',
          'warning',
        )
      return redirect(url_for('gestion.ingreso'))

  return render_template('gestion/registro.html', form=form)

@bp.route('/salir', endpoint='logout')
@jwt_required(optional=True)
def salir():
  session.clear()
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta