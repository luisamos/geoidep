from flask_wtf import FlaskForm, RecaptchaField
from wtforms import (
    BooleanField,
    DateField,
    HiddenField,
    PasswordField,
    SelectField,
    StringField,
    SubmitField,
)
from wtforms.fields import EmailField
from wtforms.validators import DataRequired, Email, EqualTo, Optional


class LoginForm(FlaskForm):
    email = EmailField(
        "Correo electrónico",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            Email(message="Ingrese un correo válido"),
        ],
    )
    password = PasswordField(
        "Contraseña",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    recaptcha = RecaptchaField()
    submit = SubmitField("Ingresar")


class RegisterForm(FlaskForm):
    nombres = StringField(
        "Nombres",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    apellidos = StringField(
        "Apellidos",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    email = EmailField(
        "Correo electrónico",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            Email(message="Ingrese un correo válido"),
        ],
    )
    password = PasswordField(
        "Contraseña",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    confirm_password = PasswordField(
        "Confirmar Contraseña",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            EqualTo('password', message='Las contraseñas deben coincidir'),
        ],
    )
    recaptcha = RecaptchaField()
    submit = SubmitField("Registrar")


class ForgotPasswordForm(FlaskForm):
    email = EmailField(
        "Correo electrónico",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            Email(message="Ingrese un correo válido"),
        ],
    )
    submit = SubmitField("Enviar enlace de recuperación")


class ResetPasswordForm(FlaskForm):
    password = PasswordField(
        "Nueva contraseña",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    confirm_password = PasswordField(
        "Confirmar contraseña",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            EqualTo('password', message='Las contraseñas deben coincidir'),
        ],
    )
    submit = SubmitField("Restablecer contraseña")


class UsuarioForm(FlaskForm):
    id = HiddenField()
    nombres = StringField(
        "Nombres",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    apellidos = StringField(
        "Apellidos",
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    email = EmailField(
        "Correo electrónico",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            Email(message="Ingrese un correo válido"),
        ],
    )
    numero_documento = StringField("N° documento")
    fecha = DateField("Fecha", format="%Y-%m-%d", validators=[Optional()])
    id_institucion = SelectField(
        "Institución",
        coerce=int,
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    id_perfil = SelectField(
        "Perfil",
        coerce=int,
        validators=[DataRequired(message="Este campo es obligatorio")],
    )
    estado = BooleanField("Activo", default=True)
    geoidep = BooleanField("Acceso GEOIDEP")
    geoperu = BooleanField("Acceso GEOPERU")
    password = PasswordField("Contraseña", validators=[Optional()])
    submit = SubmitField("Guardar")


class BuscarUsuarioForm(FlaskForm):
    termino = StringField("Buscar")
    submit = SubmitField("Buscar")


class DeleteUsuarioForm(FlaskForm):
    submit = SubmitField("Eliminar")