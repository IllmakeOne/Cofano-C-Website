package nl.utwente.di14.Cofano_C.data;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(description="Application Data Servlet", urlPatterns={"/addapp"})

public class AddApps extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setAttribute("page", "data/addapps");           // Tells base.jsp to include form.jsp
		request.getRequestDispatcher("/WEB-INF/jsp/data/addapps.jsp").forward(request, response);
	}
}
