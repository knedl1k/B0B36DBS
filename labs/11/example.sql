DROP TABLE IF EXISTS Nalezi_zanru;
DROP TABLE IF EXISTS Zanr;
DROP TABLE IF EXISTS Kniha;
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

UPDATE Kniha
SET anotace = 'Jen málokterá kniha se zapsala do srdcí čtenářů tak hluboko jako právě Babička z pera známé české spisovatelky Boženy Němcové. V průběhu let se dočkala mnohých vydání a idylický život na vesnici, jehož středobodem je postava moudré, zbožné i pověrčivé staré ženy, lákal k uměleckému ztvárnění význačné české výtvarníky a ilustrátory. Jsou díla, u kterých čas a prostor nehrají roli. Babička je toho jasným důkazem. V tomto vydání se stírají hranice časoprostoru a na jednom místě se potkávají dvě silné ženské osobnosti – Božena Němcová a Míla Fürstová, světoznámá česká malířka, grafička a ilustrátorka. Dívky, ženy, matky, tvůrkyně, umělkyně… dvě silné osobnosti, dvě mysli spojené v jedno dílo.'
WHERE ISBN = '978-80-207-2063-4';
UPDATE Kniha
SET anotace = 'V této povídce autorka poukazuje na rozpory mezi životem chudého lidu a šlechtou. Hlavními postavami je rodina Skočdopolova.'
WHERE ISBN = '978-80-7497-080-1';

INSERT INTO Kniha VALUES ('978-80-277-1380-6', 'Retro křížovky: První republika', 'Naše nakladatelství', '2022', 'Víte, čemu se říkalo Táflrunda? Co si přála v roce 1936 většina žen k Vánocům? Čemu kralovala Eliška Junková nebo kdy a komu se v Praze konečně povedlo otevřít zoologickou zahradu? Zažijte časy první republiky a procvičte si mozek luštěním. Naše RETRO křížovky vám přinášejí tajenku na každý den v roce!', 'https://www.knihydobrovsky.cz/kniha/retro-krizovky-prvni-republika-454112262');
INSERT INTO Kniha VALUES ('978-80-204-3895-9', 'Děsná dvojka má namále', 'Mladá fronta', '2021', 'Miles a Niles byli v provádění fórků skutečné jedničky. Ale když se spojili a vytvořili tým s názvem Děsná dvojka, jsou nepřekonatelní. I když… Brzy budou muset prokázat, že se hned tak něčeho nezaleknou. Svůj fórkařský um totiž dovedli tak daleko, že kvůli jejich poslední legrácce je jejich obávaný protivník ředitel Rass propuštěn. Místo něj usedá do ředitelského křesla bývalý ředitel Rass. A to je teprv ras! Na škole zavládne tvrdý režim.', 'https://www.databazeknih.cz/knihy/desna-dvojka-miles-a-niles-desna-dvojka-ma-namale-278887');
INSERT INTO Kniha VALUES ('978-80-7617-857-1', 'Temné lesy', 'Kalibr', '2019', 'Okresní státní zástupce Paul Copeland se pouští do soukromého vyšetřování dvacet let starého případu, kdy v hlubokých lesích kolem dětského letního tábora zmizeli čtyři mladí lidé. Dva z nich se našli s proříznutým hrdlem, dva už nikdy nikdo neviděl. Jenže teď je jeden z nich nalezen – mrtvý a o dvacet let starší, než by měl být…Harlan Coben ve své detektivce opět zastihuje své hrdiny v mezní životní situaci, kdy musejí čelit nejen vnějšímu tlaku, ale i vlastní minulosti a svědomí. Kniha zaujme nejen tajemnou zápletkou, skvělou psychologickou kresbou postav a svižným dějem, ale i vtipnými dialogy a ironickým nadhledem.', 'https://www.databazeknih.cz/knihy/temne-lesy-3500');
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
INSERT INTO Kniha VALUES ('978-80-277-0382-1', 'Vesmírníček', 'Drobek', '2022', 'Už jste někdy zažili, že ve vás něco vyvolalo neodbytnou otázku proč? Začal vám v hlavě hryzat červík poznání a nenechal toho, dokud jste nenašli odpověď? To my, vědci a vědkyně, dobře známe.', 'https://www.databazeknih.cz/knihy/vesmirnicek-500930');
INSERT INTO Nalezi_zanru VALUES ('978-80-277-0382-1', 'Naučná literatura');
INSERT INTO Nalezi_zanru VALUES ('978-80-277-0382-1', 'Světová beletrie');
INSERT INTO Kniha VALUES ('978-80-277-2018-7', 'Toskánské dědictví', 'Kontrast', '2024', NULL, 'https://www.databazeknih.cz/knihy/toskanske-dedictvi-528469');
INSERT INTO Nalezi_zanru VALUES
('978-80-277-2018-7', 'Světová beletrie'),
('978-80-277-2018-7', 'Thrillery');
INSERT INTO Kniha VALUES ('978-80-277-1279-3', 'Kdyby ze světa zmizely kočky', 'Kontrast', '2023', 'Co byste dělali, kdybyste zjistili, že brzo zemřete? A co teprve tehdy, kdyby se před vámi objevil Ďábel s nabídkou, že vám život prodlouží? Má to však jeden háček. Za každý den vašeho života navíc musí ze světa něco nadobro zmizet.
Přesně v takové situaci se ocitne hrdina románu Kdyby ze světa zmizely kočky, pošťák, který žije v malém bytě se svým kocourem jménem pan Zelí. Jednoho dne mu lékař oznámí, že mu kvůli nádoru na mozku už nezbývá moc času. Objeví se však Ďábel s nabídku, která se zdánlivě neodmítá. Hrdina pak každý den musí čelit volbě, zda nechá něco trvale zmizet ze světa, aby na něm on sám mohl zůstat o den déle.', NULL);
INSERT INTO Nalezi_zanru VALUES ('978-80-277-1279-3', 'Světová beletrie');
INSERT INTO Nalezi_zanru VALUES ('978-80-277-1279-3', 'Horory');
INSERT INTO Kniha VALUES ('978-80-908289-4-0', 'Až na ten konec dobrý', 'Otoč', '2021', NULL, 'https://www.databazeknih.cz/knihy/az-na-ten-konec-dobry-481900');
INSERT INTO Nalezi_zanru VALUES
('978-80-908289-4-0', 'Česká a slovenská beletrie');
INSERT INTO Kniha VALUES ('978-80-277-0451-4', 'Sedm manželů Evelyn Hugo', 'Kontrast', '2023', NULL, 'https://www.databazeknih.cz/knihy/sedm-manzelu-evelyn-hugo-495888');
INSERT INTO Nalezi_zanru VALUES
('978-80-277-0451-4', 'Světová beletrie');
INSERT INTO Kniha VALUES ('978-80-277-2075-0', 'Botanikova dcera', 'Kontrast', '2024', 'V Anglii konce 19. století stále panují přísné společenské konvence. Svéhlavá a odvážná Elizabeth je dcerou významného botanika a sběratele cenných rostlin. Také ona miluje květiny a je skvělou ilustrátorkou. Bohužel je ale žena, a tak nemůže své touhy o objevování cizích krajů a rostlin uskutečnit. To vše se změní, když její otec vážně onemocní a na smrtelné posteli dceři svěří riskantní a nebezpečný úkol. A Elizabeth vypluje za největším dobrodružstvím svého života.', 'https://www.databazeknih.cz/knihy/botanikova-dcera-527134');
INSERT INTO Nalezi_zanru VALUES
('978-80-277-2075-0', 'Světová beletrie');
