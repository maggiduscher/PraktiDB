-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 07. Apr 2018 um 17:19
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `praktidb`
--
CREATE DATABASE IF NOT EXISTS `praktidb` DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci;
USE `praktidb`;

DELIMITER $$
--
-- Prozeduren
--
DROP PROCEDURE IF EXISTS `AddAngebot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAngebot` (IN `UnternehmensID` BIGINT, IN `Anfangsdatum` DATE, IN `Enddatum` DATE, IN `Angebotsart` VARCHAR(50), IN `Gesucht` INT)  BEGIN
INSERT INTO tbangebote(biUnternehmensID,dAnfangsdatum, dEnddatum,vaAngebots_Art,iGesuchte_Bewerber,iAnzahl_Bewerber,iAngenommene_Bewerber) VALUES(UnternehmensID,Anfangsdatum,Enddatum,Angebotsart,Gesucht,0,0);
END$$

DROP PROCEDURE IF EXISTS `AddAngenommene`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAngenommene` (IN `UserID` BIGINT, IN `AngebotsID` BIGINT)  NO SQL
BEGIN
 INSERT INTO tbangenommene VALUES(UserID,AngebotsID);
END$$

DROP PROCEDURE IF EXISTS `AddBewerbung`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBewerbung` (IN `AngebotsID` BIGINT, IN `UserID` BIGINT, IN `Bewerbung` DATE)  BEGIN
INSERT INTO tbuser_bewerbungen(biAngebotsID, biUserID, dBewerbung) VALUES(AngebotsID,UserID,Bewerbung);
END$$

DROP PROCEDURE IF EXISTS `AddBewertung`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBewertung` (IN `UnternehmensID` BIGINT, IN `UserID` BIGINT, IN `Punkte` INT, IN `Texxt` VARCHAR(50))  BEGIN
INSERT INTO tbuser_bewertung(biUnternehmensID, biUserID, iPunkte, vaText) VALUES(UnternehmensID, UserID, Punkte, Texxt);
END$$

DROP PROCEDURE IF EXISTS `AddOrt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddOrt` (IN `PLZ` VARCHAR(50), IN `Stadt` VARCHAR(50))  BEGIN INSERT INTO tbort(vaPLZ,vaStadt)
 VALUES(PLZ,Stadt);
 END$$

DROP PROCEDURE IF EXISTS `AddUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUnternehmen` (IN `Name` VARCHAR(50), IN `Adresse` VARCHAR(50), IN `PLZ` VARCHAR(50), IN `Branche` VARCHAR(50), IN `Email` VARCHAR(50), IN `Telefonnummer` VARCHAR(50), IN `Weblinke` VARCHAR(255), IN `Texxt` TEXT)  BEGIN
INSERT INTO tbunternehmen(vaName,vaAdresse,vaPLZ,vaBranche,vaEmail,vaTelefonnummer
                          ,vaWeblinke, tText) VALUES(Name,Adresse,PLZ,Branche,Email,Telefonnummer,Weblinke,Texxt);

END$$

DROP PROCEDURE IF EXISTS `AddUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser` (IN `Geburtsjahr` DATE, IN `Adresse` VARCHAR(50), IN `EMail` VARCHAR(50), IN `Klasse` VARCHAR(50), IN `Nachname` VARCHAR(50), IN `Passwort` VARCHAR(256), IN `PLZ` VARCHAR(50), IN `Username` VARCHAR(50), IN `UserRole` VARCHAR(50), IN `Vorname` VARCHAR(50))  BEGIN
INSERT INTO tbuser(dGeburtsjahr,vaAdresse,vaEmail,vaKlasse,vaNachname,vaPasswort,vaPLZ,vaUsername,vaUserRole,vaVorname)VALUES(Geburtsjahr,Adresse, EMail, Klasse, Nachname ,  Passwort ,  PLZ ,  Username ,  UserRole ,  Vorname );
END$$

DROP PROCEDURE IF EXISTS `CheckEmail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckEmail` (IN `EMail` VARCHAR(50))  NO SQL
BEGIN
 SELECT u.vaEmail FROM tbuser u
 WHERE u.vaEmail LIKE EMail;
END$$

DROP PROCEDURE IF EXISTS `CheckUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckUser` (IN `Username` VARCHAR(50), IN `Passwort` VARCHAR(256))  BEGIN
   
   SELECT u.vaUserRole,u.biUserID,o.vaStadt FROM tbuser u JOIN
   tbort o
   ON(u.vaPLZ = o.vaPLZ)
   WHERE (u.vaUsername = Username or 
          u.vaEMail = Username)
          AND u.vaPasswort = Passwort;

END$$

DROP PROCEDURE IF EXISTS `DeleteAngebot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAngebot` (IN `ID` BIGINT)  BEGIN
DELETE FROM tbAngebote
WHERE  biAngebotsID= ID;
END$$

DROP PROCEDURE IF EXISTS `DeleteAngenommene`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAngenommene` (IN `UserID` BIGINT)  NO SQL
BEGIN
 DELETE FROM tbangenommene WHERE biUserID = UserID;
END$$

DROP PROCEDURE IF EXISTS `DeleteOrt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrt` (IN `PLZ` VARCHAR(50))  NO SQL
BEGIN
DELETE FROM tbOrt
WHERE vaPLZ = PLZ;
END$$

DROP PROCEDURE IF EXISTS `DeleteUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUnternehmen` (IN `ID` BIGINT)  BEGIN
DELETE FROM tbUnternehmen
WHERE  biUnternehmensID = ID;
END$$

DROP PROCEDURE IF EXISTS `DeleteUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser` (IN `ID` BIGINT)  BEGIN
DELETE FROM tbuser
WHERE biUserID = ID;
END$$

DROP PROCEDURE IF EXISTS `GetAllAngebote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllAngebote` ()  BEGIN
SELECT a.*, u.*,o.vaStadt FROM tbangebote a 
JOIN tbUnternehmen u 
ON(a.biUnternehmensID = u.biUnternehmensID )
JOIN tbort o 
ON(u.vaPLZ = o.vaPLZ);
END$$

DROP PROCEDURE IF EXISTS `GetAllAngeboteArt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllAngeboteArt` ()  NO SQL
BEGIN
SELECT DISTINCT (vaAngebots_Art) FROM tbangebote;
END$$

DROP PROCEDURE IF EXISTS `GetAllAngenommene`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllAngenommene` ()  NO SQL
BEGIN
 SELECT us.vaUsername, un.vaName, us.biUserID 
 FROM tbuser us JOIN tbangenommene an 
 ON(us.biUserID = an.biUserID)
 JOIN tbangebote ang
 ON(ang.biAngebotsID = an.biAngebotsID)
 JOIN tbunternehmen un 
 ON(un.biUnternehmensID = ang.biUnternehmensID)
 WHERE us.vaUserRole LIKE 'student';
END$$

DROP PROCEDURE IF EXISTS `GetAllBesuchteStellen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllBesuchteStellen` ()  NO SQL
BEGIN
 SELECT us.vaUsername, un.vaName, us.biUserID
 FROM tbuser us JOIN tbangenommene an 
 ON(us.biUserID = an.biUserID)
 JOIN tbangebote ang
 ON(ang.biAngebotsID = an.biAngebotsID)
 JOIN tbunternehmen un 
 ON(un.biUnternehmensID = ang.biUnternehmensID)
 WHERE us.vaUserRole NOT LIKE 'student';
END$$

DROP PROCEDURE IF EXISTS `GetAllDeactivatedUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDeactivatedUnternehmen` ()  NO SQL
BEGIN
 SELECT * FROM tbunternehmen
 WHERE vaName LIKE '%deactivated%';
END$$

DROP PROCEDURE IF EXISTS `GetAllDeactivatedUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDeactivatedUser` ()  NO SQL
BEGIN
 SELECT * FROM tbuser
 WHERE vaUserRole LIKE '%deactivated%';
END$$

DROP PROCEDURE IF EXISTS `GetAllKlassen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllKlassen` ()  NO SQL
SELECT DISTINCT vaKlasse 
FROM tbuser$$

DROP PROCEDURE IF EXISTS `GetAllNichtAngenommende`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllNichtAngenommende` ()  NO SQL
BEGIN
 SELECT u.vaUsername,u.biUserID FROM tbuser u
 WHERE biUserID NOT IN(
     SELECT biUserID FROM tbangenommene
 ) 
 AND  u.vaUserRole LIKE 'student';
 END$$

DROP PROCEDURE IF EXISTS `GetAllNichtAngenommene`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllNichtAngenommene` ()  NO SQL
BEGIN
 SELECT u.biUserID,u.vaUsername FROM tbuser u
 WHERE biUserID NOT IN (
     SELECT biUserID FROM tbangenommene
 )
 AND  u.vaUserRole NOT LIKE 'student';
END$$

DROP PROCEDURE IF EXISTS `GetAllNichtBesuchteLehrer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllNichtBesuchteLehrer` ()  NO SQL
BEGIN
 SELECT u.biUserID,u.vaUsername FROM tbuser u
 WHERE biUserID NOT IN (
     SELECT biUserID FROM tbangenommene
 )
 AND  u.vaUserRole NOT LIKE 'student';
END$$

DROP PROCEDURE IF EXISTS `GetAllNichtBesuchteStellen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllNichtBesuchteStellen` ()  NO SQL
BEGIN
 SELECT u.vaName
 FROM tbunternehmen u
 WHERE u.biUnternehmensID NOT IN(
     SELECT un.biUnternehmensID
     FROM tbuser us JOIN tbangenommene an 
     ON(an.biUserID = us.biUserID)
     JOIN tbangebote ang
     ON(an.biAngebotsID = ang.biAngebotsID)
     JOIN tbunternehmen un 
     ON(ang.biUnternehmensID = un.biUnternehmensID)
     WHERE us.vaUserRole NOT LIKE 'student'
 );
END$$

DROP PROCEDURE IF EXISTS `GetAllOrt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllOrt` ()  NO SQL
BEGIN
 SELECT * FROM tbort;
END$$

DROP PROCEDURE IF EXISTS `GetAllUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUnternehmen` ()  BEGIN
SELECT u.*,o.vaStadt FROM tbunternehmen u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ)
WHERE u.vaName NOT LIKE '%deactivated%';
END$$

DROP PROCEDURE IF EXISTS `GetAllUnternehmenMitAngebot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUnternehmenMitAngebot` ()  NO SQL
BEGIN
SELECT * FROM tbunternehmen
JOIN tbangebote
USING (biUnternehmensID);
END$$

DROP PROCEDURE IF EXISTS `GetAllUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUser` ()  BEGIN
SELECT u.*,o.vaStadt FROM tbuser u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ);
END$$

DROP PROCEDURE IF EXISTS `GetAngebote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAngebote` (IN `Name` VARCHAR(50))  BEGIN
SELECT * FROM tbangebote
WHERE biUnternehmensID = (SELECT biUnternehmensID FROM tbunternehmen WHERE vaName = Name);
END$$

DROP PROCEDURE IF EXISTS `GetAngeboteArt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAngeboteArt` (IN `Art` VARCHAR(50))  BEGIN
SELECT * FROM tbangebote
WHERE vaAngebots_Art =Art;
END$$

DROP PROCEDURE IF EXISTS `GetBewertung`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBewertung` (IN `UserID` BIGINT, IN `UnternehmensID` INT)  NO SQL
BEGIN
 SELECT * FROM tbuser_bewertung
 WHERE biUserID = UserID
 AND biUnternehmensID = UnternehmensID;
END$$

DROP PROCEDURE IF EXISTS `GetBewertungenUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBewertungenUnternehmen` (IN `ID` BIGINT)  NO SQL
BEGIN
SELECT be.*,b.*,u.* FROM tbuser_bewertung be JOIN tbunternehmen b
ON(b.biUnternehmensID = be.biUnternehmensID)
JOIN tbUser u
ON(u.biUserID = be.biUserID);
END$$

DROP PROCEDURE IF EXISTS `GetBewertungUnternehmenFromUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBewertungUnternehmenFromUser` (IN `ID` BIGINT)  NO SQL
BEGIN
 SELECT b.*, u.vaUsername FROM tbuser_bewertung b
 JOIN tbUser u
 ON(u.biUserID = b.biUserID)
 WHERE biUnternehmensID = ID;
END$$

DROP PROCEDURE IF EXISTS `GetKlasse`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetKlasse` (IN `Klasse` VARCHAR(50))  BEGIN
SELECT * FROM tbuser
WHERE vaKlasse = Klasse;
END$$

DROP PROCEDURE IF EXISTS `GetLetzteBewerbung`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLetzteBewerbung` (IN `UserID` BIGINT)  NO SQL
BEGIN
SELECT MAX(dBewerbung) FROM tbuser_bewerbungen
WHERE biUserID = UserID;
END$$

DROP PROCEDURE IF EXISTS `GetMittelwertBewertung`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMittelwertBewertung` (IN `ID` BIGINT)  NO SQL
BEGIN
 SELECT AVG(iPunkte) FROM tbuser_bewertung
 WHERE biUnternehmensID = ID;

END$$

DROP PROCEDURE IF EXISTS `GetStadt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStadt` (IN `PLZ` VARCHAR(50))  NO SQL
BEGIN
SELECT * FROM tbort
 WHERE vaPLZ = PLZ;
END$$

DROP PROCEDURE IF EXISTS `GetTeacherForCumpany`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherForCumpany` ()  NO SQL
BEGIN
 SELECT us.vaUsername, un.vaName 
 FROM tbuser us JOIN tbangenommene an 
 ON(us.biUserID = an.biUserID)
 JOIN tbangebote ang
 ON(ang.biAngebotsID = an.biAngebotsID)
 JOIN tbunternehmen un 
 ON(un.biUnternehmensID = ang.biUnternehmensID)
 WHERE us.vaUserRole NOT LIKE 'student';
END$$

DROP PROCEDURE IF EXISTS `GetUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUnternehmen` (IN `ID` BIGINT(50))  BEGIN
SELECT u.*,o.vaStadt FROM tbunternehmen u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ)
WHERE biUnternehmensID = ID;
END$$

DROP PROCEDURE IF EXISTS `GetUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUser` (IN `UserID` BIGINT(50))  BEGIN
SELECT u.*, o.vaStadt FROM tbuser u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ)
WHERE biUserID = UserID;
END$$

DROP PROCEDURE IF EXISTS `UpdateAngebotsAngenommende`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAngebotsAngenommende` (IN `AngebotsID` BIGINT, IN `Anzahl` INT)  BEGIN
UPDATE tbangebote
SET iAngenommene_Bewerber = Anzahl
WHERE biAngebotsID = AngebotsID;

END$$

DROP PROCEDURE IF EXISTS `UpdateAngebotsBewerber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAngebotsBewerber` (IN `AngebotsID` BIGINT, IN `Anzahl` INT)  BEGIN
UPDATE tbangebote
SET iAnzahl_Bewerber = Anzahl
WHERE biAngebotsID = AngebotsID;

END$$

DROP PROCEDURE IF EXISTS `UpdatePasswort`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePasswort` (IN `Passwort` VARCHAR(256), IN `ID` BIGINT)  NO SQL
BEGIN
UPDATE tbuser
SET vaPasswort = Passwort
WHERE biUserID = ID;
END$$

DROP PROCEDURE IF EXISTS `UpdateRoleUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateRoleUser` (IN `ID` BIGINT, IN `Role` VARCHAR(50))  NO SQL
BEGIN
 
 UPDATE tbuser
 SET vaUserRole = Role
 WHERE biUserID = ID;

END$$

DROP PROCEDURE IF EXISTS `UpdateStatusUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStatusUnternehmen` (IN `ID` BIGINT, IN `Name` VARCHAR(50))  NO SQL
BEGIN
 UPDATE tbunternehmen
 SET vaName = SUBSTRING(vaName,12)
 WHERE biUnternehmensID = ID;
END$$

DROP PROCEDURE IF EXISTS `UpdateText`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateText` (IN `UserID` BIGINT, IN `Texxt` TEXT)  NO SQL
BEGIN
UPDATE tbuser
SET tText = TexxT
WHERE biUserID = UserID;
END$$

DROP PROCEDURE IF EXISTS `UpdateUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUnternehmen` (IN `ID` BIGINT, IN `Texxt` TEXT, IN `Adresse` VARCHAR(50), IN `Branche` VARCHAR(50), IN `EMail` VARCHAR(50), IN `PLZ` VARCHAR(50), IN `Name` VARCHAR(50))  NO SQL
BEGIN
UPDATE tbunternehmen
SET tText = Texxt, vaAdresse = Adresse,
    vaBranche = Branche, vaEMail = EMail,
    vaPLZ = PLZ, vaName = Name
WHERE biUnternehmensID = ID;
END$$

DROP PROCEDURE IF EXISTS `UpdateUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser` (IN `Geburtsjahr` DATE, IN `Texxt` TEXT, IN `Adresse` VARCHAR(50), IN `Email` VARCHAR(50), IN `Klasse` VARCHAR(50), IN `Nachname` VARCHAR(50), IN `PLZ` VARCHAR(50), IN `Username` VARCHAR(50), IN `UserRole` VARCHAR(50), IN `Vorname` VARCHAR(50), IN `ID` BIGINT)  NO SQL
BEGIN
UPDATE tbUser
SET dGeburtsjahr = Geburtsjahr,tText = Texxt,
    vaEmail = Email,
    vaKlasse = Klasse,vaNachname = Nachname ,
    vaPLZ = PLZ,vaUsername = Username,
    vaUserRole = UserRole, vaVorname = Vorname 
WHERE biUserID = ID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbangebote`
--

