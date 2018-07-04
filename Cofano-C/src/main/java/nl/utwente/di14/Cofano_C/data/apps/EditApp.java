package nl.utwente.di14.Cofano_C.data.apps;

import nl.utwente.di14.Cofano_C.util.RequestHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static org.apache.commons.text.StringEscapeUtils.escapeHtml4;


/**
 * Data object for editing apps.
 */
@WebServlet(description = "Application Data Servlet", urlPatterns = {"/application/*"})
public class EditApp extends HttpServlet {

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
        request.setAttribute("action", "Edit");
        request.setAttribute("method", "put");

        String pathInfo = request.getPathInfo();
        String appId = escapeHtml4(pathInfo.split("/")[1]);

        request.setAttribute("app", appId);
        request.setAttribute("formUrl", getServletContext()
                .getInitParameter("cofano.url") + "/api/applications/" + appId);

        RequestHelper.show(request, response, getServletContext(),
                "/WEB-INF/jsp/data/apps/edit.jsp");
    }
}
