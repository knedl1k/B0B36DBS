package tables;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "zavazadlo")
public class Zavazadlo {
    @EmbeddedId
    private ZavazadloId id;

    @MapsId("cisloPasu")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cislo_pasu", nullable = false)
    private Pasazer cisloPasu;

    @Column(name = "hmotnost", nullable = false)
    private BigDecimal hmotnost;

    public ZavazadloId getId() {
        return id;
    }

    public void setId(ZavazadloId id) {
        this.id = id;
    }

    public Pasazer getCisloPasu() {
        return cisloPasu;
    }

    public void setCisloPasu(Pasazer cisloPasu) {
        this.cisloPasu = cisloPasu;
    }

    public BigDecimal getHmotnost() {
        return hmotnost;
    }

    public void setHmotnost(BigDecimal hmotnost) {
        this.hmotnost = hmotnost;
    }

}