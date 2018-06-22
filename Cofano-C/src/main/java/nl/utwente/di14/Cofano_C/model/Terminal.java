package nl.utwente.di14.Cofano_C.model;

/**
 * Model for terminal objects.
 */
public class Terminal {

    private int id;
    private String name;
    private String terminalCode;
    private String type;
    private String unlo;
    private int portId;


    /**
     * Constructs a terminal without data.
     */
    public Terminal() {
    }


    /**
     * Constructs a terminal with data.
     *
     * @param id           of the terminal
     * @param name         of the terminal
     * @param terminalCode of the terminal
     * @param type         of the terminal
     * @param unlo         of the terminal
     * @param portId       of the terminal
     */
    public Terminal(int id, String name, String terminalCode, String type,
                    String unlo, int portId) {
        super();
        this.id = id;
        this.name = name;
        this.terminalCode = terminalCode;
        this.type = type;
        this.unlo = unlo;
        this.portId = portId;
    }

    /**
     * Constructs a string with all the data of this object.
     *
     * @return a string with all data
     */
    @Override
    public String toString() {
        return "Terminal:  Name: " + name + "; TerminalCode: " + terminalCode + "; Type: " + type +
                "; Unlo: " + unlo + "; port id: " + portId;
    }

    /**
     * Gets the name of the terminal.
     *
     * @return name of the terminal
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of the terminal.
     *
     * @param name of the terminal
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the terminal code of the terminal.
     *
     * @return the terminal code of the terminal
     */
    public String getTerminalCode() {
        return terminalCode;
    }

    /**
     * Sets the terminal code of the terminal.
     *
     * @param terminalCode of the terminal
     */
    public void setTerminalCode(String terminalCode) {
        this.terminalCode = terminalCode;
    }

    /**
     * Gets the type of the terminal.
     *
     * @return the type of the terminal
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the type of the terminal.
     *
     * @param type of the terminal
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the UNLO of the terminal.
     *
     * @return the UNLO of the terminal
     */
    public String getUnlo() {
        return unlo;
    }

    /**
     * Sets the UNLO of the terminal.
     *
     * @param unlo of the terminal
     */
    public void setUnlo(String unlo) {
        this.unlo = unlo;
    }

    /**
     * Gets the ID  of the terminal.
     *
     * @return the ID  of the terminal
     */
    public int getID() {
        return id;
    }

    /**
     * Sets the ID of the terminal.
     *
     * @param terminalID of the terminal
     */
    public void setID(int terminalID) {
        this.id = terminalID;
    }

    /**
     * Gets the port ID of the terminal.
     *
     * @return the port ID of the terminal
     */
    public int getPortId() {
        return portId;
    }

    /**
     * The port ID of the terminal.
     *
     * @param portID of the terminal
     */
    public void setPortId(int portID) {
        this.portId = portID;
    }
}
