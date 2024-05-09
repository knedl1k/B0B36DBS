package tables;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "letadlo")
public class Letadlo {
    @Id
    @Column(name = "registracni_znacka", nullable = false, length = 9)
    private String registracniZnacka;

    @Column(name = "vlastnik", nullable = false, length = 50)
    private String vlastnik;

    @OneToOne(mappedBy = "registracniZnacka")
    private Civilni civilni;

    @ManyToMany(mappedBy = "letadlo")
    private Set<Let> lets = new LinkedHashSet<>();

    @OneToOne(mappedBy = "registracniZnacka")
    private Nakladni nakladni;

    @OneToMany(mappedBy = "registracniZnacka")
    private Set<Pasazer> pasazers = new LinkedHashSet<>();

    public String getRegistracniZnacka() {
        return registracniZnacka;
    }

    public void setRegistracniZnacka(String registracniZnacka) {
        this.registracniZnacka = registracniZnacka;
    }

    public String getVlastnik() {
        return vlastnik;
    }

    public void setVlastnik(String vlastnik) {
        this.vlastnik = vlastnik;
    }

    public Civilni getCivilni() {
        return civilni;
    }

    public void setCivilni(Civilni civilni) {
        this.civilni = civilni;
    }

    public Set<Let> getLets() {
        return lets;
    }

    public void setLets(Set<Let> lets) {
        this.lets = lets;
    }

    public Nakladni getNakladni() {
        return nakladni;
    }

    public void setNakladni(Nakladni nakladni) {
        this.nakladni = nakladni;
    }

    public Set<Pasazer> getPasazers() {
        return pasazers;
    }

    public void setPasazers(Set<Pasazer> pasazers) {
        this.pasazers = pasazers;
    }

}