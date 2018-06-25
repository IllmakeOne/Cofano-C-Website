package nl.utwente.di14.Cofano_C.model;

import java.math.BigDecimal;

public class Ship {

	private int ID;
	
	private String imo;
	private String name;
	private String callsign;
	private String mmsi;
	private BigDecimal depth;
	
	public Ship() {}
	
	public Ship(String imo, String name, String callsign, String mmsi, BigDecimal depth, int iD) {
		super();
		this.imo = imo;
		this.name = name;
		this.callsign = callsign;
		this.mmsi = mmsi;
		this.depth = depth;
		ID = iD;
	}
	
	@Override 
	public String toString() {
		return "Ship:  IMO: " + imo + "; Name: "+name+"; CallSign: "
				+callsign+ "; MMSI: " +mmsi+ "; Depth: " +depth;
	}
	
	public String getImo() {
		return imo;
	}
	public void setImo(String imo) {
		this.imo = imo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCallsign() {
		return callsign;
	}
	public void setCallsign(String callsign) {
		this.callsign = callsign;
	}
	public String getMmsi() {
		return mmsi;
	}
	public void setMmsi(String mmsi) {
		this.mmsi = mmsi;
	}
	public BigDecimal getDepth() {
		return depth;
	}
	public void setDepth(BigDecimal depth) {
		this.depth = depth;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	
}
