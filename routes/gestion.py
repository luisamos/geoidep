import secrets
import smtplib

from flask import Blueprint, render_template, redirect, url_for, flash, session, abort, current_app
from flask_jwt_extended import create_access_token
from flask_mail import Message

from extensions import db, mail
from models.usuarios import Usuario
from forms.autenticacion import LoginForm, RegisterForm

bp = Blueprint('gestion', __name__)

@bp.route('/gestion', methods=['GET','POST'])
def ingreso():
    form = LoginForm()
    if form.validate_on_submit():
        user = Usuario.query.filter_by(username=form.username.data).first()
        if user and user.check_password(form.password.data):
            if not user.confirmed:
                flash('Debes confirmar tu correo antes de ingresar.', 'error')
                return redirect(url_for('gestion.ingreso'))
            session['usuario']       = user.username
            session['access_token']  = create_access_token(identity=user.username)
            return redirect(url_for('gestion.principal'))
        flash('Usuario o contraseña inválidos', 'error')
    return render_template('gestion/ingreso.html', form=form)


def _enviar_correo_confirmacion(usuario: Usuario) -> bool:
    if not usuario.email:
        current_app.logger.warning('Usuario %s no tiene correo registrado, se omite el envío de confirmación.', usuario.username)
        return False

    if current_app.config.get('MAIL_SUPPRESS_SEND'):
        current_app.logger.info('MAIL_SUPPRESS_SEND habilitado, no se enviará correo a %s', usuario.email)
        return True

    if not current_app.config.get('MAIL_SERVER'):
        current_app.logger.warning('Configuración de correo incompleta, no se pudo enviar la confirmación a %s', usuario.email)
        return False

    confirm_url = url_for('gestion.confirmar_cuenta', token=usuario.confirmation_token, _external=True)
    asunto = 'Confirma tu cuenta en GEOIDEP'
    cuerpo = render_template('gestion/email_confirmacion.txt', usuario=usuario, confirm_url=confirm_url)
    cuerpo_html = render_template('gestion/email_confirmacion.html', usuario=usuario, confirm_url=confirm_url)

    mensaje = Message(subject=asunto, recipients=[usuario.email])
    mensaje.body = cuerpo
    mensaje.html = cuerpo_html

    try:
        mail.send(mensaje)
    except smtplib.SMTPAuthenticationError:
        current_app.logger.exception(
            'Error de autenticación SMTP al enviar el correo de confirmación para %s. '
            'Verifica las credenciales y, si usas autenticación en dos pasos, genera una contraseña de aplicación.',
            usuario.email,
        )
        return False
    except Exception:  # pragma: no cover - dependiente de infraestructura de correo
        current_app.logger.exception('No se pudo enviar el correo de confirmación para %s', usuario.email)
        return False

    return True

@bp.route('/registro', methods=['GET', 'POST'])
def registro():
    form = RegisterForm()
    if form.validate_on_submit():
        if Usuario.query.filter_by(username=form.username.data).first():
            flash('El nombre de usuario ya se encuentra registrado.', 'error')
        elif Usuario.query.filter_by(email=form.email.data).first():
            flash('El correo electrónico ya está siendo utilizado.', 'error')
        else:
            nuevo_usuario = Usuario(
                username=form.username.data,
                email=form.email.data,
                confirmed=False,
                confirmation_token=secrets.token_urlsafe(32),
                id_institucion=1,
            )
            nuevo_usuario.set_password(form.password.data)
            db.session.add(nuevo_usuario)
            db.session.commit()

            correo_enviado = _enviar_correo_confirmacion(nuevo_usuario)
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


@bp.route('/confirmar/<token>')
def confirmar_cuenta(token):
    usuario = Usuario.query.filter_by(confirmation_token=token).first()
    if not usuario:
        abort(404)

    if not usuario.confirmed:
        usuario.confirmed = True
        usuario.confirmation_token = None
        db.session.commit()
        flash('Tu cuenta ha sido confirmada correctamente. Ya puedes iniciar sesión.', 'success')
    else:
        flash('Tu cuenta ya se encontraba confirmada.', 'info')

    return redirect(url_for('gestion.ingreso'))

@bp.route('/principal')
def principal():
    if 'usuario' not in session:
        return redirect(url_for('gestion.ingreso'))
    return render_template('gestion/principal.html')

@bp.route('/salir', endpoint='logout')
def salir():
    session.clear()
    return redirect(url_for('gestion.ingreso'))