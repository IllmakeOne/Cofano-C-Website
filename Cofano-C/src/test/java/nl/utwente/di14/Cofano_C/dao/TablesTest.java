package nl.utwente.di14.Cofano_C.dao;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static nl.utwente.di14.Cofano_C.dao.Tables.getInstance;
import static org.junit.Assert.assertNotNull;

public class TablesTest {

    @Before
    public void setup() {
        Tables tables = new Tables();
    }

    @Test
    public void getInstanceTest() {
        assertNotNull(getInstance());
    }

    @Test
    public void getBds() {
    }

    @Test
    public void setBds() {
    }

    @Test
    public void getCon() {
    }

    @Test
    public void addtoConflicts() {
    }

    @Test
    public void objToPGobj() {
    }

    @After
    public void tearDown() {
    }
}