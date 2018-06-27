package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Undg;
import nl.utwente.di14.Cofano_C.model.UndgDescription;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@Path("/undgs")
class UndgsResource {


//	WE CAN USE THIS:
//	SELECT ud.description, undgs.*
//	FROM undgs_descriptions ud
//	INNER JOIN undgs ON undgs.uid = ud.undgs_id
//	WHERE ud.language = 'en'

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Undg> getAllUndgsBasic(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Undg> result = new ArrayList<>();

        String query = " SELECT ud.description, undgs.*" +
                " FROM undgs_descriptions ud" +
                " FULL OUTER JOIN undgs ON undgs.uid = ud.undgs_id" +
                " WHERE ud.language = 'en';";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();


                while (resultSet.next()) {
                    Undg undg = new Undg();
                    undg.setId(resultSet.getInt("uid"));
                    undg.setClassification(resultSet.getString("classification"));
                    undg.setClassificationCode(resultSet.getString("classification_code"));
                    undg.setCollective(resultSet.getBoolean("collective"));
                    undg.setHazardNo(resultSet.getString("hazard_no"));
                    undg.setNotApplicable(resultSet.getBoolean("not_applicable"));
                    undg.setPackingGroup(resultSet.getInt("packing_group"));
                    undg.setStation(resultSet.getString("station"));
                    undg.setTransportCategory(resultSet.getString("transport_category"));
                    undg.setTransportForbidden(resultSet.getBoolean("transport_forbidden"));
                    undg.setTunnelCode(resultSet.getString("tunnel_code"));
                    undg.setUnNo(resultSet.getInt("un_no"));
                    undg.setVehicleTankCarriage(resultSet.getString("vehicletank_carriage"));
                    //noinspection ArraysAsListWithZeroOrOneArgument
                    undg.setDescriptions(Arrays.asList(
                            new UndgDescription("en", resultSet.getString("description"))));
                    result.add(undg);

                }
            } catch (SQLException e) {
                System.err.println("Could not retrieve all undgs" + e);
            }
        }

        return result;

    }

    @GET
    @Path("/full")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Undg> getFullUndgs(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Undg> result = new ArrayList<>();
//		String query = "SELECT * " +
//				"FROM undgs "+
//				"WHERE approved = true";

        String query = "SELECT" +
                "  undgs.*," +
                "  ul.name   AS label," +
                "  ut.name   AS tankcode," +
                "  utsp.name AS tank_special_provision," +
                "  ud.language," +
                "  ud.description" +
                "  FROM undgs" +
                "  FULL OUTER JOIN undgs_has_label uhl on undgs.uid = uhl.uid" +
                "  FULL OUTER JOIN undgs_labels ul ON ul.ulid = uhl.ulid" +
                "  FULL OUTER JOIN undgs_has_tank_special_provision u on undgs.uid = u.uid" +
                "  FULL OUTER JOIN undgs_tank_special_provisions utsp on u.utsid = utsp.utsid" +
                "  FULL OUTER JOIN undgs_has_tankcode tankcode on undgs.uid = tankcode.uid" +
                "  FULL OUTER JOIN undgs_tankcodes ut on tankcode.utid = ut.utid" +
                "  FULL OUTER JOIN undgs_descriptions ud on undgs.uid = ud.undgs_id" +
                "  GROUP BY undgs.uid, label, tankcode, tank_special_provision, ud.language," +
                " ud.description" +
                "  ORDER BY undgs.uid;";

        String name = Tables.testRequest(request);
        if (!name.equals("")) {

            try {
                PreparedStatement statement = Tables.getCon().prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();

                Undg lastUndg = null;

                List<String> undgLabels = new ArrayList<>();
                List<String> tankSpecialProvisions = new ArrayList<>();
                List<String> tankCodes = new ArrayList<>();
                Map<String, UndgDescription> descriptions = new HashMap<>();


                while (resultSet.next()) {

                    if (lastUndg != null && lastUndg.getId() == resultSet.getInt("uid")) {
                        if (!undgLabels.contains(resultSet.getString("label"))) {
                            undgLabels.add(resultSet.getString("label"));
                        }
                        if (!tankSpecialProvisions.contains(resultSet.getString(
                                "tank_special_provision"))) {
                            tankSpecialProvisions.add(resultSet.getString(
                                    "tank_special_provision"));
                        }
                        if (!tankCodes.contains(resultSet.getString("tankcode"))) {
                            tankCodes.add(resultSet.getString("tankcode"));
                        }
                        if (!descriptions.containsKey(resultSet.getString("language"))) {
                            descriptions.put(resultSet.getString("language"),
                                    new UndgDescription(resultSet.getString("language"),
                                            resultSet.getString("description")));
                        }
                    } else {
                        if (lastUndg != null) {
                            lastUndg.setLabels(undgLabels);
                            lastUndg.setTankSpecialProvisions(tankSpecialProvisions);
                            lastUndg.setTankCode(tankCodes);
                            lastUndg.setDescriptions(new ArrayList<>(descriptions.values()));

                            result.add(lastUndg);

                            undgLabels = new ArrayList<>();
                            tankSpecialProvisions = new ArrayList<>();
                            tankCodes = new ArrayList<>();
                            descriptions = new HashMap<>();
                        }
                        Undg undg = new Undg();
                        undg.setId(resultSet.getInt("uid"));
                        undg.setClassification(resultSet.getString("classification"));
                        undg.setClassificationCode(resultSet.getString("classification_code"));
                        undg.setCollective(resultSet.getBoolean("collective"));
                        undg.setHazardNo(resultSet.getString("hazard_no"));
                        undg.setNotApplicable(resultSet.getBoolean("not_applicable"));
                        undg.setPackingGroup(resultSet.getInt("packing_group"));
                        undg.setStation(resultSet.getString("station"));
                        undg.setTransportCategory(resultSet.getString("transport_category"));
                        undg.setTransportForbidden(resultSet.getBoolean("transport_forbidden"));
                        undg.setTunnelCode(resultSet.getString("tunnel_code"));
                        undg.setUnNo(resultSet.getInt("un_no"));
                        undg.setVehicleTankCarriage(resultSet.getString("vehicletank_carriage"));

                        lastUndg = undg;

                    }


				/*	query = "SELECT * FROM undgs_descriptions WHERE undgs_id = ?";
					statement = Tables.getCon().prepareStatement(query);
					statement.setInt(1, undg.getId());
					ResultSet descriptionsResultSet = statement.executeQuery();
					List<UndgDescription> undgDescriptions = new ArrayList<UndgDescription>();
					while(descriptionsResultSet.next()) {
						UndgDescription description = new UndgDescription();
						description.setLanguage(descriptionsResultSet.getString("language"));
						description.setDescription(descriptionsResultSet.getString("description"));
						description.setId(descriptionsResultSet.getInt("udid"));
						description.setUndgID(undg.getId());

						undgDescriptions.add(description);
					}
					undg.setDescriptions(undgDescriptions);


					query = "SELECT ul.name" +
							" FROM undgs_has_label uhl" +
							" JOIN undgs_labels ul ON ul.ulid = uhl.ulid" +
							" WHERE uhl.uid = ?";

					statement = Tables.getCon().prepareStatement(query);
					statement.setInt(1, undg.getId());
					ResultSet labelsResultSet = statement.executeQuery();
					List<String> undgLabels = new ArrayList<String>();
					while(labelsResultSet.next()) {
						undgLabels.add(labelsResultSet.getString("name"));
					}
					undg.setLabels(undgLabels);

					query = "SELECT utsp.name" +
							" FROM undgs_has_tank_special_provision uhtsp" +
							" JOIN undgs_tank_special_provisions utsp ON utsp.utsid = uhtsp.utsid" +
							" WHERE uhtsp.uid = ?";

					statement = Tables.getCon().prepareStatement(query);
					statement.setInt(1, undg.getId());
					ResultSet tankSpecialProvisionsResultSet = statement.executeQuery();
					List<String> tankSpecialProvisions = new ArrayList<String>();
					while(tankSpecialProvisionsResultSet.next()) {
						tankSpecialProvisions.add(tankSpecialProvisionsResultSet.getString("name"));
					}
					undg.setTankSpecialProvisions(tankSpecialProvisions);


					query = "SELECT ut.name" +
							" FROM undgs_has_tankcode uht" +
							" JOIN undgs_tankcodes ut ON ut.utid = uht.utid" +
							" WHERE uht.uid = ?";

					statement = Tables.getCon().prepareStatement(query);
					statement.setInt(1, undg.getId());
					ResultSet tankcodesResultSet = statement.executeQuery();
					List<String> tankcodes = new ArrayList<String>();
					while(tankcodesResultSet.next()) {
						tankcodes.add(tankcodesResultSet.getString("name"));
					}
					undg.setTankCode(tankcodes);

					result.add(undg);*/
                }
            } catch (SQLException e) {
                System.err.println("Could not retrieve all undgs" + e);
            }
        }
        

        return result;

    }

 /*   @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addApp(ContainerType input, @Context HttpServletRequest request) {
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
            Tables.addHistoryEntry("CON", doer, ownID + " " + input.toString() +
            " con with " + con, myName, false);
        }


    }

    private int addEntry(ContainerType entry, boolean app) {
        String query = "SELECT addcontainer_type(?,?,?,?,?,?,?)";
        int rez = 0;
        //gets here if the request is from API
        //add to conflicts table
        try {
            PreparedStatement statement = (PreparedStatement) Tables.getCon()
            .prepareStatement(query);
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

    @DELETE
    @Path("/{containerId}")
    public void deleteShip(@PathParam("containerId") int containerId,
     @Context HttpServletRequest request) {
        Tables.start();

        String query = "DELETE FROM container_type WHERE cid = ?";
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setLong(1, containerId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Was not able to delete Container");
            System.err.println(e.getSQLState());
            e.printStackTrace();
        }
    }


    @GET
    @Path("/{containerId}")
    @Produces(MediaType.APPLICATION_JSON)
    public ContainerType getShip(@PathParam("containerId") int containerId,
    @Context HttpServletRequest request) {
        ContainerType container = new ContainerType();
        String query = "SELECT * FROM container_type WHERE cid = ?";

        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
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
            e.printStackTrace();
        }


        return container;
    }

    @PUT
    @Path("/{containerId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateContainer(@PathParam("containerId") int containerId,
    ContainerType container) {
        System.out.println("Joohoooo");
        System.out.print(containerId);
        String query = "UPDATE container_type SET display_name = ?, iso_code = ?,
        description = ?, c_length = ?, c_height = ?, reefer = ? WHERE cid = ?";
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, container.getDisplayName());
            statement.setString(2, container.getIsoCode());
            statement.setString(3, container.getDescription());
            statement.setInt(4, container.getLength());
            statement.setInt(5, container.getHeight());
            statement.setBoolean(6, container.getReefer());
            statement.setInt(7, containerId);

            statement.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


    private int testConflict(ContainerType test) {
        int result = 0;
        String query = "SELECT * FROM containerconflict(?,?)";

        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
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
        return result;*/


}
