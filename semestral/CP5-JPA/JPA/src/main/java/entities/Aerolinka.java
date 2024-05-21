package entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "aerolinka")
public class Aerolinka {
    @Id
    @Column(name = "kod_spolecnosti", nullable = false, length = 3)
    private String kodSpolecnosti;

    @Column(name = "nazev", nullable = false, length = 50)
    private String nazev;

    @Column(name = "zeme_puvodu", nullable = false, length = 50)
    private String zemePuvodu;

    public String getKodSpolecnosti() {
        return kodSpolecnosti;
    }

    public void setKodSpolecnosti(String kodSpolecnosti) {
        this.kodSpolecnosti = kodSpolecnosti;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    public String getZemePuvodu() {
        return zemePuvodu;
    }

    public void setZemePuvodu(String zemePuvodu) {
        this.zemePuvodu = zemePuvodu;
    }

}