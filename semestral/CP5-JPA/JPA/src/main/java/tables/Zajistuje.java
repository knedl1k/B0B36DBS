package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "zajistuje")
public class Zajistuje {
    @EmbeddedId
    private ZajistujeId id;

    @MapsId("kodSpolecnosti")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "kod_spolecnosti", nullable = false)
    private Aerolinka kodSpolecnosti;

    @MapsId("id")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "cislo_letu", referencedColumnName = "cislo_letu", nullable = false),
            @JoinColumn(name = "cas_odletu", referencedColumnName = "cas_odletu", nullable = false)
    })
    private Let let;

    public ZajistujeId getId() {
        return id;
    }

    public void setId(ZajistujeId id) {
        this.id = id;
    }

    public Aerolinka getKodSpolecnosti() {
        return kodSpolecnosti;
    }

    public void setKodSpolecnosti(Aerolinka kodSpolecnosti) {
        this.kodSpolecnosti = kodSpolecnosti;
    }

    public Let getLet() {
        return let;
    }

    public void setLet(Let let) {
        this.let = let;
    }

}