package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.Conexion;
import modelo.Empleado;

public class EmpleadoDAO {
	
	private static final String SQL_BUSCAR = "SELECT * FROM empleado WHERE nombres LIKE ? OR apellidos LIKE ?";
	
	public ArrayList<Empleado> ListarTodos() {
		ArrayList<Empleado> listaEmpleado = new ArrayList<>();

		String sql = "select * from empleado";

		try (Connection cn = Conexion.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				listaEmpleado.add(mapearEmpleado(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listaEmpleado;
	}

	public int registrar(Empleado obj) {
		int result = 0;
		String sql = "insert into empleado (nombres, apellidos, fecha_ingreso, sueldo)" + " values (?,?,?,?)";

		try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setString(1, obj.getNombre());
			ps.setString(2, obj.getApellido());
			ps.setString(3, obj.getFechaIngreso());
			ps.setDouble(4, obj.getSueldo());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int editar(Empleado obj) {
		int result = 0;
		String sql = "update empleado set nombres = ?, apellidos = ?, fecha_ingreso = ?, sueldo = ? where id = ?";

		try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			
			ps.setString(1, obj.getNombre());
			ps.setString(2, obj.getApellido());
			ps.setString(3, obj.getFechaIngreso());
			ps.setDouble(4, obj.getSueldo());
			ps.setInt(5, obj.getId());
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int eliminar(int id) {
		int result = 0;
		String sql = "delete from empleado where id = ?";

		try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			
			ps.setInt(1, id);
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public Empleado buscarPorId(int id) {
		Empleado objEmpleado = null;

		String sql = "select * from empleado where id = ?";

		try (Connection cn = Conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				objEmpleado = mapearEmpleado(rs);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return objEmpleado;
	}
	
	public List<Empleado> buscarPorNombreOApellido(String texto) {
		List<Empleado> lista = new ArrayList<>();
		String query = "%" + texto + "%";
		
		try (Connection cn = Conexion.getConnection();
			PreparedStatement ps = cn.prepareStatement(SQL_BUSCAR)){
			
			ps.setString(1, query);
			ps.setString(2, query);
			
			try (ResultSet rs = ps.executeQuery()){
				while (rs.next()) {
					lista.add(mapearEmpleado(rs));
				}
			}
		} catch (Exception e) {
			System.err.println("Error en búsqueda: " + e.getMessage());
		}
		
		return lista;
	}
	
	public Empleado mapearEmpleado(ResultSet rs) throws SQLException {
		Empleado emp = new Empleado();
		emp.setId(rs.getInt("id"));
		emp.setNombre(rs.getString("nombres"));
		emp.setApellido(rs.getString("apellidos"));
		emp.setFechaIngreso(rs.getString("fecha_ingreso"));
		emp.setSueldo(rs.getDouble("sueldo"));
		return emp;
	}
}
