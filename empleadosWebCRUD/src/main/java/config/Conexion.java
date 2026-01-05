package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
	public static final String username = "root";
    public static final String password = "";
    public static final String database = "bdempleado";
    public static final String url = "jdbc:mysql://localhost:3306/" + database;

    public static Connection getConnection(){
        Connection cn = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, username, password);
            System.out.println("Conexion establecida");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cn;
    }
}
