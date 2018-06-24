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
import java.sql.Timestamp;
import java.util.ArrayList;

@Path("/ships")
public class ShipsResource {


    private String myName = "Ship";

    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addShip(Ship input, @Context HttpServletRequest request) {
        Tables.start();

        String title = "ADD";
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            System.out.println(doer);
            //if there is no conflict
            if (!testConflict(input)) {

                System.out.println("Received from client request " + input.toString());

                String query = "SELECT addships(?,?,?,?,?)";

                try {
                    //Create prepared statement
                    PreparedStatement statement = Tables.getCon().prepareStatement(query);
                    //add the data to the statement's query
                    statement.setString(1, input.getName());
                    statement.setString(2, input.getImo());
                    statement.setString(3, input.getCallSign());
                    statement.setString(4, input.getMMSI());
                    statement.setBigDecimal(5, input.getDepth());

                    statement.executeQuery();

                    //add to history
                    Tables.addHistoryEntry(title, doer, input.toString(),
                            new Timestamp(System.currentTimeMillis()), myName);
                } catch (SQLException e) {
                    System.err.println("Could not add ship");
                    System.err.println(e.getSQLState());
                    e.printStackTrace();
                }
            } else {
                //TODO
                //what happens when conflict
            }
        }

    }

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Ship> getAllApps(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Ship> result = new ArrayList<>();
        Ship ship = new Ship();
        String query = "SELECT * " +
                "FROM ship";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    //System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
                    //		resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));
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
                System.err.println("Could not retrive all apps" + e);
            }
        }

        return result;

    }

    private boolean testConflict(Ship test) {
        boolean result = true;
        String query = "SELECT * FROM shipconflict(?,?,?)";

        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getImo());
            statement.setString(2, test.getCallSign());
            statement.setString(3, test.getMMSI());

            ResultSet resultSet = statement.executeQuery();

            result = resultSet.next();

        } catch (SQLException e) {
            System.err.println("Could not test conflcit IN apps" + e);
        }
        return result;
    }


    @DELETE
    @Path("/{shipId}")
    public void deletShip(@PathParam("shipId") int shipId, @Context HttpServletRequest request) {
        Tables.start();

        String query = "DELETE FROM ship WHERE sid = ?";
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setLong(1, shipId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Was not able to delete APP");
            System.err.println(e.getSQLState());
            e.printStackTrace();
        }
    }


    @GET
    @Path("/{shipId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Ship getShip(@PathParam("shipId") int shipId, @Context HttpServletRequest request) {
        Ship ship = new Ship();
        String query = "SELECT * FROM ship WHERE sid = ?";

        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
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


        return ship;
    }

    @PUT
    @Path("/{shipId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateApp(@PathParam("shipId") int shipId, Ship ship) {
        System.out.println("JOOOOOSOSKSOKSOSKSOKS");

        String query = "UPDATE ship SET imo = ?, name = ?, callsign = ?, mmsi = ?, ship_depth = ? WHERE sid = ?";
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, ship.getImo());
            statement.setString(2, ship.getName());
            statement.setString(3, ship.getCallSign());
            statement.setString(4, ship.getMMSI());
            statement.setBigDecimal(5, ship.getDepth());
            statement.setInt(6, shipId);
            statement.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


}
