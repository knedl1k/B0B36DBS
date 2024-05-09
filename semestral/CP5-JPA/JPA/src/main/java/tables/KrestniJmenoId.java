package tables;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class KrestniJmenoId implements Serializable {
    private static final long serialVersionUID = 1326959247045846978L;
    @Column(name = "cislo_pasu", nullable = false, length = 9)
    private String cisloPasu;

    @Column(name = "krestni_jmeno", nullable = false, length = 10)
    private String krestniJmeno;

    public String getCisloPasu() {
        return cisloPasu;
    }

    public void setCisloPasu(String cisloPasu) {
        this.cisloPasu = cisloPasu;
    }

    public String getKrestniJmeno() {
        return krestniJmeno;
    }

    public void setKrestniJmeno(String krestniJmeno) {
        this.krestniJmeno = krestniJmeno;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        KrestniJmenoId entity = (KrestniJmenoId) o;
        return Objects.equals(this.krestniJmeno, entity.krestniJmeno) &&
                Objects.equals(this.cisloPasu, entity.cisloPasu);
    }

    @Override
    public int hashCode() {
        return Objects.hash(krestniJmeno, cisloPasu);
    }

}