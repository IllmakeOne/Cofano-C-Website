package nl.utwente.di14.Cofano_C.data.ships;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import java.io.IOException;

@WebServlet(description="Application Data Servlet", urlPatterns={"/ships/add"})

public class AddShip extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setAttribute("action", "Add");
		request.setAttribute("method", "post");
		request.setAttribute("formUrl", getServletContext().getInitParameter("cofano.url") + "/api/ships/add" );
		RequestHelper.show(request, response, getServletContext(), "/WEB-INF/jsp/data/ships/edit.jsp");
	}
}
