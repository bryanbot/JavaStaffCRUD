document.addEventListener("DOMContentLoaded", function() {
    var inputBuscar = document.getElementById("txtBuscar");
    var tablaBody = document.getElementById("tablaEmpleados");
    var timeout = null;

    var form = inputBuscar.closest('form');
    if(form) {
        form.addEventListener("submit", function(e) { e.preventDefault(); });
    }
    
    inputBuscar.addEventListener("input", function() {
        clearTimeout(timeout);
        timeout = setTimeout(function() {
            var valor = inputBuscar.value.trim();
            fetch("EmpleadoControlador?accion=listar&format=json&txtBuscar=" + encodeURIComponent(valor))
                .then(function(response) { return response.json(); })
                .then(function(data) { renderizarTabla(data); })
                .catch(function(error) { console.error("Error:", error); });
        }, 300);
    });

    function renderizarTabla(empleados, query) {
        tablaBody.innerHTML = ""; 
        if (empleados.length === 0) {
            tablaBody.innerHTML = '<tr><td colspan="6" class="text-center py-4">Sin resultados</td></tr>';
            return;
        }
        for (var i = 0; i < empleados.length; i++) {
            var emp = empleados[i];
            var fila = '<tr>' +
                '<td>' + emp.id + '</td>' +
                '<td>' + emp.nombre + '</td>' +
                '<td>' + emp.apellido + '</td>' +
                '<td>' + emp.fechaIngreso + '</td>' +
                '<td>' + emp.sueldo.toFixed(2) + '</td>' +
                '<td>' +
                    '<a href="EmpleadoControlador?accion=editar&id=' + emp.id + '" class="btn btn-info btn-sm"><i class="fa fa-edit"></i></a> ' +
                    '<a href="EmpleadoControlador?accion=eliminar&id=' + emp.id + '" class="btn btn-danger btn-sm" onclick="return confirm(\'¿Eliminar?\')"><i class="fa fa-trash"></i></a>' +
                '</td>' +
            '</tr>';
            tablaBody.innerHTML += fila;
        }
    }
});