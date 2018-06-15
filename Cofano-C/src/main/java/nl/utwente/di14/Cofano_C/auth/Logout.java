package nl.utwente.di14.Cofano_C.auth;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles log outs
 */
@WebServlet(description = "Logout Servlet", urlPatterns = {"/logout"})
public class Logout extends HttpServlet {

    /**
     * Handles the HTTP servlet GET requests
     *
     * @param request  the HTTP servlet request
     * @param response the HTTP servlet response
     * @throws IOException thrown when an IO exception occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // you can also make an authenticated request to logout, but here we choose to
        // simply delete the session variables for simplicity
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // rebuild session
        request.getSession();


        response.sendRedirect(getServletContext().getInitParameter("cofano.url"));
    }
}
