package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Empleado;
import modelo.dao.EmpleadoDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet implementation class EmpleadoControlador
 */
@WebServlet("/EmpleadoControlador")
public class EmpleadoControlador extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EmpleadoDAO empleadoDAO = new EmpleadoDAO();
	private final String pagListar = "/vista/listar.jsp";
	private final String pagNuevo = "/vista/nuevo.jsp";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EmpleadoControlador() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accion = request.getParameter("accion");
		if(accion == null) accion = "listar";
		
		try {
			switch (accion) {
			case "listar": listar(request, response); break;
			case "nuevo": nuevo(request, response); break;
			case "guardar": guardar(request, response); break;
			case "editar": editar(request, response); break;
			case "eliminar": eliminar(request, response); break;
			default: throw new AssertionError();
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
		}
	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			if (empleadoDAO.eliminar(id) > 0) {
				request.getSession().setAttribute("success", "Empleado con id " + id + " eliminado");
			}else {
				request.getSession().setAttribute("error", "No se pudo eliminar el empleado");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("error", "ID inválido");
		}
		response.sendRedirect("EmpleadoControlador?accion=listar");
	}

	private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			Empleado objEmpleado = empleadoDAO.buscarPorId(id);
			if (objEmpleado != null) {
				request.setAttribute("empleado", objEmpleado);
				request.getRequestDispatcher(pagNuevo).forward(request, response);
			}else {
				throw new Exception("No existe");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("error", "Empleado no encontrado");
			response.sendRedirect("EmpleadoControlador?accion=listar");
		}
	}

	private void guardar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Empleado obj = new Empleado();
			obj.setId(Integer.parseInt(request.getParameter("id")));
			obj.setNombre(request.getParameter("nombre"));
			obj.setApellido(request.getParameter("apellido"));
			obj.setFechaIngreso(request.getParameter("fechaIngreso"));
			obj.setSueldo(Double.parseDouble(request.getParameter("sueldo")));

			int result = (obj.getId() == 0) ? empleadoDAO.registrar(obj) : empleadoDAO.editar(obj);

			if (result > 0) {
				request.getSession().setAttribute("success", "Datos guardados");
				response.sendRedirect("EmpleadoControlador?accion=listar");
			} else {
				request.setAttribute("error", "No se pudo completar la operación");
				request.setAttribute("empleado", obj);
				request.getRequestDispatcher(pagNuevo).forward(request, response);
			}
		} catch (NumberFormatException e) {
			request.getSession().setAttribute("error", "Error en el formato de los datos numéricos");
			response.sendRedirect("EmpleadoControlador?accion=listar");
		}
	}
	
	protected void listar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { 
		String textoBusqueda = request.getParameter("txtBuscar");
		String formato = request.getParameter("format");
		
		List<Empleado> lista;
		if (textoBusqueda != null && !textoBusqueda.trim().isEmpty()) {
			lista = empleadoDAO.buscarPorNombreOApellido(textoBusqueda);
		}else {
			lista = empleadoDAO.ListarTodos();
		}
		
		if("json".equals(formato)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			try (PrintWriter out = response.getWriter()){
				out.print(convertirAJsonManual(lista));
				out.flush();
			}
		}else {
			request.setAttribute("empleados", lista);
			request.getRequestDispatcher(pagListar).forward(request, response);
			System.out.println("Listar todos: " + lista);
		}
	}
	
	private void nuevo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("empleado", new Empleado());
		request.getRequestDispatcher(pagNuevo).forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	private String convertirAJsonManual(List<Empleado> lista) {
		StringBuilder sb = new StringBuilder("[");
		for (int i = 0; i < lista.size(); i++) {
			Empleado e = lista.get(i);
			sb.append(String.format(
					"{\"id\":%d, \"nombre\":\"%s\", \"apellido\":\"%s\", \"fechaIngreso\":\"%s\", \"sueldo\":%.2f}", 
					e.getId(), e.getNombre(), e.getApellido(), e.getFechaIngreso(), e.getSueldo()
			));
			if(i < lista.size() - 1) sb.append(",");
		}
		sb.append("]");
		return sb.toString();
	}
}
