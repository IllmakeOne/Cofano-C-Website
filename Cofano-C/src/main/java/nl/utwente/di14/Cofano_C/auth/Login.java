package nl.utwente.di14.Cofano_C.auth;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description="Login Servlet", urlPatterns={"/login"})

public class Login extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getSession().getAttribute("token") != null) {
			resp.sendRedirect(getServletContext().getInitParameter("cofano.url"));
		} else {
			System.out.println("JOOO");
			RequestDispatcher view = req.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			view.forward(req, resp);
		}
	}
}