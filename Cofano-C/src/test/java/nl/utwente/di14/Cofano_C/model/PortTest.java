package nl.utwente.di14.Cofano_C.model;

import org.junit.Test;

import static org.junit.Assert.*;

public class PortTest {

    private Port p1 = new Port(0001, "Name1", "UNLO1");
    private Port p2 = new Port();

    @Test
    public void constructorWithDataTest() {
        assertNotNull(p1);
    }

    @Test
    public void constructorWithoutDataTest() {
        assertNotNull(p2);
    }

    @Test
    public void toStringTest() {
        assertEquals(("Port:  Name: " + "Name1" + "; Unlo: " + "UNLO1"), p1.toString());
    }

    @Test
    public void getId() {
        assertEquals(0001, p1.getId());
    }

    @Test
    public void setId() {
        p2.setId(0002);
        assertEquals(0002, p2.getId());
    }

    @Test
    public void getName() {
        assertEquals("Name1", p1.getName());
    }

    @Test
    public void setName() {
        p2.setName("Name2");
        assertEquals("Name2", p2.getName());
    }

    @Test
    public void getUnlo() {
        assertEquals("UNLO1", p1.getUnlo());
    }

    @Test
    public void setUnlo() {
        p2.setUnlo("UNLO2");
        assertEquals("UNLO2", p2.getUnlo());
    }
}