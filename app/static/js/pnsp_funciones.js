/*
******************************************************************************************
pnsp_funciones.js
FECHA CREACION      : 13/03/2007
FECHA ACTUALIZACION : 05/02/2016
ULTIMA ACTUALIZACION: 27/05/2024 - Modernización y correcciones de seguridad
DETALLE DE LA PAGINA: ESTA PAGINA CONTIENE EL CODIGO JAVASCRIPT A UTILIZAR EN TODO EL MÓDULO 
DE ADMINISTRACIÓN
******************************************************************************************
*/

/**
 * Valida que solo se ingresen caracteres numéricos y algunos especiales
 * @param {KeyboardEvent} evt - Evento del teclado
 * @returns {boolean} - True si la tecla es permitida
 */
function pnsp_js_valida_numero(evt) {
    const key = evt.key;

    // Teclas permitidas: números, backspace, tab, enter, punto, coma
    const teclasPermitidas = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
        'Backspace', 'Tab', 'Enter', '.', ','];

    return teclasPermitidas.includes(key);
}

function pnsp_js_validar_input_numerico(input) {
    // Permite números, punto y coma, pero valida el formato completo
    input.value = input.value.replace(/[^0-9.,]/g, '');

    // Opcional: Validar que solo haya un punto o coma decimal
    const decimalCount = (input.value.match(/[.,]/g) || []).length;
    if (decimalCount > 1) {
        input.value = input.value.slice(0, -1);
    }
}

/**
 * Redirige a la página de detalle del catálogo
 * @param {number|string} Codigo_Catalogo - ID del catálogo
 * @param {number|string} Codigo_Entidad - ID de la entidad
 */
function pnsp_js_detalle_catalogo(Codigo_Catalogo, Codigo_Entidad) {
    if (!Codigo_Catalogo || !Codigo_Entidad) {
        console.error('Parámetros inválidos para detalle de catálogo');
        return;
    }

    const form = document.getElementById('frm_datos_catalogo');
    if (!form) {
        console.error('Formulario no encontrado: frm_datos_catalogo');
        return;
    }

    const sanitizeInput = (value) => {
        if (typeof value === 'string') {
            return value.replace(/[<>]/g, '');
        }
        return value;
    };

    try {
        form.querySelector('input[name="id_catalogo"]').value = sanitizeInput(Codigo_Catalogo);
        form.querySelector('input[name="id_entidad"]').value = sanitizeInput(Codigo_Entidad);
        form.action = "../catalogo/catalogo_detalle.aspx";
        form.submit();
    } catch (error) {
        console.error('Error al enviar formulario:', error);
    }
}

/**
 * Envía el formulario de búsqueda de catálogo
 */
function pnsp_js_buscar_catalogo() {
    const form = document.getElementById('frm_buscar_catalogo');
    if (!form) {
        console.error('Formulario no encontrado: frm_buscar_catalogo');
        return;
    }

    form.action = "../catalogo/catalogo_servicios.aspx";
    form.submit();
}

/**
 * Lista catálogo por sectores
 * @param {number|string} id - ID del sector
 */
function pnsp_js_listado_catalogo_sectores(id) {
    if (!id) {
        console.error('ID de sector no proporcionado');
        return;
    }

    const form = document.getElementById('frm_buscar_catalogo_sector');
    if (!form) {
        console.error('Formulario no encontrado: frm_buscar_catalogo_sector');
        return;
    }

    const sanitizedId = String(id).replace(/[^0-9]/g, '');

    let input = form.querySelector('input[name="codigo_sector"]');
    if (!input) {
        input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'codigo_sector';
        input.id = 'codigo_sector';
        form.appendChild(input);
    }

    input.value = sanitizedId;
    form.action = "../catalogo/catalogo_sectores.aspx?codigo_sector="+id;
    form.method = "post";

    try {
        form.submit();
    } catch (error) {
        console.error('Error al enviar formulario sector:', error);
    }
}

function pnsp_js_sanitize_input(input) {
    if (typeof input !== 'string') return input;
    return input.replace(/[<>&"']/g, '');
}

window.addEventListener('error', function (e) {
    console.error('Error global capturado:', e.error);
    // Aquí podrías enviar el error a un servicio de logging
});

if (!String.prototype.includes) {
    String.prototype.includes = function (search, start) {
        if (typeof start !== 'number') {
            start = 0;
        }
        if (start + search.length > this.length) {
            return false;
        }
        return this.indexOf(search, start) !== -1;
    };
}