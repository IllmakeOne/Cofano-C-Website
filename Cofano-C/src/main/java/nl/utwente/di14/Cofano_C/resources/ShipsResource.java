package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.auth.Secured;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.exceptions.ConflictException;
import nl.utwente.di14.Cofano_C.model.Ship;
import okhttp3.internal.Internal;

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

@SuppressWarnings("Duplicates")
@Path("/ships")
public class ShipsResource {


    private final String myName = "ship";

    /**
     * @return a JSON array of all approved ports
     */
    @GET
    @Secured
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Ship> getAllShips(@Context HttpServletRequest request) {
        ArrayList<Ship> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM ship " +
                "WHERE approved = true;";
        try (Connection connection = Tables.getCon()){
            constructShip(connection, result, query);
        } catch (SQLException e) {
            System.out.println("Something went wrong while loading all ships! Because: " + e.getSQLState());
            throw new InternalServerErrorException();
        }

        return result;

    }

    /**
     * This is used for displaying unapproved entries.
     * which await deletion or approval
     * this method only returns something if the request is coming from our website
     *
     * @return an JSON array of unapproved entries
     */
    @GET
    @Secured
    @Path("unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Ship> getAllShipsUN(@Context HttpServletRequest request) {
        ArrayList<Ship> result = new ArrayList<>();
        try (Connection connection = Tables.getCon()){

            //select all unapproved entries which are not in the conflict table
            String query = "select ship.* "
                    + "from ship "
                    + "where ship.approved = false "
                    + "AND ship.sid not in (select conflict.entry "
                    + "from conflict "
                    + "where conflict.\"table\"= 'ship' )";

            constructShip(connection, result, query);
        } catch (SQLException e) {
            System.out.println("Something went wrong retrieving unapproved apps becaue: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return result;

    }

    /**
     * this method retrieves a specific entry from the DB.
     *
     * @param shipId the ID of the ship
     * @return return the entry as an Ship object
     */
    @GET
    @Secured
    @Path("/{shipId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Ship retrieveShip(@PathParam("shipId") int shipId,
                        @Context HttpServletRequest request) {
        Ship ship;
        try (Connection connection = Tables.getCon()){
            ship = getShip(connection, shipId);
        } catch (SQLException e) {
            System.err.println("Something went wrong while getting a ship with ID: " + shipId + ", because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }


        return ship;
    }

    // Internal only
    private Ship getShip(Connection connection, int shipId) throws SQLException{
        Ship ship = new Ship();
        String query = "SELECT * FROM ship WHERE sid = ?";


        try (PreparedStatement statement =
                connection.prepareStatement(query)) {
            statement.setInt(1, shipId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ship = new Ship();
                    ship.setName(resultSet.getString(3));
                    ship.setImo(resultSet.getString(2));
                    ship.setId(resultSet.getInt(1));
                    ship.setDepth(resultSet.getBigDecimal(6));
                    ship.setCallSign(resultSet.getString(4));
                    ship.setMMSI(resultSet.getString(5));
                }
            }
        }

        return ship;
    }


    /**
     * this function adds an entry to the database.
     * if it is from a user it is directly added and approve
     * if not, it is added but not approved
     *
     * @param input   the entry about to be added
     * @param request the request of the client
     */
    @POST
    @Secured
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addShip(Ship input, @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        try (Connection connection = Tables.getCon()) {
            connection.setAutoCommit(false);
            String doer = securityContext.getUserPrincipal().getName();
            int ownID = 0;
            String title = "ADD";

            int con = testConflict(connection, input);

            if (request.getSession().getAttribute("userEmail") != null && con == 0) {
                //if its from a cofano employee and it doesn't create conflict, add straight to db
                ownID = addEntry(connection, input, true);
                HistoryResource.addHistoryEntry(connection, title, doer, input.toString(), myName, true);
            } else if (request.getSession().getAttribute("userEmail") != null && con != 0) {
                //if its from a cofano employee and it creates conflict, add but unapproved
                ownID = addEntry(connection, input, false);

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
                HistoryResource.addHistoryEntry(connection, "CON", doer, ownID + " " + input.toString() +
                        " con with " + con, myName, false);
                //throw conflict execption
                throw new ConflictException(myName, "IMO, MMSI or Callsign are the same as another entry in the table");
            }
            connection.commit();
        } catch (SQLException e) {
            System.err.println("Something went wrong while adding a new ship, because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

    }

    /**
     * this method adds a Ship entry to the Database.
     *
     * @param entry the Ship about to be added
     * @param app   if the ship is approved or not
     * @return the ID which is assigned to this ship by the database
     */
    private int addEntry(Connection connection, Ship entry, boolean app) {
        int rez = 0;

        String query = "SELECT addships(?,?,?,?,?,?)";
        //Create prepared statement
        try (PreparedStatement statement =
               connection.prepareStatement(query)) {
            //add the data to the statement's query
            statement.setString(2, entry.getName());
            statement.setString(1, entry.getImo());
            statement.setString(3, entry.getCallSign());
            statement.setString(4, entry.getMMSI());
            statement.setBigDecimal(5, entry.getDepth());
            statement.setBoolean(6, app);

            ResultSet res = statement.executeQuery();
            res.next();
            rez = res.getInt(1);

            connection.commit();
        } catch (SQLException e) {
            System.err.println("Could not add ship");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return rez;
    }

    /**
     * this method deletes an entry from a table and also adds it to history.
     *
     * @param shipId the id of the entry which is deleted
     */
    @DELETE
    @Secured
    @Path("/{shipId}")
    public void deleteShip(@PathParam("shipId") int shipId,
                           @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        String query = "SELECT deleteships(?)";


        try (Connection connection = Tables.getCon(); PreparedStatement statement =
            connection.prepareStatement(query)) {

            connection.setAutoCommit(false);
            Ship aux = getShip(connection, shipId);

            statement.setInt(1, shipId);
            statement.executeQuery();

            HistoryResource.addHistoryEntry(connection, "DELETE", securityContext.getUserPrincipal().getName(),
                    aux.toString(), myName, true);
            connection.commit();


        } catch (SQLException e) {
            System.err.println("Was not able to delete APP");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }

    /**
     * this method deletes an entry from a table but doest not enter in in the database.
     * this method is called for unapproved entries
     * this method does not add to the history table
     *
     * @param shipId the id of the entry which is deleted
     */
    @DELETE
    @Secured
    @Path("/unapproved/{shipId}")
    public void deletShipUN(@PathParam("shipId") int shipId,
                            @Context HttpServletRequest request) {
        String query = "SELECT deleteships(?)";
        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {

            statement.setInt(1, shipId);
            statement.executeQuery();
        } catch (SQLException e) {
            System.err.println("Was not able to delete unapproved ship");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }


    /**
     * this method approves an entry in the database.
     *
     * @param shipid the id of the ship which is approved
     */
    @PUT
    @Secured
    @Path("/approve/{shipid}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void approveShip(@PathParam("shipid") int shipid,
                            @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        String query = "SELECT approveship(?)";

        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {
            connection.setAutoCommit(false);
            Ship aux = getShip(connection, shipid);

            statement.setInt(1, shipid);
            statement.executeQuery();

            HistoryResource.addHistoryEntry(connection, "APPROVE",
                    securityContext.getUserPrincipal().getName(),
                    aux.toString(), myName, true);

            connection.commit();
        } catch (SQLException e) {
            System.err.println("Something went wrong while approving ship: " + shipid + ", because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }


    /**
     * this method changes an entry in the database.
     *
     * @param shipId the ID of the entry about to be changed
     * @param ship   the new information for the entry
     */
    @PUT
    @Secured
    @Path("/{shipId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateShip(@PathParam("shipId") int shipId,
                           Ship ship, @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        String query = "SELECT editships(?,?,?,?,?,?)";
        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)){

            connection.setAutoCommit(false);

            Ship aux = getShip(connection, shipId);


            statement.setString(2, ship.getImo());
            statement.setString(3, ship.getName());
            statement.setString(4, ship.getCallSign());
            statement.setString(5, ship.getMMSI());
            statement.setBigDecimal(6, ship.getDepth());
            statement.setInt(1, shipId);
            statement.executeQuery();


            HistoryResource.addHistoryEntry(connection, "UPDATE", securityContext.getUserPrincipal().getName(), aux.toString() + "-->" +
                    ship.toString(), myName, false);

            connection.commit();


        } catch (SQLException e) {
            System.err.println("Something went wrong while editing ship: " + shipId + ", because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }


    /**
     * this tests if there a new Port creates a conflict in the DB if it is added.
     * it creates a conflict if the IMO, call sign or MMSI
     * is the same as another entry in the DB
     *
     * @param test the Port which is tested
     * @return the id of the port it is on conflict with
     * or 0 if there is no conflict
     */
    private int testConflict(Connection connection, Ship test) throws SQLException {
        int result = -1;

        String query = "SELECT * FROM shipconflict(?,?,?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, test.getImo());
            statement.setString(2, test.getCallSign());
            statement.setString(3, test.getMMSI());

            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    result = 0;
                } else {
                    result = resultSet.getInt("sid");
                }
            }
        }

        return result;
    }

    private void constructShip(Connection connection, ArrayList<Ship> result, String query) throws SQLException {
        Ship ship;
        try ( PreparedStatement statement =
                      connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                ship = new Ship();
                ship.setName(resultSet.getString(3));
                ship.setImo(resultSet.getString(2));
                ship.setId(resultSet.getInt(1));
                ship.setDepth(resultSet.getBigDecimal(6));
                ship.setCallSign(resultSet.getString(4));
                ship.setMMSI(resultSet.getString(5));

                result.add(ship);
            }
        }
    }


}
