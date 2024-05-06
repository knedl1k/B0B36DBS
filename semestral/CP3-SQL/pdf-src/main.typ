#import "@preview/codelst:2.0.0": sourcecode


#set par(justify: true)
#set text(
  font: "New Computer Modern",
  lang:"cs",
  size: 10.5pt,
)

#set page(
  paper: "a4",
  header:[
    
  ],
  
  footer:[
    #set align(left)
    Praha, jaro 2024
    #set align(center)
    #counter(page).display(
      "1",
    )
  ],
  
)

#set align(center)
= CP-3 Vytvoření databáze, dotazy na data
Jakub Adamec --  adamej14\@fel.cvut.cz
\
\
\
#set align(left)
== 1. ER model a relační model

#show figure.caption: it => [Obr.1#it.separator #it.body]
#figure(
  image("er.png", width: 100%),
  caption: [
   Entity-relationship model databáze
  ],
)

#show figure.caption: it => [Obr.2#it.separator #it.body]
#figure(
  image("relace.png", width: 100%),
  caption: [
   Relační model databáze
  ],
)
#pagebreak()
== 2. SQL dotazy pro vytvoření databáze

#sourcecode[```sql
DROP TABLE IF EXISTS Zavazadlo;
DROP TABLE IF EXISTS Krestni_jmeno;
DROP TABLE IF EXISTS Pasazer;
DROP TABLE IF EXISTS Civilni;
DROP TABLE IF EXISTS Nakladni;
DROP TABLE IF EXISTS Leti;
DROP TABLE IF EXISTS Letadlo;
DROP TABLE IF EXISTS Zajistuje;
DROP TABLE IF EXISTS Aerolinka;
DROP TABLE IF EXISTS Navazuje_na;
DROP TABLE IF EXISTS Let;
DROP TABLE IF EXISTS Letiste;


CREATE TABLE Letiste (
    ICAO_kod VARCHAR(4) CHECK (ICAO_kod LIKE '____') PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL,
    mesto VARCHAR(50) NOT NULL,
    stat VARCHAR(50) NOT NULL
);

CREATE TABLE Let (
    cislo_letu VARCHAR(6) CHECK (cislo_letu LIKE '______'),
    cas_odletu TIMESTAMP,
    cas_priletu TIMESTAMP NOT NULL,
   ICAO_kod_prilet VARCHAR(4) REFERENCES Letiste (ICAO_kod) ON UPDATE CASCADE ON DELETE CASCADE,
    ICAO_kod_odlet VARCHAR(4) REFERENCES Letiste (ICAO_kod) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT let_pk PRIMARY KEY (cislo_letu, cas_odletu),
    CONSTRAINT let_unique UNIQUE (cislo_letu, cas_priletu)
);

CREATE TABLE Navazuje_na (
    cislo_letu VARCHAR(6) CHECK (cislo_letu LIKE '______'),
    cas_odletu TIMESTAMP,
    navazujici_cislo_letu VARCHAR(6) CHECK (navazujici_cislo_letu LIKE '______'),
    navazujici_cas_odletu TIMESTAMP,
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (navazujici_cislo_letu, navazujici_cas_odletu) REFERENCES Let (cislo_letu, cas_odletu) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT navazujeNa_pk_let PRIMARY KEY (cislo_letu, cas_odletu, 
 navazujici_cislo_letu, navazujici_cas_odletu)
);

CREATE TABLE Aerolinka (
    kod_spolecnosti VARCHAR(3) CHECK (kod_spolecnosti LIKE '___') PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL,
    zeme_puvodu VARCHAR(50) NOT NULL
);

