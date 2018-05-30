package nl.utwente.di14.Cofano_C.model;
import java.sql.Date;

public class HistoryEntry {
	
	private int ID;
	private int tableID;
	private int changerID;
	private int changedID;
	private String type;
	private String message;
	private Date addDate;
	
	public HistoryEntry() {}
	
	public HistoryEntry(int iD, int tableID, int changerID, int changedID, String type, String message, Date addDate) {
		super();
		ID = iD;
		this.tableID = tableID;
		this.changerID = changerID;
		this.changedID = changedID;
		this.type = type;
		this.message = message;
		this.addDate = addDate;
	}


	public int getID() {
		return ID;
	}


	public void setID(int iD) {
		ID = iD;
	}


	public int getTableID() {
		return tableID;
	}


	public void setTableID(int tableID) {
		this.tableID = tableID;
	}


	public int getChangerID() {
		return changerID;
	}


	public void setChangerID(int changerID) {
		this.changerID = changerID;
	}


	public int getChangedID() {
		return changedID;
	}


	public void setChangedID(int changedID) {
		this.changedID = changedID;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public Date getAddDate() {
		return addDate;
	}


	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}
	
	
	
	

}
