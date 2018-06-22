package nl.utwente.di14.Cofano_C.main;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description = "Dashboard Servlet", urlPatterns = {"/dashboard"})
public class Dashboard extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("token") != null) {
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(getServletContext().getInitParameter("cofano.url") + "/login");
        }
    }
}
