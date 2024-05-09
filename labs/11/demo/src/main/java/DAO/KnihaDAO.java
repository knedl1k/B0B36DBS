package DAO;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import tables.Kniha;

import java.util.List;

public class KnihaDAO {
    private EntityManager em;
    private EntityTransaction et;

    public KnihaDAO(EntityManager em) {
        this.em=em;
        et=em.getTransaction();
    }
    public Kniha insertKniha(String ISBN, String nazev, String vydav, String rok){
        Kniha k = new Kniha();
        k.setIsbn(ISBN);
        k.setNazev(nazev);
        k.setVydavatel(vydav);
        k.setRok(rok);
        et.begin();
        em.persist(k);
        et.commit();
        return k;
    }
    public List<Kniha> getAll(){
        et.begin();
        List<Kniha> ll = em.createQuery(
                "SELECT b FROM Kniha AS b",
                Kniha.class).getResultList();
        et.commit();
        return ll;
    }
    public List<Kniha> getAllVydavatel(String vydav){
        et.begin();
        TypedQuery<Kniha> q = em.createQuery(
                "SELECT b FROM Kniha AS b WHERE b.vydavatel=:vydav",
                Kniha.class);
        q.setParameter("vydav", vydav);
        List<Kniha> ll = q.getResultList();
        et.commit();
        return ll;
    }
    public Kniha getKniha(String ISBN){
        et.begin();
        Kniha k=em.find(Kniha.class, ISBN);
        et.commit();
        return k;
    }
    public Kniha updateKniha(Kniha k){
        et.begin();
        em.merge(k);
        et.commit();
        return k;
    }
    public void deleteKniha(Kniha k){
        et.begin();
        Kniha kk = em.find(Kniha.class, k.getIsbn());
        em.remove(kk);
        et.commit();
    }
}
