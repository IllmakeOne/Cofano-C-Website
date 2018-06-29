package nl.utwente.di14.Cofano_C.model;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;

public class ApplicationTest {

    Application app1 = new Application("Test app 1", "KEY001", 0001);
    Application app2 = new Application();


    @Test
    public void toStringTest() {
        Assert.assertEquals(("  Application:  Name: " + "Test app 1" + "; APIKey: " + "KEY001"), app1.toString());
    }

    @Test
    public void setId() {
        app2.setId(0002);
        Assert.assertEquals(0002, app2.getId());
    }

    @Test
    public void getId() {
        Assert.assertEquals(0001, app1.getId());

    }

    @Test
    public void setName() {
        app2.setName("Test app 2");
        Assert.assertEquals("Test app 2", app2.getName());
    }

    @Test
    public void getName() {
        Assert.assertEquals("Test app 1", app1.getName());

    }

    @Test
    public void setAPIKey() {
        app2.setAPIKey("KEY002");
        Assert.assertEquals("KEY002", app2.getAPIKey());
    }

    @Test
    public void getAPIKey() {
        Assert.assertEquals("KEY001", app1.getAPIKey());
    }
}