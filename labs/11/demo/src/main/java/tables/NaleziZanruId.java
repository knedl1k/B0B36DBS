package tables;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class NaleziZanruId implements Serializable {
    private static final long serialVersionUID = 5774712923259082159L;
    @Column(name = "isbn", nullable = false, length = 20)
    private String isbn;

    @Column(name = "nazev", nullable = false, length = 50)
    private String nazev;

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NaleziZanruId entity = (NaleziZanruId) o;
        return Objects.equals(this.nazev, entity.nazev) &&
                Objects.equals(this.isbn, entity.isbn);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nazev, isbn);
    }

}