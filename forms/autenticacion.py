from flask_wtf import FlaskForm, RecaptchaField
from wtforms import (
    BooleanField,
    HiddenField,
    PasswordField,
    SelectField,
    StringField,
    SubmitField,
)
from wtforms.fields import EmailField
from wtforms.validators import DataRequired, Email, Length, Optional


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


class UsuarioForm(FlaskForm):
  id = HiddenField()
  nombres = StringField(
    "Nombres",
    validators=[Optional(), Length(max=120, message="Máximo 120 caracteres")],
  )
  apellidos = StringField(
    "Apellidos",
    validators=[Optional(), Length(max=160, message="Máximo 160 caracteres")],
  )
  email = EmailField(
    "Correo electrónico",
    validators=[
      DataRequired(message="Este campo es obligatorio"),
      Email(message="Ingrese un correo válido"),
    ],
  )
  numero_documento = StringField(
    "Número de documento",
    validators=[Optional(), Length(max=20, message="Máximo 20 caracteres")],
  )
  id_institucion = SelectField(
    "Institución",
    coerce=int,
    validators=[DataRequired(message="Selecciona una institución")],
  )
  id_perfil = SelectField(
    "Perfil",
    coerce=int,
    validators=[DataRequired(message="Selecciona un perfil")],
  )
  estado = BooleanField("Usuario activo", default=True)
  geoidep = BooleanField("Acceso a GeoIDEP", default=False)
  geoperu = BooleanField("Acceso a GeoPerú", default=False)
  password = PasswordField(
    "Contraseña",
    validators=[Optional(), Length(max=256, message="Máximo 256 caracteres")],
  )
  submit = SubmitField("Guardar")


class BuscarUsuarioForm(FlaskForm):
  termino = StringField(
    "Buscar usuario",
    validators=[Optional(), Length(max=255, message="Máximo 255 caracteres")],
  )
  submit = SubmitField("Buscar")


class DeleteUsuarioForm(FlaskForm):
  submit = SubmitField("Eliminar")