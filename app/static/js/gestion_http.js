(function (global) {
  function obtenerCookie(nombre) {
    const prefijo = `${nombre}=`;
    const partes = document.cookie ? document.cookie.split("; ") : [];
    for (const parte of partes) {
      if (parte.startsWith(prefijo)) {
        return decodeURIComponent(parte.slice(prefijo.length));
      }
    }
    return null;
  }

  function obtenerTokenCSRF() {
    return obtenerCookie("csrf_access_token");
  }

  function crearOpcionesJson(method, payload) {
    const headers = {};
    const token = obtenerTokenCSRF();
    if (token) {
      headers["X-CSRF-Token"] = token;
    }
    const opciones = { method, headers };
    if (payload !== undefined) {
      headers["Content-Type"] = "application/json";
      opciones.body = JSON.stringify(payload);
    }
    return opciones;
  }

  function escapar(t) {
    const d = document.createElement("div");
    d.textContent = t || "";
    return d.innerHTML;
  }

  global.GestionHttp = {
    obtenerCookie,
    obtenerTokenCSRF,
    crearOpcionesJson,
    escapar,
  };
})(window);
