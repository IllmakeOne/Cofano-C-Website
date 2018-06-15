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

	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addShip(Port input, @Context HttpServletRequest request) {
		Tables.start();
		
		String title = "ADD";
			
			System.out.println("Received from client request " +input.toString());
			
			String query ="SELECT addport(?,?)";
			
			try {
				//Create prepared statement
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				//add the data to the statement's query
				statement.setString(1, input.getName());
				statement.setString(2,input.getUnlo());
				
				statement.executeQuery();
				
				//add to history
				Tables.addHistoryEntry(title, (String) request.getSession().getAttribute("userEmail"), input.toString()
						, new Timestamp(System.currentTimeMillis()));
			} catch (SQLException e) {
				System.err.println("Could not add contaynertype");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
			
	}

	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Port> getAllContainerTypes(){
		Tables.start();
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM port";

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

		return result;

	}

}
