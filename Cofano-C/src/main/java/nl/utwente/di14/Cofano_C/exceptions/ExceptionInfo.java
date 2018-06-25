package nl.utwente.di14.Cofano_C.exceptions;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * This class is the XMP Root Element for exception descriptions.
 */
@XmlRootElement
public class ExceptionInfo {
    private final int status;
    private final String msg, desc;

    /**
     * Constructs a new <code>ExceptionInfo</code> element.
     *
     * @param status is the status of the exception
     * @param msg    is the message given with the exception
     * @param desc   is description describing the exception
     */
    public ExceptionInfo(int status, String msg, String desc) {
        this.status = status;
        this.msg = msg;
        this.desc = desc;
    }

    /**
     * XML getter for the status.
     *
     * @return the status
     */
    @XmlElement
    public int getStatus() {
        return status;
    }

    /**
     * XML getter for the message.
     *
     * @return the message
     */
    @XmlElement
    public String getMessage() {
        return msg;
    }

    /**
     * XML getter for the description.
     *
     * @return the description
     */
    @XmlElement
    public String getDescription() {
        return desc;
    }
}
