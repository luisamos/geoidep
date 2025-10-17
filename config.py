import os
from datetime import timedelta
from dotenv import load_dotenv
load_dotenv()

SECRET_KEY = "2ec242bf63d3e623de366a182809a09318a458091d336f4cf6e3d26408a2f247"
JWT_SECRET_KEY = "dc5654d30597e3678966d27526cb403c64f6b5e9f4346e084bf65497fa7fee4e"
RECAPTCHA_PUBLIC_KEY = "6LcNxoUrAAAAAL_UlqLYShQCvmruYTUE7s5jUkGL"
RECAPTCHA_PRIVATE_KEY = "6LcNxoUrAAAAANoYYtojSWUmyUgz9XP7_-OeUa71"

#ENV_NAME = (os.environ.get("FLASK_ENV") or os.environ.get("ENV") or "development").lower()
#IS_DEV = ENV_NAME in {"development", "dev", "local"}
IS_DEV = True
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_URI = os.environ.get(
    "DATABASE_URL",
    f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}",
)

JWT_ACCESS_TOKEN_EXPIRES = timedelta(minutes=15 if IS_DEV else 5)
JWT_REFRESH_TOKEN_EXPIRES = timedelta(days=1)
JWT_TOKEN_LOCATION = ["cookies"]
JWT_COOKIE_SAMESITE = "Lax"
WT_COOKIE_SECURE = False if IS_DEV else True
JWT_COOKIE_CSRF_PROTECT = False if IS_DEV else True
JWT_ACCESS_COOKIE_NAME = "access_geotoken"

SESSION_COOKIE_NAME = "geoidep_state"
SESSION_COOKIE_SAMESITE = "Lax"
SESSION_COOKIE_SECURE = False if IS_DEV else True

SQLALCHEMY_DATABASE_URI = DB_URI
SQLALCHEMY_TRACK_MODIFICATIONS = False

MAIL_SERVER = os.environ.get("MAIL_SERVER", "smtp.gmail.com")
MAIL_PORT = int(os.environ.get("MAIL_PORT", 587))
MAIL_USE_TLS = os.environ.get("MAIL_USE_TLS", "true").lower() in {"1", "true", "on"}
MAIL_USERNAME = os.environ.get("MAIL_USERNAME", "luisamos7@gmail.com")
MAIL_PASSWORD = os.environ.get("MAIL_PASSWORD", "****")
MAIL_DEFAULT_SENDER = os.environ.get("MAIL_DEFAULT_SENDER", MAIL_USERNAME)
MAIL_SUPPRESS_SEND = (
  os.environ.get("MAIL_SUPPRESS_SEND", "false").lower() in {"1", "true", "on"}
)