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
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
		integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
		crossorigin="anonymous" referrerpolicy="no-referrer" />
	<title>${empleado.id == 0 ? "Nuevo" : "Editar"} Empleado</title>
</head>
<body class="bg-light">
	<main class="container py-5">
		<section class="row justify-content-center">
			<div class="col-md-8 col-lg-6">
				<article class="card shadow">
					<header class="card-header bg-primary text-white py-3">
						<h1 class="h4 mb-0">
							<i class="fa ${empleado.id == 0 ? 'fa-user-plus' : 'fa-user-edit'}" aria-hidden="true"></i>
							${empleado.id == 0 ? "Nuevo":"Editar"} empleado
						</h1>
					</header>
					
					<section class="card-body p-4">
						<form action="EmpleadoControlador" method="post">
							<fieldset>
								<legend class="visually-hidden">Información del Empleado</legend>
								
								<div class="mb-3">
									<label for="txtNombre" class="form-label fw-bold">Nombres</label> 
									<input id="txtNombre" 
											value="${empleado.nombre}" 
											name="nombre" 
											type="text" 
											maxlength="50" 
											class="form-control" 
											pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$" 
											title="El nombre solo debe contener letras" 
											required="" 
											placeholder="Ingrese nombres completos">
								</div>
								
								<div class="mb-3">
									<label for="txtApellido" class="form-label fw-bold">Apellidos</label> 
									<input id="txtApellido" 
											value="${empleado.apellido}" 
											name="apellido" 
											type="text" 
											maxlength="50" 
											class="form-control" 
											pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$" 
											title="El apellido solo debe contener letras"	
											required="" 
											placeholder="Ingrese apellidos completos">
								</div>
								
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="dateIngreso" class="form-label fw-bold">Fecha de Ingreso</label> 
										<input id="dateIngreso" value="${empleado.fechaIngreso}" name="fechaIngreso" type="date" class="form-control" required="">
									</div>
									
									<div class="col-md-6 mb-3">
										<label for="numSueldo" class="form-label fw-bold">Sueldo</label>
										<div class="input-group">
											<span class="input-group-text" id="currency-addon">$</span>
											<input inputmode="decimal" id="numSueldo" value="${empleado.sueldo}" name="sueldo" type="number" class="form-control" required="" step="0.01" min="0" aria-describedby="currency-addon">
										</div>
									</div>
								</div>
							</fieldset>
							
							<input type="hidden" name="id" value="${empleado.id}">
							<input type="hidden" name="accion" value="guardar">
							
							<footer class="d-flex justify-content-end gap-2 mt-4">
								<a href="EmpleadoControlador?accion=listar"
									class="btn btn-outline-secondary">
									<i class="fa fa-arrow-left" aria-hidden="true"></i>Volver atrás
								</a>
								<button type="submit" class="btn btn-primary px-4">
									<i class="fa fa-save" aria-hidden="true"></i> Guardar cambios
								</button>
							</footer>
						</form>
					</section>
				</article>
			</div>
		</section>
	</main>
	<footer class="text-center mt-4 text-muted">
		<address>
			<small>&copy; 2026 Sistema de RRHH - Versión 1.0</small>
		</address>
    </footer>
</body>
</html>