package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Port;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.glassfish.jersey.server.monitoring.RequestEventListener;
import org.postgresql.util.PGobject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/ports")
public class PortsResource {

	private String myname = "port";
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addShip(Port input, @Context HttpServletRequest request) {
		Tables.start();
		
		int ownID = 0;
		String title = "ADD";
		String doer = Tables.testRequest(request);

		int con = testConflict(input);
		
		
		if(request.getSession().getAttribute("userEmail")!=null && con == 0 ) {
			//if its from a cofano employee and it doesnt create conflcit, add straight to db
			ownID = addEntry(input,true);
			Tables.addHistoryEntry(title, doer, input.toString(),myname,true);
		} else if(request.getSession().getAttribute("userEmail")!=null && con != 0 ) {
			//if its froma cofano emplyee and it create sconflcit, add but unapproved
			ownID = addEntry(input,false);

			Tables.addHistoryEntry(title, doer, input.toString(),myname,false);
		} else if(!doer.equals("")) {
			//if its from an api add to unapproved
			ownID = addEntry(input,false);
			Tables.addHistoryEntry(title, doer, input.toString(),myname,false);
		}
		
		if(con != 0) {
			//if it creates a conflcit, add it to conflict table
			Tables.addtoConflicts(myname, doer, ownID, con);
			//add to history
			Tables.addHistoryEntry("CON", doer, ownID + " " + input.toString()+" con with "+con,myname,false);

		}
			
	}
	
	

	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Port> getAllContainerTypes(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM port " +
				"WHERE approved = true";
		
		String name = Tables.testRequest(request);
	//	System.out.println(name);
		if(!name.equals("")) {

			try {
				PreparedStatement statement = Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					//System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3));
	
					Port port = new Port();
					port.setId(resultSet.getInt("pid"));
					port.setName(resultSet.getString("name"));
					port.setUnlo(resultSet.getString("unlo"));
	
	
					result.add(port);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all ports" + e);
			}
		} 

		return result;

	}
	
	
	public int addEntry(Port entry, boolean app) {
		String query = "SELECT addport(?,?,?)";
		int rez =0;
		//gets here if the request is from API
		//add to conflicts table
		try {
			//Create prepared statement
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(1, entry.getName());
			statement.setString(2,entry.getUnlo());
			statement.setBoolean(3, app);
			
			ResultSet res = statement.executeQuery();			
			res.next();
			rez = res.getInt(1);
		} catch (SQLException e) {
			System.err.println("Could not add approved port ");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		return rez;
	}
		
		
	
	
	public int testConflict(Port test) {
		int result = 0 ;
		String query = "SELECT * FROM portconflict(?,?)";
		
		try {
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			statement.setString(1, test.getName());
			statement.setString(2, test.getUnlo());
			
			ResultSet resultSet = statement.executeQuery();
				
			if(!resultSet.next()) {
				result = 0;
			} else {
				result = resultSet.getInt("pid");
			}
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN port " + e);
		}
		return result;
	}
	
	/*
	public int getID(Port entry) {
		int res = 0;
		String query = "SELECT getexactport(?,?)";
		//gets here if the request is from API
		//add to conflicts table
		try {
			//Create prepared statement
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(1, entry.getName());
			statement.setString(2,entry.getUnlo());
			
			ResultSet rez = statement.executeQuery();	
			rez.next();
			res = rez.getInt(1);
			
		} catch (SQLException e) {
			System.err.println("Could not get specific port ");
			System.err.println(e.getSQLState());
			e.printStackTrace();
		}
		return res;
	}
	*/
}
