-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 23. Feb 2018 um 09:03
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `ichhasseeuch`
--
CREATE DATABASE IF NOT EXISTS `ichhasseeuch` DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci;
USE `ichhasseeuch`;

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUnternehmen` (IN `Name` VARCHAR(50), IN `Adresse` VARCHAR(50), IN `PLZ` VARCHAR(50))  BEGIN
INSERT INTO tbunternehmen(vaName,vaAdresse,vaPLZ) VALUES(Name,Adresse,PLZ);

END$$

DROP PROCEDURE IF EXISTS `AddUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser` (IN `Geburtsjahr` DATE, IN `Adresse` VARCHAR(50), IN `EMail` VARCHAR(50), IN `Klasse` VARCHAR(50), IN `Nachname` VARCHAR(50), IN `Passwort` VARCHAR(50), IN `PLZ` VARCHAR(50), IN `Username` VARCHAR(50), IN `UserRole` VARCHAR(50), IN `Vorname` VARCHAR(50))  BEGIN
INSERT INTO tbuser(dGeburtsjahr,vaAdresse,vaEmail,vaKlasse,vaNachname,vaPasswort,vaPLZ,vaUsername,vaUserRole,vaVorname)VALUES(Geburtsjahr,Adresse, EMail, Klasse, Nachname ,  Passwort ,  PLZ ,  Username ,  UserRole ,  Vorname );
END$$

DROP PROCEDURE IF EXISTS `CheckUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckUser` (IN `Username` VARCHAR(50), IN `Passwort` VARCHAR(50))  BEGIN
   
   SELECT u.vaUserRole,u.biUserID,o.vaStadt FROM tbuser u JOIN
   tbort o
   ON(u.vaPLZ = o.vaPLZ)
   WHERE (u.vaUsername = Username or 
          u.vaEMail = Username)
          AND u.vaPasswort = Passwort;

END$$

DROP PROCEDURE IF EXISTS `DeleteUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser` (IN `Username` VARCHAR(50))  BEGIN
DELETE FROM tbuser
WHERE vaUsername = Username;
END$$

DROP PROCEDURE IF EXISTS `GetAllAngebote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllAngebote` ()  BEGIN
SELECT * FROM tbangebote;
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

DROP PROCEDURE IF EXISTS `GetUnternehmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUnternehmen` (IN `Name` VARCHAR(50))  BEGIN
SELECT u.*,o.vaStadt FROM tbunternehmen u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ)
WHERE vaName = Name;
END$$

DROP PROCEDURE IF EXISTS `GetUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUser` (IN `Username` VARCHAR(50))  BEGIN
SELECT u.*, o.vaStadt FROM tbuser u JOIN tbort o
ON(u.vaPLZ = o.vaPLZ)
WHERE vaUsername = Username;
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

DROP PROCEDURE IF EXISTS `UpdateText`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateText` (IN `UserID` BIGINT, IN `Texxt` TEXT)  NO SQL
BEGIN
UPDATE tbuser
SET tText = TexxT
WHERE biUserID = UserID;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbangebote`
--

TRUNCATE TABLE `tbangebote`;
--
-- Daten für Tabelle `tbangebote`
--

INSERT DELAYED IGNORE INTO `tbangebote` (`biAngebotsID`, `biUnternehmensID`, `vaAngebots_Art`, `dAnfangsdatum`, `dEnddatum`, `iGesuchte_Bewerber`, `iAnzahl_Bewerber`, `iAngenommene_Bewerber`) VALUES
(2, 1, 'IT', '2018-02-23', '2018-02-23', 5, 2, 2),
(3, 1, 'IT', NULL, NULL, 5, NULL, 0);

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
-- TRUNCATE Tabelle vor dem Einfügen `tbort`
--

TRUNCATE TABLE `tbort`;
--
-- Daten für Tabelle `tbort`
--

INSERT DELAYED IGNORE INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES
('0', 'Hilden'),
('00000', 'Berlin');

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
  `biUserID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`biUnternehmensID`),
  KEY `biUserID` (`biUserID`),
  KEY `vaPLZ` (`vaPLZ`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbunternehmen`
--

TRUNCATE TABLE `tbunternehmen`;
--
-- Daten für Tabelle `tbunternehmen`
--

INSERT DELAYED IGNORE INTO `tbunternehmen` (`biUnternehmensID`, `vaName`, `vaAdresse`, `vaPLZ`, `biUserID`) VALUES
(1, 'Frings', 'Hier', '0', NULL),
(2, 'Name', 'Adresse', '0', NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbuser`
--

TRUNCATE TABLE `tbuser`;
--
-- Daten für Tabelle `tbuser`
--

INSERT DELAYED IGNORE INTO `tbuser` (`biUserID`, `vaUsername`, `vaUserRole`, `vaEmail`, `vaVorname`, `vaNachname`, `vaAdresse`, `vaPLZ`, `vaKlasse`, `dGeburtsjahr`, `vaPasswort`, `tText`) VALUES
(1, 'TIM', 'TIM', 'TIM', 'TIM', 'TIM', 'TIM', '0', 'TIM', '2018-02-02', 'TIM', 'Nestle');

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
-- TRUNCATE Tabelle vor dem Einfügen `tbuser_bewerbungen`
--

TRUNCATE TABLE `tbuser_bewerbungen`;
--
-- Daten für Tabelle `tbuser_bewerbungen`
--

INSERT DELAYED IGNORE INTO `tbuser_bewerbungen` (`biAngebotsID`, `biUserID`, `dBewerbung`) VALUES
(2, 1, '2018-02-23');

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
-- TRUNCATE Tabelle vor dem Einfügen `tbuser_bewertung`
--

TRUNCATE TABLE `tbuser_bewertung`;
--
-- Daten für Tabelle `tbuser_bewertung`
--

INSERT DELAYED IGNORE INTO `tbuser_bewertung` (`biUnternehmensID`, `biUserID`, `iPunkte`, `vaText`) VALUES
(2, 1, 8, 'Ich liebe es');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbangebote`
--
ALTER TABLE `tbangebote`
  ADD CONSTRAINT `tbangebote_ibfk_1` FOREIGN KEY (`biUnternehmensID`) REFERENCES `tbunternehmen` (`biUnternehmensID`);

--
-- Constraints der Tabelle `tbunternehmen`
--
ALTER TABLE `tbunternehmen`
  ADD CONSTRAINT `tbunternehmen_ibfk_1` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`),
  ADD CONSTRAINT `tbunternehmen_ibfk_2` FOREIGN KEY (`vaPLZ`) REFERENCES `tbort` (`vaPLZ`);

--
-- Constraints der Tabelle `tbuser`
--
ALTER TABLE `tbuser`
  ADD CONSTRAINT `tbuser_ibfk_1` FOREIGN KEY (`vaPLZ`) REFERENCES `tbort` (`vaPLZ`);

--
-- Constraints der Tabelle `tbuser_bewerbungen`
--
ALTER TABLE `tbuser_bewerbungen`
  ADD CONSTRAINT `tbuser_bewerbungen_ibfk_1` FOREIGN KEY (`biAngebotsID`) REFERENCES `tbangebote` (`biAngebotsID`),
  ADD CONSTRAINT `tbuser_bewerbungen_ibfk_2` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`);

--
-- Constraints der Tabelle `tbuser_bewertung`
--
ALTER TABLE `tbuser_bewertung`
  ADD CONSTRAINT `tbuser_bewertung_ibfk_1` FOREIGN KEY (`biUnternehmensID`) REFERENCES `tbangebote` (`biAngebotsID`),
  ADD CONSTRAINT `tbuser_bewertung_ibfk_2` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
