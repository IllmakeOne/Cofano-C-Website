package nl.utwente.di14.Cofano_C.model;

import org.junit.Test;

import java.sql.Timestamp;

import static org.junit.Assert.*;

public class HistoryEntryTest {
    private Timestamp stamp1 = new Timestamp(1530264090);
    private Timestamp stamp2 = new Timestamp(1530264091);
    private HistoryEntry entry1 = new HistoryEntry(0001, "Title1", "Message1", stamp1, "Type1");
    private HistoryEntry entry2 = new HistoryEntry();

    @Test
    public void getType() {
        assertEquals("Type1", entry1.getType());
    }

    @Test
    public void setType() {
        entry2.setType("Type2");
        assertEquals("Type2", entry2.getType());
    }

    @Test
    public void getId() {
        assertEquals(0001, entry1.getId());
    }

    @Test
    public void setId() {
        entry2.setId(0002);
        assertEquals(0002, entry2.getId());
    }

    @Test
    public void getTitle() {
        assertEquals("Title1", entry1.getTitle());
    }

    @Test
    public void setTitle() {
        entry2.setTitle("Title2");
        assertEquals("Title2", entry2.getTitle());
    }

    @Test
    public void getMessage() {
        assertEquals("Message1", entry1.getMessage());
    }

    @Test
    public void setMessage() {
        entry2.setMessage("Message2");
        assertEquals("Message2", entry2.getMessage());
    }

    @Test
    public void getAddedAt() {
        assertEquals(stamp1, entry1.getAddedAt());
    }

    @Test
    public void setAddedAt() {
        entry2.setAddedAt(stamp2);
        assertEquals(stamp2, entry2.getAddedAt());
    }
}