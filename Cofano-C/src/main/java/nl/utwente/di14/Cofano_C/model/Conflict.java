package nl.utwente.di14.Cofano_C.model;

public class Conflict {
	
	private String table_type;
	private String table_attribute;
	private int ID;
	private int created_by;
	private int solved_by;
	
	public Conflict() {}
	
	public Conflict(String type, String att, int id, int creat) {
		this.table_attribute = att;
		this.table_type = type;
		this.created_by = creat;
		this.solved_by = 0;
		this.ID = id;
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
		this.table_attribute = att;
	}
	
	public String getTableAtt() {
		return this.table_attribute;
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
