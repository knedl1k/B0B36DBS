package entities;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Entity
@Table(name = "zavazadlo")
public class Zavazadlo {
    @EmbeddedId
    private ZavazadloId id;

    @MapsId("cisloPasu")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
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

    @Override
    public String toString() {
        return "Zavazadlo{" +
                "id=" + id +
                ", cisloPasu=" + cisloPasu +
                ", hmotnost=" + hmotnost +
                '}';
    }
}