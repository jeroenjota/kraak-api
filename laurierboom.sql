/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: laurierboom
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `kingscore`
--

DROP TABLE IF EXISTS `kingscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kingscore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datum` datetime NOT NULL,
  `speler1` int(11) NOT NULL,
  `speler2` int(11) NOT NULL,
  `speler3` int(11) NOT NULL,
  `speler4` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kingscore`
--

LOCK TABLES `kingscore` WRITE;
/*!40000 ALTER TABLE `kingscore` DISABLE KEYS */;
/*!40000 ALTER TABLE `kingscore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kraakTeams`
--

DROP TABLE IF EXISTS `kraakTeams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kraakTeams` (
  `speler1` int(11) NOT NULL,
  `speler2` int(11) NOT NULL,
  PRIMARY KEY (`speler1`,`speler2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kraakTeams`
--

LOCK TABLES `kraakTeams` WRITE;
/*!40000 ALTER TABLE `kraakTeams` DISABLE KEYS */;
INSERT INTO `kraakTeams` VALUES
(1,2),
(1,11),
(2,140),
(3,7),
(3,11),
(5,6),
(5,18),
(5,139),
(6,11),
(7,11),
(7,22),
(8,9),
(8,21),
(9,11),
(9,12),
(9,13),
(10,11),
(10,20),
(10,21),
(10,22),
(11,13),
(12,13),
(12,22),
(14,15),
(16,17),
(16,20),
(17,20),
(18,19),
(131,132),
(131,134),
(136,137),
(141,142);
/*!40000 ALTER TABLE `kraakTeams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kraakmatches`
--

DROP TABLE IF EXISTS `kraakmatches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kraakmatches` (
  `tournooi_id` int(11) NOT NULL,
  `ronde` int(11) NOT NULL DEFAULT 0,
  `finaleronde` int(11) NOT NULL DEFAULT 0,
  `tafel` int(11) NOT NULL,
  `team1` varchar(100) DEFAULT NULL,
  `team2` varchar(100) DEFAULT NULL,
  `score1` int(11) DEFAULT 0,
  `score2` int(11) DEFAULT 0,
  PRIMARY KEY (`tournooi_id`,`ronde`,`finaleronde`,`tafel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kraakmatches`
--

LOCK TABLES `kraakmatches` WRITE;
/*!40000 ALTER TABLE `kraakmatches` DISABLE KEYS */;
/*!40000 ALTER TABLE `kraakmatches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kraaktoernooien`
--

DROP TABLE IF EXISTS `kraaktoernooien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kraaktoernooien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datum` date NOT NULL,
  `teams` longtext DEFAULT NULL,
  `groups` longtext DEFAULT NULL,
  `matches` longtext DEFAULT NULL,
  `groupMatches` longtext DEFAULT NULL,
  `finalMatches` longtext DEFAULT NULL,
  `groepsToernooi` tinyint(1) DEFAULT NULL,
  `repeatRounds` smallint(6) DEFAULT NULL,
  `pdfUrl` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kraaktoernooien_unique` (`datum`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kraaktoernooien`
--

LOCK TABLES `kraaktoernooien` WRITE;
/*!40000 ALTER TABLE `kraaktoernooien` DISABLE KEYS */;
INSERT INTO `kraaktoernooien` VALUES
(2,'2025-07-14','[\"Carla/Theo\",\"Cris/Ramon\",\"Gerard/Willem\",\"Jan/Angelo\",\"Jeroen/Ron\",\"Joost/Wim\",\"Tijmen/Karlijn\",\"Lize/Joren\"]','[[\"Cris/Ramon\",\"Tijmen/Karlijn\",\"Gerard/Willem\",\"Joost/Wim\"],[\"Jan/Angelo\",\"Jeroen/Ron\",\"Lize/Joren\",\"Carla/Theo\"]]','[]','[[[{\"tafel\":1,\"teamL\":\"Cris/Ramon\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2880,\"scoreR\":3910},{\"tafel\":2,\"teamL\":\"Tijmen/Karlijn\",\"teamR\":\"Joost/Wim\",\"scoreL\":1590,\"scoreR\":3340}],[{\"tafel\":1,\"teamL\":\"Cris/Ramon\",\"teamR\":\"Joost/Wim\",\"scoreL\":3240,\"scoreR\":2110},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Tijmen/Karlijn\",\"scoreL\":2250,\"scoreR\":3650}],[{\"tafel\":1,\"teamL\":\"Cris/Ramon\",\"teamR\":\"Tijmen/Karlijn\",\"scoreL\":3730,\"scoreR\":2370},{\"tafel\":2,\"teamL\":\"Joost/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2070,\"scoreR\":4020}]],[[{\"tafel\":3,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jan/Angelo\",\"scoreL\":2740,\"scoreR\":3760},{\"tafel\":4,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Lize/Joren\",\"scoreL\":3500,\"scoreR\":1790}],[{\"tafel\":3,\"teamL\":\"Carla/Theo\",\"teamR\":\"Lize/Joren\",\"scoreL\":3220,\"scoreR\":2580},{\"tafel\":4,\"teamL\":\"Jan/Angelo\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":3860,\"scoreR\":1850}],[{\"tafel\":3,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2240,\"scoreR\":4020},{\"tafel\":4,\"teamL\":\"Lize/Joren\",\"teamR\":\"Jan/Angelo\",\"scoreL\":4070,\"scoreR\":3060}]]]','[{\"teamL\":\"Gerard/Willem\",\"teamR\":\"Jan/Angelo\",\"scoreL\":1050,\"scoreR\":2500},{\"teamL\":\"Cris/Ramon\",\"teamR\":\"Ron/Jeroen\",\"scoreL\":800,\"scoreR\":2720}]',1,1,'kraken_14_jul_2025.pdf'),
(3,'2025-07-28','[\"Carla/Pieter\",\"Gerard/Willem\",\"Ramon/Angelo\",\"Joost/Wim\",\"Joren/Maarten\",\"Karlijn/Tijmen\"]','[]','[[{\"tafel\":1,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3020,\"scoreR\":870},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Joren/Maarten\",\"scoreL\":1170,\"scoreR\":3270},{\"tafel\":3,\"teamL\":\"Ramon/Angelo\",\"teamR\":\"Joost/Wim\",\"scoreL\":1780,\"scoreR\":2890}],[{\"tafel\":1,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Joren/Maarten\",\"scoreL\":1390,\"scoreR\":3040},{\"tafel\":2,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Joost/Wim\",\"scoreL\":2390,\"scoreR\":2810},{\"tafel\":3,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Ramon/Angelo\",\"scoreL\":3030,\"scoreR\":2120}],[{\"tafel\":1,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Joost/Wim\",\"scoreL\":3040,\"scoreR\":1520},{\"tafel\":2,\"teamL\":\"Joren/Maarten\",\"teamR\":\"Ramon/Angelo\",\"scoreL\":1990,\"scoreR\":2660},{\"tafel\":3,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1270,\"scoreR\":2720}],[{\"tafel\":1,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Ramon/Angelo\",\"scoreL\":3040,\"scoreR\":530},{\"tafel\":2,\"teamL\":\"Joost/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2900,\"scoreR\":1120},{\"tafel\":3,\"teamL\":\"Joren/Maarten\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":2700,\"scoreR\":1740}],[{\"tafel\":1,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2810,\"scoreR\":2240},{\"tafel\":2,\"teamL\":\"Ramon/Angelo\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3150,\"scoreR\":610},{\"tafel\":3,\"teamL\":\"Joost/Wim\",\"teamR\":\"Joren/Maarten\",\"scoreL\":1790,\"scoreR\":2610}]]','[]','[{\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null},{\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null}]',0,1,'kraken_15_aug_2025.pdf'),
(4,'2025-08-11','[\"Carla/Theo\",\"Gerard/Willem\",\"Jeroen/Angelo\",\"Joost/Wim\",\"Pieter/Frank\",\"Karlijn/Tijmen\"]','[]','[[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":2860,\"scoreR\":1790},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Pieter/Frank\",\"scoreL\":2880,\"scoreR\":2550},{\"tafel\":3,\"teamL\":\"Jeroen/Angelo\",\"teamR\":\"Joost/Wim\",\"scoreL\":3590,\"scoreR\":1430}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Pieter/Frank\",\"scoreL\":1040,\"scoreR\":2990},{\"tafel\":2,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Joost/Wim\",\"scoreL\":1900,\"scoreR\":2520},{\"tafel\":3,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Jeroen/Angelo\",\"scoreL\":1960,\"scoreR\":2780}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Joost/Wim\",\"scoreL\":2080,\"scoreR\":2640},{\"tafel\":2,\"teamL\":\"Pieter/Frank\",\"teamR\":\"Jeroen/Angelo\",\"scoreL\":3360,\"scoreR\":1710},{\"tafel\":3,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1790,\"scoreR\":2720}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jeroen/Angelo\",\"scoreL\":6320,\"scoreR\":1350},{\"tafel\":2,\"teamL\":\"Joost/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":790,\"scoreR\":2900},{\"tafel\":3,\"teamL\":\"Pieter/Frank\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3080,\"scoreR\":1040}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3860,\"scoreR\":2330},{\"tafel\":2,\"teamL\":\"Jeroen/Angelo\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3140,\"scoreR\":1120},{\"tafel\":3,\"teamL\":\"Joost/Wim\",\"teamR\":\"Pieter/Frank\",\"scoreL\":2740,\"scoreR\":2070}]]','[]','[]',0,1,'kraken_11_aug_2025.pdf'),
(30,'2025-09-08','[\"Carla/Theo\",\"Gerard/Willem\",\"Jan/Maarten\",\"Angelo/Wim\"]','[]','[[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Angelo/Wim\",\"scoreL\":2090,\"scoreR\":1340},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Jan/Maarten\",\"scoreL\":2210,\"scoreR\":910}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jan/Maarten\",\"scoreL\":2040,\"scoreR\":1340},{\"tafel\":2,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1290,\"scoreR\":1960}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1480,\"scoreR\":2240},{\"tafel\":2,\"teamL\":\"Jan/Maarten\",\"teamR\":\"Angelo/Wim\",\"scoreL\":1530,\"scoreR\":2100}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Angelo/Wim\",\"scoreL\":870,\"scoreR\":2100},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Jan/Maarten\",\"scoreL\":830,\"scoreR\":2170}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jan/Maarten\",\"scoreL\":1870,\"scoreR\":2600},{\"tafel\":2,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2120,\"scoreR\":1620}],[{\"tafel\":1,\"teamL\":\"Carla/Theo\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1320,\"scoreR\":3280},{\"tafel\":2,\"teamL\":\"Jan/Maarten\",\"teamR\":\"Angelo/Wim\",\"scoreL\":1600,\"scoreR\":2030}]]','[]','[{\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null},{\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null}]',0,2,'kraken_8_sep_2025.pdf'),
(31,'2025-09-22','[\"Carla/Theo\",\"Gerard/Willem\",\"Jeroen/Ron\",\"Karlijn/Tijmen\",\"Joost/Wim\",\"Lize/Maarten\",\"Cris/Robin\",\"Jan/Robert\"]','[[\"Jan/Robert\",\"Lize/Maarten\",\"Jeroen/Ron\",\"Gerard/Willem\"],[\"Karlijn/Tijmen\",\"Cris/Robin\",\"Carla/Theo\",\"Joost/Wim\"]]','[]','[[[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2590,\"scoreR\":2280},{\"tafel\":2,\"teamL\":\"Lize/Maarten\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2570,\"scoreR\":3190}],[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2800,\"scoreR\":1930},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Lize/Maarten\",\"scoreL\":3130,\"scoreR\":1520}],[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Lize/Maarten\",\"scoreL\":2160,\"scoreR\":2590},{\"tafel\":2,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3280,\"scoreR\":1970}]],[[{\"tafel\":3,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Joost/Wim\",\"scoreL\":1370,\"scoreR\":3150},{\"tafel\":4,\"teamL\":\"Cris/Robin\",\"teamR\":\"Carla/Theo\",\"scoreL\":1990,\"scoreR\":3090}],[{\"tafel\":3,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Carla/Theo\",\"scoreL\":1260,\"scoreR\":3030},{\"tafel\":4,\"teamL\":\"Joost/Wim\",\"teamR\":\"Cris/Robin\",\"scoreL\":3450,\"scoreR\":1440}],[{\"tafel\":3,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Cris/Robin\",\"scoreL\":2710,\"scoreR\":980},{\"tafel\":4,\"teamL\":\"Carla/Theo\",\"teamR\":\"Joost/Wim\",\"scoreL\":2360,\"scoreR\":3960}]]]','[{\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Joost/Wim\",\"scoreL\":1710,\"scoreR\":2880},{\"teamL\":\"Jan/Robert\",\"teamR\":\"Carla/Theo\",\"scoreL\":3220,\"scoreR\":920}]',1,1,'kraken_22_sep_2025.pdf'),
(49,'2025-10-13','[\"Angelo/Ramon\",\"Cris/Robin\",\"Joost/Wim\",\"Jeroen/Ron\",\"Jesse/Misja\",\"Carla/Pieter\",\"Karlijn/Tijmen\",\"Robert/Willem\"]','[[\"Robert/Willem\",\"Karlijn/Tijmen\",\"Carla/Pieter\",\"Jesse/Misja\"],[\"Jeroen/Ron\",\"Joost/Wim\",\"Cris/Robin\",\"Angelo/Ramon\"]]','[]','[[[{\"tafel\":1,\"teamL\":\"Robert/Willem\",\"teamR\":\"Jesse/Misja\",\"scoreL\":2150,\"scoreR\":2910},{\"tafel\":2,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2270,\"scoreR\":3010}],[{\"tafel\":1,\"teamL\":\"Robert/Willem\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2780,\"scoreR\":1240},{\"tafel\":2,\"teamL\":\"Jesse/Misja\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":2800,\"scoreR\":2220}],[{\"tafel\":1,\"teamL\":\"Robert/Willem\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":2930,\"scoreR\":970},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Jesse/Misja\",\"scoreL\":2890,\"scoreR\":1840}]],[[{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Angelo/Ramon\",\"scoreL\":2870,\"scoreR\":1080},{\"tafel\":4,\"teamL\":\"Joost/Wim\",\"teamR\":\"Cris/Robin\",\"scoreL\":1540,\"scoreR\":3400}],[{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Cris/Robin\",\"scoreL\":3030,\"scoreR\":960},{\"tafel\":4,\"teamL\":\"Angelo/Ramon\",\"teamR\":\"Joost/Wim\",\"scoreL\":3060,\"scoreR\":1660}],[{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Joost/Wim\",\"scoreL\":3080,\"scoreR\":1580},{\"tafel\":4,\"teamL\":\"Cris/Robin\",\"teamR\":\"Angelo/Ramon\",\"scoreL\":2190,\"scoreR\":3090}]]]','[{\"teamL\":\"Robert/Willem\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":1900,\"scoreR\":2890},{\"teamL\":\"Jesse/Misja\",\"teamR\":\"Angelo/Ramon\",\"scoreL\":3260,\"scoreR\":1690}]',1,1,'kraken_13_okt_2025.pdf'),
(60,'2025-10-27','[\"Cris/Robin\",\"Jan/Robert\",\"Joost/Wim\",\"Angelo/Theo\",\"Gerard/Willem\",\"Jeroen/Ron\"]','[]','[[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":960,\"scoreR\":2830},{\"tafel\":2,\"teamL\":\"Jan/Robert\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3740,\"scoreR\":820},{\"tafel\":3,\"teamL\":\"Joost/Wim\",\"teamR\":\"Angelo/Theo\",\"scoreL\":2260,\"scoreR\":2850}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3090,\"scoreR\":760},{\"tafel\":2,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Angelo/Theo\",\"scoreL\":3370,\"scoreR\":990},{\"tafel\":3,\"teamL\":\"Jan/Robert\",\"teamR\":\"Joost/Wim\",\"scoreL\":3040,\"scoreR\":940}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Angelo/Theo\",\"scoreL\":3220,\"scoreR\":150},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Joost/Wim\",\"scoreL\":2100,\"scoreR\":2800},{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Jan/Robert\",\"scoreL\":1350,\"scoreR\":2900}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Joost/Wim\",\"scoreL\":1410,\"scoreR\":4900},{\"tafel\":2,\"teamL\":\"Angelo/Theo\",\"teamR\":\"Jan/Robert\",\"scoreL\":2960,\"scoreR\":1370},{\"tafel\":3,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":1570,\"scoreR\":3320}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jan/Robert\",\"scoreL\":2250,\"scoreR\":2830},{\"tafel\":2,\"teamL\":\"Joost/Wim\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2970,\"scoreR\":1230},{\"tafel\":3,\"teamL\":\"Angelo/Theo\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3050,\"scoreR\":550}]]','[]','[]',0,1,'kraken_27_okt_2025.pdf'),
(61,'2025-11-10','[\"Angelo/Jeroen\",\"Carla/Pieter\",\"Gerard/Willem\",\"Cris/Ramon\",\"Joost/Wim\",\"Jan/Robert\"]','[]','[[{\"tafel\":1,\"teamL\":\"Angelo/Jeroen\",\"teamR\":\"Jan/Robert\",\"scoreL\":3520,\"scoreR\":1400},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Joost/Wim\",\"scoreL\":1530,\"scoreR\":2140},{\"tafel\":3,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Cris/Ramon\",\"scoreL\":3060,\"scoreR\":1820}],[{\"tafel\":1,\"teamL\":\"Angelo/Jeroen\",\"teamR\":\"Joost/Wim\",\"scoreL\":2930,\"scoreR\":2010},{\"tafel\":2,\"teamL\":\"Jan/Robert\",\"teamR\":\"Cris/Ramon\",\"scoreL\":2820,\"scoreR\":1590},{\"tafel\":3,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2270,\"scoreR\":3210}],[{\"tafel\":1,\"teamL\":\"Angelo/Jeroen\",\"teamR\":\"Cris/Ramon\",\"scoreL\":3300,\"scoreR\":640},{\"tafel\":2,\"teamL\":\"Joost/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1550,\"scoreR\":3580},{\"tafel\":3,\"teamL\":\"Jan/Robert\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2180,\"scoreR\":2900}],[{\"tafel\":1,\"teamL\":\"Angelo/Jeroen\",\"teamR\":\"Gerard/Willem\",\"scoreL\":400,\"scoreR\":3070},{\"tafel\":2,\"teamL\":\"Cris/Ramon\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2140,\"scoreR\":3420},{\"tafel\":3,\"teamL\":\"Joost/Wim\",\"teamR\":\"Jan/Robert\",\"scoreL\":1970,\"scoreR\":3150}],[{\"tafel\":1,\"teamL\":\"Angelo/Jeroen\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2880,\"scoreR\":1560},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Jan/Robert\",\"scoreL\":2600,\"scoreR\":2140},{\"tafel\":3,\"teamL\":\"Cris/Ramon\",\"teamR\":\"Joost/Wim\",\"scoreL\":1110,\"scoreR\":3070}]]','[]','[]',0,1,'kraken_10_nov_2025.pdf'),
(63,'2025-11-24','[\"Cris/Robin\",\"Joost/Ramon\",\"Angelo/Gerard\",\"Carla/Pieter\"]','[]','[[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Carla/Pieter\",\"scoreL\":640,\"scoreR\":2410},{\"tafel\":2,\"teamL\":\"Joost/Ramon\",\"teamR\":\"Angelo/Gerard\",\"scoreL\":2490,\"scoreR\":1240}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Angelo/Gerard\",\"scoreL\":1290,\"scoreR\":2470},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Joost/Ramon\",\"scoreL\":2780,\"scoreR\":1100}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Joost/Ramon\",\"scoreL\":2250,\"scoreR\":1920},{\"tafel\":2,\"teamL\":\"Angelo/Gerard\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2130,\"scoreR\":2520}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Carla/Pieter\",\"scoreL\":550,\"scoreR\":2320},{\"tafel\":2,\"teamL\":\"Joost/Ramon\",\"teamR\":\"Angelo/Gerard\",\"scoreL\":880,\"scoreR\":2680}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Angelo/Gerard\",\"scoreL\":1890,\"scoreR\":2400},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Joost/Ramon\",\"scoreL\":1630,\"scoreR\":2450}],[{\"tafel\":1,\"teamL\":\"Cris/Robin\",\"teamR\":\"Joost/Ramon\",\"scoreL\":1710,\"scoreR\":2450},{\"tafel\":2,\"teamL\":\"Angelo/Gerard\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2460,\"scoreR\":1270}]]','[]','[]',0,2,'kraken_24_nov_2025.pdf'),
(73,'2025-12-08','[\"Jan/Robin\",\"Ramon/Wim\",\"Gerard/Willem\",\"Carla/Pieter\",\"Jeroen/Ron\"]','[]','[[{\"tafel\":1,\"teamL\":\"Jan/Robin\",\"teamR\":\"VRIJ\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"Ramon/Wim\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":1230,\"scoreR\":3100},{\"tafel\":3,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2760,\"scoreR\":2270}],[{\"tafel\":1,\"teamL\":\"Jan/Robin\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2490,\"scoreR\":2760},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"VRIJ\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":3,\"teamL\":\"Ramon/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2790,\"scoreR\":2060}],[{\"tafel\":1,\"teamL\":\"Jan/Robin\",\"teamR\":\"Carla/Pieter\",\"scoreL\":3730,\"scoreR\":1210},{\"tafel\":2,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3580,\"scoreR\":1140},{\"tafel\":3,\"teamL\":\"Ramon/Wim\",\"teamR\":\"VRIJ\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":1,\"teamL\":\"Jan/Robin\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2200,\"scoreR\":3210},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Ramon/Wim\",\"scoreL\":590,\"scoreR\":3130},{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"VRIJ\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":1,\"teamL\":\"Jan/Robin\",\"teamR\":\"Ramon/Wim\",\"scoreL\":3580,\"scoreR\":1700},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"VRIJ\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":3,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2440,\"scoreR\":1710}]]','[]','[]',0,1,'kraken_8_dec_2025.pdf'),
(75,'2025-12-22','[\"Angelo/Willem\",\"Carla/Theo\",\"Cris/Robin\",\"Jeroen/Ron\",\"Jesse/Yorik\",\"Paul/Wiebo\",\"Joost/Robert\",\"Frank/Pieter\"]','[[\"Frank/Pieter\",\"Joost/Robert\",\"Angelo/Willem\",\"Cris/Robin\"],[\"Jeroen/Ron\",\"Jesse/Yorik\",\"Paul/Wiebo\",\"Carla/Theo\"]]','[]','[[[{\"tafel\":1,\"teamL\":\"Frank/Pieter\",\"teamR\":\"Cris/Robin\",\"scoreL\":1680,\"scoreR\":2610},{\"tafel\":2,\"teamL\":\"Joost/Robert\",\"teamR\":\"Angelo/Willem\",\"scoreL\":2580,\"scoreR\":1020}],[{\"tafel\":1,\"teamL\":\"Frank/Pieter\",\"teamR\":\"Angelo/Willem\",\"scoreL\":1630,\"scoreR\":2740},{\"tafel\":2,\"teamL\":\"Cris/Robin\",\"teamR\":\"Joost/Robert\",\"scoreL\":1880,\"scoreR\":3060}],[{\"tafel\":1,\"teamL\":\"Frank/Pieter\",\"teamR\":\"Joost/Robert\",\"scoreL\":2620,\"scoreR\":1710},{\"tafel\":2,\"teamL\":\"Angelo/Willem\",\"teamR\":\"Cris/Robin\",\"scoreL\":2830,\"scoreR\":1730}]],[[{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Carla/Theo\",\"scoreL\":2670,\"scoreR\":730},{\"tafel\":4,\"teamL\":\"Jesse/Yorik\",\"teamR\":\"Paul/Wiebo\",\"scoreL\":2820,\"scoreR\":720}],[{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Paul/Wiebo\",\"scoreL\":1800,\"scoreR\":2510},{\"tafel\":4,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jesse/Yorik\",\"scoreL\":2680,\"scoreR\":670}],[{\"tafel\":3,\"teamL\":\"Jeroen/Ron\",\"teamR\":\"Jesse/Yorik\",\"scoreL\":1490,\"scoreR\":2430},{\"tafel\":4,\"teamL\":\"Paul/Wiebo\",\"teamR\":\"Carla/Theo\",\"scoreL\":3490,\"scoreR\":1590}]]]','[{\"tafel\":1,\"teamL\":\"Joost/Robert\",\"teamR\":\"Paul/Wiebo\",\"scoreL\":2130,\"scoreR\":2800,\"pl\":1},{\"tafel\":2,\"teamL\":\"Angelo/Willem\",\"teamR\":\"Jeroen/Ron\",\"scoreL\":2850,\"scoreR\":780,\"pl\":3},{\"tafel\":3,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jesse/Yorik\",\"scoreL\":3340,\"scoreR\":680,\"pl\":5},{\"tafel\":4,\"teamL\":\"Frank/Pieter\",\"teamR\":\"Carla/Theo\",\"scoreL\":2490,\"scoreR\":2050,\"pl\":7}]',1,1,'kraken_9_jan_2026.pdf'),
(96,'2026-01-12','[\"Carla/Wiebe\",\"Ramon/Wim\",\"Gerard/Willem\",\"Karlijn/Tijmen\"]','[]','[[{\"tafel\":1,\"teamL\":\"Carla/Wiebe\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3540,\"scoreR\":2600},{\"tafel\":2,\"teamL\":\"Ramon/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3460,\"scoreR\":2310}],[{\"tafel\":1,\"teamL\":\"Carla/Wiebe\",\"teamR\":\"Gerard/Willem\",\"scoreL\":860,\"scoreR\":3640},{\"tafel\":2,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Ramon/Wim\",\"scoreL\":2300,\"scoreR\":3330}],[{\"tafel\":1,\"teamL\":\"Carla/Wiebe\",\"teamR\":\"Ramon/Wim\",\"scoreL\":2530,\"scoreR\":3210},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":5100,\"scoreR\":620}]]','[]','[{\"tafel\":1,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":1},{\"tafel\":2,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":3},{\"tafel\":3,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":5},{\"tafel\":4,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":7}]',0,1,'kraken_13_jan_2026.pdf'),
(99,'2026-01-26','[\"Jan/Robert\",\"Fleur/Ron\",\"Carla/Pieter\",\"Ramon/Wim\",\"Gerard/Willem\",\"Cris/Robin\"]','[]','[[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Cris/Robin\",\"scoreL\":2600,\"scoreR\":1720},{\"tafel\":2,\"teamL\":\"Fleur/Ron\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1840,\"scoreR\":3130},{\"tafel\":3,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Ramon/Wim\",\"scoreL\":3200,\"scoreR\":2170}],[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Gerard/Willem\",\"scoreL\":1810,\"scoreR\":2820},{\"tafel\":2,\"teamL\":\"Cris/Robin\",\"teamR\":\"Ramon/Wim\",\"scoreL\":1380,\"scoreR\":2700},{\"tafel\":3,\"teamL\":\"Fleur/Ron\",\"teamR\":\"Carla/Pieter\",\"scoreL\":1850,\"scoreR\":2890}],[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Ramon/Wim\",\"scoreL\":520,\"scoreR\":3710},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Carla/Pieter\",\"scoreL\":2090,\"scoreR\":2860},{\"tafel\":3,\"teamL\":\"Cris/Robin\",\"teamR\":\"Fleur/Ron\",\"scoreL\":680,\"scoreR\":2800}],[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Carla/Pieter\",\"scoreL\":1890,\"scoreR\":2790},{\"tafel\":2,\"teamL\":\"Ramon/Wim\",\"teamR\":\"Fleur/Ron\",\"scoreL\":1150,\"scoreR\":2620},{\"tafel\":3,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Cris/Robin\",\"scoreL\":2100,\"scoreR\":2630}],[{\"tafel\":1,\"teamL\":\"Jan/Robert\",\"teamR\":\"Fleur/Ron\",\"scoreL\":2050,\"scoreR\":2650},{\"tafel\":2,\"teamL\":\"Carla/Pieter\",\"teamR\":\"Cris/Robin\",\"scoreL\":3260,\"scoreR\":1950},{\"tafel\":3,\"teamL\":\"Ramon/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":2110,\"scoreR\":2860}]]','[]','[{\"tafel\":1,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":1},{\"tafel\":2,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":3},{\"tafel\":3,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":5},{\"tafel\":4,\"teamL\":null,\"teamR\":null,\"scoreL\":null,\"scoreR\":null,\"pl\":7}]',0,1,'kraken_26_jan_2026.pdf'),
(100,'2026-02-09','[\"Angelo/Wim\",\"Cris/Robin\",\"Jan/Robert\",\"Karlijn/Tijmen\",\"Carla/Theo\",\"Gerard/Willem\",\"/Pieter/Ramon\",\"Jannpaul/Pieterr\"]','[[\"Angelo/Wim\",\"Carla/Theo\",\"/Pieter/Ramon\",\"Gerard/Willem\"],[\"Jannpaul/Pieterr\",\"Cris/Robin\",\"Jan/Robert\",\"Karlijn/Tijmen\"]]','[]','[[[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":4760,\"scoreR\":760},{\"tafel\":2,\"teamL\":\"Carla/Theo\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":4110,\"scoreR\":2430}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":3930,\"scoreR\":1640},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Carla/Theo\",\"scoreL\":3340,\"scoreR\":1940}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Carla/Theo\",\"scoreL\":1150,\"scoreR\":3570},{\"tafel\":2,\"teamL\":\"/Pieter/Ramon\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3460,\"scoreR\":2950}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"Carla/Theo\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Carla/Theo\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Carla/Theo\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"/Pieter/Ramon\",\"teamR\":\"Gerard/Willem\",\"scoreL\":0,\"scoreR\":0}]],[[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3760,\"scoreR\":2710},{\"tafel\":4,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jan/Robert\",\"scoreL\":2040,\"scoreR\":4480}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Jan/Robert\",\"scoreL\":3440,\"scoreR\":2460},{\"tafel\":4,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Cris/Robin\",\"scoreL\":720,\"scoreR\":3780}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Cris/Robin\",\"scoreL\":3360,\"scoreR\":2590},{\"tafel\":4,\"teamL\":\"Jan/Robert\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3660,\"scoreR\":1210}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":4,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jan/Robert\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Jan/Robert\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":4,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Cris/Robin\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Cris/Robin\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":4,\"teamL\":\"Jan/Robert\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":0,\"scoreR\":0}]]]','[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Jan/Robert\",\"scoreL\":3780,\"scoreR\":1700,\"pl\":1},{\"tafel\":2,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jannpaul/Pieterr\",\"scoreL\":1990,\"scoreR\":3190,\"pl\":3},{\"tafel\":3,\"teamL\":\"/Pieter/Ramon\",\"teamR\":\"Cris/Robin\",\"scoreL\":null,\"scoreR\":null,\"pl\":5},{\"tafel\":4,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":null,\"scoreR\":null,\"pl\":7}]',1,2,'kraken_10_feb_2026.pdf'),
(101,'2026-02-10','[\"Angelo/Wim\",\"Cris/Robin\",\"Jan/Robert\",\"Karlijn/Tijmen\",\"Carla/Theo\",\"Gerard/Willem\",\"/Pieter/Ramon\",\"Jannpaul/Pieterr\"]','[[\"Angelo/Wim\",\"Carla/Theo\",\"/Pieter/Ramon\",\"Gerard/Willem\"],[\"Jannpaul/Pieterr\",\"Cris/Robin\",\"Jan/Robert\",\"Karlijn/Tijmen\"]]','[]','[[[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":4760,\"scoreR\":760},{\"tafel\":2,\"teamL\":\"Carla/Theo\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":4110,\"scoreR\":2430}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":3930,\"scoreR\":1640},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Carla/Theo\",\"scoreL\":3340,\"scoreR\":1940}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Carla/Theo\",\"scoreL\":1150,\"scoreR\":3570},{\"tafel\":2,\"teamL\":\"/Pieter/Ramon\",\"teamR\":\"Gerard/Willem\",\"scoreL\":3460,\"scoreR\":2950}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Gerard/Willem\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"Carla/Theo\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"/Pieter/Ramon\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Carla/Theo\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Carla/Theo\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":2,\"teamL\":\"/Pieter/Ramon\",\"teamR\":\"Gerard/Willem\",\"scoreL\":0,\"scoreR\":0}]],[[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3760,\"scoreR\":2710},{\"tafel\":4,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jan/Robert\",\"scoreL\":2040,\"scoreR\":4480}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Jan/Robert\",\"scoreL\":3440,\"scoreR\":2460},{\"tafel\":4,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Cris/Robin\",\"scoreL\":720,\"scoreR\":3780}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Cris/Robin\",\"scoreL\":3360,\"scoreR\":2590},{\"tafel\":4,\"teamL\":\"Jan/Robert\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":3660,\"scoreR\":1210}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":4,\"teamL\":\"Cris/Robin\",\"teamR\":\"Jan/Robert\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Jan/Robert\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":4,\"teamL\":\"Karlijn/Tijmen\",\"teamR\":\"Cris/Robin\",\"scoreL\":0,\"scoreR\":0}],[{\"tafel\":3,\"teamL\":\"Jannpaul/Pieterr\",\"teamR\":\"Cris/Robin\",\"scoreL\":0,\"scoreR\":0},{\"tafel\":4,\"teamL\":\"Jan/Robert\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":0,\"scoreR\":0}]]]','[{\"tafel\":1,\"teamL\":\"Angelo/Wim\",\"teamR\":\"Jan/Robert\",\"scoreL\":3780,\"scoreR\":1700,\"pl\":1},{\"tafel\":2,\"teamL\":\"Carla/Theo\",\"teamR\":\"Jannpaul/Pieterr\",\"scoreL\":1990,\"scoreR\":3190,\"pl\":3},{\"tafel\":3,\"teamL\":\"/Pieter/Ramon\",\"teamR\":\"Cris/Robin\",\"scoreL\":null,\"scoreR\":null,\"pl\":5},{\"tafel\":4,\"teamL\":\"Gerard/Willem\",\"teamR\":\"Karlijn/Tijmen\",\"scoreL\":null,\"scoreR\":null,\"pl\":7}]',1,2,'kraken_10_feb_2026.pdf');
/*!40000 ALTER TABLE `kraaktoernooien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spelers`
--

DROP TABLE IF EXISTS `spelers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `spelers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spelers`
--

LOCK TABLES `spelers` WRITE;
/*!40000 ALTER TABLE `spelers` DISABLE KEYS */;
INSERT INTO `spelers` VALUES
(1,'Jeroen'),
(2,'Ron'),
(3,'Gerard'),
(5,'Carla'),
(6,'Theo'),
(7,'Willem'),
(8,'Cris'),
(9,'Ramon'),
(10,'Jan'),
(11,'Angelo'),
(12,'Joost'),
(13,'Wim'),
(14,'Karlijn'),
(15,'Tijmen'),
(16,'Lize'),
(17,'Joren'),
(18,'Pieter'),
(19,'Frank'),
(20,'Maarten'),
(21,'Robin'),
(22,'Robert'),
(131,'Jesse'),
(132,'Misja'),
(134,'Yorik'),
(136,'Paul'),
(137,'Wiebo'),
(139,'Wiebe'),
(140,'Fleur'),
(141,'Jannpaul'),
(142,'Pieterr');
/*!40000 ALTER TABLE `spelers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `teamSpelers`
--

DROP TABLE IF EXISTS `teamSpelers`;
/*!50001 DROP VIEW IF EXISTS `teamSpelers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `teamSpelers` AS SELECT
 1 AS `speler1`,
  1 AS `speler2`,
  1 AS `teamNaam` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `toernooiTeams`
--

DROP TABLE IF EXISTS `toernooiTeams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `toernooiTeams` (
  `tnID` int(11) DEFAULT NULL,
  `teamSpelers` varchar(100) NOT NULL,
  KEY `toernooiTeams_kraaktoernooien_FK` (`tnID`),
  CONSTRAINT `toernooiTeams_kraaktoernooien_FK` FOREIGN KEY (`tnID`) REFERENCES `kraaktoernooien` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toernooiTeams`
--

LOCK TABLES `toernooiTeams` WRITE;
/*!40000 ALTER TABLE `toernooiTeams` DISABLE KEYS */;
/*!40000 ALTER TABLE `toernooiTeams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'laurierboom'
--

--
-- Final view structure for view `teamSpelers`
--

/*!50001 DROP VIEW IF EXISTS `teamSpelers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jeroen`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `teamSpelers` AS select `kt`.`speler1` AS `speler1`,`kt`.`speler2` AS `speler2`,concat(`s1`.`naam`,'/',`s2`.`naam`) AS `teamNaam` from ((`kraakTeams` `kt` join `spelers` `s1` on(`kt`.`speler1` = `s1`.`id`)) join `spelers` `s2` on(`kt`.`speler2` = `s2`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-10 14:09:57
