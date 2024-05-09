package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "civilni")
public class Civilni {
    @Id
    @Column(name = "registracni_znacka", nullable = false, length = 9)
    private String registracniZnacka;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "registracni_znacka", nullable = false)
    private Letadlo letadlo;

    @Column(name = "kapacita_pasazeru", nullable = false)
    private Integer kapacitaPasazeru;

    public String getRegistracniZnacka() {
        return registracniZnacka;
    }

    public void setRegistracniZnacka(String registracniZnacka) {
        this.registracniZnacka = registracniZnacka;
    }

    public Letadlo getLetadlo() {
        return letadlo;
    }

    public void setLetadlo(Letadlo letadlo) {
        this.letadlo = letadlo;
    }

    public Integer getKapacitaPasazeru() {
        return kapacitaPasazeru;
    }

    public void setKapacitaPasazeru(Integer kapacitaPasazeru) {
        this.kapacitaPasazeru = kapacitaPasazeru;
    }

}