/*
Created: 23/11/2022
Modified: 04/12/2022
Project: Filharmonia
Model: Filharmonia
Company: Telekomunnikacja, WEITI, Politechnika Warszawska
Author: Wojciech Polak, Mikołaj Jankowski
Version: 1.0.
Database: Oracle 19c
*/


-- Create tables section -------------------------------------------------

-- Table Filharmonie

CREATE TABLE Filharmonie(
  Nr_flilharmoni Integer NOT NULL,
  Nazwa Varchar2(40 ) NOT NULL,
  Data_zalozenia Date NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Filharmonie

CREATE INDEX IX_Relationship2a ON Filharmonie (Nr_adresu)
/

-- Add keys for table Filharmonie

ALTER TABLE Filharmonie ADD CONSTRAINT FilharminiaPK PRIMARY KEY (Nr_flilharmoni)
/

-- Table Muzycy

CREATE TABLE Muzycy(
  Nr_Pracownika Integer NOT NULL,
  Wyksztalcenie Varchar2(400 ) NOT NULL
)
/

-- Add keys for table Muzycy

ALTER TABLE Muzycy ADD CONSTRAINT Unique_Identifier2 PRIMARY KEY (Nr_Pracownika)
/

-- Table Dyrygenci

CREATE TABLE Dyrygenci(
  Nr_Pracownika Integer NOT NULL,
  Doswiadczenie Varchar2(400 ) NOT NULL
)
/

-- Add keys for table Dyrygenci

ALTER TABLE Dyrygenci ADD CONSTRAINT DyrygentPK PRIMARY KEY (Nr_Pracownika)
/

-- Table Instrumenty

CREATE TABLE Instrumenty(
  Numer_instrumentu Integer NOT NULL,
  Nazwa Varchar2(40 ) NOT NULL,
  Data_zakupu Date NOT NULL,
  Wartosc Number(10,2),
  Nr_modelu Integer NOT NULL
)
/

-- Create indexes for table Instrumenty

CREATE INDEX IX_Relationship5 ON Instrumenty (Nr_modelu)
/

-- Add keys for table Instrumenty

ALTER TABLE Instrumenty ADD CONSTRAINT IstrumnetPK PRIMARY KEY (Numer_instrumentu)
/

-- Table Sale

CREATE TABLE Sale(
  Nr_sali Integer NOT NULL,
  Ilosc_miejsc Integer NOT NULL,
  Rodzaj_sali VarChar(11) CHECK (RODZAJ_SALI IN ('SYMFONICZNA','KAMERALNA')) NOT NULL,
  Nazwa Varchar2(40),
  Nr_flilharmoni Integer NOT NULL
)
/

-- Create indexes for table Sale

CREATE INDEX IX_posiada_sale ON Sale (Nr_flilharmoni)
/

-- Add keys for table Sale

ALTER TABLE Sale ADD CONSTRAINT SalaPK PRIMARY KEY (Nr_sali)
/

-- Table Klienci

CREATE TABLE Klienci(
  Nr_klienta Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Data_urodzenia Date,
  PESEL Char(11 ),
  Plec Char(256) CHECK (PLEC IN ('M','K')),
  Adres Varchar2(400 ),
  Email Varchar2(30 ),
  Nr_telefonu Varchar2(15 ),
  Nr_flilharmoni Integer NOT NULL
)
/

-- Create indexes for table Klienci

CREATE INDEX IX_Posiada_klienta ON Klienci (Nr_flilharmoni)
/

-- Add keys for table Klienci

ALTER TABLE Klienci ADD CONSTRAINT KlientPK PRIMARY KEY (Nr_klienta)
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  Nr_Pracownika Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Data_Urodzenia Date NOT NULL,
  PESEL Char(11 ),
  Plec Char(256 ) CHECK (PLEC IN ('M','K')) NOT NULL,
  Data_zatrudnienia Date NOT NULL,
  Nr_konta Char(26 ),
  Email Varchar2(30 ),
  Nr_telefonu Varchar2(15 ),
  Nr_flilharmoni Integer NOT NULL,
  Nr_adresu Integer NOT NULL,
  Nr_Stanowiska Integer NOT NULL
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_Zatrudnia ON Pracownicy (Nr_flilharmoni)
/

CREATE INDEX IX_Relationship3 ON Pracownicy (Nr_adresu)
/

CREATE INDEX IX_Relationship6 ON Pracownicy (Nr_Stanowiska)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT PracownikPK PRIMARY KEY (Nr_Pracownika)
/

-- Table Koncerty

CREATE TABLE Koncerty(
  Nr_Koncertu Integer NOT NULL,
  Opis Varchar2(1200 ) NOT NULL,
  Nazwa Varchar2(20 ) NOT NULL,
  Rodzaj_muzyki Varchar2(17 ) CHECK (RODZAJ_MUZYKI IN ('KLASYCZNA','FILMOWA','KONCERT PIANISTYCZNY','LUDOWA')) NOT NULL,
  Nr_flilharmoni Integer NOT NULL
)
/

-- Create indexes for table Koncerty

CREATE INDEX IX_oferuje ON Koncerty (Nr_flilharmoni)
/

-- Add keys for table Koncerty

ALTER TABLE Koncerty ADD CONSTRAINT KoncertPK PRIMARY KEY (Nr_Koncertu)
/

-- Table Wypozyczenia

CREATE TABLE Wypozyczenia(
  Numer_instrumentu Integer NOT NULL,
  Nr_Pracownika Integer NOT NULL
)
/

-- Table Wykorzystanie_instrumentu

CREATE TABLE Wykorzystanie_instrumentu(
  Numer_instrumentu Integer NOT NULL,
  Nr_realizacji Integer NOT NULL
)
/

-- Table Obsady

CREATE TABLE Obsady(
  Nr_Pracownika Integer NOT NULL,
  Nr_realizacji Integer NOT NULL
)
/

-- Table Realizacje

CREATE TABLE Realizacje(
  Nr_realizacji Integer NOT NULL,
  Data Date NOT NULL,
  Nr_sali Integer NOT NULL,
  Nr_Koncertu Integer NOT NULL,
  Nr_Pracownika Integer NOT NULL
)
/

-- Create indexes for table Realizacje

CREATE INDEX IX_odbywa_sie_na_Koncert ON Realizacje (Nr_Koncertu)
/

CREATE INDEX IX_odbywa_sie_na_Sala ON Realizacje (Nr_sali)
/

CREATE INDEX IX_Relationship5a ON Realizacje (Nr_Pracownika)
/

-- Table Bilety

CREATE TABLE Bilety(
  Nr_biletu Integer NOT NULL,
  Data_zakupu Date NOT NULL,
  Cena Number(10,2) NOT NULL,
  Rodzaj_biletu Varchar2(8 ) CHECK (RODZAJ_BILETU IN ('NOMRALNY','ULGOWY','GRUPOWY')) NOT NULL,
  Nr_realizacji Integer NOT NULL,
  Nr_klienta Integer NOT NULL
)
/

-- Create indexes for table Bilety

CREATE INDEX IX_Relationship3a ON Bilety (Nr_realizacji)
/

CREATE INDEX IX_Klient_kupuje_bilet ON Bilety (Nr_klienta)
/

-- Table Adresy

CREATE TABLE Adresy(
  Nr_adresu Integer NOT NULL,
  Kraj Varchar2(20 ) NOT NULL,
  Miasto Varchar2(20 ) NOT NULL,
  Ulica Varchar2(30 ) NOT NULL,
  Nr_budynku Varchar2(4 ) NOT NULL,
  Nr_lokalu Varchar2(4 ) NOT NULL,
  Nr_poczty Integer
)
/

-- Create indexes for table Adresy

CREATE INDEX IX_Relationship2 ON Adresy (Nr_poczty)
/

-- Add keys for table Adresy

ALTER TABLE Adresy ADD CONSTRAINT AdresyPK PRIMARY KEY (Nr_adresu)
/

-- Table Modele

CREATE TABLE Modele(
  Nr_modelu Integer NOT NULL,
  Kod_modelu Varchar2(15 ) NOT NULL,
  Data_produkcji Date NOT NULL,
  Nr_marki Integer NOT NULL
)
/

-- Create indexes for table Modele

CREATE INDEX IX_Relationship4 ON Modele (Nr_marki)
/

-- Add keys for table Modele

ALTER TABLE Modele ADD CONSTRAINT PK_Modele PRIMARY KEY (Nr_modelu)
/

ALTER TABLE Modele ADD CONSTRAINT Kod_modelu UNIQUE (Kod_modelu)
/

-- Table Marki

CREATE TABLE Marki(
  Nr_marki Integer NOT NULL,
  Nazwa_marki Varchar2(15 ) NOT NULL
)
/

-- Add keys for table Marki

ALTER TABLE Marki ADD CONSTRAINT PK_Marki PRIMARY KEY (Nr_marki)
/

ALTER TABLE Marki ADD CONSTRAINT Nazwa_marki UNIQUE (Nazwa_marki)
/

-- Table Stanowiska

CREATE TABLE Stanowiska(
  Nr_Stanowiska Integer NOT NULL,
  Nazwa Varchar2(20 ) NOT NULL,
  Opis Varchar2(400 ) NOT NULL
)
/

-- Add keys for table Stanowiska

ALTER TABLE Stanowiska ADD CONSTRAINT PK_Stanowiska PRIMARY KEY (Nr_Stanowiska)
/

ALTER TABLE Stanowiska ADD CONSTRAINT Nazwa UNIQUE (Nazwa)
/

-- Table Poczty

CREATE TABLE Poczty(
  Nr_poczty Integer NOT NULL,
  Kod_poczty Char(6 ) NOT NULL,
  Poczta Varchar2(30 ) NOT NULL
)
/

-- Add keys for table Poczty

ALTER TABLE Poczty ADD CONSTRAINT PK_Poczty PRIMARY KEY (Nr_poczty)
/

-- Table Dyrektorzy

CREATE TABLE Dyrektorzy(
  Nr_dyrektora Integer NOT NULL,
  Data_od Date NOT NULL,
  Data_do Date,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Nr_flilharmoni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Dyrektorzy

CREATE INDEX IX_Relationship1 ON Dyrektorzy (Nr_flilharmoni)
/

CREATE INDEX IX_Relationship10 ON Dyrektorzy (Nr_adresu)
/

-- Add keys for table Dyrektorzy

ALTER TABLE Dyrektorzy ADD CONSTRAINT PK_Dyrektorzy PRIMARY KEY (Nr_dyrektora,Data_od)
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Sale ADD CONSTRAINT posiada_sale FOREIGN KEY (Nr_flilharmoni) REFERENCES Filharmonie (Nr_flilharmoni)
/



ALTER TABLE Klienci ADD CONSTRAINT Posiada_klienta FOREIGN KEY (Nr_flilharmoni) REFERENCES Filharmonie (Nr_flilharmoni)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Zatrudnia FOREIGN KEY (Nr_flilharmoni) REFERENCES Filharmonie (Nr_flilharmoni)
/



ALTER TABLE Koncerty ADD CONSTRAINT oferuje FOREIGN KEY (Nr_flilharmoni) REFERENCES Filharmonie (Nr_flilharmoni)
/



ALTER TABLE Filharmonie ADD CONSTRAINT Filharmonia_posiada_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_posiada_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Modele ADD CONSTRAINT Marka_ma_model FOREIGN KEY (Nr_marki) REFERENCES Marki (Nr_marki)
/



ALTER TABLE Instrumenty ADD CONSTRAINT Instrument_jest_modelu FOREIGN KEY (Nr_modelu) REFERENCES Modele (Nr_modelu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_ma_stanowisko FOREIGN KEY (Nr_Stanowiska) REFERENCES Stanowiska (Nr_Stanowiska)
/



ALTER TABLE Adresy ADD CONSTRAINT Adres_ma_poczte FOREIGN KEY (Nr_poczty) REFERENCES Poczty (Nr_poczty)
/



ALTER TABLE Dyrektorzy ADD CONSTRAINT Zarzadza_filharmonia FOREIGN KEY (Nr_flilharmoni) REFERENCES Filharmonie (Nr_flilharmoni)
/



ALTER TABLE Dyrektorzy ADD CONSTRAINT Dyrektor_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Bilety ADD CONSTRAINT Bilet_dotyczy FOREIGN KEY (Nr_realizacji) REFERENCES Realizacje (Nr_realizacji)
/



ALTER TABLE Realizacje ADD CONSTRAINT Dyryguje FOREIGN KEY (Nr_Pracownika) REFERENCES Dyrygenci (Nr_Pracownika)
/



ALTER TABLE Wykorzystanie_instrumentu ADD CONSTRAINT Realizacja_korzysta FOREIGN KEY (Nr_realizacji) REFERENCES Realizacje (Nr_realizacji)
/



ALTER TABLE Obsady ADD CONSTRAINT Pracownik_bierze_udzial FOREIGN KEY (Nr_realizacji) REFERENCES Realizacje (Nr_realizacji)
/





