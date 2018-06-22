package nl.utwente.di14.Cofano_C.data.ships;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static org.apache.commons.lang3.StringEscapeUtils.escapeHtml4;

@WebServlet(description="Application Data Servlet", urlPatterns={"/ship/*"})

public class EditShip extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setAttribute("action", "Edit");
		request.setAttribute("method", "put");

		String pathInfo = request.getPathInfo();
		String appId = escapeHtml4(pathInfo.split("/")[1]);

		request.setAttribute("app", appId);
		request.setAttribute("formUrl", getServletContext().getInitParameter("cofano.url") + "/api/ships/" + appId);

		RequestHelper.show(request, response, getServletContext(), "/WEB-INF/jsp/data/ships/edit.jsp");
	}
}
