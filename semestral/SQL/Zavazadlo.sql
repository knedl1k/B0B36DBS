CREATE TABLE Zavazadlo (
    datum DATE,
    cislo_letu VARCHAR(10),
    cislo_pasu VARCHAR(20),
    hmotnost DECIMAL NOT NULL,
    PRIMARY KEY (datum, cislo_letu, cislo_pasu),
    FOREIGN KEY (cislo_pasu) REFERENCES Pasazer (cislo_pasu)
);
