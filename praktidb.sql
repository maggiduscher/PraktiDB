-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 11. Mrz 2018 um 12:00
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUnternehmen` (IN `Name` VARCHAR(50), IN `Adresse` VARCHAR(50), IN `PLZ` VARCHAR(50), IN `Branche` VARCHAR(50))  BEGIN
INSERT INTO tbunternehmen(vaName,vaAdresse,vaPLZ,vaBranche) VALUES(Name,Adresse,PLZ,Branche);

END$$

DROP PROCEDURE IF EXISTS `AddUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser` (IN `Geburtsjahr` DATE, IN `Adresse` VARCHAR(50), IN `EMail` VARCHAR(50), IN `Klasse` VARCHAR(50), IN `Nachname` VARCHAR(50), IN `Passwort` VARCHAR(256), IN `PLZ` VARCHAR(50), IN `Username` VARCHAR(50), IN `UserRole` VARCHAR(50), IN `Vorname` VARCHAR(50))  BEGIN
INSERT INTO tbuser(dGeburtsjahr,vaAdresse,vaEmail,vaKlasse,vaNachname,vaPasswort,vaPLZ,vaUsername,vaUserRole,vaVorname)VALUES(Geburtsjahr,Adresse, EMail, Klasse, Nachname ,  Passwort ,  PLZ ,  Username ,  UserRole ,  Vorname );
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
SELECT * FROM tbangebote;
END$$

DROP PROCEDURE IF EXISTS `GetAllOrt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllOrt` ()  NO SQL
BEGIN
 SELECT * FROM tbort;
END$$

DROP PROCEDURE IF EXISTS `GetAllUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUnternehmen` ()  BEGIN
SELECT u.*,o.vaStadt FROM tbunternehmen u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ);
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

DROP PROCEDURE IF EXISTS `GetKlasse`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetKlasse` (IN `Klasse` VARCHAR(50))  BEGIN
SELECT * FROM tbuser
WHERE vaKlasse = Klasse;
END$$

DROP PROCEDURE IF EXISTS `GetStadt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStadt` (IN `PLZ` VARCHAR(50))  NO SQL
BEGIN
SELECT * FROM tbort
 WHERE vaPLZ = PLZ;
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
-- Erstellt am: 10. Mrz 2018 um 14:13
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
-- RELATIONEN DER TABELLE `tbangebote`:
--

--
-- Daten für Tabelle `tbangebote`
--

INSERT INTO `tbangebote` (`biAngebotsID`, `biUnternehmensID`, `vaAngebots_Art`, `dAnfangsdatum`, `dEnddatum`, `iGesuchte_Bewerber`, `iAnzahl_Bewerber`, `iAngenommene_Bewerber`) VALUES
(2, 1, 'IT', '2018-02-23', '2018-02-23', 5, 2, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbort`
--
-- Erstellt am: 10. Mrz 2018 um 14:13
--

DROP TABLE IF EXISTS `tbort`;
CREATE TABLE IF NOT EXISTS `tbort` (
  `vaPLZ` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaStadt` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`vaPLZ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- RELATIONEN DER TABELLE `tbort`:
--

--
-- Daten für Tabelle `tbort`
--

INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES
('0', 'Hilden'),
('00000', 'Berlin'),
('40764', 'Langenfeld');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbunternehmen`
--
-- Erstellt am: 10. Mrz 2018 um 14:13
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
  PRIMARY KEY (`biUnternehmensID`),
  KEY `vaPLZ` (`vaPLZ`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- RELATIONEN DER TABELLE `tbunternehmen`:
--

--
-- Daten für Tabelle `tbunternehmen`
--

INSERT INTO `tbunternehmen` (`biUnternehmensID`, `vaName`, `vaAdresse`, `vaPLZ`, `vaEmail`, `tText`, `vaBranche`) VALUES
(1, '0', 'Hier', 'Batman', 'Mail@Brief4Live.Post', 'TEXXXT', 'ALLES'),
(2, 'EP', 'Die Strasssss', '0', '', NULL, 'ET');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser`
--
-- Erstellt am: 10. Mrz 2018 um 14:13
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- RELATIONEN DER TABELLE `tbuser`:
--

--
-- Daten für Tabelle `tbuser`
--

INSERT INTO `tbuser` (`biUserID`, `vaUsername`, `vaUserRole`, `vaEmail`, `vaVorname`, `vaNachname`, `vaAdresse`, `vaPLZ`, `vaKlasse`, `dGeburtsjahr`, `vaPasswort`, `tText`) VALUES
(1, '0', '0', 'Tom', 'Tom', 'Tom', 'TIM', 'Tom', 'Tom', '2018-02-28', 'TIM', 'Tom'),
(2, 'TIM', 'student', 'TIM@TIM', 'TIM', 'TIM', 'TIM v', '0', 'TIM', NULL, '6ea50202636d798337a6c4ea885cbbd47772795a3257c309451ab27686c4dd92', ''),
(3, 'TOM', 'student', 'TOM@TOM', 'TOM', 'TOM', 'TOM TOM', '0', 'TOM', '0000-00-00', 'c8435b00e294b7b0ad44311d8d816b8eb1f52ce6abecf1008d4ee715f3c4f1e2', ''),
(5, 'dd', 'student', 'sebastian.hauscheid@arcor.de', 'Sebastian', 'Hauscheid', 'Karnaper StraÃŸe, 6 6', '0', 'ALLE', '0000-00-00', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewerbungen`
--
-- Erstellt am: 10. Mrz 2018 um 14:13
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
-- RELATIONEN DER TABELLE `tbuser_bewerbungen`:
--

--
-- Daten für Tabelle `tbuser_bewerbungen`
--

INSERT INTO `tbuser_bewerbungen` (`biAngebotsID`, `biUserID`, `dBewerbung`) VALUES
(2, 1, '2018-02-23');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewertung`
--
-- Erstellt am: 10. Mrz 2018 um 14:13
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
-- RELATIONEN DER TABELLE `tbuser_bewertung`:
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
