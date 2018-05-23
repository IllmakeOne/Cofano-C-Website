package model;

public class ContainerType {
	
	private String displayName;
	private String isoCode;
	private String description;
	private int lenght;
	private int height;
	private boolean refeer;
	private int ID;

	public ContainerType() {}
	
	public ContainerType(String name, String isocode, String decription, int lenght, int height, boolean reef, int ID) {
		this.displayName = name;
		this.isoCode = isocode;
		this.description = decription;
		this.lenght = lenght;
		this.height = height;
		this.refeer = reef;
		this.ID = ID;
	}
	
	public void setID(int ID) {
		this.ID = ID;
	}	
	public int getID() {
		return this.ID;
	}
	
	public void setLenght(int lenght) {
		this.lenght = lenght;
	}	
	public int getLenght() {
		return this.lenght;
	}
	

	public void setHeight(int height) {
		this.height = height;
	}
	public int getHeight() {
		return this.height;
	}
	
	public void setDisplayName(String name) {
		this.displayName = name;
	}
	public String getDisplayName() {
		return this.displayName;
	}
	
	public void setIsoCode(String iso) {
		this.isoCode = iso;
	}
	public String getIsoCode() {
		return this.isoCode;
	}
	
	public void setDescription(String desc) {
		this.description = desc;
	}
	public String getDescription() {
		return this.description;
	}
	
	
}
