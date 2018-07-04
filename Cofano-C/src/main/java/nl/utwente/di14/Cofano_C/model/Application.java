package nl.utwente.di14.Cofano_C.model;

/**
 * This is the model for an <code>Application</code>.
 */
public class Application {


    /**
     * These are the data elements of an <code>Application</code>.
     */
    private int id;
    private String name;
    private String apiKey;

    /**
     * Constructs an <code>Application</code> without data.
     */
    public Application() {

    }

    /**
     * Constructs a new application.
     *
     * @param name of the application
     * @param key  of the application
     * @param id   of the application
     */
    public Application(String name, String key, int id) {
        this.name = name;
        this.apiKey = key;
        this.id = id;
    }

    public Application(String name, String key) {
        this.name = name;
        this.apiKey = key;
    }

    /**
     * Returns the applications data as a string.
     *
     * @return the applications as a string
     */
    @Override
    public String toString() {
        return "  Application:  Name: " + name + "; APIKey: " + apiKey;
    }

    /**
     * Gets the id of an application.
     *
     * @return the id of an application
     */
    public int getId() {
        return this.id;
    }

    /**
     * Sets the id of an application.
     *
     * @param id of the application
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Gets the name of an application.
     *
     * @return the name of an application
     */
    public String getName() {
        return this.name;
    }

    /**
     * Sets the name of an application.
     *
     * @param name of an application
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the API Key of an application.
     *
     * @return the API key of an application
     */
    public String getAPIKey() {
        return this.apiKey;
    }

    /**
     * Sets the API Key of an application.
     *
     * @param key the API Key of of an application
     */
    public void setAPIKey(String key) {
        this.apiKey = key;
    }
}
