package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
	public static final String username = "root";
    public static final String database = "bdempleado";

    public static Connection getConnection(){
        Connection cn = null;
        
        String host = System.getenv("DB_HOST");
        if (host == null) host = "localhost";
        
        String password = System.getenv("DB_PASS");
        if (password == null) password = ""; // Tu clave de Eclipse local
        
        String url = "jdbc:mysql://" + host + ":3306/" + database + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, username, password);
            System.out.println("Conexion establecida con: " + host);
        } catch (Exception e) {
        	System.err.println("Error de conexión en " + host + ": " + e.getMessage());
        }
        return cn;
    }
}
