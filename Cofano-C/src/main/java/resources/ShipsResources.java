package resources;

import java.awt.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import dao.*;
import model.*;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/data/ships")
public class ShipsResources {
	

	@GET
	@Produces({MediaType.APPLICATION_JSON})
	@Path("all")
	public ArrayList<Ship> getAllApps(){
		Tables.start();
		ArrayList<Ship> result = new ArrayList<>(); 
		Ship ship = new Ship();
		String query = "SELECT * " +
				"FROM ships";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		
		ResultSet resultSet = statement.executeQuery();
		
		while(resultSet.next()) {
			System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
					resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));
			ship = new Ship();
			ship.setName(resultSet.getString(3));
			ship.setImo(resultSet.getString(2));
			ship.setID(resultSet.getInt(1));
			ship.setDepth(resultSet.getFloat(6));
			ship.setCallsign(resultSet.getString(4));
			ship.setMmsi(resultSet.getString(5));
			
			result.add(ship);
			}
		} catch (SQLException e) {
			System.err.println("Could not retrive all apps" + e);
		}
	
		return result;
		
	}

	
	
	
}
