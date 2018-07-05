package nl.utwente.di14.Cofano_C.resources;


import nl.utwente.di14.Cofano_C.auth.Secured;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Application;
import org.glassfish.jersey.servlet.ServletContainer;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.security.SecureRandom;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;


/**
 * This is the resource class for applications.
 */
@SuppressWarnings("CheckStyle")
@Path("/applications")
public class ApplicationsResource extends ServletContainer {


    private final String myName = "Application";


    /**
     * @return a JSON array of all approved Application
     */
    @GET
    @Secured
    @Produces({MediaType.APPLICATION_JSON})
    public List<Application> getAllApps(@Context HttpServletRequest request) {

        ArrayList<Application> result = new ArrayList<>();

        if (request.getSession().getAttribute("userEmail") != null) {
            String query = "SELECT * FROM application";
            try (Connection connection = Tables.getCon();  PreparedStatement statement =
                   connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {
                Application add;

                while (resultSet.next()) {
                    add = new Application();
                    add.setName(resultSet.getString(2));
                    add.setAPIKey(resultSet.getString(3));
                    add.setId(resultSet.getInt(1));
                    result.add(add);
                }
            } catch (SQLException e) {
                System.err.println("Could not retrieve all apps because: " + e);
                throw new InternalServerErrorException();
            }
        }

        return result;
    }


    @GET
    @Secured
    @Path("/generate")
    @Produces({MediaType.APPLICATION_JSON})
    public Application generateAPI(@Context HttpServletRequest request, @Context SecurityContext securityContext) {

        SecureRandom random = new SecureRandom();
        byte bytes[] = new byte[42];
        random.nextBytes(bytes);
        Base64.Encoder encoder = Base64.getUrlEncoder().withoutPadding();
        String token = encoder.encodeToString(bytes);

        Application newApp = new Application("New Application", token);

        String title = "ADD";

        //if there is no conflict
        String query = "SELECT * FROM addapplications(?,?)";
        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {
            connection.setAutoCommit(false);

            String doer = securityContext.getUserPrincipal().getName();

            HistoryResource.addHistoryEntry(connection, title, doer, newApp.toString(),
                    new Timestamp(System.currentTimeMillis()), myName);

            statement.setString(1, newApp.getName());
            statement.setString(2, newApp.getAPIKey());
            statement.executeQuery();

            try (ResultSet resultSet = statement.getResultSet()) {
                while (resultSet.next()) {
                    System.out.println("Retrieved id:" + resultSet.getInt(1));
                    newApp.setId(resultSet.getInt(1));
                }
            }

            connection.commit();

        } catch (SQLException e) {
            System.err.println("Could not add application");
            System.err.println(e.getSQLState());
            throw new InternalServerErrorException();
        }

        return newApp;
    }


    /**
     * This method retrieves a specific entry from the DB.
     *
     * @param appId the ID of the application
     * @return return the entry as an Application object
     */
    @GET
    @Secured
    @Path("/{appid}")
    @Produces(MediaType.APPLICATION_JSON)
    public Application retrieveApp(@PathParam("appid") int appId, @Context HttpServletRequest request) {
        Application app = null;
        try (Connection connection = Tables.getCon()) {
            app = getApp(connection, appId);
        } catch (SQLException e) {
            System.out.println("Something went wrong while getting app with id: " + appId + " because: " + e.getSQLState());
            throw new InternalServerErrorException();
        }
        return app;
    }

    // Internal only
    private Application getApp(Connection connection, int appId) throws SQLException{
        Application app = new Application();
        String query = "SELECT * FROM application WHERE aid = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, appId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    app.setName(resultSet.getString(2));
                    app.setAPIKey(resultSet.getString(3));
                    app.setId(resultSet.getInt(1));
                }
            }
        }

        return app;
    }

    /**
     * This method deletes an entry from a table and also adds it to history.
     *
     * @param appid the ID of the entry which is deleted
     */
    @DELETE
    @Secured
    @Path("/{appid}")
    public void deleteApp(@PathParam("appid") int appid, @Context HttpServletRequest request, @Context SecurityContext securityContext) {
        //retrieve the App about to be deleted

        //add the deletion to the history table

        String query = "SELECT deleteapplications(?)";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query)) {
            connection.setAutoCommit(false);

            Application add = getApp(connection, appid);
            String doer = securityContext.getUserPrincipal().getName();

            String title = "DELETE";

            HistoryResource.addHistoryEntry(connection, title, doer, add.toString(), myName, true);

            statement.setInt(1, appid);
            statement.executeQuery();
            connection.commit();
        } catch (SQLException e) {
            System.err.println("Was not able to delete APP with ID: " + appid);
            System.err.println(e.getSQLState());
            throw new InternalServerErrorException();
        }
    }


    /**
     * this method changes an entry in the database.
     *
     * @param appid the ID of the entry about to be changed
     * @param app   the new information for the entry
     */
    @PUT
    @Secured
    @Path("/{appid}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateApp(@PathParam("appid") int appid,
                          Application app, @Context HttpServletRequest request, @Context SecurityContext securityContext) {

        String query = "SELECT editapplications(?,?)";
        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query)) {

            connection.setAutoCommit(false);

            Application aux = getApp(connection, appid);


            statement.setString(2, app.getName());
            statement.setInt(1, appid);
            statement.executeQuery();
            HistoryResource.addHistoryEntry(connection, "UPDATE", securityContext.getUserPrincipal().getName(),
                    aux.toString() + " -->" + app.toString(), myName, false);
            connection.commit();

        } catch (SQLException e) {
            throw new InternalServerErrorException();
        }

    }


    /**
     * This tests if there a new Application creates a conflict in the DB if it is added
     * it creates a conflict if the name or API key is the same as another entry in the DB.
     *
     * @param test the Application which is tested
     * @return the id of the port it is on conflict with , or 0 if there is no conflict
     */
    private boolean testConflict(Connection connection, Application test) throws SQLException {
        boolean result = true;
        String query = "SELECT * FROM appsconflict(?,?)";

        try (PreparedStatement statement = Tables.getCon().prepareStatement(query)) {
            statement.setString(1, test.getName());
            statement.setString(2, test.getAPIKey());
            try (ResultSet resultSet = statement.executeQuery()) {
                result = resultSet.next();
            }
        }

        return result;
    }


}



