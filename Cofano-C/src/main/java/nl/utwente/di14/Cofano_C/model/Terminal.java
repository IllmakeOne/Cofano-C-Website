package nl.utwente.di14.Cofano_C.model;

public class Terminal {
	
	private int ID;
	
	private String name;
	private String terminalCode;
	private String type;
	private String unlo;
	private int portId;
	
	

	public Terminal() {}
	
	
	public Terminal(int iD, String name, String terminalCode, String type, String unlo, int portId) {
		super();
		ID = iD;
		this.name = name;
		this.terminalCode = terminalCode;
		this.type = type;
		this.unlo = unlo;
		this.portId = portId;
	}
	
	@Override
	public String toString() {
		return "Terminal:  Name: " + name + "; TerminalCode: " + terminalCode + "; Type: " + type+
				"; Unlo: " + unlo + "; port ID: " + portId;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTerminalCode() {
		return terminalCode;
	}
	public void setTerminalCode(String terminalCode) {
		this.terminalCode = terminalCode;
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
	public int getPortId() {
		return portId;
	}

	public void setPortId(int portId) {
		this.portId = portId;
	}
	
	

}
