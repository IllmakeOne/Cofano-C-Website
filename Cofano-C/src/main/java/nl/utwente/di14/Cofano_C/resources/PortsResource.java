package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.auth.Secured;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.exceptions.ConflictException;
import nl.utwente.di14.Cofano_C.model.Port;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/ports")
public class PortsResource {

    private final String myName = "port";


    /**
     * @return a JSON array of all approved ports
     */
    @GET
    @Secured
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Port> getAllPorts(@Context HttpServletRequest request) {
        ArrayList<Port> result = new ArrayList<>();


        String query = "SELECT * " +
                "FROM port " +
                "WHERE approved = true";

        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {
            constructPort(result, resultSet);

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Something went wrong while getting all approved ports, because: " + e.getSQLState());
            throw new InternalServerErrorException();
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
    @Secured
    @Path("unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Port> getAllPortUN(@Context HttpServletRequest request) {
        ArrayList<Port> result = new ArrayList<>();

        String query = "select port.* from port "
                + "where port.approved = false "
                + "AND port.pid not in (select conflict.entry"
                + " from conflict "
                + "where conflict.\"table\"= 'port' ) ";


        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {
            //select all unapproved entries which are not in the conflict table

//                connection.commit();
            constructPort(result, resultSet);

        } catch(SQLException e){
            e.printStackTrace();
            System.err.println("Could not retrieve all unapproved ports" + e);
            throw new InternalServerErrorException();
        }

        return result;

    }


    /**
     * this method retrieves a specific entry from the DB.
     *
     * @param portId the ports ID
     * @return return the entry as an Port object
     */
    @GET
    @Secured
    @Path("/{portId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Port retrievePort(@PathParam("portId") int portId,
                        @Context HttpServletRequest request) {

        Port port;

        try (Connection connection = Tables.getCon())  {
            port = getPort(portId, connection);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return port;
    }

    private Port getPort(int portId, Connection connection) throws SQLException {
        Port port = new Port();
        String query = "SELECT * FROM port WHERE pid = ?";

        try (PreparedStatement statement =
                connection.prepareStatement(query)) {
            statement.setInt(1, portId);
            try(ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    port.setName(resultSet.getString("name"));
                    port.setUnlo(resultSet.getString("unlo"));
                    port.setId(resultSet.getInt("pid"));
                }
            }
        }

        return port;
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
    @Secured
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addPort(Port input, @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        try (Connection connection = Tables.getCon()) {
            connection.setAutoCommit(false);
            int ownID = 0;
            String title = "ADD";
            String doer = securityContext.getUserPrincipal().getName();

            int con = testConflict(connection, input);

            if (request.getSession().getAttribute("userEmail") != null && con == 0) {
                //if its from a cofano employee and it doesn't create conflict, add straight to db
                ownID = addEntry(connection, input, true);
                HistoryResource.addHistoryEntry(connection, title, doer, input.toString(), myName, true);
            } else if (request.getSession().getAttribute("userEmail") != null && con != 0) {
                //if its from a cofano employee and it creates conflict, add but unapproved
                ownID = addEntry(connection, input, false);
                //INFOM CLIENT THEY CREATED CONFLICT
                HistoryResource.addHistoryEntry(connection, title, doer, input.toString(), myName, false);
            } else if (!doer.equals("")) {
                //if its from an api add to unapproved
                ownID = addEntry(connection, input, false);
                HistoryResource.addHistoryEntry(connection, title, doer, input.toString(), myName, false);
            }

            if (con != 0) {
                //if it creates a conflict, add it to conflict table
                Tables.addtoConflicts(connection, myName, doer, ownID, con);
                //add to history
                HistoryResource.addHistoryEntry(connection, "CON", doer, ownID + " "
                        + input.toString() + " con with " + con, myName, false);

                //throw conflict execption
                throw new ConflictException(myName, "Name ( " + input.getName() +
                			" ) or Unlo ( " + input.getUnlo() + " ) are the same as another entry in the table");
            }

            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Something went wrong adding a port, because: " + e.getSQLState());
            throw new InternalServerErrorException();
        }

    }


    /**
     * this method adds a Port entry to the Database.
     *
     * @param entry the Port about to be added
     * @param app   if the port is approved or not
     * @return the ID which is assigned to this port by the database
     */
    private int addEntry(Connection connection, Port entry, boolean app) {
        int rez;

        String query = "SELECT addport(?,?,?)";

        try (PreparedStatement statement =
                connection.prepareStatement(query)) {


            //add the data to the statement's query
            statement.setString(1, entry.getName());
            statement.setString(2, entry.getUnlo());
            statement.setBoolean(3, app);

            try (ResultSet res = statement.executeQuery()) {
                res.next();
                rez = res.getInt(1);
            }

            connection.commit();
        } catch (SQLException e) {
            System.err.println("Could not add  port ");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
        return rez;
    }


    /**
     * this method deletes an entry from a table and also adds it to history.
     *
     * @param portId the id of the entry which is deleted
     */
    @DELETE
    @Secured
    @Path("/{portId}")
    public void deletePort(@PathParam("portId") int portId,
                           @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        String query = "SELECT deleteport(?)";

        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {

            connection.setAutoCommit(false);

            Port aux = getPort(portId, connection);

            HistoryResource.addHistoryEntry(connection, "DELETE", securityContext.getUserPrincipal().getName(),
                    aux.toString(), myName, true);

            statement.setInt(1, portId);
            statement.executeQuery();

            connection.commit();

        } catch (SQLException e) {
            System.err.println("Was not able to delete Port");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

    }

    /**
     * this method deletes an entry from a table but doest not enter in in the database
     * this method is called for unapproved entries
     * this method does not add to the history table
     *
     * @param portId the id of the entry which is deleted
     */
    @DELETE
    @Secured
    @Path("/unapproved/{portId}")
    public void deletPortUN(@PathParam("portId") int portId,
                            @Context HttpServletRequest request) {

        String query = "SELECT deleteport(?)";
        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {
            statement.setInt(1, portId);
            statement.executeQuery();
        } catch (SQLException e) {
            System.err.println("Was not able to delete unapproved Port");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }


    /**
     * this method approves an entry in the database
     *
     * @param portid the id of the port which is approved
     */
    @PUT
    @Secured
    @Path("/approve/{portid}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void approvePort(@PathParam("portid") int portid,
                            @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        String query = "SELECT approveport(?)";
        try (Connection connection = Tables.getCon();  PreparedStatement statement =
                connection.prepareStatement(query)) {
            connection.setAutoCommit(false);
            Port aux = getPort(portid, connection);

            statement.setInt(1, portid);
            statement.executeQuery();

            HistoryResource.addHistoryEntry(connection, "APPROVE",
                    securityContext.getUserPrincipal().getName(),
                    aux.toString(), myName, true);

            connection.commit();

        } catch (SQLException e) {
            System.err.println("Something went wrong while approving a port, because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();

        }

    }


    /**
     * this method changes an entry in the database.
     *
     * @param portId the ID of the entry about to be changed
     * @param port   the new information for the entry
     */
    @PUT
    @Secured
    @Path("/{portId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateContainer(@PathParam("portId") int portId,
                                Port port, @Context HttpServletRequest request, @Context SecurityContext securityContext) {
        String query = "SELECT editports(?,?,?)";

        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {
            connection.setAutoCommit(false);
            Port aux = getPort(portId, connection);

            statement.setString(2, port.getName());
            statement.setString(3, port.getUnlo());
            statement.setInt(1, portId);

            statement.executeQuery();

            HistoryResource.addHistoryEntry(connection, "UPDATE", securityContext.getUserPrincipal().getName(),
                    aux.toString() + "-->" + port.toString(), myName, false);

            connection.commit();

        } catch (SQLException e) {
            System.err.println("could not update entry IN port");
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

    }


    /**
     * Extracted method to construct a port.
     *
     * @param result    the result being constructed
     * @param resultSet the Set with elements to be added to result
     * @throws SQLException if an exception occurs
     */
    private void constructPort(ArrayList<Port> result, ResultSet resultSet) throws SQLException {
        while (resultSet.next()) {
            Port port = new Port();
            port.setId(resultSet.getInt("pid"));
            port.setName(resultSet.getString("name"));
            port.setUnlo(resultSet.getString("unlo"));
            result.add(port);
        }
    }

    /**
     * this tests if there a new Port creates a conflict in the DB if it is added.
     * it creates a conflict if the name or unlo is the same as another entry in the DB
     *
     * @param test the Port which is tested
     * @return the id of the port it is on conflict with
     * or 0 if there is no conflict
     */

    private int testConflict(Connection connection, Port test) throws SQLException {
        int result = -1;

        String query = "SELECT * FROM portconflict(?,?)";

        try (PreparedStatement statement =
                connection.prepareStatement(query)) {
            statement.setString(1, test.getName());
            statement.setString(2, test.getUnlo());

            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    result = 0;
                } else {
                    result = resultSet.getInt("pid");
                }
            }

        }

        return result;
    }

}
