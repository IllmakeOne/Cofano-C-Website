package nl.utwente.di14.Cofano_C.model;

import java.sql.Timestamp;

/**
 * This is the model for an entry in the history table.
 */
public class HistoryEntry {

    private int id;
    private String title;
    private String message;
    private Timestamp addedAt;
    private String type;

    /**
     * Constructs a blank history entry.
     */
    public HistoryEntry() {
    }

    /**
     * Constructs a new history entry with data.
     *
     * @param id      of the history entry
     * @param title   of the history entry
     * @param message of the history entry
     * @param addedAt data the history entry was added
     * @param type    of the history entry
     */
    public HistoryEntry(int id, String title, String message, Timestamp addedAt, String type) {
        super();
        this.id = id;
        this.title = title;
        this.message = message;
        this.addedAt = addedAt;
        this.type = type;
    }


    /**
     * Gets the type of the history entry.
     *
     * @return the type of the history entry
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the type of the history entry.
     *
     * @param type of the history entry
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the ID of the history entry.
     *
     * @return the ID of the history entry
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the ID of the history entry.
     *
     * @param id of the history entry
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Gets the title of the history entry.
     *
     * @return the title of the history entry
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the title of the history entry.
     *
     * @param title of the history entry
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the message of the history entry.
     *
     * @return the message of the history entry
     */
    public String getMessage() {
        return message;
    }

    /**
     * Sets the message of the history entry.
     *
     * @param message of the history entry
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * Gets the added at time of the history entry.
     *
     * @return the added at time of the history entry
     */
    public Timestamp getAddedAt() {
        return addedAt;
    }

    /**
     * Sets the added at time of the history entry.
     *
     * @param addedAt the added at time of the history entry
     */
    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }
}
