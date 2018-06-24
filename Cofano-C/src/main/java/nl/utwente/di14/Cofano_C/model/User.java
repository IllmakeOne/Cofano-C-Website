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

    @Override
    public String toString() {
        return "User:  Name: " + name + "; email: " + email + "; emailNotification: " + emailNotification +
                "; darkMode: " + darkMode + "; lastLoggedIn: " + lastLoggedIn;
    }

    public User() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getLastLoggedIn() {
        return lastLoggedIn;
    }

    public void setLastLoggedIn(Timestamp lastLoggedIn) {
        this.lastLoggedIn = lastLoggedIn;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isEmailNotification() {
        return emailNotification;
    }

    public void setEmailNotification(boolean emailNotification) {
        this.emailNotification = emailNotification;
    }

    public boolean isDarkMode() {
        return darkMode;
    }

    public void setDarkMode(boolean darkMode) {
        this.darkMode = darkMode;
    }

    public int getId() {
        return id;
    }

    public void setId(int iD) {
        id = iD;
    }


}
