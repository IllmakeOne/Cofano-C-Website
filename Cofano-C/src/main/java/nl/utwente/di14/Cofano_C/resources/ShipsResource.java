package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Application;
import nl.utwente.di14.Cofano_C.model.ContainerType;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/ships")
public class ShipsResource {
	

	private String myname = "Ship";
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addShip(Ship input, @Context HttpServletRequest request) {
		Tables.start();
		
		String title = "ADD";
		String doer = Tables.testRequste(request);
		if(!doer.equals("")) {
			//System.out.println(doer);
			//if there is no conflict
			int con = testConflict(input);
			//System.out.println(con);
			if(con == 0) {	
				//System.out.println("Received from client request " +input.toString());
				
				String query ="SELECT addships(?,?,?,?,?)";
				
				try {
					//Create prepared statement
					PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
					//add the data to the statement's query
					statement.setString(2, input.getName());
					statement.setString(1,input.getImo());
					statement.setString(3, input.getCallsign());
					statement.setString(4, input.getMmsi());
					statement.setBigDecimal(5, input.getDepth());
					
					statement.executeQuery();
					
					//add to history
					Tables.addHistoryEntry(title, doer, input.toString()
							, new Timestamp(System.currentTimeMillis()),myname);
				} catch (SQLException e) {
					System.err.println("Could not add ship");
					System.err.println(e.getSQLState());
					e.printStackTrace();
				}
			} else {
				//System.out.println("conflcit in ships");
				if(request.getSession().getAttribute("userEmail")!=null) {
					//inform clientside it creates a conflicts
				} else {
					String query ="SELECT addconflict(?,?,?,?)";
					//gets here if the request is from API
					//add to conflicts table
					try {
						//Create prepared statement
						PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
						//add the data to the statement's query
						statement.setInt(1, Integer.parseInt(doer.split(" ")[0]));
						statement.setString(2, "ship");
						statement.setObject(3, Tables.objToPGobj(input));
						statement.setInt(4, con);
						
						statement.executeQuery();
						
						//add to history
						Tables.addHistoryEntry("CON", doer, input.toString()+" con with "+con,myname);
						
					} catch (SQLException e) {
						System.err.println("Could not add port");
						System.err.println(e.getSQLState());
						e.printStackTrace();
					}
					
				}
			
			}
		}
			
	}

	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Ship> getAllApps(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Ship> result = new ArrayList<>(); 
		Ship ship = new Ship();
		String query = "SELECT * " +
				"FROM ship";
		
		String name = Tables.testRequste(request);
		if(!name.equals("")) {
		
			try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			
			ResultSet resultSet = statement.executeQuery();
			
			while(resultSet.next()) {
				//System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
				//		resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));
				ship = new Ship();
				ship.setName(resultSet.getString(3));
				ship.setImo(resultSet.getString(2));
				ship.setID(resultSet.getInt(1));
				ship.setDepth(resultSet.getBigDecimal(6));
				ship.setCallsign(resultSet.getString(4));
				ship.setMmsi(resultSet.getString(5));
				
				result.add(ship);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrive all apps" + e);
			}
		}
	
		return result;
		
	}
	
	public int testConflict(Ship test) {
		int result = 0;
		String query = "SELECT * FROM shipconflict(?,?,?)";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getImo());
		statement.setString(2, test.getCallsign());
		statement.setString(3, test.getMmsi());
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


	@DELETE
	@Path("/{shipId}")
	public void deletShip(@PathParam("shipId") int shipId, @Context HttpServletRequest request) {
		Tables.start();

		String query ="DELETE FROM ship WHERE sid = ?";
		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setLong(1, shipId);
			statement.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Was not able to delete APP");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
	}


	@GET
	@Path("/{shipId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Ship getShip(@PathParam("shipId") int shipId, @Context HttpServletRequest request) {
		Ship ship = new Ship();
		String query = "SELECT * FROM ship WHERE sid = ?";

		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setInt(1, shipId);
			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
				ship = new Ship();
				ship.setName(resultSet.getString(3));
				ship.setImo(resultSet.getString(2));
				ship.setID(resultSet.getInt(1));
				ship.setDepth(resultSet.getBigDecimal(6));
				ship.setCallsign(resultSet.getString(4));
				ship.setMmsi(resultSet.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}


		return ship;
	}

	@PUT
	@Path("/{shipId}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateApp(@PathParam("shipId") int shipId, Ship ship) {
		System.out.println("JOOOOOSOSKSOKSOSKSOKS");

		String query = "UPDATE ship SET imo = ?, name = ?, callsign = ?, mmsi = ?, ship_depth = ? WHERE sid = ?";
		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setString(1, ship.getImo());
			statement.setString(2, ship.getName());
			statement.setString(3, ship.getCallsign());
			statement.setString(4, ship.getMmsi());
			statement.setBigDecimal(5, ship.getDepth());
			statement.setInt(6, shipId);
			statement.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	
	
	
}
