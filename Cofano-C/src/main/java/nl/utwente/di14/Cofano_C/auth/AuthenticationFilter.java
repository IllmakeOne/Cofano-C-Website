package nl.utwente.di14.Cofano_C.auth;

import nl.utwente.di14.Cofano_C.dao.Tables;

import javax.annotation.Priority;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import javax.ws.rs.ext.Provider;
import java.security.Principal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Secured
@Provider
@Priority(Priorities.AUTHENTICATION)
public class AuthenticationFilter implements ContainerRequestFilter {
	@Context
	HttpServletRequest webRequest;

	private static final String REALM = "example";
	private static final String AUTHENTICATION_SCHEME = "Bearer";


	@Override
	public void filter(ContainerRequestContext requestContext) {
		final HttpSession session = webRequest.getSession();

		final String username = getUsername(requestContext);

		final SecurityContext currentSecurityContext = requestContext.getSecurityContext();
		requestContext.setSecurityContext(new SecurityContext() {

			@Override
			public Principal getUserPrincipal() {
				return () -> username;
			}

			@Override
			public boolean isUserInRole(String role) {
				return true;
			}

			@Override
			public boolean isSecure() {
				return currentSecurityContext.isSecure();
			}

			@Override
			public String getAuthenticationScheme() {
				return AUTHENTICATION_SCHEME;
			}
		});


		if (username == null || username.equals("")) {
			abortWithUnauthorized(requestContext);
			return;
		}


	}

	private boolean isTokenBasedAuthentication(String authorizationHeader) {

		// Check if the Authorization header is valid
		// It must not be null and must be prefixed with "Bearer" plus a whitespace
		// The authentication scheme comparison must be case-insensitive
		return authorizationHeader != null && authorizationHeader.toLowerCase()
				.startsWith(AUTHENTICATION_SCHEME.toLowerCase() + " ");
	}

	private void abortWithUnauthorized(ContainerRequestContext requestContext) {

		// Abort the filter chain with a 401 status code response
		// The WWW-Authenticate header is sent along with the response
		requestContext.abortWith(
				Response.status(Response.Status.UNAUTHORIZED)
						.header(HttpHeaders.WWW_AUTHENTICATE,
								AUTHENTICATION_SCHEME + " realm=\"" + REALM + "\"")
						.build());
	}

	private void validateToken(String token) throws Exception {
		// Check if the token was issued by the server and if it's not expired
		// Throw an Exception if the token is invalid
	}

	private String getToken(String authorizationHeader) {
		return authorizationHeader.substring(AUTHENTICATION_SCHEME.length()).trim();
	}


	private String getUsername(ContainerRequestContext requestContext) {

		String authorizationHeader = requestContext.getHeaderString(HttpHeaders.AUTHORIZATION);

		if (webRequest.getSession().getAttribute("token") != null) {
			return (String) webRequest.getSession().getAttribute("userEmail");
		} else if (isTokenBasedAuthentication(authorizationHeader)) {

			String query = "SELECT testrequest(?)";
			try (Connection connection = Tables.getCon(); PreparedStatement statement = connection.prepareStatement(query)) {
				statement.setString(1, getToken(authorizationHeader));
				try (ResultSet rez = statement.executeQuery()) {
					if (rez.next()) {
						return tidyup(rez.getString(1));
					}
				}
			} catch (SQLException e) {
				requestContext.abortWith(
						Response.status((Response.Status.INTERNAL_SERVER_ERROR)).build()
				);
			}
		}

		return "";
	}

	/**
	 * this methods takes a strig and reformats it
	 * the method is called to reformat string comming from the database
	 *
	 * @param str the string to be inputed
	 * @return the formatted string
	 */

	private static String tidyup(String str) {
		String[] aux = str.split(",");
		return aux[0].substring(1) + " " + aux[1].substring(0, aux[1].length() - 1);
	}


}