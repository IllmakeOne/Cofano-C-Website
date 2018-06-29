package nl.utwente.di14.Cofano_C.model;

/**
 * This is the model for UNDG descriptions.
 */
public class UndgDescription {

    private int id;
    private int undgID;
    private String description;
    private String language;

    /**
     * Creates a new blank UNDG description.
     */
    public UndgDescription() {
    }

    /**
     * Creates an new UNDG description with data.
     *
     * @param id          of the UNDG description
     * @param undgID      of the UNDG the description is about
     * @param description the actual description
     * @param language    of the UNDG description
     */
    public UndgDescription(int id, int undgID, String description, String language) {
        super();
        this.id = id;
        this.undgID = undgID;
        this.description = description;
        this.language = language;
    }

    public UndgDescription(String language, String description) {
        this.language = language;
        this.description = description;
    }

    /**
     * Sets the ID of the UNDG description.
     *
     * @param id of the UNDG description
     */
    public void setId(int id) {
        this.id = id;
    }


    /**
     * Sets the UNDG ID the description references.
     *
     * @param undgID the description references
     */
    public void setUndgID(int undgID) {
        this.undgID = undgID;
    }

    /**
     * Gets the actual description of the UNDG.
     *
     * @return the description of the UNDG
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the description of the UNDG.
     *
     * @param description of the UNDG.
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the language of the UNDG description.
     *
     * @return the language of the UNDG description
     */
    public String getLanguage() {
        return language;
    }

    /**
     * Sets the language of the UNDG description.
     *
     * @param language of the UNDG description
     */
    public void setLanguage(String language) {
        this.language = language;
    }
}
