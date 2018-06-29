package nl.utwente.di14.Cofano_C.util;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RequestHelper {
    public static void show(final HttpServletRequest request, final HttpServletResponse response,
                            final ServletContext context,
                            final String page) throws ServletException, IOException {
        request.setAttribute("base", context.getInitParameter("cofano.url"));
        request.getRequestDispatcher(page).forward(request, response);
    }
}
