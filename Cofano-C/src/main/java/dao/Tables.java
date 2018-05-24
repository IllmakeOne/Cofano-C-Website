package dao;

import java.util.HashMap;
import java.util.Map;

import model.*;

public enum Tables {
	instance;
	
	private Map<String, ContainerType> ContainerTypes= new HashMap<String, ContainerType>();
	private Map<String, DestinationPort> DestinationPorts = new HashMap<String, DestinationPort>();
	private Map<String, User> Users = new HashMap<String, User>();
	private Map<String, Undg> Undgs = new HashMap<String, Undg>();
	private Map<String, Terminal> Terminals = new HashMap<String, Terminal>();
	private Map<String, Application> Applications = new HashMap<String, Application>();
	private Map<String, Ship> Ships = new HashMap<String, Ship>();
	private Map<String, HistoryEntry> History = new HashMap<String, HistoryEntry>();
	private Map<String, Conflict> Conflicts = new HashMap<String, Conflict>();
	
	public Map<String, ContainerType> getContainerTypes() {
		return ContainerTypes;
	}
	public Map<String, DestinationPort> getDestinationPorts() {
		return DestinationPorts;
	}
	public Map<String, User> getUsers() {
		return Users;
	}
	public Map<String, Undg> getUndgs() {
		return Undgs;
	}
	public Map<String, Terminal> getTerminals() {
		return Terminals;
	}
	public Map<String, Application> getApplications() {
		return Applications;
	}
	public Map<String, Ship> getShips() {
		return Ships;
	}
	public Map<String, HistoryEntry> getHistory() {
		return History;
	}
	public Map<String, Conflict> getConflicts() {
		return Conflicts;
	}
	
	

}
