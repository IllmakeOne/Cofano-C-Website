package nl.utwente.di14.Cofano_C.dao;



import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.postgresql.util.PGobject;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
			System.err.println("Could not add hisotry IN Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		
		resetLastlogin(who);
	}
	
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
			System.err.println("Could not add hisotry IN Tables");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		
		resetLastlogin(who);
	}

	
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
	
	public static String testRequste(HttpServletRequest request) {
		String result = "";
		String user ="";
		if(request.getSession().getAttribute("userEmail")!=null) {
			return (String)request.getSession().getAttribute("userEmail");
		} else if(request.getHeader("Authorization")!= null) {
			user = request.getHeader("Authorization");
		} else {
			//returns false if the request isnt from a google user or from an application with an Authorization header
			System.out.println("nono in the first if");
			return result;
		}
		//System.out.println(user);
		String query ="SELECT testrequest(?)";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, user);
			ResultSet rez =statement.executeQuery();
			if(rez.next()) {
				
				result = tidyup(rez.getString(1));
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
	
	
	public static String tidyup(String str) {
		String[] aux = str.split(",");
		return aux[0].substring(1)+" " +aux[1].substring(0, aux[1].length()-1);
	}
	
	
	
	public static PGobject objToPGobj(Object obj) {

		ObjectMapper mapper = new ObjectMapper();
		
		String workplis="";
		try {
			workplis = mapper.writeValueAsString(obj);
		} catch (JsonProcessingException e1) {
			System.out.println("coulnt not make from obj to json IN tables objtopgobj");
		}
		
		PGobject jsonObject = new PGobject();
		
		jsonObject.setType("json");
		try {
			jsonObject.setValue(workplis);
		} catch (SQLException e) {
			System.out.println("coulnt not make from json to PGobject IN tables objtopgobj");
		}
		
		return jsonObject;
	}

	

}
