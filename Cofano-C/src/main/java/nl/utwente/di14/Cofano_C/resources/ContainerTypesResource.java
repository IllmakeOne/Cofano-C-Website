package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Application;
import nl.utwente.di14.Cofano_C.model.ContainerType;
import nl.utwente.di14.Cofano_C.model.Port;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/containers")
public class ContainerTypesResource {

	private String myname= "container_type";
	
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<ContainerType> getAllContainerTypes(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<ContainerType> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM container_type "+
				"WHERE approved = true";
		
		String name = Tables.testRequste(request);
		if(!name.equals("")) {
	
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					
					ContainerType container = new ContainerType();
					container.setDisplayName(resultSet.getString("display_name"));
					container.setID(resultSet.getInt("cid"));
					container.setIsoCode(resultSet.getString("iso_code"));
					container.setDescription(resultSet.getString("description"));
					container.setLength(resultSet.getInt("c_length"));
					container.setHeight(resultSet.getInt("c_height"));
					container.setReefer(resultSet.getBoolean("reefer"));
	
					result.add(container);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all containers" + e);
			}
		}

		return result;

	}
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(ContainerType input, @Context HttpServletRequest request) {
		Tables.start();
		
		
		int ownID = 0;
		String title = "ADD";
		String doer = Tables.testRequste(request);

		int con = testConflict(input);
		
		
		if(request.getSession().getAttribute("userEmail")!=null && con == 0 ) {
			//if its from a cofano employee and it doesnt create conflcit, add straight to db
			ownID = addEntry(input,true);
			Tables.addHistoryEntry(title, doer, input.toString(),myname,true);
		} else if(request.getSession().getAttribute("userEmail")!=null && con != 0 ) {
			//if its froma cofano emplyee and it create sconflcit, add but unapproved
			ownID = addEntry(input,false);

			Tables.addHistoryEntry(title, doer, input.toString(),myname,false);
		} else if(!doer.equals("")) {
			//if its from an api add to unapproved
			ownID = addEntry(input,false);
			Tables.addHistoryEntry(title, doer, input.toString(),myname,false);
		}
		
		if(con != 0) {
			//if it creates a conflcit, add it to conflict table
			Tables.addtoConflicts(myname, doer, ownID, con);
			//add to history
			Tables.addHistoryEntry("CON", doer, ownID + " " + input.toString()+" con with "+con,myname,false);
		}
		
		
	}
	
	public int addEntry(ContainerType entry, boolean app) {
		String query = "SELECT addcontainer_type(?,?,?,?,?,?,?)";
		int rez =0;
		//gets here if the request is from API
		//add to conflicts table
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(1, entry.getDisplayName());
			statement.setString(2,entry.getIsoCode());
			statement.setString(3, entry.getDescription());
			statement.setInt(4, entry.getLength());
			statement.setInt(5, entry.getHeight());
			statement.setBoolean(6, entry.getReefer());
			statement.setBoolean(7, app);
			
			ResultSet res = statement.executeQuery();			
			res.next();
			rez = res.getInt(1);
		} catch (SQLException e) {
			System.err.println("Could not add container types ");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		return rez;
	}
			
	@DELETE
	@Path("/{appid}")
	public void deleteContainer(@PathParam("appid") int appid, @Context HttpServletRequest request) {
		Tables.start();
		
		//retrive the App about to be deleted
		if(request.getSession().getAttribute("userEmail")!=null){
			ContainerType add = new ContainerType();
			String query = "SELECT * FROM container_type WHERE aid = ?";
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				statement.setInt(1, appid);
				ResultSet resultSet = statement.executeQuery();
				//create an application object 
				while(resultSet.next()) {
					add.setDisplayName(resultSet.getString("display_name"));
					add.setID(resultSet.getInt("cid"));
					add.setIsoCode(resultSet.getString("iso_code"));
					add.setDescription(resultSet.getString("description"));
					add.setLength(resultSet.getInt("c_length"));
					add.setHeight(resultSet.getInt("c_height"));
					add.setReefer(resultSet.getBoolean("reefer"));
					}
				} catch (SQLException e) {
					System.err.println("Coulnd retrive app about to be deleted" + e);
				}
			//add the deletion to the history table
			String title = "DELETE";
			Tables.addHistoryEntry(title, Tables.testRequste(request),	add.toString(), myname, true);
				query ="SELECT deletecontainer_types(?)";
				try {
					PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
					statement.setLong(1, appid);
					statement.executeUpdate();
				} catch (SQLException e) {
					System.err.println("Was not able to delete container");
					System.err.println(e.getSQLState());
					e.printStackTrace();
				}
		}
	}
	
	@GET
	@Path("/{appid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ContainerType getContainer(@PathParam("appid") int appid, @Context HttpServletRequest request) {
		ContainerType add = new ContainerType();
		String query = "SELECT * FROM application WHERE aid = ?";

		if(request.getSession().getAttribute("userEmail")!=null){
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				statement.setInt(1, appid);
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					add.setDisplayName(resultSet.getString("display_name"));
					add.setID(resultSet.getInt("cid"));
					add.setIsoCode(resultSet.getString("iso_code"));
					add.setDescription(resultSet.getString("description"));
					add.setLength(resultSet.getInt("c_length"));
					add.setHeight(resultSet.getInt("c_height"));
					add.setReefer(resultSet.getBoolean("reefer"));
				}
			} catch (SQLException e) {
				System.err.println("could not get specific contaienr");
				e.printStackTrace();
			}
		}
		return add;
	}
	
	@PUT
	@Path("/{appid}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateContainer(@PathParam("appid") int appid, ContainerType con,@Context HttpServletRequest request) {

		ContainerType add = new ContainerType();

		if(request.getSession().getAttribute("userEmail")!=null){
			String query = "SELECT * FROM container_type WHERE aid = ?";
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				statement.setInt(1, appid);
				ResultSet resultSet = statement.executeQuery();
				//create an application object 
				while(resultSet.next()) {
					add.setDisplayName(resultSet.getString("display_name"));
					add.setID(resultSet.getInt("cid"));
					add.setIsoCode(resultSet.getString("iso_code"));
					add.setDescription(resultSet.getString("description"));
					add.setLength(resultSet.getInt("c_length"));
					add.setHeight(resultSet.getInt("c_height"));
					add.setReefer(resultSet.getBoolean("reefer"));
					}
				} catch (SQLException e) {
					System.err.println("Coulnd retrive app about to be deleted" + e);
				}
				query = "SELECT editcontainer_types(?,?,?,?,?,?)";
				try {
					PreparedStatement statement = Tables.getCon().prepareStatement(query);
					statement.setInt(1, appid);
					statement.setString(2, con.getDescription());
					statement.setString(3, con.getIsoCode());
					statement.setString(4, con.getDescription());
					statement.setInt(5, con.getHeight());
					statement.setBoolean(6, con.getReefer());
					statement.executeQuery();
		
				} catch (SQLException e) {
					e.printStackTrace();
				}
			
			Tables.addHistoryEntry("UPDATE", Tables.testRequste(request), 
					add.toString()+ " to " + con.toString(), myname, true);
		}

	}


	public int testConflict(ContainerType test) {
		int result = 0;
		String query = "SELECT * FROM containerconflict(?,?)";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getDisplayName());
		statement.setString(2, test.getIsoCode());
		
		ResultSet resultSet = statement.executeQuery();
			
		if(!resultSet.next()) {
			result = 0;
		} else {
			result = resultSet.getInt("cid");
		}
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}


}
