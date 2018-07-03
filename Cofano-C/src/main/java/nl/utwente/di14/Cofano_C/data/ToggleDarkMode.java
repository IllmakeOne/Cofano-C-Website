package nl.utwente.di14.Cofano_C.data;

import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(description = "Dark Mode servlet", urlPatterns = {"/darkmode"})
public class ToggleDarkMode extends HttpServlet {

	/**
	 * Handles the GET request.
	 *
	 * @param request  the HTTP request
	 * @param response the HTTP response
	 * @throws IOException      when there is an <code>IOException</code>
	 * @throws ServletException when there is a <code>ServletException</code>
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		Tables.start();
		User user = ((User) request.getSession().getAttribute("user"));

		try {
			PreparedStatement statement = Tables.getCon().prepareStatement("UPDATE \"user\" SET darkmode = NOT darkmode WHERE uid = ?");
			statement.setInt(1, user.getId());
			statement.execute();
			user.setDarkMode(!user.isDarkMode());
			request.setAttribute("user", user);
		} catch (SQLException e) {
			System.out.println(" Setting dark mode failed because: " + e.getMessage());
		}
		Tables.shutDown();

		response.sendRedirect(getServletContext().getInitParameter("cofano.url"));
	}
}
