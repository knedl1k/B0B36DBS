DROP TABLE IF EXISTS Operace;
DROP TABLE IF EXISTS Rezervuje; 
DROP TABLE IF EXISTS Komentar; 
DROP TABLE IF EXISTS Je_nadzanr; 
DROP TABLE IF EXISTS Nalezi_zanru; 
DROP TABLE IF EXISTS Zanr; 
DROP TABLE IF EXISTS Anotace; 
DROP TABLE IF EXISTS Autor; 
DROP TABLE IF EXISTS Exemplar; 
DROP TABLE IF EXISTS Kniha; 
DROP TABLE IF EXISTS Osobni_udaje; 
DROP TABLE IF EXISTS Doporucil; 
DROP TABLE IF EXISTS Sledujici; 
DROP TABLE IF EXISTS Clensky_prispevek; 
DROP TABLE IF EXISTS Zakaznik; 
DROP TABLE IF EXISTS Je_nadrizeny; 
DROP TABLE IF EXISTS Zamestnanec; 
DROP TABLE IF EXISTS Uzivatel; 
DROP SEQUENCE IF EXISTS operace_id_seq;
CREATE TABLE Kniha (
  ISBN VARCHAR(20) CONSTRAINT kniha_pk PRIMARY KEY,
  nazev VARCHAR(50) NOT NULL,
  vydavatel VARCHAR(50) NOT NULL,
  rok CHAR(4) NOT NULL,
  anotace TEXT,
  URL VARCHAR(100) CONSTRAINT kniha_url_unique UNIQUE,
  CONSTRAINT kniha_unique UNIQUE (nazev, vydavatel, rok)
);
INSERT INTO Kniha VALUES ('978-80-207-2063-4', 'Babička', 'Odeon', '2021', NULL, NULL);
INSERT INTO Kniha VALUES ('978-80-7497-080-1', 'V zámku a v podzámčí', 'Akcent', '2021', NULL, NULL);

CREATE TABLE Autor (
  ISBN VARCHAR(20) NOT NULL CONSTRAINT isbnB_fk_kniha REFERENCES Kniha(ISBN),
  jmeno VARCHAR(50) NOT NULL,
  prijmeni VARCHAR(50) NOT NULL,
  PRIMARY KEY (ISBN, jmeno, prijmeni)
);
UPDATE Kniha
SET anotace = 'Jen málokterá kniha se zapsala do srdcí čtenářů tak hluboko jako právě Babička z pera známé české spisovatelky Boženy Němcové. V průběhu let se dočkala mnohých vydání a idylický život na vesnici, jehož středobodem je postava moudré, zbožné i pověrčivé staré ženy, lákal k uměleckému ztvárnění význačné české výtvarníky a ilustrátory. Jsou díla, u kterých čas a prostor nehrají roli. Babička je toho jasným důkazem. V tomto vydání se stírají hranice časoprostoru a na jednom místě se potkávají dvě silné ženské osobnosti – Božena Němcová a Míla Fürstová, světoznámá česká malířka, grafička a ilustrátorka. Dívky, ženy, matky, tvůrkyně, umělkyně… dvě silné osobnosti, dvě mysli spojené v jedno dílo.'
WHERE ISBN = '978-80-207-2063-4';
UPDATE Kniha
SET anotace = 'V této povídce autorka poukazuje na rozpory mezi životem chudého lidu a šlechtou. Hlavními postavami je rodina Skočdopolova.'
WHERE ISBN = '978-80-7497-080-1';
INSERT INTO Autor VALUES ('978-80-207-2063-4', 'Božena', 'Němcová'),
('978-80-7497-080-1', 'Božena', 'Němcová');

