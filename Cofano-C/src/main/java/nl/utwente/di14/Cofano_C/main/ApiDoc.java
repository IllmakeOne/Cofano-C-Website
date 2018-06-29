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
@WebServlet(description = "Api Dcumentation Servlet", urlPatterns = {"/apidoc"})
public class ApiDoc extends HttpServlet {


    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (req.getSession().getAttribute("token") != null) {
            req.getRequestDispatcher("/WEB-INF/jsp/data/apidoc.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(getServletContext().getInitParameter("cofano.url") + "/login");
        }
    }
}
