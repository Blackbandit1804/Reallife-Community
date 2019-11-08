-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 08. Nov 2019 um 16:07
-- Server-Version: 10.1.29-MariaDB
-- PHP-Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cnvpvwqh_ragemp`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password_hash` char(40) NOT NULL,
  `password_salt` char(32) NOT NULL,
  `password_iterations` int(7) DEFAULT NULL,
  `creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rank` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts_serial`
--

CREATE TABLE `accounts_serial` (
  `account_id` int(11) NOT NULL,
  `serial` char(128) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts_socialclub`
--

CREATE TABLE `accounts_socialclub` (
  `account_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL DEFAULT '0',
  `pin` int(4) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans_account`
--

CREATE TABLE `bans_account` (
  `ban_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans_serial`
--

CREATE TABLE `bans_serial` (
  `ban_id` int(11) NOT NULL,
  `serial` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans_socialclub`
--

CREATE TABLE `bans_socialclub` (
  `ban_id` int(11) NOT NULL,
  `socialclub` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cfg_items`
--

CREATE TABLE `cfg_items` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `category` enum('Ressource','Frucht','Waffe','Munition','Kleidung') NOT NULL,
  `rarity` tinyint(4) UNSIGNED NOT NULL,
  `volume` int(11) UNSIGNED NOT NULL,
  `weight` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cfg_vehicles`
--

CREATE TABLE `cfg_vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `hash` int(2) UNSIGNED NOT NULL,
  `multi` int(2) NOT NULL DEFAULT '1',
  `price` int(10) NOT NULL DEFAULT '0',
  `type` tinyint(4) DEFAULT NULL,
  `fuel_tank` float NOT NULL DEFAULT '0',
  `fuel_consumption` float NOT NULL DEFAULT '0',
  `aktiv` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='/epm (Summe)\r\nSELECT *, fuel_tank / fuel_consumption AS range_km From cfg_vehicles' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cfg_vehicles_type`
--

CREATE TABLE `cfg_vehicles_type` (
  `id` tinyint(3) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `created` tinyint(1) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `cash` int(11) NOT NULL,
  `wanteds` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `vehicles` int(11) NOT NULL,
  `creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `p_x` float NOT NULL,
  `p_y` float NOT NULL,
  `p_z` float NOT NULL,
  `dim` int(20) NOT NULL,
  `h_key` int(11) NOT NULL,
  `leader` int(11) NOT NULL,
  `fraktion` int(11) NOT NULL,
  `fraktionrank` tinyint(1) NOT NULL,
  `payday` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters_clothes`
--

CREATE TABLE `characters_clothes` (
  `character_id` int(11) NOT NULL,
  `masks` int(11) NOT NULL,
  `torsos` int(11) NOT NULL,
  `legs` int(11) NOT NULL,
  `bags` int(11) NOT NULL,
  `shoes` int(11) NOT NULL,
  `accessories` int(11) NOT NULL,
  `undershirts` int(11) NOT NULL,
  `armor` int(11) NOT NULL,
  `decals` int(11) NOT NULL,
  `tops` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters_customization`
--

CREATE TABLE `characters_customization` (
  `character_id` int(11) NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `h_ShapeFirst` tinyint(3) UNSIGNED NOT NULL,
  `h_ShapeSecond` tinyint(3) UNSIGNED NOT NULL,
  `h_ShapeThird` tinyint(3) UNSIGNED NOT NULL,
  `h_SkinFirst` tinyint(3) UNSIGNED NOT NULL,
  `h_SkinSecond` tinyint(3) UNSIGNED NOT NULL,
  `h_SkinThird` tinyint(3) UNSIGNED NOT NULL,
  `h_ShapeMix` float NOT NULL,
  `h_SkinMix` float NOT NULL,
  `h_ThirdMix` float NOT NULL,
  `eyeColor` tinyint(3) UNSIGNED NOT NULL,
  `hair` int(11) NOT NULL,
  `hairColor` tinyint(3) UNSIGNED NOT NULL,
  `hightlightColor` tinyint(3) UNSIGNED NOT NULL,
  `f_noseWidth` float NOT NULL,
  `f_noseHeight` float NOT NULL,
  `f_noseLength` float NOT NULL,
  `f_noseBridge` float NOT NULL,
  `f_noseTip` float NOT NULL,
  `f_noseShift` float NOT NULL,
  `f_browHeight` float NOT NULL,
  `f_browWidth` float NOT NULL,
  `f_cheekboneHeight` float NOT NULL,
  `f_cheekboneWidth` float NOT NULL,
  `f_cheeksWidth` float NOT NULL,
  `f_eyes` float NOT NULL,
  `f_lips` float NOT NULL,
  `f_jawWidth` float NOT NULL,
  `f_jawHeight` float NOT NULL,
  `f_chinLength` float NOT NULL,
  `f_chinPosition` float NOT NULL,
  `f_chinWidth` float NOT NULL,
  `f_chinShape` float NOT NULL,
  `f_neckWidth` float NOT NULL,
  `o_i_blemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c_blemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_blemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_o_blemishes` float NOT NULL,
  `o_i_facialHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c_facialHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_facialHair` tinyint(3) UNSIGNED NOT NULL,
  `o_o_facialHair` float NOT NULL,
  `o_i_eyebrows` tinyint(3) UNSIGNED NOT NULL,
  `o_c_eyebrows` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_eyebrows` tinyint(3) UNSIGNED NOT NULL,
  `o_o_eyebrows` float NOT NULL,
  `o_i_ageing` tinyint(3) UNSIGNED NOT NULL,
  `o_c_ageing` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_ageing` tinyint(3) UNSIGNED NOT NULL,
  `o_o_ageing` float NOT NULL,
  `o_i_makeup` tinyint(3) UNSIGNED NOT NULL,
  `o_c_makeup` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_makeup` tinyint(3) UNSIGNED NOT NULL,
  `o_o_makeup` float NOT NULL,
  `o_i_blush` tinyint(3) UNSIGNED NOT NULL,
  `o_c_blush` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_blush` tinyint(3) UNSIGNED NOT NULL,
  `o_o_blush` float NOT NULL,
  `o_i_complexion` tinyint(3) UNSIGNED NOT NULL,
  `o_c_complexion` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_complexion` tinyint(3) UNSIGNED NOT NULL,
  `o_o_complexion` float NOT NULL,
  `o_i_sunDamage` tinyint(3) UNSIGNED NOT NULL,
  `o_c_sunDamage` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_sunDamage` tinyint(3) UNSIGNED NOT NULL,
  `o_o_sunDamage` float NOT NULL,
  `o_i_lipstick` tinyint(3) UNSIGNED NOT NULL,
  `o_c_lipstick` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_lipstick` tinyint(3) UNSIGNED NOT NULL,
  `o_o_lipstick` float NOT NULL,
  `o_i_molesFreckles` tinyint(3) UNSIGNED NOT NULL,
  `o_c_molesFreckles` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_molesFreckles` tinyint(3) UNSIGNED NOT NULL,
  `o_o_molesFreckles` float NOT NULL,
  `o_i_chestHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c_chestHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_chestHair` tinyint(3) UNSIGNED NOT NULL,
  `o_o_chestHair` float NOT NULL,
  `o_i_bodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c_bodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_bodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_o_bodyBlemishes` float NOT NULL,
  `o_i_addBodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c_addBodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_addBodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_o_addBodyBlemishes` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fvehicles`
--

CREATE TABLE `fvehicles` (
  `id` int(11) NOT NULL,
  `fraktion` varchar(50) NOT NULL,
  `cfg_vehicle_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `engine` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `locked` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `p_x` float NOT NULL,
  `p_y` float NOT NULL,
  `p_z` float NOT NULL,
  `r` float NOT NULL,
  `c` int(11) NOT NULL DEFAULT '0',
  `c_r` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `c_g` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `c_b` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `s` int(11) NOT NULL DEFAULT '0',
  `s_r` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `s_g` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `s_b` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `hp` float NOT NULL DEFAULT '100',
  `km` float NOT NULL DEFAULT '0',
  `fuel` float NOT NULL DEFAULT '0',
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `house`
--

CREATE TABLE `house` (
  `id` int(11) NOT NULL,
  `status` tinyint(2) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `interior` int(255) DEFAULT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `cost` int(10) DEFAULT NULL,
  `renter` tinyint(1) DEFAULT NULL,
  `rentcost` int(10) DEFAULT NULL,
  `platz` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `items`
--

CREATE TABLE `items` (
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `licenses`
--

CREATE TABLE `licenses` (
  `id` int(11) NOT NULL,
  `character_name` varchar(15) NOT NULL,
  `license` tinyint(4) NOT NULL,
  `punkte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `numberplates`
--

CREATE TABLE `numberplates` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `numberplate` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `cfg_vehicle_id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `garage_id` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `alive` tinyint(1) NOT NULL DEFAULT '1',
  `engine` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `locked` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `p_x` float NOT NULL,
  `p_y` float NOT NULL,
  `p_z` float NOT NULL,
  `r` float NOT NULL,
  `dim` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `insurance` tinyint(3) NOT NULL DEFAULT '0',
  `c` int(11) NOT NULL DEFAULT '0',
  `c_r` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `c_g` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `c_b` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `s` int(11) NOT NULL DEFAULT '0',
  `s_r` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `s_g` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `s_b` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `hp` float NOT NULL DEFAULT '100',
  `km` float NOT NULL DEFAULT '0',
  `fuel` float NOT NULL DEFAULT '0',
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_owner_change` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `UNIQUE` (`name`) USING BTREE;

--
-- Indizes für die Tabelle `accounts_serial`
--
ALTER TABLE `accounts_serial`
  ADD PRIMARY KEY (`account_id`,`serial`) USING BTREE;

--
-- Indizes für die Tabelle `accounts_socialclub`
--
ALTER TABLE `accounts_socialclub`
  ADD PRIMARY KEY (`account_id`,`name`) USING BTREE;

--
-- Indizes für die Tabelle `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indizes für die Tabelle `bans_account`
--
ALTER TABLE `bans_account`
  ADD PRIMARY KEY (`ban_id`);

--
-- Indizes für die Tabelle `bans_serial`
--
ALTER TABLE `bans_serial`
  ADD PRIMARY KEY (`ban_id`,`serial`) USING BTREE;

--
-- Indizes für die Tabelle `bans_socialclub`
--
ALTER TABLE `bans_socialclub`
  ADD PRIMARY KEY (`ban_id`,`socialclub`) USING BTREE;

--
-- Indizes für die Tabelle `cfg_items`
--
ALTER TABLE `cfg_items`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indizes für die Tabelle `cfg_vehicles`
--
ALTER TABLE `cfg_vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `name` (`name`) USING BTREE,
  ADD KEY `FK_cfg_vehicles_cfg_vehicles_type` (`type`) USING BTREE;

--
-- Indizes für die Tabelle `cfg_vehicles_type`
--
ALTER TABLE `cfg_vehicles_type`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indizes für die Tabelle `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`first_name`,`last_name`) USING BTREE,
  ADD KEY `accounts_id:characters_account_id_idx` (`account_id`) USING BTREE;

--
-- Indizes für die Tabelle `characters_clothes`
--
ALTER TABLE `characters_clothes`
  ADD PRIMARY KEY (`character_id`);

--
-- Indizes für die Tabelle `characters_customization`
--
ALTER TABLE `characters_customization`
  ADD PRIMARY KEY (`character_id`) USING BTREE;

--
-- Indizes für die Tabelle `fvehicles`
--
ALTER TABLE `fvehicles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indizes für die Tabelle `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indizes für die Tabelle `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`character_id`,`item_id`) USING BTREE;

--
-- Indizes für die Tabelle `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `numberplates`
--
ALTER TABLE `numberplates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numberplate_UNIQUE` (`numberplate`);

--
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bans_account`
--
ALTER TABLE `bans_account`
  MODIFY `ban_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bans_serial`
--
ALTER TABLE `bans_serial`
  MODIFY `ban_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bans_socialclub`
--
ALTER TABLE `bans_socialclub`
  MODIFY `ban_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `cfg_items`
--
ALTER TABLE `cfg_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `cfg_vehicles`
--
ALTER TABLE `cfg_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `cfg_vehicles_type`
--
ALTER TABLE `cfg_vehicles_type`
  MODIFY `id` tinyint(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `fvehicles`
--
ALTER TABLE `fvehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `house`
--
ALTER TABLE `house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `licenses`
--
ALTER TABLE `licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `numberplates`
--
ALTER TABLE `numberplates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `accounts_socialclub`
--
ALTER TABLE `accounts_socialclub`
  ADD CONSTRAINT `accounts_id:social_club_accounts_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `accounts_uid_social_club_accounts_account_uid` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `cfg_vehicles`
--
ALTER TABLE `cfg_vehicles`
  ADD CONSTRAINT `FK_cfg_vehicles_cfg_vehicles_type` FOREIGN KEY (`type`) REFERENCES `cfg_vehicles_type` (`id`);

--
-- Constraints der Tabelle `characters_customization`
--
ALTER TABLE `characters_customization`
  ADD CONSTRAINT `FK_characters_customization_characters` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
