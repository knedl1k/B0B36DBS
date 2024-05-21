package entities;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "civilni")
public class Civilni extends Letadlo{
    @Column(name = "kapacita_pasazeru", nullable = false)
    private Integer kapacitaPasazeru;

    public Integer getKapacitaPasazeru() {
        return kapacitaPasazeru;
    }

    public void setKapacitaPasazeru(Integer kapacitaPasazeru) {
        this.kapacitaPasazeru = kapacitaPasazeru;
    }

    @Override
    public String toString() {
        return "Civilni{" +
                "kapacitaPasazeru=" + kapacitaPasazeru +
                ", registracniZnacka='" + registracniZnacka + '\'' +
                ", vlastnik='" + vlastnik + '\'' +
                '}';
    }
}