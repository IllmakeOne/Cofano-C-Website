package nl.utwente.di14.Cofano_C.resources;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.*;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;


@Path("/applications")
public class ApplicationsResource{
	
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(Application input, @Context HttpServletRequest request) {
		Tables.start();
			
		String title = "ADD";
			
			Tables.addHistoryEntry(title, (String) request.getSession().getAttribute("userEmail"), input.toString()
			, new Timestamp(System.currentTimeMillis()));
			
			
			System.out.println("Received from client request " +input.toString());
			
			String query ="SELECT addapplications(?,?)";
			
			System.out.println(query);
			
			System.out.println("Added to database: " + "name, api_key -> "+
			input.getName()+ ","+input.getAPIKey());
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				statement.setString(1, input.getName());
				statement.setString(2, input.getAPIKey());
				
				statement.executeQuery();
			} catch (SQLException e) {
				System.err.println("Could not add application");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
	}
	
	
	
	@DELETE
	@Path("/{appid}")
	public void deleteApp(@PathParam("appid") int appid, @Context HttpServletRequest request) {
		Tables.start();
		
		//retrive the App about to be deleted
		Application add = new Application();
		String query = "SELECT * FROM application WHERE aid = ?";
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setInt(1, appid);
			ResultSet resultSet = statement.executeQuery();
			//create an application object 
			while(resultSet.next()) {
				add.setName(resultSet.getString(2));
				add.setAPIKey( resultSet.getString(3));
				add.setID(resultSet.getInt(1));
				}
			} catch (SQLException e) {
				System.err.println("Coulnd retrive app about to be deleted" + e);
			}
		//add the deletion to the history table
		String title = "DELETE";
		Tables.addHistoryEntry(title, (String) request.getSession().getAttribute("userEmail"),
				add.toString()
				, new Timestamp(System.currentTimeMillis()));
			
			query ="DELETE FROM application WHERE aid = ?";
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				statement.setLong(1, appid);
				statement.executeUpdate();
			} catch (SQLException e) {
				System.err.println("Was not able to delete APP");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
			query = "";
	}
	
	
	
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public List<Application> getAllApps(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Application> result = new ArrayList<>(); 
		Application add = new Application();
		String query = "SELECT * FROM application";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		
		ResultSet resultSet = statement.executeQuery();
		
		while(resultSet.next()) {
			//System.out.println(resultSet.getString(1));
			add = new Application();
			add.setName(resultSet.getString(2));
			add.setAPIKey( resultSet.getString(3));
			add.setID(resultSet.getInt(1));
			
			result.add(add);
			}
		} catch (SQLException e) {
			System.err.println("Could not retrive all apps" + e);
		}
	
		return result;
		
	}
	
	

}



