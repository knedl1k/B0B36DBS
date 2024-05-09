package tables;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

@Embeddable
public class LetiId implements Serializable {
    private static final long serialVersionUID = 7157431494434004690L;
    @Column(name = "registracni_znacka", nullable = false, length = 9)
    private String registracniZnacka;

    @Column(name = "cislo_letu", nullable = false, length = 6)
    private String cisloLetu;

    @Column(name = "cas_odletu", nullable = false)
    private Instant casOdletu;

    public String getRegistracniZnacka() {
        return registracniZnacka;
    }

    public void setRegistracniZnacka(String registracniZnacka) {
        this.registracniZnacka = registracniZnacka;
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
        LetiId entity = (LetiId) o;
        return Objects.equals(this.cisloLetu, entity.cisloLetu) &&
                Objects.equals(this.registracniZnacka, entity.registracniZnacka) &&
                Objects.equals(this.casOdletu, entity.casOdletu);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cisloLetu, registracniZnacka, casOdletu);
    }

}