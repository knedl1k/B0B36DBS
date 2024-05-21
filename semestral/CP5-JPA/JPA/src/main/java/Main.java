import entities.*;
import DAO.*;
import jakarta.persistence.*;
import java.util.List;
import java.time.*;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ApplicationPU");
        EntityManager em = emf.createEntityManager();

        ZavazadloDAO z = new ZavazadloDAO(em);
        List<Zavazadlo> lz = z.getAll();
        for (Zavazadlo zavazadlo : lz) {
            System.out.println(zavazadlo);
        }



    }

}


/* Najde vsechny pasazery v jednom letadle
        PasazerDAO p=new PasazerDAO(em);
        LetadloDAO d=new LetadloDAO(em);
        List<Pasazer> lp = p.getAllLetadlo(d.getLetadlo("KM-PHO4US"));
        for(Pasazer b : lp){
            System.out.println(b);
        }
*/
/*
        em.getTransaction().begin();

        Pasazer p = new Pasazer();
        p.setCisloPasu("111111111");
        p.setDatumNarozeni(LocalDate.parse("1975-06-04"));
        p.setPrijmeni("Adamec");

        KrestniJmenoId krestniJmenoId = new KrestniJmenoId(p.getCisloPasu(), "Jakub");
        KrestniJmeno k = new KrestniJmeno();
        k.setId(krestniJmenoId);
        k.setPasazer(p);

        em.persist(p);
        em.persist(k);

        em.getTransaction().commit();
*/