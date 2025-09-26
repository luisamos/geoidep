from flask_wtf import FlaskForm, RecaptchaField
from wtforms import StringField, PasswordField, SubmitField
from wtforms.fields import EmailField
from wtforms.validators import DataRequired, EqualTo, Email

class LoginForm(FlaskForm):
    username  = StringField("Usuario", validators=[DataRequired(message="Este campo es obligatorio")])
    password  = PasswordField("Contraseña", validators=[DataRequired(message="Este campo es obligatorio")])
    recaptcha = RecaptchaField()
    submit    = SubmitField("Ingresar")

class RegisterForm(FlaskForm):
    username         = StringField("Usuario", validators=[DataRequired(message="Este campo es obligatorio")])
    email            = EmailField(
        "Correo electrónico",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            Email(message="Ingrese un correo válido")
        ]
    )
    password         = PasswordField("Contraseña", validators=[DataRequired(message="Este campo es obligatorio")])
    confirm_password = PasswordField(
        "Confirmar Contraseña",
        validators=[
            DataRequired(message="Este campo es obligatorio"),
            EqualTo('password', message='Las contraseñas deben coincidir')
        ]
    )
    recaptcha  = RecaptchaField()
    submit     = SubmitField("Registrar")
