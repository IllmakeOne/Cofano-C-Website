package nl.utwente.di14.Cofano_C;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(description="Logout Servlet", urlPatterns={"/logout"})

public class Logout extends HttpServlet {
	/*@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// you can also make an authenticated request to logout, but here we choose to
		// simply delete the session variables for simplicity
		HttpSession session =  request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		// rebuild session
		request.getSession();


		response.sendRedirect(getServletContext().getInitParameter("cofano.url"));
	}*/

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// you can also make an authenticated request to logout, but here we choose to
		// simply delete the session variables for simplicity
		HttpSession session =  request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		// rebuild session
		request.getSession();


		response.sendRedirect(getServletContext().getInitParameter("cofano.url"));
	}
}