CREATE TABLE Zajistuje (
    kod_spolecnosti VARCHAR(3) CHECK (kod_spolecnosti LIKE '___'),
    cislo_letu VARCHAR(6) CHECK (cislo_letu LIKE '______'),
    cas_odletu TIMESTAMP,
    CONSTRAINT zajistuje_pk PRIMARY KEY (kod_spolecnosti, cislo_letu, cas_odletu),
      CONSTRAINT kodSpol_fk_zajistuje FOREIGN KEY (kod_spolecnosti) REFERENCES Aerolinka (kod_spolecnosti) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT let_fk_zajistuje FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu) ON UPDATE CASCADE ON DELETE CASCADE
);
```]
\
#sourcecode[```sql
CREATE TABLE Letadlo (
    registracni_znacka VARCHAR(9) CHECK (registracni_znacka LIKE '__-______') PRIMARY KEY,
    vlastnik VARCHAR(50) NOT NULL
);

CREATE TABLE Leti (
    registracni_znacka VARCHAR(9) CHECK (registracni_znacka LIKE '__-______'),
    cislo_letu VARCHAR(6) CHECK (cislo_letu LIKE '______'),
    cas_odletu TIMESTAMP,
    CONSTRAINT leti_pk PRIMARY KEY (registracni_znacka, cislo_letu, cas_odletu),
   CONSTRAINT letadlo_fk_leti FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka) ON UPDATE CASCADE,
  CONSTRAINT let_fk_leti FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu) ON UPDATE CASCADE
);

