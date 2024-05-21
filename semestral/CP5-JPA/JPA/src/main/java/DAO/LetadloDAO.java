package DAO;

import entities.*;

import jakarta.persistence.*;

import java.util.List;

public class LetadloDAO {
    private EntityManager em;
    public LetadloDAO(EntityManager em){
        this.em=em;
    }
    public Letadlo insertLetadlo(String znacka, String vlastnik){
        EntityTransaction et=em.getTransaction();
        Letadlo a = new Letadlo();
        a.setRegistracniZnacka(znacka);
        a.setVlastnik(vlastnik);

        et.begin();
        em.persist(a);
        et.commit();
        return a;
    }
    public void deleteLetadlo(Letadlo l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Letadlo> getAll(){
        return em.createQuery("SELECT k FROM Letadlo AS k", Letadlo.class).getResultList();
    }
    public List<Letadlo> getAllVlastnik(String vlastnik){
        TypedQuery<Letadlo> q = em.createQuery("SELECT b FROM Letadlo AS b WHERE (b.vlastnik = :vlast)",
                Letadlo.class);
        q.setParameter("vlast", vlastnik);
        return q.getResultList();
    }
    public Letadlo getLetadlo(String znacka){
        return em.find(Letadlo.class, znacka);
    }
}