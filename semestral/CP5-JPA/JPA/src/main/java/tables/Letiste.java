package tables;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "letiste")
public class Letiste {
    @Id
    @Column(name = "icao_kod", nullable = false, length = 4)
    private String icaoKod;

    @Column(name = "nazev", nullable = false, length = 50)
    private String nazev;

    @Column(name = "mesto", nullable = false, length = 50)
    private String mesto;

    @Column(name = "stat", nullable = false, length = 50)
    private String stat;

    @OneToMany(mappedBy = "icaoKodPrilet")
    private Set<Let> let_prilet = new LinkedHashSet<>();

    @OneToMany(mappedBy = "icaoKodOdlet")
    private Set<Let> lets_odlet = new LinkedHashSet<>();

    public String getIcaoKod() {
        return icaoKod;
    }

    public void setIcaoKod(String icaoKod) {
        this.icaoKod = icaoKod;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    public String getMesto() {
        return mesto;
    }

    public void setMesto(String mesto) {
        this.mesto = mesto;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public Set<Let> getLet_prilet() {
        return let_prilet;
    }

    public void setLet_prilet(Set<Let> let_prilet) {
        this.let_prilet = let_prilet;
    }

    public Set<Let> getLets_odlet() {
        return lets_odlet;
    }

    public void setLets_odlet(Set<Let> lets_odlet) {
        this.lets_odlet = lets_odlet;
    }

}