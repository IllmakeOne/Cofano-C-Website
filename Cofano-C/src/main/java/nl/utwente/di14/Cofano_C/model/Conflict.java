package nl.utwente.di14.Cofano_C.model;

import java.sql.Timestamp;

/**
 * This is the model for a conflict object,
 */
public class Conflict {


    private int id;

    private String table_type;
    private String columnName;
    private String value;

    private int createdBy;
    private int solvedBy;

    private Timestamp addedAt;
    private Timestamp updatedAt;

    public Conflict() {
    }

    public Conflict(int iD, String table_type, String columnName, String value, int createdBy, int solvedBy, Timestamp addedAt,
                    Timestamp updatedAt) {
        super();
        id = iD;
        this.table_type = table_type;
        this.columnName = columnName;
        this.createdBy = createdBy;
        this.solvedBy = solvedBy;
        this.addedAt = addedAt;
        this.updatedAt = updatedAt;
        this.value = value;
    }


    public String toString(String whodid, String whoRepaired) {
        return "Conflict:  Created by : " + whodid + "; Solved by: " + whoRepaired + "; In table: " + table_type +
                "; on column: " + columnName + "; with Value of: " + value +
                "; Created on: " + addedAt + "; Solved on: " + updatedAt;
    }


    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getTable_type() {
        return table_type;
    }

    public void setTable_type(String table_type) {
        this.table_type = table_type;
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
        this.table_type = type;
    }

    public String getTableType() {
        return this.table_type;
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
