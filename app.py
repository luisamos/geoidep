from apps import create_app
from apps.config import IS_DEV

app = create_app()

if __name__ == "__main__":
    print("\n🟢\t[PRODUCCIÓN] | GEOIDEP - GEOPORTAL\n")
    app.run(
    port=5000 if IS_DEV else 5004,
    debug=True,
    host="127.0.0.7" if IS_DEV else "0.0.0.0",
    use_reloader=True,
    threaded=True,
  )