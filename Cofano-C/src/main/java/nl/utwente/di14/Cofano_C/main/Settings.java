package nl.utwente.di14.Cofano_C.main;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import java.io.IOException;

/**
 * This class is the main data object for settings.
 */
@WebServlet(description = "Application Data Servlet", urlPatterns = {"/settings"})
public class Settings extends HttpServlet {

    /**
     * This method handles the <code>HttpServletRequest</code>s.
     *
     * @param request  the HTTP Servlet request
     * @param response the HTTP Servlet response
     * @throws ServletException when there is a servlet exception
     * @throws IOException      when there is an IO exception
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        RequestHelper.show(request, response, getServletContext(), "/WEB-INF/jsp/settings.jsp");
    }
}