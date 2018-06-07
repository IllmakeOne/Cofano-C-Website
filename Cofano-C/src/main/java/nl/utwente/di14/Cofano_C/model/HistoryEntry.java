package nl.utwente.di14.Cofano_C.model;
import java.sql.Date;
import java.sql.Timestamp;

public class HistoryEntry {
	
	private int ID;
	private String title;
	private String message;
	private Timestamp added_at;
	
	public HistoryEntry() {}

	public HistoryEntry(int iD, String title, String message, Timestamp added_at) {
		super();
		ID = iD;
		this.title = title;
		this.message = message;
		this.added_at = added_at;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getAdded_at() {
		return added_at;
	}

	public void setAdded_at(Timestamp added_at) {
		this.added_at = added_at;
	}
	
	
}
