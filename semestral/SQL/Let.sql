CREATE TABLE Let (
    cislo_letu VARCHAR(10),
    cas_odletu TIMESTAMP,
    cas_priletu TIMESTAMP,
    ICAO_kod_prilet VARCHAR(4) REFERENCES Letiste (ICAO_kod),
    ICAO_kod_odlet VARCHAR(4) REFERENCES Letiste (ICAO_kod),
    PRIMARY KEY (cislo_letu, cas_odletu)
);
