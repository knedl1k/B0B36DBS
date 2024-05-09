package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "leti")
public class Leti {
    @EmbeddedId
    private LetiId id;

    @MapsId("registracniZnacka")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "registracni_znacka", nullable = false)
    private Letadlo registracniZnacka;

    @MapsId("id")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "cislo_letu", referencedColumnName = "cislo_letu", nullable = false),
            @JoinColumn(name = "cas_odletu", referencedColumnName = "cas_odletu", nullable = false)
    })
    private Let let;

    public LetiId getId() {
        return id;
    }

    public void setId(LetiId id) {
        this.id = id;
    }

    public Letadlo getRegistracniZnacka() {
        return registracniZnacka;
    }

    public void setRegistracniZnacka(Letadlo registracniZnacka) {
        this.registracniZnacka = registracniZnacka;
    }

    public Let getLet() {
        return let;
    }

    public void setLet(Let let) {
        this.let = let;
    }

}