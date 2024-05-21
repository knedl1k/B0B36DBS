package entities;

import jakarta.persistence.*;

@Entity
@Table(name = "letadlo")
@Inheritance(strategy = InheritanceType.JOINED)
public class Letadlo {
    @Id
    @Column(name = "registracni_znacka", nullable = false, length = 9)
    protected String registracniZnacka;

    @Column(name = "vlastnik", nullable = false, length = 50)
    protected String vlastnik;

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

    @Override
    public String toString() {
        return "Letadlo{" +
                "registracniZnacka='" + registracniZnacka + '\'' +
                ", vlastnik='" + vlastnik + '\'' +
                '}';
    }
}