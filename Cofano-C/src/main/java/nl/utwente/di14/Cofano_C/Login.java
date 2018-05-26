package nl.utwente.di14.Cofano_C;

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
 * Servlet for logging in
 * @author jesse
 *
 */


@WebServlet(description="Login Servlet", urlPatterns={"/login"})

public class Login extends HttpServlet {
	private static final Collection<String> SCOPES = Arrays.asList("email", "profile");
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

	private GoogleAuthorizationCodeFlow flow;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String state = new BigInteger(130, new SecureRandom()).toString(32);  // prevent request forgery
		request.getSession().setAttribute("state", state);

		request.getSession().setAttribute("loginDestination", "/dashboard");

		flow = new GoogleAuthorizationCodeFlow.Builder(
				HTTP_TRANSPORT,
				JSON_FACTORY,
				getServletContext().getInitParameter("google.clientID"),
		        getServletContext().getInitParameter("google.clientSecret"),
				SCOPES)
				.build();

		// Callback url should be the one registered in Google Developers Console
		GenericUrl callbackUrl = new GenericUrl(request.getRequestURL().toString());
		callbackUrl.setRawPath(getServletContext().getInitParameter("cofano.url") + "/oauth2callback");
		String redirectUrl =
				flow.newAuthorizationUrl()
						.setRedirectUri(callbackUrl.toString())
						.setState(state)            // Prevent request forgery
						.build();
		response.sendRedirect(redirectUrl+"&hd=student.utwente.nl"); // TODO HERE WE MUST SET COFANO ONLY
	}
}

//public class Login extends AbstractAuthorizationCodeServlet {
//
//
//
//	// Set the data that we want to access
//	private static final Collection<String> SCOPES = Arrays.asList("email", "profile");
//
//	  @Override
//	  protected void doGet(HttpServletRequest request, HttpServletResponse response)
//	      throws IOException, ServletException {
//		  RequestDispatcher view = request.getRequestDispatcher("index.html");
//	      view.forward(request, response);
//	  }
//
//	  @Override
//	  protected String getRedirectUri(HttpServletRequest req) throws ServletException, IOException {
//	    GenericUrl url = new GenericUrl(req.getRequestURL().toString());
//	    url.setRawPath(getServletContext().getInitParameter("cofano.url") + "/oauth2callback");
//	    return url.build();
//	  }
//
//	  /*
//	  @Override
//	  protected AuthorizationCodeFlow initializeFlow() throws IOException {
//	    return new AuthorizationCodeFlow.Builder(BearerToken.authorizationHeaderAccessMethod(),
//	        new NetHttpTransport(),
//	        new JacksonFactory(),
//	        new GenericUrl("https://server.example.com/token"),
//	        new BasicAuthentication("s6BhdRkqt3", "7Fjfp0ZBr1KtDRbnfVdmIw"),
//	        "s6BhdRkqt3",
//	        "https://server.example.com/authorize").setCredentialDataStore(
//	            StoredCredential.getDefaultDataStore(
//	                new FileDataStoreFactory(new File("datastoredir"))))
//	        .build();
//	  }
//	  */
//
//	  @Override
//	  protected AuthorizationCodeFlow initializeFlow() throws IOException {
//	    return new GoogleAuthorizationCodeFlow.Builder(
//	        new NetHttpTransport(),
//	        JacksonFactory.getDefaultInstance(),
//	        getServletContext().getInitParameter("google.clientID"),
//	        getServletContext().getInitParameter("google.clientSecret"),
//	        SCOPES)
//	    	.setApprovalPrompt("auto")
//	    	.build();
//	  }
//
//	  @Override
//	  protected String getUserId(HttpServletRequest req) throws ServletException, IOException {
//	    // return user ID
//		return null;
//	  }
//}