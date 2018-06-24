package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Port;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/ports")
public class PortsResource {

    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addShip(Port input, @Context HttpServletRequest request) {
        Tables.start();

        String title = "ADD";
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            //if there is no conflict
            if (!testConflict(input)) {
                //	System.out.println("Received from client request " +input.toString());

                String query = "SELECT addport(?,?)";

                try {
                    //Create prepared statement
                    PreparedStatement statement = Tables.getCon().prepareStatement(query);
                    //add the data to the statement's query
                    statement.setString(1, input.getName());
                    statement.setString(2, input.getUnlo());

                    statement.executeQuery();

                    //add to history
                    String myName = "Port";
                    Tables.addHistoryEntry(title, doer, input.toString(), myName);

                } catch (SQLException e) {
                    System.err.println("Could not add port");
                    System.err.println(e.getSQLState());
                    e.printStackTrace();
                }
            } else {
                if (request.getSession().getAttribute("userEmail") != null) {
                    //inform client side it creates a conflicts
                } else {
                }
            }
        }

    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Port> getAllContainerTypes(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Port> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM port";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    Port port = new Port();
                    port.setId(resultSet.getInt("pid"));
                    port.setName(resultSet.getString("name"));
                    port.setUnlo(resultSet.getString("unlo"));

                    result.add(port);
                }
            } catch (SQLException e) {
                System.err.println("Could not retrieve all ports" + e);
            }
        }

        return result;

    }

    private boolean testConflict(Port test) {
        boolean result = true;
        String query = "SELECT * FROM portconflict(?,?)";

        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getName());
            statement.setString(2, test.getUnlo());

            ResultSet resultSet = statement.executeQuery();

            result = resultSet.next();

        } catch (SQLException e) {
            System.err.println("Could not test conflict IN apps" + e);
        }
        return result;
    }

}
