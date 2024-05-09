package tables;

import jakarta.persistence.*;

@Entity
@Table(name = "kniha")
public class Kniha {
    @Id
    @Column(name = "isbn", nullable = false, length = 20)
    private String isbn;

    @Column(name = "nazev", nullable = false, length = 50)
    private String nazev;

    @Column(name = "vydavatel", nullable = false, length = 50)
    private String vydavatel;

    @Column(name = "rok", nullable = false, length = 4)
    private String rok;

    @Lob
    @Column(name = "anotace")
    private String anotace;

    @Column(name = "url", length = 100)
    private String url;

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

    public String getVydavatel() {
        return vydavatel;
    }

    public void setVydavatel(String vydavatel) {
        this.vydavatel = vydavatel;
    }

    public String getRok() {
        return rok;
    }

    public void setRok(String rok) {
        this.rok = rok;
    }

    public String getAnotace() {
        return anotace;
    }

    public void setAnotace(String anotace) {
        this.anotace = anotace;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Kniha{" +
                "isbn='" + isbn + '\'' +
                ", nazev='" + nazev + '\'' +
                ", vydavatel='" + vydavatel + '\'' +
                ", rok='" + rok + '\'' +
                ", anotace='" + anotace + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}