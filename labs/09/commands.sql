CREATE TABLE Penezenka(
    idp SERIAL PRIMARY KEY,
    zakaznik VARCHAR(20) NOT NULL UNIQUE REFERENCES zakaznik(login),
    mesto VARCHAR(20) NOT NULL,
    zustatek DECIMAL(6, 2),
    realzustatek REAL
);

INSERT INTO Penezenka(zakaznik, mesto, zustatek, realzustatek) VALUES
('Komar', 'Praha 8', 150, 150),
('Tetrev', 'Brno', 42.3, 42.3),
('Blecha', 'Praha 4', 67, 67);

SELECT *
FROM penezenka;

CREATE TABLE Platba(
    idt SERIAL PRIMARY KEY,
    cas TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    zdroj INT NOT NULL REFERENCES Penezenka(idp),
    vyse DECIMAL(6,2),
    ucel VARCHAR(50),
    CONSTRAINT platba_uq UNIQUE (cas, zdroj)
);
INSERT INTO Platba(zdroj, vyse, ucel) VALUES
(1, 1.2, 'Pokuta z prodleni'),
(2, 5.40, 'Pokuta');

SELECT *
FROM platba;
DROP VIEW Pen100;
CREATE VIEW Pen100 AS
    SELECT zakaznik, mesto, zustatek, realzustatek
    FROM penezenka
    WHERE zustatek >= 100;
DROP VIEW Pen100Praha;
CREATE VIEW Pen100Praha AS
    SELECT *
    FROM Pen100
    WHERE mesto LIKE 'Praha%'
WITH CASCADED CHECK OPTION; --WITH LOCAL CHECK OPTION

SELECT *
FROM Pen100Praha;

INSERT INTO Pen100Praha(zakaznik, mesto, zustatek, realzustatek) VALUES
('Labutbila', 'Praha 2', 278, 278);

CREATE FUNCTION vloz_platbu(login VARCHAR(20), hodnota DECIMAL(6,2), ucel VARCHAR(50))
RETURNS BOOLEAN
AS
    $$
    DECLARE
        idPen INT;
        pen DECIMAL(6,2);

    BEGIN
        idPen := (SELECT idp FROM Penezenka WHERE zakaznik = login);
        IF idPen IS NULL THEN
            RETURN false;
        END IF;
        pen := (SELECT zustatek FROM Penezenka WHERE zakaznik = login);
        IF pen < hodnota THEN
            RETURN false;
        END IF;

        INSERT INTO Platba(zdroj, vyse, ucel) VALUES (idPen, hodnota, ucel);
        UPDATE Penezenka
        SET zustatek=zustatek-hodnota, realzustatek=realzustatek-hodnota
        WHERE idPen = idp;

        RETURN true;
    END;
    $$
LANGUAGE plpgsql;

SELECT vloz_platbu('Komar', 0.1, 'Pokuta za pozdni vraceni.');
SELECT * FROM penezenka;
SELECT * FROM platba;

CREATE TABLE numbers(
    id SERIAL PRIMARY KEY,
    number INT
);
CREATE PROCEDURE insert_num(count INT)
AS
    $$
        BEGIN
            FOR r IN 1..count LOOP
               INSERT INTO numbers(number) VALUES (floor(random()*100 +5));
            END LOOP;
        END;
    $$
LANGUAGE plpgsql;

CALL insert_num(100);
SELECT *
FROM numbers;

DROP PROCEDURE change;
CREATE PROCEDURE change(idn INT)
AS
    $$
        DECLARE
            tmp INT;
        BEGIN
            tmp := (SELECT number FROM numbers WHERE id = idn); -- muze vzniknout nejaky race condition, obdobne jako u paralelniho programovani
            UPDATE numbers
            SET number = tmp + 1
            WHERE idn = id;
        END;
    $$
LANGUAGE plpgsql;

CALL change(80);

DROP PROCEDURE change;
CREATE PROCEDURE change(idn INT)
AS
    $$
        DECLARE
            tmp INT;
        BEGIN
            tmp := (SELECT number FROM numbers WHERE id = idn FOR UPDATE); -- FOR UPDATE zajisti, ze pro cteni ma pristup pouze jeden
            UPDATE numbers
            SET number = tmp + 1
            WHERE idn = id;
        END;
    $$
LANGUAGE plpgsql;

DROP PROCEDURE change;
CREATE PROCEDURE change(idn INT)
AS
    $$
        DECLARE
            tmp INT;
        BEGIN
            LOCK TABLE numbers IN ACCESS EXCLUSIVE MODE;
            tmp := (SELECT number FROM numbers WHERE id = idn);
            UPDATE numbers
            SET number = tmp + 1
            WHERE idn = id;
            COMMIT;
        END;
    $$
LANGUAGE plpgsql;

-- pouziti transakce:
DROP PROCEDURE change;
CREATE PROCEDURE change(idn INT)
AS
    $$
        DECLARE
            tmp INT;
        BEGIN
            tmp := (SELECT number FROM numbers WHERE id = idn);
            UPDATE numbers
            SET number = tmp + 1
            WHERE idn = id;
        END;
    $$
LANGUAGE plpgsql;
/*spoustim najednou:*/
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
CALL change(80);
COMMIT TRANSACTION;
-- ROLLBACK TRANSACTION


-- Oprava predchozi funkce:
DROP FUNCTION vloz_platbu;
CREATE FUNCTION vloz_platbu(login VARCHAR(20), hodnota DECIMAL(6,2), ucel VARCHAR(50))
RETURNS BOOLEAN
AS
    $$
    DECLARE
        idPen INT;
        pen DECIMAL(6,2);

    BEGIN
        idPen := (SELECT idp FROM Penezenka WHERE zakaznik = login);
        IF idPen IS NULL THEN
            RETURN false;
        END IF;
        pen := (SELECT zustatek FROM Penezenka WHERE zakaznik = login);
        IF pen < hodnota THEN
            RETURN false;
        END IF;

        INSERT INTO Platba(zdroj, vyse, ucel) VALUES (idPen, hodnota, ucel);
        UPDATE Penezenka
        SET zustatek=zustatek-hodnota, realzustatek=realzustatek-hodnota
        WHERE idPen = idp;

        RETURN true;
    END;
    $$
LANGUAGE plpgsql;
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT vloz_platbu('Komar',0.1,'Pokuta.');
COMMIT;

EXPLAIN ANALYSE SELECT * FROM my_faust ORDER BY word;
CREATE INDEX faust_idx ON my_faust(word);

EXPLAIN ANALYSE SELECT * FROM my_faust WHERE word LIKE 'faust%' ORDER BY word;
