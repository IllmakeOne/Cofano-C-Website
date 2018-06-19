package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.HistoryEntry;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/history")
public class HistoryResource {


	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<HistoryEntry> getAllContainerTypes(){
		Tables.start();
		ArrayList<HistoryEntry> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM history";

		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);

			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
				//System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " "
				//		+ resultSet.getString(3) + " " + resultSet.getString(4));

				HistoryEntry entry = new HistoryEntry();
				entry.setID(resultSet.getInt("hid"));
				entry.setTitle(resultSet.getString("title"));
				entry.setAdded_at(resultSet.getTimestamp("added_at"));
				entry.setMessage(resultSet.getString("message"));
				entry.setType(resultSet.getString("type"));

				result.add(entry);
			}
		} catch (SQLException e) {
			System.err.println("Could not retrieve all history entries" + e);
		}

		return result;

	}

}