CREATE TABLE Nakladni (
    registracni_znacka VARCHAR(9) CHECK (registracni_znacka LIKE '__-______') PRIMARY KEY,
    nosnost DECIMAL NOT NULL,
    CONSTRAINT letadlo_fk_nakladni FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Civilni (
    registracni_znacka VARCHAR(9) CHECK (registracni_znacka LIKE '__-______') PRIMARY KEY,
    kapacita_pasazeru INT NOT NULL,
    CONSTRAINT letadlo_fk_civilni FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Pasazer (
    cislo_pasu VARCHAR(9) CHECK (cislo_pasu LIKE '_________') PRIMARY KEY,
    datum_narozeni DATE NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    registracni_znacka VARCHAR(9) CHECK (registracni_znacka LIKE '__-______'),
     CONSTRAINT letadlo_fk_pasazer FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Krestni_jmeno (
    cislo_pasu VARCHAR(9) CHECK (cislo_pasu LIKE '_________'),
    krestni_jmeno VARCHAR(10),
    CONSTRAINT krestniJmeno_pk PRIMARY KEY (cislo_pasu, krestni_jmeno),
   CONSTRAINT pasazer_fk_krestniJmeno FOREIGN KEY (cislo_pasu) REFERENCES Pasazer (cislo_pasu) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Zavazadlo (
    datum TIMESTAMP,
    cislo_letu VARCHAR(6) CHECK (cislo_letu LIKE '______'),
    cislo_pasu VARCHAR(9) CHECK (cislo_pasu LIKE '_________'),
    hmotnost DECIMAL NOT NULL,
    CONSTRAINT zavazadlo_pk PRIMARY KEY (datum, cislo_letu, cislo_pasu),
  CONSTRAINT pasazer_fk_zavazadlo FOREIGN KEY (cislo_pasu) REFERENCES Pasazer (cislo_pasu) ON UPDATE CASCADE ON DELETE CASCADE
);
```]

`ON UPDATE` a `ON DELETE` používám v kombinaci prakticky vždy proto, že vždy dává smysl buď aktualizovat "potomka" anebo že dává smysl ho smazat, aby nezůstávali již nerelevantní data v tabulkách.\
`ON DELETE` používám v kontextu toho, že když se například přepraví Pasažér, jeho smysl v databázi zanikne, smaže se, a tedy s ním se musí smazat i jeho křestní jméno(a) a případné zavazadlo.\
`ON UPDATE` zase proto, že se například může z nějakého důvodu změnit registrační značka letadla, což se musí propsat i do civilní/nákladní tabulky, dle příslušnosti.

Všechny tabulky jsem vygeneroval pomocí přiloženého skriptu v kapitole 4. Skript vygeneroval CSV soubory, které jsem pak pomocí IntelliJ naimportoval do databáze, a tedy nikde nepoužívám `INSERT INTO`. 
Příkladem manuálního vložení řádku do tabulky by bylo například:
#sourcecode[```sql
INSERT INTO Letiste VALUES ('AAAA', 'Vaclav Havel Airport Prague', 'Prague', 'Czech Republic');
INSERT INTO Aerolinka VALUES ('WXH', 'Smart Wings', 'Czech Republic');
INSERT INTO Pasazer VALUES ('P01418606', '1975-06-04', 'Dominguez', 'KM-PHO4US');
INSERT INTO Krestni_jmeno VALUES ('P01418606', 'Jose');
INSERT INTO Zavazadlo VALUES ('2024-01-29 11:42:26.116000', 'iL0356', 'P01418606', '40');
```]
== 3. SQL dotazy pro získání údajů z databáze
\
#sourcecode[```sql
SELECT Letiste.nazev, Letiste.mesto, Let.cislo_letu, Let.cas_odletu
FROM Letiste
LEFT OUTER JOIN Let ON Letiste.ICAO_kod = Let.ICAO_kod_odlet;
```]
Tento dotaz vrátí údaje o letištích a odpovídajících letech odletu. Využívá vnější spojení (`LEFT OUTER JOIN`), aby zahrnul všechna letiště a případné odpovídající lety odletu.
#show figure.caption: it => [Obr.3#it.separator #it.body]
#figure(
  image("dotazy1.png", width: 100%),
  caption: [
   dotaz s vnějším spojením tabulek
  ],
)
#pagebreak()
#sourcecode[```sql
SELECT Let.cislo_letu, Let.cas_odletu, Letiste.mesto AS odlet_mesto, 
Prilet_letiste.mesto AS prilet_mesto
FROM Let
INNER JOIN Letiste ON Let.ICAO_kod_odlet = Letiste.ICAO_kod
INNER JOIN Letiste AS Prilet_letiste ON Let.ICAO_kod_prilet = Prilet_letiste.ICAO_kod;
```]
Tento dotaz vrací údaje o letech včetně informací o městě odletu a příletu. Využívá vnitřní spojení (`INNER JOIN`) mezi tabulkami Let, Letiste a opět Letiste.
#show figure.caption: it => [Obr.4#it.separator #it.body]
#figure(
  image("dotazy2.png", width: 100%),
  caption: [
   dotaz s vnitřním spojením tabulek
  ],
)
#pagebreak()
#sourcecode[```sql
SELECT pasazer.cislo_pasu, datum_narozeni, Krestni_jmeno.krestni_jmeno, prijmeni, registracni_znacka AS registracni_znacka_letadla
FROM Pasazer JOIN Krestni_jmeno USING(cislo_pasu)
WHERE datum_narozeni >= '1990-01-01'
ORDER BY datum_narozeni ASC;
```]
Dotaz vybere všechny informace o pasažérech, včetně jejich křestních jmen, kteří se narodili po a v roce 1990. Data jsou seřazena od nejstaršího pasažéra.
#show figure.caption: it => [Obr.5#it.separator #it.body]
#figure(
  image("dotazy3.png", width: 100%),
  caption: [
   dotaz s podmínkou na data
  ],
)

#pagebreak()
#sourcecode[```sql
SELECT cislo_letu, round(AVG(hmotnost), 2) AS prumer_hmotnosti
FROM Zavazadlo
GROUP BY cislo_letu
HAVING AVG(hmotnost) > 20;
```]
Dotaz spočítá průměrnou váhu zavazadel na jednoho člověka a vypíše všechny lety, kde je průměr více jak 20.
#show figure.caption: it => [Obr.6#it.separator #it.body]
#figure(
  image("dotazy4.png", width: 80%),
  caption: [
   dotaz s agregací a podmínkou v agregační funkci
  ],
)

#pagebreak()
#sourcecode[```sql
SELECT * FROM Let ORDER BY cas_odletu DESC LIMIT 10 OFFSET 0;
```]
Pomocí dotazu se vyberou časově nejvzdálenější lety a zobrazí se pouze prvních 10 výsledků. Způsobem, kterým generuji data ve skriptu jsou ty nejpozdější data v den, kdy jsem databázi generoval. Nejnovější jsou pak začátkem roku, tedy tabulka je z pohledu zaměstnance 1. 1. 2024.
#show figure.caption: it => [Obr.7#it.separator #it.body]
#figure(
  image("dotazy5.png", width: 100%),
  caption: [
   dotaz s řazením a stránkováním
  ],
)

#pagebreak()
#sourcecode[```sql
SELECT ICAO_kod_odlet AS ICAO_kod
FROM Let
UNION
SELECT ICAO_kod_prilet AS ICAO_kod
FROM Let;
```]
Dotaz zjišťuje, která letiště jsou zapojeny do letových operací v databázi, ať už jako místo startu nebo cíle. Zkombinuje dotaz na všechna odletová a příletová letiště s tím, že odstraní duplicitní záznamy.
#show figure.caption: it => [Obr.8#it.separator #it.body]
#figure(
  image("dotazy6.png", width: 30%),
  caption: [
   dotaz s množinovou operací
  ],
)

#pagebreak()
#sourcecode[```sql
SELECT * FROM Pasazer WHERE registracni_znacka IN (SELECT registracni_znacka FROM Nakladni);
```]
Dotaz vybere všechny informace o pasažérech, jejichž letadlo je určeno pro nákladní přepravu (protože jsem neplánovaně dovolil při generaci dat, že civilisti mohou být i v nákladních letadlech :) ).
#show figure.caption: it => [Obr.9#it.separator #it.body]
#figure(
  image("dotazy7.png", width: 100%),
  caption: [
   dotaz s vnořeným `SELECT`
  ],
)
#pagebreak()
== 4. Skript pro naplnění databáze
#sourcecode[```py
#!/usr/env/bin python3
# GNU General Public License v3.0
# knedl1k 2024

import csv
import random
import string
from datetime import timedelta
from faker import Faker

fake=Faker()

generated_ICAO_codes=set()
generated_kodspol_codes=set()
generated_aeroname_codes=set()
generated_registrznacka_codes=set()
taken_registrznacka_codes=set()

generated_cisloletu=list()
generated_pas_codes=set()

odlety={}
prilety={}

""" 
HELPER FUNCTIONS
"""
def generate_unique_ICAO_code():
    while True:
        code = ''.join(random.choices(string.ascii_uppercase, k=4))
        if code not in generated_ICAO_codes:
            generated_ICAO_codes.add(code)
            return code

def generate_ICAO_code():
    code = ''.join(random.choices(string.ascii_uppercase, k=4))
    return code

def generate_unique_aerokod_code():
    while True:
        code = ''.join(random.choices(string.ascii_uppercase, k=3))
        if code not in generated_kodspol_codes:
            generated_kodspol_codes.add(code)
            return code

def generate_unique_aeroname_code():
    while True:
        code=fake.company()
        if code not in generated_aeroname_codes:
            generated_aeroname_codes.add(code)
            return code

def generate_registznacka():
    while True:
        letters=string.ascii_uppercase
        numbers=string.digits
        code=''.join(random.choices(letters, k=2)) + '-' + ''.join(random.choices(letters + numbers, k=6))
        if code not in generated_registrznacka_codes:
            generated_registrznacka_codes.add(code)
            return code

def pick_registrznacka(fr):
    while True:
        code=random.choice(tuple(generated_registrznacka_codes))
        if code not in taken_registrznacka_codes:
            taken_registrznacka_codes.add(code)
            return code
```]
#sourcecode[```py
def generate_cisloletu():
    code=fake.bothify(text='??####')
    generated_cisloletu.append(code)
    return code

def generate_pas():
    while True:
        code=fake.passport_number()
        if code not in generated_pas_codes:
            generated_pas_codes.add(code)
            return code

def generate_lety(n):
    for _ in range(n):
        cislo_letu=generate_cisloletu()
        odlet=fake.date_time_this_year(before_now=True, after_now=False)
        odlety[cislo_letu]=odlet
        prilet=prilet=odlet + timedelta(hours=random.randint(1, 12))
        prilety[cislo_letu]=prilet
"""
HEAD FUNCTIONS
"""
def generate_letiste_data(n):
    with open('letiste_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['ICAO_kod', 'nazev', 'mesto', 'stat']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'ICAO_kod': generate_unique_ICAO_code(),
                'nazev': fake.company(),
                'mesto': fake.city(),
                'stat': fake.country()
            })

def generate_let_data(n):
    ls=list(generated_cisloletu)
    with open('let_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['cislo_letu', 'cas_odletu', 'cas_priletu', 'ICAO_kod_prilet', 'ICAO_kod_odlet']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(n):
            #odlet=fake.date_time_this_year(before_now=True, after_now=False)
            #prilet=odlet + timedelta(hours=random.randint(1, 12))
            writer.writerow({
                'cislo_letu': ls[i],
                'cas_odletu': odlety[ls[i]],
                'cas_priletu': prilety[ls[i]],
                'ICAO_kod_prilet': random.choice(tuple(generated_ICAO_codes)),
                'ICAO_kod_odlet': random.choice(tuple(generated_ICAO_codes))
            })

def generate_aerolinka_data(n):
    with open('aerolinka_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['kod_spolecnosti', 'nazev', 'zeme_puvodu']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'kod_spolecnosti': generate_unique_aerokod_code(),
                'nazev': generate_unique_aeroname_code(),
                'zeme_puvodu': fake.country()
            })
```]\
#sourcecode[```py
def generate_letadlo_data(n):
    with open('letadlo_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'vlastnik']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': generate_registznacka(),
                'vlastnik': fake.company(),
            })

def generate_nakladni_data(n):
    midpoint=len(list(generated_registrznacka_codes)) // 2
    ls=list(generated_registrznacka_codes)[:midpoint]
    with open('nakladni_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'nosnost']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': pick_registrznacka(ls),
                'nosnost': random.randint(5, 100),
            })

def generate_civilni_data(n):
    midpoint=len(generated_registrznacka_codes) // 2
    ls=list(generated_registrznacka_codes)[midpoint:]
    with open('civilni_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'kapacita_pasazeru']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'registracni_znacka': pick_registrznacka(ls),
                'kapacita_pasazeru': random.randint(20, 800),
            })

