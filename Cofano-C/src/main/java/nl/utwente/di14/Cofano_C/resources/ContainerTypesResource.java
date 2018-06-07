package nl.utwente.di14.Cofano_C.resources;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.ContainerType;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/containers")
public class ContainerTypesResource {


	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<ContainerType> getAllContainerTypes(){
		Tables.start();
		ArrayList<ContainerType> result = new ArrayList<>();
		ContainerType container = new ContainerType();
		String query = "SELECT * " +
				"FROM container_type";

		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);

			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
				System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
						resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));
//				container = new ContainerType();
//				container.setName(resultSet.getString(3));
//				container.setImo(resultSet.getString(2));
//				container.setID(resultSet.getInt(1));
//				container.setDepth(resultSet.getBigDecimal(6));
//				ship.setCallsign(resultSet.getString(4));
//				ship.setMmsi(resultSet.getString(5));

				container.setDisplayName(resultSet.getString(""));
				result.add(container);
			}
		} catch (SQLException e) {
			System.err.println("Could not retrive all containers" + e);
		}

		return result;

	}




}
