package tables;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

@Embeddable
public class ZavazadloId implements Serializable {
    private static final long serialVersionUID = -1013826010730822994L;
    @Column(name = "datum", nullable = false)
    private Instant datum;

    @Column(name = "cislo_letu", nullable = false, length = 6)
    private String cisloLetu;

    @Column(name = "cislo_pasu", nullable = false, length = 9)
    private String cisloPasu;

    public Instant getDatum() {
        return datum;
    }

    public void setDatum(Instant datum) {
        this.datum = datum;
    }

    public String getCisloLetu() {
        return cisloLetu;
    }

    public void setCisloLetu(String cisloLetu) {
        this.cisloLetu = cisloLetu;
    }

    public String getCisloPasu() {
        return cisloPasu;
    }

    public void setCisloPasu(String cisloPasu) {
        this.cisloPasu = cisloPasu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ZavazadloId entity = (ZavazadloId) o;
        return Objects.equals(this.datum, entity.datum) &&
                Objects.equals(this.cisloLetu, entity.cisloLetu) &&
                Objects.equals(this.cisloPasu, entity.cisloPasu);
    }

    @Override
    public int hashCode() {
        return Objects.hash(datum, cisloLetu, cisloPasu);
    }

}