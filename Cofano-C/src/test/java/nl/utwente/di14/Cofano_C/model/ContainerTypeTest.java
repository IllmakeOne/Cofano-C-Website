package nl.utwente.di14.Cofano_C.model;

import org.junit.Test;

import static org.junit.Assert.*;

public class ContainerTypeTest {

    ContainerType ct1 = new ContainerType("Test1", "ISO001", "Description1", 100, 50, true, 0001);
    ContainerType ct2 = new ContainerType();

    @Test
    public void toStringTest() {
        assertEquals(("  ContainerType:  displayName: " + "Test1" + "; isoCode: " + "ISO001" +
                "; Description: " + "Description1" +
                "; Length: " + 100 + "; Height: " + 50 + "; Reefer: " + true), ct1.toString());
    }

    @Test
    public void getReefer() {
        assertTrue(ct1.getReefer());
    }

    @Test
    public void setReefer() {
        ct2.setReefer(false);
        assertFalse(ct2.getReefer());
    }

    @Test
    public void getId() {
        assertEquals(0001, ct1.getId());
    }

    @Test
    public void setId() {
        ct2.setId(0002);
        assertEquals(0002, ct2.getId());
    }

    @Test
    public void getLength() {
        assertEquals(100, ct1.getLength());
    }

    @Test
    public void setLength() {
        ct2.setLength(200);
        assertEquals(200, ct2.getLength());
    }

    @Test
    public void getHeight() {
        assertEquals(50, ct1.getHeight());
    }

    @Test
    public void setHeight() {
        ct2.setHeight(60);
        assertEquals(60, ct2.getHeight());
    }

    @Test
    public void getDisplayName() {
        assertEquals("Test1", ct1.getDisplayName());
    }

    @Test
    public void setDisplayName() {
        ct2.setDisplayName("Test2");
        assertEquals("Test2", ct2.getDisplayName());
    }

    @Test
    public void getIsoCode() {
        assertEquals("ISO001", ct1.getIsoCode());
    }

    @Test
    public void setIsoCode() {
        ct2.setIsoCode("ISO002");
        assertEquals("ISO002", ct2.getIsoCode());
    }

    @Test
    public void getDescription() {
        assertEquals("Description1", ct1.getDescription());
    }

    @Test
    public void setDescription() {
        ct2.setDescription("Description2");
        assertEquals("Description2", ct2.getDescription());
    }
}