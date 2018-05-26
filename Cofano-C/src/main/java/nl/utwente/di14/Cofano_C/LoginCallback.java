package nl.utwente.di14.Cofano_C;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.auth.oauth2.*;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.http.*;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

@WebServlet(description="LoginCallback Servlet", urlPatterns={"/oauth2callback"})
public class LoginCallback extends HttpServlet {
	private static final Collection<String> SCOPES = Arrays.asList("email", "profile");
	private static final String USERINFO_ENDPOINT
			= "https://www.googleapis.com/plus/v1/people/me/openIdConnect";
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

	private GoogleAuthorizationCodeFlow flow;

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		// Ensure that this is no request forgery going on, and that the user
		// sending us this connect request is the user that was supposed to.
		if (req.getSession().getAttribute("state") == null
				|| !req.getParameter("state").equals((String) req.getSession().getAttribute("state"))) {
			resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			resp.sendRedirect("/");
			return;
		}

		req.getSession().removeAttribute("state");     // Remove one-time use state.

		flow = new GoogleAuthorizationCodeFlow.Builder(
				HTTP_TRANSPORT,
				JSON_FACTORY,
				getServletContext().getInitParameter("google.clientID"),
				getServletContext().getInitParameter("google.clientSecret"),
				SCOPES)
				.setApprovalPrompt("auto")
				.build();

		GenericUrl callbackUrl = new GenericUrl(req.getRequestURL().toString());
		callbackUrl.setRawPath(getServletContext().getInitParameter("cofano.url") + "/oauth2callback");

		final TokenResponse tokenResponse =
				flow.newTokenRequest(req.getParameter("code"))
						.setRedirectUri(callbackUrl.toString())
						.execute();

		req.getSession().setAttribute("token", tokenResponse.toString()); // Keep track of the token.
		final Credential credential = flow.createAndStoreCredential(tokenResponse, null);
		final HttpRequestFactory requestFactory = HTTP_TRANSPORT.createRequestFactory(credential);

		final GenericUrl url = new GenericUrl(USERINFO_ENDPOINT);      // Make an authenticated request.
		final HttpRequest request = requestFactory.buildGetRequest(url);
		request.getHeaders().setContentType("application/json");

		final String jsonIdentity = request.execute().parseAsString();
		HashMap<String, String> userIdResult = null;
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

		if (userIdResult.get("hd").equals("student.utwente.nl")) { //TODO check
			req.getSession().setAttribute("userEmail", userIdResult.get("email"));
			req.getSession().setAttribute("userId", userIdResult.get("sub"));
			req.getSession().setAttribute("userImageUrl", userIdResult.get("picture"));
			req.getSession().setAttribute("userName", userIdResult.get("given_name"));
			req.getSession().setAttribute("userFamilyName", userIdResult.get("family_name"));
			resp.sendRedirect(getServletContext().getInitParameter("cofano.url") +
					req.getSession().getAttribute("loginDestination"));
		} else {
			resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
			resp.setContentType("text/html");
			PrintWriter out = resp.getWriter();
			out.append("You must be part of the Cofano team! Change the setting in LoginCallback.java");
			out.close();
		}
	}

}