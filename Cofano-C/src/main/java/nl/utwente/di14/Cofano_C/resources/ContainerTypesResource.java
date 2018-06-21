package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
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

	private String myname= "Container";
	
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<ContainerType> getAllContainerTypes(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<ContainerType> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM container_type";
		
		String name = Tables.testRequest(request);
		if(!name.equals("")) {
	
			try {
				PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					
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
		}

		return result;

	}
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(ContainerType input, @Context HttpServletRequest request) {
		Tables.start();
		
		String title = "ADD";
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
			System.out.println(doer);
			//if there is no conflict
			if(testConflict(input) == false) {		
			
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
					Tables.addHistoryEntry(title, doer, input.toString()
							, new Timestamp(System.currentTimeMillis()),myname);
				} catch (SQLException e) {
					System.err.println("Could not add contaynertype");
					System.err.println(e.getSQLState());
					e.printStackTrace();
				}	
			} else {
				System.out.println("conflcit in contaiers");
				//TODO
			}
		}
	}
			

	public boolean testConflict(ContainerType test) {
		boolean result = true;
		String query = "SELECT * FROM containerconflict(?,?)";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getDisplayName());
		statement.setString(2, test.getIsoCode());
		
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
