package nl.utwente.di14.Cofano_C.model;
import java.sql.Timestamp;

public class User {

	private int ID;
	
	private String name;
	private String email;
	
	private boolean email_notification;
	private boolean darkmode;
	
	private Timestamp lastLogedIn;
	
	@Override
	public String toString() {
		return "User:  Name: "+name+"; email: "+email+"; email_notification: "+ email_notification+
				"; darkmode: "+darkmode + "; lastLogedIn: "+lastLogedIn; 
	}
	
	public User() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getLastLogedIn() {
		return lastLogedIn;
	}

	public void setLastLogedIn(Timestamp lastLogedIn) {
		this.lastLogedIn = lastLogedIn;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isEmail_notification() {
		return email_notification;
	}

	public void setEmail_notification(boolean email_notification) {
		this.email_notification = email_notification;
	}

	public boolean isDarkmode() {
		return darkmode;
	}

	public void setDarkmode(boolean darkmode) {
		this.darkmode = darkmode;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}
	

	
	
}
