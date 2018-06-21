package nl.utwente.di14.Cofano_C.dao;



import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * This class is the Data Access Object for all the database tables.
 * It is also responsible for creating history entries and recording when a user last made a change in the system.
 */
public class Tables {

	private static String host = "farm05.ewi.utwente.nl";
	private static String dbName = "docker";
	private static String url = "jdbc:postgresql://" + host + ":7028/" + dbName;
	private static Connection con;


    /**
     * This method starts a connections to the database using PostgreSQL drivers.
     * @return true if a connection was established.
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

    /**
     * Shuts down the connection in a safe manner.
     */
	public static void shutDown() {
		try {
			if(con != null) {
				con.close();
			}
		} catch (Exception e) {
			System.err.println("could not shut down safely");
		}
	}


    /**
     * Getter for the conneciton
     * @return the current<code>Connection</code>
     */
    public static Connection getCon() {
		return con;
	}


    /**
     * Method for adding an entry to the history table
     * @param title Contains the type of change (ADD, DELETE etc.)
     * @param who user or application that made the change
     * @param message The information that was changed
     * @param timestamp The time of change
     * @param type The name of the table where a change was made
     */
    public static void addHistoryEntry(String title, String who, String message, Timestamp timestamp, String type) {

		String query ="SELECT addhistory(?,?,?,?)";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, title);
			statement.setString(2, who+" " + title+" " +message);
			statement.setTimestamp(3, timestamp);
			statement.setString(4, type);
			statement.executeQuery();
			//ResultSet result= statement.executeQuery();
		} catch (SQLException e) {
			System.err.println("Could not add history in Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}

		resetLastlogin(who);
	}

    /**
     * Method for adding an entry to the history table without providing a timestamp
     * @param title Contains the type of change (ADD, DELETE etc.)
     * @param who user or application that made the change
     * @param message The information that was changed
     * @param type The name of the table where a change was made
     */
    public static void addHistoryEntry(String title, String who, String message, String type) {

		String query ="SELECT addhistory(?,?,?)";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, title);
			statement.setString(2, who+" " + title+" " +message);
			statement.setString(3, type);
			statement.executeQuery();
			//ResultSet result= statement.executeQuery();
		} catch (SQLException e) {
			System.err.println("Could not add history in Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}

		resetLastlogin(who);
	}


    /**
     * Updates the users last login timestamp
     * @param user The user who's last login should be updated
     */
    public static void resetLastlogin(String user) {

		String query ="SELECT updatelastlogin(?)";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, user);
			statement.executeQuery();
		} catch (SQLException e) {
			System.err.println("Could not update last login IN Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}

	}

    /**
     * Check if the request is valid. I.e. check if it's either a valid Google user or a valid API.
     * @param request the <code>HttpServletRequest</code> to be checked
     * @return the name of the API of the request was from an API
     */
    public static String testRequest(HttpServletRequest request) {
		String result = "";
		String user ="";
		if(request.getSession().getAttribute("userEmail")!=null) {
			return (String)request.getSession().getAttribute("userEmail");
		} else if(request.getHeader("Authorization")!= null) {
			user = request.getHeader("Authorization");
		} else {
			//returns false if the request isn't from a google user or from an application with an Authorization header
			System.out.println("nono in the first if");
			return result;
		}
		//System.out.println(request);
		String query ="SELECT testrequest(?)";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, user);
			ResultSet rez =statement.executeQuery();
			if(rez.next()) {
				result = rez.getString(1);
			}

		} catch (SQLException e) {
			System.err.println("Could test request IN Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		//System.out.println("at the end "+ result);
		return result;
	}

//	public static String decideName(HttpServletRequest request) {
//		String stringy ="";
//		if(request.getSession().getAttribute("userEmail")!=null) {
//			stringy = (String)request.getSession().getAttribute("userEmail") ;
//		} else if(request.getHeader("Authorization")!= null) {
//			stringy = request.getHeader("Authorization");
//		}
//
//		return stringy;
//	}





}
