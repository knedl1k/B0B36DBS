import DAO.KnihaDAO;
import jakarta.persistence.*;
import tables.Kniha;
import tables.NaleziZanru;
import tables.Zanr;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ApplicationPU");
        EntityManager em = emf.createEntityManager();
        EntityTransaction et = em.getTransaction();

        KnihaDAO k = new KnihaDAO(em);

        List<Kniha> ll = k.getAll();
        for(Kniha b : ll)
            System.out.println(b);
        System.out.println("\n");

        ll=k.getAllVydavatel("Kontrast");
        for(Kniha b : ll)
            System.out.println(b);
        System.out.println("\n");

//        Kniha kk=k.getKniha("978-80-271-3688-9");
//        k.deleteKniha(kk);

        List<Zanr> lz=em.createQuery("SELECT z FROM Zanr AS z", Zanr.class).getResultList();
        for(Zanr z : lz){
            TypedQuery<NaleziZanru> q= em.createQuery(
                    "SELECT nz FROM NaleziZanru AS nz WHERE nz.nazev=:idZanr",
                    NaleziZanru.class);
            q.setParameter("idZanr",z);
            List<NaleziZanru> nz = q.getResultList();
            System.out.println(z);
            for(NaleziZanru b : nz)
                System.out.println("\t" + b.getIsbn());
            System.out.println("\n");
        }


        em.close();
        emf.close();
    }
}
