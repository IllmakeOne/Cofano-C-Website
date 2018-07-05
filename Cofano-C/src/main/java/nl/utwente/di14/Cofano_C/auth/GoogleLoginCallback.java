package nl.utwente.di14.Cofano_C.auth;


import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import nl.utwente.di14.Cofano_C.dao.Tables;
import nl.utwente.di14.Cofano_C.model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;

/**
 * Handles the data returned by the Google API.
 */
@WebServlet(description = "GoogleLoginCallback Servlet", urlPatterns = {"/oauth2callback"})
public class GoogleLoginCallback extends HttpServlet {
    private static final Collection<String> SCOPES = Arrays.asList("email", "profile");
    private static final String USERINFO_ENDPOINT
            = "https://www.googleapis.com/plus/v1/people/me/openIdConnect";
    private static final JsonFactory JSON_FACTORY = new JacksonFactory();
    private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

    /**
     * @param req  the HTTP servlet request
     * @param resp the HTTP servlet response
     * @throws IOException thrown when an IO exception occurs
     */
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Ensure that this is no request forgery going on, and that the user
        // sending us this connect request is the user that was supposed to.
        if (req.getSession().getAttribute("state") == null
                || !req.getParameter("state").equals(req.getSession().getAttribute("state"))) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.sendRedirect("/");
            return;
        }

        req.getSession().removeAttribute("state");     // Remove one-time use state.

        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT,
                JSON_FACTORY,
                getServletContext().getInitParameter("google.clientID"),
                getServletContext().getInitParameter("google.clientSecret"),
                SCOPES)
//				.setApprovalPrompt("auto")
                .build();

        GenericUrl callbackUrl = new GenericUrl(req.getRequestURL().toString());
        callbackUrl.setRawPath(getServletContext().
                getInitParameter("cofano.url") + "/oauth2callback");

        final TokenResponse tokenResponse =
                flow.newTokenRequest(req.getParameter("code"))
                        .setRedirectUri(callbackUrl.toString())
                        .execute();

        req.getSession().setAttribute("token", tokenResponse.toString());
        // Keep track of the token.
        final Credential credential = flow.createAndStoreCredential(tokenResponse, null);
        final HttpRequestFactory requestFactory = HTTP_TRANSPORT.createRequestFactory(credential);

        final GenericUrl url = new GenericUrl(USERINFO_ENDPOINT);
        // Make an authenticated request.
        final HttpRequest request = requestFactory.buildGetRequest(url);
        request.getHeaders().setContentType("application/json");

        final String jsonIdentity = request.execute().parseAsString();
        HashMap userIdResult = null;
        try {
            userIdResult = new ObjectMapper().readValue(jsonIdentity, HashMap.class);
        } catch (JsonMappingException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("text/html");
            PrintWriter out = resp.getWriter();
            out.append("Oops! Troubles logging in with Google Oauth.");
            out.close();
        }
        // From this map, extract the relevant profile info and store it in the session.
        // See also: https://developers.google.com/+/web/api/rest/openidconnect/getOpenIdConnect

        if (userIdResult != null && ((String) userIdResult.get("hd")).equals((getServletContext()
                .getInitParameter("google.hostdomain"))) || ((String) userIdResult.get("hd")).endsWith(
                        "." + getServletContext().getInitParameter("google.hostdomain"))) {
            req.getSession().setAttribute("userEmail", userIdResult.get("email"));
            req.getSession().setAttribute("userId", userIdResult.get("sub"));
            req.getSession().setAttribute("userImageUrl", userIdResult.get("picture"));
            req.getSession().setAttribute("userName", userIdResult.get("given_name"));
            req.getSession().setAttribute("userFamilyName", userIdResult.get("family_name"));
            req.getSession().setAttribute("userFullName", userIdResult.get("name"));
            resp.sendRedirect(getServletContext().getInitParameter("cofano.url") +
                    req.getSession().getAttribute("loginDestination"));

            String sql = "SELECT * from addorselectuser(?, ?)";

            try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, (String) userIdResult.get("name"));
                statement.setString(2, (String) userIdResult.get("email"));
                ResultSet resultSet = statement.executeQuery();
                connection.commit();
                while (resultSet.next()) {
                    User user = new User();
                    user.setEmail(resultSet.getString("email"));
                    user.setName(resultSet.getString("name"));
                    user.setDarkMode(resultSet.getBoolean("darkmode"));
                    user.setId(resultSet.getInt("uid"));
                    req.getSession().setAttribute("user", user);
                }

            } catch (SQLException e) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("text/html");
                PrintWriter out = resp.getWriter();
                out.append("Could not connect to the Database.");
                out.close();
            }

        } else {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            // rebuild session
            req.getSession();
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            resp.setContentType("text/html");
            PrintWriter out = resp.getWriter();
            out.append("You must be part of the Cofano team! " +
                    "Change the setting in GoogleLoginCallback.java");
            out.close();
        }
    }

}