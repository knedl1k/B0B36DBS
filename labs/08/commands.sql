/*
SELECT DISTINCT OS.jmeno, OS.prijmeni
FROM osobni_udaje OS
WHERE EXISTS (SELECT *
    FROM je_nadrizeny
    WHERE EXISTS(SELECT *
        FROM osobni_udaje OSS
        WHERE OSS.jmeno = 'Zdeněk' AND OSS.prijmeni = 'Řeřucha'
            AND OS.login = je_nadrizeny.zamestnanec
            AND OSS.login=je_nadrizeny.nadrizeny));


SELECT *
FROM kniha JOIN nalezi_zanru USING(ISBN);
-- NATURAL JOIN spoji podle stejne pojmenovanych sloupcu, zde spojuje podle nazvu knihy a nazvu zanru, tedy se nic nevrati

SELECT * from nalezi_zanru;

--agregace je kdyz neco pocitam
SELECT nazev, count(ISBN)
FROM nalezi_zanru
GROUP BY nazev;
*/

/*
SELECT kniha.nazev, ISBN
FROM kniha JOIN nalezi_zanru USING (ISBN)
WHERE nalezi_zanru.nazev = 'Česká a slovenská beletrie'
   OR nalezi_zanru.nazev = 'Světová beletrie';
-- druhy zpusob:
SELECT kniha.nazev, ISBN
FROM kniha JOIN nalezi_zanru USING (ISBN)
WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie');
-- treti zpusob:
SELECT kniha.nazev, ISBN
FROM kniha
WHERE isbn IN (SELECT ISBN
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie'));
-- ctvrty:
SELECT kniha.nazev, ISBN
FROM kniha
WHERE isbn = ANY (SELECT ISBN
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie')
    AND nalezi_zanru.ISBN = kniha.ISBN);
-- paty:
SELECT kniha.nazev, ISBN
FROM kniha
WHERE EXISTS (SELECT *
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie')
    AND nalezi_zanru.ISBN = kniha.ISBN);
-- sesty:
SELECT kniha.nazev, ISBN
FROM kniha NATURAL JOIN (SELECT ISBN
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie'))
AS NZ;
-- sedmy:
SELECT kniha.nazev, ISBN
FROM kniha JOIN nalezi_zanru USING (ISBN)
WHERE nalezi_zanru.nazev = 'Česká a slovenská beletrie'
UNION DISTINCT --pokud chci vsechno, tak ALL
SELECT kniha.nazev, ISBN
FROM kniha JOIN nalezi_zanru USING (ISBN)
WHERE nalezi_zanru.nazev = 'Světová beletrie';

/*
NEGACE
 */
SELECT kniha.nazev, ISBN, nalezi_zanru.nazev
FROM kniha JOIN nalezi_zanru USING(ISBN);

-- != je <>
-- prvni: SPATNY OUTPUT
SELECT kniha.nazev, ISBN
FROM kniha JOIN nalezi_zanru USING (ISBN)
WHERE (nalezi_zanru.nazev <> 'Česká a slovenská beletrie'
   and nalezi_zanru.nazev <> 'Světová beletrie');
-- druhy zpusob: SPATNY OUTPUT
SELECT kniha.nazev, ISBN
FROM kniha JOIN nalezi_zanru USING (ISBN)
WHERE nalezi_zanru.nazev NOT IN ('Česká a slovenská beletrie', 'Světová beletrie');
-- treti zpusob: SPRAVNE
SELECT kniha.nazev, ISBN
FROM kniha
WHERE isbn NOT IN (SELECT ISBN
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie'));
-- ctvrty: SPRAVNE
SELECT kniha.nazev, ISBN
FROM kniha
WHERE isbn <> ALL (SELECT ISBN
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie')
    AND nalezi_zanru.ISBN = kniha.ISBN);
-- paty: SPRAVNE
SELECT kniha.nazev, ISBN
FROM kniha
WHERE NOT EXISTS (SELECT *
    FROM nalezi_zanru
    WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie')
    AND nalezi_zanru.ISBN = kniha.ISBN);
-- sesty: SPRAVNE
SELECT kniha.nazev, kniha.ISBN, nalezi_zanru.nazev
FROM kniha LEFT OUTER JOIN nalezi_zanru ON kniha.isbn = nalezi_zanru.isbn
AND nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie')
WHERE nalezi_zanru.nazev is NULL;
-- sedmy:
SELECT kniha.nazev, ISBN
FROM kniha
WHERE ISBN IN (SELECT isbn
               FROM kniha
               EXCEPT (SELECT isbn
                      FROM nalezi_zanru
                      WHERE nalezi_zanru.nazev IN ('Česká a slovenská beletrie', 'Světová beletrie') ));
*/
--------------------

SELECT nazev, rok, jmeno, prijmeni, ISBN
FROM (SELECT *
      FROM kniha
      WHERE ISBN LIKE '978-80-2_7%' ) AS k978 -- jeden znak je _; n znaku %
    JOIN autor USING(ISBN);

SELECT zakaznik, ISBN, kniha.nazev, round(CAST((pujceno-30) * pokuta AS numeric), 2) AS pokuta, pujceno
FROM (SELECT id_operace, DATE_PART('day', AGE(vraceno, od)) +
                         30 * DATE_PART('month', AGE(vraceno, od)) AS pujceno
      FROM operace) AS OPPP
      JOIN operace USING(id_operace)
      JOIN kniha USING(ISBN)
WHERE pujceno > 30;