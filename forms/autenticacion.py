from flask_wtf import FlaskForm, RecaptchaField
from wtforms import (
    PasswordField,
    SubmitField,
)
from wtforms.fields import EmailField
from wtforms.validators import DataRequired, Email

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