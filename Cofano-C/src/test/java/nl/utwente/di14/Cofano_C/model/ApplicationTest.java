package nl.utwente.di14.Cofano_C.model;


import org.junit.Test;

import static org.junit.Assert.*;

public class ApplicationTest {

    private Application app1 = new Application("Test app 1", "KEY001", 0001);
    private Application app2 = new Application();

    @Test
    public void constructorWithDataTest() {
        assertNotNull(app1);
    }

    @Test
    public void constructorWithoutDataTest() {
        assertNotNull(app2);
    }

    @Test
    public void toStringTest() {
        assertEquals(("  Application:  Name: " + "Test app 1" + "; APIKey: " + "KEY001"), app1.toString());
    }

    @Test
    public void setId() {
        app2.setId(0002);
        assertEquals(0002, app2.getId());
    }

    @Test
    public void getId() {
        assertEquals(0001, app1.getId());

    }

    @Test
    public void setName() {
        app2.setName("Test app 2");
        assertEquals("Test app 2", app2.getName());
    }

    @Test
    public void getName() {
        assertEquals("Test app 1", app1.getName());

    }

    @Test
    public void setAPIKey() {
        app2.setAPIKey("KEY002");
        assertEquals("KEY002", app2.getAPIKey());
    }

    @Test
    public void getAPIKey() {
        assertEquals("KEY001", app1.getAPIKey());
    }
}