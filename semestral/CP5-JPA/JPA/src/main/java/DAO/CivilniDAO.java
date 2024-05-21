package DAO;

import entities.*;

import jakarta.persistence.*;

import java.util.List;

public class CivilniDAO {
    private EntityManager em;
    public CivilniDAO(EntityManager em){
        this.em=em;
    }
    public Civilni insertCivilni(String znacka, String vlastnik, Integer kapacita){
        EntityTransaction et=em.getTransaction();
        Civilni a = new Civilni();
        a.setRegistracniZnacka(znacka);
        a.setVlastnik(vlastnik);
        a.setKapacitaPasazeru(kapacita);

        et.begin();
        em.persist(a);
        et.commit();
        return a;
    }
    public void deleteCivilni(Civilni l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Civilni> getAll(){
        return em.createQuery("SELECT k FROM Civilni AS k", Civilni.class).getResultList();
    }
    public List<Civilni> getAllVlastnik(String vlastnik){
        TypedQuery<Civilni> q = em.createQuery("SELECT b FROM Civilni AS b WHERE (b.vlastnik = :vlast)",
                Civilni.class);
        q.setParameter("vlast", vlastnik);
        return q.getResultList();
    }
    public List<Civilni> getAllPasazer(Integer pocet){
        TypedQuery<Civilni> q = em.createQuery("SELECT b FROM Civilni AS b WHERE (b.kapacitaPasazeru >= :poc)",
                Civilni.class);
        q.setParameter("poc", pocet);
        return q.getResultList();
    }
    public Civilni getCivilni(String znacka){
        return em.find(Civilni.class,znacka);
    }
}