package nl.utwente.di14.Cofano_C.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

/**
 * Create 403 Forbidden exception.
 */
@SuppressWarnings("SameParameterValue")
public class ForbiddenException extends WebApplicationException {
    private static final long serialVersionUID = 1L;

    public ForbiddenException() {
        this("Unauthorized request!", null);
    }

    /**
     * Create a HTTP 403 (Forbidden) exception.
     *
     * @param msg the String that is the entity of the 409 response.
     */
    private ForbiddenException(String msg, String desc) {
        super(Response.status(Status.FORBIDDEN).entity(
                new ExceptionInfo(Status.FORBIDDEN.getStatusCode(),
                        msg,
                        desc)
        ).type("application/json").build());
    }

}