<!-- SQL Befhele -->

create table tbOrt(
 vaPLZ varchar(50) PRIMARY KEY,
 vaStadt varchar(50)
)


create table tbUser(
 biUserID bigint PRIMARY KEY AUTO_INCREMENT,
 vaUsername varchar(50) UNIQUE,
 vaUserRole varchar(50) NOT NULL,
 vaEmail varchar(50) UNIQUE,
 vaVorname varchar(50) NOT NULL,
 vaNachname varchar(50) NOT NULL,
 vaAdresse varchar(50) NOT NULL,
 vaPLZ varchar(50), 
 vaKlasse varchar(50),
 dGeburtsjahr date,
 
 FOREIGN KEY(vaPLZ) REFERENCES tbOrt(vaPLZ ), 
)

create table tbUeberMich(
 biUserID bigint,
 tText Text,

 FOREIGN KEY(biUserID) REFERENCES tbuser(biUserID )
)


create table tbUnternehmen(
 biUnternehmensID bigint PRIMARY KEY AUTO_INCREMENT,
 vaName varchar(50),
 vaAdresse  varchar(50),
 vaPLZ varchar(50),
 biUserID bigint, 
 FOREIGN KEY(biUserID) REFERENCES tbUser(biUserID),
 FOREIGN KEY(vaPLZ) REFERENCES tbOrt(vaPLZ)
)


create table tbAngebote(
   biAngebotesID bigint PRIMARY KEY AUTO_INCREMENT,
   biUnternehmensID bigint, FOREIGN KEY(biUnternehmensID) REFERENCES tbUnternehmen(biUnternehmensID),
   vaAngebots_Art varchar(50) NOT NULL,
   dAnfangsdatum date,
   dEnddatum date,
   iGesuchte_Bewerber int,
   iAnzahl_Bewerber int,
   iAngenommene_Bewerber int
)

create table tbUser_Bewerbungen(
         biAngebotesID bigint, FOREIGN KEY(biAngebotesID) REFERENCES tbAngebote(biAngebotesID),
	 biUserID bigint, FOREIGN KEY(biUserID) REFERENCES tbUser(biUserID),
	 dBewerbung date NOT  NULL
)

create table User_Bewertung(
         biAngebotesID bigint, FOREIGN KEY(biAngebotesID) REFERENCES tbAngebote(biAngebotesID),
	 biUserID bigint, FOREIGN KEY(biUserID) REFERENCES tbUser(biUserID),
         iPunkte int NOT NULL,
         vaText varchar(50) NOT NULL

        
)


Alter Table tbUnternehmen
ADD FOREIGN KEY(PLZ) REFERENCES tbOrt(vaPLZ)


INSERT INTO User(vaUsername,vaUserRole,vaEmail) VALUES('Test','Test','Test')

DELIMITER //
CREATE PROCEDURE DeleteUser(in Username varchar(50))
BEGIN
DELETE FROM tbuser
WHERE vaUsername = Username;
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE AddUnternehmen(in Name varchar(50),in Adresse varchar(50),in PLZ varchar(50))
BEGIN
INSERT INTO tbunternehmen(vaName,vaAdresse,vaPLZ) VALUES(Name,Adresse,PLZ);

END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE AddAngebot(in UnternehmensID bigint,in Anfangsdatum date,in Enddatum date, in Angebotsart varchar(50))
BEGIN
INSERT INTO tbangebote(biUnternehmensID , dAnfangsdatum, dEnddatum ,  vaAngebotsart) VALUES(UnternehmensID,Anfangsdatum,Enddatum,Angebotsart);
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE AddBewerbung(in AngebotsID bigint, in UserID bigint, in Bewerbung date)
BEGIN
INSERT INTO tbuser_bewerbungen(biAngebotsID, biUserID, dBewerbung) VALUES(AngebotsID,UserID,Bewerbung);
END // 
DELIMITER //
DELIMITER //
CREATE PROCEDURE AddBewertung(in UnternehmensID bigint, in UserID bigint, in Punkte int,in Texxt varchar(50))
BEGIN
INSERT INTO tbuser_bewertung(biUnternehmensID, biUserID, iPunkte, vaText) VALUES(UnternehmensID, UserID, Punkte, Texxt);
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE UpdateAngebotsBewerber(in AngebotsID bigint, in Anzahl int)
BEGIN
UPDATE tbangebote
SET iAnzahl_Bewerber = Anzahl
WHERE biAngebotsID = AngebotsID;

END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE UpdateAngebotsAngenommende(in AngebotsID bigint, in Anzahl int)
BEGIN
UPDATE tbangebote
SET iAngenommende_Bewerber = Anzahl
WHERE biAngebotsID = AngebotsID;

END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE GetAllUser()
BEGIN
SELECT * FROM tbuser;
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE GetAllUnternehmen()
BEGIN
SELECT * FROM tbunternehmen;
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE GetUnternehmen(in Name varchar(50))
BEGIN
SELECT * FROM tbunternehmen
WHERE vaName = Name;
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE GetAngebote(in Name varchar(50))
BEGIN
SELECT * FROM tbangebote
WHERE biUnternmensID = (SELECT biUnternmensID WHERE vaName = Name);
END // 
DELIMITER //

DELIMITER //
CREATE PROCEDURE GetAngeboteArt(in Art varchar(50))
BEGIN
SELECT * FROM tbangebote
WHERE vaAngebots_Art =Art;
END // 
DELIMITER //





DELIMITER //
CREATE PROCEDURE AddUeberMich(in UserId bigint, in Texxt Text)
BEGIN
INSERT INTO 

END // 
DELIMITER //



DELIMITER //
CREATE PROCEDURE DeleteAngebot(in ID bigint)
BEGIN
DELETE FROM tbAngebote
WHERE  biAngebotsID= ID;
END // 
DELIMITER //
