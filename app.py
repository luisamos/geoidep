# app.py
from flask import Flask
import config
from extensions import db, migrate, jwt, mail

def create_app():
    app = Flask(__name__)
    app.config.from_object(config)

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    mail.init_app(app)

    from routes.gestion import bp as gestion_bp
    from routes.herramientas_digitales import bp as herramientas_digitales_bp
    from routes.capas_geograficas import bp as capas_geograficas_bp
    from routes.geoportal import bp as geoportal_bp
    app.register_blueprint(gestion_bp)
    app.register_blueprint(herramientas_digitales_bp)
    app.register_blueprint(capas_geograficas_bp)
    app.register_blueprint(geoportal_bp)
    return app

if __name__ == "__main__":
    print('\n🟢\t[DESAROLLO] - GEOIDEP | Registro\n')
    create_app().run(port=5000, debug=True, host='127.0.0.8', use_reloader=True, threaded=True)
