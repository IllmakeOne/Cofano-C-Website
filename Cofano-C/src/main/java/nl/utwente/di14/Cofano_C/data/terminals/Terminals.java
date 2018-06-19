package nl.utwente.di14.Cofano_C.data.terminals;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description="Terminals Data Servlet", urlPatterns={"/terminals"})

public class Terminals extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		RequestHelper.show(request, response, getServletContext(), "/WEB-INF/jsp/data/terminals/overview.jsp");
	}
}
