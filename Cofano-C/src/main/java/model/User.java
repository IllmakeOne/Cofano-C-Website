package model;
import java.sql.Date;

public class User {

	public final static String DEFAULTPREF = " ";
	
	private String name;
	private Date lastLogedIn;
	private String email;
	private String preferance;
	private int ID;
	
	public User() {
	}
	
	public User(String name, String email, int ID, Date date) {
		this.name = name;
		this.email = email;
		this.preferance = DEFAULTPREF;
		this.ID = ID;
		this.lastLogedIn = date;
	}
	
	public void setDate(Date date) {
		this.lastLogedIn = date;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setPreferance(String preferance) {
		this.preferance = preferance;
	}
	
	public void setID(int ID) {
		this.ID = ID;
	}
	
	public int getID() {
		return this.ID;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public String getName() {
		return this.name;
	}
	
	public Date getLastLogIn() {
		return this.lastLogedIn;
	}
	
	public String getPreference() {
		return this.preferance;
	}
	
	
	
}
