-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 23. Feb 2018 um 09:26
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `prakdb`
--
CREATE DATABASE IF NOT EXISTS `prakdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci;
USE `prakdb`;

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

DROP PROCEDURE IF EXISTS `GetStadt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStadt` (IN `PLZ` VARCHAR(50))  NO SQL
BEGIN
SELECT vaStadt FROM tbort;
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
CREATE TABLE `tbangebote` (
  `biAngebotsID` bigint(20) NOT NULL,
  `biUnternehmensID` bigint(20) DEFAULT NULL,
  `vaAngebots_Art` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `dAnfangsdatum` date DEFAULT NULL,
  `dEnddatum` date DEFAULT NULL,
  `iGesuchte_Bewerber` int(11) DEFAULT NULL,
  `iAnzahl_Bewerber` int(11) DEFAULT NULL,
  `iAngenommene_Bewerber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbangebote`
--

INSERT INTO `tbangebote` (`biAngebotsID`, `biUnternehmensID`, `vaAngebots_Art`, `dAnfangsdatum`, `dEnddatum`, `iGesuchte_Bewerber`, `iAnzahl_Bewerber`, `iAngenommene_Bewerber`) VALUES
(2, 1, 'IT', '2018-02-23', '2018-02-23', 5, 2, 2),
(3, 1, 'IT', NULL, NULL, 5, NULL, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbort`
--

DROP TABLE IF EXISTS `tbort`;
CREATE TABLE `tbort` (
  `vaPLZ` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `vaStadt` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbort`
--

INSERT INTO `tbort` (`vaPLZ`, `vaStadt`) VALUES
('0', 'Hilden'),
('00000', 'Berlin');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbunternehmen`
--

DROP TABLE IF EXISTS `tbunternehmen`;
CREATE TABLE `tbunternehmen` (
  `biUnternehmensID` bigint(20) NOT NULL,
  `vaName` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaAdresse` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vaPLZ` varchar(50) COLLATE utf8_croatian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbunternehmen`
--

INSERT INTO `tbunternehmen` (`biUnternehmensID`, `vaName`, `vaAdresse`, `vaPLZ`) VALUES
(1, 'Frings', 'Hier', '0'),
(2, 'Name', 'Adresse', '0');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser`
--

DROP TABLE IF EXISTS `tbuser`;
CREATE TABLE `tbuser` (
  `biUserID` bigint(20) NOT NULL,
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
  `tText` text COLLATE utf8_croatian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbuser`
--

INSERT INTO `tbuser` (`biUserID`, `vaUsername`, `vaUserRole`, `vaEmail`, `vaVorname`, `vaNachname`, `vaAdresse`, `vaPLZ`, `vaKlasse`, `dGeburtsjahr`, `vaPasswort`, `tText`) VALUES
(1, 'TIM', 'TIM', 'TIM', 'TIM', 'TIM', 'TIM', '0', 'TIM', '2018-02-02', 'TIM', 'Nestle');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewerbungen`
--

DROP TABLE IF EXISTS `tbuser_bewerbungen`;
CREATE TABLE `tbuser_bewerbungen` (
  `biAngebotsID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `dBewerbung` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Daten für Tabelle `tbuser_bewerbungen`
--

INSERT INTO `tbuser_bewerbungen` (`biAngebotsID`, `biUserID`, `dBewerbung`) VALUES
(2, 1, '2018-02-23');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewertung`
--

DROP TABLE IF EXISTS `tbuser_bewertung`;
CREATE TABLE `tbuser_bewertung` (
  `biUnternehmensID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `iPunkte` int(11) NOT NULL,
  `vaText` varchar(50) COLLATE utf8_croatian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbangebote`
--
ALTER TABLE `tbangebote`
  ADD PRIMARY KEY (`biAngebotsID`),
  ADD KEY `biUnternehmensID` (`biUnternehmensID`);

--
-- Indizes für die Tabelle `tbort`
--
ALTER TABLE `tbort`
  ADD PRIMARY KEY (`vaPLZ`);

--
-- Indizes für die Tabelle `tbunternehmen`
--
ALTER TABLE `tbunternehmen`
  ADD PRIMARY KEY (`biUnternehmensID`),
  ADD KEY `vaPLZ` (`vaPLZ`);

--
-- Indizes für die Tabelle `tbuser`
--
ALTER TABLE `tbuser`
  ADD PRIMARY KEY (`biUserID`),
  ADD UNIQUE KEY `vaUsername` (`vaUsername`),
  ADD UNIQUE KEY `vaEmail` (`vaEmail`),
  ADD KEY `vaPLZ` (`vaPLZ`);

--
-- Indizes für die Tabelle `tbuser_bewerbungen`
--
ALTER TABLE `tbuser_bewerbungen`
  ADD KEY `biAngebotesID` (`biAngebotsID`),
  ADD KEY `biUserID` (`biUserID`);

--
-- Indizes für die Tabelle `tbuser_bewertung`
--
ALTER TABLE `tbuser_bewertung`
  ADD KEY `biAngebotesID` (`biUnternehmensID`),
  ADD KEY `biUserID` (`biUserID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbangebote`
--
ALTER TABLE `tbangebote`
  MODIFY `biAngebotsID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT für Tabelle `tbunternehmen`
--
ALTER TABLE `tbunternehmen`
  MODIFY `biUnternehmensID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT für Tabelle `tbuser`
--
ALTER TABLE `tbuser`
  MODIFY `biUserID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
