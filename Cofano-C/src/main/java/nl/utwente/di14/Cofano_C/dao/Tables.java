package nl.utwente.di14.Cofano_C.dao;



import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Tables {
	
	private static String host = "farm05.ewi.utwente.nl";
	private static String dbName = "docker";
	private static String url = "jdbc:postgresql://" + host + ":7028/" + dbName;
	private static Connection con;
	
	
	/*
	 * start the connection
	 */
	public static boolean start() {
		
		try {
			Class.forName("org.postgresql.Driver");
			con = DriverManager.getConnection(url, "docker", "YsLxCu0I1");
			}
			catch (ClassNotFoundException cnfe) {
			System.err.println("Error loading driver: " + cnfe);
			}
			catch (SQLException e) {
				System.err.println("error loading DB" + e);
			}
		
		return true;
	}
	
	/*
	 * closes down the connection
	 */
	public static void shutDown() {
		try {
			if(con != null) {
				con.close();
			}
		} catch (Exception e) {
			System.err.println("could not shut donw safely");
		}
	}
	
	
	public static Connection getCon() {
		return con;
	}
	
	
	public static void addHistoryEntry(String title, String who, String message, Timestamp timestamp) {
		
		String query ="INSERT INTO history(title,message,added_at) VALUES(?,?,?)";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, title);
			statement.setString(2, who+" " + title+" " +message);
			statement.setTimestamp(3, timestamp);
			statement.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Could not add application IN Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
	}

	
	
	

	

}
