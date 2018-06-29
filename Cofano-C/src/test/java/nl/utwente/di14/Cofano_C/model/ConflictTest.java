package nl.utwente.di14.Cofano_C.model;

import org.junit.Test;
import java.sql.Timestamp;
import static org.junit.Assert.*;

public class ConflictTest {
   private Timestamp stamp1 = new Timestamp(1530264090);
    private Timestamp stamp2 = new Timestamp(1530264091);
   private Conflict conf1 = new Conflict(0001, "TestingTable", "Column1", "TestingValue",0010, 0011, stamp1, stamp2);
    private Conflict conf2 = new Conflict();

    @Test
    public void constructorWithDataTest() {
        assertNotNull(conf1);
    }

    @Test
    public void constructorWithoutDataTest() {
        assertNotNull(conf2);
    }

    @Test
    public void toStringTest() {
      assertEquals(("Conflict:  Created by : " + "Me" + "; Solved by: " + "You" + "; In table: "
              + "TestingTable" + "; on column: " + "Column1" + "; with Value of: " + "TestingValue" +
              "; Created on: " + stamp1 + "; Solved on: " + stamp2),conf1.toString("Me", "You"));
    }

    @Test
    public void getValue() {
        assertEquals("TestingValue", conf1.getValue());
    }

    @Test
    public void setValue() {
        conf2.setValue("TestingValue2");
        assertEquals("TestingValue2", conf2.getValue());
    }

    @Test
    public void getUpdatedAt() {
        assertEquals(stamp2, conf1.getUpdatedAt());
    }

    @Test
    public void setUpdatedAt() {
        conf2.setUpdatedAt(stamp1);
        assertEquals(stamp1, conf2.getUpdatedAt());
    }

    @Test
    public void getId() {
        assertEquals(0001, conf1.getId());
    }

    @Test
    public void setID() {
        conf2.setID(0002);
        assertEquals(0002, conf2.getId());
    }

    @Test
    public void getTableType() {
        assertEquals("TestingTable", conf1.getTableType());
    }

    @Test
    public void setTableType() {
        conf2.setTableType("TestingTable2");
        assertEquals("TestingTable2", conf2.getTableType());
    }

    @Test
    public void getTableAtt() {
        assertEquals("Column1", conf1.getTableAtt());
    }

    @Test
    public void setTableAtt() {
        conf2.setTableAtt("Column2");
        assertEquals("Column2", conf2.getTableAtt());
    }

    @Test
    public void getCreatedBy() {
        assertEquals(0010, conf1.getCreatedBy());
    }

    @Test
    public void setCreatedBy() {
        conf2.setCreatedBy(0020);
        assertEquals(0020, conf2.getCreatedBy());
    }

    @Test
    public void getSolvedBy() {
        assertEquals(0011, conf1.getSolvedBy());
    }

    @Test
    public void setSolvedBy() {
        conf2.setSolvedBy(0012);
        assertEquals(0012, conf2.getSolvedBy());
    }

}