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
    ICAO_kod VARCHAR(4) PRIMARY KEY,
    nazev VARCHAR(255) NOT NULL,
    mesto VARCHAR(255) NOT NULL,
    stat VARCHAR(255) NOT NULL
);

CREATE TABLE Let (
    cislo_letu VARCHAR(6),
    cas_odletu TIMESTAMP,
    cas_priletu TIMESTAMP NOT NULL UNIQUE,
    ICAO_kod_prilet VARCHAR(4) REFERENCES Letiste (ICAO_kod),
    ICAO_kod_odlet VARCHAR(4) REFERENCES Letiste (ICAO_kod),
    PRIMARY KEY (cislo_letu, cas_odletu)
);

CREATE TABLE Navazuje_na ( -- TODO
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    navazuje VARCHAR(10),
    PRIMARY KEY (cislo_letu, cas_odletu, navazuje),
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu),
    CONSTRAINT navazuje FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu)
);

CREATE TABLE Aerolinka (
    kod_spolecnosti VARCHAR(3) PRIMARY KEY,
    nazev VARCHAR(255) NOT NULL,
    zeme_puvodu VARCHAR(255) NOT NULL
);

CREATE TABLE Zajistuje (
    kod_spolecnosti VARCHAR(3),
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    PRIMARY KEY (kod_spolecnosti, cislo_letu, cas_odletu),
    FOREIGN KEY (kod_spolecnosti) REFERENCES Aerolinka (kod_spolecnosti),
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu)
);

CREATE TABLE Letadlo (
    registracni_znacka VARCHAR(10) PRIMARY KEY,
    vlastnik VARCHAR(255) NOT NULL
);

CREATE TABLE Leti (
    registracni_znacka VARCHAR(10),
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    PRIMARY KEY (registracni_znacka, cislo_letu, cas_odletu),
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka),
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu)
);

CREATE TABLE Nakladni (
    registracni_znacka VARCHAR(10) PRIMARY KEY,
    nosnost DECIMAL NOT NULL,
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka)
);

CREATE TABLE Civilni (
    registracni_znacka VARCHAR(10) PRIMARY KEY,
    kapacita_pasazeru INT NOT NULL,
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka)
);

CREATE TABLE Pasazer (
    cislo_pasu VARCHAR(20) PRIMARY KEY,
    datum_narozeni DATE NOT NULL,
    --krestni_jmeno VARCHAR(255) NOT NULL,
    prijmeni VARCHAR(255) NOT NULL,
    registracni_znacka VARCHAR(10),
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka)
);

CREATE TABLE Krestni_jmeno (
    cislo_pasu VARCHAR(20),
    krestni_jmeno VARCHAR(10),
    PRIMARY KEY (cislo_pasu, krestni_jmeno),
    FOREIGN KEY (cislo_pasu) REFERENCES Pasazer (cislo_pasu)
);

CREATE TABLE Zavazadlo (
    datum TIMESTAMP,
    cislo_letu VARCHAR(10),
    cislo_pasu VARCHAR(20),
    hmotnost DECIMAL NOT NULL,
    PRIMARY KEY (datum, cislo_letu, cislo_pasu),
    FOREIGN KEY (cislo_pasu) REFERENCES Pasazer (cislo_pasu)
);

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
