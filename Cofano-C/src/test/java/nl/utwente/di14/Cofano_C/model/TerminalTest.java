package nl.utwente.di14.Cofano_C.model;

import org.junit.Test;

import static org.junit.Assert.*;

public class TerminalTest {

    private Terminal t1 = new Terminal(0001, "Name1", "T001", "Type1", "UNLO1", 1001);
    private Terminal t2 = new Terminal();

    @Test
    public void constructorWithDataTest() {
        assertNotNull(t1);
    }

    @Test
    public void constructorWithoutDataTest() {
        assertNotNull(t2);
    }

    @Test
    public void toStringTest() {
        assertEquals(("Terminal:  Name: " + "Name1" + "; TerminalCode: " + "T001" + "; Type: " + "Type1" +
                "; Unlo: " + "UNLO1" + "; port id: " + 1001), t1.toString());
    }

    @Test
    public void getName() {
        assertEquals("Name1", t1.getName());
    }

    @Test
    public void setName() {
        t2.setName("Name2");
        assertEquals("Name2", t2.getName());
    }

    @Test
    public void getTerminalCode() {
        assertEquals("T001", t1.getTerminalCode());
    }

    @Test
    public void setTerminalCode() {
        t2.setTerminalCode("T002");
        assertEquals("T002", t2.getTerminalCode());
    }

    @Test
    public void getType() {
        assertEquals("Type1", t1.getType());
    }

    @Test
    public void setType() {
        t2.setType("Type2");
        assertEquals("Type2", t2.getType());
    }

    @Test
    public void getUnlo() {
        assertEquals("UNLO1", t1.getUnlo());
    }

    @Test
    public void setUnlo() {
        t2.setUnlo("UNLO2");
        assertEquals("UNLO2", t2.getUnlo());
    }

    @Test
    public void getID() {
        assertEquals(0001, t1.getID());
    }

    @Test
    public void setID() {
        t2.setID(0002);
        assertEquals(0002, t2.getID());
    }

    @Test
    public void getPortId() {
        assertEquals(1001, t1.getPortId());
    }

    @Test
    public void setPortId() {
        t2.setPortId(1002);
        assertEquals(1002, t2.getPortId());
    }
}