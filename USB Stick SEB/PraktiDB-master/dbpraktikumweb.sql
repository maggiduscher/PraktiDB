-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 30. Jan 2018 um 09:13
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `dbpraktikumweb`
--
CREATE DATABASE IF NOT EXISTS `dbpraktikumweb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dbpraktikumweb`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbangebote`
--

DROP TABLE IF EXISTS `tbangebote`;
CREATE TABLE `tbangebote` (
  `biAngebotesID` bigint(20) NOT NULL,
  `biUnternehmensID` bigint(20) DEFAULT NULL,
  `vaAngebots_Art` varchar(50) NOT NULL,
  `dAnfangsdatum` date DEFAULT NULL,
  `dEnddatum` date DEFAULT NULL,
  `iGesuchte_Bewerber` int(11) DEFAULT NULL,
  `iAnzahl_Bewerber` int(11) DEFAULT NULL,
  `iAngenommene_Bewerber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbort`
--

DROP TABLE IF EXISTS `tbort`;
CREATE TABLE `tbort` (
  `vaPLZ` varchar(50) NOT NULL,
  `vaStadt` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbschule`
--

DROP TABLE IF EXISTS `tbschule`;
CREATE TABLE `tbschule` (
  `biUserID` bigint(20) DEFAULT NULL,
  `vaVorname` varchar(50) NOT NULL,
  `vaNachname` varchar(50) NOT NULL,
  `vaAdresse` varchar(50) NOT NULL,
  `vaPLZ` varchar(50) DEFAULT NULL,
  `vaKlasse` varchar(50) DEFAULT NULL,
  `dGeburtsjahr` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbunternehmen`
--

DROP TABLE IF EXISTS `tbunternehmen`;
CREATE TABLE `tbunternehmen` (
  `biUnternehmensID` bigint(20) NOT NULL,
  `vaName` varchar(50) DEFAULT NULL,
  `vaAdresse` varchar(50) DEFAULT NULL,
  `vaPLZ` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser`
--

DROP TABLE IF EXISTS `tbuser`;
CREATE TABLE `tbuser` (
  `biUserID` bigint(20) NOT NULL,
  `vaUsername` varchar(50) DEFAULT NULL,
  `vaUserRole` varchar(50) NOT NULL,
  `vaEmail` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbuser_bewerbungen`
--

DROP TABLE IF EXISTS `tbuser_bewerbungen`;
CREATE TABLE `tbuser_bewerbungen` (
  `biAngebotesID` bigint(20) DEFAULT NULL,
  `biUserID` bigint(20) DEFAULT NULL,
  `dBewerbung` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbverwalter`
--

DROP TABLE IF EXISTS `tbverwalter`;
CREATE TABLE `tbverwalter` (
  `biUserID` bigint(20) DEFAULT NULL,
  `biUnternehmensID` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbangebote`
--
ALTER TABLE `tbangebote`
  ADD PRIMARY KEY (`biAngebotesID`),
  ADD KEY `biUnternehmensID` (`biUnternehmensID`);

--
-- Indizes für die Tabelle `tbort`
--
ALTER TABLE `tbort`
  ADD PRIMARY KEY (`vaPLZ`);

--
-- Indizes für die Tabelle `tbschule`
--
ALTER TABLE `tbschule`
  ADD KEY `vaPLZ` (`vaPLZ`),
  ADD KEY `biUserID` (`biUserID`);

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
  ADD UNIQUE KEY `vaEmail` (`vaEmail`);

--
-- Indizes für die Tabelle `tbuser_bewerbungen`
--
ALTER TABLE `tbuser_bewerbungen`
  ADD KEY `biAngebotesID` (`biAngebotesID`),
  ADD KEY `biUserID` (`biUserID`);

--
-- Indizes für die Tabelle `tbverwalter`
--
ALTER TABLE `tbverwalter`
  ADD KEY `biUserID` (`biUserID`),
  ADD KEY `biUnternehmensID` (`biUnternehmensID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbangebote`
--
ALTER TABLE `tbangebote`
  MODIFY `biAngebotesID` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `tbunternehmen`
--
ALTER TABLE `tbunternehmen`
  MODIFY `biUnternehmensID` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `tbuser`
--
ALTER TABLE `tbuser`
  MODIFY `biUserID` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbangebote`
--
ALTER TABLE `tbangebote`
  ADD CONSTRAINT `tbangebote_ibfk_1` FOREIGN KEY (`biUnternehmensID`) REFERENCES `tbunternehmen` (`biUnternehmensID`);

--
-- Constraints der Tabelle `tbschule`
--
ALTER TABLE `tbschule`
  ADD CONSTRAINT `tbschule_ibfk_1` FOREIGN KEY (`vaPLZ`) REFERENCES `tbort` (`vaPLZ`),
  ADD CONSTRAINT `tbschule_ibfk_2` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`);

--
-- Constraints der Tabelle `tbunternehmen`
--
ALTER TABLE `tbunternehmen`
  ADD CONSTRAINT `tbunternehmen_ibfk_1` FOREIGN KEY (`vaPLZ`) REFERENCES `tbort` (`vaPLZ`);

--
-- Constraints der Tabelle `tbuser_bewerbungen`
--
ALTER TABLE `tbuser_bewerbungen`
  ADD CONSTRAINT `tbuser_bewerbungen_ibfk_1` FOREIGN KEY (`biAngebotesID`) REFERENCES `tbangebote` (`biAngebotesID`),
  ADD CONSTRAINT `tbuser_bewerbungen_ibfk_2` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`);

--
-- Constraints der Tabelle `tbverwalter`
--
ALTER TABLE `tbverwalter`
  ADD CONSTRAINT `tbverwalter_ibfk_1` FOREIGN KEY (`biUserID`) REFERENCES `tbuser` (`biUserID`),
  ADD CONSTRAINT `tbverwalter_ibfk_2` FOREIGN KEY (`biUnternehmensID`) REFERENCES `tbunternehmen` (`biUnternehmensID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
