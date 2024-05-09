package tables;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "nakladni")
public class Nakladni {
    @Id
    @Column(name = "registracni_znacka", nullable = false, length = 9)
    private String registracniZnacka;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "registracni_znacka", nullable = false)
    private Letadlo letadlo;

    @Column(name = "nosnost", nullable = false)
    private BigDecimal nosnost;

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

    public BigDecimal getNosnost() {
        return nosnost;
    }

    public void setNosnost(BigDecimal nosnost) {
        this.nosnost = nosnost;
    }

}