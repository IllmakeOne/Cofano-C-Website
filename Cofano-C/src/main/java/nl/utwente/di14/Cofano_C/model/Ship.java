package nl.utwente.di14.Cofano_C.model;

import java.math.BigDecimal;

/**
 * Model for ship objects.
 */
public class Ship {

    private int id;
    private String imo;
    private String name;
    private String callSign;
    private String mmsi;
    private BigDecimal depth;

    /**
     * Constructs a ship without data.
     */
    public Ship() {
    }

    /**
     * Constructs a ship with data.
     *
     * @param imo      of the ship
     * @param name     of the ship
     * @param callSign of the ship
     * @param mmsi     of the ship
     * @param depth    of the ship
     * @param id       of the ship
     */
    public Ship(String imo, String name, String callSign, String mmsi, BigDecimal depth, int id) {
        super();
        this.imo = imo;
        this.name = name;
        this.callSign = callSign;
        this.mmsi = mmsi;
        this.depth = depth;
        this.id = id;
    }

    /**
     * Returns the ship object as a string.
     *
     * @return a string with all the data of this ship object
     */
    @Override
    public String toString() {
        return "Ship:  IMO: " + imo + "; Name: " + name + "; CallSign: "
                + callSign + "; MMSI: " + mmsi + "; Depth: " + depth;
    }

    /**
     * Gets the IMO of the ship.
     *
     * @return the IMO of the ship
     */
    public String getImo() {
        return imo;
    }

    /**
     * Sets the IMO of the ship.
     *
     * @param imo of the ship.
     */
    public void setImo(String imo) {
        this.imo = imo;
    }

    /**
     * Gets the name of the ship.
     *
     * @return name of the ship
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of the ship.
     *
     * @param name of the ship
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the callSign of the ship.
     *
     * @return the callSign of the ship
     */
    public String getCallSign() {
        return callSign;
    }

    /**
     * Sets the callSign of the ship.
     *
     * @param callSign of the ship
     */
    public void setCallSign(String callSign) {
        this.callSign = callSign;
    }

    /**
     * Gets the MMSI of the ship.
     *
     * @return the MMSI of the ship
     */
    public String getMMSI() {
        return mmsi;
    }

    /**
     * Sets the MMSI of the ship.
     *
     * @param shipMMSI of the ship
     */
    public void setMMSI(String shipMMSI) {
        this.mmsi = shipMMSI;
    }

    /**
     * Gets the depth of the ship.
     *
     * @return the depth of the ship
     */
    public BigDecimal getDepth() {
        return depth;
    }

    /**
     * Sets the depth of the ship.
     *
     * @param depth of the ship
     */
    public void setDepth(BigDecimal depth) {
        this.depth = depth;
    }

    /**
     * Gets the ID of the ship.
     *
     * @return the ID of the ship
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the ID of the ship.
     *
     * @param id of the ship
     */
    public void setId(int id) {
        this.id = id;
    }

}
