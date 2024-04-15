CREATE TABLE Navazuje_na (
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    navazuje VARCHAR(10),
    PRIMARY KEY (cislo_letu, cas_odletu, navazuje),
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu),
    CONSTRAINT navazuje FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu)
    --FOREIGN KEY (navazuje) REFERENCES Let (cislo_letu, cas_odletu)
);
