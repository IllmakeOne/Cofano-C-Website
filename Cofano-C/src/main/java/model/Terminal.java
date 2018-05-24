package model;

public class Terminal {
	
	private String name;
	private String terminalcode;
	private String type;
	private String unlo;
	
	public Terminal() {}
	
	public Terminal(String name, String terminalcode, String type, String unlo) {
		super();
		this.name = name;
		this.terminalcode = terminalcode;
		this.type = type;
		this.unlo = unlo;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTerminalcode() {
		return terminalcode;
	}
	public void setTerminalcode(String terminalcode) {
		this.terminalcode = terminalcode;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUnlo() {
		return unlo;
	}
	public void setUnlo(String unlo) {
		this.unlo = unlo;
	}
	
	

}
