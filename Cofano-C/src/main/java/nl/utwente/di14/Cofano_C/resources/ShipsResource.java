package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/ships")
public class ShipsResource {
	

	private String myname = "ship";
	
	/**
	 * @return a JSON array of all approved ports
	 */
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Ship> getAllShips(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Ship> result = new ArrayList<>(); 
		Ship ship = new Ship();
		String query = "SELECT * " +
				"FROM ship "+
				"WHERE approved = true;";
		
		String name = Tables.testRequest(request);
		if(!name.equals("")) {
		
			try {
			PreparedStatement statement =
					Tables.getCon().prepareStatement(query);
			
			ResultSet resultSet = statement.executeQuery();
			
			while(resultSet.next()) {
				ship = new Ship();
				ship.setName(resultSet.getString(3));
				ship.setImo(resultSet.getString(2));
				ship.setId(resultSet.getInt(1));
				ship.setDepth(resultSet.getBigDecimal(6));
				ship.setCallSign(resultSet.getString(4));
				ship.setMMSI(resultSet.getString(5));
				
				result.add(ship);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrive all ships" + e);
			}
		}
	
		return result;
		
	}
	
	/**
	 * This is used for displaying unapproved entries, 
	 * which await deletion or approval
	 * this method only returns something if the request is comming from our website
	 * @return an JSON array of unapproved entries
	 */
	@GET
	@Path("unapproved")
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Ship> getAllShipsUN(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Ship> result = new ArrayList<>(); 
		Ship ship = new Ship();
		String query = "SELECT * " +
				"FROM ship "+
				"WHERE approved = false;";
		
		if(request.getSession().getAttribute("userEmail")!=null) {
			try {
			PreparedStatement statement = 
					Tables.getCon().prepareStatement(query);
			ResultSet resultSet = statement.executeQuery();
			while(resultSet.next()) {
				ship = new Ship();
				ship.setName(resultSet.getString(3));
				ship.setImo(resultSet.getString(2));
				ship.setId(resultSet.getInt(1));
				ship.setDepth(resultSet.getBigDecimal(6));
				ship.setCallSign(resultSet.getString(4));
				ship.setMMSI(resultSet.getString(5));
				
				result.add(ship);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrive all ships" + e);
			}
		}
	
		return result;
		
	}
	
	/**
	 * this method retrives a specific entry from the DB
	 * @param shipId 
	 * @return return the entry as an Ship object
	 */
	@GET
	@Path("/{shipId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Ship getShip(@PathParam("shipId") int shipId, 
			@Context HttpServletRequest request) {
		Ship ship = new Ship();
		if(!Tables.testRequest(request).equals("")) {
			String query = "SELECT * FROM ship WHERE sid = ?";
	
			try {
				PreparedStatement statement =
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, shipId);
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					ship = new Ship();
					ship.setName(resultSet.getString(3));
					ship.setImo(resultSet.getString(2));
					ship.setId(resultSet.getInt(1));
					ship.setDepth(resultSet.getBigDecimal(6));
					ship.setCallSign(resultSet.getString(4));
					ship.setMMSI(resultSet.getString(5));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
	
		return ship;
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
	public void addShip(Ship input, @Context HttpServletRequest request) {
		
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
	 * this method adds a Ship entry to the Database
	 * @param entry the Ship about to be added 
	 * @param app if the ship is approved or not 
	 * @return the ID which is assigned to this ship by the database
	 */
	public int addEntry(Ship entry, boolean app) {
		String query ="SELECT addships(?,?,?,?,?,?)";
		int rez = 0;
		try {
			//Create prepared statement
			PreparedStatement statement =
					Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(2, entry.getName());
			statement.setString(1,entry.getImo());
			statement.setString(3, entry.getCallSign());
			statement.setString(4, entry.getMMSI());
			statement.setBigDecimal(5, entry.getDepth());
			statement.setBoolean(6, app);
			
			ResultSet res = statement.executeQuery();
			res.next();
			rez = res.getInt(1);
			
		} catch (SQLException e) {
			System.err.println("Could not add ship");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
			return rez;
	}
	
	/**
	 * this method deletes an entry from a table and also adds it to history
	 * @param shipId the id of the entry which is deleted
	 */
	@DELETE
	@Path("/{shipId}")
	public void deletShip(@PathParam("shipId") int shipId,
			@Context HttpServletRequest request) {
		Tables.start();
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
			Ship aux = getShip(shipId, request);
			String query ="SELECT deleteships(?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, shipId);
				statement.executeUpdate();
			} catch (SQLException e) {
				System.err.println("Was not able to delete APP");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
			Tables.addHistoryEntry("DELETE", doer, aux.toString(), myname, true);
		}
	}

	/**
	 * this method changes an entry in the database
	 * @param shipId the ID of the entry about to be changed
	 * @param ship the new information for the entry
	 */
	@PUT
	@Path("/{shipId}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateShip(@PathParam("shipId") int shipId, 
			Ship ship,@Context HttpServletRequest request) {

		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
			
			Ship aux = getShip(shipId, request);
			String query = "SELECT editships(?,?,?,?,?,?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setString(2, ship.getImo());
				statement.setString(3, ship.getName());
				statement.setString(4, ship.getCallSign());
				statement.setString(5, ship.getMMSI());
				statement.setBigDecimal(6, ship.getDepth());
				statement.setInt(1, shipId);
				statement.executeQuery();
	
			} catch (SQLException e) {
				e.printStackTrace();
			}
			Tables.addHistoryEntry("UPDATE", doer, aux.toString() + "-->" + ship.toString(), myname, false);
			
		}
	}


	/**
	 * this tests if there a new Port creates a conflict in the DB if it is added
	 * it creates a conflict if the IMO, callsign or MMSI
	 *  is the same as another entry in the DB
	 * @param test the Port which is tested
	 * @return the id of the port it is on conflict with 
	 * or 0 if there is no conflict
	 */
	public int testConflict(Ship test) {
		int result = 0;
		String query = "SELECT * FROM shipconflict(?,?,?)";
		
		try {
		PreparedStatement statement = Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getImo());
		statement.setString(2, test.getCallSign());
		statement.setString(3, test.getMMSI());
		//System.out.println(statement);
		
		ResultSet resultSet = statement.executeQuery();
			
		if(!resultSet.next()) {
			result = 0;
		} else {
			result = resultSet.getInt("sid");
		}
		
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}

	
	
	
}
