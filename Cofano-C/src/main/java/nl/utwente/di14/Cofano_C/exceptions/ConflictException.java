package nl.utwente.di14.Cofano_C.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

/**
 * Create 409 Conflict exception.
 */
@SuppressWarnings("SameParameterValue")
public class ConflictException extends WebApplicationException {
    private static final long serialVersionUID = 1L;

    public ConflictException() {
        this("There is a conflict!", null);
    }

    /**
     * Create a HTTP 409 (Conflict) exception.
     *
     * @param msg the String that is the entity of the 409 response.
     */
    private ConflictException(String msg, String desc) {
        super(Response.status(Status.CONFLICT).entity(
                new ExceptionInfo(Status.CONFLICT.getStatusCode(),
                        msg,
                        desc)
        ).type("application/json").build());
    }

}