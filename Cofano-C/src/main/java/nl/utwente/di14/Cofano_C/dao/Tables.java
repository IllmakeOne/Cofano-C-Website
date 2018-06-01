package nl.utwente.di14.Cofano_C.dao;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import nl.utwente.di14.Cofano_C.model.Application;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;


import java.util.HashMap;
import java.util.Map;

import model.*;

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
