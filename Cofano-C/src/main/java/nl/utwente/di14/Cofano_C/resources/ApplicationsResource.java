package nl.utwente.di14.Cofano_C.resources;


import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Application;
import org.glassfish.jersey.servlet.ServletContainer;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.security.SecureRandom;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;


/**
 * This is the resource class for applications.
 */
@Path("/applications")
public class ApplicationsResource extends ServletContainer {


    private final String myName = "Application";


    /**
     * @return a JSON array of all approved Application
     */
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<Application> getAllApps(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Application> result = new ArrayList<>();

        if (request.getSession().getAttribute("userEmail") != null) {
            Application add;
            String query = "SELECT * FROM application";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    add = new Application();
                    add.setName(resultSet.getString(2));
                    add.setAPIKey(resultSet.getString(3));
                    add.setId(resultSet.getInt(1));
                    result.add(add);
                }
            } catch (SQLException e) {
                System.err.println("Could not retrieve all apps" + e);
            }
        }
        Tables.shutDown();
        return result;
    }


    @GET
    @Path("/generate")
    @Produces({MediaType.APPLICATION_JSON})
    public Application generateAPI(@Context HttpServletRequest request) {

        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[42];
        random.nextBytes(bytes);
        Base64.Encoder encoder = Base64.getUrlEncoder().withoutPadding();
        String token = encoder.encodeToString(bytes);

        Application newApp = new Application("New Application", token);

        Tables.start();

        String doer = Tables.testRequest(request);
        //tests if the person is allowed to make any modifications
        System.out.println("TEST");
        if (request.getSession().getAttribute("userEmail") != null) {
            String title = "ADD";

            //if there is no conflict
            Tables.addHistoryEntry(title, doer, newApp.toString(),
                    new Timestamp(System.currentTimeMillis()), myName);
            String query = "SELECT * FROM addapplications(?,?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setString(1, newApp.getName());
                statement.setString(2, newApp.getAPIKey());
                statement.executeQuery();

                try (ResultSet resultSet = statement.getResultSet()) {
                    while (resultSet.next()) {
                        System.out.println("Retrieved id:" + resultSet.getInt(1));
                        newApp.setId(resultSet.getInt(1));
                    }
                }


            } catch (SQLException e) {
                System.err.println("Could not add application");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
        }
        Tables.shutDown();
        return newApp;
    }


    /**
     * This method retrieves a specific entry from the DB.
     *
     * @param appID the ID of the application
     * @return return the entry as an Application object
     */
    @GET
    @Path("/{appid}")
    @Produces(MediaType.APPLICATION_JSON)
    public Application getApp(@PathParam("appid") int appID, @Context HttpServletRequest request) {
        Tables.start();
        Application app = new Application();
        String query = "SELECT * FROM application WHERE aid = ?";
        if (request.getSession().getAttribute("userEmail") != null) {
            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);
                statement.setInt(1, appID);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    app.setName(resultSet.getString(2));
                    app.setAPIKey(resultSet.getString(3));
                    app.setId(resultSet.getInt(1));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        Tables.shutDown();
        return app;
    }

//    /**
//     * this function adds an entry to the database.
//     * if it is from a user it is directly added and approved
//     * if not, it is added but not approved
//     *
//     * @param input   the entry about to be added
//     * @param request the request of the client
//     */
//    @SuppressWarnings("StatementWithEmptyBody")
//    @POST
//    @Path("add")
//    @Consumes(MediaType.APPLICATION_JSON)
//    public void addApp(Application input, @Context HttpServletRequest request) {
//        Tables.start();
//
//        String doer = Tables.testRequest(request);
//        //tests if the person is allowed to make any modifications
//        if (request.getSession().getAttribute("userEmail") != null) {
//            String title = "ADD";
//
//            if (!testConflict(input)) {
//                //if there is no conflict
//                Tables.addHistoryEntry(title, doer, input.toString(),
//                        new Timestamp(System.currentTimeMillis()), myName);
//                String query = "SELECT addapplications(?,?)";
//                try {
//                    PreparedStatement statement =
//                            Tables.getCon().prepareStatement(query);
//                    statement.setString(1, input.getName());
//                    statement.setString(2, input.getAPIKey());
//
//                    statement.executeQuery();
//                } catch (SQLException e) {
//                    System.err.println("Could not add application");
//                    System.err.println(e.getSQLState());
//                    e.printStackTrace();
//                }
//            } else {
//                //TODO
//                //what happens when there is a conflict
//            }
//        }
//    }

    /**
     * This method deletes an entry from a table and also adds it to history.
     *
     * @param appid the ID of the entry which is deleted
     */
    @DELETE
    @Path("/{appid}")
    public void deleteApp(@PathParam("appid") int appid, @Context HttpServletRequest request) {


        //retrieve the App about to be deleted
        if (request.getSession().getAttribute("userEmail") != null) {
            Application add = getApp(appid, request);
            //add the deletion to the history table
            String title = "DELETE";
            String doer = Tables.testRequest(request);
            Tables.start();
            Tables.addHistoryEntry(title, doer, add.toString(), myName, true);
            Tables.start();
            String query = "SELECT deleteapplications(?)";
            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);
                statement.setInt(1, appid);
                statement.executeQuery();
            } catch (SQLException e) {
                System.err.println("Was not able to delete APP");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
        }
        Tables.shutDown();
    }


    /**
     * this method changes an entry in the database.
     *
     * @param appid the ID of the entry about to be changed
     * @param app   the new information for the entry
     */
    @PUT
    @Path("/{appid}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateApp(@PathParam("appid") int appid,
                          Application app, @Context HttpServletRequest request) {

        Application aux = getApp(appid, request);
        Tables.start();
        if (request.getSession().getAttribute("userEmail") != null) {
            String query = "SELECT editapplications(?,?)";
            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);
                statement.setString(2, app.getName());
                statement.setInt(1, appid);
                statement.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        Tables.addHistoryEntry("UPDATE", Tables.testRequest(request),
                aux.toString() + " -->" + app.toString(), myName, false);
        Tables.shutDown();
    }


    /**
     * This tests if there a new Application creates a conflict in the DB if it is added
     * it creates a conflict if the name or API key is the same as another entry in the DB.
     *
     * @param test the Application which is tested
     * @return the id of the port it is on conflict with , or 0 if there is no conflict
     */
    private boolean testConflict(Application test) {
        boolean result = true;
        String query = "SELECT * FROM appsconflict(?,?)";
        Tables.start();
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getName());
            statement.setString(2, test.getAPIKey());
            ResultSet resultSet = statement.executeQuery();
            result = resultSet.next();
        } catch (SQLException e) {
            System.err.println("Could not test conflict IN apps" + e);
        }
        Tables.shutDown();
        return result;
    }


}



