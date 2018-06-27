package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Port;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


@Path("/ports")
public class PortsResource {

    private final String myName = "port";


    /**
     * @return a JSON array of all approved ports
     */
    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Port> getAllPorts(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Port> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM port " +
                "WHERE approved = true";

	/**
	 * This is used for displaying unapproved entries, which await deletion or approval
	 * this method only returns something if the request is comming from our website
	 * @return an JSON array of unapproved entries
	 */
	@GET
	@Path("unapproved")
	@Produces({MediaType.APPLICATION_JSON})
	public ArrayList<Port> getAllPortUN(@Context HttpServletRequest request){
		Tables.start();
		//System.out.println("getting some ports");
		ArrayList<Port> result = new ArrayList<>();
		String query = "SELECT * " +
				"FROM port " +
				"WHERE approved = false";
		
		if(request.getSession().getAttribute("userEmail")!=null) {
	
			try {
				PreparedStatement statement =
						Tables.getCon().prepareStatement(query);
				ResultSet resultSet = statement.executeQuery();
				while(resultSet.next()) {
					Port port = new Port();
					port.setId(resultSet.getInt("pid"));
					port.setName(resultSet.getString("name"));
					port.setUnlo(resultSet.getString("unlo"));
					result.add(port);
				}
			} catch (SQLException e) {
				System.err.println("Could not retrieve all unapproved ports" + e);
			}
		} 
	
		return result;
	
	}

            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                constructPort(result, resultSet);
            } catch (SQLException e) {
                System.err.println("Could not retrieve all approved ports" + e);
            }
        }

        return result;
    }

    /**
     * Extracted method to construct a port.
     *
     * @param result    the result being constructed
     * @param resultSet the Set with elements to be added to result
     * @throws SQLException if an exception occurs
     */
    private void constructPort(ArrayList<Port> result, ResultSet resultSet) throws SQLException {
        while (resultSet.next()) {
            Port port = new Port();
            port.setId(resultSet.getInt("pid"));
            port.setName(resultSet.getString("name"));
            port.setUnlo(resultSet.getString("unlo"));


            result.add(port);
        }
    }


    /**
     * This is used for displaying unapproved entries, which await deletion or approval.
     * this method only returns something if the request is coming from our website
     *
     * @return an JSON array of unapproved entries
     */
    @GET
    @Path("unapproved")
    @Produces({MediaType.APPLICATION_JSON})
    public ArrayList<Port> getAllPortUN(@Context HttpServletRequest request) {
        Tables.start();
        ArrayList<Port> result = new ArrayList<>();
        String query = "SELECT * " +
                "FROM port " +
                "WHERE approved = false";

        if (request.getSession().getAttribute("userEmail") != null) {

            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                constructPort(result, resultSet);
            } catch (SQLException e) {
                System.err.println("Could not retrieve all unapproved ports" + e);
            }
        }

        return result;

    }


	/**
	 * this method deletes an entry from a table and also adds it to history
	 * @param portId the id of the entry which is deleted
	 */
	@DELETE
	@Path("/{portId}")
	public void deletPort(@PathParam("portId") int portId,
			@Context HttpServletRequest request) {
		Tables.start();
		
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {
	
			Port  aux = getPort(portId, request);
			String query ="SELECT deleteport(?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, portId);
				statement.executeQuery();
			} catch (SQLException e) {
				System.err.println("Was not able to delete Port");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
			Tables.addHistoryEntry("DELETE", doer, 
					aux.toString(), myname, true);
		}
	}
	
	/**
	 * this method deletes an entry from a table but doest not enter in in the database
	 * this method is called for unapproved entries
	 * @param portId the id of the entry which is deleted
	 */
	@DELETE
	@Path("/unapproved/{portId}")
	public void deletPortUN(@PathParam("portId") int portId,
			@Context HttpServletRequest request) {
		Tables.start();		
		if(request.getSession().getAttribute("userEmail")!=null) {
			String query ="SELECT deleteport(?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, portId);
				statement.executeQuery();
			} catch (SQLException e) {
				System.err.println("Was not able to delete unapproved Port");
				System.err.println(e.getSQLState());
				e.printStackTrace();
			}
		}
	}

	/**
	 * this method changes an entry in the database
	 * @param portId the ID of the entry about to be changed
	 * @param port the new information for the entry
	 */
	@PUT
	@Path("/{portId}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateContainer(@PathParam("portId") int portId, 
			Port port,@Context HttpServletRequest request) {
		
		String doer = Tables.testRequest(request);
		if(!doer.equals("")) {			
			Port aux = getPort(portId, request);
			String query = "SELECT editports(?,?,?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setString(2, port.getName());
				statement.setString(3, port.getUnlo());
				statement.setInt(1, portId);
	
				statement.executeQuery();
	
			} catch (SQLException e) {
				System.err.println("could not update entry IN port");
				e.printStackTrace();
			}
			Tables.addHistoryEntry("UPDATE", doer, 
				aux.toString() + "-->" + port.toString(), myname, false);
		}
	}
	
	/**
	 * this method approves an entry in the database
	 * @param portid the id of the port which is approved
	 */
	@PUT
	@Path("/approve/{portid}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void approvePort(@PathParam("portid") int portid,
			@Context HttpServletRequest request) {
		
		if(request.getSession().getAttribute("userEmail")!=null) {
			Port aux = getPort(portid, request);
			String query = "SELECT approveport(?)";
			try {
				PreparedStatement statement = 
						Tables.getCon().prepareStatement(query);
				statement.setInt(1, portid);
				statement.executeQuery();
	
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			Tables.addHistoryEntry("APPROVE", 
					request.getSession().getAttribute("userEmail").toString(),
					aux.toString() , myname, true);
		}
	}


    /**
     * this function adds an entry to the database.
     * if it is from a user it is directly added and approve
     * if not, it is added but not approved
     *
     * @param input   the entry about to be added
     * @param request the request of the client
     */
    @SuppressWarnings("Duplicates")
    @POST
    @Path("add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void addPort(Port input, @Context HttpServletRequest request) {
        Tables.start();

        int ownID = 0;
        String title = "ADD";
        String doer = Tables.testRequest(request);

        int con = testConflict(input);


        if (request.getSession().getAttribute("userEmail") != null && con == 0) {
            //if its from a cofano employee and it doesn't create conflict, add straight to db
            ownID = addEntry(input, true);
            Tables.addHistoryEntry(title, doer, input.toString(), myName, true);
        } else if (request.getSession().getAttribute("userEmail") != null && con != 0) {
            //if its from a cofano employee and it creates conflict, add but unapproved
            ownID = addEntry(input, false);

            Tables.addHistoryEntry(title, doer, input.toString(), myName, false);
        } else if (!doer.equals("")) {
            //if its from an api add to unapproved
            ownID = addEntry(input, false);
            Tables.addHistoryEntry(title, doer, input.toString(), myName, false);
        }

        if (con != 0) {
            //if it creates a conflict, add it to conflict table
            Tables.addtoConflicts(myName, doer, ownID, con);
            //add to history
            Tables.addHistoryEntry("CON", doer, ownID + " "
                    + input.toString() + " con with " + con, myName, false);

        }

    }


    /**
     * this method adds a Port entry to the Database.
     *
     * @param entry the Port about to be added
     * @param app   if the port is approved or not
     * @return the ID which is assigned to this port by the database
     */
    private int addEntry(Port entry, boolean app) {
        String query = "SELECT addport(?,?,?)";
        int rez = 0;
        //gets here if the request is from API
        //add to conflicts table
        try {
            //Create prepared statement
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
            //add the data to the statement's query
            statement.setString(1, entry.getName());
            statement.setString(2, entry.getUnlo());
            statement.setBoolean(3, app);

            ResultSet res = statement.executeQuery();
            res.next();
            rez = res.getInt(1);
        } catch (SQLException e) {
            System.err.println("Could not add  port ");
            System.err.println(e.getSQLState());
            e.printStackTrace();
        }
        return rez;
    }


    /**
     * this method deletes an entry from a table and also adds it to history.
     *
     * @param portId the id of the entry which is deleted
     */
    @DELETE
    @Path("/{portId}")
    public void deletePort(@PathParam("portId") int portId,
                           @Context HttpServletRequest request) {
        Tables.start();

        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {

            Port aux = getPort(portId, request);
            String query = "SELECT deleteport(?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setLong(1, portId);
                statement.executeUpdate();
            } catch (SQLException e) {
                System.err.println("Was not able to delete Port");
                System.err.println(e.getSQLState());
                e.printStackTrace();
            }
            Tables.addHistoryEntry("DELETE", doer,
                    aux.toString(), myName, true);
        }
    }

    /**
     * this method changes an entry in the database.
     *
     * @param portId the ID of the entry about to be changed
     * @param port   the new information for the entry
     */
    @PUT
    @Path("/{portId}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateContainer(@PathParam("portId") int portId,
                                Port port, @Context HttpServletRequest request) {

        String doer = Tables.testRequest(request);
        if (!doer.equals("")) {
            Port aux = getPort(portId, request);
            String query = "SELECT editports(?,?,?)";
            try {
                PreparedStatement statement =
                        Tables.getCon().prepareStatement(query);
                statement.setString(2, port.getName());
                statement.setString(3, port.getUnlo());
                statement.setInt(1, portId);

                statement.executeQuery();

            } catch (SQLException e) {
                System.err.println("could not update entry IN port");
                e.printStackTrace();
            }
            Tables.addHistoryEntry("UPDATE", doer,
                    aux.toString() + "-->" + port.toString(), myName, false);
        }

    }


    /**
     * this tests if there a new Port creates a conflict in the DB if it is added.
     * it creates a conflict if the name or unlo is the same as another entry in the DB
     *
     * @param test the Port which is tested
     * @return the id of the port it is on conflict with
     * or 0 if there is no conflict
     */
    private int testConflict(Port test) {
        int result = -1;
        String query = "SELECT * FROM portconflict(?,?)";

        try {
            PreparedStatement statement =
                    Tables.getCon().prepareStatement(query);
            statement.setString(1, test.getName());
            statement.setString(2, test.getUnlo());

            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.next()) {
                result = 0;
            } else {
                result = resultSet.getInt("pid");
            }

        } catch (SQLException e) {
            System.err.println("Could not test conflict IN port " + e);
        }
        return result;
    }

}
