package nl.utwente.di14.Cofano_C.model;

import org.junit.Test;

import java.math.BigDecimal;
import java.text.Bidi;

import static org.junit.Assert.*;

public class ShipTest {
    private BigDecimal bd1 = new BigDecimal(100);
    private BigDecimal bd2 = new BigDecimal(200);
    private Ship s1 = new Ship("IMO1", "Name1", "CALL1", "MMSI1", bd1, 001);
    private Ship s2 = new Ship();

    @Test
    public void constructorWithDataTest() {
        assertNotNull(s1);
    }

    @Test
    public void constructorWithoutDataTest() {
        assertNotNull(s2);
    }

    @Test
    public void toStringTest() {
        assertEquals(("Ship:  IMO: " + "IMO1" + "; Name: " + "Name1" + "; CallSign: "
                + "CALL1" + "; MMSI: " + "MMSI1" + "; Depth: " + bd1), s1.toString());
    }

    @Test
    public void getImo() {
        assertEquals("IMO1", s1.getImo());
    }

    @Test
    public void setImo() {
        s2.setImo("IMO2");
        assertEquals("IMO2", s2.getImo());
    }

    @Test
    public void getName() {
        assertEquals("Name1", s1.getName());
    }

    @Test
    public void setName() {
        s2.setName("Name2");
        assertEquals("Name2", s2.getName());
    }

    @Test
    public void getCallSign() {
        assertEquals("CALL1", s1.getCallSign());
    }

    @Test
    public void setCallSign() {
        s2.setCallSign("CALL2");
        assertEquals("CALL2", s2.getCallSign());
    }

    @Test
    public void getMMSI() {
        assertEquals("MMSI1", s1.getMMSI());
    }

    @Test
    public void setMMSI() {
        s2.setMMSI("MMSI2");
        assertEquals("MMSI2", s2.getMMSI());
    }

    @Test
    public void getDepth() {
        assertEquals(bd1, s1.getDepth());
    }

    @Test
    public void setDepth() {
        s2.setDepth(bd2);
        assertEquals(bd2, s2.getDepth());
    }

    @Test
    public void getId() {
        assertEquals(0001, s1.getId());
    }

    @Test
    public void setId() {
        s2.setId(0002);
        assertEquals(0002, s2.getId());
    }
}