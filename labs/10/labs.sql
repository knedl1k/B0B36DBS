CREATE FUNCTION check_zustatek()
RETURNS INTEGER
AS $$
BEGIN
	IF (NEW.zustatek IS NULL OR NEW.zustatek < 0) THEN
		RAISE EXCEPTION 'Chyba pri zapisu do penezenky';
	END IF;
	NEW.realzustatek = NEW.zustatek;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER penezenka_trig BEFORE INSERT OR UPDATE ON penezenka
	FOR EACH ROW EXECUTE PROCEDURE check_zustatek();

INSERT INTO Penezenka(zakaznik, mesto, zustatek) VALUES
('Hrivnacek', 'Ceske Budejovice', -200); -- TRIGGER nepusti





ALTER TABLE penezenka
ADD COLUMN posledni_zmena TIMESTAMP;


CREATE FUNCTION posledni_zmena()
RETURNS INTEGER
AS $$
BEGIN
	NEW.posledni_zmena=CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER penezenka_trig_cas BEFORE INSERT OR UPDATE ON penezenka
	FOR EACH ROW EXECUTE PROCEDURE posledni_zmena();

INSERT INTO Penezenka(zakaznik, mesto, zustatek) VALUES
('Zelvac', 'Pisek', 100);
	