DROP TABLE IF EXISTS `tbangebote`;
CREATE TABLE IF NOT EXISTS `tbangebote` (
  `biAngebotsID` bigint(20) NOT NULL AUTO_INCREMENT,
  `biUnternehmensID` bigint(20) DEFAULT NULL,
  `vaAngebots_Art` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `dAnfangsdatum` date DEFAULT NULL,
  `dEnddatum` date DEFAULT NULL,
  `iGesuchte_Bewerber` int(11) DEFAULT NULL,
  `iAnzahl_Bewerber` int(11) DEFAULT NULL,
  `iAngenommene_Bewerber` int(11) DEFAULT NULL,
  PRIMARY KEY (`biAngebotsID`),
  KEY `biUnternehmensID` (`biUnternehmensID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbangebote`
--

INSERT INTO `tbangebote` (`biAngebotsID`, `biUnternehmensID`, `vaAngebots_Art`, `dAnfangsdatum`, `dEnddatum`, `iGesuchte_Bewerber`, `iAnzahl_Bewerber`, `iAngenommene_Bewerber`) VALUES(2, 1, 'IT', '2018-02-23', '2018-02-23', 5, 2, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbangenommene`
--

DROP TABLE IF EXISTS `tbangenommene`;
CREATE TABLE IF NOT EXISTS `tbangenommene` (
  `biUserID` bigint(20) NOT NULL,
  `biAngebotsID` bigint(20) NOT NULL,
  KEY `biUserID` (`biUserID`),
  KEY `biAngebotsID` (`biAngebotsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbort`
--

DROP TABLE IF EXISTS `tbort`;
CREATE TABLE IF NOT EXISTS `tbort` (
  `vaPLZ` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaStadt` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`vaPLZ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbort`
--

INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01067', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01069', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01097', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01099', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01108', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01109', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01127', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01129', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01139', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01156', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01157', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01159', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01169', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01187', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01189', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01217', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01219', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01237', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01239', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01257', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01259', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01277', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01279', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01307', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01309', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01324', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01326', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01328', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01445', ' Radebeul');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01454', ' Radeberg, Wachau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01458', ' Ottendorf-Okrilla');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01465', ' Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01468', ' Moritzburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01471', ' Radeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01477', ' Arnsdorf b. Dresden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01558', ' GroÃŸenhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01561', ' GroÃŸenhain, Ebersbach u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01587', ' Riesa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01589', ' Riesa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01591', ' Riesa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01594', ' Riesa, Stauchitz, Hirschstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01609', ' GrÃ¶ditz, WÃ¼lknitz, RÃ¶deraue');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01612', ' NÃ¼nchritz, Glaubitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01616', ' Strehla');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01619', ' Zeithain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01623', ' Lommatzsch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01640', ' Coswig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01662', ' MeiÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01665', ' KÃ¤bschÃ¼tztal, Klipphausen, Diera-Zehren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01683', ' Nossen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01689', ' WeinbÃ¶hla');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01705', ' Freital');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01723', ' Wilsdruff');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01728', ' Bannewitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01731', ' Kreischa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01734', ' Rabenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01737', ' Tharandt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01738', ' Dorfhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01744', ' Dippoldiswalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01762', ' Hartmannsdorf-Reichenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01768', ' GlashÃ¼tte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01773', ' Altenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01774', ' Klingenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01776', ' Hermsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01778', ' Altenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01796', ' Pirna, Struppen, Dohma');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01809', ' Heidenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01814', ' Bad Schandau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01816', ' Bad Gottleuba-BerggieÃŸhÃ¼bel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01819', ' Bahretal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01824', ' KÃ¶nigstein/SÃ¤chs.Schw.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01825', ' Liebstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01829', ' Wehlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01833', ' Stolpen, DÃ¼rrrÃ¶hrsdorf-Dittersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01844', ' Neustadt i. Sa.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01847', ' Lohmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01848', ' Hohnstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01855', ' Sebnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01877', ' Bischofswerda u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01896', ' Pulsnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01900', ' GroÃŸrÃ¶hrsdorf, Bretnig-Hauswalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01904', ' Neukirch/Lausitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01906', ' Burkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01909', ' GroÃŸharthau, Frankenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01917', ' Kamenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01920', ' Elstra, OÃŸling u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01936', ' KÃ¶nigsbrÃ¼ck u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01945', ' Ruhland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01968', ' Senftenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01979', ' Lauchhammer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01983', ' GroÃŸrÃ¤schen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01987', ' Schwarzheide N.L.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01990', ' Ortrand');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01993', ' Schipkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01994', ' Schipkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01996', ' Senftenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('01998', ' Schipkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02625', ' Bautzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02627', ' WeiÃŸenberg, Hochkirch u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02633', ' GÃ¶da');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02681', ' Wilthen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02689', ' Sohland a. d. Spree');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02692', ' Doberschau-GauÃŸig, GroÃŸpostwitz, Obergurig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02694', ' GroÃŸdubrau, Malschwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02699', ' KÃ¶nigswartha');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02708', ' LÃ¶bau, Kottmar u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02727', ' Ebersbach-Neugersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02730', ' Ebersbach-Neugersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02733', ' Cunewalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02736', ' Beiersdorf, Oppach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02739', ' Kottmar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02742', ' Neusalza-Spremberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02747', ' Herrnhut');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02748', ' Bernstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02763', ' Zittau u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02779', ' GroÃŸschÃ¶nau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02782', ' Seifhennersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02785', ' Olbersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02788', ' Zittau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02791', ' Oderwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02794', ' Leutersdorf, Spitzkunnersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02796', ' Jonsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02797', ' Oybin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02799', ' GroÃŸschÃ¶nau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02826', ' GÃ¶rlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02827', ' GÃ¶rlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02828', ' GÃ¶rlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02829', ' Markersdorf, NeiÃŸeaue u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02894', ' Reichenbach, Vierkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02899', ' Ostritz, SchÃ¶nau-Berzdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02906', ' Niesky, Hohendubrau u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02923', ' HÃ¤hnichen, Horka, Kodersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02929', ' Rothenburg/O.L.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02943', ' WeiÃŸwasser, Boxberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02953', ' Bad Muskau, GroÃŸ DÃ¼ben, Gablenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02956', ' Rietschen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02957', ' Krauschwitz, WeiÃŸkeiÃŸel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02959', ' Schleife');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02977', ' Hoyerswerda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02979', ' Spreetal, Elsterheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02991', ' Lauta');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02994', ' Bernsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02997', ' Wittichenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('02999', ' Lohsa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03042', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03044', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03046', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03048', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03050', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03051', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03052', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03053', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03054', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03055', ' Cottbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03058', ' Neuhausen/Spree');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03096', ' Burg/Spreewald u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03099', ' Kolkwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03103', ' Neu-Seeland, Neupetershain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03116', ' Drebkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03119', ' Welzow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03130', ' Spremberg, Tschernitz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03149', ' Forst/ Lausitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03159', ' DÃ¶bern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03172', ' Guben, SchenkendÃ¶bern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03185', ' Peitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03197', ' JÃ¤nschwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03205', ' Calau, Bronkow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03222', ' LÃ¼bbenau/ Spreewald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03226', ' Vetschau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03229', ' AltdÃ¶bern, Luckaitztal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03238', ' Finsterwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03246', ' Crinitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03249', ' Sonnewalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('03253', ' Doberlug-Kirchhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04103', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04105', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04107', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04109', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04129', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04155', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04157', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04158', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04159', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04177', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04178', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04179', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04205', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04207', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04209', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04229', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04249', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04275', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04277', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04279', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04288', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04289', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04299', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04315', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04316', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04317', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04318', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04319', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04328', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04329', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04347', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04349', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04356', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04357', ' Leipzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04416', ' Markkleeberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04420', ' MarkranstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04425', ' Taucha');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04435', ' Schkeuditz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04442', ' Zwenkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04451', ' Borsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04463', ' GroÃŸpÃ¶sna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04509', ' Delitzsch, Krostitz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04519', ' Rackwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04523', ' Pegau, Elstertrebnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04539', ' Groitzsch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04552', ' Borna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04564', ' BÃ¶hlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04565', ' Regis-Breitingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04567', ' Kitzscher');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04571', ' RÃ¶tha');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04575', ' Neukieritzsch, Deutzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04600', ' Altenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04603', ' Nobitz, GÃ¶hren, Windischleuba');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04610', ' Meuselwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04613', ' Lucka');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04617', ' Rositz, Starkenberg, Treben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04618', ' Langenleuba-Niederhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04626', ' SchmÃ¶lln, Altkirchen, NÃ¶bdenitz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04639', ' GÃ¶ÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04643', ' Geithain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04651', ' Bad Lausick');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04654', ' Frohburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04668', ' Grimma');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04680', ' Colditz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04683', ' Naunhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04687', ' Trebsen/Mulde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04703', ' Leisnig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04720', ' DÃ¶beln, GroÃŸweitzschen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04736', ' Waldheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04741', ' RoÃŸwein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04746', ' Hartha');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04749', ' Ostrau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04758', ' Oschatz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04769', ' MÃ¼geln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04774', ' Dahlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04779', ' Wermsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04808', ' Wurzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04821', ' Brandis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04824', ' Brandis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04827', ' Machern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04828', ' Bennewitz, Machern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04838', ' Eilenburg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04849', ' Bad DÃ¼ben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04860', ' Torgau, Dreiheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04861', ' Torgau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04862', ' Mockrehna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04874', ' Belgern-Schildau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04880', ' Dommitzsch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04886', ' Arzberg, Beilrode');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04889', ' Belgern-Schildau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04895', ' Falkenberg/ Elster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04910', ' Elsterwerda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04916', ' Herzberg/ Elster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04924', ' Bad Liebenwerda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04928', ' Plessa, Schraden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04931', ' MÃ¼hlberg, Bad Liebenwerda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04932', ' RÃ¶derland, GroÃŸthiemig u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04934', ' Hohenleipisch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04936', ' Schlieben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('04938', ' Uebigau-WahrenbrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06108', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06110', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06112', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06114', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06116', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06118', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06120', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06122', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06124', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06126', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06128', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06130', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06132', ' Halle/ Saale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06179', ' Teutschenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06184', ' Kabelsketal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06188', ' Landsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06193', ' Petersberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06198', ' Salzatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06217', ' Merseburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06231', ' Bad DÃ¼rrenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06237', ' Leuna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06242', ' Braunsbedra');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06246', ' Bad LauchstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06249', ' MÃ¼cheln/ Geiseltal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06255', ' MÃ¼cheln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06258', ' Schkopau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06259', ' Frankleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06268', ' Querfurt, Obhausen, MÃ¼cheln u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06279', ' Schraplau, FarnstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06295', ' Eisleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06308', ' Klostermansfeld, Benndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06311', ' Helbra');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06313', ' Hergisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06317', ' Seegebiet Mansfelder Land');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06333', ' Hettstedt, Endorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06343', ' Mansfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06347', ' Gerbstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06366', ' KÃ¶then');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06369', ' SÃ¼dliches Anhalt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06385', ' Aken (Elbe)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06386', ' Aken, Osternienburger Land, SÃ¼dliches Anhalt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06388', ' SÃ¼dliches Anhalt, KÃ¶then');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06406', ' Bernburg (Saale)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06408', ' Ilberstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06420', ' KÃ¶nnern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06425', ' Alsleben/Saale, PlÃ¶tzkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06429', ' Nienburg (Saale)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06449', ' Aschersleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06456', ' Arnstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06458', ' Hedersleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06463', ' Falkenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06464', ' Seeland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06466', ' Seeland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06467', ' Seeland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06469', ' Seeland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06484', ' Quedlinburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06485', ' Quedlinburg, Ballenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06493', ' Ballenstedt, Harzgerode');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06502', ' Thale, Blankenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06526', ' Sangerhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06528', ' Wallhausen, Blankenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06536', ' SÃ¼dharz, Berga');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06537', ' Kelbra (KyffhÃ¤user)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06542', ' Allstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06543', ' Falkenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06556', ' Artern/Unstrut u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06567', ' Bad Frankenhausen/ KyffhÃ¤user');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06571', ' RoÃŸleben, Wiehe, Donndorf, Nausitz, Gehofen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06577', ' Heldrungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06578', ' Bilzingsleben Kannawurf Oldisleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06618', ' Naumburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06628', ' Lanitz-Hassel-Tal, Molauer Land');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06632', ' Freyburg, BalgstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06636', ' Laucha an der Unstrut');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06638', ' Karsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06642', ' Nebra, Kaiserpfalz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06647', ' Bad Bibra, Finne u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06648', ' Eckartsberga');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06667', ' WeiÃŸenfels, StÃ¶ÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06679', ' HohenmÃ¶lsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06682', ' Teuchern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06686', ' LÃ¼tzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06688', ' WeiÃŸenfels');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06711', ' Zeitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06712', ' Zeitz, Gutenborn u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06721', ' Meineweh, Osterfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06722', ' DroyÃŸig, Wetterzeube');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06729', ' Elsteraue');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06749', ' Bitterfeld-Wolfen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06766', ' Bitterfeld-Wolfen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06772', ' GrÃ¤fenhainichen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06773', ' GrÃ¤fenhainichen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06774', ' Muldestausee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06779', ' Raguhn-JeÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06780', ' ZÃ¶rbig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06785', ' Oranienbaum-WÃ¶rlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06792', ' Sandersdorf-Brehna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06794', ' Sandersdorf-Brehna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06796', ' Sandersdorf-Brehna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06800', ' Raguhn-JeÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06803', ' Bitterfeld-Wolfen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06808', ' Bitterfeld-Wolfen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06809', ' Roitzsch, Petersroda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06842', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06844', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06846', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06847', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06849', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06861', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06862', ' Dessau-RoÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06868', ' Coswig (Anhalt)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06869', ' Coswig (Anhalt)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06886', ' Wittenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06888', ' Wittenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06889', ' Wittenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06895', ' Zahna-Elster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06901', ' Kemberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06905', ' Bad Schmiedeberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06917', ' Jessen (Elster)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('06925', ' Annaburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07318', ' Saalfeld/Saale, Wittgendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07330', ' Probstzella');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07333', ' Unterwellenborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07334', ' Kamsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07338', ' Kaulsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07343', ' Wurzbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07349', ' Lehesten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07356', ' Lobenstein, Neundorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07366', ' Blankenstein, Blankenberg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07368', ' Remptendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07381', ' PÃ¶ÃŸneck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07387', ' KrÃ¶lpa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07389', ' Ranis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07407', ' Rudolstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07422', ' Bad Blankenburg, Saalfelder HÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07426', ' KÃ¶nigsee-Rottenbach u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07427', ' Schwarzburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07429', ' DÃ¶schnitz, Sitzendorf, Rohrbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07545', ' Gera');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07546', ' Gera');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07548', ' Gera');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07549', ' Gera');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07551', ' Gera');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07552', ' Gera');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07554', ' Brahmenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07557', ' Gera, Zedlitz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07570', ' Weida, Harth-PÃ¶llnitz, WÃ¼nschendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07580', ' Ronneburg, Braunichswalde, GroÃŸenstein u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07586', ' Bad KÃ¶stritz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07589', ' MÃ¼nchenbernsdorf, Schwarzbach, Bocka');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07607', ' Eisenberg, GÃ¶sen, Hainspitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07613', ' Crossen, Heideland u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07616', ' BÃ¼rgel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07619', ' SchkÃ¶len');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07629', ' Hermsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07639', ' Bad Klosterlausnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07646', ' Stadtroda u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07743', ' Jena');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07745', ' Jena');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07747', ' Jena');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07749', ' Jena');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07751', ' Jena, Bucha, GroÃŸpÃ¼rschÃ¼tz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07768', ' Kahla');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07774', ' Dornburg-Camburg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07778', ' NeuengÃ¶nna u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07806', ' Neustadt/ Orla');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07819', ' Triptis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07907', ' Schleiz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07919', ' Kirschkau, Pausa-MÃ¼hltroff');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07922', ' Tanna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07924', ' ZiegenrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07926', ' Gefell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07927', ' Hirschberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07929', ' Saalburg-Ebersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07937', ' Zeulenroda-Triebes, Langenwolschendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07950', ' Zeulenroda-Triebes, WeiÃŸendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07952', ' Pausa-MÃ¼hltroff');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07955', ' Auma-Weidatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07957', ' Langenwetzendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07958', ' Hohenleuben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07973', ' Greiz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07980', ' Berga/Elster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07985', ' Elsterberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('07987', ' Mohlsdorf-Teichwolframsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08056', ' Zwickau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08058', ' Zwickau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08060', ' Zwickau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08062', ' Zwickau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08064', ' Zwickau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08066', ' Zwickau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08107', ' Kirchberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08112', ' Wilkau-HaÃŸlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08115', ' Lichtentanne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08118', ' Hartenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08132', ' MÃ¼lsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08134', ' LangenweiÃŸbach, Wildenfels');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08141', ' Reinsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08144', ' Hirschfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08147', ' Crinitzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08209', ' Auerbach/Vogtl.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08223', ' Falkenstein/Vogtl.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08228', ' Rodewisch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08233', ' Treuen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08236', ' Ellefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08237', ' Steinberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08239', ' Bergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08248', ' Klingenthal/Sa.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08258', ' Markneukirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08261', ' SchÃ¶neck/Vogtl.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08262', ' Muldenhammer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08267', ' Klingenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08280', ' Aue');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08289', ' Schneeberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08294', ' LÃ¶ÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08297', ' ZwÃ¶nitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08301', ' Schlema');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08304', ' SchÃ¶nheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08309', ' Eibenstock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08315', ' Lauter-Bernsbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08321', ' Zschorlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08324', ' Bockau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08328', ' StÃ¼tzengrÃ¼n');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08340', ' Schwarzenberg/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08344', ' GrÃ¼nhain-Beierfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08349', ' Johanngeorgenstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08352', ' Raschau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08359', ' Breitenbrunn/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08371', ' Glauchau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08373', ' Remse');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08393', ' Meerane');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08396', ' Waldenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08412', ' Werdau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08427', ' Fraureuth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08428', ' Langenbernsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08451', ' Crimmitschau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08459', ' Neukirchen/PleiÃŸe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08468', ' Reichenbach/Vogtl.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08485', ' Lengenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08491', ' Netzschkau, Limbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08496', ' Neumark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08499', ' Mylau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08523', ' Plauen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08525', ' Plauen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08527', ' Plauen, RÃ¶ÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08529', ' Plauen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08538', ' Weischlitz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08539', ' Rosenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08541', ' Neuensalz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08543', ' PÃ¶hl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08547', ' JÃ¶ÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08548', ' Rosenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08606', ' Oelsnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08626', ' Adorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08645', ' Bad Elster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('08648', ' Bad Brambach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09111', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09112', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09113', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09114', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09116', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09117', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09119', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09120', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09122', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09123', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09125', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09126', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09127', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09128', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09130', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09131', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09212', ' Limbach-Oberfrohna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09217', ' BurgstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09221', ' Neukirchen/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09224', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09228', ' Chemnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09232', ' Hartmannsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09235', ' Burkhardtsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09236', ' ClauÃŸnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09241', ' MÃ¼hlau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09243', ' Niederfrohna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09244', ' Lichtenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09247', ' RÃ¶hrsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09249', ' Taura b. BurgstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09306', ' Rochlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09322', ' Penig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09326', ' Geringswalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09328', ' Lunzenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09337', ' Callenberg, Hohenstein-Ernstthal, Bernsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09350', ' Lichtenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09353', ' Oberlungwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09355', ' Gersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09356', ' St. Egidien');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09366', ' Stollberg/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09376', ' Oelsnitz/Erzgebirge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09380', ' Thalheim/Erzgebirge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09385', ' Lugau/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09387', ' Jahnsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09390', ' Gornsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09392', ' Auerbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09394', ' Hohndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09399', ' NiederwÃ¼rschnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09405', ' Zschopau, Gornau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09419', ' Thum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09423', ' Gelenau/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09427', ' Ehrenfriedersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09429', ' Wolkenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09430', ' Drebach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09432', ' GroÃŸolbersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09434', ' Zschopau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09437', ' BÃ¶rnichen, Gornau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09439', ' Amtsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09456', ' Annaberg-Buchholz, Mildenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09465', ' Sehma');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09468', ' Geyer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09471', ' BÃ¤renstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09474', ' Crottendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09477', ' JÃ¶hstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09481', ' Scheibenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09484', ' Oberwiesenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09487', ' Schlettau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09488', ' Wiesa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09496', ' Marienberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09509', ' Pockau-Lengefeld (Pockau)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09514', ' Pockau-Lengefeld (Lengefeld)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09518', ' GroÃŸrÃ¼ckerswalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09526', ' Olbernhau, Pfaffroda, Heidersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09544', ' Neuhausen/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09548', ' Seiffen/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09557', ' FlÃ¶ha');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09569', ' Oederan');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09573', ' Leubsdorf, Gornau, Augustusburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09575', ' Eppendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09577', ' Niederwiesa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09579', ' GrÃ¼nhainichen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09599', ' Freiberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09600', ' WeiÃŸenborn, OberschÃ¶na');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09603', ' GroÃŸschirma');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09618', ' Brand-Erbisdorf, GroÃŸhartmannsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09619', ' Dorfchemnitz, Mulda, Sayda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09623', ' Frauenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09627', ' Bobritzsch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09629', ' Reinsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09633', ' HalsbrÃ¼cke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09634', ' Reinsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09638', ' Lichtenberg/Erzgeb.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09648', ' Mittweida, Kriebstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09661', ' Hainichen, Rossau, Striegistal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('09669', ' Frankenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('1', '2');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10115', ' Berlin Mitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10117', ' Berlin Mitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10119', ' Berlin Mitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10178', ' Berlin Mitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10179', ' Berlin Mitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10243', ' Berlin Friedrichshain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10245', ' Berlin Friedrichshain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10247', ' Berlin Friedrichshain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10249', ' Berlin Friedrichshain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10315', ' Berlin Friedrichsfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10317', ' Berlin Rummelsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10318', ' Berlin Karlshorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10319', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10365', ' Berlin Lichtenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10367', ' Berlin Lichtenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10369', ' Berlin Lichtenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10405', ' Berlin Prenzlauer Berg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10407', ' Berlin Prenzlauer Berg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10409', ' Berlin Prenzlauer Berg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10435', ' Berlin Prenzlauer Berg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10437', ' Berlin Prenzlauer Berg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10439', ' Berlin Prenzlauer Berg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10551', ' Berlin Moabit');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10553', ' Berlin Moabit');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10555', ' Berlin Moabit');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10557', ' Berlin Moabit');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10559', ' Berlin Moabit');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10585', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10587', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10589', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10623', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10625', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10627', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10629', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10707', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10709', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10711', ' Berlin Halensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10713', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10715', ' Berlin Wilhelmsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10717', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10719', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10777', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10779', ' Berlin SchÃ¶neberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10781', ' Berlin SchÃ¶neberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10783', ' Berlin SchÃ¶neberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10785', ' Berlin Tiergarten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10787', ' Berlin Tiergarten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10789', ' Berlin SchÃ¶neberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10823', ' Berlin-West');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10825', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10827', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10829', ' Berlin SchÃ¶neberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10961', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10963', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10965', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10967', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10969', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10997', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('10999', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12043', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12045', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12047', ' Berlin Kreuzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12049', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12051', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12053', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12055', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12057', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12059', ' Berlin NeukÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12099', ' Berlin Tempelhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12101', ' Berlin Tempelhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12103', ' Berlin Tempelhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12105', ' Berlin Mariendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12107', ' Berlin Mariendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12109', ' Berlin Mariendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12157', ' Berlin SchÃ¶neberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12159', ' Berlin Friedenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12161', ' Berlin Friedenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12163', ' Berlin Steglitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12165', ' Berlin Steglitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12167', ' Berlin Steglitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12169', ' Berlin Steglitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12203', ' Berlin Lichtenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12205', ' Berlin Lichtenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12207', ' Berlin Lichtenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12209', ' Berlin-Lichterfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12247', ' Berlin Lankwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12249', ' Berlin Lankwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12277', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12279', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12305', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12307', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12309', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12347', ' Berlin Britz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12349', ' Berlin Buckow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12351', ' Berlin Buckow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12353', ' Berlin Gropiusstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12355', ' Berlin Rudow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12357', ' Berlin Rudow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12359', ' Berlin Britz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12435', ' Berlin Alt Treptow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12437', ' Berlin Baumschulenweg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12439', ' Berlin NiederschÃ¶neweide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12459', ' Berlin OberschÃ¶neweide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12487', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12489', ' Berlin Teltowkanal III');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12524', ' Berlin Altglienicke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12526', ' Berlin Bohnsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12527', ' Berlin SchmÃ¶ckwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12529', ' SchÃ¶nefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12555', ' Berlin KÃ¶penik');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12557', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12559', ' Berlin KÃ¶penick');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12587', ' Berlin Wiesengrund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12589', ' Berlin Rahnsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12619', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12621', ' Berlin Kaulsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12623', ' Berlin Mahlsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12627', ' Berlin Hellersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12629', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12679', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12681', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12683', ' Berlin Biesdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12685', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12687', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('12689', ' Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13051', ' Berlin Neu-SchÃ¶nhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13053', ' Berlin Alt-HohenschÃ¶nhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13055', ' Berlin Alt-HohenschÃ¶nhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13057', ' Berlin Falkenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13059', ' Berlin Wartenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13086', ' Berlin WeiÃŸensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13088', ' Berlin WeiÃŸensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13089', ' Berlin Heinelsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13125', ' Berlin Buch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13127', ' Berlin FranzÃ¶sisch Buchholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13129', ' Berlin Blankenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13156', ' Berlin NiederschÃ¶nhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13158', ' Berlin Rosenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13159', ' Berlin Blankenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13187', ' Berlin Pankow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13189', ' Berlin Pankow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13347', ' Berlin Wedding');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13349', ' Berlin Wedding');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13351', ' Berlin Wedding');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13353', ' Berlin Wedding');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13355', ' Berlin Wedding');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13357', ' Berlin Gesundbrunnen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13359', ' Berlin Gesundbrunnen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13403', ' Berlin Reinickendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13405', ' Berlin Wedding');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13407', ' Berlin-West');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13409', ' Berlin-West');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13435', ' Berlin MÃ¤rkisches Viertel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13437', ' Berlin Reinickendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13439', ' Berlin MÃ¤rkisches Viertel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13465', ' Berlin Frohnau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13467', ' Berlin Hermsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13469', ' Berlin LÃ¼bars');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13503', ' Berlin Tegel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13505', ' Berlin Tegel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13507', ' Berlin Tegel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13509', ' Berlin Reinickendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13581', ' Berlin Spandau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13583', ' Berlin Spandau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13585', ' Berlin Spandau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13587', ' Berlin Hakenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13589', ' Berlin Falkenhagener Feld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13591', ' Berlin Staaken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13593', ' Berlin Wilhelmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13595', ' Berlin Wlhelmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13597', ' Berlin Spandau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13599', ' Berlin Haselhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13627', ' Berlin Charlottenburg-Nord');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('13629', ' Berlin Siemensstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14050', ' Berlin Westend');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14052', ' Berlin Westend');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14053', ' Berlin Westend');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14055', ' Berlin Westend');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14057', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14059', ' Berlin Charlottenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14089', ' Berlin Gatow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14109', ' Berlin Wannsee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14129', ' Berlin Nikolassee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14163', ' Berlin Zehlendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14165', ' Berlin Zehlendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14167', ' Berlin Zehlendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14169', ' Berlin Zehlendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14193', ' Berlin Grunewald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14195', ' Berlin Dahlem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14197', ' Berlin Wilmersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14199', ' Berlin Schmargendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14467', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14469', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14471', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14473', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14476', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14478', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14480', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14482', ' Potsdam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14513', ' Teltow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14532', ' Kleinmachnow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14542', ' Werder/ Havel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14547', ' Beelitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14548', ' Schwielowswee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14550', ' GroÃŸ Kreutz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14552', ' Michendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14554', ' Seddinger See');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14558', ' Nuthetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14612', ' Falkensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14621', ' SchÃ¶nwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14624', ' Dallgow-DÃ¶beritz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14641', ' Nauen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14656', ' Brieselang');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14662', ' Friesack');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14669', ' Ketzin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14712', ' Rathenow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14715', ' Milower Land, Schollene, Nennhausen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14727', ' Premnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14728', ' Rhinow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14770', ' Brandenburg/ Havel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14772', ' Brandenburg/ Havel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14774', ' Brandenburg/ Havel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14776', ' Brandenburg/Havel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14778', ' Beetzsee, Wollin, Wenzlow, Golzow u.a');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14789', ' Wusterwitz, Rosenau, Bensdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14793', ' Ziesar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14797', ' Lehnin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14798', ' Havelsee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14806', ' Belzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14822', ' BrÃ¼ck, Borkheide u.a');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14823', ' Niemegk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14827', ' Wiesenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14828', ' GÃ¶rzke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14913', ' JÃ¼terbog');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14929', ' Treuenbrietzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14943', ' Luckenwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14947', ' Nuthe-Urstromtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14959', ' Trebbin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14974', ' Ludwigsfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('14979', ' GroÃŸbeeren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15230', ' Frankfurt/ Oder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15232', ' Frankfurt/ Oder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15234', ' Frankfurt/ Oder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15236', ' Treplin, Jacobsdorf, Frankfurt (Oder)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15295', ' Brieskow-Finkenheerd');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15299', ' MÃ¼llrose');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15306', ' Seelow, Lietzen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15320', ' Neutrebbin, Neuhardenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15324', ' Letschin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15326', ' Zeschdorf, Podelzig, Lebus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15328', ' Golzow, Zechin u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15344', ' Strausberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15345', ' Lichtenow, Altlandsberg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15366', ' Neuenhagen, Hoppegarten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15370', ' Fredersdorf-Vogelsdorf, Petershagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15374', ' MÃ¼ncheberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15377', ' Oberbarnim, MÃ¤rkische HÃ¶he u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15378', ' RÃ¼dersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15517', ' FÃ¼rstenwalde/ Spree');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15518', ' Briesen, Rauen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15526', ' Bad Saarow-Pieskow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15528', ' Spreenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15537', ' Erkner');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15562', ' RÃ¼dersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15566', ' SchÃ¶neiche bei Berlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15569', ' Woltersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15711', ' KÃ¶nigs Wusterhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15712', ' KÃ¶nigs Wusterhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15713', ' KÃ¶nigs Wusterhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15732', ' Schulzendorf b. Eichenwade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15738', ' Zeuthen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15741', ' Bestensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15745', ' Wildau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15746', ' GroÃŸ KÃ¶ris');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15748', ' MÃ¤rkisch Buchholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15749', ' Mittenwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15754', ' Heidesee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15755', ' Teupitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15757', ' Halbe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15806', ' Zossen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15827', ' Blankenfelde-Mahlow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15831', ' Blankenfelde-Mahlow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15834', ' Rangsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15837', ' Baruth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15838', ' Am Mellensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15848', ' Beeskow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15859', ' Storkow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15864', ' Wendisch Rietz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15868', ' Lieberose');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15890', ' EisenhÃ¼ttenstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15898', ' Neuzelle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15907', ' LÃ¼bben (Spreewald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15910', ' SchÃ¶nwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15913', ' Straupitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15926', ' Luckau, Waldrehna, Heideblick, FÃ¼rstlich Drehna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15936', ' Dahme u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('15938', ' GolÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16225', ' Eberswalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16227', ' Eberswalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16230', ' Melchow, Chorin u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16244', ' Schorfheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16247', ' Joachimsthal u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16248', ' Oderberg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16259', ' Bad Freienwalde u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16269', ' Wriezen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16278', ' AngermÃ¼nde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16303', ' Schwedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16306', ' Biesendahlshof, Berkholz-Meyenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16307', ' Gartz (Oder)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16321', ' Bernau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16341', ' Panketal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16348', ' Wandlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16356', ' Werneuchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16359', ' Biesenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16515', ' Oranienburg, MÃ¼hlenbecker Land');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16540', ' Hohen Neuendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16547', ' Birkenwerder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16548', ' Glienicke/Nordbahn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16552', ' MÃ¼hlenbecker Land');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16556', ' Borgsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16559', ' Liebenwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16562', ' Hohen Neuendorf OT Bergfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16567', ' MÃ¼hlenbecker Land');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16727', ' Velten, OberkrÃ¤mer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16761', ' Hennigsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16766', ' Kremmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16767', ' Leegebruch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16775', ' Gransee, LÃ¶wenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16792', ' Zehdenick');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16798', ' FÃ¼rstenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16816', ' Neuruppin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16818', ' Fehrbellin, Temnitzquell, MÃ¤rkisch Linden u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16827', ' Neuruppin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16831', ' Rheinsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16833', ' Fehrbellin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16835', ' Lindow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16837', ' Rheinsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16845', ' Neustadt (Dosse) u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16866', ' Gumtow, Kyritz u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16868', ' Wusterhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16909', ' Wittstock/Dosse, Heiligengrabe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16928', ' Pritzwalk, GroÃŸ Pankow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16945', ' Meyenburg, KÃ¼mmernitztal u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('16949', ' Triglitz, Putlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17033', ' Neubrandenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17034', ' Neubrandenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17036', ' Neubrandenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17039', ' Sponholz, Neunkirchen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17087', ' Altentreptow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17089', ' Burow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17091', ' Rosenow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17094', ' CÃ¶lpin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17098', ' Friedland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17099', ' Friedland, Galenbeck, Datzetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17109', ' Demmin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17111', ' Demmin u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17121', ' Loitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17126', ' Jarmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17129', ' Bentzin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17139', ' Malchin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17153', ' Stavenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17154', ' Neukalen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17159', ' Dargun');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17166', ' Dahmen, GroÃŸ Wokern, Teterow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17168', ' JÃ¶rdenstorf, Prebberede u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17179', ' Gnoien u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17192', ' Waren/ MÃ¼ritz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17194', ' GrabowhÃ¶fe, Moltzow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17207', ' RÃ¶bel/ MÃ¼ritz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17209', ' Wredenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17213', ' Malchow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17214', ' Nossentiner HÃ¼tte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17217', ' Penzlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17219', ' MÃ¶llenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17235', ' Neustrelitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17237', ' MÃ¶llenbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17248', ' Rechlin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17252', ' Mirow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17255', ' Wesenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17258', ' Feldberger Seenlandschaft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17268', ' Templin, Boitzenburg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17279', ' Lychen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17291', ' Prenzlau u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17309', ' Pasewalk u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17321', ' LÃ¶cknitz, Rothenklempenow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17322', ' Blankensee, Grambow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17326', ' BrÃ¼ssow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17328', ' Penkun u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17329', ' Krackow, Nadrensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17335', ' Strasburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17337', ' Uckerland, GroÃŸ Luckow, SchÃ¶nhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17348', ' Woldegk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17349', ' GroÃŸ Miltzow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17358', ' Torgelow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17367', ' Eggesin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17373', ' UeckermÃ¼nde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17375', ' Vogelsang-Warsin, Meiersberg, MÃ¶nkebude u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17379', ' Ferdinandshof u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17389', ' Anklam');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17390', ' Klein BÃ¼nzow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17391', ' Krien u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17392', ' Spantekow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17398', ' Ducherow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17406', ' Usedom u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17419', ' Seebad Ahlbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17424', ' Ostseebad Heringsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17429', ' Benz, Heringsdorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17438', ' Wolgast');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17440', ' KrÃ¶slin, Krummin, Lassan u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17449', ' Karlshagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17454', ' Zinnowitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17459', ' Koserow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17489', ' Greifswald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17491', ' Greifswald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17493', ' Greifswald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17495', ' Karlsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17498', ' Neuenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17506', ' GÃ¼tzkow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('17509', ' Lubmin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18055', '');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18057', '');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18059', '');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18069', '');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18106', '');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18107', ' Elmenhorst/Lichtenhagen, Rostock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18109', ' Rostock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18119', ' Rostock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18146', ' Rostock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18147', ' Rostock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18181', ' Rostock, Graal-MÃ¼ritz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18182', ' Rostock, Gelbensande, RÃ¶vershagen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18184', ' Roggentin, Broderstorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18190', ' Sanitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18195', ' Tessin, Grammow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18196', ' Dummerstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18198', '');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18209', ' Bad Doberan, Bartenshagen-Parkentin u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18211', ' Retschow, Admannshagen-Bargeshagen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18225', ' KÃ¼hlungsborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18230', ' Rerik, Bastorf, Biendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18233', ' Neubukow, Ravensberg, WestenbrÃ¼gge u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18236', ' KrÃ¶pelin, Carinerland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18239', ' Satow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18246', ' BÃ¼tzow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18249', ' Bernitt, Qualitz, Warnow, Zernin u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18258', ' Schwaan u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18273', ' GÃ¼strow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18276', ' Reimershagen, Lohmen, Zehna, HÃ¤gerfelde u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18279', ' Lalendorf, Langhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18292', ' Krakow, Dobbin-Linstow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18299', ' Laage, Wardow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18311', ' Ribnitz-Damgarten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18314', ' LÃ¶bnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18317', ' Saal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18320', ' Ahrenshagen-Daskow, Trinwillershagen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18334', ' Bad SÃ¼lze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18337', ' Marlow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18347', ' Dierhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18356', ' Barth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18374', ' Zingst a. DarÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18375', ' Prerow a. DarÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18435', ' Stralsund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18437', ' Stralsund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18439', ' Stralsund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18442', ' Niepars');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18445', ' Prohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18461', ' Franzburg, Richtenberg, u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18465', ' Tribsees');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18469', ' Velgast');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18507', ' Grimmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18510', ' Wittenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18513', ' Glewitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18516', ' Rakow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18519', ' Miltzow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18528', ' Bergen/ RÃ¼gen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18546', ' Sassnitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18551', ' Sagard');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18556', ' Dranske');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18565', ' Hiddensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18569', ' Gingst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18573', ' Samtens');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18574', ' Garz/ RÃ¼gen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18581', ' Putbus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18586', ' Sellin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('18609', ' Binz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19053', ' Schwerin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19055', ' Schwerin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19057', ' Schwerin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19059', ' Schwerin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19061', ' Schwerin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19063', ' Schwerin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19065', ' Pinnow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19067', ' Leezen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19069', ' LÃ¼bstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19071', ' BrÃ¼sewitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19073', ' WittenfÃ¶rden u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19075', ' Pampow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19077', ' Rastow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19079', ' Banzkow, Sukow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19086', ' Plate');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19089', ' Crivitz, Friedrichsruhe u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19205', ' Gadebusch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19209', ' LÃ¼tzow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19217', ' Rehna, Carlow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19230', ' Hagenow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19243', ' Wittenburg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19246', ' Zarrentin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19249', ' LÃ¼btheen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19258', ' Boizenburg, Gresse, Greven u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19260', ' Vellahn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19273', ' Amt Neuhaus, Stapel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19288', ' Ludwigslust');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19294', ' Neu KaliÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19300', ' Grabow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19303', ' DÃ¶mitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19306', ' Neustadt-Glewe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19309', ' Lenzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19322', ' Wittenberge, RÃ¼hstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19336', ' Legde/QuitzÃ¶bel, Bad Wilsnack');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19339', ' Plattenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19348', ' Perleberg, Berge u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19357', ' KarstÃ¤dt, Dambeck, KlÃ¼ÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19370', ' Parchim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19372', ' Spornitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19374', ' DomsÃ¼hl, Mestlin, Obere Warnow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19376', ' Marnitz, Siggelkow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19386', ' LÃ¼bz, Passow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19395', ' Plau am See');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19399', ' Goldberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19406', ' Sternberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19412', ' BrÃ¼el');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('19417', ' Warin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20095', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20097', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20099', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20144', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20146', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20148', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20149', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20249', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20251', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20253', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20255', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20257', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20259', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20354', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20355', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20357', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20359', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20457', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20459', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20535', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20537', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('20539', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21029', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21031', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21033', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21035', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21037', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21039', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21073', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21075', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21077', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21079', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21107', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21109', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21129', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21147', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21149', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21217', ' Seevetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21218', ' Seevetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21220', ' Seevetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21224', ' Rosengarten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21227', ' Bendestorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21228', ' Harmstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21244', ' Buchholz in der Nordheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21255', ' Tostedt, Kakenstorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21256', ' Handeloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21258', ' Heidenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21259', ' Otter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21261', ' Welle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21266', ' Jesteburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21271', ' Hanstedt, Asendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21272', ' Eggestorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21274', ' Undeloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21279', ' Hollenstedt, Drestedt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21335', ' LÃ¼neburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21337', ' LÃ¼neburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21339', ' LÃ¼neburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21354', ' Bleckede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21357', ' Bardowick, Wittorf, Barum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21358', ' Mechtersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21360', ' VÃ¶gelsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21365', ' Adendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21368', ' Dahlenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21369', ' Nahrendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21371', ' Tosterglope');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21376', ' Salzhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21379', ' Scharnebeck, Echem, LÃ¼dersburg, Rullstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21380', ' Artlenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21382', ' Brietlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21385', ' Oldendorf (Luhe), Amelinghausen, Rehlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21386', ' Betzendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21388', ' Soderstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21391', ' Reppenstedt, LÃ¼neburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21394', ' Kirchgellersen, Westergellersen, SÃ¼dergellersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21395', ' Tespe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21397', ' Barendorf, Vastorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21398', ' Neetze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21400', ' Reinstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21401', ' Thomasburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21403', ' Wendisch Evern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21406', ' Melbeck, Barnstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21407', ' Deutsch Evern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21409', ' Embsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21423', ' Winsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21435', ' Stelle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21436', ' Marschacht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21438', ' Brackel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21439', ' Marxen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21441', ' Garstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21442', ' Toppenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21444', ' VierhÃ¶fen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21445', ' Wulfsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21447', ' Handorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21449', ' Radbruch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21465', ' Reinbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21481', ' Lauenburg/Elbe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21483', ' GÃ¼lzow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21493', ' Fuhlenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21502', ' Geesthacht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21509', ' Glinde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21514', ' BrÃ¶then');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21516', ' Woltersdorf, MÃ¼ssen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21521', ' AumÃ¼hle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21522', ' Hohnstorf (Elbe), Hittbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21524', ' Brunstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21526', ' Hohenhorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21527', ' Kollow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21529', ' KrÃ¶ppelshagen-Fahrendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21614', ' Buxtehude');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21629', ' Neu Wulmstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21635', ' Jork');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21640', ' Horneburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21641', ' Apensen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21643', ' Beckdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21644', ' Sauensiek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21646', ' Halvesbostel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21647', ' Moisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21649', ' Regesbostel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21680', ' Stade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21682', ' Stade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21683', ' Stade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21684', ' Stade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21698', ' Harsefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21702', ' Ahlerstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21706', ' Drochtersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21709', ' Himmelpforten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21710', ' Engelschoff');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21712', ' GroÃŸenwÃ¶rden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21714', ' Hammah');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21717', ' Fredenbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21720', ' GrÃ¼nendeich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21723', ' Hollern-Twielenfleth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21726', ' Oldendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21727', ' Estorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21729', ' Freiburg (Elbe)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21730', ' Balje');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21732', ' Krummendeich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21734', ' Oederquart');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21737', ' Wischhafen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21739', ' Dollern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21745', ' Hemmoor');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21755', ' Hechthausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21756', ' Osten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21762', ' Otterndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21763', ' Neuenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21765', ' Nordleda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21769', ' Lamstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21770', ' Mittelstenahe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21772', ' Stinstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21775', ' Ihlienworth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21776', ' Wanna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21781', ' Cadenberge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21782', ' BÃ¼lkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21785', ' Neuhaus (Oste)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21787', ' Oberndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('21789', ' Wingst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22041', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22043', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22045', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22047', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22049', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22081', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22083', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22085', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22087', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22089', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22111', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22113', ' Hamburg, Oststeinbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22115', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22117', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22119', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22143', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22145', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22147', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22149', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22159', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22175', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22177', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22179', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22297', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22299', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22301', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22303', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22305', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22307', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22309', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22335', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22337', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22339', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22359', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22391', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22393', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22395', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22397', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22399', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22415', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22417', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22419', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22453', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22455', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22457', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22459', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22523', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22525', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22527', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22529', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22547', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22549', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22559', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22587', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22589', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22605', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22607', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22609', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22761', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22763', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22765', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22767', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22769', ' Hamburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22844', ' Norderstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22846', ' Norderstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22848', ' Norderstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22850', ' Norderstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22851', ' Norderstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22869', ' Schenefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22880', ' Wedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22885', ' BarsbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22889', ' Tangstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22926', ' Ahrensburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22927', ' GroÃŸhansdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22929', ' Hamfelde, Kasseburg, KÃ¶thel, Rausdorf, SchÃ¶nber');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22941', ' Bargteheide, Delingsdorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22946', ' Trittau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22949', ' Ammersbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22952', ' LÃ¼tjensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22955', ' Hoisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22956', ' GrÃ¶nwohld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22958', ' KuddewÃ¶rde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22959', ' Linau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22961', ' Hoisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22962', ' Siek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22964', ' Steinburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22965', ' Todendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22967', ' TremsbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('22969', ' Witzhave');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23552', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23554', ' LÃ¼beck St. Lorenz Nord');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23556', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23558', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23560', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23562', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23564', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23566', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23568', ' LÃ¼beck Schlutup/St. Gertrud');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23569', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23570', ' LÃ¼beck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23611', ' Bad Schwartau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23617', ' Stockelsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23619', ' Zarpen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23623', ' AhrensbÃ¶k');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23626', ' Ratekau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23627', ' GroÃŸ GrÃ¶nau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23628', ' Krummesse, Klempau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23629', ' Sarkwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23669', ' Timmendorfer Strand');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23683', ' Scharbeutz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23684', ' Scharbeutz, SÃ¼sel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23689', ' Pansdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23701', ' Eutin, SÃ¼sel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23714', ' Malente, KirchnÃ¼chel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23715', ' Bosau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23717', ' Kasseedorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23719', ' Glasau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23730', ' Neustadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23738', ' Lensahn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23743', ' GrÃ¶mitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23744', ' SchÃ¶nwalde am Bungsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23746', ' Kellenhusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23747', ' Dahme');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23749', ' Grube');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23758', ' Oldenburg in Holstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23769', ' Fehmarn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23774', ' Heiligenhafen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23775', ' GroÃŸenbrode');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23777', ' Heringsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23779', ' Neukirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23795', ' Bad Segeberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23812', ' Wahlstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23813', ' Nehms');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23815', ' Geschendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23816', ' Leezen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23818', ' NeuengÃ¶rs');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23820', ' Pronstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23821', ' Rohlstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23823', ' Seedorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23824', ' Tensfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23826', ' Bark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23827', ' Wensin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23829', ' Wittenborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23843', ' Bad Oldesloe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23845', ' Seth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23847', ' Lasbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23858', ' Reinfeld (Holstein)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23860', ' Klein Wesenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23863', ' Bargfeld-Stegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23866', ' Nahe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23867', ' SÃ¼lfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23869', ' Elmenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23879', ' MÃ¶lln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23881', ' Breitenfelde, Lankau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23883', ' Sterley');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23896', ' Nusse');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23898', ' Sandesneben u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23899', ' Gudow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23909', ' Ratzeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23911', ' Ziethen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23919', ' Berkenthin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23923', ' SchÃ¶nberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23936', ' GrevesmÃ¼hlen, Stepenitztal, Upahl u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23942', ' Dassow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23946', ' Boltenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23948', ' KlÃ¼tz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23966', ' Wismar, GroÃŸ Krankow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23968', ' Barnekow, GÃ¤gelow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23970', ' Wismar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23972', ' Dorf Mecklenburg, LÃ¼bow u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23974', ' Neuburg-Steinhausen, Hornstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23992', ' Neukloster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23996', ' Bad Kleinen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('23999', ' Insel Poel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24103', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24105', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24106', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24107', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24109', ' Melsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24111', ' Kiel Russee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24113', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24114', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24116', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24118', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24119', ' Kronshagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24143', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24145', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24146', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24147', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24148', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24149', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24159', ' Kiel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24161', ' Altenholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24211', ' Preetz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24214', ' Gettorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24217', ' SchÃ¶nberg (Holstein)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24220', ' Flintbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24222', ' Schwentinental');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24223', ' Schwentinetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24226', ' Heikendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24229', ' DÃ¤nischenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24232', ' SchÃ¶nkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24235', ' Laboe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24238', ' Selent');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24239', ' Achterwehr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24241', ' Blumenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24242', ' Felde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24244', ' Felm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24245', ' Kirchbarkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24247', ' Mielkendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24248', ' MÃ¶nkeberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24250', ' Nettelsee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24251', ' Osdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24253', ' Probsteierhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24254', ' Rumohr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24256', ' Fargau-Pratjau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24257', ' Hohenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24259', ' Westensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24306', ' PlÃ¶n');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24321', ' LÃ¼tjenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24326', ' Ascheberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24327', ' Blekendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24329', ' Grebin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24340', ' EckernfÃ¶rde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24351', ' Damp');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24354', ' Kosel, Rieseby u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24357', ' Fleckeby u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24358', ' Ascheffel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24360', ' Barkelsby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24361', ' GroÃŸ Wittensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24363', ' Holtsee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24364', ' Holzdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24366', ' Loose');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24367', ' Osterby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24369', ' Waabs');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24376', ' Kappeln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24392', ' SÃ¼derbrarup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24395', ' Gelting');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24398', ' DÃ¶rphof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24399', ' Arnis, Marienhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24401', ' BÃ¶el');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24402', ' Esgrus, Schrepperie');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24404', ' Maasholm, SchleimÃ¼nde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24405', ' Mohrkirch, RÃ¼gge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24407', ' Rabenkirchen-FaulÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24409', ' StoltebÃ¼ll');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24534', ' NeumÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24536', ' NeumÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24537', ' NeumÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24539', ' NeumÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24558', ' Henstedt-Ulzburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24568', ' Kaltenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24576', ' Bad Bramstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24582', ' Bordesholm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24589', ' Nortorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24594', ' Hohenwestedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24598', ' Boostedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24601', ' Wankendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24610', ' Trappenkamp');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24613', ' Aukrug, Wiedenborstel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24616', ' Brokstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24619', ' BÃ¶rnhÃ¶ved');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24620', ' BÃ¶nebÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24622', ' Gnutz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24623', ' GroÃŸenaspe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24625', ' GroÃŸharrie');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24626', ' GroÃŸ Kummerfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24628', ' Hartenholm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24629', ' Kisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24631', ' Langwedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24632', ' LentfÃ¶hrden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24634', ' Padenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24635', ' Rickling');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24637', ' Schillsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24638', ' Schmalensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24640', ' Schmalfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24641', ' SievershÃ¼tten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24643', ' StruvenhÃ¼tten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24644', ' Timmaspe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24646', ' Warder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24647', ' Wasbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24649', ' Wiemersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24768', ' Rendsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24782', ' BÃ¼delsdorf, Rickert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24783', ' OsterrÃ¶nfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24784', ' WesterrÃ¶nfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24787', ' Fockbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24790', ' Schacht-Audorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24791', ' Alt Duvenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24793', ' Bargstedt, Brammer, OldenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24794', ' Borgstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24796', ' Bredenbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24797', ' Breiholz, Tackesdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24799', ' Meggerdorf, Friedrichsholm, Friedrichsgraben u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24800', ' Elsdorf-WestermÃ¼hlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24802', ' Emkendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24803', ' Erfde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24805', ' Hamdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24806', ' Hohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24808', ' Jevenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24809', ' NÃ¼bbel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24811', ' Owschlag u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24813', ' SchÃ¼lp bei Rendsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24814', ' Sehestedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24816', ' Hamweddel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24817', ' Tetenhusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24819', ' TodenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24837', ' Schleswig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24848', ' Kropp u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24850', ' Schuby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24852', ' Eggebek, Langstedt, Sollerup, SÃ¼derhackstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24855', ' Bollingstedt, JÃ¼bek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24857', ' Fahrdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24860', ' BÃ¶klund u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24861', ' Bergenhusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24863', ' BÃ¶rm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24864', ' Brodersby, Goltoft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24866', ' Busdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24867', ' Dannewerk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24869', ' DÃ¶rpstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24870', ' Ellingstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24872', ' GroÃŸ Rheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24873', ' Havetoft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24876', ' Hollingstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24878', ' Jagel, Lottorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24879', ' Idstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24881', ' NÃ¼bel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24882', ' Schaalby, Geelbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24884', ' Selk, Geltdorf, Hahnekrug');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24885', ' Sieverstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24887', ' Silberstedt, Schwittschau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24888', ' Steinfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24890', ' Stolk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24891', ' Struxdorf, Schnarup-Thumby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24893', ' Taarstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24894', ' Tolk, Twedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24896', ' Treia, AhrenviÃ¶lfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24897', ' Ulsnis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24899', ' Wohlde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24937', ' Flensburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24939', ' Flensburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24941', ' Flensburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24943', ' Flensburg, Tastrup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24944', ' Flensburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24955', ' Harrislee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24960', ' GlÃ¼cksburg, Munkbrarup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24963', ' Tarp');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24966', ' SÃ¶rup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24969', ' GroÃŸenwiehe, Lindewitt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24972', ' Steinberg, Steinbergkirche');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24975', ' Husby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24976', ' Handewitt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24977', ' Langballig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24980', ' Schafflund, Meyn u.a');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24983', ' Handewitt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24986', ' Mittelangeln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24988', ' Oeversee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24989', ' Dollerup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24991', ' GroÃŸsolt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24992', ' JÃ¶rl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24994', ' Medelby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24996', ' Sterup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24997', ' Wanderup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('24999', ' Wees');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25335', ' Elmshorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25336', ' Elmshorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25337', ' Elmshorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25348', ' GlÃ¼ckstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25355', ' Barmstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25358', ' Horst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25361', ' Krempe, Grevenkop, SÃ¼derau, Muchelndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25364', ' Brande-HÃ¶rnerkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25365', ' Klein Offenseth-Sparrieshoop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25368', ' Kiebitzreihe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25370', ' Seester');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25371', ' SeestermÃ¼he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25373', ' Ellerhoop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25376', ' Borsfleth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25377', ' Kollmar, Pagensand');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25379', ' Herzhorn, Kamerlanderdeich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25421', ' Pinneberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25436', ' Uetersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25451', ' Quickborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25462', ' Rellingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25469', ' Halstenbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25474', ' Ellerbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25479', ' Ellerau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25482', ' Appen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25485', ' Hemdingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25486', ' Alveslohe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25488', ' Holm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25489', ' Haseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25491', ' Hetlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25492', ' Heist');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25494', ' Borstel-Hohenraden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25495', ' Kummerfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25497', ' Prisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25499', ' Tangstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25524', ' Itzehoe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25541', ' BrunsbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25548', ' Kellinghusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25551', ' Hohenlockstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25554', ' Wilster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25557', ' Hanerau-Hademarschen, Seefeld u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25560', ' Schenefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25563', ' Wrist');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25566', ' LÃ¤gerdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25569', ' Kremperheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25572', ' Sankt Margarethen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25573', ' Beidenfleth, Klein Kampen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25575', ' Beringstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25576', ' Brokdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25578', ' DÃ¤geling, Neuenbrook');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25579', ' Fitzbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25581', ' Hennstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25582', ' Hohenaspe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25584', ' Holstenniendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25585', ' LÃ¼tjenwestedt, Tackesdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25587', ' MÃ¼nsterdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25588', ' Oldendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25590', ' Osterstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25591', ' OttenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25593', ' Reher');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25594', ' Vaale');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25596', ' Wacken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25597', ' Westermoor');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25599', ' Wewelsfleth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25693', ' Sankt Michaelisdonn,Gudendorf,Volsemenhusen,Trenn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25704', ' Meldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25709', ' Kronprinzenkoog, Marne u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25712', ' Burg (Dithmarschen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25715', ' Eddelak, Averlak, Dingen, Ramhusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25718', ' Friedrichskoog');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25719', ' Barlt, Busenwurth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25721', ' Eggstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25724', ' Neufeld, Schmedeswurth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25725', ' Schafstedt, Weidenhof, Bornholt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25727', ' SÃ¼derhastedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25729', ' Windbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25746', ' Heide u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25761', ' BÃ¼sum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25764', ' Wesselburen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25767', ' Albersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25770', ' Hemmingstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25774', ' Lunden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25776', ' Sankt Annen, Rehm-Flehde-Bargen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25779', ' Hennstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25782', ' Tellingstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25785', ' Nordhastedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25786', ' Dellstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25788', ' Delve');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25791', ' Linden, Barkenholm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25792', ' Neuenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25794', ' Pahlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25795', ' Weddingstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25797', ' WÃ¶hrden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25799', ' Wrohm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25813', ' Husum, Schwesing u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25821', ' Bredstedt, Breklum u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25826', ' Sankt Peter-Ording');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25832', ' TÃ¶nning');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25836', ' Garding, Osterhever, PoppenbÃ¼ll u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25840', ' Friedrichstadt, KoldenbÃ¼ttel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25842', ' Langenhorn, Ockholm u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25845', ' Nordstrand, Elisabeth-Sophien-Koog, SÃ¼dfall');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25849', ' SÃ¼deroog, Pellworm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25850', ' Behrendorf, Bondelum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25852', ' Bordelum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25853', ' AhrenshÃ¶ft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25855', ' Haselund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25856', ' Hattstedt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25858', ' HÃ¶gel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25859', ' Hallig Hooge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25860', ' Horstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25862', ' Joldelund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25863', ' LangeneÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25864', ' LÃ¶wenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25866', ' Mildstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25867', ' Oland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25869', ' Habel, GrÃ¶de');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25870', ' Oldenswort');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25872', ' Ostenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25873', ' Rantrum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25876', ' Schwabstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25878', ' Drage, Seeth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25879', ' Stapel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25881', ' Tating, Westerhever, TÃ¼mlauer Koog');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25882', ' TetenbÃ¼ll');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25884', ' ViÃ¶l');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25885', ' Wester-Ohrstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25887', ' Winnert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25889', ' UelvesbÃ¼ll, Witzwort');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25899', ' NiebÃ¼ll');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25917', ' Leck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25920', ' Risum-Lindholm, Stedesand');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25923', ' SÃ¼derlÃ¼gum, Braderup u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25924', ' RodenÃ¤s');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25926', ' Ladelund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25927', ' Neukirchen, Aventoft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25938', ' FÃ¶hr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25946', ' Amrum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25980', ' Sylt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25992', ' List');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25996', ' Wenningstedt-Braderup (Sylt)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25997', ' HÃ¶rnum (Sylt)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('25999', ' Kampen (Sylt)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26121', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26122', ' Oldenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26123', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26125', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26127', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26129', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26131', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26133', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26135', ' Oldenburg (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26160', ' Bad Zwischenahn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26169', ' Friesoythe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26180', ' Rastede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26188', ' Edewecht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26197', ' GroÃŸenkneten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26203', ' Wardenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26209', ' Hatten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26215', ' Wiefelstede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26219', ' BÃ¶sel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26316', ' Varel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26340', ' Zetel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26345', ' Bockhorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26349', ' Jade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26382', ' Wilhelmshaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26384', ' Wilhelmshaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26386', ' Wilhelmshaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26388', ' Wilhelmshaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26389', ' Wilhelmshaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26409', ' Wittmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26419', ' Schortens');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26427', ' Esens, Neuharlingersiel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26434', ' Wangerland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26441', ' Jever');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26446', ' Friedeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26452', ' Sande');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26465', ' Langeoog');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26474', ' Spiekeroog');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26486', ' Wangerooge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26487', ' Blomberg, Neuschoo');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26489', ' Ochtersum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26506', ' Norden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26524', ' Hage, Halbemond u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26529', ' Upgant-Schott, Osteel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26532', ' GroÃŸheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26548', ' Norderney');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26553', ' Dornum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26556', ' Westerholt, Schweindorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26571', ' Juist, Memmert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26579', ' Baltrum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26603', ' Aurich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26605', ' Aurich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26607', ' Aurich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26624', ' SÃ¼dbrookmerland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26629', ' GroÃŸefehn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26632', ' Ihlow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26639', ' Wiesmoor');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26655', ' Westerstede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26670', ' Uplengen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26676', ' BarÃŸel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26683', ' Saterland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26689', ' Apen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26721', ' Emden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26723', ' Emden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26725', ' Emden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26736', ' KrummhÃ¶rn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26757', ' Borkum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26759', ' Hinte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26789', ' Leer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26802', ' Moormerland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26810', ' Westoverledingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26817', ' Rhauderfehn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26826', ' Weener');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26831', ' Bunde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26835', ' Hesel, Neukamperfehn u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26842', ' Ostrhauderfehn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26844', ' Jemgum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26845', ' Nortmoor');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26847', ' Detern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26849', ' Filsum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26871', ' Papenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26892', ' DÃ¶rpen, Lehe, u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26897', ' Esterwegen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26899', ' Rhede (Ems)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26901', ' Lorup, Rastdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26903', ' Surwold');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26904', ' BÃ¶rger');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26906', ' Dersum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26907', ' Walchum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26909', ' NeubÃ¶rger, Neulehe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26919', ' Brake');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26931', ' Elsfleth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26935', ' Stadland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26936', ' Stadland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26937', ' Stadland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26939', ' OvelgÃ¶nne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26954', ' Nordenham');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('26969', ' Butjadingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27211', ' Bassum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27232', ' Sulingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27239', ' Twistringen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27243', ' Harpstedt, GroÃŸ Ippener, Colnrade u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27245', ' Bahrenborstel, Barenburg, Kirchdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27246', ' Borstel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27248', ' Ehrenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27249', ' Maasen, Mellinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27251', ' Neuenkirchen, Scholen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27252', ' SchwafÃ¶rden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27254', ' Siedenburg, Staffhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27257', ' Affinghausen und Sudwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27259', ' Freistatt, Varrel, Wehrbleck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27283', ' Verden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27299', ' Langwedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27305', ' Bruchhausen-Vilsen, SÃ¼stedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27308', ' Kirchlinteln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27313', ' DÃ¶rverden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27318', ' Hoya, Hoyerhagen, Hilgermissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27321', ' Thedinghausen, Emtinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27324', ' Eystrup, Hassel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27327', ' Martfeld, Schwarme');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27330', ' Asendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27333', ' Schweringen, Warpe, BÃ¼cken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27336', ' Rethem (Aller), HÃ¤uslingen, Frankenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27337', ' Blender');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27339', ' Riede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27356', ' Rotenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27367', ' Sottrum, ReeÃŸum, BÃ¶tersen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27374', ' VisselhÃ¶vede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27383', ' ScheeÃŸel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27386', ' Bothel, Kirchwalsede u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27389', ' Fintel, LauenbrÃ¼ck u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27404', ' Zeven, Elsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27412', ' Tarmstedt, Breddorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27419', ' Sittensen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27432', ' BremervÃ¶rde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27442', ' Gnarrenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27446', ' Selsingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27449', ' Kutenholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27472', ' Cuxhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27474', ' Cuxhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27476', ' Cuxhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27478', ' Cuxhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27498', ' Helgoland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27499', ' Neuwerk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27568', ' Bremerhaven, Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27570', ' Bremerhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27572', ' Bremerhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27574', ' Bremerhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27576', ' Bremerhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27578', ' Bremerhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27580', ' Bremerhaven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27607', ' Geestland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27612', ' Loxstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27616', ' Beverstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27619', ' Schiffdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27624', ' Geestland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27628', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27639', ' Wurster NordseekÃ¼ste');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27711', ' Osterholz-Scharmbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27721', ' Ritterhude');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27726', ' Worpswede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27729', ' Hambergen, Holste u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27749', ' Delmenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27751', ' Delmenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27753', ' Delmenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27755', ' Delmenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27777', ' Ganderkesee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27793', ' Wildeshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27798', ' Hude (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27801', ' DÃ¶tlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27804', ' Berne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('27809', ' Lemwerder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28195', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28197', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28199', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28201', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28203', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28205', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28207', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28209', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28211', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28213', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28215', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28217', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28219', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28237', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28239', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28259', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28277', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28279', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28307', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28309', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28325', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28327', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28329', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28355', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28357', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28359', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28717', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28719', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28755', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28757', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28759', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28777', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28779', ' Bremen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28790', ' Schwanewede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28816', ' Stuhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28832', ' Achim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28844', ' Weyhe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28857', ' Syke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28865', ' Lilienthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28870', ' Ottersberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28876', ' Oyten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('28879', ' Grasberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29221', ' Celle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29223', ' Celle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29225', ' Celle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29227', ' Celle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29229', ' Celle, Wittbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29303', ' Bergen, Lohheide u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29308', ' Winsen (Aller)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29313', ' HambÃ¼hren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29320', ' Hermannsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29323', ' Wietze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29328', ' FaÃŸberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29331', ' Lachendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29336', ' Nienhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29339', ' Wathlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29342', ' Wienhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29345', ' UnterlÃ¼ÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29348', ' Eschede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29351', ' Eldingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29352', ' Adelheidsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29353', ' Ahnsbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29355', ' Beedenbostel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29356', ' BrÃ¶ckel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29358', ' Eicklingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29359', ' Habighorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29361', ' HÃ¶fer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29362', ' Hohne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29364', ' Langlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29365', ' Sprakensehl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29367', ' Steinhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29369', ' Ummern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29378', ' Wittingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29379', ' Wittingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29386', ' HankensbÃ¼ttel, Obernholz, Dedelstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29389', ' Bad Bodenteich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29392', ' Wesendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29393', ' GroÃŸ Oesingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29394', ' LÃ¼der');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29396', ' SchÃ¶newÃ¶rde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29399', ' Wahrenholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29410', ' Salzwedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29413', ' DÃ¤hre, Diesdorf, Wallstawe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29416', ' Kuhfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29439', ' LÃ¼chow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29451', ' Dannenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29456', ' Hitzacker (Elbe)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29459', ' Clenze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29462', ' Wustrow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29465', ' Schnega');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29468', ' Bergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29471', ' Gartow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29472', ' Damnatz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29473', ' GÃ¶hrde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29475', ' Gorleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29476', ' Gusborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29478', ' HÃ¶hbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29479', ' Jameln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29481', ' Karwitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29482', ' KÃ¼sten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29484', ' Langendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29485', ' Lemgow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29487', ' Luckau (Wendland)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29488', ' LÃ¼bbow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29490', ' Neu Darchau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29491', ' Prezelle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29493', ' Schnackenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29494', ' Trebel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29496', ' Waddeweitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29497', ' Woltersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29499', ' Zernien');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29525', ' Uelzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29549', ' Bad Bevensen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29553', ' BienenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29556', ' Suderburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29559', ' Wrestedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29562', ' Suhlendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29565', ' Wriedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29571', ' Rosche');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29574', ' Ebstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29575', ' Altenmedingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29576', ' Barum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29578', ' Eimke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29579', ' Emmendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29581', ' Gerdau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29582', ' Hanstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29584', ' Himbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29585', ' Jelmstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29587', ' Natendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29588', ' Oetzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29590', ' RÃ¤tzlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29591', ' RÃ¶mstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29593', ' Schwienau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29594', ' Soltendiek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29597', ' Stoetze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29599', ' Weste');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29614', ' Soltau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29633', ' Munster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29640', ' Schneverdingen, Heimbuch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29643', ' Neuenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29646', ' Bispingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29649', ' Wietzendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29664', ' Walsrode, Ostenholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29683', ' Bad Fallingbostel, Osterheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29690', ' Schwarmstedt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29693', ' Hodenhagen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('29699', ' Bomlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30159', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30161', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30163', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30165', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30167', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30169', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30171', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30173', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30175', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30177', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30179', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30419', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30449', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30451', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30453', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30455', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30457', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30459', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30519', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30521', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30539', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30559', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30625', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30627', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30629', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30655', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30657', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30659', ' Hannover');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30669', ' Langenhagen (Flughafen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30823', ' Garbsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30826', ' Garbsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30827', ' Garbsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30851', ' Langenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30853', ' Langenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30855', ' Langenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30880', ' Laatzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30890', ' Barsinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30900', ' Wedemark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30916', ' Isernhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30926', ' Seelze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30938', ' Burgwedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30952', ' Ronnenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30966', ' Hemmingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30974', ' Wennigsen (Deister)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30982', ' Pattensen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('30989', ' Gehrden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31008', ' Elze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31020', ' Salzhemmendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31028', ' Gronau (Leine)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31036', ' Eime');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31061', ' Alfeld (Leine)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31073', ' GrÃ¼nenplan, Delligsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31079', ' Sibbesse');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31084', ' Freden (Leine)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31089', ' Duingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31134', ' Hildesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31135', ' Hildesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31137', ' Hildesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31139', ' Hildesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31141', ' Hildesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31157', ' Sarstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31162', ' Bad Salzdetfurth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31167', ' Bockenem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31171', ' Nordstemmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31174', ' Schellerten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31177', ' Harsum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31180', ' Giesen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31185', ' SÃ¶hlde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31188', ' Holle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31191', ' Algermissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31195', ' Lamspringe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31199', ' Diekholzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31224', ' Peine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31226', ' Peine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31228', ' Peine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31234', ' Edemissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31241', ' Ilsede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31246', ' Lahstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31249', ' Hohenhameln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31275', ' Lehrte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31303', ' Burgdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31311', ' Uetze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31319', ' Sehnde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31515', ' Wunstorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31535', ' Neustadt am RÃ¼benberge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31542', ' Bad Nenndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31547', ' Rehburg-Loccum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31552', ' Apelern, Rodenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31553', ' Auhagen, Sachsenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31555', ' Suthfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31556', ' WÃ¶lpinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31558', ' Hagenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31559', ' Haste, Hohnhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31582', ' Nienburg/Weser');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31592', ' Stolzenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31595', ' Steyerberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31600', ' Uchte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31603', ' Diepenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31604', ' Raddestorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31606', ' Warmsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31608', ' Marklohe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31609', ' Balge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31613', ' Wietzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31618', ' Liebenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31619', ' Binnen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31621', ' Pennigsehl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31622', ' Heemsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31623', ' Drakenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31626', ' HaÃŸbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31627', ' Rohrsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31628', ' Landesbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31629', ' Estorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31632', ' Husum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31633', ' Leese');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31634', ' Steimbke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31636', ' Linsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31637', ' Rodewald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31638', ' StÃ¶ckse');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31655', ' Stadthagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31675', ' BÃ¼ckeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31683', ' Obernkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31688', ' NienstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31691', ' Helpsen, Seggebruch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31693', ' Hespe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31698', ' Lindhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31699', ' Beckedorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31700', ' HeuerÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31702', ' LÃ¼dersfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31707', ' HeeÃŸen, Bad Eilsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31708', ' Ahnsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31710', ' Buchholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31711', ' Luhden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31712', ' NiederwÃ¶hren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31714', ' Lauenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31715', ' Meerbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31717', ' Nordsehl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31718', ' Pollhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31719', ' Wiedensahl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31737', ' Rinteln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31749', ' Auetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31785', ' Hameln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31787', ' Hameln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31789', ' Hameln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31812', ' Bad Pyrmont');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31832', ' Springe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31840', ' Hessisch Oldendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31848', ' Bad MÃ¼nder am Deister');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31855', ' Aerzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31860', ' Emmerthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31863', ' CoppenbrÃ¼gge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31867', ' Pohle, Lauenau, Messenkamp, HÃ¼lsede etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('31868', ' Ottenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32049', ' Herford');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32051', ' Herford');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32052', ' Herford');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32105', ' Bad Salzuflen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32107', ' Bad Salzuflen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32108', ' Bad Salzuflen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32120', ' Hiddenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32130', ' Enger');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32139', ' Spenge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32257', ' BÃ¼nde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32278', ' Kirchlengern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32289', ' RÃ¶dinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32312', ' LÃ¼bbecke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32339', ' Espelkamp');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32351', ' Stemwede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32361', ' PreuÃŸisch Oldendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32369', ' Rahden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32423', ' Minden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32425', ' Minden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32427', ' Minden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32429', ' Minden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32457', ' Porta Westfalica');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32469', ' Petershagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32479', ' Hille');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32545', ' Bad Oeynhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32547', ' Bad Oeynhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32549', ' Bad Oeynhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32584', ' LÃ¶hne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32602', ' Vlotho');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32609', ' HÃ¼llhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32657', ' Lemgo');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32676', ' LÃ¼gde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32683', ' Barntrup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32689', ' Kalletal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32694', ' DÃ¶rentrup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32699', ' Extertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32756', ' Detmold');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32758', ' Detmold');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32760', ' Detmold');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32791', ' Lage');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32805', ' Horn-Bad Meinberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32816', ' Schieder-Schwalenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32825', ' Blomberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32832', ' Augustdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('32839', ' Steinheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33014', ' Bad Driburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33034', ' Brakel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33039', ' Nieheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33098', ' Paderborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33100', ' Paderborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33102', ' Paderborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33104', ' Paderborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33106', ' Paderborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33129', ' DelbrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33142', ' BÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33154', ' Salzkotten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33161', ' HÃ¶velhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33165', ' Lichtenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33175', ' Bad Lippspringe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33178', ' Borchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33181', ' WÃ¼nnenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33184', ' Altenbeken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33189', ' Schlangen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33330', ' GÃ¼tersloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33332', ' GÃ¼tersloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33333', ' Bertelsmann');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33334', ' GÃ¼tersloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33335', ' GÃ¼tersloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33378', ' Rheda-WiedenbrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33397', ' Rietberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33415', ' Verl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33428', ' Harsewinkel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33442', ' Herzebrock-Clarholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33449', ' Langenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33602', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33604', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33605', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33607', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33609', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33611', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33613', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33615', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33617', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33619', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33647', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33649', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33659', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33689', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33699', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33719', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33729', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33739', ' Bielefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33758', ' SchloÃŸ Holte-Stukenbrock');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33775', ' Versmold');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33790', ' Halle (Westfalen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33803', ' Steinhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33813', ' Oerlinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33818', ' LeopoldshÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33824', ' Werther (Westf.)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('33829', ' Borgholzhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34117', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34119', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34121', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34123', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34125', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34127', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34128', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34130', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34131', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34132', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34134', ' Kassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34212', ' Melsungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34225', ' Baunatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34233', ' Kassel, Fuldatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34246', ' Vellmar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34253', ' Lohfelden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34260', ' Kaufungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34266', ' Niestetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34270', ' Schauenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34277', ' FuldabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34281', ' Gudensberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34286', ' Spangenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34289', ' Zierenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34292', ' Ahnatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34295', ' EdermÃ¼nde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34298', ' Helsa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34302', ' Guxhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34305', ' Niedenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34308', ' Bad Emstal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34311', ' Naumburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34314', ' Espenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34317', ' Habichtswald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34320', ' SÃ¶hrewald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34323', ' Malsfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34326', ' Morschen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34327', ' KÃ¶rle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34329', ' Nieste');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34346', ' Hann. MÃ¼nden, Gutsbezirk Reinhardswald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34355', ' Staufenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34359', ' Reinhardshagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34369', ' Hofgeismar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34376', ' Immenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34379', ' Calden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34385', ' Bad Karlshafen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34388', ' Trendelburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34393', ' Grebenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34396', ' Liebenau (Hessen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34399', ' Oberweser');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34414', ' Warburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34431', ' Marsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34434', ' Borgentreich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34439', ' Willebadessen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34454', ' Bad Arolsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34466', ' Wolfhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34471', ' Volkmarsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34474', ' Diemelstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34477', ' Twistetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34479', ' Breuna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34497', ' Korbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34508', ' Willingen (Upland)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34513', ' Waldeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34516', ' VÃ¶hl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34519', ' Diemelsee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34537', ' Bad Wildungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34549', ' Edertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34560', ' Fritzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34576', ' Homberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34582', ' Borken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34587', ' Felsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34590', ' Wabern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34593', ' KnÃ¼llwald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34596', ' Bad Zwesten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34599', ' Neuental');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34613', ' Schwalmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34621', ' Frielendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34626', ' Neukirchen (KnÃ¼ll)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34628', ' Willingshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34630', ' Gilserberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34632', ' Jesberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34633', ' Ottrau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34637', ' Schrecksbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('34639', ' Schwarzenborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35037', ' Marburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35039', ' Marburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35041', ' Marburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35043', ' Marburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35066', ' Frankenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35075', ' Gladenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35080', ' Bad Endbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35083', ' Wetter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35085', ' Ebsdorfergrund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35088', ' Battenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35091', ' CÃ¶lbe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35094', ' Lahntal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35096', ' Weimar (Lahn)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35099', ' Burgwald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35102', ' Lohra');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35104', ' Lichtenfels');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35108', ' Allendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35110', ' Frankenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35112', ' Fronhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35114', ' Haina');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35116', ' Hatzfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35117', ' MÃ¼nchhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35119', ' Rosenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35216', ' Biedenkopf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35232', ' Dautphetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35236', ' Breidenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35239', ' Steffenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35260', ' Stadtallendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35274', ' Kirchhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35279', ' Neustadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35282', ' Rauschenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35285', ' GemÃ¼nden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35287', ' AmÃ¶neburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35288', ' Wohratal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35305', ' GrÃ¼nberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35315', ' Homberg (Ohm)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35321', ' Laubach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35325', ' MÃ¼cke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35327', ' Ulrichstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35329', ' GemÃ¼nden (Felda)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35390', ' GieÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35392', ' GieÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35394', ' GieÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35396', ' GieÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35398', ' GieÃŸen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35410', ' Hungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35415', ' Pohlheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35418', ' Buseck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35423', ' Lich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35428', ' LanggÃ¶ns');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35435', ' Wettenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35440', ' Linden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35444', ' Biebertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35447', ' Reiskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35452', ' Heuchelheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35457', ' Lollar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35460', ' Staufenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35463', ' Fernwald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35466', ' Rabenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35469', ' Allendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35510', ' Butzbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35516', ' MÃ¼nzenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35519', ' Rockenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35576', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35578', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35579', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35580', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35581', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35582', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35583', ' Wetzlar Garbeinheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35584', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35585', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35586', ' Wetzlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35606', ' Solms');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35614', ' AÃŸlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35619', ' Braunfels');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35625', ' HÃ¼ttenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35630', ' Ehringshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35633', ' Lahnau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35638', ' Leun');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35641', ' SchÃ¶ffengrund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35644', ' Hohenahr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35647', ' Waldolms');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35649', ' Bischoffen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35683', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35684', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35685', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35686', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35687', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35688', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35689', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35690', ' Dillenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35708', ' Haiger');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35713', ' Eschenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35716', ' DietzhÃ¶lztal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35719', ' Angelburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35745', ' Herborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35753', ' Greifenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35756', ' Mittenaar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35759', ' Driedorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35764', ' Sinn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35767', ' Breitscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35768', ' Siegbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35781', ' Weilburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35789', ' WeilmÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35792', ' LÃ¶hnberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35794', ' Mengerskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35796', ' Weinbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('35799', ' Merenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36037', ' Fulda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36039', ' Fulda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36041', ' Fulda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36043', ' Fulda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36088', ' HÃ¼nfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36093', ' KÃ¼nzell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36100', ' Petersberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36103', ' Flieden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36110', ' Schlitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36115', ' Hilders, Ehrenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36119', ' Neuhof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36124', ' Eichenzell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36129', ' Gersfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36132', ' Eiterfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36137', ' GroÃŸenlÃ¼der');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36142', ' Tann');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36145', ' Hofbieber');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36148', ' Kalbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36151', ' Burghaun');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36154', ' Hosenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36157', ' Ebersburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36160', ' Dipperz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36163', ' Poppenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36166', ' Haunetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36167', ' NÃ¼sttal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36169', ' Rasdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36179', ' Bebra');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36199', ' Rotenburg an der Fulda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36205', ' Sontra');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36208', ' Wildeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36211', ' Alheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36214', ' Nentershausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36217', ' Ronshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36219', ' Cornberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36251', ' Bad Hersfeld, Ludwigsau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36266', ' Heringen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36269', ' Philippsthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36272', ' Niederaula');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36275', ' Kirchheim (Hessen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36277', ' Schenklengsfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36280', ' Oberaula');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36282', ' Hauneck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36284', ' Hohenroda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36286', ' Neuenstein (Hessen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36287', ' Breitenbach am Herzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36289', ' Friedewald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36304', ' Alsfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36318', ' Schwalmtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36320', ' Kirtorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36323', ' Grebenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36325', ' Feldatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36326', ' Antrifttal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36329', ' Romrod');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36341', ' Lauterbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36355', ' Grebenhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36358', ' Herbstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36364', ' Bad Salzschlirf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36367', ' Wartenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36369', ' Lautertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36381', ' SchlÃ¼chtern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36391', ' Sinntal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36396', ' Steinau an der StraÃŸe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36399', ' Freiensteinau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36404', ' Vacha, Unterbreizbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36414', ' Unterbreizbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36419', ' Geisa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36433', ' Bad Salzungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36448', ' Bad Liebenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36452', ' Kaltennordheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36456', ' Barchfeld-Immelborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36457', ' Stadtlengsfeld, Weilar, Urnshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36460', ' Krayenberggemeinde, Frauensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36466', ' Dermbach, Wiesenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('36469', ' Tiefenort');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37073', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37075', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37077', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37079', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37081', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37083', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37085', ' GÃ¶ttingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37115', ' Duderstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37120', ' Bovenden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37124', ' Rosdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37127', ' Dransfeld u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37130', ' Gleichen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37133', ' Friedland');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37136', ' Seulingen, Waake u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37139', ' Adelebsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37154', ' Northeim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37170', ' Uslar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37176', ' NÃ¶rten-Hardenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37181', ' Hardegsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37186', ' Moringen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37191', ' Katlenburg-Lindau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37194', ' Bodenfelde, Wahlsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37197', ' Hattorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37199', ' Wulften');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37213', ' Witzenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37214', ' Witzenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37215', ' Witzenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37216', ' Witzenhausen, Gutsbezirk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37217', ' Witzenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37218', ' Witzenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37235', ' Hessisch Lichtenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37242', ' Bad Sooden-Allendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37247', ' GroÃŸalmerode');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37249', ' Neu-Eichenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37269', ' Eschwege');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37276', ' Meinhard');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37281', ' Wanfried');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37284', ' Waldkappel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37287', ' Wehretal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37290', ' MeiÃŸner');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37293', ' Herleshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37296', ' Ringgau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37297', ' Berkatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37299', ' WeiÃŸenborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37308', ' Heiligenstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37318', ' Arenshausen, Uder u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37327', ' Leinefelde-Worbis, Wingerode, Hausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37339', ' Worbis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37345', ' Am Ohmberg, Sonnenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37351', ' DingelstÃ¤dt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37355', ' Niederorschel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37359', ' KÃ¼llstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37412', ' Herzberg, Elbingerode, HÃ¶rden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37431', ' Bad Lauterberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37434', ' Gieboldehausen, Rhumequelle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37441', ' Bad Sachsa');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37444', ' Braunlage');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37445', ' Walkenried');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37447', ' Wieda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37449', ' Zorge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37520', ' Osterode am Harz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37539', ' Bad Grund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37574', ' Einbeck, Kreiensen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37581', ' Bad Gandersheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37586', ' Dassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37589', ' Kalefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37603', ' Holzminden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37619', ' Bodenwerder, Pegestorf, Kirchbrak, Hehlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37620', ' Halle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37627', ' Stadtoldendorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37632', ' Holzen, Eschershausen, Eimen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37633', ' Dielmissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37635', ' LÃ¼erdissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37639', ' Bevern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37640', ' Golmbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37642', ' Holenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37643', ' Negenborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37647', ' BrevÃ¶rde, Polle, Vahlbruch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37649', ' Heinsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37671', ' HÃ¶xter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37688', ' Beverungen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37691', ' Boffzen, Derental');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37696', ' MarienmÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37697', ' LauenfÃ¶rde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('37699', ' FÃ¼rstenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38100', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38102', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38104', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38106', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38108', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38110', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38112', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38114', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38116', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38118', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38120', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38122', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38124', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38126', ' Braunschweig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38154', ' KÃ¶nigslutter am Elm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38159', ' Vechelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38162', ' Cremlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38165', ' Lehre');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38170', ' SchÃ¶ppenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38173', ' Sickte, Dettum u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38176', ' Wendeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38179', ' SchwÃ¼lper');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38226', ' Salzgitter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38228', ' Salzgitter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38229', ' Salzgitter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38239', ' Salzgitter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38259', ' Salzgitter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38268', ' Lengede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38271', ' Baddeckenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38272', ' Burgdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38274', ' Elbe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38275', ' Haverlah');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38277', ' Heere');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38279', ' Sehlde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38300', ' WolfenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38302', ' WolfenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38304', ' WolfenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38312', ' Dorstadt, FlÃ¶the, BÃ¶rÃŸum u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38315', ' Schladen-Werla');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38319', ' Remlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38321', ' Denkte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38322', ' Hedeper');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38324', ' KissenbrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38325', ' Roklum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38327', ' Semmenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38329', ' Wittmar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38350', ' Helmstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38364', ' SchÃ¶ningen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38368', ' Rennau, Querenhorst, Mariental, Grasleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38372', ' BÃ¼ddenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38373', ' SÃ¼pplingen, Frellstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38375', ' RÃ¤bke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38376', ' SÃ¼pplingenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38378', ' Warberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38379', ' Wolsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38381', ' Jerxheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38382', ' Beierstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38384', ' Gevensleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38387', ' SÃ¶llingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38440', ' Wolfsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38442', ' Wolfsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38444', ' Wolfsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38446', ' Wolfsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38448', ' Wolfsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38458', ' Velpke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38459', ' Bahrdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38461', ' Danndorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38462', ' Grafhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38464', ' GroÃŸ TwÃ¼lpstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38465', ' Brome');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38467', ' Bergfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38468', ' Ehra-Lessien');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38470', ' Parsau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38471', ' RÃ¼hen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38473', ' Tiddische');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38474', ' TÃ¼lau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38476', ' Barwedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38477', ' Jembke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38479', ' Tappenbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38486', ' KlÃ¶tze, Apenburg-Winterfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38489', ' Beetzendorf, Rohrberg, JÃ¼bar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38518', ' Gifhorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38524', ' Sassenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38527', ' Meine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38528', ' AdenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38530', ' Didderse');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38531', ' RÃ¶tgesbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38533', ' Vordorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38536', ' Meinersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38539', ' MÃ¼den (Aller)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38542', ' Leiferde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38543', ' Hillerse');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38547', ' Calberlah');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38550', ' IsenbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38551', ' RibbesbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38553', ' WasbÃ¼ttel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38554', ' Weyhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38556', ' Bokensdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38557', ' OsloÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38559', ' Wagenhoff, Ringelah');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38640', ' Goslar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38642', ' Goslar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38644', ' Goslar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38667', ' Bad Harzburg, Torfhaus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38678', ' Clausthal-Zellerfeld, Oberschulenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38685', ' Langelsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38690', ' Goslar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38700', ' Braunlage');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38704', ' Liebenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38707', ' Altenau, Schulenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38709', ' Wildemann');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38723', ' Seesen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38729', ' Hahausen, Lutter, Wallmoden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38820', ' Halberstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38822', ' Halberstadt, GroÃŸ Quenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38828', ' Wegeleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38829', ' Harsleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38835', ' Osterwieck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38836', ' Badersleben u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38838', ' Huy');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38855', ' Wernigerode, Nordharz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38871', ' Ilsenburg, Nordharz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38875', ' Oberharz am Brocken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38877', ' Oberharz am Brocken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38879', ' Wernigerode');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38889', ' Blankenburg, Oberharz am Brocken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38895', ' Langenstein, Derenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('38899', ' Oberharz am Brocken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39104', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39106', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39108', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39110', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39112', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39114', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39116', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39118', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39120', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39122', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39124', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39126', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39128', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39130', ' Magdeburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39164', ' Wanzleben-BÃ¶rde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39167', ' Eichenbarleben, Ochtmersleben, Irxleben, Schnarsl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39171', ' SÃ¼lzetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39175', ' Gerwisch, Biederitz, Menz, KÃ¶rbelitz etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39179', ' Barleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39217', ' SchÃ¶nebeck (Elbe)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39218', ' SchÃ¶nebeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39221', ' Welsleben, Biere, Eickendorf, Eggersdorf, GroÃŸmÃ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39240', ' Calbe, Rosenburg, LÃ¶dderitz etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39245', ' Gommern, Dannigkow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39249', ' Barby');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39261', ' Zerbst/Anhalt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39264', ' GÃ¼terglÃ¼ck, LÃ¼bs, Deetz, JÃ¼trichau etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39279', ' Loburg, Leitzkau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39288', ' Burg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39291', ' MÃ¶ckern, Schermen, Nedlitz etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39307', ' Genthin, Hohenseeden, Zabakuck u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39317', ' Elbe-Parey');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39319', ' Jerichow');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39326', ' Wolmirstedt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39340', ' Haldensleben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39343', ' Erxleben, Nordgermersleben u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39345', ' Haldensleben, Flechtingen, BÃ¼lstringen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39356', ' Weferlingen, Behnsdorf, Belsdorf etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39359', ' RÃ¤tzlingen, Wegenstedt, CalvÃ¶rde, BÃ¶ddensell e');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39365', ' Harbke, Sommersdorf, Wefensleben, Ummendorf, Eils');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39387', ' Oschersleben (Bode)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39393', ' HÃ¶tensleben, VÃ¶lpke, Ottleben, Hamersleben etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39397', ' Schwanebeck, GrÃ¶ningen, Kroppenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39418', ' StaÃŸfurt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39435', ' Egeln, Unseburg, Wolmirsleben, Borne etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39439', ' GÃ¼sten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39443', ' StaÃŸfurt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39444', ' Hecklingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39446', ' StaÃŸfurt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39448', ' BÃ¶rde-Hakel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39517', ' TangerhÃ¼tte u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39524', ' Sandau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39539', ' Havelberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39576', ' Stendal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39579', ' Bismark, Rochau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39590', ' TangermÃ¼nde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39596', ' Goldbeck, Arneburg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39599', ' Bismark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39606', ' Osterburg, AltmÃ¤rkische HÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39615', ' Seehausen, Werben, Leppin, Wahrenberg etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39619', ' Arendsee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39624', ' Kalbe, Bismark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39629', ' Bismark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39638', ' Gardelegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39646', ' Oebisfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('39649', ' Gardelegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40210', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40211', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40212', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40213', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40215', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40217', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40219', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40221', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40223', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40225', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40227', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40229', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40231', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40233', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40235', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40237', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40239', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40468', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40470', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40472', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40474', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40476', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40477', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40479', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40489', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40545', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40547', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40549', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40589', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40591', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40593', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40595', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40597', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40599', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40625', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40627', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40629', ' DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40667', ' Meerbusch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40668', ' Meerbusch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40670', ' Meerbusch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40699', ' Erkrath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40721', ' Hilden, DÃ¼sseldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40723', ' Hilden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40724', ' Hilden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40764', ' Langenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40789', ' Monheim am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40822', ' Mettmann');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40878', ' Ratingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40880', ' Ratingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40882', ' Ratingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40883', ' Ratingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('40885', ' Ratingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41061', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41063', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41065', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41066', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41068', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41069', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41169', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41179', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41189', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41199', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41236', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41238', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41239', ' MÃ¶nchengladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41334', ' Nettetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41352', ' Korschenbroich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41363', ' JÃ¼chen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41366', ' Schwalmtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41372', ' NiederkrÃ¼chten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41379', ' BrÃ¼ggen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41460', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41462', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41464', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41466', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41468', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41469', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41470', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41472', ' Neuss');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41515', ' Grevenbroich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41516', ' Grevenbroich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41517', ' Grevenbroich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41539', ' Dormagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41540', ' Dormagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41541', ' Dormagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41542', ' Dormagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41564', ' Kaarst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41569', ' Rommerskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41747', ' Viersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41748', ' Viersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41749', ' Viersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41751', ' Viersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41812', ' Erkelenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41836', ' HÃ¼ckelhoven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41844', ' Wegberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('41849', ' Wassenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42103', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42105', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42107', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42109', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42111', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42113', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42115', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42117', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42119', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42275', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42277', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42279', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42281', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42283', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42285', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42287', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42289', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42327', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42329', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42349', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42369', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42389', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42399', ' Wuppertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42477', ' Radevormwald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42489', ' WÃ¼lfrath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42499', ' HÃ¼ckeswagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42549', ' Velbert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42551', ' Velbert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42553', ' Velbert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42555', ' Velbert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42579', ' Heiligenhaus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42651', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42653', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42655', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42657', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42659', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42697', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42699', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42719', ' Solingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42781', ' Haan');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42799', ' Leichlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42853', ' Remscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42855', ' Remscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42857', ' Remscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42859', ' Remscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42897', ' Remscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42899', ' Remscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('42929', ' Wermelskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44135', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44137', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44139', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44141', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44143', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44145', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44147', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44149', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44225', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44227', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44229', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44263', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44265', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44267', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44269', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44287', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44289', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44309', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44319', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44328', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44329', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44339', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44357', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44359', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44369', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44379', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44388', ' Dortmund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44532', ' LÃ¼nen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44534', ' LÃ¼nen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44536', ' LÃ¼nen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44575', ' Castrop-Rauxel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44577', ' Castrop-Rauxel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44579', ' Castrop-Rauxel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44581', ' Castrop-Rauxel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44623', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44625', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44627', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44628', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44629', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44649', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44651', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44652', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44653', ' Herne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44787', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44789', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44791', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44793', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44795', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44797', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44799', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44801', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44803', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44805', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44807', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44809', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44866', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44867', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44869', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44879', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44892', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('44894', ' Bochum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45127', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45128', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45130', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45131', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45133', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45134', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45136', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45138', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45139', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45141', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45143', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45144', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45145', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45147', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45149', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45219', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45239', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45257', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45259', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45276', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45277', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45279', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45289', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45307', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45309', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45326', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45327', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45329', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45355', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45356', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45357', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45359', ' Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45468', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45470', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45472', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45473', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45475', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45476', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45478', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45479', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45481', ' MÃ¼lheim an der Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45525', ' Hattingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45527', ' Hattingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45529', ' Hattingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45549', ' SprockhÃ¶vel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45657', ' Recklinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45659', ' Recklinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45661', ' Recklinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45663', ' Recklinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45665', ' Recklinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45699', ' Herten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45701', ' Herten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45711', ' Datteln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45721', ' Haltern am See');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45731', ' Waltrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45739', ' Oer-Erkenschwick');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45768', ' Marl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45770', ' Marl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45772', ' Marl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45879', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45881', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45883', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45884', ' Gelsenkirchen Rotthausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45886', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45888', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45889', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45891', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45892', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45894', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45896', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45897', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45899', ' Gelsenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45964', ' Gladbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45966', ' Gladbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('45968', ' Gladbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46045', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46047', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46049', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46117', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46119', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46145', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46147', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46149', ' Oberhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46236', ' Bottrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46238', ' Bottrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46240', ' Bottrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46242', ' Bottrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46244', ' Bottrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46282', ' Dorsten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46284', ' Dorsten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46286', ' Dorsten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46325', ' Borken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46342', ' Velen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46348', ' Raesfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46354', ' SÃ¼dlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46359', ' Heiden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46395', ' Bocholt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46397', ' Bocholt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46399', ' Bocholt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46414', ' Rhede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46419', ' Isselburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46446', ' Emmerich am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46459', ' Rees');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46483', ' Wesel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46485', ' Wesel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46487', ' Wesel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46499', ' Hamminkeln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46509', ' Xanten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46514', ' Schermbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46519', ' Alpen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46535', ' Dinslaken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46537', ' Dinslaken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46539', ' Dinslaken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46562', ' Voerde (Niederrhein)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('46569', ' HÃ¼nxe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47051', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47053', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47055', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47057', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47058', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47059', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47119', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47137', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47138', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47139', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47166', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47167', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47169', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47178', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47179', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47198', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47199', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47226', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47228', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47229', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47239', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47249', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47259', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47269', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47279', ' Duisburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47441', ' Moers');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47443', ' Moers');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47445', ' Moers');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47447', ' Moers');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47475', ' Kamp-Lintfort');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47495', ' Rheinberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47506', ' Neukirchen-Vluyn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47509', ' Rheurdt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47533', ' Kleve');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47546', ' Kalkar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47551', ' Bedburg-Hau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47559', ' Kranenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47574', ' Goch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47589', ' Uedem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47608', ' Geldern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47623', ' Kevelaer-Mitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47624', ' Kevelaer-Twisteden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47625', ' Kevelaer-Wetten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47626', ' Kevelaer-Winnekendonk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47627', ' Kevelaer-Kervenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47638', ' Straelen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47647', ' Kerken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47652', ' Weeze');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47661', ' Issum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47665', ' Sonsbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47669', ' Wachtendonk');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47798', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47799', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47800', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47802', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47803', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47804', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47805', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47807', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47809', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47829', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47839', ' Krefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47877', ' Willich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47906', ' Kempen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47918', ' TÃ¶nisvorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('47929', ' Grefrath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48143', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48145', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48147', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48149', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48151', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48153', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48155', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48157', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48159', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48161', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48163', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48165', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48167', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48231', ' Warendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48249', ' DÃ¼lmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48268', ' Greven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48282', ' Emsdetten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48291', ' Telgte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48301', ' Nottuln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48308', ' Senden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48317', ' Drensteinfurt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48324', ' Sendenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48329', ' Havixbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48336', ' Sassenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48341', ' Altenberge');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48346', ' Ostbevern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48351', ' Everswinkel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48356', ' Nordwalde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48361', ' Beelen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48366', ' Laer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48369', ' Saerbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48429', ' Rheine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48431', ' Rheine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48432', ' Rheine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48455', ' Bad Bentheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48465', ' Engden, Isterberg, SchÃ¼ttorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48477', ' HÃ¶rstel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48480', ' LÃ¼nne, Schapen, Spelle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48485', ' Neuenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48488', ' EmsbÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48493', ' Wettringen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48496', ' Hopsten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48499', ' Salzbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48527', ' Nordhorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48529', ' Nordhorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48531', ' Nordhorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48565', ' Steinfurt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48599', ' Gronau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48607', ' Ochtrup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48612', ' Horstmar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48619', ' Heek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48624', ' SchÃ¶ppingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48629', ' Metelen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48653', ' Coesfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48683', ' Ahaus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48691', ' Vreden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48703', ' Stadtlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48712', ' Gescher');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48720', ' Rosendahl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48727', ' Billerbeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48734', ' Reken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('48739', ' Legden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49074', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49076', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49078', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49080', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49082', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49084', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49086', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49088', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49090', ' OsnabrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49124', ' GeorgsmarienhÃ¼tte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49134', ' Wallenhorst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49143', ' Bissendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49152', ' Bad Essen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49163', ' Bohmte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49170', ' Hagen am Teutoburger Wald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49176', ' Hilter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49179', ' Ostercappeln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49186', ' Bad Iburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49191', ' Belm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49196', ' Bad Laer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49201', ' Dissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49205', ' Hasbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49214', ' Bad Rothenfelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49219', ' Glandorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49324', ' Melle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49326', ' Melle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49328', ' Melle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49356', ' Diepholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49377', ' Vechta');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49393', ' Lohne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49401', ' Damme');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49406', ' Barnstorf, Eydelstedt, Drentwede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49413', ' Dinklage');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49419', ' Wagenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49424', ' Goldenstedt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49429', ' Visbek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49434', ' Neuenkirchen-VÃ¶rden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49439', ' Steinfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49448', ' LemfÃ¶rde u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49451', ' Holdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49453', ' Barver, Dickel, Hemsloh, Rehden, Wetschen, Wehrbl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49456', ' Bakum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49457', ' Drebber');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49459', ' Lembruch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49477', ' IbbenbÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49479', ' IbbenbÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49492', ' Westerkappeln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49497', ' Mettingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49504', ' Lotte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49509', ' Recke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49525', ' Lengerich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49536', ' Lienen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49545', ' Tecklenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49549', ' Ladbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49565', ' Bramsche');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49577', ' Kettenkamp, EggermÃ¼hlen, Ankum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49584', ' FÃ¼rstenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49586', ' Merzen, Neuenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49593', ' BersenbrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49594', ' Alfhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49596', ' Gehrde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49597', ' Rieste');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49599', ' Voltlage');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49610', ' QuakenbrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49624', ' LÃ¶ningen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49626', ' Berge, Bippen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49632', ' Essen (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49635', ' Badbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49637', ' Menslage');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49638', ' Nortrup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49661', ' Cloppenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49681', ' Garrel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49685', ' Emstek');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49688', ' Lastrup');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49692', ' Cappeln (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49696', ' Molbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49699', ' Lindern (Oldenburg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49716', ' Meppen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49733', ' Haren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49740', ' HaselÃ¼nne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49744', ' Geeste');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49751', ' SÃ¶gel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49757', ' Werlte, Vrees, Lahn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49762', ' Sustrum, Lathen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49767', ' Twist');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49770', ' Herzlake, Dohren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49774', ' LÃ¤hden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49777', ' Stavern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49779', ' Oberlangen, Niederlangen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49808', ' Lingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49809', ' Lingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49811', ' Lingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49824', ' Ringe, Laar, Emlichheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49828', ' Esche, Georgsdorf, Lage, Neuenhaus, Osterwald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49832', ' Andervenne, Beesten, Freren, Messingen, Thuine');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49835', ' Wietmarschen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49838', ' Lengerich u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49843', ' Uelsen, Halle, GÃ¶lenkamp, Getelo');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49844', ' Bawinkel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49846', ' Hoogstede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49847', ' Itterbeck/Wielen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('49849', ' Wilsum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50126', ' Bergheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50127', ' Bergheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50129', ' Bergheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50169', ' Kerpen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50170', ' Kerpen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50171', ' Kerpen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50181', ' Bedburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50189', ' Elsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50226', ' Frechen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50259', ' Pulheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50321', ' BrÃ¼hl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50354', ' HÃ¼rth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50374', ' Erftstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50389', ' Wesseling');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50667', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50668', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50670', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50672', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50674', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50676', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50677', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50678', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50679', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50733', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50735', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50737', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50739', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50765', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50767', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50769', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50823', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50825', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50827', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50829', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50858', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50859', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50931', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50933', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50935', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50937', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50939', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50968', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50969', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50996', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50997', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('50999', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51061', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51063', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51065', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51067', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51069', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51103', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51105', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51107', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51109', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51143', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51145', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51147', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51149', ' KÃ¶ln');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51371', ' Leverkusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51373', ' Leverkusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51375', ' Leverkusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51377', ' Leverkusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51379', ' Leverkusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51381', ' Leverkusen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51399', ' Burscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51427', ' Bergisch Gladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51429', ' Bergisch Gladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51465', ' Bergisch Gladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51467', ' Bergisch Gladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51469', ' Bergisch Gladbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51491', ' Overath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51503', ' RÃ¶srath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51515', ' KÃ¼rten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51519', ' Odenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51545', ' WaldbrÃ¶l');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51570', ' Windeck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51580', ' Reichshof');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51588', ' NÃ¼mbrecht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51597', ' Morsbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51598', ' Friesenhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51643', ' Gummersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51645', ' Gummersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51647', ' Gummersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51674', ' Wiehl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51688', ' WipperfÃ¼rth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51702', ' Bergneustadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51709', ' Marienheide');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51766', ' Engelskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('51789', ' Lindlar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52062', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52064', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52066', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52068', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52070', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52072', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52074', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52076', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52078', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52080', ' Aachen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52134', ' Herzogenrath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52146', ' WÃ¼rselen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52152', ' Simmerath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52156', ' Monschau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52159', ' Roetgen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52222', ' Stolberg (Rhld.)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52223', ' Stolberg (Rhld.)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52224', ' Stolberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52249', ' Eschweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52349', ' DÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52351', ' DÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52353', ' DÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52355', ' DÃ¼ren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52372', ' Kreuzau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52379', ' Langerwehe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52382', ' Niederzier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52385', ' Nideggen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52388', ' NÃ¶rvenich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52391', ' VettweiÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52393', ' HÃ¼rtgenwald');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52396', ' Heimbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52399', ' Merzenich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52428', ' JÃ¼lich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52441', ' Linnich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52445', ' Titz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52457', ' Aldenhoven');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52459', ' Inden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52477', ' Alsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52499', ' Baesweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52511', ' Geilenkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52525', ' Waldfeucht, Heinsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52531', ' Ãœbach-Palenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('52538', ' Gangelt, Selfkant');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53111', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53113', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53115', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53117', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53119', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53121', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53123', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53125', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53127', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53129', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53173', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53175', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53177', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53179', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53225', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53227', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53229', ' Bonn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53332', ' Bornheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53340', ' Meckenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53343', ' Wachtberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53347', ' Alfter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53359', ' Rheinbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53424', ' Remagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53426', ' Schalkenbach, KÃ¶nigsfeld, Dedenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53474', ' Bad Neuenahr-Ahrweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53489', ' Sinzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53498', ' Bad Breisig, Waldorf, GÃ¶nnersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53501', ' Grafschaft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53505', ' Altenahr, Berg, Kalenborn, Kirchsahr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53506', ' AhrbrÃ¼ck, Heckenbach, HÃ¶nningen, Kesseling, Rec');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53507', ' Dernau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53508', ' MayschoÃŸ');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53518', ' Adenau, Kottenborn u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53520', ' Reifferscheid, Kaltenborn, Wershofen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53533', ' Antweiler, Aremberg, Dorsel, Eichenbach, Aremberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53534', ' Barweiler, Bauler, Hoffeld, Pomster, Wiesemscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53539', ' Bodenbach, Kelberg, Kirsbach u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53545', ' Linz am Rhein, Ockenfels');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53547', ' Breitscheid, Dattenberg, Hausen, HÃ¼mmerich, Kasb');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53557', ' Bad HÃ¶nningen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53560', ' VettelschloÃŸ, Kretzhaus (Linz am Rhein)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53562', ' Sankt Katharinen (Landkreis Neuwied)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53567', ' Asbach, Buchholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53572', ' Bruchhausen, Unkel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53577', ' Neustadt (Wied)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53578', ' Windhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53579', ' Erpel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53604', ' Bad Honnef');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53619', ' Rheinbreitbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53639', ' KÃ¶nigswinter');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53721', ' Siegburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53757', ' Sankt Augustin');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53773', ' Hennef (Sieg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53783', ' Eitorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53797', ' Lohmar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53804', ' Much');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53809', ' Ruppichteroth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53819', ' Neunkirchen-Seelscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53840', ' Troisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53842', ' Troisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53844', ' Troisdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53859', ' Niederkassel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53879', ' Euskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53881', ' Euskirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53894', ' Mechernich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53902', ' Bad MÃ¼nstereifel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53909', ' ZÃ¼lpich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53913', ' Swisttal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53919', ' Weilerswist');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53925', ' Kall');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53937', ' Schleiden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53940', ' Hellenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53945', ' Blankenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53947', ' Nettersheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('53949', ' Dahlem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54290', ' Trier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54292', ' Trier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54293', ' Trier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54294', ' Trier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54295', ' Trier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54296', ' Trier');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54298', ' Welschbillig, Igel, Aach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54306', ' Kordel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54308', ' Langsur');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54309', ' Newel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54310', ' Ralingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54311', ' Trierweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54313', ' Zemmer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54314', ' Zerf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54316', ' Pluwig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54317', ' Osburg, Gusterath, Farschweiler, Kasel u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54318', ' Mertesdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54320', ' Waldrach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54329', ' Konz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54331', ' Pellingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54332', ' Wasserliesch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54338', ' Schweich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54340', ' Leiwen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54341', ' Fell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54343', ' FÃ¶hren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54344', ' Kenn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54346', ' Mehring');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54347', ' Neumagen-Dhron');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54349', ' Trittenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54411', ' Deuselbach, Hermeskeil, Rorodt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54413', ' Gusenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54421', ' Reinsfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54422', ' NeuhÃ¼tten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54424', ' Thalfang');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54426', ' Malborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54427', ' Kell am See');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54429', ' Schillingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54439', ' Saarburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54441', ' Ayl, Trassem u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54450', ' Freudenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54451', ' Irsch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54453', ' Nittel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54455', ' Serrig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54456', ' Tawern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54457', ' Wincheringen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54459', ' Wiltingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54470', ' Bernkastel-Kues u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54472', ' Monzelfeld, Hochscheid u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54483', ' Kleinich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54484', ' Maring-Noviand');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54486', ' MÃ¼lheim (Mosel)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54487', ' Wintrich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54492', ' Zeltingen-Rachtig, Erden, LÃ¶snich u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54497', ' Morbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54498', ' Piesport');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54516', ' Wittlich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54518', ' Binsfeld, HeckenmÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54523', ' Hetzerath, Dierscheid, HeckenmÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54524', ' Klausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54526', ' Landscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54528', ' Salmtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54529', ' Spangdahlem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54531', ' Manderscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54533', ' Bettenfeld, NiederÃ¶fflingen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54534', ' GroÃŸlittgen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54536', ' KrÃ¶v');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54538', ' Bausendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54539', ' Ãœrzig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54550', ' Daun');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54552', ' Mehren u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54558', ' Gillenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54568', ' Gerolstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54570', ' Pelm, Neroth u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54574', ' Birresborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54576', ' Hillesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54578', ' Walsdorf, Nohn u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54579', ' Ãœxheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54584', ' JÃ¼nkerath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54585', ' Esch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54586', ' SchÃ¼ller');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54587', ' Lissendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54589', ' Stadtkyll');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54595', ' PrÃ¼m');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54597', ' Pronsfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54608', ' Bleialf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54610', ' BÃ¼desheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54611', ' Hallschlag');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54612', ' Lasel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54614', ' SchÃ¶necken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54616', ' Winterspelt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54617', ' LÃ¼tzkampen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54619', ' Ãœttfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54634', ' Bitburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54636', ' Rittersdorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54646', ' Bettingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54647', ' Dudeldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54649', ' Waxweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54655', ' Kyllburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54657', ' Badem, Gindorf, Neidenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54662', ' Speicher');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54664', ' Preist');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54666', ' Irrel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54668', ' Ferschweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54669', ' Bollendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54673', ' Neuerburg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54675', ' KÃ¶rperich u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54687', ' Arzfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('54689', ' Daleiden, Preischeid u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55116', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55118', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55120', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55122', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55124', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55126', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55127', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55128', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55129', ' Mainz Ebersheim, Hechtsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55130', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55131', ' Mainz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55218', ' Ingelheim am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55232', ' Alzey');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55234', ' Albig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55237', ' Flonheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55239', ' Gau-Odernheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55246', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55252', ' Mainz-Kastel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55257', ' Budenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55262', ' Heidesheim am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55263', ' Wackernheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55268', ' Nieder-Olm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55270', ' Ober-Olm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55271', ' Stadecken-Elsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55276', ' Oppenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55278', ' Mommenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55283', ' Nierstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55286', ' WÃ¶rrstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55288', ' Armsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55291', ' Saulheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55294', ' Bodenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55296', ' Harxheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55299', ' Nackenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55411', ' Bingen am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55413', ' Weiler bei Bingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55422', ' Bacharach, Breitscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55424', ' MÃ¼nster-Sarmsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55425', ' Waldalgesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55430', ' Oberwesel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55432', ' Niederburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55435', ' Gau-Algesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55437', ' Ockenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55442', ' Stromberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55444', ' Seibersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55450', ' Langenlonsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55452', ' Guldental');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55457', ' Gensingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55459', ' Aspisheim, Grolsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55469', ' Simmern/HunsrÃ¼ck u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55471', ' Tiefenbach u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55481', ' Kirchberg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55483', ' Dickenschied u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55487', ' Sohren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55490', ' GemÃ¼nden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55491', ' BÃ¼chenbeuren');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55494', ' RheinbÃ¶llen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55496', ' Argenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55497', ' Ellern (HunsrÃ¼ck), Schnorbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55499', ' Riesweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55543', ' Bad Kreuznach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55545', ' Bad Kreuznach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55546', ' Hackenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55559', ' Bretzenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55566', ' Sobernheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55568', ' Staudernheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55569', ' Monzingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55571', ' Odernheim am Glan');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55576', ' Sprendlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55578', ' Wallertheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55583', ' Bad Kreuznach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55585', ' Norheim u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55590', ' Meisenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55592', ' Rehborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55593', ' RÃ¼desheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55595', ' Hargesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55596', ' WaldbÃ¶ckelheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55597', ' WÃ¶llstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55599', ' Gau-Bickelheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55606', ' Kirn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55608', ' Bergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55618', ' Simmertal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55619', ' Hennweiler');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55621', ' Hundsbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55624', ' Rhaunen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55626', ' Bundenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55627', ' Merxheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55629', ' Seesbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55743', ' Idar-Oberstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55756', ' Herrstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55758', ' NiederwÃ¶rresbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55765', ' Birkenfeld u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55767', ' BrÃ¼cken, Oberbrombach u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55768', ' HoppstÃ¤dten-Weiersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55774', ' Baumholder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55776', ' Berglangenbach, Ruschberg u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55777', ' Berschweiler bei Baumholder');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('55779', ' Heimbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56068', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56070', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56072', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56073', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56075', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56076', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56077', ' Koblenz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56112', ' Lahnstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56130', ' Bad Ems');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56132', ' Dausenau, Nievern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56133', ' Fachbach, Exklave Lahnstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56154', ' Boppard');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56170', ' Bendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56179', ' Vallendar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56182', ' Urbar (bei Koblenz)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56191', ' Weitersburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56203', ' HÃ¶hr-Grenzhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56204', ' Hillscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56206', ' Hilgert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56218', ' MÃ¼lheim-KÃ¤rlich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56220', ' Urmitz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56235', ' Ransbach-Baumbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56237', ' Nauort');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56242', ' Selters (Westerwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56244', ' Freilingen, Freirachdorf u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56249', ' Herschbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56253', ' Treis-Karden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56254', ' MÃ¼den');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56269', ' Dierdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56271', ' Kleinmaischeid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56276', ' GroÃŸmaischeid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56281', ' Emmelshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56283', ' Wildenbungert, Gondershausen, NÃ¶rtershausen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56288', ' Kastellaun');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56290', ' Beltheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56291', ' Leiningen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56294', ' MÃ¼nstermaifeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56295', ' Lonnig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56299', ' Ochtendung');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56305', ' Puderbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56307', ' DÃ¼rrholz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56316', ' Raubach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56317', ' Urbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56321', ' Rhens');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56322', ' Spay');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56323', ' Waldesch, HÃ¼nenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56329', ' Sankt Goar');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56330', ' Kobern-Gondorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56332', ' Lehmen, Niederfell, Oberfell, Wolken u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56333', ' Winningen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56335', ' NeuhÃ¤usel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56337', ' Eitelborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56338', ' Braubach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56340', ' Osterspai');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56341', ' Kamp-Bornhofen-Filsen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56346', ' Sankt Goarshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56348', ' Bornich, Patersberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56349', ' Kaub');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56355', ' NastÃ¤tten u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56357', ' Miehlen u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56368', ' Katzenelnbogen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56370', ' SchÃ¶nborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56377', ' Nassau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56379', ' Singhofen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56410', ' Montabaur');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56412', ' Nentershausen, HÃ¼bingen, Niederelbert u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56414', ' Meudt, Molsberg, Hundsangen, Niederahr u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56422', ' Wirges, Stadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56424', ' Mogendorf, Ebernhahn, Staudt u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56427', ' Siershahn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56428', ' Dernbach (Westerwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56457', ' Westerburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56459', ' Bellingen, KÃ¶lbingen, GemÃ¼nden etc');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56462', ' HÃ¶hn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56470', ' Bad Marienberg (Westerwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56472', ' Nisterau u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56477', ' Rennerod, Zehnhausen, Nister-MÃ¶hrendorf, Waigand');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56479', ' Oberrod u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56564', ' Neuwied');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56566', ' Neuwied');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56567', ' Neuwied');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56575', ' WeiÃŸenthurm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56579', ' Rengsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56581', ' Melsbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56584', ' Anhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56587', ' StraÃŸenhaus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56588', ' Waldbreitbach, Hasuen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56589', ' Niederbreitbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56593', ' Horhausen (Westerwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56594', ' Willroth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56598', ' Rheinbrohl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56599', ' Leutesdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56626', ' Andernach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56630', ' Kretz');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56637', ' Plaidt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56642', ' Kruft');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56645', ' Nickenich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56648', ' Saffig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56651', ' Niederzissen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56653', ' Wehr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56656', ' Brohl-LÃ¼tzing');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56659', ' Burgbrohl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56727', ' Mayen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56729', ' Ettringen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56736', ' Kottenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56743', ' Mendig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56745', ' Bell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56746', ' Kempenich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56751', ' Polch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56753', ' Mertloch, Welling u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56754', ' Binningen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56759', ' Kaisersesch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56761', ' DÃ¼ngenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56766', ' Ulmen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56767', ' Uersfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56769', ' Retterath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56812', ' Cochem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56814', ' Ediger-Eller');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56818', ' Klotten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56820', ' Senheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56821', ' Ellenz-Poltersdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56823', ' BÃ¼chel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56825', ' Gevenich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56826', ' Lutzerath');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56828', ' Alflen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56829', ' Pommern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56841', ' Traben-Trarbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56843', ' Irmenach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56850', ' Enkirch u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56856', ' Zell (Mosel)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56858', ' Peterswald-LÃ¶ffelscheid u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56859', ' Bullay, Alf, Zell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56861', ' Reil');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56862', ' PÃ¼nderich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56864', ' Bad Bertrich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56865', ' Blankenrath u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56867', ' Briedel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('56869', ' Mastershausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57072', ' Siegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57074', ' Siegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57076', ' Siegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57078', ' Siegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57080', ' Siegen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57223', ' Kreuztal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57234', ' Wilnsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57250', ' Netphen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57258', ' Freudenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57271', ' Hilchenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57290', ' Neunkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57299', ' Burbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57319', ' Bad Berleburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57334', ' Bad Laasphe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57339', ' ErndtebrÃ¼ck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57368', ' Lennestadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57392', ' Schmallenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57399', ' Kirchhundem');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57413', ' Finnentrop');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57439', ' Attendorn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57462', ' Olpe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57482', ' Wenden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57489', ' Drolshagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57518', ' Betzdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57520', ' Emmerzhausen, Niederdreisbach, Steinebach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57537', ' Wissen, HÃ¶vels u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57539', ' FÃ¼rthen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57548', ' Kirchen (Sieg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57555', ' Mudersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57562', ' Herdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57567', ' Daaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57572', ' Niederfischbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57577', ' Hamm (Sieg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57578', ' Elkenroth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57580', ' Gebhardshain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57581', ' Katzwinkel (Sieg)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57583', ' Nauroth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57584', ' Scheuerfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57586', ' Weitefeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57587', ' Birken-Honigsessen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57589', ' Pracht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57610', ' Altenkirchen (Westerwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57612', ' Birnbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57614', ' Steimel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57627', ' Hachenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57629', ' Malberg, Norken, HÃ¶chstenbach u.a.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57632', ' Flammersfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57635', ' Weyerbusch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57636', ' Mammelzen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57638', ' Neitersen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57639', ' Oberdreis');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57641', ' Oberlahr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57642', ' Alpenrod');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57644', ' Hattert');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57645', ' Nister');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57647', ' Nistertal, Enspel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('57648', ' Unnau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58089', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58091', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58093', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58095', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58097', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58099', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58119', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58135', ' Hagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58239', ' Schwerte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58256', ' Ennepetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58285', ' Gevelsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58300', ' Wetter (Ruhr)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58313', ' Herdecke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58332', ' Schwelm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58339', ' Breckerfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58452', ' Witten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58453', ' Witten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58454', ' Witten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58455', ' Witten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58456', ' Witten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58507', ' LÃ¼denscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58509', ' LÃ¼denscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58511', ' LÃ¼denscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58513', ' LÃ¼denscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58515', ' LÃ¼denscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58540', ' Meinerzhagen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58553', ' Halver');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58566', ' Kierspe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58579', ' SchalksmÃ¼hle');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58636', ' Iserlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58638', ' Iserlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58640', ' Iserlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58642', ' Iserlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58644', ' Iserlohn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58675', ' Hemer');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58706', ' Menden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58708', ' Menden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58710', ' Menden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58730', ' FrÃ¶ndenberg/Ruhr');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58739', ' Wickede (Ruhr)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58762', ' Altena');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58769', ' Nachrodt-Wiblingwerde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58791', ' Werdohl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58802', ' Balve');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58809', ' Neuenrade');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58840', ' Plettenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('58849', ' Herscheid');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59063', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59065', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59067', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59069', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59071', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59073', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59075', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59077', ' Hamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59174', ' Kamen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59192', ' Bergkamen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59199', ' BÃ¶nen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59227', ' Ahlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59229', ' Ahlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59269', ' Beckum');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59302', ' Oelde');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59320', ' Ennigerloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59329', ' Wadersloh');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59348', ' LÃ¼dinghausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59368', ' Werne');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59379', ' Selm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59387', ' Ascheberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59394', ' Nordkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59399', ' Olfen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59423', ' Unna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59425', ' Unna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59427', ' Unna');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59439', ' Holzwickede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59457', ' Werl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59469', ' Ense');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59494', ' Soest');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59505', ' Bad Sassendorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59510', ' Lippetal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59514', ' Welver');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59519', ' MÃ¶hnesee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59555', ' Lippstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59556', ' Lippstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59557', ' Lippstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59558', ' Lippstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59581', ' Warstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59590', ' Geseke');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59597', ' Erwitte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59602', ' RÃ¼then');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59609', ' AnrÃ¶chte');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59755', ' Arnsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59757', ' Arnsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59759', ' Arnsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59821', ' Arnsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59823', ' Arnsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59846', ' Sundern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59872', ' Meschede');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59889', ' Eslohe');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59909', ' Bestwig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59929', ' Brilon');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59939', ' Olsberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59955', ' Winterberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59964', ' Medebach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('59969', ' Bromskirchen, Hallenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60306', ' Frankfurt am Main, Opernturm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60308', ' Frankfurt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60310', ' Frankfurt am Main (Taunusturm)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60311', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60313', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60314', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60316', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60318', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60320', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60322', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60323', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60325', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60326', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60327', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60329', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60385', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60386', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60388', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60389', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60431', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60433', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60435', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60437', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60438', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60439', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60486', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60487', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60488', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60489', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60528', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60529', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60549', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60594', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60596', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60598', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('60599', ' Frankfurt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61118', ' Bad Vilbel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61130', ' Nidderau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61137', ' SchÃ¶neck');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61138', ' Niederdorfelden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61169', ' Friedberg (Hessen)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61184', ' Karben');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61191', ' Rosbach v.d. HÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61194', ' Niddatal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61197', ' Florstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61200', ' WÃ¶lfersheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61203', ' Reichelsheim (Wetterau)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61206', ' WÃ¶llstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61209', ' Echzell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61231', ' Bad Nauheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61239', ' Ober-MÃ¶rlen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61250', ' Usingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61267', ' Neu-Anspach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61273', ' Wehrheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61276', ' Weilrod');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61279', ' GrÃ¤venwiesbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61348', ' Bad Homburg v.d. HÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61350', ' Bad Homburg v.d. HÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61352', ' Bad Homburg v.d. HÃ¶he');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61381', ' Friedrichsdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61389', ' Schmitten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61440', ' Oberursel (Taunus)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61449', ' Steinbach (Taunus)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61462', ' KÃ¶nigstein im Taunus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61476', ' Kronberg im Taunus');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('61479', ' GlashÃ¼tten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63065', ' Offenbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63067', ' Offenbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63069', ' Offenbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63071', ' Offenbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63073', ' Offenbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63075', ' Offenbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63110', ' Rodgau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63128', ' Dietzenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63150', ' Heusenstamm');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63165', ' MÃ¼hlheim am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63179', ' Obertshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63225', ' Langen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63263', ' Neu-Isenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63303', ' Dreieich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63322', ' RÃ¶dermark');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63329', ' Egelsbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63450', ' Hanau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63452', ' Hanau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63454', ' Hanau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63456', ' Hanau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63457', ' Hanau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63477', ' Maintal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63486', ' BruchkÃ¶bel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63500', ' Seligenstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63505', ' Langenselbold');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63512', ' Hainburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63517', ' Rodenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63526', ' Erlensee');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63533', ' Mainhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63538', ' GroÃŸkrotzenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63543', ' Neuberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63546', ' Hammersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63549', ' Ronneburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63571', ' Gelnhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63579', ' Freigericht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63584', ' GrÃ¼ndau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63589', ' Linsengericht');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63594', ' Hasselroth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63599', ' BiebergemÃ¼nd');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63607', ' WÃ¤chtersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63619', ' Bad Orb');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63628', ' Bad Soden-SalmÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63633', ' Birstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63636', ' Brachttal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63637', ' Jossgrund');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63639', ' FlÃ¶rsbachtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63654', ' BÃ¼dingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63667', ' Nidda');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63674', ' Altenstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63679', ' Schotten');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63683', ' Ortenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63688', ' Gedern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63691', ' Ranstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63694', ' Limeshain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63695', ' Glauburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63697', ' Hirzenhain');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63699', ' Kefenrod');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63739', ' Aschaffenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63741', ' Aschaffenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63743', ' Aschaffenburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63755', ' Alzenau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63762', ' GroÃŸostheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63768', ' HÃ¶sbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63773', ' Goldbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63776', ' MÃ¶mbris');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63785', ' Obernburg a.Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63791', ' Karlstein am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63796', ' Kahl am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63801', ' Kleinostheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63808', ' Haibach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63811', ' Stockstadt am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63814', ' Mainaschaff');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63820', ' Elsenfeld');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63825', ' SchÃ¶llkrippen, Blankenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63826', ' Geiselbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63828', ' Kleinkahl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63829', ' Krombach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63831', ' Wiesen, Wiesener Forst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63834', ' Sulzbach am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63839', ' Kleinwallstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63840', ' Hausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63843', ' Niedernberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63846', ' Laufach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63849', ' Leidersbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63853', ' MÃ¶mlingen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63856', ' Bessenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63857', ' Waldaschaff, Waldaschaffer Forst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63860', ' Rothenbuch, Rothenbucher Forst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63863', ' Eschau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63864', ' Glattbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63867', ' Johannesberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63868', ' GroÃŸwallstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63869', ' HeigenbrÃ¼cken');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63871', ' Heinrichsthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63872', ' Heimbuchenthal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63874', ' Dammbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63875', ' Mespelbrunn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63877', ' Sailauf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63879', ' Weibersbrunn, Rohrbrunner Forst');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63897', ' Miltenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63906', ' Erlenbach a.Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63911', ' Klingenberg a. Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63916', ' Amorbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63920', ' GroÃŸheubach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63924', ' Kleinheubach, RÃ¼denau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63925', ' Laudenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63927', ' BÃ¼rgstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63928', ' EichenbÃ¼hl');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63930', ' Neunkirchen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63931', ' Kirchzell');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63933', ' MÃ¶nchberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63934', ' RÃ¶llbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63936', ' Schneeberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63937', ' Weilbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('63939', ' WÃ¶rth a.Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64283', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64285', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64287', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64289', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64291', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64293', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64295', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64297', ' Darmstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64319', ' Pfungstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64331', ' Weiterstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64342', ' Seeheim-Jugenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64347', ' Griesheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64354', ' Reinheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64367', ' MÃ¼hltal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64372', ' Ober-Ramstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64380', ' RoÃŸdorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64385', ' Reichelsheim (Odenwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64390', ' Erzhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64395', ' Brensbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64397', ' Modautal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64401', ' GroÃŸ-Bieberau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64404', ' Bickenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64405', ' Fischbachtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64407', ' FrÃ¤nkisch-Crumbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64409', ' Messel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64521', ' GroÃŸ-Gerau');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64546', ' MÃ¶rfelden-Walldorf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64560', ' Riedstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64569', ' Nauheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64572', ' BÃ¼ttelborn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64579', ' Gernsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64584', ' Biebesheim am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64589', ' Stockstadt am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64625', ' Bensheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64646', ' Heppenheim (BergstraÃŸe)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64653', ' Lorsch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64658', ' FÃ¼rth');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64665', ' Alsbach-HÃ¤hnlein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64668', ' Rimbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64673', ' Zwingenberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64678', ' Lindenfels');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64683', ' Einhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64686', ' Lautertal (Odenwald)');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64689', ' Grasellenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64711', ' Erbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64720', ' Michelstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64732', ' Bad KÃ¶nig');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64739', ' HÃ¶chst i. Odw.');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64747', ' Breuberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64750', ' LÃ¼tzelbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64753', ' Brombachtal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64754', ' Badisch SchÃ¶llenbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64756', ' Mossautal');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64757', ' Unter-Hainbrunn');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64760', ' Oberzent');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64807', ' Dieburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64823', ' GroÃŸ-Umstadt');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64832', ' Babenhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64839', ' MÃ¼nster');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64846', ' GroÃŸ-Zimmern');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64850', ' Schaafheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64853', ' Otzberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('64859', ' Eppertshausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65183', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65185', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65187', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65189', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65191', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65193', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65195', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65197', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65199', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65201', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65203', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65205', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65207', ' Wiesbaden');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65232', ' Taunusstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65239', ' Hochheim am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65307', ' Bad Schwalbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65321', ' Heidenrod');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65326', ' Aarbergen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65329', ' Hohenstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65343', ' Eltville am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65344', ' Eltville am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65345', ' Eltville am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65346', ' Eltville am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65347', ' Eltville am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65366', ' Geisenheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65375', ' Oestrich-Winkel');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65385', ' RÃ¼desheim am Rhein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65388', ' Schlangenbad');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65391', ' Lorch');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65396', ' Walluf');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65399', ' Kiedrich');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65428', ' RÃ¼sselsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65439', ' FlÃ¶rsheim am Main');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65451', ' Kelsterbach');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65462', ' Ginsheim-Gustavsburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65468', ' Trebur');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65474', ' Bischofsheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65479', ' Raunheim');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65510', ' HÃ¼nstetten, Idstein');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65520', ' Bad Camberg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65527', ' Niedernhausen');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65529', ' Waldems');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65549', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65550', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65551', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65552', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65553', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65554', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65555', ' Limburg');
INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES('65556', ' Limburg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbunternehmen`
--

DROP TABLE IF EXISTS `tbunternehmen`;
CREATE TABLE IF NOT EXISTS `tbunternehmen` (
  `biUnternehmensID` bigint(20) NOT NULL AUTO_INCREMENT,
  `vaName` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaAdresse` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaPLZ` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaEmail` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `tText` text COLLATE utf8_croatian_ci,
  `vaBranche` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaTelefonnummer` varchar(25) COLLATE utf8_croatian_ci NOT NULL,
  `vaWeblinke` varchar(256) COLLATE utf8_croatian_ci NOT NULL,
  PRIMARY KEY (`biUnternehmensID`),
  KEY `vaPLZ` (`vaPLZ`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbunternehmen`
--

INSERT INTO `tbunternehmen` (`biUnternehmensID`, `vaName`, `vaAdresse`, `vaPLZ`, `vaEmail`, `tText`, `vaBranche`, `vaTelefonnummer`, `vaWeblinke`) VALUES(1, 'EP', 'Die Strasssss', '01067', '', NULL, 'ET', '', '');
INSERT INTO `tbunternehmen` (`biUnternehmensID`, `vaName`, `vaAdresse`, `vaPLZ`, `vaEmail`, `tText`, `vaBranche`, `vaTelefonnummer`, `vaWeblinke`) VALUES(14, 'deactivated Frings Solutions ', 'KleinhÃ¼lsen  42', '40721', 'kontakt@frings-solutions.de', NULL, 'IT', '(2103) 58 77 -100 ', 'http://www.frings-solutions.de/');
INSERT INTO `tbunternehmen` (`biUnternehmensID`, `vaName`, `vaAdresse`, `vaPLZ`, `vaEmail`, `tText`, `vaBranche`, `vaTelefonnummer`, `vaWeblinke`) VALUES(19, 'deactivated Sebastian Hauscheid', 'Karnaper StraÃŸe, 6 6', '01067', 'sebastian.hauscheid@arcor.de', 'ICh mag ZÃ¼ge', 'IT', '015775253119', 'www.Dummy.de');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser`
--

DROP TABLE IF EXISTS `tbuser`;
CREATE TABLE IF NOT EXISTS `tbuser` (
  `biUserID` bigint(20) NOT NULL AUTO_INCREMENT,
  `vaUsername` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaUserRole` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaEmail` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaVorname` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaNachname` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaAdresse` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaPLZ` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaKlasse` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `dGeburtsjahr` date DEFAULT NULL,
  `vaPasswort` varchar(256) COLLATE utf8_croatian_ci NOT NULL,
  `tText` text COLLATE utf8_croatian_ci NOT NULL,
  PRIMARY KEY (`biUserID`),
  UNIQUE KEY `vaUsername` (`vaUsername`),
  UNIQUE KEY `vaEmail` (`vaEmail`),
  KEY `vaPLZ` (`vaPLZ`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbuser`
--

INSERT INTO `tbuser` (`biUserID`, `vaUsername`, `vaUserRole`, `vaEmail`, `vaVorname`, `vaNachname`, `vaAdresse`, `vaPLZ`, `vaKlasse`, `dGeburtsjahr`, `vaPasswort`, `tText`) VALUES(1, '0', '0', 'Tom', 'Tom', 'Tom', 'TIM', 'Tom', 'Tom', '2018-02-28', 'TIM', 'Tom');
INSERT INTO `tbuser` (`biUserID`, `vaUsername`, `vaUserRole`, `vaEmail`, `vaVorname`, `vaNachname`, `vaAdresse`, `vaPLZ`, `vaKlasse`, `dGeburtsjahr`, `vaPasswort`, `tText`) VALUES(7, 'maggiduscher', 'student', 'maggiduscher@maggiduscher.com', 'maggiduscher', 'maggiduscher', 'maggiduscher 12', '0', 'ITA51', '0000-00-00', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewerbungen`
--

DROP TABLE IF EXISTS `tbuser_bewerbungen`;
CREATE TABLE IF NOT EXISTS `tbuser_bewerbungen` (
  `biAngebotsID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `dBewerbung` date NOT NULL,
  KEY `biAngebotesID` (`biAngebotsID`),
  KEY `biUserID` (`biUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbuser_bewerbungen`
--

INSERT INTO `tbuser_bewerbungen` (`biAngebotsID`, `biUserID`, `dBewerbung`) VALUES(2, 1, '2018-02-23');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewertung`
--

DROP TABLE IF EXISTS `tbuser_bewertung`;
CREATE TABLE IF NOT EXISTS `tbuser_bewertung` (
  `biUnternehmensID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `iPunkte` int(11) NOT NULL,
  `vaText` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  KEY `biAngebotesID` (`biUnternehmensID`),
  KEY `biUserID` (`biUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbuser_bewertung`
--

INSERT INTO `tbuser_bewertung` (`biUnternehmensID`, `biUserID`, `iPunkte`, `vaText`) VALUES(1, 1, 10, 'Super duper');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbangenommene`
--
ALTER TABLE `tbangenommene`
  ADD CONSTRAINT `tbangenommene_ibfk_1` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`),
  ADD CONSTRAINT `tbangenommene_ibfk_2` FOREIGN KEY (`biAngebotsID`) REFERENCES `tbangebote` (`biAngebotsID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
