package model;

public class DescriptionsUndg {
	
	private int ID;
	private int undgID;
	private String description;
	private String language;
	
	public DescriptionsUndg() {}
	
	public DescriptionsUndg(int iD, int undgID, String description, String language) {
		super();
		ID = iD;
		this.undgID = undgID;
		this.description = description;
		this.language = language;
	}
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public int getUndgID() {
		return undgID;
	}
	public void setUndgID(int undgID) {
		this.undgID = undgID;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	
	
	
	

}
