package nl.utwente.di14.Cofano_C.dao;

import org.apache.commons.dbcp2.BasicDataSource;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;

import static nl.utwente.di14.Cofano_C.dao.Tables.getInstance;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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
    public void addtoConflicts() {
        try {
            Tables.addtoConflicts(Tables.getCon(), "ship", "JUnit", 909090, 808080);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String query = "SELECT * FROM  conflict WHERE culprit = "JUnit"";
    }


    @Test
    public void objToPGobj() {
    }

    @After
    public void tearDown() {
    }
}