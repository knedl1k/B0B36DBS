package entities;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class KrestniJmenoId implements Serializable {
    private String cisloPasu;
    private String krestniJmeno;

    public KrestniJmenoId() {}

    public KrestniJmenoId(String cisloPasu, String krestniJmeno) {
        this.cisloPasu = cisloPasu;
        this.krestniJmeno = krestniJmeno;
    }

    // Getters and setters
    public String getCisloPasu() {
        return cisloPasu;
    }

    public void setCisloPasu(String cisloPasu) {
        this.cisloPasu = cisloPasu;
    }

    public String getKrestniJmeno() {
        return krestniJmeno;
    }

    public void setKrestniJmeno(String krestniJmeno) {
        this.krestniJmeno = krestniJmeno;
    }

    // hashCode and equals
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        KrestniJmenoId that = (KrestniJmenoId) o;
        return Objects.equals(cisloPasu, that.cisloPasu) &&
               Objects.equals(krestniJmeno, that.krestniJmeno);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cisloPasu, krestniJmeno);
    }
}
