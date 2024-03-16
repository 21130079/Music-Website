package database;

import java.sql.*;

public class fileUtils {
	public static Connection connectDb() {
		String url = "jdbc:sqlserver://localhost:1433;database=MusicWeb;user=21130079;password=21130079;encrypt=true;trustServerCertificate=true;";
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection connection = DriverManager.getConnection(url);
			return connection;
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println("fail");
		}
		return null;

	}

	public static void main(String[] args) {
		Connection connection = connectDb();
		
	}
}