def generate_pasazer_data(n):
    midpoint=len(list(generated_registrznacka_codes)) // 2
    ls=list(generated_registrznacka_codes)[midpoint:]
    #print("otviram soubor")
    with open('pasazer_data.csv', 'w', newline='') as csvfile:
        fieldnames=['cislo_pasu', 'datum_narozeni', 'prijmeni', 'registracni_znacka']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            #print("zapisuju")
            writer.writerow({
                'cislo_pasu': generate_pas(),
                'datum_narozeni': fake.passport_dob(),
                'prijmeni': fake.last_name(),
                'registracni_znacka': ls[random.randint(0, len(ls)-1)]
            })
```]
#pagebreak()
#sourcecode[```py
def generate_krestnijmeno_data():
    ls=list(generated_pas_codes)
    with open('krestniJmeno_data.csv', 'w', newline='') as csvfile:
        fieldnames=['cislo_pasu', 'krestni_jmeno']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(len(ls)):
            jmeno=fake.first_name()
            writer.writerow({
                'cislo_pasu': ls[i],
                'krestni_jmeno': jmeno,
            })
            if(random.choices([0, 1], weights=[0.9, 0.1], k=1)[0]):
                jmeno2=fake.first_name()
                while jmeno==jmeno2:
                    jmeno2=fake.first_name()
                writer.writerow({
                'cislo_pasu': ls[i],
                'krestni_jmeno': jmeno2,
                })

