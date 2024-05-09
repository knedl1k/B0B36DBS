package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "krestni_jmeno")
public class KrestniJmeno {
    @EmbeddedId
    private KrestniJmenoId id;

    @MapsId("cisloPasu")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cislo_pasu", nullable = false)
    private Pasazer cisloPasu;

    public KrestniJmenoId getId() {
        return id;
    }

    public void setId(KrestniJmenoId id) {
        this.id = id;
    }

    public Pasazer getCisloPasu() {
        return cisloPasu;
    }

    public void setCisloPasu(Pasazer cisloPasu) {
        this.cisloPasu = cisloPasu;
    }

}