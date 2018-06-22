package nl.utwente.di14.Cofano_C.model;

/**
 * This is the model for a port object.
 */
public class Port {

    private int id;
    private String name;
    private String unlo;

    public Port() {
    }

    public Port(int id, String name, String unlo) {
        this.id = id;
        this.name = name;
        this.unlo = unlo;
    }

    @Override
    public String toString() {
        return "Port:  Name: " + name + "; Unlo: " + unlo;
    }

    public int getId() {
        return id;
    }

    public void setId(int iD) {
        id = iD;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUnlo() {
        return unlo;
    }

    public void setUnlo(String unlo) {
        this.unlo = unlo;
    }


}
