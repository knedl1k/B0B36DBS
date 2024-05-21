package DAO;
import entities.*;

import jakarta.persistence.*;

import java.util.List;

public class LetisteDAO {
    private EntityManager em;
    public LetisteDAO(EntityManager em){
        this.em=em;
    }
    public Letiste insertLetiste(String ICAO, String nazev, String mesto, String stat){
        EntityTransaction et=em.getTransaction();
        Letiste a = new Letiste();
        a.setIcaoKod(ICAO);
        a.setNazev(nazev);
        a.setMesto(mesto);
        a.setStat(stat);
        //a.setLetiste_odlet();
        //a.setLetiste_prilet();

        et.begin();
        em.persist(a);
        et.commit();
        return a;
    }
    public void deleteLetiste(Letiste l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Letiste> getAll(){
        return em.createQuery("SELECT k FROM Letiste AS k", Letiste.class).getResultList();
    }
    public List<Letiste> getAllStat(String stat){
        TypedQuery<Letiste> q = em.createQuery("SELECT k FROM Letiste AS k WHERE (k.stat = :stat)",
                Letiste.class);
        q.setParameter("stat", stat);
        return q.getResultList();
    }
}
