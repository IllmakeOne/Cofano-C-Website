package nl.utwente.di14.Cofano_C.model;

import java.sql.Timestamp;

/**
 * Model for the user objects.
 */
public class User {

    private int id;
    private String name;
    private String email;
    private boolean emailNotification;
    private boolean darkMode;
    private Timestamp lastLoggedIn;

    /**
     * Constructs a user without data.
     */
    public User() {
    }

    /**
     * Returns all the info of the object as a string.
     *
     * @return the string with info.
     */
    @Override
    public String toString() {
        return "User:  Name: " + name + "; email: " + email + "; emailNotification: "
                + emailNotification +
                "; darkMode: " + darkMode + "; lastLoggedIn: " + lastLoggedIn;
    }

    /**
     * Gets the name of a user.
     *
     * @return the name of a user
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of a user.
     *
     * @param name of a user
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the last time the user logged in.
     *
     * @return the last log in time
     */
    public Timestamp getLastLoggedIn() {
        return lastLoggedIn;
    }

    /**
     * Sets the last time the user logged in.
     *
     * @param lastLoggedIn the timestamp to be stored as lost login
     */
    public void setLastLoggedIn(Timestamp lastLoggedIn) {
        this.lastLoggedIn = lastLoggedIn;
    }

    /**
     * Gets the email of a user.
     *
     * @return email of a user
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the email of a user.
     *
     * @param email address of a user
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets whether the user wants email notifications.
     *
     * @return true if the user wants notifications
     */
    public boolean isEmailNotification() {
        return emailNotification;
    }

    /**
     * Sets the email notifications flag.
     *
     * @param emailNotification true if the user wants notifications.
     */
    public void setEmailNotification(boolean emailNotification) {
        this.emailNotification = emailNotification;
    }

    /**
     * Gets whether the user wants dark mode enabled.
     *
     * @return true if dark mode enabled.
     */
    public boolean isDarkMode() {
        return darkMode;
    }

    /**
     * Sets whether the user wants dark mode enabled.
     *
     * @param darkMode set true if the user wants dark mode enabled
     */
    public void setDarkMode(boolean darkMode) {
        this.darkMode = darkMode;
    }

    /**
     * Gets the ID of the user.
     *
     * @return the ID of the user
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the ID of the user.
     *
     * @param id of the user
     */
    public void setId(int id) {
        this.id = id;
    }


}
