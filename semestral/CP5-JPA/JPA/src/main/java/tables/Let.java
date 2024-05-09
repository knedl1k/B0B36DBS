package tables;

import jakarta.persistence.*;

import java.time.Instant;

@Entity
@Table(name = "let")
public class Let {
    @EmbeddedId
    private LetId id;

    @Column(name = "cas_priletu", nullable = false)
    private Instant casPriletu;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "icao_kod_odlet")
    private Letiste icaoKodOdlet;

    public LetId getId() {
        return id;
    }

    public void setId(LetId id) {
        this.id = id;
    }

    public Instant getCasPriletu() {
        return casPriletu;
    }

    public void setCasPriletu(Instant casPriletu) {
        this.casPriletu = casPriletu;
    }

    public Letiste getIcaoKodOdlet() {
        return icaoKodOdlet;
    }

    public void setIcaoKodOdlet(Letiste icaoKodOdlet) {
        this.icaoKodOdlet = icaoKodOdlet;
    }

}