package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "navazuje_na")
public class NavazujeNa {
    @EmbeddedId
    private NavazujeNaId id;

    @MapsId("id")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "cislo_letu", referencedColumnName = "cislo_letu", nullable = false),
            @JoinColumn(name = "cas_odletu", referencedColumnName = "cas_odletu", nullable = false)
    })
    private Let let;

    @MapsId("id")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "navazujici_cislo_letu", referencedColumnName = "cislo_letu", nullable = false),
            @JoinColumn(name = "navazujici_cas_odletu", referencedColumnName = "cas_odletu", nullable = false)
    })
    private Let let1;

    public NavazujeNaId getId() {
        return id;
    }

    public void setId(NavazujeNaId id) {
        this.id = id;
    }

    public Let getLet() {
        return let;
    }

    public void setLet(Let let) {
        this.let = let;
    }

    public Let getLet1() {
        return let1;
    }

    public void setLet1(Let let1) {
        this.let1 = let1;
    }

}