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
    CONSTRAINT navazujeNa_pk_let PRIMARY KEY (cislo_letu, cas_odletu, navazujici_cislo_letu, navazujici_cas_odletu)
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

/*
-- vsichni pasazeri se zavazdlem
SELECT *
FROM pasazer, zavazadlo
WHERE pasazer.cislo_pasu=zavazadlo.cislo_pasu;
-- vsichni pasazeri bez zavazadla
SELECT *
FROM Pasazer
WHERE NOT EXISTS(
    SELECT cislo_pasu
    FROM zavazadlo
    WHERE zavazadlo.cislo_pasu =Pasazer.cislo_pasu
 );
*/