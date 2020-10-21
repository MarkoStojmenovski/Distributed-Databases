create database Karavan_4193

use Karavan_4193

CREATE TABLE KADMINISTRATOR (
Id_admin numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
username nvarchar (50) NULL,
password nvarchar(50) NULL,
ime nvarchar(50) NULL,
telefon nvarchar(50) NULL,
)

CREATE TABLE JAZIK (
id_jazik numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
jazik nvarchar(50) NULL,
)

CREATE TABLE KNOVOST (
id_novost numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
adm_id_adminn numeric(18, 0) NULL FOREIGN KEY REFERENCES KADMINISTRATOR(id_admin),
jazik_id_jazikn numeric(18, 0) NULL FOREIGN KEY REFERENCES JAZIK(id_jazik),
naslov nvarchar(50) NULL,
opis nvarchar(1500) NULL,
datum_od datetime NULL,
datum_do datetime NULL,
)

CREATE TABLE KDOKUMENT (
id_dokument numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
naslov nvarchar (50) NULL,
jazik_id_jazikd numeric(18, 0) NULL FOREIGN KEY REFERENCES JAZIK(id_jazik),
dokument nvarchar (50) NULL,
prikaz numeric(18, 0) NULL,
)

CREATE TABLE EMAIL (
id_posetitel numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
ime nvarchar(50) NULL,
mail nvarchar(50) NULL,
)

CREATE TABLE EMAIL_GRUPA (
ID_GRUPA numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
JAZIK_ID_JAZIKM numeric(18, 0) NULL FOREIGN KEY REFERENCES JAZIK(id_jazik),
NAZIV nvarchar(50) NULL,
aktivna numeric(18, 0) NULL,
)

CREATE TABLE EMAIL_PORAKA (
ID_PORAKA numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
GRUPA_ID_GRUPA numeric(18, 0) NULL FOREIGN KEY REFERENCES EMAIL_GRUPA(ID_GRUPA),
DATUM datetime NULL,
NASLOV nvarchar(50) NULL,
TEKST nvarchar(500) NULL,
)

CREATE TABLE MAILING (
EMAIL_ID_POSETITEL numeric(18, 0) NULL FOREIGN KEY REFERENCES EMAIL(id_posetitel),
EMAIL_ID_GRUPA numeric(18, 0) NULL FOREIGN KEY REFERENCES EMAIL_GRUPA(ID_GRUPA),
)

CREATE TABLE GALERIJA (
Id_galerija numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
preview numeric(18, 0) NULL,
)

CREATE TABLE GALERIJA_OPIS (
gal_id_galerija numeric(18, 0) NULL FOREIGN KEY REFERENCES GALERIJA(Id_galerija),
jazik_id_jazikg numeric(18, 0) NULL FOREIGN KEY REFERENCES JAZIK(id_jazik),
naslov nvarchar(50) NULL,
opis nvarchar(500) NULL,
)

CREATE TABLE GALERIJA_SLIKA (
id_slika numeric(18, 0) IDENTITY NOT NULL PRIMARY KEY,
gal_id_galerijas numeric(18, 0) NULL FOREIGN KEY REFERENCES GALERIJA(Id_galerija),
opisslika nvarchar(300) NULL,
slika nvarchar(50) NULL,
OPISSLIKAENG nvarchar(300) NULL,
)