package nl.utwente.di14.Cofano_C.auth;

import java.io.IOException;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Collection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;


/**
 * Handles google OAuth2 login requests.
 */
@WebServlet(description = "GoogleLogin Servlet", urlPatterns = {"/googlelogin"})
public class GoogleLogin extends HttpServlet {
    /**
     * Initialized necessary instance variables.
     */
    private static final Collection<String> SCOPES = Arrays.asList("email", "profile");
    private static final JsonFactory JSON_FACTORY = new JacksonFactory();
    private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

    /**
     * Handles a new login request.
     *
     * @param request  The HTTP request
     * @param response The HTTP response
     * @throws IOException thrown when an IO exception occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String state = new BigInteger(130, new SecureRandom()).toString(32);
        // prevent request forgery
        request.getSession().setAttribute("state", state);

        request.getSession().setAttribute("loginDestination", "/");

        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT,
                JSON_FACTORY,
                getServletContext().getInitParameter("google.clientID"),
                getServletContext().getInitParameter("google.clientSecret"),
                SCOPES)
                .build();

        // Callback url should be the one registered in Google Developers Console
        GenericUrl callbackUrl = new GenericUrl(request.getRequestURL().toString());
        callbackUrl.setRawPath(getServletContext().
                getInitParameter("cofano.url") + "/oauth2callback");
        String redirectUrl =
                flow.newAuthorizationUrl()
                        .setRedirectUri(callbackUrl.toString())
                        .setState(state)            // Prevent request forgery
                        .build();
        response.sendRedirect(redirectUrl + "&hd=student.utwente.nl");
        // TODO HERE WE MUST SET COFANO ONLY
    }
}