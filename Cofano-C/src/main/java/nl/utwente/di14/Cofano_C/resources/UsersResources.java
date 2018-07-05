package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.auth.Secured;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.InternalServerErrorException;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@Path("/users")
public class UsersResources {


    /**
     * @return a JSON array of all users
     * this can only be accessed by users of our website
     */
    @GET
    @Secured
    @Produces({MediaType.APPLICATION_JSON})
    public List<User> getAllUsers(@Context HttpServletRequest request) {

        ArrayList<User> end = new ArrayList<>();

        String query = "SELECT * " +
                "FROM public.user";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.
                prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

            User add;

            while (resultSet.next()) {
                add = new User();
                add.setEmail(resultSet.getString("email"));
                add.setId(resultSet.getInt("uid"));
                add.setName(resultSet.getString("name"));
                add.setLastLoggedIn(resultSet.getTimestamp("last_login"));

                end.add(add);
            }


        } catch (SQLException e) {
            System.err.println("Something went wrong while retrieving all users because: " + e.getSQLState());
            e.printStackTrace();
            throw new InternalServerErrorException();
        }

        return end;
    }
}
