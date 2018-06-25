package nl.utwente.di14.Cofano_C.model;

import java.sql.Timestamp;

public class Conflict {
	

	private int ID;
	
	private String table_type;
	private String column_name;
	private String value;
	
	private int created_by;
	private int solved_by;
	
	private Timestamp added_at;
	private Timestamp updated_at;
	
	public Conflict() {}
	
	public Conflict(int iD, String table_type, String column_name,String value, int created_by, int solved_by, Timestamp added_at,
			Timestamp updated_at) {
		super();
		ID = iD;
		this.table_type = table_type;
		this.column_name = column_name;
		this.created_by = created_by;
		this.solved_by = solved_by;
		this.added_at = added_at;
		this.updated_at = updated_at;
		this.value = value;
	}
	
	
	public String toString(String whodid, String whoRepaired) {
		return "Conflict:  Created by : "+whodid+ "; Solved by: "+whoRepaired+"; In table: "+table_type+
				"; on column: "+column_name + "; with Value of: " +value+
				"; Created on: " +added_at+"; Solved on: "+updated_at;
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
	
	public Timestamp getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}
	
	public void setID(int ID) {
		this.ID = ID;
	}
	
	public int getID() {
		return this.ID;
	}
	
	
	public void setTableType(String type) {
		this.table_type = type;
	}
	
	public String getTableType() {
		return this.table_type;
	}
	

	public void setTableAtt(String att) {
		this.column_name = att;
	}
	
	public String getTableAtt() {
		return this.column_name;
	}
	
	
	public void setCreatedBy(int create) {
		this.created_by = create;
	}
	
	public int getCreatedBy() {
		return this.created_by;
	}
	
	
	public void setScolvedBy(int solve) {
		this.solved_by = solve;
	}
	
	public int getScolvedBy() {
		return this.solved_by;
	}
	

}
