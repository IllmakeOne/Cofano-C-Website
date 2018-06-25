package nl.utwente.di14.Cofano_C.exceptions;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ExceptionInfo {
	private int status;
	private String msg, desc;
	public ExceptionInfo(int status, String msg, String desc) {
		this.status = status;
		this.msg = msg;
		this.desc = desc;
	}

	@XmlElement public int getStatus() { return status; }
	@XmlElement public String getMessage() { return msg; }
	@XmlElement public String getDescription() { return desc; }
}
