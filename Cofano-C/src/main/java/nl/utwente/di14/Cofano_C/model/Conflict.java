package nl.utwente.di14.Cofano_C.model;

import java.sql.Timestamp;

/**
 * This is the model for a conflict object,
 */
public class Conflict {


    private int id;

    private String tableType;
    private String columnName;
    private String value;

    private int createdBy;
    private int solvedBy;

    private Timestamp addedAt;
    private Timestamp updatedAt;

    public Conflict() {
    }

    public Conflict(int iD, String tableType, String columnName, String value, int createdBy, int solvedBy, Timestamp addedAt,
                    Timestamp updatedAt) {
        super();
        id = iD;
        this.tableType = tableType;
        this.columnName = columnName;
        this.createdBy = createdBy;
        this.solvedBy = solvedBy;
        this.addedAt = addedAt;
        this.updatedAt = updatedAt;
        this.value = value;
    }


    public String toString(String whodid, String whoRepaired) {
        return "Conflict:  Created by : " + whodid + "; Solved by: " + whoRepaired + "; In table: " + tableType +
                "; on column: " + columnName + "; with Value of: " + value +
                "; Created on: " + addedAt + "; Solved on: " + updatedAt;
    }


    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return this.id;
    }


    public void setTableType(String type) {
        this.tableType = type;
    }

    public String getTableType() {
        return this.tableType;
    }


    public void setTableAtt(String att) {
        this.columnName = att;
    }

    public String getTableAtt() {
        return this.columnName;
    }


    public void setCreatedBy(int create) {
        this.createdBy = create;
    }

    public int getCreatedBy() {
        return this.createdBy;
    }


    public void setScolvedBy(int solve) {
        this.solvedBy = solve;
    }

    public int getScolvedBy() {
        return this.solvedBy;
    }


}
