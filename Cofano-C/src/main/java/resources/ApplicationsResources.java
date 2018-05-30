package resources;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Application;
import dao.Tables;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;


@Path("data/applications")
public class ApplicationsResources extends Connect {
	

	public ApplicationsResources() {
	}
	
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	@Path("all")
	public List<Application> getAllApps(){
		Tables.start();
		ArrayList<Application> result = new ArrayList<>(); 
		Application add = new Application();
		String query = "SELECT * " +
				"FROM application";
		
		try {
		PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
		
		ResultSet resultSet = statement.executeQuery();
		
		while(resultSet.next()) {
			System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3));
			add = new Application();
			add.setName(resultSet.getString(1));
			add.setAPIKey((Integer) resultSet.getInt(2));
			add.setID(resultSet.getInt(3));
			
			result.add(add);
			}
		} catch (SQLException e) {
			System.err.println("Could not retrive all apps" + e);
		}
	
		return result;
		
	}
	
	public static void main(String[] args) {
		ApplicationsResources test = new ApplicationsResources();
		test.getAllApps();
	}

}



