package nl.utwente.di14.Cofano_C.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

/**
 * Create 500 Internal Server Error exception.
 */
@SuppressWarnings("SameParameterValue")
public class InternalServerErrorException extends WebApplicationException {
    private static final long serialVersionUID = 1L;

    public InternalServerErrorException() {
        this("There occured an internal servcer error!", null);
    }

    /**
     * Create a HTTP 500 (Inernal Server Error) exception.
     *
     * @param msg the String that is the entity of the 409 response.
     */
    private InternalServerErrorException(String msg, String desc) {
        super(Response.status(Status.INTERNAL_SERVER_ERROR).entity(
                new ExceptionInfo(Status.INTERNAL_SERVER_ERROR.getStatusCode(),
                        msg,
                        desc)
        ).type("application/json").build());
    }

}