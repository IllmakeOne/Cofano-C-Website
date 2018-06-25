package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.HistoryEntry;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/history")
public class HistoryResource {


	/**
	 * @return a JSON array of all hisotry entries
	 */
	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<HistoryEntry> getAllHisotryEntries(
			@Context HttpServletRequest request){
		Tables.start();
		ArrayList<HistoryEntry> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM history";
		if(request.getSession().getAttribute("userEmail")!=null) {
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					HistoryEntry entry = new HistoryEntry();
					entry.setId(resultSet.getInt("hid"));
					entry.setTitle(resultSet.getString("title"));
					entry.setAddedAt(resultSet.getTimestamp("added_at"));
					entry.setMessage(resultSet.getString("message"));
					entry.setType(resultSet.getString("type"));
	
					result.add(entry);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all history entries" + e);
			}
		}

		return result;

	}

}
