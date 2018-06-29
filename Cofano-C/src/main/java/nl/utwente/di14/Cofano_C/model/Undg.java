package nl.utwente.di14.Cofano_C.model;

import java.util.List;

/**
 * Model for UNDG objects.
 */
public class Undg {

    private int id;

    private List<UndgDescription> descriptions;
    private List<String> labels;
    private List<String> tankSpecialProvisions;
    private List<String> tankCode;
    private boolean transportForbidden;
    private boolean collective;
    private boolean notApplicable;
    private String classificationCode;
    private int unNo;
    private String classification;
    private int packingGroup;
    private String hazardNo;
    private String station;
    private String transportCategory;
    private String tunnelCode;
    private String vehicleTankCarriage;

    /**
     * Constructs a UNDG without data.
     */
    public Undg() {
    }

    /**
     * Constructs a UNDG with data.
     *
     * @param iD                 of the UNDG
     * @param descriptions       of the UNDG
     * @param classificationCode of the UNDG
     * @param unNo               of the UNDG
     * @param classification     of the UNDG
     * @param packingGroup       of the UNDG
     */
    public Undg(int iD, List<UndgDescription> descriptions, String classificationCode, int unNo,
                String classification, int packingGroup) {
        super();
        id = iD;
        this.descriptions = descriptions;
        this.classificationCode = classificationCode;
        this.unNo = unNo;
        this.classification = classification;
        this.packingGroup = packingGroup;


        transportForbidden = false;
        collective = false;
        notApplicable = false;
    }

    @Override
    public String toString() {
        String descr = "";
        for (int i = 0; i < descriptions.size(); i++) {
            if (descriptions.get(i).getLanguage().equals("en")) {
                descr = descriptions.get(i).getDescription().substring(0, 15);
            }
        }
        return "UNDG: ID: " + id + " Classification code: " + classificationCode + "English descr: " + descr;
    }

    public List<UndgDescription> getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(List<UndgDescription> descriptions) {
        this.descriptions = descriptions;
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
    public int getUnNo() {
        return unNo;
    }

    /**
     * Sets the UnNo of the UNDG.
     *
     * @param unNo of the UNDG
     */
    public void setUnNo(int unNo) {
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
    public int getPackingGroup() {
        return packingGroup;
    }

    /**
     * Sets the packing group of the UNDG.
     *
     * @param packingGroup of the UNDG
     */
    public void setPackingGroup(int packingGroup) {
        this.packingGroup = packingGroup;
    }

    public String getHazardNo() {
        return hazardNo;
    }

    public void setHazardNo(String hazardNo) {
        this.hazardNo = hazardNo;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getTransportCategory() {
        return transportCategory;
    }

    public void setTransportCategory(String transportCategory) {
        this.transportCategory = transportCategory;
    }

    public String getTunnelCode() {
        return tunnelCode;
    }

    public void setTunnelCode(String tunnelCode) {
        this.tunnelCode = tunnelCode;
    }

    public String getVehicleTankCarriage() {
        return vehicleTankCarriage;
    }

    public void setVehicleTankCarriage(String vehicleTankCarriage) {
        this.vehicleTankCarriage = vehicleTankCarriage;
    }

    public List<String> getLabels() {
        return labels;
    }

    public void setLabels(List<String> labels) {
        this.labels = labels;
    }

    public List<String> getTankSpecialProvisions() {
        return tankSpecialProvisions;
    }

    public void setTankSpecialProvisions(List<String> tankSpecialProvisions) {
        this.tankSpecialProvisions = tankSpecialProvisions;
    }

    public List<String> getTankCode() {
        return tankCode;
    }

    public void setTankCode(List<String> tankCode) {
        this.tankCode = tankCode;
    }
}