def generate_zavazadlo_data(n):
    with open('zavazadlo_data.csv', 'w', newline='') as csvfile:
        fieldnames=['datum', 'cislo_letu', 'cislo_pasu', 'hmotnost']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for _ in range(n):
            writer.writerow({
                'datum': fake.date_time_this_year(before_now=True, after_now=False),
                'cislo_letu': generated_cisloletu[random.randint(0, len(generated_cisloletu)-1)],
                'cislo_pasu': random.choice(tuple(generated_pas_codes)), 
                'hmotnost': random.randint(1, 100),
            })

def generate_leti_data(n):
    ls=list(generated_cisloletu)
    ls2=list(generated_registrznacka_codes)
    with open('leti_data.csv', 'w', newline='') as csvfile:
        fieldnames=['registracni_znacka', 'cislo_letu', 'cas_odletu']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(n):
            writer.writerow({
                'registracni_znacka': ls2[i],
                'cislo_letu': ls[i],
                'cas_odletu': odlety[ls[i]]
            })
```]
#pagebreak()
#sourcecode[```py
taken_navazujeCislo_code=set()
taken_navazujiciCislo_code=set()
def generate_navazujeNa_data(n):
    with open('navazujeNa_data.csv', 'w', newline='') as csvfile:
        fieldnames = ['cislo_letu', 'cas_odletu', 'navazujici_cislo_letu', 'navazujici_cas_odletu']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()

        unique_ICAO_kody_odletu = list(generated_ICAO_codes)
        
        for _ in range(n):
            cislo_letu = random.choice(generated_cisloletu)
            if(cislo_letu in taken_navazujeCislo_code):
                continue
            taken_navazujeCislo_code.add(cislo_letu)
            ICAO_kod_odlet = odlety[cislo_letu]
            navazujici_lety = [let for let in generated_cisloletu if let != cislo_letu and prilety[let] > odlety[cislo_letu] and odlety[let] - prilety[cislo_letu] < timedelta(days=1)]
            
            if navazujici_lety:
                navazujici_cislo_letu = random.choice(navazujici_lety)
                if(navazujici_cislo_letu in taken_navazujiciCislo_code):
                    continue
                taken_navazujiciCislo_code.add(navazujici_cislo_letu)
                navazujici_cas_odletu = odlety[navazujici_cislo_letu]
                
                writer.writerow({
                    'cislo_letu': cislo_letu,
                    'cas_odletu': odlety[cislo_letu],
                    'navazujici_cislo_letu': navazujici_cislo_letu,
                    'navazujici_cas_odletu': navazujici_cas_odletu
                })

