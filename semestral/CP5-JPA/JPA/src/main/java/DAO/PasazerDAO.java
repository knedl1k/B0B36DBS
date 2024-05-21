package DAO;
import entities.*;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.List;

public class PasazerDAO {
    private EntityManager em;
    public PasazerDAO(EntityManager em){
        this.em=em;
    }
    public void insertPasazer(String pas, LocalDate datum, String prijmeni, Letadlo znacka, String krestni){
        EntityTransaction et=em.getTransaction();
        Pasazer a = new Pasazer();
        KrestniJmeno ak = new KrestniJmeno();
        a.setCisloPasu(pas);
        a.setDatumNarozeni(datum);
        a.setPrijmeni(prijmeni);
        //a.setRegistracniZnacka(znacka);
        //ak.setPasazer(a);
        ak.setKrestniJmeno(krestni);
        et.begin();
        em.persist(a);
        em.persist(ak);
        et.commit();
    }
    public void deletePasazer(Pasazer l){
        EntityTransaction et= em.getTransaction();
        et.begin();
        em.remove(l);
        et.commit();
    }
    public List<Pasazer> getAll(){
        return em.createQuery("SELECT k FROM Pasazer AS k", Pasazer.class).getResultList();
    }
    public List<Pasazer> getAllLetadlo(Letadlo znacka){
        TypedQuery<Pasazer> q = em.createQuery("SELECT k FROM Pasazer AS k WHERE (k.registracniZnacka = :znacka)",
                Pasazer.class);
        q.setParameter("znacka", znacka);
        return q.getResultList();
    }
}
