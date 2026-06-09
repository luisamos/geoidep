(function (global) {
  function comparar(tipo, dir) {
    const factor = dir === "desc" ? -1 : 1;
    return (a, b) => {
      const va = a ?? "";
      const vb = b ?? "";
      if (va === "" && vb !== "") return 1;
      if (vb === "" && va !== "") return -1;
      if (va === "" && vb === "") return 0;
      if (tipo === "number") return (Number(va) - Number(vb)) * factor;
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

  global.GestionTabla = { ordenable };
})(window);
