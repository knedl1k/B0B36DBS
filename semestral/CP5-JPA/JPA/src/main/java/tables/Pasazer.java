package tables;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "pasazer")
public class Pasazer {
    @Id
    @Column(name = "cislo_pasu", nullable = false, length = 9)
    private String cisloPasu;

    @Column(name = "datum_narozeni", nullable = false)
    private LocalDate datumNarozeni;

    @Column(name = "prijmeni", nullable = false, length = 20)
    private String prijmeni;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "registracni_znacka")
    private Letadlo registracniZnacka;

    @OneToMany(mappedBy = "cisloPasu")
    private Set<KrestniJmeno> krestniJmenos = new LinkedHashSet<>();

    @OneToMany(mappedBy = "cisloPasu")
    private Set<Zavazadlo> zavazadlos = new LinkedHashSet<>();

    public String getCisloPasu() {
        return cisloPasu;
    }

    public void setCisloPasu(String cisloPasu) {
        this.cisloPasu = cisloPasu;
    }

    public LocalDate getDatumNarozeni() {
        return datumNarozeni;
    }

    public void setDatumNarozeni(LocalDate datumNarozeni) {
        this.datumNarozeni = datumNarozeni;
    }

    public String getPrijmeni() {
        return prijmeni;
    }

    public void setPrijmeni(String prijmeni) {
        this.prijmeni = prijmeni;
    }

    public Letadlo getRegistracniZnacka() {
        return registracniZnacka;
    }

    public void setRegistracniZnacka(Letadlo registracniZnacka) {
        this.registracniZnacka = registracniZnacka;
    }

    public Set<KrestniJmeno> getKrestniJmenos() {
        return krestniJmenos;
    }

    public void setKrestniJmenos(Set<KrestniJmeno> krestniJmenos) {
        this.krestniJmenos = krestniJmenos;
    }

    public Set<Zavazadlo> getZavazadlos() {
        return zavazadlos;
    }

    public void setZavazadlos(Set<Zavazadlo> zavazadlos) {
        this.zavazadlos = zavazadlos;
    }

}