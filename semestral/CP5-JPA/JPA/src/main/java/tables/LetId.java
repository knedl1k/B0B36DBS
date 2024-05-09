package tables;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

@Embeddable
public class LetId implements Serializable {
    private static final long serialVersionUID = -4998215942018454137L;
    @Column(name = "cislo_letu", nullable = false, length = 6)
    private String cisloLetu;

    @Column(name = "cas_odletu", nullable = false)
    private Instant casOdletu;

    public String getCisloLetu() {
        return cisloLetu;
    }

    public void setCisloLetu(String cisloLetu) {
        this.cisloLetu = cisloLetu;
    }

    public Instant getCasOdletu() {
        return casOdletu;
    }

    public void setCasOdletu(Instant casOdletu) {
        this.casOdletu = casOdletu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LetId entity = (LetId) o;
        return Objects.equals(this.cisloLetu, entity.cisloLetu) &&
                Objects.equals(this.casOdletu, entity.casOdletu);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cisloLetu, casOdletu);
    }

}