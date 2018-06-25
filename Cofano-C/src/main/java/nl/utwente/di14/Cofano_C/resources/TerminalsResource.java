package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.exceptions.ConflictException;
import nl.utwente.di14.Cofano_C.model.Port;
import nl.utwente.di14.Cofano_C.model.Terminal;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;



@Path("/terminals")
public class TerminalsResource {


	private String myname = "terminal";
	
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
	public void addShip(Terminal input, @Context HttpServletRequest request) {
		Tables.start();
		
		int ownID = 0;
		String title = "ADD";
		String doer = Tables.testRequste(request);
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
	
	public int addEntry(Terminal entry, boolean app) {
		int rez =0;
		//gets here if the request is from API
		//add to conflicts table
		String query ="SELECT addterminal(?,?,?,?,?,?)";
		
		try {
			//Create prepared statement
			PreparedStatement statement = (PreparedStatement) Tables.getCon().prepareStatement(query);
			//add the data to the statement's query
			statement.setString(1, entry.getName());
			statement.setString(2,entry.getTerminalCode());
			statement.setString(3,entry.getType());
			statement.setString(4,entry.getUnlo());
			statement.setInt(5,entry.getPortId());
			statement.setBoolean(6, app);
			
			ResultSet res = statement.executeQuery();			
			res.next();
			rez = res.getInt(1);
			
		} catch (SQLException e) {
			System.err.println("Could not add terminal");
			System.err.println(e.getSQLState());
			e.printStackTrace();
			throw new ConflictException();
		}
		return rez;
	}
	
	
	/**
	 * this function is used in the Adding of a terminal.
	 * Terminal have a foreign key to Ports
	 * @return the PKs and name of all ports
	 */
	@GET
	@Path("portids")
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Port> getAvailableIDs(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT pid, name FROM port";
		
		String name = Tables.testRequest(request);
		if(!name.equals("")) {
	
			try {
				PreparedStatement statement = Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					
					Port terminal = new Port();
					terminal.setId(resultSet.getInt("pid"));
					terminal.setName(resultSet.getString("name"));
	
					result.add(terminal);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all ports" + e);
			}
		}
		return result;
	}

	@GET
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Terminal> getAllContainerTypes(@Context HttpServletRequest request){
		Tables.start();
		ArrayList<Terminal> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM terminal "+
				"WHERE approved = true";
		String name = Tables.testRequste(request);
		if(!name.equals("")) {

			try {
				PreparedStatement statement = Tables.getCon().prepareStatement(query);
	
				ResultSet resultSet = statement.executeQuery();
	
				while(resultSet.next()) {
					//System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " " + resultSet.getString(3) +" " +
						//	resultSet.getString(4) + " " + resultSet.getString(5) + " " + resultSet.getString(6));
	
					Terminal terminal = new Terminal();
					terminal.setID(resultSet.getInt("tid"));
					terminal.setName(resultSet.getString("name"));
					terminal.setTerminalCode(resultSet.getString("terminal_code"));
					terminal.setType(resultSet.getString("type"));
					terminal.setUnlo(resultSet.getString("unlo"));
					terminal.setPortId(resultSet.getInt("port_id"));
	
	
					result.add(terminal);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all terminals" + e);
			}
		}

		return result;
	}
	
	
	
	public int testConflict(Terminal test) {
		int result = 0;
		String query = "SELECT * FROM terminalconflict(?,?)";
		
		try {
		PreparedStatement statement = Tables.getCon().prepareStatement(query);
		statement.setString(1, test.getName());
		statement.setString(2, test.getTerminalCode());
		
		ResultSet resultSet = statement.executeQuery();
			
		if(!resultSet.next()) {
			result = 0;
		} else {
			result = resultSet.getInt("tid");
		}
		
		} catch (SQLException e) {
			System.err.println("Could not test conflcit IN apps" + e);
		}
		return result;
	}

}
