package nl.utwente.di14.Cofano_C.resources;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.*;
import org.glassfish.jersey.servlet.ServletContainer;

import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;


//@WebFilter(value = "/applications/*", initParams = @WebInitParam(name = "javax.ws.rs.Application", value = "javax.ws.rs.Application"))

@Path("/applications")

public class ApplicationsResource extends ServletContainer {

	
	private String myname = "Application";
	
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(Application input, @Context HttpServletRequest request) {
		Tables.start();

		String doer = Tables.testRequste(request);
		
		//tests if the person is allowed to make any modificaitons
		if(request.getSession().getAttribute("userEmail")!=null){
			String title = "ADD";
			
			//if there is no conflict
			if(testConflict(input) == false) {
					Tables.addHistoryEntry(title, doer, input.toString()
					, new Timestamp(System.currentTimeMillis()), myname );
		
		
					//System.out.println("Received from client request " +input.toString());
		
					String query ="SELECT addapplications(?,?)";
		
					//System.out.println(query);
		
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
			} else {
				//TODO
				//waht happends hwne there is a conflict
			}
		}
	}
	
	
	@DELETE
	@Path("/{appid}")
	public void deleteApp(@PathParam("appid") int appid, @Context HttpServletRequest request) {
		Tables.start();
		
		//retrive the App about to be deleted
		if(request.getSession().getAttribute("userEmail")!=null){
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
			String doer = Tables.testRequste(request);
	//		Tables.addHistoryEntry(title, doer,
	//				add.toString()
	//				, new Timestamp(System.currentTimeMillis()),myname );
			//Tables.addHistoryEntry(title, doer, add.toString(),myname,);
				query ="SELECT deleteapplications(?)";
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
	}


	@GET
	@Path("/{appid}")
	@Produces(MediaType.APPLICATION_JSON)
	public Application getApp(@PathParam("appid") int appid, @Context HttpServletRequest request) {
		Application app = new Application();
		String query = "SELECT * FROM application WHERE aid = ?";

		if(request.getSession().getAttribute("userEmail")!=null){
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				statement.setInt(1, appid);
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					app.setName(resultSet.getString(2));
					app.setAPIKey( resultSet.getString(3));
					app.setID(resultSet.getInt(1));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}


		return app;
	}

	@PUT
	@Path("/{appid}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateApp(@PathParam("appid") int appid, Application app,@Context HttpServletRequest request) {

		if(request.getSession().getAttribute("userEmail")!=null){
			String query = "SELECT editapplications(?,?,?)";
			try {
				PreparedStatement statement = Tables.getCon().prepareStatement(query);
				statement.setString(2, app.getName());
				statement.setString(3, app.getAPIKey());
				statement.setInt(1, appid);
				statement.executeQuery();
	
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
	
	
	
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public List<Application> getAllApps(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Application> result = new ArrayList<>();
		
		if(request.getSession().getAttribute("userEmail")!=null) {
		
			//System.out.println("acces granted to "+
		//(String)request.getSession().getAttribute("userEmail"));
		
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
		}
		return result;
	}
	
	
	
	public boolean testConflict(Application test) {
		boolean result = true;
		String query = "SELECT * FROM appsconflict(?,?)";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getName());
		statement.setString(2, test.getAPIKey());
		ResultSet resultSet = statement.executeQuery();
			
		if(!resultSet.next()) {
			result = false;
		} else {
			result = true;
		}
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}
		
	
	

}



