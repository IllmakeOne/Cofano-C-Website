package nl.utwente.di14.Cofano_C.dao;



import java.sql.Connection;
import java.sql.DriverManager;
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
	
//	public static List<Application> getAllApps(){
//
//		ArrayList<Application> result = new ArrayList<>(); 
//		Application add = new Application();
//		String query = "SELECT * " +
//				"FROM application";
//		
//		try {
//		PreparedStatement statement = (PreparedStatement) con.prepareStatement(query);
//		
//		ResultSet resultSet = statement.executeQuery();
//		
//		while(resultSet.next()) {
//			//System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3));
//			add = new Application();
//			add.setName(resultSet.getString(1));
//			add.setAPIKey((Integer) resultSet.getInt(2));
//			add.setID(resultSet.getInt(3));
//			
//			result.add(add);
//			}
//		} catch (SQLException e) {
//			System.err.println("Could not retrive all apps" + e);
//		}
//	
//		return result;
//	}
	
	
	

	

}
