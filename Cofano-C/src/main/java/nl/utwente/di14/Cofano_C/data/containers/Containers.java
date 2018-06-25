package nl.utwente.di14.Cofano_C.data.containers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Data object for containers.
 */
@WebServlet(description = "Container Data Servlet", urlPatterns = {"/containers"})
public class Containers extends HttpServlet {

    /**
     * Handles the GET request.
     *
     * @param request  the HTTP request
     * @param response the HTTP response
     * @throws IOException      when there is an <code>IOException</code>
     * @throws ServletException when there is a <code>ServletException</code>
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setAttribute("base", getServletContext().getInitParameter("cofano.url"));
        request.getRequestDispatcher("/WEB-INF/jsp/data/containers/overview.jsp")
                .forward(request, response);
    }
}
