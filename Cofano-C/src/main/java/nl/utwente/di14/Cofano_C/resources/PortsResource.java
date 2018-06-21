package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Port;
import nl.utwente.di14.Cofano_C.model.Ship;
import nl.utwente.di14.Cofano_C.model.Terminal;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


@Path("/ports")
public class PortsResource {

	private String myname = "Port";
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addShip(Port input, @Context HttpServletRequest request) {
		Tables.start();
		
		String title = "ADD";
		String doer = Tables.testRequste(request);
		if(!doer.equals("")) {
			//if there is no conflict
			if(testConflict(input) == false) {
			//	System.out.println("Received from client request " +input.toString());
				
				String query ="SELECT addport(?,?)";
				
				try {
					//Create prepared statement
					PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
					//add the data to the statement's query
					statement.setString(1, input.getName());
					statement.setString(2,input.getUnlo());
					
					statement.executeQuery();
					
					//add to history
					Tables.addHistoryEntry(title, doer, input.toString(),myname);
					
				} catch (SQLException e) {
					System.err.println("Could not add port");
					System.err.println(e.getSQLState());
					e.printStackTrace();
				}
			} else {
				if(request.getSession().getAttribute("userEmail")!=null) {
					//inform clientside it creates a conflicts
				} else {
					
				}
			}
		}
			
	}

	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Port> getAllContainerTypes(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM port";
		
		String name = Tables.testRequste(request);
	//	System.out.println(name);
		if(!name.equals("")) {

			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					//System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3));
	
					Port port = new Port();
					port.setID(resultSet.getInt("pid"));
					port.setName(resultSet.getString("name"));
					port.setUnlo(resultSet.getString("unlo"));
	
	
					result.add(port);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all ports" + e);
			}
		}

		return result;

	}
	
	public boolean testConflict(Port test) {
		boolean result = true;
		String query = "SELECT * FROM portconflict(?,?)";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getName());
		statement.setString(2, test.getUnlo());
		
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
