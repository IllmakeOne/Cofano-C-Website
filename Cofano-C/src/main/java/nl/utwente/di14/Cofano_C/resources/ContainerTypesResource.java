package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.ContainerType;
import nl.utwente.di14.Cofano_C.model.Port;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
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
		
		String name = Tables.testRequest(request);
		if(!name.equals("")) {
	
			try {
				PreparedStatement statement = Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					
					ContainerType container = new ContainerType();
					container.setDisplayName(resultSet.getString("display_name"));
					container.setId(resultSet.getInt("cid"));
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
	@Path("/{containerId}")
	public void deletShip(@PathParam("containerId") int containerId, @Context HttpServletRequest request) {
		Tables.start();

		String query ="DELETE FROM container_type WHERE cid = ?";
		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setLong(1, containerId);
			statement.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Was not able to delete Container");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
	}


	@GET
	@Path("/{containerId}")
	@Produces(MediaType.APPLICATION_JSON)
	public ContainerType getShip(@PathParam("containerId") int containerId, @Context HttpServletRequest request) {
		ContainerType container = new ContainerType();
		String query = "SELECT * FROM container_type WHERE cid = ?";

		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setInt(1, containerId);
			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
				container.setDisplayName(resultSet.getString("display_name"));
				container.setIsoCode(resultSet.getString("iso_code"));
				container.setDescription(resultSet.getString("description"));
				container.setLength(resultSet.getInt("c_length"));
				container.setHeight(resultSet.getInt("c_height"));
				container.setReefer(resultSet.getBoolean("reefer"));
				container.setID(resultSet.getInt("cid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}


		return container;
	}

	@PUT
	@Path("/{containerId}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateContainer(@PathParam("containerId") int containerId, ContainerType container) {
		System.out.println("Joohoooo");
		System.out.print(containerId);
		String query = "UPDATE container_type SET display_name = ?, iso_code = ?, description = ?, c_length = ?, c_height = ?, reefer = ? WHERE cid = ?";
		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setString(1, container.getDisplayName());
			statement.setString(2, container.getIsoCode());
			statement.setString(3, container.getDescription());
			statement.setInt(4, container.getLength());
			statement.setInt(5, container.getHeight());
			statement.setBoolean(6, container.getReefer());
			statement.setInt(7, containerId);

			statement.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
			
	


	public int testConflict(ContainerType test) {
		int result = 0;
		String query = "SELECT * FROM containerconflict(?,?)";
		
		try {
		PreparedStatement statement = Tables.getCon().prepareStatement(query);
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
