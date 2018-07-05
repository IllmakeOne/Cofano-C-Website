package nl.utwente.di14.Cofano_C.resources;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.ContainerType;
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

public class ContainerTypesResourceTest {

    private ContainerTypesResource servlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;

    @Before
    public void setUp() {
        servlet = new ContainerTypesResource();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
    }

    @After
    public void tearDown() {
    }

    @Test
    public void getAllContainerTypes() {
        ArrayList<ContainerType> result = new ArrayList<>();

        String query = "SELECT * FROM container_type";
        try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {
            ContainerType add;

            while (resultSet.next()) {
                add = new ContainerType();
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

}

    @Test
    public void getAllContainerTypesUN() {
    }

    @Test
    public void retrieveContainer() {
    }

    @Test
    public void addContainer() {
    }

    @Test
    public void deleteContainer() {
    }

    @Test
    public void deleteContainerUN() {
    }

    @Test
    public void approveContainer() {
    }

    @Test
    public void updateContainer() {
    }
}