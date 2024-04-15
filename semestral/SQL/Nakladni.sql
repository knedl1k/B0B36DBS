CREATE TABLE Nakladni (
    registracni_znacka VARCHAR(10) PRIMARY KEY,
    nosnost DECIMAL NOT NULL,
    FOREIGN KEY (registracni_znacka) REFERENCES Letadlo (registracni_znacka)
);
