<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
		crossorigin="anonymous">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
		integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
		crossorigin="anonymous" referrerpolicy="no-referrer" />
	<title>Gestión de Empleados</title>
</head>
<body class="container py-4">

	<header>
		<h1 class="display-5">Gestión de Empleados</h1>
		<p class="text-muted">Panel administrativo para el control de personal</p>
		<hr aria-hidden="true" />
	</header>

	<nav class="navbar navbar-light bg-light mb-4 p-3 border rounded shadow-sm d-flex flex-column flex-md-row justify-content-between align-items-center gap-3" 
		aria-label="Barra de herramientas de empleados">
		
		<form action="EmpleadoControlador" method="get" class="row g-2">
			<input type="hidden" name="accion" value="listar">
			
			<div class="col-auto">
				<label for="txtBuscar" class="visually-hidden">Buscar empleado</label>
				<div class="input-group">
					<span class="input-group-text"><i class="fa fa-search"></i></span>
					<input type="text" class="form-control" id="txtBuscar" name="txtBuscar"
							placeholder="Nombre o apellido..." value="${textoBusqueda}">
				</div>
			</div>
			
			<div class="col-auto">
				<button type="submit" class="btn btn-primary">Buscar</button>
				<a href="EmpleadoControlador?accion=listar" class="btn btn-outline-secondary">Limpiar</a>
			</div>
		</form>
		
		<a href="EmpleadoControlador?accion=nuevo"
			class="btn btn-success btn-sm"> 
			<i class="fa fa-plus-circle" aria-hidden="true"></i> Nuevo Empleado
		</a>
	</nav>

	<aside aria-live="polite" class="mb-3">
		<jsp:include page="../components/mensaje.jsp"></jsp:include>
	</aside>

	<main>
		<section class="table-responsive">
			<table class="table table-bordered table-striped align-middle">
				<caption class="visually-hidden">Lista de empleados
					registrados en el sistema</caption>
				<thead class="table-dark">
					<tr>
						<th scope="col">ID</th>
						<th scope="col">Nombres</th>
						<th scope="col">Apellidos</th>
						<th scope="col">Fecha de ingreso</th>
						<th scope="col">Sueldo</th>
						<th scope="col" class="text-center">Acción</th>
					</tr>
				</thead>
				
				<tbody id="tablaEmpleados">
					<c:forEach items="${empleados}" var="item">
						<tr>
							<td>${item.id}</td>
							<td>${item.nombre}</td>
							<td>${item.apellido}</td>
							<td>${item.fechaIngreso}</td>
							<td>${item.sueldo}</td>
							<td>
								<a href="EmpleadoControlador?accion=editar&id=${item.id}"
									class="btn btn-info btn-sm" title="Editar a ${item.nombre}"
									aria-label="Editar empleado ${item.nombre}"> 
									<i class="fa fa-edit" aria-hidden="true"></i>
								</a> 
								<a href="EmpleadoControlador?accion=eliminar&id=${item.id}"
									onclick="return confirm('Esta seguro que desea eliminar el empleado con id ${item.id}')"
									class="btn btn-danger btn-sm"
									title="Eliminar a ${item.nombre}"> 
									<i class="fa fa-trash" aria-hidden="true"></i>
								</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empleados.size() == 0}">
						<tr>
							<td colspan="6" class="text-center py-4"><i
								class="fa fa-info-circle"></i> No hay registros</td>
						</tr>
					</c:if>
				</tbody>
				
			</table>
		</section>
	</main>

	<footer class="text-center mt-4 text-muted">
		<address>
			<small>&copy; 2026 Sistema de RRHH - Versión 1.0</small>
		</address>
    </footer>

	<script>
		// Esperar a que el DOM esté cargado
		document.addEventListener("DOMContentLoaded", function() {
			// Seleccionar todas las alertas que tengan la clase .alert
			const alertas = document.querySelectorAll('.alert');

			alertas.forEach(function(alerta) {
				// Configurar un temporizador de 4000ms (4 segundos)
				setTimeout(function() {
					// Usar la API de Bootstrap para cerrar la alerta con animación
					const bsAlert = new bootstrap.Alert(alerta);
					bsAlert.close();
				}, 4000);
			});
		});
	</script>
	
	<script>
		document.addEventListener("DOMContentLoaded", () => {
	    const inputBuscar = document.getElementById("txtBuscar");
	    const tablaBody = document.getElementById("tablaEmpleados");
	    let timeout = null;
	
	    inputBuscar.addEventListener("input", () => {
	        // Limpiar el temporizador previo (Debounce)
	        clearTimeout(timeout);
	
	        timeout = setTimeout(() => {
	            const valor = inputBuscar.value;
	            
	            // Llamada asíncrona al Servlet pidiendo formato JSON
	            fetch(`EmpleadoControlador?accion=listar&format=json&txtBuscar=` + encodeURIComponent(valor))
	                .then(response => {
	                    if (!response.ok) throw new Error('Error en la red');
	                    return response.json();
	                })
	                .then(data => {
	                    actualizarTabla(data);
	                })
	                .catch(error => console.error("Error:", error));
	        }, 300); // Espera 300ms después de que el usuario deja de escribir
	    });
	
	    function actualizarTabla(empleados) {
	        tablaBody.innerHTML = ""; // Limpiar tabla actual
	
	        if (empleados.length === 0) {
	            tablaBody.innerHTML = '<tr><td colspan="6" class="text-center">No se encontraron resultados</td></tr>';
	            return;
	        }
	
	        empleados.forEach(emp => {
	            const fila = `
	                <tr>
	                    <td>${emp.id}</td>
	                    <td>${emp.nombre}</td>
	                    <td>${emp.apellido}</td>
	                    <td>${emp.fechaIngreso}</td>
	                    <td>${emp.sueldo.toFixed(2)}</td>
	                    <td>
	                        <a href="EmpleadoControlador?accion=editar&id=${emp.id}" class="btn btn-info btn-sm"><i class="fa fa-edit"></i></a>
	                        <a href="EmpleadoControlador?accion=eliminar&id=${emp.id}" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar?')"><i class="fa fa-trash"></i></a>
	                    </td>
	                </tr>`;
	            tablaBody.innerHTML += fila;
	        });
	    }
	});
	</script>
</body>
</html>