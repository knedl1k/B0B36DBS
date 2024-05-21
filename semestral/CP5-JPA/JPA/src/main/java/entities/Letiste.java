package entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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

    @Override
    public String toString() {
        return "Letiste{" +
                "icaoKod='" + icaoKod + '\'' +
                ", nazev='" + nazev + '\'' +
                ", mesto='" + mesto + '\'' +
                ", stat='" + stat + '\'' +
                '}';
    }
}