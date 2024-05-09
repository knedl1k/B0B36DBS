package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "nalezi_zanru")
public class NaleziZanru {
    @EmbeddedId
    private NaleziZanruId id;

    @MapsId("isbn")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "isbn", nullable = false)
    private Kniha isbn;

    @MapsId("nazev")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "nazev", nullable = false)
    private Zanr nazev;

    public NaleziZanruId getId() {
        return id;
    }

    public void setId(NaleziZanruId id) {
        this.id = id;
    }

    public Kniha getIsbn() {
        return isbn;
    }

    public void setIsbn(Kniha isbn) {
        this.isbn = isbn;
    }

    public Zanr getNazev() {
        return nazev;
    }

    public void setNazev(Zanr nazev) {
        this.nazev = nazev;
    }

}