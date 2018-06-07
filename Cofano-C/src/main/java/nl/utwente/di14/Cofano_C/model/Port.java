package nl.utwente.di14.Cofano_C.model;

public class Port {

	private int ID;
	private String name;
	private String unlo;
	
	public Port() {}
	
	public Port(int id, String name, String unlo) {
		this.ID = id;
		this.name = name;
		this.unlo = unlo;
	}
	
	@Override
	public String toString() {
		return "Port:  Name: "+ name+"; Unlo: "+unlo;
	}
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUnlo() {
		return unlo;
	}
	public void setUnlo(String unlo) {
		this.unlo = unlo;
	}
	
	
}