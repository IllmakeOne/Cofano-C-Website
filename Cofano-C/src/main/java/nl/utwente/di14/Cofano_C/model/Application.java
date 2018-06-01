package nl.utwente.di14.Cofano_C.model;

public class Application {


	private int ID;
	private String name;
	private int APIkey;
	
	public Application() {
		
	}
	
	public Application(String name, int key, int id) {
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
	
	public void setAPIKey(int key) {
		this.APIkey = key;
	}
	
	public int getAPIKey() {
		return this.APIkey;
	}
}
