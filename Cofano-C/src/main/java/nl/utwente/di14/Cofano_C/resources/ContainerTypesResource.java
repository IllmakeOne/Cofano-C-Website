package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.ContainerType;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Resource class for container types.
 */
@Path("/containers")
public class ContainerTypesResource {

    private final String myName = "container_type";

    /**
     * @return a JSON array of all approved ContainerTypes
     */
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<ContainerType> getAllContainerTypes(
            @Context HttpServletRequest request) {
        Tables.start();
        ArrayList<ContainerType> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM container_type " +
                "WHERE approved = true";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                constructContainerType(result, resultSet);
            } catch (SQLException e) {
                System.err.println("Could not retrieve all approved containers" + e);
            }
        }
        return result;
    }

    private void constructContainerType(ArrayList<ContainerType> result, ResultSet resultSet)
            throws SQLException {
        while (resultSet.next()) {
            ContainerType container = new ContainerType();
            container.setDisplayName(resultSet.getString("display_name"));
            container.setId(resultSet.getInt("cid"));
            container.setIsoCode(resultSet.getString("iso_code"));
            container.setDescription(resultSet.getString("description"));
            container.setLength(resultSet.getInt("c_length"));
            container.setHeight(resultSet.getInt("c_height"));
            container.setReefer(resultSet.getBoolean("reefer"));

            result.add(container);
        }
    }

    /**
     * This is used for displaying unapproved entries, which await deletion or approval
     * this method only returns something if the request is coming from our website.
     *
     * @return an JSON array of unapproved ContainerType entries
     */
    @GET
    @Path("unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<ContainerType> getAllContainerTypesUN(
            @Context HttpServletRequest request) {
        Tables.start();
        ArrayList<ContainerType> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM container_type " +
                "WHERE approved = false";

        if (request.getSession().getAttribute("userEmail") != null) {
            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                constructContainerType(result, resultSet);
            } catch (SQLException e) {
                System.err.println("Could not retrieve all unapproved containers" + e);
            }
        }
        return result;
    }

    /**
     * This method retrieves a specific entry from the DB.
     *
     * @param containerId the ID of the container type
     * @return return the entry as an ContainerType object
     */
    @GET
    @Path("/{containerId}")
    @Produces(MediaType.APPLICATION_JSON)
    public ContainerType getContainer(@PathParam("containerId") int containerId,
                                      @Context HttpServletRequest request) {
        ContainerType container = new ContainerType();
        String query = "SELECT * FROM container_type WHERE cid = ?";

        if (!Tables.testRequest(request).equals("")) {

            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setInt(1, containerId);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    container.setDisplayName(resultSet.getString("display_name"));
                    container.setIsoCode(resultSet.getString("iso_code"));
                    container.setDescription(resultSet.getString("description"));
                    container.setLength(resultSet.getInt("c_length"));
                    container.setHeight(resultSet.getInt("c_height"));
                    container.setReefer(resultSet.getBoolean("reefer"));
                    container.setId(resultSet.getInt("cid"));
                }
            } catch (SQLException e) {
                System.err.println("could not get specific ContainerType");
                e.printStackTrace();
            }
        }
        return container;
    }

    /**
     * This function adds an entry to the database.
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
    public void addContainer(ContainerType input, @Context HttpServletRequest request) {
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
     * This method adds a ContainerType entry to the Database.
     *
     * @param entry the ContainerType about to be added
     * @param app   if the port is approved or not
     * @return the ID which is assigned to this container by the database
     */
    private int addEntry(ContainerType entry, boolean app) {
        String query = "SELECT addcontainer_type(?,?,?,?,?,?,?)";
        int rez = 0;
        //gets here if the request is from API
        //add to conflicts table
        try {
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
            //add the data to the statement's query
            statement.setString(1, entry.getDisplayName());
            statement.setString(2, entry.getIsoCode());
            statement.setString(3, entry.getDescription());
            statement.setInt(4, entry.getLength());
            statement.setInt(5, entry.getHeight());
            statement.setBoolean(6, entry.getReefer());
            statement.setBoolean(7, app);

            ResultSet res = statement.executeQuery();
            res.next();
            rez = res.getInt(1);
        } catch (SQLException e) {
            System.err.println("Could not add container types ");
            System.err.println(e.getSQLState());
            e.printStackTrace();
        }
        return rez;
    }

    /**
     * This method deletes an entry from a table and also adds it to history.
     *
     * @param containerId the id of the entry which is deleted
     */
    @DELETE
    @Path("/{containerId}")
    public void deleteContainer(@PathParam("containerId") int containerId,
                                @Context HttpServletRequest request) {
        Tables.start();
        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            ContainerType aux = getContainer(containerId, request);
            String query = "SELECT  deletecontainer_types(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setLong(1, containerId);
                statement.executeQuery();
            } catch (SQLException e) {
                System.err.println("Was not able to delete Container");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
            Tables.addHistoryEntry("DELETE", doer, aux.toString(), myName, true);
        }
    }


    /**
     * This method changes an entry in the database.
     *
     * @param containerId the ID of the entry about to be changed
     * @param container   the new information for the entry
     */
    @PUT
    @Path("/{containerId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateContainer(@PathParam("containerId") int containerId,
                                ContainerType container, @Context HttpServletRequest request) {

        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            ContainerType aux = getContainer(containerId, request);
            String query = "SELECT editcontainer_types(?,?,?,?,?,?,?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setString(2, container.getDisplayName());
                statement.setString(3, container.getIsoCode());
                statement.setString(4, container.getDescription());
                statement.setInt(5, container.getLength());
                statement.setInt(6, container.getHeight());
                statement.setBoolean(7, container.getReefer());
                statement.setInt(1, containerId);

                statement.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            }

            Tables.addHistoryEntry("UPDATE", doer,
                    aux.toString() + "-->" + container.toString(), myName, false);
        }

    }


    /**
     * This tests if there a new ContainerType creates a conflict in the DB if it is added.
     * it creates a conflict if the display_name or iso_code is the same as another entry in the DB
     *
     * @param test the ContainerType which is tested
     * @return the id of the port it is on conflict with , or 0 if there is no conflict
     */
    private int testConflict(ContainerType test) {
        int result = -1;
        String query = "SELECT * FROM containerconflict(?,?)";

        try {
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getDisplayName());
            statement.setString(2, test.getIsoCode());

            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.next()) {
                result = 0;
            } else {
                result = resultSet.getInt("cid");
            }
        } catch (SQLException e) {
            System.err.println("Could not test conflict IN apps" + e);
        }
        return result;
    }


}
