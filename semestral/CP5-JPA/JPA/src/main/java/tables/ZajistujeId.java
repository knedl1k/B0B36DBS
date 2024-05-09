package tables;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

@Embeddable
public class ZajistujeId implements Serializable {
    private static final long serialVersionUID = -1788407984833792263L;
    @Column(name = "kod_spolecnosti", nullable = false, length = 3)
    private String kodSpolecnosti;

    @Column(name = "cislo_letu", nullable = false, length = 6)
    private String cisloLetu;

    @Column(name = "cas_odletu", nullable = false)
    private Instant casOdletu;

    public String getKodSpolecnosti() {
        return kodSpolecnosti;
    }

    public void setKodSpolecnosti(String kodSpolecnosti) {
        this.kodSpolecnosti = kodSpolecnosti;
    }

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
        ZajistujeId entity = (ZajistujeId) o;
        return Objects.equals(this.cisloLetu, entity.cisloLetu) &&
                Objects.equals(this.casOdletu, entity.casOdletu) &&
                Objects.equals(this.kodSpolecnosti, entity.kodSpolecnosti);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cisloLetu, casOdletu, kodSpolecnosti);
    }

}