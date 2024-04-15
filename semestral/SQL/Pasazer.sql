CREATE TABLE Pasazer (
    cislo_pasu VARCHAR(20) PRIMARY KEY,
    datum_narozeni DATE NOT NULL,
    krestni_jmeno VARCHAR(255) NOT NULL,
    prijmeni VARCHAR(255) NOT NULL,
    registracni_znacka VARCHAR(10),
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka)
);
