package nl.utwente.di14.Cofano_C.model;

public class Terminal {
	
	private int ID;
	
	private String name;
	private String terminalcode;
	private String type;
	private String unlo;
	private int port_id;
	
	

	public Terminal() {}
	
	
	public Terminal(int iD, String name, String terminalcode, String type, String unlo, int port_id) {
		super();
		ID = iD;
		this.name = name;
		this.terminalcode = terminalcode;
		this.type = type;
		this.unlo = unlo;
		this.port_id = port_id;
	}
	
	@Override
	public String toString() {
		return "Terminal:  Name: " + name + "; TerminalCode: " + terminalcode + "; Type: " + type+ 
				"; Unlo: " + unlo + "; port ID: " + port_id;
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
	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}
	public int getPort_id() {
		return port_id;
	}

	public void setPort_id(int port_id) {
		this.port_id = port_id;
	}
	
	

}
