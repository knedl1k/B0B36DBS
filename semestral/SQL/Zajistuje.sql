CREATE TABLE Zajistuje (
    kod_spolecnosti VARCHAR(10),
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    PRIMARY KEY (kod_spolecnosti, cislo_letu, cas_odletu),
    FOREIGN KEY (kod_spolecnosti) REFERENCES Aerolinka (kod_spolecnosti),
    FOREIGN KEY (cislo_letu, cas_odletu) REFERENCES Let (cislo_letu, cas_odletu)
);
