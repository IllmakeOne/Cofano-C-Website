package nl.utwente.di14.Cofano_C.model;

/**
 * Model for UNDG objects.
 */
class Undg {

    private int id;
    private int descriptionId;
    private boolean transportForbidden;
    private boolean collective;
    private boolean notApplicable;
    private String classificationCode;
    private String unNo;
    private String classification;
    private String packingGroup;

    /**
     * Constructs a UNDG without data.
     */
    public Undg() {
    }

    /**
     * Constructs a UNDG with data.
     *
     * @param iD                 of the UNDG
     * @param descriptionID      of the UNDG
     * @param classificationCode of the UNDG
     * @param unNo               of the UNDG
     * @param classification     of the UNDG
     * @param packingGroup       of the UNDG
     */
    public Undg(int iD, int descriptionID, String classificationCode, String unNo,
                String classification, String packingGroup) {
        super();
        id = iD;
        this.descriptionId = descriptionID;
        this.classificationCode = classificationCode;
        this.unNo = unNo;
        this.classification = classification;
        this.packingGroup = packingGroup;

        transportForbidden = false;
        collective = false;
        notApplicable = false;
    }

    /**
     * Gets the description ID of the UNDG.
     *
     * @return the description ID of the UNDG
     */
    public int getDescriptionID() {
        return descriptionId;
    }

    /**
     * Sets the description ID of the UNDG.
     *
     * @param iD of the description of the UNDG
     */
    public void setDescriptionID(int iD) {
        descriptionId = iD;
    }

    /**
     * Gets the ID of the UNDG.
     *
     * @return ID of the UNDG
     */
    public int getId() {
        return id;
    }

    /**
     * Gets the ID of the UNDG.
     *
     * @param iD of the UNDG
     */
    public void setId(int iD) {
        id = iD;
    }

    /**
     * Gets whether or not transport is forbidden.
     *
     * @return true of false
     */
    public boolean isTransportForbidden() {
        return transportForbidden;
    }

    /**
     * Sets transport status.
     *
     * @param transportForbidden true if forbidden
     */
    public void setTransportForbidden(boolean transportForbidden) {
        this.transportForbidden = transportForbidden;
    }

    /**
     * Gets whether or not the UNDG is collective.
     *
     * @return true if collective
     */
    public boolean isCollective() {
        return collective;
    }

    /**
     * Sets the collective status.
     *
     * @param collective true if collective
     */
    public void setCollective(boolean collective) {
        this.collective = collective;
    }

    /**
     * Gets the NA status.
     *
     * @return true if NA
     */
    public boolean isNotApplicable() {
        return notApplicable;
    }

    /**
     * Sets the NA status.
     *
     * @param notApplicable true is NA
     */
    public void setNotApplicable(boolean notApplicable) {
        this.notApplicable = notApplicable;
    }

    /**
     * Gets the classification code of the UNDG.
     *
     * @return the classification code of the UNDG
     */
    public String getClassificationCode() {
        return classificationCode;
    }

    /**
     * Sets the classification code  of the UNDG.
     *
     * @param classificationCode of the UNDG
     */
    public void setClassificationCode(String classificationCode) {
        this.classificationCode = classificationCode;
    }

    /**
     * Gets the UnNo of the UNDG.
     *
     * @return UnNo of the UNDG
     */
    public String getUnNo() {
        return unNo;
    }

    /**
     * Sets the UnNo of the UNDG.
     *
     * @param unNo of the UNDG
     */
    public void setUnNo(String unNo) {
        this.unNo = unNo;
    }

    /**
     * Gets the classification of the UNDG.
     *
     * @return classification of the UNDG
     */
    public String getClassification() {
        return classification;
    }

    /**
     * Sets the classification of the UNDG.
     *
     * @param classification of the UNDG
     */
    public void setClassification(String classification) {
        this.classification = classification;
    }

    /**
     * Gets the packing group of the UNDG.
     *
     * @return the packing group of the UNDG
     */
    public String getPackingGroup() {
        return packingGroup;
    }

    /**
     * Sets the packing group of the UNDG.
     *
     * @param packingGroup of the UNDG
     */
    public void setPackingGroup(String packingGroup) {
        this.packingGroup = packingGroup;
    }
}
