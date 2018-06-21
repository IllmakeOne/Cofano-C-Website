package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
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
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
			System.out.println(doer);
			//if there is no conflict
			if(testConflict(input) == false) {
				
				System.out.println("Received from client request " +input.toString());
				
				String query ="SELECT addships(?,?,?,?,?)";
				
				try {
					//Create prepared statement
					PreparedStatement statement = Tables.getCon().prepareStatement(query);
					//add the data to the statement's query
					statement.setString(1, input.getName());
					statement.setString(2,input.getImo());
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
				//TODO
				//waht happends when conflict
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
		
		String name = Tables.testRequest(request);
		if(!name.equals("")) {
		
			try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			
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
	
	public boolean testConflict(Ship test) {
		boolean result = true;
		String query = "SELECT * FROM shipconflict(?,?,?)";
		
		try {
		PreparedStatement statement = Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getImo());
		statement.setString(2, test.getCallsign());
		statement.setString(3, test.getMmsi());
		
		ResultSet resultSet = statement.executeQuery();

            result = resultSet.next();
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}

	
	
	
}
