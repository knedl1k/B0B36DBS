CREATE TABLE Krestni_jmeno (
    cislo_pasu VARCHAR(20),
    krestni_jmeno VARCHAR(255),
    PRIMARY KEY (cislo_pasu, krestni_jmeno),
    FOREIGN KEY (cislo_pasu) REFERENCES Pasazer (cislo_pasu)
);
