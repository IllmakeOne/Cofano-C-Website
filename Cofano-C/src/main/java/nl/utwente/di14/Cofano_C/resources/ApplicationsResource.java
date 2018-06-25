package nl.utwente.di14.Cofano_C.resources;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import nl.utwente.di14.Cofano_C.App;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.*;
import org.glassfish.jersey.servlet.ServletContainer;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;


//@WebFilter(value = "/applications/*", initParams = @WebInitParam(name = "javax.ws.rs.Application", value = "javax.ws.rs.Application"))

@Path("/applications")

public class ApplicationsResource extends ServletContainer {

	
	private String myname = "Application";
	
	
	/**
	 * this function adds an entry to the database
	 * if it is from a user it is directly added and approved
	 * if not, it is added but not approved
	 * @param input the entry about to be added
	 * @param request the request of the client
	 */
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(Application input, @Context HttpServletRequest request) {
		Tables.start();

		String doer = Tables.testRequest(request);
		
		//tests if the person is allowed to make any modificaitons
		if(request.getSession().getAttribute("userEmail")!=null){
			String title = "ADD";
			
			if(testConflict(input) == false) {
				//if there is no conflict
					Tables.addHistoryEntry(title, doer, input.toString()
					, new Timestamp(System.currentTimeMillis()), myname );
		
					String query ="SELECT addapplications(?,?)";
					try {
						PreparedStatement statement = Tables.getCon().prepareStatement(query);
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
	
	/**
	 * this method deletes an entry from a table and also adds it to history
	 * @param appid the ID of the entry which is deleted
	 */
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
					add.setId(resultSet.getInt(1));
					}
				} catch (SQLException e) {
					System.err.println("Coulnd retrive app about to be deleted" + e);
				}
			//add the deletion to the history table
			String title = "DELETE";
			String doer = Tables.testRequest(request);
			Tables.addHistoryEntry(title, doer, add.toString(), myname, true);
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


	/**
	 * this method retrives a specific entry from the DB
	 * @param appid
	 * @return return the entry as an Application object
	 */
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
					app.setId(resultSet.getInt(1));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}


		return app;
	}

	/**
	 * this method changes an entry in the database
	 * @param appid the ID of the entry about to be changed
	 * @param app the new information for the entry
	 */
	@PUT
	@Path("/{appid}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateApp(@PathParam("appid") int appid, Application app,@Context HttpServletRequest request) {

		Application aux = getApp(appid, request);
		
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
		
		Tables.addHistoryEntry("UPDATE", Tables.testRequest(request), aux.toString()+ " -->" +app.toString(), myname, false);

	}
	
	
	/**
	 * This is used for displaying unapproved entries, which await deletion or approval
	 * this method only returns something if the request is comming from our website
	 * @return an JSON array of unapproved entries
	 */
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public List<Application> getAllApps(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Application> result = new ArrayList<>();
		
		if(request.getSession().getAttribute("userEmail")!=null) {
		
			Application add = new Application();
			String query = "SELECT * FROM application";
	
			try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
	
			ResultSet resultSet = statement.executeQuery();
	
			while(resultSet.next()) {
				//System.out.println(resultSet.getString(1));
				add = new Application();
				add.setName(resultSet.getString(2));
				add.setAPIKey( resultSet.getString(3));
				add.setId(resultSet.getInt(1));
	
				result.add(add);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrive all apps" + e);
			}
		}
		return result;
	}
	
	
	/**
	 * this tests if there a new Application creates a conflict in the DB if it is added
	 * it creates a conflict if the name or apikey is the same as another entry in the DB
	 * @param test the Application which is tested 
	 * @return the id of the port it is on conflict with , or 0 if there is no conflict
	 */
	public boolean testConflict(Application test) {
		boolean result = true;
		String query = "SELECT * FROM appsconflict(?,?)";
		
		try {
		PreparedStatement statement = Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getName());
		statement.setString(2, test.getAPIKey());
		ResultSet resultSet = statement.executeQuery();

            result = resultSet.next();
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}
		
	
	

}



