CREATE TABLE Leti (
    registracni_znacka VARCHAR(10),
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    PRIMARY KEY (registracni_znacka, cislo_letu, cas_odletu),
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka),
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu)
);
