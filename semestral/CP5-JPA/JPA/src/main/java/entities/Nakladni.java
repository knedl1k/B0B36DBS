package entities;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Entity
@Table(name = "nakladni")
public class Nakladni extends Letadlo{
    @Column(name = "nosnost", nullable = false)
    private BigDecimal nosnost;

    public BigDecimal getNosnost() {
        return nosnost;
    }

    public void setNosnost(BigDecimal nosnost) {
        this.nosnost = nosnost;
    }

    @Override
    public String toString() {
        return "Nakladni{" +
                "nosnost=" + nosnost +
                ", registracniZnacka='" + registracniZnacka + '\'' +
                ", vlastnik='" + vlastnik + '\'' +
                '}';
    }
}