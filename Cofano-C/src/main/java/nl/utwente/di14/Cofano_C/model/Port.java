package nl.utwente.di14.Cofano_C.model;

/**
 * This is the model for a port object.
 */
public class Port {

    private int id;
    private String name;
    private String unlo;

    /**
     * Constructs a port without data.
     */
    public Port() {
    }

    /**
     * Constructs a port with data.
     *
     * @param id   of the port
     * @param name of the port
     * @param unlo of the port
     */
    public Port(int id, String name, String unlo) {
        this.id = id;
        this.name = name;
        this.unlo = unlo;
    }

    /**
     * Converts the information of the port to a string.
     *
     * @return the string with info about this port object
     */
    @Override
    public String toString() {
        return "Port:  Name: " + name + "; Unlo: " + unlo;
    }

    /**
     * Gets the ID of the port.
     *
     * @return ID of the port
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the ID of the port.
     *
     * @param id of the port
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Gets the name of the port.
     *
     * @return the name of the port
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of the port.
     *
     * @param name of the port
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the UNLO of the port.
     *
     * @return the UNLO of the port
     */
    public String getUnlo() {
        return unlo;
    }

    /**
     * Sets the UNLO of the port.
     *
     * @param unlo of the port
     */
    public void setUnlo(String unlo) {
        this.unlo = unlo;
    }
}
