(function (global) {
  function valorFecha(v) {
    const m = String(v).match(
      /^(\d{2})\/(\d{2})\/(\d{4})(?:\s+(\d{2}):(\d{2}))?/
    );
    if (m) {
      return new Date(+m[3], +m[2] - 1, +m[1], +(m[4] || 0), +(m[5] || 0)).getTime();
    }
    const t = Date.parse(v);
    return Number.isNaN(t) ? null : t;
  }

  function comparar(tipo, dir) {
    const factor = dir === "desc" ? -1 : 1;
    return (a, b) => {
      const va = a ?? "";
      const vb = b ?? "";
      if (va === "" && vb !== "") return 1;
      if (vb === "" && va !== "") return -1;
      if (va === "" && vb === "") return 0;
      if (tipo === "number") return (Number(va) - Number(vb)) * factor;
      if (tipo === "date") {
        const fa = valorFecha(va);
        const fb = valorFecha(vb);
        if (fa !== null && fb !== null) return (fa - fb) * factor;
      }
      return (
        String(va).localeCompare(String(vb), "es", { numeric: true }) * factor
      );
    };
  }

  function ordenable({ tabla, columnas, alOrdenar }) {
    const estado = { key: null, tipo: null, dir: null };
    const ths = tabla.querySelectorAll("thead th");

    columnas.forEach((col) => {
      const th = ths[col.indice];
      if (!th) return;
      th.classList.add("sortable");
      th.dataset.key = col.key;
      th.dataset.tipo = col.tipo || "string";
      th.insertAdjacentHTML(
        "beforeend",
        ' <i class="material-icons sort-icon">unfold_more</i>'
      );
      th.addEventListener("click", () => {
        if (estado.key === col.key) {
          estado.dir = estado.dir === "asc" ? "desc" : "asc";
        } else {
          estado.key = col.key;
          estado.tipo = col.tipo || "string";
          estado.dir = "asc";
        }
        actualizarIconos();
        if (typeof alOrdenar === "function") alOrdenar();
      });
    });

    function actualizarIconos() {
      ths.forEach((th) => {
        if (!th.classList.contains("sortable")) return;
        th.classList.remove("sort-asc", "sort-desc");
        const icono = th.querySelector(".sort-icon");
        if (!icono) return;
        if (th.dataset.key === estado.key) {
          th.classList.add(estado.dir === "asc" ? "sort-asc" : "sort-desc");
          icono.textContent =
            estado.dir === "asc" ? "arrow_upward" : "arrow_downward";
        } else {
          icono.textContent = "unfold_more";
        }
      });
    }

    return {
      aplicar(arr) {
        if (!estado.key || !Array.isArray(arr)) return arr;
        const cmp = comparar(estado.tipo, estado.dir);
        return [...arr].sort((a, b) => cmp(a[estado.key], b[estado.key]));
      },
      estado() {
        return { ...estado };
      },
    };
  }

  // Variante para tablas renderizadas por el servidor: ordena las filas <tr>
  // existentes según el texto de la celda. `indiceNumeracion` (opcional)
  // indica una columna N° que se renumera tras cada ordenamiento.
  function ordenableDom({ tabla, columnas, indiceNumeracion }) {
    const tbody = tabla.querySelector("tbody");
    const instancia = ordenable({
      tabla,
      columnas: columnas.map((col) => ({ ...col, key: String(col.indice) })),
      alOrdenar: aplicarDom,
    });

    function aplicarDom() {
      const estado = instancia.estado();
      if (!tbody || estado.key === null) return;
      const indice = Number(estado.key);
      const cmp = comparar(estado.tipo, estado.dir);
      Array.from(tbody.querySelectorAll(":scope > tr"))
        .map((tr, i) => ({
          tr,
          i,
          valor: tr.cells[indice] ? tr.cells[indice].textContent.trim() : "",
        }))
        .sort((a, b) => cmp(a.valor, b.valor) || a.i - b.i)
        .forEach((fila) => tbody.appendChild(fila.tr));
      if (typeof indiceNumeracion === "number") {
        Array.from(tbody.querySelectorAll(":scope > tr")).forEach((tr, i) => {
          const celda = tr.cells[indiceNumeracion];
          if (celda && celda.colSpan === 1) {
            celda.textContent = i + 1;
          }
        });
      }
    }

    return instancia;
  }

  global.GestionTabla = { ordenable, ordenableDom };
})(window);