""""""
def generate_zajistuje_data():
    ls=list(generated_cisloletu)
    ls2=list(generated_kodspol_codes)
    with open('zajistuje_data.csv', 'w', newline='') as csvfile:
        fieldnames=['kod_spolecnosti', 'cislo_letu', 'cas_odletu']
        writer=csv.DictWriter(csvfile, fieldnames=fieldnames)
        #writer.writeheader()
        for i in range(len(ls2)):
            writer.writerow({
                'kod_spolecnosti': ls2[random.randint(0, len(ls2)-1)],
                'cislo_letu': ls[i],
                'cas_odletu': odlety[ls[i]]
            })

```]
#pagebreak()
#sourcecode[```py
if __name__ == "__main__":
    num_letadlo=1_000
    num_pasazer=40_000
    ''''''
    generate_letiste_data(10_000)

    generate_lety(1_200) #pregenerate combinations of odlet+cislo & prilet+cislo
    generate_let_data(num_letadlo)
    

    generate_aerolinka_data(1_000)

    generate_letadlo_data(num_letadlo)
    generate_nakladni_data(int(num_letadlo/2))
    generate_civilni_data(int(num_letadlo/2))
    taken_registrznacka_codes=set()

    generate_pasazer_data(num_pasazer)
    generate_krestnijmeno_data()
    generate_zavazadlo_data(int(num_pasazer//1.5))

    generate_leti_data(num_letadlo)

    generate_zajistuje_data()

    generate_navazujeNa_data(num_letadlo)
```]


Kód není příliš hezký ani efektivní, ale funkční. Pro naplnění velkým množstvím dat jsem zvolil tabulku `Pasazer`, ve které je 40 tisíc záznamů. Vedlejším efektem se stalo, že tabulka `Krestni_jmeno` je ještě větší, protože část populace má více křestních jmen (skript umí generovat pouze lidi s jedním nebo dvěma křestními jmény, ale databáze je schopná pojmout libovolné kladné množství křestních jmen).