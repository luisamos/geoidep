from flask import (
  Blueprint,
  abort,
  current_app,
  flash,
  redirect,
  render_template,
  request,
  url_for,
)
from flask_jwt_extended import jwt_required, unset_jwt_cookies
from flask_mail import Message
from sqlalchemy import func, or_

from extensions import db, mail
from forms.autenticacion import (
  BuscarUsuarioForm,
  DeleteUsuarioForm,
  UsuarioForm,
  ForgotPasswordForm,
  RegisterForm,
  ResetPasswordForm
)
from models.niveles_gobierno import Institucion
from models.usuarios import Usuario
from routes._helpers import obtener_usuario_actual

def enviar_correo_confirmacion(usuario: Usuario) -> bool:
  if not usuario.email:
    current_app.logger.warning(
      'Usuario %s no tiene correo registrado, se omite el envío de confirmación.',
      usuario.nombre_completo,
    )
    return False

  if current_app.config.get('MAIL_SUPPRESS_SEND'):
    current_app.logger.info('MAIL_SUPPRESS_SEND habilitado, no se enviará correo a %s', usuario.email)
    return True

  if not current_app.config.get('MAIL_SERVER'):
    current_app.logger.warning(
      'Configuración de correo incompleta, no se pudo enviar la confirmación a %s',
      usuario.email,
    )
    return False

  if not usuario.confirmation_token:
    usuario.generar_token_confirmacion()
    db.session.commit()

  confirm_url = url_for('gestion.confirmar_cuenta', token=usuario.confirmation_token, _external=True)
  asunto = 'Confirma tu cuenta en GEOIDEP'
  cuerpo = render_template('gestion/email_confirmacion.txt', usuario=usuario, confirm_url=confirm_url)
  cuerpo_html = render_template('gestion/email_confirmacion.html', usuario=usuario, confirm_url=confirm_url)

  mensaje = Message(subject=asunto, recipients=[usuario.email])
  mensaje.body = cuerpo
  mensaje.html = cuerpo_html

  try:
    mail.send(mensaje)
  except Exception as exc:
    current_app.logger.exception('No se pudo enviar el correo de confirmación para %s', usuario.email)
    return False

  return True

def enviar_correo_recuperacion(usuario: Usuario) -> bool:
  if not usuario.email:
    current_app.logger.warning(
      'Usuario %s no tiene correo registrado, se omite el envío de recuperación.',
      usuario.nombre_completo,
    )
    return False

  if current_app.config.get('MAIL_SUPPRESS_SEND'):
    current_app.logger.info('MAIL_SUPPRESS_SEND habilitado, no se enviará correo a %s', usuario.email)
    return True

  if not current_app.config.get('MAIL_SERVER'):
    current_app.logger.warning(
      'Configuración de correo incompleta, no se pudo enviar la recuperación a %s',
      usuario.email,
    )
    return False

  if not usuario.reset_token:
    usuario.generar_token_recuperacion()
    db.session.commit()

  reset_url = url_for('gestion.restablecer_contrasena', token=usuario.reset_token, _external=True)
  asunto = 'Recupera tu contraseña en GEOIDEP'
  cuerpo = render_template('gestion/email_recuperacion.txt', usuario=usuario, reset_url=reset_url)
  cuerpo_html = render_template('gestion/email_recuperacion.html', usuario=usuario, reset_url=reset_url)

  mensaje = Message(subject=asunto, recipients=[usuario.email])
  mensaje.body = cuerpo
  mensaje.html = cuerpo_html

  try:
      mail.send(mensaje)
  except Exception:
      current_app.logger.exception('No se pudo enviar el correo de recuperación para %s', usuario.email)
      return False

  return True

bp = Blueprint('usuarios', __name__, url_prefix='/usuarios')

def _redirect_to_login():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta


def _obtener_admin_actual():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return None, _redirect_to_login()
  if not usuario.es_administrador:
    flash('No cuentas con permisos para acceder a esta sección.', 'error')
    return None, redirect(url_for('gestion.principal'))
  return usuario, None


@bp.route('/', endpoint='listar')
@jwt_required()
def usuarios():
  _, respuesta = _obtener_admin_actual()
  if respuesta():
    return respuesta

  termino = request.args.get('q', '').strip()
  editar_id = request.args.get('editar', type=int)

  consulta = Usuario.query.order_by(Usuario.apellidos, Usuario.nombres, Usuario.email)
  if termino:
    like = f"%{termino}%"
    consulta = consulta.filter(
      or_(
        Usuario.nombres.ilike(like),
        Usuario.apellidos.ilike(like),
        Usuario.email.ilike(like),
        Usuario.numero_documento.ilike(like),
      )
    )
  lista_usuarios = consulta.all()

  instituciones = Institucion.query.order_by(Institucion.nombre).all()
  choices_institucion = [(inst.id, inst.nombre) for inst in instituciones]

  form = UsuarioForm()
  form.id_institucion.choices = choices_institucion
  if choices_institucion and not form.id.data:
    form.id_institucion.data = choices_institucion[0][0]

  usuario_editar = None
  if editar_id:
    usuario_editar = Usuario.query.get_or_404(editar_id)
    form = UsuarioForm(obj=usuario_editar)
    form.id.data = usuario_editar.id
    form.id_institucion.choices = choices_institucion
    form.email.data = usuario_editar.email
    form.estado.data = usuario_editar.estado
    form.geoidep.data = usuario_editar.geoidep
    form.geoperu.data = usuario_editar.geoperu

  buscar_form = BuscarUsuarioForm()
  buscar_form.termino.data = termino
  delete_form = DeleteUsuarioForm()

  return render_template(
    'gestion/usuarios.html',
    usuarios=lista_usuarios,
    form=form,
    buscar_form=buscar_form,
    delete_form=delete_form,
    usuario_editar=usuario_editar,
    termino=termino,
  )