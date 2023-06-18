-- Haupttabellen:
---------------------------------------------------------------------------


DROP TABLE if EXISTS MitarbeiterPosition;
CREATE TABLE MitarbeiterPosition (
	Positionsnummer	INTEGER NOT NULL UNIQUE,
	Positionsname	TEXT(60),
	PRIMARY KEY(Positionsnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS Mitarbeiter;
CREATE TABLE Mitarbeiter (
	Mitarbeiternummer	INTEGER NOT NULL UNIQUE,
	Telefonnummer_Festnetz	INTEGER,
	Telefonnummer Mobil	INTEGER,
	Faxnummer	INTEGER,
	Anrede	TEXT(10),
	Titel	TEXT(20),
	Geschlecht	TEXT(10),
	Vorname	TEXT(60),
	Nachname	TEXT(60),
	Strasse	TEXT(60),
	Hausnummer	TEXT(10),
	Ort	TEXT(60),
	PLZ	INTEGER,
	EMailadresse	TEXT(100),
	Beschaeftigt seit	NUMERIC,
	Geburtsdatum	NUMERIC,
	Geburtsort	TEXT(60),
	Nationalitaet	TEXT(60),
	sozialer_Status	TEXT,
	Bemerkungen	TEXT(250),
	Positionsnummer	INTEGER,
	PRIMARY KEY(Mitarbeiternummer AUTOINCREMENT),
	FOREIGN KEY (Positionsnummer) REFERENCES MitarbeiterPosition
);



DROP TABLE if EXISTS VertretungMit;
CREATE TABLE VertretungMit (
	Vertretungsnummer	INTEGER NOT NULL UNIQUE,  
	Mitarbeiternummer INTEGER,
	Vertreter INTEGER,
	Von	NUMERIC,
	Bis	NUMERIC,
	Vertretungsgrund TEXT(250),
	PRIMARY KEY(Vertretungsnummer AUTOINCREMENT),
	FOREIGN KEY (Mitarbeiternummer) REFERENCES Mitarbeiter,
	FOREIGN KEY (Vertreter) REFERENCES Mitarbeiter  
);



DROP TABLE if EXISTS Pflege;
CREATE TABLE Pflege (
	Pflegenummer	INTEGER NOT NULL UNIQUE,
	Mitarbeiternummer	INTEGER,
	Tiernummer INTEGER,
	Datum	NUMERIC,
	Pflegetyp	TEXT(60),
	Uhr	NUMERIC,
	PRIMARY KEY(Pflegenummer AUTOINCREMENT),
	FOREIGN KEY (Mitarbeiternummer) REFERENCES Mitarbeiter,
	FOREIGN KEY (Tiernummer) REFERENCES Tier
);



DROP TABLE if EXISTS Tierartpflege;
CREATE TABLE Tierartpflege (
	Tierartpflegenummer	INTEGER NOT NULL UNIQUE,
	Mitarbeiternummer INTEGER,
	Tierartnummer INTEGER,
	PRIMARY KEY(Tierartpflegenummer AUTOINCREMENT),
	FOREIGN KEY (Mitarbeiternummer) REFERENCES Mitarbeiter,
	FOREIGN KEY (Tierartnummer) REFERENCES Tierart
);



DROP TABLE if EXISTS Tierart;
CREATE TABLE Tierart (
	Tierartnummer	INTEGER NOT NULL UNIQUE,
	Tiergattungsnummer	INTEGER,
	Tierartname	TEXT(60),
	natuerlicher_Lebensraum	TEXT(250),   
	Verhaltensweisen TEXT(250),
	Abstammung  TEXT(60),
	PRIMARY KEY(Tierartnummer AUTOINCREMENT),
	FOREIGN KEY (Tiergattungsnummer) REFERENCES Tierartpflege
);



DROP TABLE if EXISTS Tiergattung;
CREATE TABLE Tiergattung (
	Tiergattungsnummer	INTEGER NOT NULL UNIQUE,
	Gattungsname	TEXT(10),
	Gattungsinfos	TEXT(250),	
	PRIMARY KEY(Tiergattungsnummer AUTOINCREMENT)	
);



DROP TABLE if EXISTS Mahlzeit;
CREATE TABLE Mahlzeit (
	Mahlzeitnummer	INTEGER NOT NULL UNIQUE,
	Mahlzeitbezeichnung	TEXT(250),
	Bemerkung	TEXT(250),
	PRIMARY KEY(Mahlzeitnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS MahlzeitTier;
CREATE TABLE MahlzeitTier (
	MahlzeitTiernummer	INTEGER NOT NULL UNIQUE,
	Mahlzeitnummer	INTEGER,
	Tiernummer	INTEGER,
	Datum	NUMERIC,
	Uhr	NUMERIC,
	PRIMARY KEY(MahlzeitTiernummer AUTOINCREMENT),
	FOREIGN KEY (Mahlzeitnummer) REFERENCES Mahlzeit,
	FOREIGN KEY (Tiernummer) REFERENCES Tier
);


--------------------------------------------------------------------------------------------
DROP TABLE if EXISTS Tier;
CREATE TABLE Tier (
	Tiernummer	INTEGER NOT NULL UNIQUE,  
	Tiername TEXT(60),
	Tierartnummer INTEGER,
	Vatertiernummer INTEGER,
	Muttertiernummer INTEGER,
	Groesse INTEGER,                      
	Gewicht REAL,
	Geburtsdatum	NUMERIC,
	Sterbedatum	NUMERIC,
	Herkunft TEXT(60),
	im_Zoo_seit NUMERIC,
	im_Zoo_geboren NUMERIC(1),  --Boolean
	Bemerkungen TEXT(250),
	Geschlecht INTEGER,
	Gewicht_Einheit TEXT(10),
	Groesse_Einheit TEXT(10),	
	PRIMARY KEY(Tiernummer AUTOINCREMENT),
	FOREIGN KEY (Tierartnummer) REFERENCES Tier,
	FOREIGN KEY (Vatertiernummer) REFERENCES Tier,
	FOREIGN KEY (Muttertiernummer) REFERENCES Tier  
);
-------------------------------------------------------------------------------------------------



DROP TABLE if EXISTS Mischung;
CREATE TABLE Mischung (
	Mischungsnummer	INTEGER NOT NULL UNIQUE,
	Mahlzeitnummer	INTEGER,
	Futternummer	INTEGER,
	Menge	REAL,
	Mengeneinheit	TEXT(10),
	PRIMARY KEY(Mischungsnummer AUTOINCREMENT),
	FOREIGN KEY (Mahlzeitnummer) REFERENCES Mahlzeit,
	FOREIGN KEY (Futternummer) REFERENCES Futter
);



DROP TABLE if EXISTS Futter;
CREATE TABLE Futter (
	Futternummer	INTEGER NOT NULL UNIQUE,
	Futterartnummer	INTEGER,
	Lagerbestand	REAL,
	Meldebestand	REAL,
	Futterbezeichnung	TEXT(250),
	Preis	REAL,
	Bestandseinheit	TEXT(10),
	PRIMARY KEY(Futternummer AUTOINCREMENT),
	FOREIGN KEY (Futterartnummer) REFERENCES Futterart	
);



DROP TABLE if EXISTS Futterlieferant;
CREATE TABLE Futterlieferant (
	Futterlieferantnummer	INTEGER NOT NULL UNIQUE,
	Futterartnummer	INTEGER,
	Lieferantnummer	INTEGER,
	PRIMARY KEY(Futterlieferantnummer AUTOINCREMENT),
	FOREIGN KEY (Futterartnummer) REFERENCES Futterart,
	FOREIGN KEY (Lieferantnummer) REFERENCES Lieferant		
);



DROP TABLE if EXISTS Futterart;
CREATE TABLE Futterart (
	Futterartnummer	INTEGER NOT NULL UNIQUE,
	Futterartbezeichnung	TEXT(250),
	PRIMARY KEY(Futterartnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS Lieferant;
CREATE TABLE Lieferant (
	Lieferantennummer	INTEGER NOT NULL UNIQUE,
	Vorname	TEXT(60),
	Nachname	TEXT(60),
	Anrede	TEXT(10),
	Firma   TEXT(250),
	Telefonnummer_Festnetz	INTEGER,    
	Telefonnummer_Mobil	INTEGER,       
	EMailadresse	TEXT(100),
	Strasse	TEXT(60),
	Hausnummer	TEXT(10),
	PLZ	INTEGER(10),
	Ort	TEXT(60),
	Land	TEXT(60),
	in_EU_ausserhalb_EU	NUMERIC(1),  -- Boolean   
	PRIMARY KEY(Lieferantennummer AUTOINCREMENT)	
);



DROP TABLE if EXISTS Bestellposition;
CREATE TABLE Bestellposition (
	Bestellpositionsnummer	INTEGER NOT NULL UNIQUE,
	Futternummer	INTEGER,
	Menge	INTEGER,
	Preis_pro_Einheit	REAL,  
	Waehrung	TEXT(10),
	Rabatt	REAL,
	MwSt_Satz	REAL,      
	Mengeneinheit	TEXT(10),
	PRIMARY KEY(Bestellpositionsnummer AUTOINCREMENT),
	FOREIGN KEY (Futternummer) REFERENCES Futter
);



DROP TABLE if EXISTS Lieferposition;
CREATE TABLE Lieferposition (
	Lieferpositionsnummer	INTEGER NOT NULL UNIQUE,
	Lieferantennummer	INTEGER,
	Bestellpositionsnummer	INTEGER,
	Liefermenge	REAL,
	Lieferdatum	NUMERIC,
	Liefermengeneinheit	TEXT(10),
	PRIMARY KEY(Lieferpositionsnummer AUTOINCREMENT),
	FOREIGN KEY (Lieferantennummer) REFERENCES Lieferant,
	FOREIGN KEY (Bestellpositionsnummer) REFERENCES Bestellposition	
);



DROP TABLE if EXISTS Gehege;
CREATE TABLE Gehege (
	Gehegenummer	INTEGER NOT NULL UNIQUE,
	Unterbringungstyp	TEXT(10),	
	Groesse	REAL,
	Groesseneinheit	TEXT(10),
	Gehegebezeichnung	TEXT(250),
	PRIMARY KEY(Gehegenummer AUTOINCREMENT)	
);



DROP TABLE if EXISTS Gebaeude;
CREATE TABLE Gebaeude (
	Gebaeudenummer	INTEGER NOT NULL UNIQUE,
	Gebaeudebezeichnung	TEXT(250),
	PRIMARY KEY(Gebaeudenummer AUTOINCREMENT)
);



DROP TABLE if EXISTS GehegeGebaeude;
CREATE TABLE GehegeGebaeude (
	Gehegegebaeudenummer	INTEGER NOT NULL UNIQUE,
	Gehegenummer	INTEGER,
	Gebaeudenummer	INTEGER,
	Etage	INTEGER,
	PRIMARY KEY(Gehegegebaeudenummer AUTOINCREMENT),
	FOREIGN KEY (Gehegenummer) REFERENCES Gehege,
	FOREIGN KEY (Gebaeudenummer) REFERENCES Gebaeude	
);



DROP TABLE if EXISTS Tiergehege;
CREATE TABLE Tiergehege (
	Tiergehegenummer	INTEGER NOT NULL UNIQUE,
	Gehegenummer	INTEGER,
	Tiernummer	INTEGER,
	Von   NUMERIC,
	Bis   NUMERIC,
	PRIMARY KEY(Tiergehegenummer AUTOINCREMENT),
	FOREIGN KEY (Gehegenummer) REFERENCES Gehege,
	FOREIGN KEY (Tiernummer) REFERENCES Tier	
);



DROP TABLE if EXISTS Inkompatibilitaet;
CREATE TABLE Inkompatibilitaet (
	Inkompatibilitaetsnummer	INTEGER NOT NULL UNIQUE,
	Tiernummer	INTEGER,
	Inkompatibel_zu	INTEGER,
	PRIMARY KEY(Inkompatibilitaetsnummer AUTOINCREMENT),
	FOREIGN KEY (Tiernummer) REFERENCES Tier,
	FOREIGN KEY (Inkompatibel_zu) REFERENCES Tier	
);



DROP TABLE if EXISTS Strecke;
CREATE TABLE Strecke (
	Streckennummer	INTEGER NOT NULL UNIQUE,
	Startgehege	INTEGER,
	Endgehege	INTEGER,
	Streckenname TEXT(60),
	PRIMARY KEY(Streckennummer AUTOINCREMENT),
	FOREIGN KEY (Startgehege) REFERENCES Gehege,
	FOREIGN KEY (Endgehege) REFERENCES Gehege	
);



DROP TABLE if EXISTS Rundweg;
CREATE TABLE Rundweg(
    Rundwegnummer INTEGER NOT NULL UNIQUE,
    Rundwegname 	INTEGER,
    Rundwegfarbe	INTEGER,
	Barrierefrei    NUMERIC(1),  -- Boolean
	PRIMARY KEY(Rundwegnummer AUTOINCREMENT)	
);



DROP TABLE if EXISTS RundwegStrecke;
CREATE TABLE RundwegStrecke(
    RundwegStreckennummer INTEGER NOT NULL UNIQUE,
    Rundwegnummer 	INTEGER,
    Streckennummer	INTEGER,
	FOREIGN KEY (Rundwegnummer) REFERENCES Rundweg,
	FOREIGN KEY (Streckennummer) REFERENCES Strecke,
	PRIMARY KEY(RundwegStreckennummer AUTOINCREMENT)	
);


DROP TABLE if EXISTS Tierarzt;
CREATE TABLE Tierarzt(
    Tierarztnummer INTEGER NOT NULL UNIQUE,
	Titel TEXT(60),
    Anrede 	TEXT(10),
    Vorname	TEXT(60),
	Nachname TEXT(60),
	Telefonnummer_Festnetz INTEGER,
	Telefonnummer_Mobil INTEGER,
	EMailadresse TEXT(100),
	Praxis_Name TEXT(60),
	Strasse TEXT(60),
	Ort TEXT(60),
	Hausnummer TEXT(10),
	PLZ TEXT(10),
	Land TEXT(60),
	Beschaeftigt_seit NUMERIC,
	Bemerkungen TEXT(250),
	in_EU_ausser_EU NUMERIC(1),	  -- Boolean
	PRIMARY KEY(Tierarztnummer AUTOINCREMENT)	
);



DROP TABLE if EXISTS VertretungArzt;
CREATE TABLE VertretungArzt(
    Vertretungarztnummer INTEGER NOT NULL UNIQUE,
    Tierarztnummer INTEGER,
	Vertreter INTEGER,
	von NUMERIC,
	bis NUMERIC,
	Vertretungsgrund TEXT(250),
	FOREIGN KEY (Tierarztnummer) REFERENCES Tierarzt,
	FOREIGN KEY (Vertreter) REFERENCES Tierarzt,
	PRIMARY KEY(Vertretungarztnummer AUTOINCREMENT)	
);




DROP TABLE if EXISTS Krankengeschichte;
CREATE TABLE Krankengeschichte(
    Krankengeschichtenummer INTEGER NOT NULL UNIQUE,
	Tiernummer INTEGER,
    Tierarztnummer INTEGER,
	Behandlungsgrund TEXT(250),
	Behandlungsdatumbegin NUMERIC,
	meldepflichtige_Krankheit NUMERIC(1),  --Boolean
	Befund TEXT(800),
	Medikation TEXT(250),
	Bemerkungen TEXT(250),
	Behandlungsdatumende NUMERIC,
	FOREIGN KEY (Tierarztnummer) REFERENCES Tierarzt,
	FOREIGN KEY (Tiernummer) REFERENCES Tier,
	PRIMARY KEY(Krankengeschichtenummer AUTOINCREMENT)	
);





---------------------------------------------------------------------------------------------------------
-- REFERENZTABELLEN:


DROP TABLE if EXISTS RefTab_Titel;
CREATE TABLE RefTab_Titel (
	Titelnummer	INTEGER NOT NULL UNIQUE,
	Titel	TEXT(10),
	PRIMARY KEY(Titelnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS RefTab_Nationalitaet;
CREATE TABLE RefTab_Nationalitaet (
	Nationalitaetnummer	INTEGER NOT NULL UNIQUE,
	Nationalitaet	TEXT(60),
	PRIMARY KEY(Nationalitaetnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS RefTab_Land_Herkunft;
CREATE TABLE RefTab_Land_Herkunft (
	Landnummer	INTEGER NOT NULL UNIQUE,
	Land	TEXT(60),
	PRIMARY KEY(Landnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS RefTab_Unterbringentyp;
CREATE TABLE RefTab_Unterbringentyp (
	Unterbringungnummer	INTEGER NOT NULL UNIQUE,
	Unterbringungname	TEXT(20),
	PRIMARY KEY(Unterbringungnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS RefTab_Geschlecht;
CREATE TABLE RefTab_Geschlecht (
	Geschlechtnummer INTEGER NOT NULL UNIQUE,
	Geschlecht	TEXT(20),
	PRIMARY KEY(Geschlechtnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS RefTab_Pflegetype;
CREATE TABLE RefTab_Pflegetype (
	Pflegetypnummer INTEGER NOT NULL UNIQUE,
	Pflegetype	TEXT(250),
	PRIMARY KEY(Pflegetypnummer AUTOINCREMENT)
);



DROP TABLE if EXISTS RefTab_MengeEinheit;
CREATE TABLE RefTab_MengeEinheit (
	MengeEinheitnummer INTEGER NOT NULL UNIQUE,
	Mengeneinheit	TEXT(10),
	PRIMARY KEY(MengeEinheitnummer AUTOINCREMENT)
);


DROP TABLE if EXISTS RefTab_Waehrung;
CREATE TABLE RefTab_Waehrung (
	Waehrungnummer INTEGER NOT NULL UNIQUE,
	Waehrung	TEXT(10),
	PRIMARY KEY(Waehrungnummer  AUTOINCREMENT)
);


DROP TABLE if EXISTS RefTab_Tierart;
CREATE TABLE RefTab_Tierart (
	Tierartnummer INTEGER NOT NULL UNIQUE,
	Tierartname	TEXT(60),
	PRIMARY KEY(Tierartnummer  AUTOINCREMENT)
);


DROP TABLE if EXISTS RefTab_SozialStatus;
CREATE TABLE RefTab_SozialStatus (
	SozialStatusnummer INTEGER NOT NULL UNIQUE,
	Sozialstatus	TEXT(20),
	PRIMARY KEY(SozialStatusnummer  AUTOINCREMENT)
);


DROP TABLE if EXISTS RefTab_Tiername;
CREATE TABLE RefTab_Tiername (
	Tiernummer INTEGER NOT NULL UNIQUE,
	Tiername	TEXT(60),
	PRIMARY KEY(Tiernummer  AUTOINCREMENT)
);


DROP TABLE if EXISTS RefTab_Mwst;
CREATE TABLE RefTab_Mwst (
	MwstNummer INTEGER NOT NULL UNIQUE,
	MwstSatz   Text(10),
	PRIMARY KEY(MwstNummer  AUTOINCREMENT)
);




