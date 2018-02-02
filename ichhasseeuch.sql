-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 02. Feb 2018 um 08:18
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 5.6.30

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
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

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbangebote`
--

DROP TABLE IF EXISTS `tbangebote`;
CREATE TABLE IF NOT EXISTS `tbangebote` (
  `biAngebotesID` bigint(20) NOT NULL AUTO_INCREMENT,
  `biUnternehmensID` bigint(20) DEFAULT NULL,
  `vaAngebots_Art` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  `dAnfangsdatum` date DEFAULT NULL,
  `dEnddatum` date DEFAULT NULL,
  `iGesuchte_Bewerber` int(11) DEFAULT NULL,
  `iAnzahl_Bewerber` int(11) DEFAULT NULL,
  `iAngenommene_Bewerber` int(11) DEFAULT NULL,
  PRIMARY KEY (`biAngebotesID`),
  KEY `biUnternehmensID` (`biUnternehmensID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbangebote`
--

TRUNCATE TABLE `tbangebote`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbunternehmen`
--

TRUNCATE TABLE `tbunternehmen`;
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
  PRIMARY KEY (`biUserID`),
  UNIQUE KEY `vaUsername` (`vaUsername`),
  UNIQUE KEY `vaEmail` (`vaEmail`),
  KEY `vaPLZ` (`vaPLZ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbuser`
--

TRUNCATE TABLE `tbuser`;
-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewerbungen`
--

DROP TABLE IF EXISTS `tbuser_bewerbungen`;
CREATE TABLE IF NOT EXISTS `tbuser_bewerbungen` (
  `biAngebotesID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `dBewerbung` date NOT NULL,
  KEY `biAngebotesID` (`biAngebotesID`),
  KEY `biUserID` (`biUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `tbuser_bewerbungen`
--

TRUNCATE TABLE `tbuser_bewerbungen`;
-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_bewertung`
--

DROP TABLE IF EXISTS `user_bewertung`;
CREATE TABLE IF NOT EXISTS `user_bewertung` (
  `biAngebotesID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `iPunkte` int(11) NOT NULL,
  `vaText` varchar(50) COLLATE utf8_croatian_ci NOT NULL,
  KEY `biAngebotesID` (`biAngebotesID`),
  KEY `biUserID` (`biUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- TRUNCATE Tabelle vor dem Einfügen `user_bewertung`
--

TRUNCATE TABLE `user_bewertung`;
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
  ADD CONSTRAINT `tbuser_bewerbungen_ibfk_1` FOREIGN KEY (`biAngebotesID`) REFERENCES `tbangebote` (`biAngebotesID`),
  ADD CONSTRAINT `tbuser_bewerbungen_ibfk_2` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`);

--
-- Constraints der Tabelle `user_bewertung`
--
ALTER TABLE `user_bewertung`
  ADD CONSTRAINT `user_bewertung_ibfk_1` FOREIGN KEY (`biAngebotesID`) REFERENCES `tbangebote` (`biAngebotesID`),
  ADD CONSTRAINT `user_bewertung_ibfk_2` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`);


--
-- Metadaten
--
USE `phpmyadmin`;

--
-- Metadaten für Tabelle tbangebote
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadaten für Tabelle tbort
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadaten für Tabelle tbunternehmen
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadaten für Tabelle tbuser
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadaten für Tabelle tbuser_bewerbungen
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadaten für Tabelle user_bewertung
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadaten für Datenbank ichhasseeuch
--

--
-- TRUNCATE Tabelle vor dem Einfügen `pma__bookmark`
--

TRUNCATE TABLE `pma__bookmark`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__relation`
--

TRUNCATE TABLE `pma__relation`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__savedsearches`
--

TRUNCATE TABLE `pma__savedsearches`;
--
-- TRUNCATE Tabelle vor dem Einfügen `pma__central_columns`
--

TRUNCATE TABLE `pma__central_columns`;SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
