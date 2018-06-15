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

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/containers")
public class ContainerTypesResource {


	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<ContainerType> getAllContainerTypes(){
		Tables.start();
		ArrayList<ContainerType> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM container_type";

		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);

			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
			//	System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
				//		resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6) + " " + resultSet.getString(7));

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

		return result;

	}
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(ContainerType input, @Context HttpServletRequest request) {
		Tables.start();
		
		String title = "ADD";
			
			
			
			System.out.println("Received from client request " +input.toString());
			
			String query ="SELECT addcontainer_types(?,?,?,?,?,?)";
			
			try {
				//Create prepared statement
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
				//add the data to the statement's query
				statement.setString(1, input.getDisplayName());
				statement.setString(2,input.getIsoCode());
				statement.setString(3, input.getDescription());
				statement.setInt(4, input.getLength());
				statement.setInt(5, input.getHeight());
				statement.setBoolean(6, input.getReefer());
				
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

}
