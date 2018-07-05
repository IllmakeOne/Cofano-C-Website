package nl.utwente.di14.Cofano_C.dao;


import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * This class is the Data Access Object for all the database tables.
 * It is also responsible for creating history entries and recording when
 * a user last made a change in the system.
 */
public class Tables {

    private static final String HOST = "farm05.ewi.utwente.nl";
    private static final String DB_NAME = "docker";

    private BasicDataSource bds = new BasicDataSource();


    /**
     * This method starts a connections to the database using PostgreSQL drivers.
     */
    public Tables() {

        //Set database driver name
        bds.setDriverClassName("org.postgresql.Driver");
        bds.setUrl("jdbc:postgresql://" + HOST + ":7028/" + DB_NAME);
        bds.setUsername("docker");
        //Set database password
        bds.setPassword("YsLxCu0I1");
        //Set the connection pool size
        bds.setInitialSize(5);

    }

    private static class TablesHolder {
        private static final Tables INSTANCE = new Tables();
    }

    public static Tables getInstance() {
        return TablesHolder.INSTANCE;
    }

    public BasicDataSource getBds() {
        return bds;
    }

    public void setBds(BasicDataSource bds) {
        this.bds = bds;
    }

    public static Connection getCon() throws SQLException {
        BasicDataSource bds = getInstance().getBds();
        return bds.getConnection();
    }


    public static void addtoConflicts(Connection connection, String table,
                                      String doer, int ownID, int con) throws SQLException {
        String query = "SELECT addconflict(?,?,?,?)";
        //gets here if the request is from API
        //add to conflicts table
        //Create prepared statement
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            //add the data to the statement's query
            statement.setString(1, doer);
            statement.setString(2, table);
            statement.setObject(3, ownID);
            statement.setInt(4, con);

            statement.executeQuery();
        }

    }


    //Code below this point is legacy and just used for
    //reference during the development process

    /*
	public static Tables getInstance() throws IOException, SQLException, PropertyVetoException {
		if (datasource == null) {
			datasource = new Tables();
			return datasource;
		} else {
			return datasource;
		}
	}

	public Connection getConnection() throws SQLException {
		return this.cpds.getConnection();
	}

    public static void forceStart() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://" + HOST + ":7028/" + DB_NAME;
            con = DriverManager.getConnection(url, "docker", "YsLxCu0I1");
            con.setAutoCommit(false);
        } catch (ClassNotFoundException cnfe) {
            System.err.println("Error loading driver: " + cnfe);
        }
    }

    *//*
      Shuts down the connection in a safe manner.
     *//*
    public static void shutDown() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            System.err.println("could not shut down safely");
        }
    }


    *//*
      Getter for the connection.

      @return the current<code>Connection</code>
     *//*
    public static Connection getCon() throws SQLException {
        if (con == null || con.isClosed()) {
            System.out.println("Apparently someone wanted to have a connection while the connection
            is null or closed!");
            start();
        }
        return con;
    }





    *//*
      Updates the users last login timestamp.

      @param user The user who's last login should be updated
     *//*
    private static void resetLastLogin(String user) throws SQLException {

        String query = "SELECT updatelastlogin(?)";
        PreparedStatement statement = Tables.getCon().prepareStatement(query);
        statement.setString(1, user);
        statement.executeQuery();

    }

    *//*
      Check if the request is valid. I.e. check if it's either a valid Google user or a valid API.

      @param request the <code>HttpServletRequest</code> to be checked
     * @return the name of the API of the request was from an API
     *//*
    public static String testRequest(HttpServletRequest request, Connection connection)
     throws SQLException, ForbiddenException {

        String result = "";
        String user;
        if (request.getSession().getAttribute("userEmail") != null) {
            return (String) request.getSession().getAttribute("userEmail");
        } else if (request.getHeader("Authorization") != null) {
            user = request.getHeader("Authorization");
        } else {
            //returns false if the request isn't from a google user or from an
             //application with an Authorization header
            System.out.println("Error in the first if");
            throw new ForbiddenException();
        }
        //System.out.println(user);

        String query = "SELECT testrequest(?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, user);
            try (ResultSet rez = statement.executeQuery()) {
                if (rez.next()) {
                    result = tidyup(rez.getString(1));
                }
            }
        }

        return result;
    }


    	public static String decideName(HttpServletRequest request) {
    		String stringy ="";
    		if(request.getSession().getAttribute("userEmail")!=null) {
    			stringy = (String)request.getSession().getAttribute("userEmail") ;
    		} else if(request.getHeader("Authorization")!= null) {
    			stringy = request.getHeader("Authorization");
    		}

    		return stringy;
    	}*/

}

