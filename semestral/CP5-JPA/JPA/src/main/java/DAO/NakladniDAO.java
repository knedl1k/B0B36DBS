package DAO;

import entities.*;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.List;

public class NakladniDAO {
    private EntityManager em;
    public NakladniDAO(EntityManager em){
        this.em=em;
    }
    public Nakladni insertNakladni(String znacka, String vlastnik, BigDecimal nosnost){
        EntityTransaction et=em.getTransaction();
        Nakladni a = new Nakladni();
        a.setRegistracniZnacka(znacka);
        a.setVlastnik(vlastnik);
        a.setNosnost(nosnost);

        et.begin();
        em.persist(a);
        et.commit();
        return a;
    }
    public void deleteNakladni(Nakladni l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Nakladni> getAll(){
        return em.createQuery("SELECT k FROM Nakladni AS k", Nakladni.class).getResultList();
    }
    public List<Nakladni> getAllVlastnik(String vlastnik){
        TypedQuery<Nakladni> q = em.createQuery("SELECT b FROM Nakladni AS b WHERE (b.vlastnik = :vlast)",
                Nakladni.class);
        q.setParameter("vlast", vlastnik);
        return q.getResultList();
    }
    public List<Nakladni> getAllNosnost(BigDecimal nosnost){
        TypedQuery<Nakladni> q = em.createQuery("SELECT b FROM Nakladni AS b WHERE (b.nosnost >= :nos)",
                Nakladni.class);
        q.setParameter("nos", nosnost);
        return q.getResultList();
    }
}