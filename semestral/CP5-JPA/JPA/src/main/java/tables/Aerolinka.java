package tables;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

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

    @ManyToMany
    @JoinTable(name = "zajistuje",
            joinColumns = @JoinColumn(name = "kod_spolecnosti"),
            inverseJoinColumns = @JoinColumn(name = "cislo_letu"))
    private Set<Let> lets = new LinkedHashSet<>();

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

    public Set<Let> getLets() {
        return lets;
    }

    public void setLets(Set<Let> lets) {
        this.lets = lets;
    }

}