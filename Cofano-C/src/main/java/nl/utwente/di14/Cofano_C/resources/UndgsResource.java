package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.auth.Secured;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.exceptions.InternalServerErrorException;
import nl.utwente.di14.Cofano_C.model.Terminal;
import nl.utwente.di14.Cofano_C.model.Undg;
import nl.utwente.di14.Cofano_C.model.UndgDescription;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;

import java.sql.*;
import java.util.*;

@Path("/undgs")
public class UndgsResource {

	private String myName = "undgs";

//	WE CAN USE THIS:
//	SELECT ud.description, undgs.*
//	FROM undgs_descriptions ud
//	INNER JOIN undgs ON undgs.uid = ud.undgs_id
//	WHERE ud.language = 'en'

    @GET
    @Secured
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Undg> getAllUndgsBasic(@Context HttpServletRequest request) {
        ArrayList<Undg> result = new ArrayList<>();

        String query = " SELECT ud.description, undgs.*" +
                " FROM undgs_descriptions ud" +
                " FULL OUTER JOIN undgs ON undgs.uid = ud.undgs_id" +
                " WHERE ud.language = 'en';";

        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Undg undg = constructUndg(new Undg(), resultSet);
                undg.setDescriptions(Arrays.asList(
                        new UndgDescription("en", resultSet.getString("description"))));
                result.add(undg);
            }
        } catch (SQLException e) {
            System.err.println("Could not retrieve all undgs" + e);
            e.printStackTrace();
            throw new InternalServerErrorException();

        }

        return result;

    }

    @GET
    @Secured
    @Path("/full")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Undg> getFullUndgs(@Context HttpServletRequest request) {


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
                "  GROUP BY undgs.uid, label, tankcode, tank_special_provision, ud.language, ud.description" +
                "  ORDER BY undgs.uid;";


        return constructUndgs(query);

    }

    @GET
    @Secured
    @Path("/full/unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Undg> getFullUnapprovedUndgs(@Context HttpServletRequest request) {

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
                "  WHERE undgs.approved = FALSE" +
                "  GROUP BY undgs.uid, label, tankcode, tank_special_provision, ud.language, ud.description" +
                "  ORDER BY undgs.uid;";

        return constructUndgs(query);

    }

    private ArrayList<Undg> constructUndgs(String query) {
        ArrayList<Undg> result = new ArrayList<>();

        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            Undg lastUndg = null;

            List<String> undgLabels = new ArrayList<>();
            List<String> tankSpecialProvisions = new ArrayList<>();
            List<String> tankcodes = new ArrayList<>();
            Map<String, UndgDescription> descriptions = new HashMap<>();


            while (resultSet.next()) {

                if (lastUndg != null && lastUndg.getId() == resultSet.getInt("uid")) {
                    if (!undgLabels.contains(resultSet.getString("label"))) {
                        undgLabels.add(resultSet.getString("label"));
                    }
                    if (!tankSpecialProvisions.contains(resultSet.getString("tank_special_provision"))) {
                        tankSpecialProvisions.add(resultSet.getString("tank_special_provision"));
                    }
                    if (!tankcodes.contains(resultSet.getString("tankcode"))) {
                        tankcodes.add(resultSet.getString("tankcode"));
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
                        lastUndg.setTankCode(tankcodes);
                        lastUndg.setDescriptions(new ArrayList<>(descriptions.values()));

                        result.add(lastUndg);

                        undgLabels = new ArrayList<>();
                        tankSpecialProvisions = new ArrayList<>();
                        tankcodes = new ArrayList<>();
                        descriptions = new HashMap<>();
                    }
                    Undg undg = constructUndg(new Undg(), resultSet);

                    undgLabels.add(resultSet.getString("label"));
                    tankSpecialProvisions.add(resultSet.getString("tank_special_provision"));
                    tankcodes.add(resultSet.getString("tankcode"));
                    descriptions.put(resultSet.getString("language"),
                            new UndgDescription(resultSet.getString("language"),
                                    resultSet.getString("description")));

                    lastUndg = undg;

                }
            }
        } catch (SQLException e) {
            System.err.println("Could not retrieve all undgs" + e);
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return result;
    }


    @GET
    @Secured
    @Path("/{undgsId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Undg retrieveUndg(@PathParam("undgsId") int undgsId,
                             @Context HttpServletRequest request) {

        Undg undg;

        try (Connection connection = Tables.getCon()){
            undg = getUndg(connection, undgsId);
        } catch (SQLException e) {
            System.err.println("Something went wrong retrieving undgs " + undgsId + ", because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return undg;


    }

    //Internal only
    private Undg getUndg(Connection connection, int undgsId) throws SQLException {
        Undg undg = new Undg();

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
                "  WHERE undgs.uid = ?" +
                "  GROUP BY undgs.uid, label, tankcode, tank_special_provision, ud.language, ud.description" +
                "  ORDER BY undgs.uid;";



        try (PreparedStatement statement =
             connection.prepareStatement(query)) {
            statement.setInt(1, undgsId);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<String> undgLabels = new ArrayList<>();
                List<String> tankSpecialProvisions = new ArrayList<>();
                List<String> tankcodes = new ArrayList<>();
                Map<String, UndgDescription> descriptions = new HashMap<>();


                while (resultSet.next()) {

                    if (undg.getId() != 0) {
                        if (!undgLabels.contains(resultSet.getString("label"))) {
                            undgLabels.add(resultSet.getString("label"));
                        }
                        if (!tankSpecialProvisions.contains(resultSet.getString("tank_special_provision"))) {
                            tankSpecialProvisions.add(resultSet.getString("tank_special_provision"));
                        }
                        if (!tankcodes.contains(resultSet.getString("tankcode"))) {
                            tankcodes.add(resultSet.getString("tankcode"));
                        }
                        if (!descriptions.containsKey(resultSet.getString("language"))) {
                            descriptions.put(resultSet.getString("language"),
                                    new UndgDescription(resultSet.getString("language"),
                                            resultSet.getString("description")));
                        }
                    } else {
                        undg = constructUndg(undg, resultSet);

                        undgLabels.add(resultSet.getString("label"));
                        tankSpecialProvisions.add(resultSet.getString("tank_special_provision"));
                        tankcodes.add(resultSet.getString("tankcode"));
                        descriptions.put(resultSet.getString("language"),
                                new UndgDescription(resultSet.getString("language"),
                                        resultSet.getString("description")));

                    }
                }

                undg.setLabels(undgLabels);
                undg.setTankSpecialProvisions(tankSpecialProvisions);
                undg.setTankCode(tankcodes);
                undg.setDescriptions(new ArrayList<>(descriptions.values()));

            }
        }

        return undg;
    }

    private Undg constructUndg(Undg undg, ResultSet resultSet) throws SQLException {
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


        return undg;
    }

    @GET
    @Secured
    @Path("labels")
    @Produces({MediaType.APPLICATION_JSON})
    public List getAvailableLabels(@Context HttpServletRequest request) {
        List<Map> result = new ArrayList<>();

        String query = "SELECT * FROM undgs_labels";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", resultSet.getString("ulid"));
                item.put("name", resultSet.getString("name"));

                result.add(item);
            }

        } catch (SQLException e) {
            System.err.println("Could not retrieve all labels: " + e);
            throw new InternalServerErrorException();
        }

        return result;
    }

    @GET
    @Secured
    @Path("tankcodes")
    @Produces({MediaType.APPLICATION_JSON})
    public List getAvailableTankCodes(@Context HttpServletRequest request) {
        List<Map> result = new ArrayList<>();

        String query = "SELECT * FROM undgs_tankcodes";

        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()){

            while (resultSet.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", resultSet.getString("utid"));
                item.put("name", resultSet.getString("name"));

                result.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Could not retrieve all tank codes" + e);
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return result;
    }

    @GET
    @Secured
    @Path("tankspecialprovisions")
    @Produces({MediaType.APPLICATION_JSON})
    public List getAvailableTankSpecialProvisions(@Context HttpServletRequest request) {

        List<Map> result = new ArrayList<>();

        String query = "SELECT * FROM undgs_tank_special_provisions";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()){

            while (resultSet.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", resultSet.getString("utsid"));
                item.put("name", resultSet.getString("name"));

                result.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Could not retrieve all tank special provisions" + e);
        }

        return result;
    }


    @PUT
    @Secured
    @Path("/{undgsId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateContainer(@PathParam("undgsId") int undgsId, Undg undg) {

        String query = "UPDATE undgs" +
                " SET classification = ?," +
                " classification_code = ?," +
                " collective = ?,  " +
                " hazard_no = ?," +
                " not_applicable = ?," +
                " packing_group = ?," +
                " station = ?," +
                " transport_category = ?," +
                " transport_forbidden = ?," +
                " tunnel_code = ?," +
                " un_no = ?," +
                " vehicletank_carriage = ?" +
                " WHERE uid = ?";

        try (Connection connection = Tables.getCon();
             PreparedStatement statement = connection.prepareStatement(query)) {
            connection.setAutoCommit(false);

            statement.setString(1, undg.getClassification());
            statement.setString(2, undg.getClassificationCode());
            statement.setBoolean(3, undg.isCollective());
            statement.setString(4, undg.getHazardNo());
            statement.setBoolean(5, undg.isNotApplicable());
            statement.setInt(6, undg.getPackingGroup());
            statement.setString(7, undg.getStation());
            statement.setString(8, undg.getTransportCategory());
            statement.setBoolean(9, undg.isTransportForbidden());
            statement.setString(10, undg.getTunnelCode());
            statement.setInt(11, undg.getUnNo());
            statement.setString(12, undg.getVehicleTankCarriage());
            statement.setInt(13, undgsId);

            labelBuilder(connection, undgsId, undg);
            tankSpecialProvisionsBuilder(connection, undgsId, undg);
            tankCodeBuilder(connection, undgsId, undg);

            descriptionBuilder(connection, undgsId, undg);

            cleanup(connection);

            statement.executeUpdate();

            connection.commit();

        } catch (SQLException e) {
            System.err.println("Something went wrong while editing Undg " + undgsId + ", because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

    }

    @POST
    @Secured
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addUndg(Undg undg, @Context HttpServletRequest request) {

        String query = "INSERT INTO undgs(classification, classification_code, collective, hazard_no, not_applicable, " +
                "packing_group, station, transport_category, transport_forbidden, tunnel_code, un_no, vehicletank_carriage)" +
                " VALUES(?," +
                "  ?," +
                "  ?,  " +
                "  ?," +
                "  ?," +
                "  ?," +
                "  ?," +
                "  ?," +
                "  ?," +
                "  ?," +
                "  ?," +
                "  ?);";

        try (Connection connection = Tables.getCon(); PreparedStatement statement =
                connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            connection.setAutoCommit(false);

            statement.setString(1, undg.getClassification());
            statement.setString(2, undg.getClassificationCode());
            statement.setBoolean(3, undg.isCollective());
            statement.setString(4, undg.getHazardNo());
            statement.setBoolean(5, undg.isNotApplicable());
            statement.setInt(6, undg.getPackingGroup());
            statement.setString(7, undg.getStation());
            statement.setString(8, undg.getTransportCategory());
            statement.setBoolean(9, undg.isTransportForbidden());
            statement.setString(10, undg.getTunnelCode());
            statement.setInt(11, undg.getUnNo());
            statement.setString(12, undg.getVehicleTankCarriage());
            statement.executeUpdate();

            int undgsId = 0;
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    undgsId = generatedKeys.getInt("uid");
                }
            }

            labelBuilder(connection, undgsId, undg);
            tankSpecialProvisionsBuilder(connection, undgsId, undg);
            tankCodeBuilder(connection, undgsId, undg);
            descriptionBuilder(connection, undgsId, undg);

            statement.executeUpdate();


            connection.commit();
        } catch (SQLException e) {
            System.err.println("Something went wrong while adding a UNDG because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

    }

    @DELETE
    @Secured
    @Path("/{undgsId}/description/{lang}")
    public void removeDescription(@PathParam("undgsId") int undgsId, @PathParam("lang") String lang) {
        String query = "DELETE FROM undgs_descriptions WHERE undgs_id = ? AND language = ?";

        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, undgsId);
            statement.setString(2, lang);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Was not able to delete undgs description");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }

    @DELETE
    @Secured
    @Path("/{undgsId}")
    public void deleteUndg(@PathParam("undgsId") int undgsId, @Context HttpServletRequest request) {

        String sql = "DELETE FROM undgs WHERE uid = ?";
        try (Connection connection = Tables.getCon(); PreparedStatement DELETEStatement = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);

            // Everything cascades!
            DELETEStatement.setInt(1, undgsId);
            DELETEStatement.executeUpdate();

            // Now cleanup:
            cleanup(connection);

            connection.commit();


        } catch (SQLException e) {
            System.err.println("Was not able to delete Undgs: ");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }

    
    /**
     * this method approves an entry in the database.
     *
     * @param undgsid the id of the terminal which is approved
     */
    @PUT
    @Secured
    @Path("/approve/{undgsid}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void approveContainer(@PathParam("undgsid") int undgsid,
                                 @Context HttpServletRequest request, @Context SecurityContext securityContext) {


        String query = "SELECT approveundgs(?)";

        try (Connection connection = Tables.getCon();PreparedStatement statement =
                connection.prepareStatement(query) ) {
            connection.setAutoCommit(false);
            Undg aux = getUndg(connection, undgsid);

            statement.setInt(1, undgsid);
            statement.executeQuery();

            HistoryResource.addHistoryEntry(connection, "APPROVE",
                    securityContext.getUserPrincipal().getName(),
                    aux.toString(), myName, true);

            connection.commit();

        } catch (SQLException e) {
            System.out.println("Something went wrong while approving terminal " + undgsid + ", because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

    }
    
    @DELETE
    @Secured
    @Path("/unapproved/{undgsId}")
    public void deleteUndgUN(@PathParam("undgsId") int undgsId, @Context HttpServletRequest request) {

        String sql = "DELETE FROM undgs WHERE uid = ?";
        try (Connection connection = Tables.getCon(); PreparedStatement DELETEStatement = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);

            // Everything cascades!
            DELETEStatement.setInt(1, undgsId);
            DELETEStatement.executeUpdate();

            // Now cleanup:
            cleanup(connection);

            connection.commit();


        } catch (SQLException e) {
            System.err.println("Was not able to delete Undgs: ");
            System.err.println(e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }
    }

    private void descriptionBuilder(Connection connection, int undgsId, Undg undg) throws SQLException {

        StringBuilder descriptionBuilder = new StringBuilder();
        descriptionBuilder.append("WITH undgs as (SELECT ? as id)," +
                " data (language, description) AS (" +
                "    VALUES");

        for (int i = 1; i <= undg.getDescriptions().size(); i++) {
            descriptionBuilder.append("(?, ?)");
            if (i != undg.getDescriptions().size()) {
                descriptionBuilder.append(", ");
            }
        }

        descriptionBuilder.append(
                "), upsert AS (" +
                        "    UPDATE undgs_descriptions ud" +
                        "    SET description = d.description" +
                        "    FROM data d, undgs" +
                        "    WHERE ud.language = d.language" +
                        "    AND ud.undgs_id = undgs.id" +
                        "    RETURNING ud.*" +
                        ")" +
                        " INSERT INTO undgs_descriptions (language, description, undgs_id)" +
                        " SELECT data.language, data.description, undgs.id" +
                        " FROM data, undgs" +
                        " WHERE NOT EXISTS (" +
                        "  SELECT 1" +
                        "  FROM upsert up" +
                        "  WHERE up.language = data.language" +
                        "  AND up.undgs_id = undgs.id" +
                        ")");


        try (PreparedStatement descriptionStatement = connection.prepareStatement((descriptionBuilder.toString()))) {
            descriptionStatement.setInt(1, undgsId);
            for (int i = 1; i <= undg.getDescriptions().size(); i++) {
                descriptionStatement.setString(i * 2, undg.getDescriptions().get(i - 1).getLanguage());
                descriptionStatement.setString(i * 2 + 1, undg.getDescriptions().get(i - 1).getDescription());
            }

            descriptionStatement.executeUpdate();
        }

    }

    private void tankCodeBuilder(Connection connection, int undgsId, Undg undg) throws SQLException {
        if (undg.getTankCode().size() > 0) {

            try (PreparedStatement deleteTankCodesStatement = connection.prepareStatement(
                    "DELETE FROM undgs_has_tankcode" +
                            " WHERE uid = ?"
            )) {
                deleteTankCodesStatement.setInt(1, undgsId);
                deleteTankCodesStatement.execute();
            }


            StringBuilder tankCodesQueryBuilder = new StringBuilder();
            tankCodesQueryBuilder.append(
                    "WITH undgs as (SELECT ? as id)," +
                            " data (name) AS (" +
                            "		VALUES ");
            for (int i = 1; i <= undg.getTankCode().size(); i++) {
                tankCodesQueryBuilder.append("(?)");
                if (i != undg.getTankCode().size()) {
                    tankCodesQueryBuilder.append(", ");
                }
            }

            tankCodesQueryBuilder.append("), s AS (" +
                    "    SELECT utid, ut.name" +
                    "    FROM undgs_tankcodes ut, data d" +
                    "    WHERE ut.name = d.name" +
                    "), i AS (" +
                    "    INSERT INTO undgs_tankcodes (name)" +
                    "    SELECT d.name FROM data d" +
                    "    WHERE NOT EXISTS (SELECT 1 FROM undgs_tankcodes ut WHERE ut.name = d.name)" +
                    "    returning utid, name" +
                    "), c AS (" +
                    "  SELECT utid, name FROM s" +
                    "  UNION ALL" +
                    "  SELECT utid, name FROM i" +
                    ")" +
                    "" +
                    "INSERT INTO undgs_has_tankcode (uid, utid)" +
                    "  SELECT undgs.id, c.utid" +
                    "  FROM c, undgs" +
                    "  WHERE NOT EXISTS (" +
                    "    SELECT 1" +
                    "    FROM undgs_tankcodes, undgs_has_tankcode" +
                    "    WHERE undgs_tankcodes.name = c.name" +
                    "    AND undgs_has_tankcode.uid = undgs.id" +
                    "    AND undgs_has_tankcode.utid = undgs_tankcodes.utid" +
                    ")");

            try (PreparedStatement tankCodeProvisionStatement =
                         connection.prepareStatement(tankCodesQueryBuilder.toString())){
                tankCodeProvisionStatement.setInt(1, undgsId);

                for (int i = 1; i <= undg.getTankCode().size(); i++) {
                    tankCodeProvisionStatement.setString(i + 1, undg.getTankCode().get(i - 1));
                }
                tankCodeProvisionStatement.executeUpdate();
            }

        }
    }

    private void tankSpecialProvisionsBuilder(Connection connection, int undgsId, Undg undg) throws SQLException {
        if (undg.getTankSpecialProvisions().size() > 0) {

            try (PreparedStatement deleteTankSpecialProvisionsStatement = connection.prepareStatement(
                    "DELETE FROM undgs_has_tank_special_provision" +
                            " WHERE uid = ?"
            )) {
                deleteTankSpecialProvisionsStatement.setInt(1, undgsId);
                deleteTankSpecialProvisionsStatement.execute();
            }

            StringBuilder tankSpecialProvisionsQueryBuilder = new StringBuilder();
            tankSpecialProvisionsQueryBuilder.append(
                    "WITH undgs as (SELECT ? as id)," +
                            " data (name) AS (" +
                            "		VALUES ");
            for (int i = 1; i <= undg.getTankSpecialProvisions().size(); i++) {
                tankSpecialProvisionsQueryBuilder.append("(?)");
                if (i != undg.getTankSpecialProvisions().size()) {
                    tankSpecialProvisionsQueryBuilder.append(", ");
                }
            }

            tankSpecialProvisionsQueryBuilder.append("), s AS (" +
                    "    SELECT utsid, utsp.name" +
                    "    FROM undgs_tank_special_provisions utsp, data d" +
                    "    WHERE utsp.name = d.name" +
                    "), i AS (" +
                    "    INSERT INTO undgs_tank_special_provisions (name)" +
                    "    SELECT d.name FROM data d" +
                    "    WHERE NOT EXISTS (SELECT 1 FROM undgs_tank_special_provisions utsp WHERE utsp.name = d.name)" +
                    "    returning utsid, name" +
                    "), c AS (" +
                    "  SELECT utsid, name FROM s" +
                    "  UNION ALL" +
                    "  SELECT utsid, name FROM i" +
                    ")" +
                    "" +
                    "INSERT INTO undgs_has_tank_special_provision (uid, utsid)" +
                    "  SELECT undgs.id, c.utsid" +
                    "  FROM c, undgs" +
                    "  WHERE NOT EXISTS (" +
                    "    SELECT 1" +
                    "    FROM undgs_tank_special_provisions, undgs_has_tank_special_provision" +
                    "    WHERE undgs_tank_special_provisions.name = c.name" +
                    "    AND undgs_has_tank_special_provision.uid = undgs.id" +
                    "    AND undgs_has_tank_special_provision.utsid = undgs_tank_special_provisions.utsid" +
                    ")");

            try (PreparedStatement tankSpecialProvisionStatement = connection.prepareStatement(tankSpecialProvisionsQueryBuilder.toString())) {
                tankSpecialProvisionStatement.setInt(1, undgsId);

                for (int i = 1; i <= undg.getTankSpecialProvisions().size(); i++) {
                    tankSpecialProvisionStatement.setString(i + 1, undg.getTankSpecialProvisions().get(i - 1));
                }
//                System.out.println(tankSpecialProvisionStatement.toString());
                tankSpecialProvisionStatement.executeUpdate();
            }
        }
    }

    private void labelBuilder(Connection connection, int undgsId, Undg undg) throws SQLException {
        if (undg.getLabels().size() > 0) {

            try (PreparedStatement deleteLabelsStatement = connection.prepareStatement(
                    "DELETE FROM undgs_has_label" +
                            " WHERE uid = ?"
            )) {
                deleteLabelsStatement.setInt(1, undgsId);
                deleteLabelsStatement.execute();
            }

            StringBuilder labelQueryBuilder = new StringBuilder();
            labelQueryBuilder.append(
                    "WITH undgs as (SELECT ? as id)," +
                            " data (name) AS (" +
                            "		VALUES ");
            for (int i = 1; i <= undg.getLabels().size(); i++) {
                labelQueryBuilder.append("(?)");
                if (i != undg.getLabels().size()) {
                    labelQueryBuilder.append(", ");
                }
            }

            labelQueryBuilder.append("), s AS (" +
                    "    SELECT ulid, ul.name" +
                    "    FROM undgs_labels ul, data d" +
                    "    WHERE ul.name = d.name" +
                    "), i AS (" +
                    "    INSERT INTO undgs_labels (name)" +
                    "    SELECT d.name FROM data d" +
                    "    WHERE NOT EXISTS (SELECT 1 FROM undgs_labels ul WHERE ul.name = d.name)" +
                    "    returning ulid, name" +
                    "), c AS (" +
                    "  SELECT ulid, name FROM s" +
                    "  UNION ALL" +
                    "  SELECT ulid, name FROM i" +
                    ")" +
                    "" +
                    "INSERT INTO undgs_has_label (uid, ulid)" +
                    "  SELECT undgs.id, c.ulid" +
                    "  FROM c, undgs" +
                    "  WHERE NOT EXISTS (" +
                    "    SELECT 1" +
                    "    FROM undgs_labels, undgs_has_label" +
                    "    WHERE undgs_labels.name = c.name" +
                    "    AND undgs_has_label.uid = undgs.id" +
                    "    AND undgs_has_label.ulid = undgs_labels.ulid" +
                    ")");

            try (PreparedStatement labelStatement = connection.prepareStatement(labelQueryBuilder.toString())) {
                labelStatement.setInt(1, undgsId);

                for (int i = 1; i <= undg.getLabels().size(); i++) {
                    labelStatement.setString(i + 1, undg.getLabels().get(i - 1));
                }
//                System.out.println(labelStatement.toString());
                labelStatement.executeUpdate();
            }

        }
    }



    private void cleanup(Connection connection) throws SQLException {
            try (PreparedStatement cleanUpStatement = connection.prepareStatement(
                    "DELETE FROM undgs_labels" +
                            " WHERE NOT EXISTS (" +
                            "    SELECT 1" +
                            "    FROM undgs_has_label" +
                            "    WHERE undgs_has_label.ulid = ulid" +
                            ");")
            ) {
                cleanUpStatement.execute();
            }

            try (PreparedStatement cleanUpProvisionsStatement = connection.prepareStatement(
                    "DELETE FROM undgs_tank_special_provisions" +
                            " WHERE NOT EXISTS (" +
                            "    SELECT 1" +
                            "    FROM undgs_has_tank_special_provision" +
                            "    WHERE undgs_has_tank_special_provision.utsid = utsid" +
                            ");")
            ) {
                cleanUpProvisionsStatement.execute();
            }

            try (PreparedStatement cleanUpTankCodeStatement = connection.prepareStatement(
                    "DELETE FROM undgs_tankcodes" +
                            " WHERE NOT EXISTS (" +
                            "    SELECT 1" +
                            "    FROM undgs_has_tankcode" +
                            "    WHERE undgs_has_tankcode.utid = utid" +
                            ");")
            ) {
                cleanUpTankCodeStatement.execute();
            }
    }


	/*@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addApp(ContainerType input, @Context HttpServletRequest request) {
		Tables.start();


		int ownID = 0;
		String title = "ADD";
		String doer = Tables.testRequest(request);

		int con = testConflict(input);


		if(request.getSession().getAttribute("userEmail")!=null && con == 0 ) {
			//if its from a cofano employee and it doesnt create conflcit, add straight to db
			ownID = addEntry(input,true);
			Tables.addHistoryEntry(title, doer, input.toString(),myname,true);
		} else if(request.getSession().getAttribute("userEmail")!=null && con != 0 ) {
			//if its froma cofano emplyee and it create sconflcit, add but unapproved
			ownID = addEntry(input,false);

			Tables.addHistoryEntry(title, doer, input.toString(),myname,false);
		} else if(!doer.equals("")) {
			//if its from an api add to unapproved
			ownID = addEntry(input,false);
			Tables.addHistoryEntry(title, doer, input.toString(),myname,false);
		}

		if(con != 0) {
			//if it creates a conflcit, add it to conflict table
			Tables.addtoConflicts(myname, doer, ownID, con);
			//add to history
			Tables.addHistoryEntry("CON", doer, ownID + " " + input.toString()+" con with "+con,myname,false);
		}


	}

	public int addEntry(ContainerType entry, boolean app) {
		String query = "SELECT addcontainer_type(?,?,?,?,?,?,?)";
		int rez =0;
		//gets here if the request is from API
		//add to conflicts table
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(1, entry.getDisplayName());
			statement.setString(2,entry.getIsoCode());
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
	public void deletShip(@PathParam("containerId") int containerId, @Context HttpServletRequest request) {
		Tables.start();

		String query ="DELETE FROM container_type WHERE cid = ?";
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
	public ContainerType getShip(@PathParam("containerId") int containerId, @Context HttpServletRequest request) {
		ContainerType container = new ContainerType();
		String query = "SELECT * FROM container_type WHERE cid = ?";

		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setInt(1, containerId);
			ResultSet resultSet = statement.executeQuery();

			while(resultSet.next()) {
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
	public void updateContainer(@PathParam("containerId") int containerId, ContainerType container) {
		System.out.println("Joohoooo");
		System.out.print(containerId);
		String query = "UPDATE container_type SET display_name = ?, iso_code = ?, description = ?, c_length = ?, c_height = ?, reefer = ? WHERE cid = ?";
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




	public int testConflict(ContainerType test) {
		int result = 0;
		String query = "SELECT * FROM containerconflict(?,?)";

		try {
			PreparedStatement statement = Tables.getCon().prepareStatement(query);
			statement.setString(1, test.getDisplayName());
			statement.setString(2, test.getIsoCode());

			ResultSet resultSet = statement.executeQuery();

			if(!resultSet.next()) {
				result = 0;
			} else {
				result = resultSet.getInt("cid");
			}

		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}*/

}