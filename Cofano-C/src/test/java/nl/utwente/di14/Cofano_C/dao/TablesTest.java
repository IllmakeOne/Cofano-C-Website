package nl.utwente.di14.Cofano_C.dao;

import org.apache.commons.dbcp2.BasicDataSource;
import org.junit.After;
import org.junit.Test;

import java.sql.*;

import static nl.utwente.di14.Cofano_C.dao.Tables.getInstance;
import static org.junit.Assert.*;

public class TablesTest {

    private final Tables tables = new Tables();

    private final BasicDataSource basicDataSource = new BasicDataSource();


    @Test
    public void getInstanceTest() {
        assertNotNull(getInstance());
    }

    @Test
    public void getBds() {
        assertNotNull(tables.getBds());
    }

    @Test
    public void setBds() {
        tables.setBds(basicDataSource);
        assertEquals(basicDataSource, tables.getBds());
    }

    @Test
    public void getCon() {
        try {
            assertNotNull(Tables.getCon());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void addtoConflicts() throws SQLException {
        String query = "SELECT addconflict(?,?,?,?)";
        try (PreparedStatement statement = Tables.getCon().prepareStatement(query)) {
            //add the data to the statement's query
            statement.setString(1, "JUnit");
            statement.setString(2, "ship");
            statement.setObject(3, 909090);
            statement.setInt(4, 808080);

            statement.executeQuery();
        }


        String querySelect = "SELECT cid FROM conflict WHERE culprit = ?";
        int id = -1;
        try (Connection con = Tables.getCon(); PreparedStatement stmt = con.prepareStatement(querySelect)) {
            stmt.setString(1, "JUnit");
            try (ResultSet resultSet = stmt.executeQuery()) {
                while (resultSet.next()) {
                    id = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        assertTrue(id > 0);
    }

    @After
    public void tearDown() throws SQLException {
        Connection con = Tables.getCon();
        String query = "DELETE  FROM conflict WHERE entry = 909090";
        try {
            Statement stmt = con.createStatement();
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        con.close();
    }
}