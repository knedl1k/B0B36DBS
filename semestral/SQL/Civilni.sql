CREATE TABLE Civilni (
    registracni_znacka VARCHAR(10) PRIMARY KEY,
    kapacita_pasazeru INT NOT NULL,
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka)
);
