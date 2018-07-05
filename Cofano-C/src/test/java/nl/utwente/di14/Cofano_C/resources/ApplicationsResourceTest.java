package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Application;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.Assert.assertEquals;

public class ApplicationsResourceTest {

    private ApplicationsResource servlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;

    @Before
    public void setUp() {
        servlet = new ApplicationsResource();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
    }

    @After
    public void tearDown() {
    }

    @Test
    public void getAllApps() {
        ArrayList<Application> result = new ArrayList<>();

        String query = "SELECT * FROM application";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {
            Application add;

            while (resultSet.next()) {
                add = new Application();
                add.setName(resultSet.getString(2));
                add.setAPIKey(resultSet.getString(3));
                add.setId(resultSet.getInt(1));
                result.add(add);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        assertEquals(servlet.getAllApps(request).toString(), result.toString());
    }

    @Test
    public void generateAPI() {
    }

    @Test
    public void retrieveApp() {
    }

    @Test
    public void deleteApp() {
    }

    @Test
    public void updateApp() {
    }
}