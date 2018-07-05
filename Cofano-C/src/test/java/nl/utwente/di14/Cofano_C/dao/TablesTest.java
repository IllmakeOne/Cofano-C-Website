package nl.utwente.di14.Cofano_C.dao;

import org.apache.commons.dbcp2.BasicDataSource;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static nl.utwente.di14.Cofano_C.dao.Tables.getInstance;
import static org.junit.Assert.*;

public class TablesTest {

    Tables tables = new Tables();

    BasicDataSource basicDataSource = new BasicDataSource();

    @Before
    public void setup() {
    }

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
        Connection con = Tables.getCon();
        int id = -1;
        try {
            Tables.addtoConflicts(Tables.getCon(), "ship", "JUnit", 909090, 808080);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String query = "SELECT cid FROM  conflict WHERE culprit = 'JUnit'";
        try {
            System.out.println("Reached this point");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                id = rs.getInt("cid");
                System.out.println("Found this id: " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        assertTrue(id > 0);
        con.close();
    }


    @Test
    public void objToPGobj() {
    }

    @After
    public void tearDown() throws SQLException {
        Connection con = tables.getCon();
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