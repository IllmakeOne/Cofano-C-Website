package nl.utwente.di14.Cofano_C.data.terminals;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import java.io.IOException;

/**
 * Data object for adding a terminal.
 */
@WebServlet(description = "Application Data Servlet", urlPatterns = {"/addterminal"})
public class AddTerminal extends HttpServlet {

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
		request.setAttribute("action", "Add");
		request.setAttribute("method", "post");
		request.setAttribute("formUrl",
				getServletContext().getInitParameter("cofano.url") + "/api/terminals/add" );
    }
}
