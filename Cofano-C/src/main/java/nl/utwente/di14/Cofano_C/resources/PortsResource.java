package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.ContainerType;
import nl.utwente.di14.Cofano_C.model.Port;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.glassfish.jersey.server.monitoring.RequestEventListener;
import org.postgresql.util.PGobject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/ports")
public class PortsResource {

	private String myname = "port";
	
	
	/**
	 * @return a JSON array of all approved ports
	 */
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Port> getAllPorts(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM port " +
				"WHERE approved = true";
		
		String name = Tables.testRequest(request);
		if(!name.equals("")) {
	
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				ResultSet resultSet = statement.executeQuery();
				while(resultSet.next()) {
					Port port = new Port();
					port.setId(resultSet.getInt("pid"));
					port.setName(resultSet.getString("name"));
					port.setUnlo(resultSet.getString("unlo"));
	
	
					result.add(port);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all approved ports" + e);
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
	public ArrayList<Port> getAllPortUN(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM port " +
				"WHERE approved = false";
		
		if(request.getSession().getAttribute("userEmail")!=null) {
	
			try {
				PreparedStatement statement =
						Tables.getCon().prepareStatement(query);
				ResultSet resultSet = statement.executeQuery();
				while(resultSet.next()) {
					Port port = new Port();
					port.setId(resultSet.getInt("pid"));
					port.setName(resultSet.getString("name"));
					port.setUnlo(resultSet.getString("unlo"));
					result.add(port);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all unapproved ports" + e);
			}
		} 
	
		return result;
	
	}



	/**
	 * this method retrives a specific entry from the DB
	 * @param portId 
	 * @return return the entry as an Port object
	 */
	@GET
	@Path("/{portId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Port getPort(@PathParam("portId") int portId, 
			@Context HttpServletRequest request) {
		Port port = new Port();
		String query = "SELECT * FROM port WHERE pid = ?";
		if(!Tables.testRequest(request).equals("")) {
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, portId);
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					port.setName(resultSet.getString("name"));
					port.setUnlo(resultSet.getString("unlo"));
					port.setId(resultSet.getInt("pid"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return port;
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
	public void addPort(Port input, @Context HttpServletRequest request) {
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
			Tables.addHistoryEntry("CON", doer, ownID + " " 
					+ input.toString()+" con with "+con,myname,false);

		}
			
	}
	
	

	/**
	 * this method adds a Port entry to the Database
	 * @param entry the Port about to be added 
	 * @param app if the port is approved or not 
	 * @return the ID which is assigned to this port by the database
	 */
	public int addEntry(Port entry, boolean app) {
		String query = "SELECT addport(?,?,?)";
		int rez =0;
		//gets here if the request is from API
		//add to conflicts table
		try {
			//Create prepared statement
			PreparedStatement statement =
					Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(1, entry.getName());
			statement.setString(2,entry.getUnlo());
			statement.setBoolean(3, app);
			
			ResultSet res = statement.executeQuery();			
			res.next();
			rez = res.getInt(1);
		} catch (SQLException e) {
			System.err.println("Could not add  port ");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		return rez;
	}



	/**
	 * this method deletes an entry from a table and also adds it to history
	 * @param portId the id of the entry which is deleted
	 */
	@DELETE
	@Path("/{portId}")
	public void deletPort(@PathParam("portId") int portId,
			@Context HttpServletRequest request) {
		Tables.start();
		
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
	
			Port  aux = getPort(portId, request);
			String query ="SELECT deleteport(?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setLong(1, portId);
				statement.executeUpdate();
			} catch (SQLException e) {
				System.err.println("Was not able to delete Port");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
			Tables.addHistoryEntry("DELETE", doer, 
					aux.toString(), myname, true);
		}
	}

	/**
	 * this method changes an entry in the database
	 * @param portId the ID of the entry about to be changed
	 * @param port the new information for the entry
	 */
	@PUT
	@Path("/{portId}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateContainer(@PathParam("portId") int portId, 
			Port port,@Context HttpServletRequest request) {
		
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {			
			Port aux = getPort(portId, request);
			String query = "SELECT editports(?,?,?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setString(2, port.getName());
				statement.setString(3, port.getUnlo());
				statement.setInt(1, portId);
	
				statement.executeQuery();
	
			} catch (SQLException e) {
				System.err.println("could not update entry IN port");
				e.printStackTrace();
			}
			Tables.addHistoryEntry("UPDATE", doer, 
				aux.toString() + "-->" + port.toString(), myname, false);
		}

	}



	/**
	 * this tests if there a new Port creates a conflict in the DB if it is added
	 * it creates a conflict if the name or unlo is the same as another entry in the DB
	 * @param test the Port which is tested
	 * @return the id of the port it is on conflict with
	 *  or 0 if there is no conflict
	 */
	public int testConflict(Port test) {
		int result = 0 ;
		String query = "SELECT * FROM portconflict(?,?)";
		
		try {
			PreparedStatement statement = 
					Tables.getCon().prepareStatement(query);
			statement.setString(1, test.getName());
			statement.setString(2, test.getUnlo());
			
			ResultSet resultSet = statement.executeQuery();
				
			if(!resultSet.next()) {
				result = 0;
			} else {
				result = resultSet.getInt("pid");
			}
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN port " + e);
		}
		return result;
	}
	
}
