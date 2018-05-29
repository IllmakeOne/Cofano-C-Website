package resources;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import model.Application;

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


@Path("data/applications/")
public class ApplicationsResources extends Connect {
	

	public ApplicationsResources() {
	}
	
	@GET
	@Produces({ MediaType.APPLICATION_XML})
	@Path("all")
	public List<Application> getAllApps(){
		ArrayList<Application> result = new ArrayList<>();
		Application add = new Application();
		
		try {
			Class.forName("org.postgresql.Driver");
			}
			catch (ClassNotFoundException cnfe) {
			System.err.println("Error loading driver: " + cnfe);
			}
		
		try {
			Connection connection =
			DriverManager.getConnection(url, "docker", "YsLxCu0I1");

			String query = "SELECT * " +
					"FROM application";
			
			PreparedStatement statement = (PreparedStatement) connection.prepareStatement(query);
			
			ResultSet resultSet = statement.executeQuery();
			

			
			while(resultSet.next()) {
				System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3));
				add.setName(resultSet.getString(1));
				add.setAPIKey((Integer) resultSet.getInt(2));
				add.setID(resultSet.getInt(3));
				result.add(add);
				}

			connection.close();

			}
			catch(SQLException sqle) {
			System.err.println("Error connecting: " + sqle);
			}
		
		return result;
		
	}
	
	public static void main(String[] args) {
		ApplicationsResources test = new ApplicationsResources();
		test.getAllApps();
	}

}



