package entities;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;
import java.util.List;

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
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "registracni_znacka")
    private Letadlo registracniZnacka;

    public Letadlo getRegistracniZnacka() {
        return registracniZnacka;
    }

    public void setRegistracniZnacka(Letadlo registracniZnacka) {
        this.registracniZnacka = registracniZnacka;
    }

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

    @Override
    public String toString() {
        return "Pasazer{" +
                "cisloPasu='" + cisloPasu + '\'' +
                ", datumNarozeni=" + datumNarozeni +
                ", prijmeni='" + prijmeni + '\'' +
                //", letadlo=" + registracniZnacka +
                '}';
    }
}