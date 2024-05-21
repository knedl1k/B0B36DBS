package entities;

import jakarta.persistence.*;

@Entity
@Table(name = "krestni_jmeno")
public class KrestniJmeno {
    @EmbeddedId
    private KrestniJmenoId id;

    @ManyToOne
    @MapsId("cisloPasu")
    @JoinColumn(name = "cislo_pasu")
    private Pasazer pasazer;

    // Constructors, getters, and setters
    public KrestniJmeno() {}

    public KrestniJmeno(KrestniJmenoId id, Pasazer pasazer) {
        this.id = id;
        this.pasazer = pasazer;
    }

    public KrestniJmenoId getId() {
        return id;
    }

    public void setId(KrestniJmenoId id) {
        this.id = id;
    }

    public Pasazer getPasazer() {
        return pasazer;
    }

    public void setPasazer(Pasazer pasazer) {
        this.pasazer = pasazer;
    }

    public void setCisloPasu(String cisloPasu) {
        if (this.id == null) {
            this.id = new KrestniJmenoId();
        }
        this.id.setCisloPasu(cisloPasu);
    }

    public void setKrestniJmeno(String krestniJmeno) {
        if (this.id == null) {
            this.id = new KrestniJmenoId();
        }
        this.id.setKrestniJmeno(krestniJmeno);
    }

    @Override
    public String toString() {
        return "KrestniJmeno{" +
               "id=" + id +
               ", pasazer=" + pasazer +
               '}';
    }
}
