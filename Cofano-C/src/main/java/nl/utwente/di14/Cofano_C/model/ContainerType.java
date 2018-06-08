package nl.utwente.di14.Cofano_C.model;

public class ContainerType {
	

	private int ID;
	
	private String displayName;
	private String isoCode;
	private String description;
	private int length;
	private int height;
	private boolean reefer;


	@Override 
	public String toString() {
		return "ContainerType:  displayName: "+displayName+"; isoCode: "+isoCode+"; Description: "+description+
				"; Lenght: "+length+"; Height: "+ height+"; Refeer: " +reefer;
	}


    public ContainerType(String name, String isocode, String decription, int length, int height, boolean reefer, int ID) {
        this.displayName = name;
        this.isoCode = isocode;
        this.description = decription;
        this.length = length;
        this.height = height;
        this.reefer = reefer;
        this.ID = ID;
    }

    public ContainerType() {

	}

	public void setReefer (boolean reefer) { this.reefer = reefer; }

	public boolean getReefer() { return this.reefer; }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getID() {
        return this.ID;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getLength() {
        return this.length;
    }


    public void setHeight(int height) {
        this.height = height;
    }

    public int getHeight() {
        return this.height;
    }

    public void setDisplayName(String name) {
        this.displayName = name;
    }

    public String getDisplayName() {
        return this.displayName;
    }

    public void setIsoCode(String iso) {
        this.isoCode = iso;
    }

    public String getIsoCode() {
        return this.isoCode;
    }

    public void setDescription(String desc) {
        this.description = desc;
    }

    public String getDescription() {
        return this.description;
    }


}
