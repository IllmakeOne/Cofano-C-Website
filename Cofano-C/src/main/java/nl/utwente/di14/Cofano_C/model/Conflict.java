package nl.utwente.di14.Cofano_C.model;

import java.sql.Timestamp;

/**
 * This is the model for a conflict object.
 */
class Conflict {


    private int id;
    private String tableType;
    private String columnName;
    private String value;
    private int createdBy;
    private int solvedBy;
    private Timestamp addedAt;
    private Timestamp updatedAt;

    /**
     * Creates a new empty conflict.
     */
    public Conflict() {
    }

    /**
     * Constructs a new conflict with all the necessary data.
     *
     * @param id         of the conflict
     * @param tableType  of the conflict
     * @param columnName of the conflict
     * @param value      of the conflict
     * @param createdBy  name of user or application that created the conflict
     * @param solvedBy   name of user or application that solved the conflict
     * @param addedAt    date the conflict was created
     * @param updatedAt  date the conflict was last updated
     */
    public Conflict(int id, String tableType, String columnName, String value,
                    int createdBy, int solvedBy, Timestamp addedAt,
                    Timestamp updatedAt) {
        super();
        this.id = id;
        this.tableType = tableType;
        this.columnName = columnName;
        this.createdBy = createdBy;
        this.solvedBy = solvedBy;
        this.addedAt = addedAt;
        this.updatedAt = updatedAt;
        this.value = value;
    }


    /**
     * Print the conflict as a string.
     *
     * @param whoDid      name of the user or application that created the conflict
     * @param whoRepaired name of the user or application the solved the conflict
     * @return the string describing the conflict
     */
    public String toString(String whoDid, String whoRepaired) {
        return "Conflict:  Created by : " + whoDid + "; Solved by: " + whoRepaired + "; In table: "
                + tableType + "; on column: " + columnName + "; with Value of: " + value +
                "; Created on: " + addedAt + "; Solved on: " + updatedAt;
    }


    /**
     * Gets the value of the conflict.
     *
     * @return the value of the conflict
     */
    public String getValue() {
        return value;
    }

    /**
     * Sets the value of the conflict.
     *
     * @param value of the conflict
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     * Gets the update time of the conflict.
     *
     * @return the update time of the conflict
     */
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    /**
     * Sets the update time of the conflict.
     *
     * @param updatedAt update time of the conflict
     */
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    /**
     * Sets the ID of the conflict.
     *
     * @param conflictID of the conflict
     */
    public void setID(int conflictID) {
        this.id = conflictID;
    }

    /**
     * Gets the ID of the conflict.
     *
     * @return the ID of the conflict
     */
    public int getId() {
        return this.id;
    }

    /**
     * Gets the table type of the conflict.
     *
     * @return the table type of the conflict
     */
    public String getTableType() {
        return this.tableType;
    }

    /**
     * Sets the table type of the conflict.
     *
     * @param type of the table of the conflict
     */
    public void setTableType(String type) {
        this.tableType = type;
    }

    /**
     * Gets the table attribute of the conflict.
     *
     * @return the table attribute of the conflict
     */
    public String getTableAtt() {
        return this.columnName;
    }

    /**
     * Sets the table attribute of the conflict.
     *
     * @param att table attribute of the conflict
     */
    public void setTableAtt(String att) {
        this.columnName = att;
    }

    /**
     * Gets the created by user or application of the conflict.
     *
     * @return the created by user or application of the conflict
     */
    public int getCreatedBy() {
        return this.createdBy;
    }

    /**
     * Sets the created by user or application of the conflict.
     *
     * @param create the created by user or application of the conflict
     */
    public void setCreatedBy(int create) {
        this.createdBy = create;
    }

    /**
     * Gets the solved by user or application of the conflict.
     *
     * @return the solved by user or application of the conflict
     */
    public int getSolvedBy() {
        return this.solvedBy;
    }

    /**
     * Sets the solved by user or application of the conflict.
     *
     * @param solve solved by user or application of the conflict
     */
    public void setSolvedBy(int solve) {
        this.solvedBy = solve;
    }
}
