package tables;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "zanr")
public class Zanr {
    @Id
    @Column(name = "nazev", nullable = false, length = 50)
    private String nazev;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nadzanr")
    private Zanr nadzanr;

    @ManyToMany
    @JoinTable(name = "nalezi_zanru",
            joinColumns = @JoinColumn(name = "nazev"),
            inverseJoinColumns = @JoinColumn(name = "isbn"))
    private Set<Kniha> knihas = new LinkedHashSet<>();

    @OneToMany(mappedBy = "nadzanr")
    private Set<Zanr> zanrs = new LinkedHashSet<>();

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    public Zanr getNadzanr() {
        return nadzanr;
    }

    public void setNadzanr(Zanr nadzanr) {
        this.nadzanr = nadzanr;
    }

    public Set<Kniha> getKnihas() {
        return knihas;
    }

    public void setKnihas(Set<Kniha> knihas) {
        this.knihas = knihas;
    }

    public Set<Zanr> getZanrs() {
        return zanrs;
    }

    public void setZanrs(Set<Zanr> zanrs) {
        this.zanrs = zanrs;
    }

    @Override
    public String toString() {
        return "Zanr{" +
                "nazev='" + nazev + '\'' +
                ", zanrs=" + zanrs +
                '}';
    }
}