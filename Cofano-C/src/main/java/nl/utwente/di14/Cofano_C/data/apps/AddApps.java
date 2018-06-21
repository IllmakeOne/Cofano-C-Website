package nl.utwente.di14.Cofano_C.data.apps;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import java.io.IOException;

@WebServlet(description = "Application Data Servlet", urlPatterns = {"/applications/add"})

public class AddApps extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setAttribute("action", "Add");
        request.setAttribute("method", "post");
        request.setAttribute("formUrl", getServletContext().getInitParameter("cofano.url") +
                "/api/applications/add");
        RequestHelper.show(request, response, getServletContext(),
                "/WEB-INF/jsp/data/apps/edit.jsp");
    }
}
