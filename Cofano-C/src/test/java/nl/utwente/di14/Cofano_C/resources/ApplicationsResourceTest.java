package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.Application;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;


public class ApplicationsResourceTest {


    private String APIkeyForRetrieval;
    private String APIkeyForDeletion;
    private ApplicationsResource servlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    private SecurityContext securityContext;

    @Before
    public void setUp() {
        securityContext = new SecurityContext() {
            @Override
            public Principal getUserPrincipal() {
                return () -> "p.h.knot@student.utwente.nl";
            }

            @Override
            public boolean isUserInRole(String s) {
                return true;
            }

            @Override
            public boolean isSecure() {
                return true;
            }

            @Override
            public String getAuthenticationScheme() {
                return "Bearer";
            }
        };
        servlet = new ApplicationsResource();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();

        //For retrieving
        String appString1 = servlet.generateAPI(request, securityContext).toString();
        APIkeyForRetrieval = appString1.substring(appString1.lastIndexOf(':') + 2);
        System.out.println("Generated API key for retrieval testing: " + APIkeyForRetrieval);

        //For removal
        String appString2 = servlet.generateAPI(request, securityContext).toString();
        APIkeyForDeletion = appString2.substring(appString2.lastIndexOf(':') + 2);
        System.out.println("Generated API key for deletion testing: " + APIkeyForDeletion);
    }

    @After
    public void tearDown() {
    }

    @Test
    public void getAllApps() {
        ArrayList<Application> result = new ArrayList<>();

        String query = "SELECT * FROM application";
        getResults(result, query);
        assertEquals(servlet.getAllApps(request).toString(), result.toString());
    }

    @Test
    public void generateAPI() {
        String appString = servlet.generateAPI(request, securityContext).toString();
        String APIkeyTest = appString.substring(appString.lastIndexOf(':') + 1);
        assertTrue(APIkeyTest.length() == 57);
    }

    @Test
    public void retrieveApp() {
        ArrayList<Application> result = new ArrayList<>();
        String query = "SELECT * FROM application WHERE api_key = '" + APIkeyForRetrieval + "'";
        System.out.println("Query: " + query);
        getResults(result, query);
        String retrievedKey = result.toString().substring(result.toString().lastIndexOf(':') + 1);
        assertEquals(" " + APIkeyForRetrieval + "]", retrievedKey);
    }

    private void getResults(ArrayList<Application> result, String query) {
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
    }

    @Test
    public void deleteApp() {
        String query = "DELETE FROM application WHERE api_key = '" + APIkeyForDeletion + "'";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        ArrayList<Application> result = new ArrayList<>();
        String queryRetrieval = "SELECT * FROM application WHERE api_key = '" + APIkeyForDeletion + "'";
        System.out.println("Query: " + query);
        getResults(result, queryRetrieval);

        assertEquals("[]", result.toString());
    }

    @Test
    public void updateApp() {
    }
}