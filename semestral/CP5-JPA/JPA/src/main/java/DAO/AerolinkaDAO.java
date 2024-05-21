package DAO;
import entities.*;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class AerolinkaDAO {
    private EntityManager em;
    public AerolinkaDAO(EntityManager em){
        this.em=em;
    }
    public void insertAerolinka(String kod, String nazev, String zeme){
        EntityTransaction et=em.getTransaction();
        Aerolinka a = new Aerolinka();
        a.setKodSpolecnosti(kod);
        a.setNazev(nazev);
        a.setZemePuvodu(zeme);
        et.begin();
        em.persist(a);
        et.commit();
    }
    public void deleteAerolinka(Aerolinka l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Aerolinka> getAll(){
        return em.createQuery("SELECT k FROM Aerolinka AS k", Aerolinka.class).getResultList();
    }
    public List<Aerolinka> getAllZeme(String zeme){
        TypedQuery<Aerolinka> q = em.createQuery("SELECT k FROM Aerolinka AS k WHERE (k.zemePuvodu = :zeme)",
                Aerolinka.class);
        q.setParameter("zeme", zeme);
        return q.getResultList();
    }
}
