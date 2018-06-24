package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.exceptions.ConflictException;
import nl.utwente.di14.Cofano_C.model.Port;
import nl.utwente.di14.Cofano_C.model.Terminal;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


@Path("/terminals")
public class TerminalsResource {


    private String myname = "Terminal";

    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addShip(Terminal input, @Context HttpServletRequest request) {
        Tables.start();

        String title = "ADD";
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            System.out.println(doer);
            //if there is no conflict
            if (testConflict(input) == false) {

                System.out.println("Received from client request " + input.toString());

                String query = "SELECT addterminal(?,?,?,?,?)";

                try {
                    //Create prepared statement
                    PreparedStatement statement = Tables.getCon().prepareStatement(query);
                    //add the data to the statement's query
                    statement.setString(1, input.getName());
                    statement.setString(2, input.getTerminalCode());
                    statement.setString(3, input.getType());
                    statement.setString(4, input.getUnlo());
                    statement.setInt(5, input.getPortId());

                    statement.executeQuery();

                    //add to history
                    Tables.addHistoryEntry(title, doer, input.toString()
                            , new Timestamp(System.currentTimeMillis()), myname);
                } catch (SQLException e) {
                    System.err.println("Could not add terminal");
                    System.err.println(e.getSQLState());
                    e.printStackTrace();
                    throw new ConflictException();
                }
            } else {
                //TODO
            }
        }

    }


    /**
     * this function is used in the Adding of a terminal.
     * Terminal have a foreign key to Ports
     *
     * @return the PKs and name of all ports
     */
    @GET
    @Path("portids")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Port> getAvailableIDs(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Port> result = new ArrayList<>();
        String query = "SELECT pid, name FROM port";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {

                    Port terminal = new Port();
                    terminal.setId(resultSet.getInt("pid"));
                    terminal.setName(resultSet.getString("name"));

                    result.add(terminal);
                }
            } catch (SQLException e) {
                System.err.println("Could not retrieve all terminals" + e);
            }
        }
        return result;
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Terminal> getAllContainerTypes(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Terminal> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM terminal";
        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    //System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
                    //	resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));

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
                System.err.println("Could not retrieve all terminals" + e);
            }
        }

        return result;
    }


    public boolean testConflict(Terminal test) {
        boolean result = true;
        String query = "SELECT * FROM terminalconflict(?,?)";

        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getName());
            statement.setString(2, test.getTerminalCode());

            ResultSet resultSet = statement.executeQuery();

            result = resultSet.next();

        } catch (SQLException e) {
            System.err.println("Could not test conflcit IN apps" + e);
        }
        return result;
    }

}
