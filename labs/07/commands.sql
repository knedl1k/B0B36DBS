SELECT isbn,nazev,rok FROM kniha
WHERE rok NOT IN ('2021', '2022')
ORDER BY rok DESC, nazev ASC
LIMIT 3 OFFSET 2;

--DISTINCT da unikatni
-- SELECT DISTINCT mistnost from zamestnanec;

SELECT zamestnanec.telefon,zamestnanec.login FROM zamestnanec
WHERE mistnost='KN-123';

SELECT *
FROM exemplar JOIN kniha USING (isbn)
WHERE rok='2021';

SELECT k.isbn, k.nazev, a.jmeno, a.prijmeni
FROM kniha k CROSS JOIN autor a;

SELECT login
FROM uzivatel LEFT OUTER JOIN osobni_udaje USING(login)
WHERE jmeno IS NULL;
-- ANOTHER APPROACH:
SELECT login
FROM uzivatel
WHERE login NOT IN (SELECT login FROM osobni_udaje);

SELECT login, count(zakaznik) as pocet, sum(vyse) as suma
FROM zakaznik JOIN clensky_prispevek ON zakaznik.login = clensky_prispevek.zakaznik
WHERE cas < '2024-01-01'
GROUP BY login
HAVING sum(vyse) > 800
ORDER by pocet Desc, login;

-- find names of people which have supervisior called Zdeněk Řeřucha
SELECT DISTINCT OS1.jmeno, OS1.prijmeni
FROM osobni_udaje OS1
    JOIN je_nadrizeny ON OS1.login = je_nadrizeny.zamestnanec
    JOIN osobni_udaje OS2 ON OS2.login=je_nadrizeny.nadrizeny
WHERE OS2.jmeno = 'Zdeněk' AND OS2.prijmeni = 'Řeřucha'
;
