package nl.utwente.di14.Cofano_C.data.ships;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description="Ship Data Servlet", urlPatterns={"/ships"})

public class Ships extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		RequestHelper.show(request, response, getServletContext(), "/WEB-INF/jsp/data/ships/overview.jsp");
	}
}
