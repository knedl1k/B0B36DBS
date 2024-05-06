-- GNU General Public License v3.0
-- knedl1k

---
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- zde se umisti vsechny sady dotazu
UPDATE Letiste SET mesto = 'Nové město' WHERE stat = 'Chad';
INSERT INTO Aerolinka (kod_spolecnosti, nazev, zeme_puvodu) VALUES ('AAA', 'AAA Airlines', 'Chad');

COMMIT;

---
CREATE VIEW Let_Info AS
SELECT l.cislo_letu, l.cas_odletu, l.cas_priletu, o.nazev AS odlet_z, p.nazev AS prilet_z
FROM Let l
JOIN Letiste o ON l.ICAO_kod_odlet = o.ICAO_kod
JOIN Letiste p ON l.ICAO_kod_prilet = p.ICAO_kod;

SELECT * FROM Let_Info;

---
CREATE OR REPLACE FUNCTION update_vlastnik_letadla()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Letadlo
    SET vlastnik = NEW.prijmeni
    WHERE registracni_znacka = NEW.registracni_znacka;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_vlastnik
AFTER INSERT ON Pasazer
FOR EACH ROW
EXECUTE FUNCTION update_vlastnik_letadla();


CREATE FUNCTION check_hmotnost()
RETURNS INTEGER
AS $$
BEGIN
	IF (NEW.hmotnost IS NULL OR NEW.hmotnost < 0) THEN
		RAISE EXCEPTION 'Spatna hmotnost zavazadla!';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER zavazadlo_trig BEFORE INSERT OR UPDATE ON zavazadlo
	FOR EACH ROW EXECUTE PROCEDURE check_hmotnost();



-- Použití triggeru
INSERT INTO Pasazer (cislo_pasu, datum_narozeni, prijmeni, registracni_znacka)
VALUES ('123456789', '1990-01-01', 'Novak', 'AB-123456');

-- Po provedení tohoto INSERTu se trigger spustí a aktualizuje vlastníka letadla


---
CREATE INDEX idx_cislo_letu ON Let (cislo_letu);

SELECT * FROM Let WHERE cislo_letu = 'AB1234';
