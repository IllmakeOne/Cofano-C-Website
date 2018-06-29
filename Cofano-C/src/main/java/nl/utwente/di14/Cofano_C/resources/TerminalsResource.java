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
import java.util.ArrayList;


@Path("/terminals")
public class TerminalsResource {


    private final String myName = "terminal";


    /**
     * @return a JSON array of all approved Terminals
     */
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Terminal> getAllTerminals(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Terminal> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM terminal " +
                "WHERE approved = true";
        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                constructTerminal(result, resultSet);
            } catch (SQLException e) {
                System.err.println("Could not retrieve all terminals" + e);
            }
        }
        return result;
    }

    /**
     * This is used for displaying unapproved entries, which await deletion or approval.
     * this method only returns something if the request is coming from our website
     *
     * @return an JSON array of unapproved entries
     */
    @GET
    @Path("unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Terminal> getAllTerminalsUN(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Terminal> result = new ArrayList<>();
        //select all unapproved entries which are not in the conflict table
        String query = "select terminal.* from terminal"
                + " where terminal.approved = false"
                + " AND terminal.tid not in (select conflict.entry "
                + "from conflict "
                + "where conflict.\"table\"= 'terminal' ) ";

        if (request.getSession().getAttribute("userEmail") != null) {

            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();

                constructTerminal(result, resultSet);
            } catch (SQLException e) {
                System.err.println("Could not retrieve all unapproved terminals" + e);
            }
        }
        return result;
    }

    /**
     * this method retrieves a specific entry from the DB.
     *
     * @param terminalId ID of the terminal
     * @return return the entry as an Terminal object
     */
    @GET
    @Path("/{terminalId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Terminal getTerminal(@PathParam("terminalId") int terminalId,
                                @Context HttpServletRequest request) {
        Terminal terminal = new Terminal();
        if (!Tables.testRequest(request).equals("")) {
            String query = "SELECT * FROM terminal WHERE tid = ?";
            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);
                statement.setInt(1, terminalId);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    terminal.setName(resultSet.getString("name"));
                    terminal.setTerminalCode(resultSet.getString("terminal_code"));
                    terminal.setType(resultSet.getString("type"));
                    terminal.setUnlo(resultSet.getString("unlo"));
                    terminal.setPortId(resultSet.getInt("port_id"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return terminal;
    }


    /**
     * this function adds an entry to the database.
     * if it is from a user it is directly added and approve
     * if not, it is added but not approved
     *
     * @param input   the entry about to be added
     * @param request the request of the client
     */
    @SuppressWarnings("Duplicates")
    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addTerminal(Terminal input, @Context HttpServletRequest request) {
        Tables.start();
        int ownID = 0;
        String title = "ADD";
        String doer = Tables.testRequest(request);
        int con = testConflict(input);

        if (request.getSession().getAttribute("userEmail") != null && con == 0) {
            //if its from a cofano employee and it doesn't create conflict, add straight to db
            ownID = addEntry(input, true);
            Tables.addHistoryEntry(title, doer, input.toString(), myName, true);
        } else if (request.getSession().getAttribute("userEmail") != null && con != 0) {
            //if its from a cofano employee and it creates conflict, add but unapproved
            ownID = addEntry(input, false);

            Tables.addHistoryEntry(title, doer, input.toString(), myName, false);
        } else if (!doer.equals("")) {
            //if its from an api add to unapproved
            ownID = addEntry(input, false);
            Tables.addHistoryEntry(title, doer, input.toString(), myName, false);
        }

        if (con != 0) {
            //if it creates a conflict, add it to conflict table
            Tables.addtoConflicts(myName, doer, ownID, con);
            //add to history
            Tables.addHistoryEntry("CON", doer,
                    ownID + " " + input.toString() + " con with " + con, myName, false);
        }

    }

    /**
     * this method adds a Terminal entry to the Database.
     *
     * @param entry the Terminal about to be added
     * @param app   if the terminal is approved or not
     * @return the ID which is assigned to this port by the database
     */
    private int addEntry(Terminal entry, boolean app) {
        int rez;
        //gets here if the request is from API
        //add to conflicts table
        String query = "SELECT addterminal(?,?,?,?,?,?)";
        try {
            //Create prepared statement
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
            //add the data to the statement's query
            statement.setString(1, entry.getName());
            statement.setString(2, entry.getTerminalCode());
            statement.setString(3, entry.getType());
            statement.setString(4, entry.getUnlo());
            statement.setInt(5, entry.getPortId());
            statement.setBoolean(6, app);
            ResultSet res = statement.executeQuery();
            res.next();
            rez = res.getInt(1);

        } catch (SQLException e) {
            System.err.println("Could not add terminal");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new ConflictException();
        }
        return rez;
    }


    /**
     * this method deletes an entry from a table and also adds it to history.
     *
     * @param terminalId the id of the entry which is deleted
     */
    @DELETE
    @Path("/{terminalId}")
    public void deleteTerminal(@PathParam("terminalId") int terminalId,
                               @Context HttpServletRequest request) {
        Tables.start();
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            Terminal aux = getTerminal(terminalId, request);
            String query = "SELECT deleteterminal(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, terminalId);
                statement.executeQuery();
            } catch (SQLException e) {
                System.err.println("Was not able to delete Terminal");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
            Tables.addHistoryEntry("DELETE", doer, aux.toString(), myName, true);
        }
    }

    /**
     * this method deletes an entry from a table but doest not enter in in the database
     * this method is called for unapproved entries
     * this method does not add to the history table
     *
     * @param terminalId the id of the entry which is deleted
     */
    @DELETE
    @Path("/unapproved/{terminalId}")
    public void deletTerminalUN(@PathParam("terminalId") int terminalId,
                                @Context HttpServletRequest request) {
        Tables.start();
        if (request.getSession().getAttribute("userEmail") != null) {
            String query = "SELECT deleteterminal(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, terminalId);
                statement.executeQuery();
            } catch (SQLException e) {
                System.err.println("Was not able to delete unapproved Terminal");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
        }
    }


    /**
     * this method approves an entry in the database
     *
     * @param terminalId the id of the terminal which is approved
     */
    @PUT
    @Path("/approve/{terminalId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void approveContainer(@PathParam("terminalId") int terminalId,
                                 @Context HttpServletRequest request) {

        if (request.getSession().getAttribute("userEmail") != null) {
            Terminal aux = getTerminal(terminalId, request);
            String query = "SELECT approveterminal(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, terminalId);
                statement.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            }

            Tables.addHistoryEntry("APPROVE",
                    request.getSession().getAttribute("userEmail").toString(),
                    aux.toString(), myName, true);
        }
    }


    /**
     * this method changes an entry in the database.
     *
     * @param terminalId the ID of the entry about to be changed
     * @param terminal   the new information for the entry
     */
    @PUT
    @Path("/{terminalId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateTerminal(@PathParam("terminalId") int terminalId,
                               Terminal terminal, @Context HttpServletRequest request) {

        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            Terminal aux = getTerminal(terminalId, request);
            String query = "SELECT editterminals(?,?,?,?,?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setString(2, terminal.getName());
                statement.setString(3, terminal.getTerminalCode());
                statement.setString(4, terminal.getType());
                statement.setString(5, terminal.getUnlo());
                statement.setInt(1, terminalId);
                statement.executeQuery();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            Tables.addHistoryEntry("UPDATE", doer,
                    aux.toString() + "-->" + terminal.toString(), myName, false);
        }
    }


    /**
     * this tests if there a new Port creates a conflict in the DB if it is added.
     * it creates a conflict if the name or terminal code is the same as another entry in the DB
     *
     * @param test the Port which is tested
     * @return the id of the port it is on conflict with , or 0 if there is no conflict
     */
    private int testConflict(Terminal test) {
        int result = -1;
        String query = "SELECT * FROM terminalconflict(?,?)";
        try {
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getName());
            statement.setString(2, test.getTerminalCode());
            ResultSet resultSet = statement.executeQuery();
            if (!resultSet.next()) {
                result = 0;
            } else {
                result = resultSet.getInt("tid");
            }
        } catch (SQLException e) {
            System.err.println("Could not test conflict IN apps" + e);
        }
        return result;
    }

    private void constructTerminal(ArrayList<Terminal> result, ResultSet resultSet)
            throws SQLException {
        while (resultSet.next()) {
            Terminal terminal = new Terminal();
            terminal.setID(resultSet.getInt("tid"));
            terminal.setName(resultSet.getString("name"));
            terminal.setTerminalCode(resultSet.getString("terminal_code"));
            terminal.setType(resultSet.getString("type"));
            terminal.setUnlo(resultSet.getString("unlo"));
            terminal.setPortId(resultSet.getInt("port_id"));
            result.add(terminal);
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
        String query = "SELECT pid, name FROM port WHERE approved = true";

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
                System.err.println("Could not retrieve all ports" + e);
            }
        }
        return result;
    }

}
