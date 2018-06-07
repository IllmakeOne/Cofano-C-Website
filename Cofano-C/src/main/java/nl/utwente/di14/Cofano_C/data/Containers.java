package nl.utwente.di14.Cofano_C.data;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description="Container Data Servlet", urlPatterns={"/containers"})

public class Containers extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setAttribute("base", getServletContext().getInitParameter("cofano.url"));
		request.getRequestDispatcher("/WEB-INF/jsp/data/containers.jsp").forward(request, response);
	}
}
