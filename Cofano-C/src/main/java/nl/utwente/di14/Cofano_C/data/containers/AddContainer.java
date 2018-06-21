package nl.utwente.di14.Cofano_C.data.containers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import java.io.IOException;

@WebServlet(description = "Application Data Servlet", urlPatterns = {"/addcontainer"})

public class AddContainer extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        RequestHelper.show(request, response, getServletContext(),
                "/WEB-INF/jsp/data/containers/edit.jsp");
    }
}
