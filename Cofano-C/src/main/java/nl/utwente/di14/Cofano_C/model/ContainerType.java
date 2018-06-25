package nl.utwente.di14.Cofano_C.model;

/**
 * This is the model for the container types.
 */
public class ContainerType {


    private int id;
    private String displayName;
    private String isoCode;
    private String description;
    private int length;
    private int height;
    private boolean reefer;


    /**
     * Constructs a new container type with data.
     *
     * @param name        of the container type
     * @param isoCode     of the container type
     * @param description of the container type
     * @param length      of the container type
     * @param height      of the container type
     * @param reefer      of the container type
     * @param id          of the container type
     */
    public ContainerType(String name, String isoCode, String description, int length,
                         int height, boolean reefer, int id) {
        this.displayName = name;
        this.isoCode = isoCode;
        this.description = description;
        this.length = length;
        this.height = height;
        this.reefer = reefer;
        this.id = id;
    }


    /**
     * Constructs a new container type without data.
     */
    public ContainerType() {

    }

    /**
     * Converts the container type information to a string.
     *
     * @return the container type info as a string
     */
    @Override
    public String toString() {
        return "  ContainerType:  displayName: " + displayName + "; isoCode: " + isoCode +
                "; Description: " + description +
                "; Length: " + length + "; Height: " + height + "; Reefer: " + reefer;
    }

    /**
     * Gets the reefer value.
     *
     * @return the reefer value
     */
    public boolean getReefer() {
        return this.reefer;
    }

    /**
     * Sets if the container type has a reefer.
     *
     * @param reefer true if the container has a reefer, false otherwise
     */
    public void setReefer(boolean reefer) {
        this.reefer = reefer;
    }

    /**
     * Gets the id of the container type.
     *
     * @return the id of the container type
     */
    public int getId() {
        return this.id;
    }

    /**
     * Sets the id of the container type.
     *
     * @param id of the container type
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Gets the length of the container type.
     *
     * @return the length of the container type
     */
    public int getLength() {
        return this.length;
    }

    /**
     * Sets the length of the container type.
     *
     * @param length of the container type.
     */
    public void setLength(int length) {
        this.length = length;
    }

    /**
     * Gets the height of the container type.
     *
     * @return the height of the container type
     */
    public int getHeight() {
        return this.height;
    }

    /**
     * Sets the height of the container type.
     *
     * @param height of the container type
     */
    public void setHeight(int height) {
        this.height = height;
    }

    /**
     * Gets the display name of the container type.
     *
     * @return the display name of the container type
     */
    public String getDisplayName() {
        return this.displayName;
    }

    /**
     * Sets the display name of the container type.
     *
     * @param name display name of the container type
     */
    public void setDisplayName(String name) {
        this.displayName = name;
    }

    /**
     * Gets the ISO Code of the container type.
     *
     * @return the ISO code of the container type
     */
    public String getIsoCode() {
        return this.isoCode;
    }

    /**
     * Sets the ISO Code of the container type.
     *
     * @param iso ISO Code of the container type
     */
    public void setIsoCode(String iso) {
        this.isoCode = iso;
    }

    /**
     * Gets the description of the container type.
     *
     * @return the description of the container type
     */
    public String getDescription() {
        return this.description;
    }

    /**
     * Sets the description of the container type.
     *
     * @param desc description of the container type
     */
    public void setDescription(String desc) {
        this.description = desc;
    }


}
