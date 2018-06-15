package nl.utwente.di14.Cofano_C.dao;


import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * The Data Access Object class for the database tables
 */
public class Tables {

    /**
     * Instance variables containing  the necessary information to connect to the right database
     */
    private static final String host = "farm05.ewi.utwente.nl";
    private static final String dbName = "docker";
    /**
     * The <code>Connection</code> object tha resembles the connection to the postgreSQL database
     */
    private static Connection con;


    /**
     * Starts the connection with the database
     */
    public static void start() {

        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://" + host + ":7028/" + dbName;
            con = DriverManager.getConnection(url, "docker", "YsLxCu0I1");
        } catch (ClassNotFoundException cnfe) {
            System.err.println("Error loading driver: " + cnfe);
        } catch (SQLException e) {
            System.err.println("error loading DB" + e);
        }
    }

    /**
     * Closes the connection properly
     */
    @SuppressWarnings("unused")
    public static void shutDown() {
        try {
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            System.err.println("could not shut down safely");
        }
    }


    /**
     * Getter for the <code>Connection</code> object <code>con</code>
     *
     * @return the current <code>Connection</code> con
     */
    public static Connection getCon() {
        return con;
    }


    /**
     * This method adds an entry to the 'history' table. This is used to track changes in the data system
     *
     * @param title     Title to be inserted into the database
     * @param who       User to be inserted into the database
     * @param message   Message to be inserted into the database
     * @param timestamp The time to be inserted into the database
     */
    public static void addHistoryEntry(String title, String who, String message, Timestamp timestamp) {

        String query = "INSERT INTO history(title,message,added_at) VALUES(?,?,?)";
        try {
            PreparedStatement statement = Tables.getCon().prepareStatement(query);
            statement.setString(1, title);
            statement.setString(2, who + " " + title + " " + message);
            statement.setTimestamp(3, timestamp);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Could not add application IN Tables");
            System.err.println(e.getSQLState());
            e.printStackTrace();
        }
    }


}
