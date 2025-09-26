import os
from datetime import timedelta

SECRET_KEY = "2ec242bf63d3e623de366a182809a09318a458091d336f4cf6e3d26408a2f247"
JWT_SECRET_KEY = "dc5654d30597e3678966d27526cb403c64f6b5e9f4346e084bf65497fa7fee4e"
RECAPTCHA_PUBLIC_KEY = "6LcNxoUrAAAAAL_UlqLYShQCvmruYTUE7s5jUkGL"
RECAPTCHA_PRIVATE_KEY = "6LcNxoUrAAAAANoYYtojSWUmyUgz9XP7_-OeUa71"
DB_URI = os.environ.get("DATABASE_URL", "postgresql://postgres:123456@localhost:5432/geoidep")

JWT_ACCESS_TOKEN_EXPIRES = timedelta(minutes=15)
JWT_REFRESH_TOKEN_EXPIRES = timedelta(days=1)

SQLALCHEMY_DATABASE_URI = DB_URI
SQLALCHEMY_TRACK_MODIFICATIONS = False

MAIL_SERVER = os.environ.get("MAIL_SERVER", "smtp.gmail.com")
MAIL_PORT = int(os.environ.get("MAIL_PORT", 587))
MAIL_USE_TLS = os.environ.get("MAIL_USE_TLS", "true").lower() in {"1", "true", "on"}
MAIL_USERNAME = os.environ.get("MAIL_USERNAME", "luisamos7@gmail.com")
MAIL_PASSWORD = os.environ.get("MAIL_PASSWORD", "****")
MAIL_DEFAULT_SENDER = os.environ.get("MAIL_DEFAULT_SENDER", MAIL_USERNAME)
MAIL_SUPPRESS_SEND = os.environ.get("MAIL_SUPPRESS_SEND", "false").lower() in {"1", "true", "on"}