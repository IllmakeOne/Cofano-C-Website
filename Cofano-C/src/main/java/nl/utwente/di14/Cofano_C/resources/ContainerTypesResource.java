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
	
	/**
	 * @return a JSON array of all approved ports
	 */
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
	
	/**
	 * This is used for displaying unapproved entries, which await deletion or approval
	 * this method only returns something if the request is comming from our website
	 * @return an JSON array of unapproved entries
	 */
	@GET
	@Path("unapproved")
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<ContainerType> getAllContainerTypesUN(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<ContainerType> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM container_type "+
				"WHERE approved = false";
		
		if(request.getSession().getAttribute("userEmail")!=null) {
	
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
	
	/**
	 * this function adds an entry to the database
	 * if it is from a user it is directly added and approve
	 * if not, it is added but not approved
	 * @param input the entry about to be added
	 * @param request the request of the client
	 */
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addContainer(ContainerType input, @Context HttpServletRequest request) {
		Tables.start();
		
		
		int ownID = 0;
		String title = "ADD";
		String doer = Tables.testRequest(request);

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
	

	/**
	 * this method adds a ContainerType entry to the Database
	 * @param entry the Container type about to be added 
	 * @param app if the port is approved or not 
	 * @return the ID which is assigned to this container by the database
	 */
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

	/**
	 * this method deletes an entry from a table and also adds it to history
	 * @param containerId the id of the entry which is deleted
	 */
	@DELETE
	@Path("/{containerId}")
	public void deleteContainer(@PathParam("containerId") int containerId,
			@Context HttpServletRequest request) {
		Tables.start();
		String doer = Tables.testRequest(request);
		
		if(!doer.equals("")) {
			ContainerType aux = getContainer(containerId, request);		
			String query ="SELECT  deletecontainer_types(?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setLong(1, containerId);
				statement.executeQuery();
			} catch (SQLException e) {
				System.err.println("Was not able to delete Container");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
			Tables.addHistoryEntry("DELETE", doer, aux.toString(), myname, true);
		}
	}


	/**
	 * this method retrives a specific entry from the DB
	 * @param containerId 
	 * @return return the entry as an Container Type object
	 */
	@GET
	@Path("/{containerId}")
	@Produces(MediaType.APPLICATION_JSON)
	public ContainerType getContainer(@PathParam("containerId") int containerId,
			@Context HttpServletRequest request) {
		ContainerType container = new ContainerType();
		String query = "SELECT * FROM container_type WHERE cid = ?";
		
		if(!Tables.testRequest(request).equals("")) {

			try {
				PreparedStatement statement =
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, containerId);
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					container.setDisplayName(resultSet.getString("display_name"));
					container.setIsoCode(resultSet.getString("iso_code"));
					container.setDescription(resultSet.getString("description"));
					container.setLength(resultSet.getInt("c_length"));
					container.setHeight(resultSet.getInt("c_height"));
					container.setReefer(resultSet.getBoolean("reefer"));
					container.setId(resultSet.getInt("cid"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}


		return container;
	}

	/**
	 * this method changes an entry in the database
	 * @param containerId the ID of the entry about to be changed
	 * @param container the new information for the entry
	 */
	@PUT
	@Path("/{containerId}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateContainer(@PathParam("containerId") int containerId,
			ContainerType container,@Context HttpServletRequest request) {
		
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
			ContainerType aux = getContainer(containerId, request);			
			String query = "SELECT editcontainer_types(?,?,?,?,?,?,?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setString(2, container.getDisplayName());
				statement.setString(3, container.getIsoCode());
				statement.setString(4, container.getDescription());
				statement.setInt(5, container.getLength());
				statement.setInt(6, container.getHeight());
				statement.setBoolean(7, container.getReefer());
				statement.setInt(1, containerId);
	
				statement.executeQuery();
	
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			Tables.addHistoryEntry("UPDATE", doer,
aux.toString() + "-->" + container.toString(), myname, false);
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
