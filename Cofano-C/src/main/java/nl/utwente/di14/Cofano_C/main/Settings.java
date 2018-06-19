package nl.utwente.di14.Cofano_C.main;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import java.io.IOException;

@WebServlet(description="Application Data Servlet", urlPatterns={"/settings"})

public class Settings extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		RequestHelper.show(request, response, getServletContext(), "/WEB-INF/jsp/settings.jsp");
	}
}


//	@Override
//	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//		String docType =
//				"<!DOCTYPE HTML>\n";
//		String title = "Dashboard coming soon...";
//		out.println(docType +
//				"<HTML>\n" +
//				"<HEAD><TITLE>" + title + "</TITLE>" +
//				"</HEAD>\n" +
//				"<BODY BGCOLOR=\"#FDF5E6\">\n" +
//				"<H1>" + title + "</H1>\n" +
//
//				" <P>HOERAAAAA: " + request.getSession().getAttribute("userEmail") + "</P>\n" +
//				" <P>HOERAAAAA: " + request.getSession().getAttribute("userName") + "</P>\n" +
//				" <P>HOERAAAAA: " + request.getSession().getAttribute("userFamilyName") + "</P>\n" +
//				" <a href='./logout'>Loguit</a>\n" +
//
//				"</BODY></HTML>");
//	}

