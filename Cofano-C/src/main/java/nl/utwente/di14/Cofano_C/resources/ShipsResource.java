package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Ship;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
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
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Ship> getAllShips(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Ship> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM ship " +
                "WHERE approved = true;";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            constructShip(result, query);
        }
        Tables.shutDown();
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
    @Path("unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Ship> getAllShipsUN(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Ship> result = new ArrayList<>();
        //select all unapproved entries which are not in the conflict table
        String query = "select ship.* "
                + "from ship "
                + "where ship.approved = false "
                + "AND ship.sid not in (select conflict.entry "
                + "from conflict "
                + "where conflict.\"table\"= 'ship' )";

        if (request.getSession().getAttribute("userEmail") != null) {
            constructShip(result, query);
        }
        Tables.shutDown();
        return result;

    }

    /**
     * this method retrieves a specific entry from the DB.
     *
     * @param shipId the ID of the ship
     * @return return the entry as an Ship object
     */
    @GET
    @Path("/{shipId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Ship getShip(@PathParam("shipId") int shipId,
                        @Context HttpServletRequest request) {
        Ship ship = new Ship();
        if (!Tables.testRequest(request).equals("")) {
            Tables.start();

            String query = "SELECT * FROM ship WHERE sid = ?";

            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, shipId);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    ship = new Ship();
                    ship.setName(resultSet.getString(3));
                    ship.setImo(resultSet.getString(2));
                    ship.setId(resultSet.getInt(1));
                    ship.setDepth(resultSet.getBigDecimal(6));
                    ship.setCallSign(resultSet.getString(4));
                    ship.setMMSI(resultSet.getString(5));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        Tables.shutDown();
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
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addShip(Ship input, @Context HttpServletRequest request) {

        int ownID = 0;
        String title = "ADD";
        String doer = Tables.testRequest(request);
        int con = testConflict(input);
        Tables.start();

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
            Tables.addHistoryEntry("CON", doer, ownID + " " + input.toString() +
                    " con with " + con, myName, false);
        }

        Tables.shutDown();


    }

    /**
     * this method adds a Ship entry to the Database.
     *
     * @param entry the Ship about to be added
     * @param app   if the ship is approved or not
     * @return the ID which is assigned to this ship by the database
     */
    private int addEntry(Ship entry, boolean app) {
        Tables.start();
        String query = "SELECT addships(?,?,?,?,?,?)";
        int rez = 0;
        try {
            //Create prepared statement
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
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

        } catch (SQLException e) {
            System.err.println("Could not add ship");
            System.err.println(e.getSQLState());
            e.printStackTrace();
        }
        Tables.shutDown();

        return rez;
    }

    /**
     * this method deletes an entry from a table and also adds it to history.
     *
     * @param shipId the id of the entry which is deleted
     */
    @DELETE
    @Path("/{shipId}")
    public void deleteShip(@PathParam("shipId") int shipId,
                           @Context HttpServletRequest request) {
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            Ship aux = getShip(shipId, request);
            Tables.start();

            String query = "SELECT deleteships(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, shipId);
                statement.executeQuery();
            } catch (SQLException e) {
                System.err.println("Was not able to delete APP");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
            Tables.addHistoryEntry("DELETE", doer, aux.toString(), myName, true);
        }
        Tables.shutDown();
    }

    /**
     * this method deletes an entry from a table but doest not enter in in the database.
     * this method is called for unapproved entries
     * this method does not add to the history table
     *
     * @param shipId the id of the entry which is deleted
     */
    @DELETE
    @Path("/unapproved/{shipId}")
    public void deletShipUN(@PathParam("shipId") int shipId,
                            @Context HttpServletRequest request) {
        Tables.start();
        if (request.getSession().getAttribute("userEmail") != null) {
            String query = "SELECT deleteships(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, shipId);
                statement.executeQuery();
            } catch (SQLException e) {
                System.err.println("Was not able to delete unapproved ship");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
        }
        Tables.shutDown();
    }


    /**
     * this method approves an entry in the database.
     *
     * @param shipid the id of the ship which is approved
     */
    @PUT
    @Path("/approve/{shipid}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void approveShip(@PathParam("shipid") int shipid,
                            @Context HttpServletRequest request) {

        if (request.getSession().getAttribute("userEmail") != null) {
            Ship aux = getShip(shipid, request);
            Tables.start();

            String query = "SELECT approveship(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, shipid);
                statement.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            }

            Tables.addHistoryEntry("APPROVE",
                    request.getSession().getAttribute("userEmail").toString(),
                    aux.toString(), myName, true);
        }
        Tables.shutDown();
    }


    /**
     * this method changes an entry in the database.
     *
     * @param shipId the ID of the entry about to be changed
     * @param ship   the new information for the entry
     */
    @PUT
    @Path("/{shipId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateShip(@PathParam("shipId") int shipId,
                           Ship ship, @Context HttpServletRequest request) {
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {

            Ship aux = getShip(shipId, request);
            Tables.start();

            String query = "SELECT editships(?,?,?,?,?,?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setString(2, ship.getImo());
                statement.setString(3, ship.getName());
                statement.setString(4, ship.getCallSign());
                statement.setString(5, ship.getMMSI());
                statement.setBigDecimal(6, ship.getDepth());
                statement.setInt(1, shipId);
                statement.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            }
            Tables.addHistoryEntry("UPDATE", doer, aux.toString() + "-->" +
                    ship.toString(), myName, false);

        }
        Tables.shutDown();
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
    private int testConflict(Ship test) {
        int result = -1;
        String query = "SELECT * FROM shipconflict(?,?,?)";
        Tables.start();
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getImo());
            statement.setString(2, test.getCallSign());
            statement.setString(3, test.getMMSI());
            //System.out.println(statement);

            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.next()) {
                result = 0;
            } else {
                result = resultSet.getInt("sid");
            }


        } catch (SQLException e) {
            System.err.println("Could not test conflict IN apps" + e);
        }
        Tables.shutDown();
        return result;
    }

    private void constructShip(ArrayList<Ship> result, String query) {
        Ship ship;
        Tables.start();
        try {
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);

            ResultSet resultSet = statement.executeQuery();

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
        } catch (SQLException e) {
            System.err.println("Could not retrieve all ships" + e);
        }
        Tables.shutDown();
    }


}
