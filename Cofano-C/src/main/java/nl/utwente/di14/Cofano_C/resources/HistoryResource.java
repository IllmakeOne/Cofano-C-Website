package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.HistoryEntry;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.InternalServerErrorException;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.*;
import java.util.ArrayList;


@Path("/history")
public class HistoryResource {


    /**
     * @return a JSON array of all history entries
     */
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<HistoryEntry> getAllHistoryEntries(
            @Context HttpServletRequest request) {

        ArrayList<HistoryEntry> result = new ArrayList<>();


        if (request.getSession().getAttribute("userEmail") != null) {

            String query = "SELECT * " +
                    "FROM history";


            try (Connection connection = Tables.getCon(); PreparedStatement statement =
                    connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
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
                throw new InternalServerErrorException();
            }
        }

        return result;

    }

    /**
     * Method for adding an entry to the history table.
     *
     * @param connection the Connection
     * @param title     Contains the type of change (ADD, DELETE etc.)
     * @param who       user or application that made the change
     * @param message   The information that was changed
     * @param timestamp The time of change
     * @param type      The name of the table where a change was made
     */

    public static void addHistoryEntry(Connection connection, String title, String who, String message, Timestamp timestamp, String type) throws SQLException {

        String query = "SELECT addhistory(?,?,?,?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, title);
            statement.setString(2, who + " " + title + " " + message);
            statement.setTimestamp(3, timestamp);
            statement.setString(4, type);
            statement.executeQuery();
        }
    }

    /**
     * Method for adding an entry to the history table without providing a timestamp.
     *
     * @param connection the Connection
     * @param title    Contains the type of change (ADD, DELETE etc.)
     * @param who      user or application that made the change
     * @param message  The information that was changed
     * @param type     The name of the table where a change was made
     * @param approved If the data added is approved or not
     */
    public static void addHistoryEntry(Connection connection, String title, String who, String message, String type, boolean approved) throws SQLException {
        String query = "SELECT addhistory(?,?,?,?)";
        System.out.println(title+who+message+type);
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, title);
            statement.setString(2, who + " " + title + " " + message);
            statement.setString(3, type);
            statement.setBoolean(4, approved);
            statement.executeQuery();
        }
    }

}
