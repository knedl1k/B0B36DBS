package DAO;
import entities.*;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class ZavazadloDAO {
    private EntityManager em;
    public ZavazadloDAO(EntityManager em){
        this.em=em;
    }
    public void insertZavazadlo(Pasazer pas, BigDecimal hmotnost){
        EntityTransaction et=em.getTransaction();
        Zavazadlo a = new Zavazadlo();
        a.setCisloPasu(pas);
        a.setHmotnost(hmotnost);
        et.begin();
        em.persist(a);
        et.commit();
    }
    public void deleteZavazadlo(Zavazadlo l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Zavazadlo> getAll(){
        return em.createQuery("SELECT k FROM Zavazadlo AS k", Zavazadlo.class).getResultList();
    }
    public List<Zavazadlo> getAllZavazadlo(Pasazer pas ){
        TypedQuery<Zavazadlo> q = em.createQuery("SELECT k FROM Zavazadlo AS k WHERE (k.cisloPasu = :pas)",
                Zavazadlo.class);
        q.setParameter("pas", pas);
        return q.getResultList();
    }
}