INSERT INTO Kniha VALUES ('978-80-277-1380-6', 'Retro křížovky: První republika', 'Naše nakladatelství', '2022', 'Víte, čemu se říkalo Táflrunda? Co si přála v roce 1936 většina žen k Vánocům? Čemu kralovala Eliška Junková nebo kdy a komu se v Praze konečně povedlo otevřít zoologickou zahradu? Zažijte časy první republiky a procvičte si mozek luštěním. Naše RETRO křížovky vám přinášejí tajenku na každý den v roce!', 'https://www.knihydobrovsky.cz/kniha/retro-krizovky-prvni-republika-454112262');
INSERT INTO Kniha VALUES ('978-80-204-3895-9', 'Děsná dvojka má namále', 'Mladá fronta', '2021', 'Miles a Niles byli v provádění fórků skutečné jedničky. Ale když se spojili a vytvořili tým s názvem Děsná dvojka, jsou nepřekonatelní. I když… Brzy budou muset prokázat, že se hned tak něčeho nezaleknou. Svůj fórkařský um totiž dovedli tak daleko, že kvůli jejich poslední legrácce je jejich obávaný protivník ředitel Rass propuštěn. Místo něj usedá do ředitelského křesla bývalý ředitel Rass. A to je teprv ras! Na škole zavládne tvrdý režim.', 'https://www.databazeknih.cz/knihy/desna-dvojka-miles-a-niles-desna-dvojka-ma-namale-278887');
INSERT INTO Autor VALUES ('978-80-204-3895-9', 'Mac', 'Barnett'), ('978-80-204-3895-9', 'John', 'Jory');
INSERT INTO Kniha VALUES ('978-80-7617-857-1', 'Temné lesy', 'Kalibr', '2019', 'Okresní státní zástupce Paul Copeland se pouští do soukromého vyšetřování dvacet let starého případu, kdy v hlubokých lesích kolem dětského letního tábora zmizeli čtyři mladí lidé. Dva z nich se našli s proříznutým hrdlem, dva už nikdy nikdo neviděl. Jenže teď je jeden z nich nalezen – mrtvý a o dvacet let starší, než by měl být…Harlan Coben ve své detektivce opět zastihuje své hrdiny v mezní životní situaci, kdy musejí čelit nejen vnějšímu tlaku, ale i vlastní minulosti a svědomí. Kniha zaujme nejen tajemnou zápletkou, skvělou psychologickou kresbou postav a svižným dějem, ale i vtipnými dialogy a ironickým nadhledem.', 'https://www.databazeknih.cz/knihy/temne-lesy-3500');
INSERT INTO Autor VALUES ('978-80-7617-857-1', 'Harlan', 'Coben');
CREATE TABLE Zanr (
  nazev VARCHAR(50) PRIMARY KEY,
  nadzanr VARCHAR(50), 
  CONSTRAINT zanr_fk_nad FOREIGN KEY (nadzanr) REFERENCES Zanr(nazev)
);
INSERT INTO Zanr VALUES 
('Literatura pro děti a mládež', NULL),
('Příběhy pro děti', 'Literatura pro děti a mládež'),
('Humorné příběhy pro děti', 'Příběhy pro děti'),
('Naučná literatura', 'Literatura pro děti a mládež'),
('Beletrie', NULL),
('Světová beletrie', 'Beletrie'), 
('Kuchařky', NULL),
('Domácí kuchařky', 'Kuchařky'),
('Vegetariánské kuchařky', 'Kuchařky'),
('Česká a slovenská beletrie', 'Beletrie'),
('Detektivky, Thrillery a Horory', 'Beletrie'),
('Thrillery', 'Detektivky, Thrillery a Horory'),
('Detektivky', 'Detektivky, Thrillery a Horory'),
('Horory', 'Detektivky, Thrillery a Horory');
CREATE TABLE Nalezi_zanru (
  ISBN VARCHAR(20) not NULL, 
  nazev VARCHAR(50) not NULL, 
  CONSTRAINT zanr_fk_ISBN FOREIGN KEY (ISBN) REFERENCES Kniha(ISBN),
  CONSTRAINT zanr_fk_nazev FOREIGN KEY (nazev) REFERENCES Zanr(nazev),
  PRIMARY KEY (ISBN, nazev)
);
INSERT INTO Nalezi_zanru VALUES 
('978-80-204-3895-9', 'Humorné příběhy pro děti'),
('978-80-207-2063-4', 'Česká a slovenská beletrie'),
('978-80-7497-080-1', 'Česká a slovenská beletrie'),
('978-80-7617-857-1', 'Thrillery');
CREATE TABLE Exemplar (
  cislo INTEGER, 
  ISBN VARCHAR(20) not NULL, 
  CONSTRAINT exem_fk_ISBN FOREIGN KEY (ISBN) REFERENCES Kniha(ISBN),
  PRIMARY KEY (cislo, ISBN)
);
INSERT INTO Exemplar VALUES 
(1, '978-80-204-3895-9'),
(10, '978-80-204-3895-9'),
(11, '978-80-204-3895-9'),
(501, '978-80-207-2063-4'),
(502, '978-80-207-2063-4'),
(601, '978-80-7497-080-1'),
(700, '978-80-7617-857-1'),
(701, '978-80-7617-857-1'),
(702, '978-80-7617-857-1'),
(703, '978-80-7617-857-1');
INSERT INTO Kniha VALUES ('978-80-277-0382-1', 'Vesmírníček', 'Drobek', '2022', 'Už jste někdy zažili, že ve vás něco vyvolalo neodbytnou otázku proč? Začal vám v hlavě hryzat červík poznání a nenechal toho, dokud jste nenašli odpověď? To my, vědci a vědkyně, dobře známe.', 'https://www.databazeknih.cz/knihy/vesmirnicek-500930');
INSERT INTO Autor VALUES ('978-80-277-0382-1', 'Petr', 'Brož');
INSERT INTO Nalezi_zanru VALUES ('978-80-277-0382-1', 'Naučná literatura');
INSERT INTO Exemplar VALUES 
(101, '978-80-277-0382-1'),
(102, '978-80-277-0382-1');
INSERT INTO Kniha VALUES ('978-80-277-2018-7', 'Toskánské dědictví', 'Kontrast', '2024', NULL, 'https://www.databazeknih.cz/knihy/toskanske-dedictvi-528469');
INSERT INTO Autor VALUES ('978-80-277-2018-7', 'Julianne', 'MacLean');
INSERT INTO Nalezi_zanru VALUES 
('978-80-277-2018-7', 'Světová beletrie');
INSERT INTO Exemplar VALUES 
(103, '978-80-277-2018-7'),
(104, '978-80-277-2018-7');
INSERT INTO Kniha VALUES ('978-80-277-1279-3', 'Kdyby ze světa zmizely kočky', 'Kontrast', '2023', 'Co byste dělali, kdybyste zjistili, že brzo zemřete? A co teprve tehdy, kdyby se před vámi objevil Ďábel s nabídkou, že vám život prodlouží? Má to však jeden háček. Za každý den vašeho života navíc musí ze světa něco nadobro zmizet.
Přesně v takové situaci se ocitne hrdina románu Kdyby ze světa zmizely kočky, pošťák, který žije v malém bytě se svým kocourem jménem pan Zelí. Jednoho dne mu lékař oznámí, že mu kvůli nádoru na mozku už nezbývá moc času. Objeví se však Ďábel s nabídku, která se zdánlivě neodmítá. Hrdina pak každý den musí čelit volbě, zda nechá něco trvale zmizet ze světa, aby na něm on sám mohl zůstat o den déle.', NULL);
INSERT INTO Autor VALUES ('978-80-277-1279-3', 'Genki', 'Kawamura');
INSERT INTO Nalezi_zanru VALUES ('978-80-277-1279-3', 'Světová beletrie');
INSERT INTO Exemplar VALUES 
(105, '978-80-277-1279-3'),
(106, '978-80-277-1279-3'),
(107, '978-80-277-1279-3'),
(108, '978-80-277-1279-3'),
(109, '978-80-277-1279-3');
INSERT INTO Kniha VALUES ('978-80-908289-4-0', 'Až na ten konec dobrý', 'Otoč', '2021', NULL, 'https://www.databazeknih.cz/knihy/az-na-ten-konec-dobry-481900');
INSERT INTO Autor VALUES ('978-80-908289-4-0', 'Pavel', 'Tomeš');
INSERT INTO Autor VALUES ('978-80-908289-4-0', 'Lenka', 'Otáhalová');
INSERT INTO Nalezi_zanru VALUES 
('978-80-908289-4-0', 'Česká a slovenská beletrie');
INSERT INTO Exemplar VALUES 
(110, '978-80-908289-4-0'),
(111, '978-80-908289-4-0'),
(112, '978-80-908289-4-0');
INSERT INTO Kniha VALUES ('978-80-277-0451-4', 'Sedm manželů Evelyn Hugo', 'Kontrast', '2023', NULL, 'https://www.databazeknih.cz/knihy/sedm-manzelu-evelyn-hugo-495888');
INSERT INTO Autor VALUES ('978-80-277-0451-4', 'Taylor', 'Jenkins Reid');
INSERT INTO Nalezi_zanru VALUES 
('978-80-277-0451-4', 'Světová beletrie');
INSERT INTO Exemplar VALUES 
(120, '978-80-277-0451-4'),
(121, '978-80-277-0451-4'),
(122, '978-80-277-0451-4'),
(123, '978-80-277-0451-4');
INSERT INTO Kniha VALUES ('978-80-277-2075-0', 'Botanikova dcera', 'Kontrast', '2024', 'V Anglii konce 19. století stále panují přísné společenské konvence. Svéhlavá a odvážná Elizabeth je dcerou významného botanika a sběratele cenných rostlin. Také ona miluje květiny a je skvělou ilustrátorkou. Bohužel je ale žena, a tak nemůže své touhy o objevování cizích krajů a rostlin uskutečnit. To vše se změní, když její otec vážně onemocní a na smrtelné posteli dceři svěří riskantní a nebezpečný úkol. A Elizabeth vypluje za největším dobrodružstvím svého života.', 'https://www.databazeknih.cz/knihy/botanikova-dcera-527134');
INSERT INTO Autor VALUES ('978-80-277-2075-0', 'Kayte', 'Nunn');
INSERT INTO Nalezi_zanru VALUES 
('978-80-277-2075-0', 'Světová beletrie');
INSERT INTO Exemplar VALUES 
(124, '978-80-277-2075-0'),
(125, '978-80-277-2075-0'),
(126, '978-80-277-2075-0');
CREATE TABLE Uzivatel (
  login VARCHAR(20) PRIMARY KEY,
  heslo VARCHAR(40) NOT NULL
);
INSERT INTO Uzivatel VALUES 
('Komar', 'heslo1234'),
('Velbloud', 'heslllo1234'),
('Zelvac', 'hessslo123'),
('Krokodyl', 'hesheshes'),
('Labutbila', 'lololololo'),
('Evelina', 'jakeheslo'),
('Hlavonozec', '123456789'),
('Tetrev', '987654321'),
('Hrivnacek', '123ed345'),
('Omeleto', '#3#3#3#3#'),
('Reprezent', '##32123##'),
('Rakytnik', 'heslo1123'),
('Gradient', 'hes12321'),
('Qvovoqva', '$$####$$'),
('Rakytov', 'heshes1123'),
('Kolobezka', 'elektricka'),
('Arabela', '##$$kouzlo'),
('Blecha', '$#45654#$');
CREATE TABLE Osobni_udaje (
  login VARCHAR(20) PRIMARY KEY CONSTRAINT login_fk_user REFERENCES Uzivatel(login),
  jmeno VARCHAR(30) NOT NULL,
  prijmeni VARCHAR(30) NOT NULL,
  narozen date NOT NULL,
  ulice VARCHAR(30),
  CP VARCHAR(10),
  obec VARCHAR(30),
  CONSTRAINT osoba_unique UNIQUE (jmeno, prijmeni, narozen)
);
INSERT INTO Osobni_udaje VALUES
('Omeleto', 'Pavel', 'Novotný', '1998-09-22', 'Višňová', '12345', 'Nový Jičín'), 
('Rakytnik', 'Vojtěch', 'Novotný', '2001-08-08', 'Náladová', '324', 'Jihlava'),
('Gradient', 'Miroslava', 'Navrátilová', '2005-05-25', NULL, NULL, NULL),
('Velbloud', 'Jánoš', 'Soukup', '1977-03-14', NULL, NULL, NULL),
('Rakytov', 'Zdeněk', 'Řeřucha', '1984-02-17', 'Horní', '4561', 'Praha 5'),
('Kolobezka', 'Anton', 'Vávra', '1997-06-28', 'Dolní', '784/1a', 'Praha 5'),
('Arabela', 'Amálie', 'Zálužická', '2000-02-18', 'Smutná', '13a', 'Děčín'),
('Qvovoqva', 'Alena', 'Veselá', '1992-01-03', 'Vyšehradská', '768/3', 'Kolín');
CREATE TABLE Zamestnanec (
  login VARCHAR(20) PRIMARY KEY CONSTRAINT login_fk_user REFERENCES Uzivatel(login),
  rodne_cislo VARCHAR(11) NOT NULL CHECK (rodne_cislo LIKE '______/___%') CONSTRAINT RC_unique UNIQUE,
  telefon CHAR(16) CHECK (telefon LIKE '+420 ___ ___ ___'),
  mistnost CHAR(6) NOT NULL CHECK (mistnost LIKE '__-___')
);
INSERT INTO Zamestnanec VALUES 
('Velbloud', '770314/234', '+420 123 456 789', 'KN-123'),
('Omeleto', '980922/3452', '+420 321 456 789', 'KN-123'),
('Rakytnik', '010808/5566', '+420 321 455 789', 'KN-222'),
('Rakytov', '840217/1547', '+420 321 455 564', 'KN-124'),
('Kolobezka', '970628/2564', '+420 321 455 565', 'KN-221'),
('Arabela', '005218/7841', '+420 321 455 567', 'KN-221'),
('Gradient', '055525/3266', NULL, 'KN-221'),
('Qvovoqva', '925103/3332', '+420 321 455 777', 'KN-220');
CREATE TABLE Je_nadrizeny (
  zamestnanec VARCHAR(20) PRIMARY KEY, 
  nadrizeny VARCHAR(20) NOT NULL, 
  CONSTRAINT zamest_fk_pod FOREIGN KEY (zamestnanec) REFERENCES Zamestnanec(login),
  CONSTRAINT zamest_fk_nad FOREIGN KEY (nadrizeny) REFERENCES Zamestnanec(login)
);
INSERT INTO Je_nadrizeny VALUES 
('Omeleto', 'Velbloud'),
('Rakytnik', 'Velbloud'),
('Kolobezka', 'Rakytov'),
('Arabela', 'Rakytov'),
('Qvovoqva', 'Velbloud');
CREATE TABLE Zakaznik (
  login VARCHAR(20) PRIMARY KEY CONSTRAINT login_fk_user REFERENCES Uzivatel(login),
  zamestnanec VARCHAR(20) NOT NULL CONSTRAINT login_fk_zamest REFERENCES Zamestnanec(login),
  cas TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO Zakaznik(login, zamestnanec) VALUES
('Reprezent', 'Rakytnik'),
('Evelina', 'Rakytnik'),
('Labutbila', 'Rakytnik'),
('Krokodyl', 'Qvovoqva');
INSERT INTO Zakaznik VALUES 
('Tetrev', 'Qvovoqva', '2021-03-07 17:08:53.937656'),
('Blecha', 'Qvovoqva', '2022-03-01 10:08:45.937777'),
('Zelvac', 'Qvovoqva', '2023-03-02 14:56:12.956847'),
('Komar', 'Qvovoqva', '2020-02-28 15:18:22.933355'),
('Hlavonozec', 'Gradient', '2020-03-08 7:35:51.937656'),
('Hrivnacek', 'Qvovoqva', '2021-04-25 10:12:22.937656');
CREATE TABLE Sledujici (
  zakaznik VARCHAR(20) NOT NULL, 
  sledujici VARCHAR(50) NOT NULL, 
  CONSTRAINT zak_fk_sleduj FOREIGN KEY (zakaznik) REFERENCES Zakaznik(login),
  CONSTRAINT zak_pk_sleduj PRIMARY KEY (zakaznik, sledujici) 
);
INSERT INTO Sledujici VALUES 
('Reprezent', 'Sněženka podsněžník'),
('Reprezent', 'Bledule jarní'),
('Reprezent', 'Podběl lékařský'),
('Blecha', 'Fialka lesní'),
('Zelvac', 'Mořské rostliny'),
('Komar', 'Člověk lidský'),
('Hlavonozec', 'Violka chlupatá'),
('Blecha', 'Blatouch bahenní'),
('Blecha', 'Violka vonná');
CREATE TABLE Doporucil (
  zakaznik VARCHAR(20) NOT NULL REFERENCES Zakaznik(login), 
  doporuceny VARCHAR(20) NOT NULL REFERENCES Zakaznik(login), 
  CONSTRAINT zak_pk_dop PRIMARY KEY (zakaznik, doporuceny) 
);
INSERT INTO Doporucil VALUES 
('Reprezent', 'Blecha'),
('Reprezent', 'Zelvac'),
('Zelvac', 'Komar'),
('Hlavonozec', 'Komar'),
('Blecha', 'Tetrev'),
('Blecha', 'Hrivnacek');
CREATE TABLE Clensky_prispevek (
  zakaznik VARCHAR(20) NOT NULL REFERENCES Zakaznik(login), 
  rok INTEGER NOT NULL, 
  od DATE NOT NULL,
  doo DATE NOT NULL, 
  vyse DECIMAL(6, 2) NOT NULL,
  CONSTRAINT clprisp_pk PRIMARY KEY (zakaznik, rok) 
);
INSERT INTO Clensky_prispevek VALUES 
('Reprezent', 2024, '2024-03-07', '2025-03-06', 250.00),
('Evelina', 2024, '2024-03-07', '2025-03-06', 250.00),
('Labutbila', 2024, '2024-03-07', '2025-03-06', 250.00),
('Tetrev', 2021, '2021-03-07', '2022-03-06', 200.00),
('Tetrev', 2022, '2022-03-07', '2023-03-06', 200.00),
('Tetrev', 2023, '2023-03-07', '2024-03-06', 200.00),
('Tetrev', 2024, '2024-03-07', '2025-03-06', 250.00),
('Komar', 2020, '2020-02-28', '2021-02-27', 200.00),
('Komar', 2021, '2021-02-28', '2022-02-27', 200.00),
('Komar', 2022, '2022-02-28', '2023-02-27', 200.00),
('Komar', 2023, '2023-02-28', '2024-02-27', 200.00),
('Komar', 2024, '2024-02-28', '2025-02-27', 250.00),
('Hrivnacek', 2021, '2021-04-25', '2022-04-24', 200.00),
('Hrivnacek', 2022, '2022-04-25', '2023-04-24', 200.00),
('Hrivnacek', 2023, '2023-05-05', '2024-05-04', 200.00),
('Hrivnacek', 2024, '2024-05-05', '2025-05-04', 250.00),
('Blecha', 2022, '2022-03-01', '2023-02-28', 200.00),
('Blecha', 2023, '2023-03-01', '2024-02-29', 200.00),
('Blecha', 2024, '2024-03-01', '2025-02-28', 250.00);
CREATE TABLE Rezervuje (
  zakaznik VARCHAR(20) NOT NULL REFERENCES Zakaznik(login), 
  ISBN VARCHAR(20) NOT NULL REFERENCES Kniha(ISBN), 
  CONSTRAINT rezervace_pk PRIMARY KEY (zakaznik, ISBN) 
);
INSERT INTO Rezervuje VALUES 
('Reprezent', '978-80-207-2063-4'),
('Zelvac', '978-80-277-1279-3'),
('Zelvac', '978-80-204-3895-9');
CREATE TABLE Komentar (
  nazev VARCHAR(30) NOT NULL,
  vydan TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  obsah VARCHAR(100) NOT NULL,
  zakaznik VARCHAR(20) NOT NULL REFERENCES Zakaznik(login), 
  ISBN VARCHAR(20) NOT NULL REFERENCES Kniha(ISBN), 
  CONSTRAINT komentar_pk PRIMARY KEY (nazev, vydan) 
);
INSERT INTO Komentar VALUES 
('Vesmirnicek', '2021-03-07 17:08:53.937656', 'Kniha je pro mé děti velice užitečná, rádi si v ní listují', 'Tetrev', '978-80-277-0382-1'),
('Bojime se', '2021-03-08 12:12:12.937656', 'Moje děti děsí obrázky v knize', 'Blecha', '978-80-277-0382-1'),
('Hezka knizka', '2021-03-09 10:22:23.937656', 'Hodně jsme se z knížky naučili', 'Zelvac', '978-80-277-0382-1'),
('Botanik', '2022-02-02 10:25:45.12345', 'Botanik a jeho dcera – knížka se mi líbila', 'Zelvac', '978-80-277-2075-0'),
('Dcera botanika', '2023-10-13 10:25:45.12345', 'Knížku jsem ještě nedočetla, ale příběh je velice napínavý', 'Reprezent', '978-80-277-2075-0'),
('Sedm manželů', '2024-01-20 17:35:12.54321', 'Sedm manželek bych nechtěl', 'Hrivnacek', '978-80-277-0451-4'),
('Sedm manželů', '2023-11-24 18:40:12.54321', 'Ta holka je fakt dobrá, doporučuji ke čtení, knížka je plná optimismu', 'Komar', '978-80-277-0451-4'),
('Sedm milenců', '2023-12-26 20:40:12.54321', 'Knížku jsem dostal k Vánocům a přečetl jsem ji jedním dechem', 'Tetrev', '978-80-277-0451-4'),
('Babička', '2023-10-12 21:45:12.54321', 'Právě jsem to dočetla a byly to vzpomínky na mé dětství', 'Hrivnacek', '978-80-207-2063-4'),
('Tam na zámku', '2022-09-12 19:19:12.98760', 'Z knížky mi četla moje babička a já to dnes čtu vnoučatům', 'Reprezent', '978-80-7497-080-1'),
('Šlechta', '2021-09-25 20:32:12.98760', 'Ještě, že dnes jsou si všichni rovni, takový útlak bych nesnesla', 'Evelina', '978-80-7497-080-1'),
('Drsna dvojka', '2023-07-10 20:45:12.98760', 'Šílená knížka, kdo toto koupí dětem', 'Labutbila', '978-80-204-3895-9');
CREATE TABLE Operace (
  id_operace int4 PRIMARY KEY,
  cislo INTEGER not NULL, 
  ISBN VARCHAR(20) NOT NULL, 
  zamestnanec VARCHAR(20) NOT NULL REFERENCES Zamestnanec(login),
  zakaznik VARCHAR(20) NOT NULL REFERENCES Zakaznik(login),
  od TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  cena DECIMAL(6, 2),
  pokuta DECIMAL(6, 2),  
  vraceno TIMESTAMP,
  stav VARCHAR(10) CHECK (stav IN ('nová', 'dobrý', 'roztrhaná', 'popsaná', 'špatný')),
  CONSTRAINT operace_fk_exem FOREIGN KEY (cislo, ISBN) REFERENCES Exemplar(cislo, ISBN),
  CONSTRAINT operace_uk_zak UNIQUE (zakaznik, od), 
  CONSTRAINT operace_uk_exem UNIQUE (cislo, ISBN, od), 
  CONSTRAINT operace_uk_zam UNIQUE (zamestnanec, od)
);
CREATE SEQUENCE operace_id_seq;
ALTER TABLE operace ALTER id_operace
   SET DEFAULT nextval('operace_id_seq');

INSERT INTO Operace(cislo, ISBN, zamestnanec, zakaznik, od, cena, pokuta, vraceno, stav) VALUES
(105, '978-80-277-1279-3', 'Kolobezka', 'Labutbila', '2023-07-10 20:45:12.98760', 234.50, 1.00, '2023-08-02 20:45:12.98760', 'dobrý'),
(105, '978-80-277-1279-3', 'Kolobezka', 'Reprezent', '2023-08-10 20:45:12.98760', 234.50, 1.00, '2023-08-30 10:50:12.98760', 'dobrý'),
(105, '978-80-277-1279-3', 'Kolobezka', 'Blecha', '2023-09-10 12:45:56.98760', 234.50, 1.00, '2023-10-15 13:50:25.98760', 'dobrý'),
(105, '978-80-277-1279-3', 'Rakytnik', 'Hrivnacek', '2023-10-16 17:35:12.98760', 234.50, 1.00, NULL, NULL),
(1, '978-80-204-3895-9', 'Kolobezka', 'Labutbila', '2021-11-26 10:42:39.89264', 322.50, 1.90, '2021-12-25 18:49:34.77545', 'dobrý'),
(1, '978-80-204-3895-9', 'Kolobezka', 'Blecha', '2020-1-3 13:37:39.89345', 436.50, 1.30, '2020-1-24 15:50:27.79493', 'nová'),
(1, '978-80-204-3895-9', 'Qvovoqva', 'Hrivnacek', '2020-2-17 17:48:13.64263', 436.50, 1.30, '2020-3-18 13:43:52.46639', 'nová'),
(1, '978-80-204-3895-9', 'Arabela', 'Zelvac', '2020-4-13 14:43:24.40806', 436.50, 1.30, '2020-5-7 13:31:43.62491', 'nová'),
(1, '978-80-204-3895-9', 'Kolobezka', 'Komar', '2020-6-8 12:29:14.14011', 436.50, 1.30, '2020-7-5 17:15:57.24578', 'dobrý'),
(601, '978-80-7497-080-1', 'Qvovoqva', 'Labutbila', '2020-10-2 18:39:46.40414', 439.40, 1.50, '2020-10-27 16:17:53.94816', 'dobrý'),
(601, '978-80-7497-080-1', 'Qvovoqva', 'Komar', '2020-11-19 14:54:43.44015', 439.40, 1.50, '2020-12-11 12:56:41.92716', 'dobrý'),
(601, '978-80-7497-080-1', 'Kolobezka', 'Tetrev', '2021-1-3 16:16:37.80716', 439.40, 1.50, '2021-2-1 11:44:18.83647', 'roztrhaná'),
(601, '978-80-7497-080-1', 'Omeleto', 'Reprezent', '2021-2-28 18:56:34.91560', 439.40, 1.50, '2021-3-25 11:32:52.17720', 'roztrhaná'),
(700, '978-80-7617-857-1', 'Rakytnik', 'Komar', '2020-12-6 11:24:23.52386', 220.20, 1.10, '2021-1-6 11:33:36.61203', 'dobrý'),
(700, '978-80-7617-857-1', 'Qvovoqva', 'Reprezent', '2021-2-5 17:11:11.86494', 220.20, 1.10, '2021-3-6 14:57:40.17372', 'dobrý'),
(700, '978-80-7617-857-1', 'Omeleto', 'Tetrev', '2021-4-8 12:10:22.67229', 220.20, 1.10, '2021-5-9 10:20:34.87506', 'dobrý'),
(700, '978-80-7617-857-1', 'Kolobezka', 'Blecha', '2021-6-7 10:41:32.14366', 220.20, 1.10, '2021-7-9 16:37:22.10925', 'roztrhaná'),
(701, '978-80-7617-857-1', 'Rakytnik', 'Tetrev', '2023-5-25 12:51:51.71084', 423.80, 1.60, '2023-6-18 12:29:42.44968', 'roztrhaná'),
(701, '978-80-7617-857-1', 'Arabela', 'Labutbila', '2023-7-16 15:23:52.95190', 423.80, 1.60, '2023-8-10 13:42:42.25972', 'roztrhaná'),
(701, '978-80-7617-857-1', 'Rakytnik', 'Zelvac', '2023-9-12 15:47:41.16759', 423.80, 1.60, '2023-10-12 14:15:36.10260', 'roztrhaná'),
(701, '978-80-7617-857-1', 'Rakytnik', 'Reprezent', '2023-11-6 13:51:33.71720', 423.80, 1.60, '2023-11-27 17:37:30.78305', 'roztrhaná'),
(702, '978-80-7617-857-1', 'Omeleto', 'Tetrev', '2022-4-28 18:38:49.14252', 410.40, 1.30, '2022-5-23 13:12:21.64065', 'dobrý'),
(702, '978-80-7617-857-1', 'Rakytnik', 'Blecha', '2022-6-19 17:45:29.43437', 410.40, 1.30, '2022-7-15 18:47:15.89614', 'dobrý'),
(702, '978-80-7617-857-1', 'Arabela', 'Komar', '2022-8-11 14:32:32.10816', 410.40, 1.30, '2022-9-13 13:29:35.72157', 'dobrý'),
(702, '978-80-7617-857-1', 'Rakytnik', 'Zelvac', '2022-10-13 13:24:53.70660', 410.40, 1.30, '2022-11-12 17:15:56.40301', 'dobrý'),
(101, '978-80-277-0382-1', 'Arabela', 'Reprezent', '2021-4-3 10:20:59.31699', 490.80, 1.00, '2021-4-26 15:38:27.60265', 'dobrý'),
(101, '978-80-277-0382-1', 'Kolobezka', 'Evelina', '2021-5-20 10:30:18.38047', 490.80, 1.00, '2021-6-22 15:40:43.52563', 'dobrý'),
(101, '978-80-277-0382-1', 'Rakytnik', 'Tetrev', '2021-7-23 17:58:48.41067', 490.80, 1.00, '2021-8-19 13:13:12.57047', 'dobrý'),
(103, '978-80-277-2018-7', 'Qvovoqva', 'Evelina', '2022-10-11 14:38:15.94399', 404.70, 1.20, '2022-11-11 10:54:56.92775', 'dobrý'),
(103, '978-80-277-2018-7', 'Rakytnik', 'Komar', '2022-12-9 15:32:16.88330', 404.70, 1.20, '2023-1-8 11:48:51.90717', 'dobrý'),
(103, '978-80-277-2018-7', 'Arabela', 'Labutbila', '2023-2-2 11:23:36.57206', 404.70, 1.20, '2023-3-1 12:38:19.23076', 'dobrý'),
(106, '978-80-277-1279-3', 'Rakytnik', 'Evelina', '2023-4-13 12:15:21.95544', 270.20, 1.90, '2023-5-6 15:45:11.82198', 'dobrý'),
(106, '978-80-277-1279-3', 'Kolobezka', 'Tetrev', '2023-6-1 11:50:16.98806', 270.20, 1.90, '2023-6-21 13:28:31.33316', 'dobrý'),
(106, '978-80-277-1279-3', 'Omeleto', 'Komar', '2023-7-20 18:46:36.68161', 270.20, 1.90, '2023-8-14 15:10:51.59753', 'dobrý'),
(106, '978-80-277-1279-3', 'Kolobezka', 'Labutbila', '2023-9-8 15:12:46.18083', 270.20, 1.90, '2023-9-28 16:49:41.63283', 'dobrý'),
(106, '978-80-277-1279-3', 'Qvovoqva', 'Hrivnacek', '2023-10-23 11:57:48.78000', 270.20, 1.90, '2023-11-15 10:45:57.16961', 'dobrý'),
(111, '978-80-908289-4-0', 'Arabela', 'Zelvac', '2021-11-10 10:49:55.38896', 254.20, 1.10, '2021-12-5 18:25:52.59496', 'dobrý'),
(111, '978-80-908289-4-0', 'Arabela', 'Labutbila', '2021-12-28 10:21:56.65689', 254.20, 1.10, '2022-1-23 17:33:46.88186', 'dobrý'),
(111, '978-80-908289-4-0', 'Omeleto', 'Reprezent', '2022-2-19 10:42:19.42887', 254.20, 1.10, '2022-3-17 13:44:41.95394', 'dobrý'),
(111, '978-80-908289-4-0', 'Qvovoqva', 'Evelina', '2022-4-11 15:31:46.43672', 254.20, 1.10, '2022-5-9 11:43:14.17137', 'popsaná'),
(112, '978-80-908289-4-0', 'Arabela', 'Reprezent', '2021-3-11 15:11:25.38340', 454.30, 1.80, '2021-4-10 11:23:20.45688', 'dobrý'),
(112, '978-80-908289-4-0', 'Rakytnik', 'Tetrev', '2021-5-6 12:50:20.79041', 454.30, 1.80, '2021-6-6 17:15:30.98616', 'dobrý'),
(112, '978-80-908289-4-0', 'Omeleto', 'Blecha', '2021-7-4 11:18:55.89682', 454.30, 1.80, '2021-7-28 18:42:58.86684', 'dobrý'),
(112, '978-80-908289-4-0', 'Arabela', 'Labutbila', '2021-8-25 11:24:54.11854', 454.30, 1.80, '2021-9-19 13:43:14.77092', 'dobrý'),
(112, '978-80-908289-4-0', 'Omeleto', 'Zelvac', '2021-10-19 16:45:36.67212', 454.30, 1.80, '2021-11-15 11:38:38.96189', 'dobrý'),
(121, '978-80-277-0451-4', 'Kolobezka', 'Blecha', '2023-11-23 18:26:43.67870', 420.70, 1.00, '2023-12-22 14:31:42.58013', 'dobrý'),
(121, '978-80-277-0451-4', 'Kolobezka', 'Tetrev', '2024-1-14 13:50:43.90169', 420.70, 1.00, '2024-2-15 17:44:18.75547', 'dobrý'),
(121, '978-80-277-0451-4', 'Kolobezka', 'Hrivnacek', '2024-3-11 13:55:35.81838', 420.70, 1.00, NULL, NULL),
(121, '978-80-277-0451-4', 'Kolobezka', 'Komar', '2024-5-6 14:47:15.83471', 420.70, 1.00, '2024-6-8 11:19:27.50083', 'dobrý'),
(122, '978-80-277-0451-4', 'Kolobezka', 'Labutbila', '2020-12-1 12:53:42.63985', 345.00, 1.00, '2021-1-2 15:47:21.38412', 'dobrý'),
(122, '978-80-277-0451-4', 'Qvovoqva', 'Tetrev', '2021-1-25 10:20:56.72898', 345.00, 1.00, '2021-2-26 10:29:19.13830', 'dobrý'),
(122, '978-80-277-0451-4', 'Arabela', 'Zelvac', '2021-3-27 10:38:45.20720', 345.00, 1.00, '2021-4-26 11:29:15.67563', 'popsaná'),
(122, '978-80-277-0451-4', 'Rakytnik', 'Komar', '2021-5-20 16:24:43.70320', 345.00, 1.00, '2021-6-18 13:53:10.24252', 'popsaná'),
(126, '978-80-277-2075-0', 'Rakytnik', 'Zelvac', '2022-3-10 18:55:52.63175', 236.40, 2.00, '2022-4-3 15:40:44.84981', 'dobrý'),
(126, '978-80-277-2075-0', 'Qvovoqva', 'Reprezent', '2022-5-1 12:42:30.94229', 236.40, 2.00, '2022-6-3 16:51:34.87342', 'špatný'),
(126, '978-80-277-2075-0', 'Kolobezka', 'Evelina', '2022-6-24 15:33:51.43871', 236.40, 2.00, '2022-7-21 12:35:30.61982', 'špatný');

