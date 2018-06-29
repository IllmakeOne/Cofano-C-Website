package nl.utwente.di14.Cofano_C.auth;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles log ins.
 */
@WebServlet(description = "Login Servlet", urlPatterns = {"/login"})
public class Login extends HttpServlet {

    /**
     * Handles the HTTP servlet GET requests.
     *
     * @param req  the HTTP servlet request
     * @param resp the HTTP servlet response
     * @throws ServletException thrown when the servlet encounters an exception
     * @throws IOException      thrown when an IO Exception occurs
     */
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (req.getSession().getAttribute("token") != null) {
            resp.sendRedirect(getServletContext().getInitParameter("cofano.url"));
        } else {
            RequestDispatcher view = req.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
            view.forward(req, resp);
        }
    }
}