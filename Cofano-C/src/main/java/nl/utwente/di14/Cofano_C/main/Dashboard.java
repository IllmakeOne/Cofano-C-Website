package nl.utwente.di14.Cofano_C.main;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * This is the data object class for the 'Dashboard' web servlet.
 */
@WebServlet(description = "Dashboard Servlet", urlPatterns = {"/dashboard"})
public class Dashboard extends HttpServlet {

    /**
     * This method handles the <code>HttpServletRequest</code>s.
     *
     * @param req  the HTTP Servlet request
     * @param resp the HTTP Servlet response
     * @throws ServletException when there is a servlet exception
     * @throws IOException      when there is an IO exception
     */
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (req.getSession().getAttribute("token") != null) {
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(getServletContext().getInitParameter("cofano.url") + "/login");
        }
    }
}
