package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.ContainerType;
import nl.utwente.di14.Cofano_C.model.Terminal;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



@Path("/terminals")
public class TerminalsResource {


	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Terminal> getAllContainerTypes(){
		Tables.start();
		ArrayList<Terminal> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM terminal";

		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);

			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
				System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
						resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));

				Terminal terminal = new Terminal();
				terminal.setID(resultSet.getInt("tid"));
				terminal.setName(resultSet.getString("name"));
				terminal.setTerminalCode(resultSet.getString("terminal_code"));
				terminal.setType(resultSet.getString("type"));
				terminal.setUnlo(resultSet.getString("unlo"));
				terminal.setPortId(resultSet.getInt("port_id"));


				result.add(terminal);
			}
		} catch (SQLException e) {
			System.err.println("Could not retrieve all containers" + e);
		}

		return result;

	}

}
