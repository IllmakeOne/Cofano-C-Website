package model;

public class Application {

	
	private String name;
	private String APIkey;
	private int ID;
	
	public Application() {
		
	}
	
	public Application(String name, String key, int id) {
		this.name = name;
		this.APIkey = key;
		this.ID = id;
	}
	
	public void setID(int ID) {
		this.ID = ID;
	}
	
	public int getID() {
		return this.ID;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setAPIKey(String key) {
		this.APIkey = key;
	}
	
	public String getAPIKey() {
		return this.APIkey;
	}
}
