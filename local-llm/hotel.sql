-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: wp-latestmysql.cidgyvjmrgz1.eu-west-1.rds.amazonaws.com    Database: hotel
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `amenity`
--

DROP TABLE IF EXISTS `amenity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenity` (
  `enabled` bit(1) NOT NULL,
  `amenity_type_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKobi8c74x00g3x6un129ehoru9` (`amenity_type_id`),
  CONSTRAINT `FKobi8c74x00g3x6un129ehoru9` FOREIGN KEY (`amenity_type_id`) REFERENCES `amenity_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amenity_aud`
--

DROP TABLE IF EXISTS `amenity_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenity_aud` (
  `enabled` bit(1) DEFAULT NULL,
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKacej7xrl3p2nfgpirhg874t3d` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amenity_type`
--

DROP TABLE IF EXISTS `amenity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenity_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge`
--

DROP TABLE IF EXISTS `charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charge` (
  `value` int NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `currency` enum('EUR','CZK','USD') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_aud`
--

DROP TABLE IF EXISTS `charge_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charge_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `value` int DEFAULT NULL,
  `id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `currency` enum('EUR','CZK','USD') DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKqpwh39lpbp9askxkyq0yqa96y` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_aud`
--

DROP TABLE IF EXISTS `contact_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `id` bigint NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKax6dmwbixsgvotyxv31vs1u3y` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guest`
--

DROP TABLE IF EXISTS `guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest` (
  `contact_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `identification_id` bigint DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5hx4n5aut925v5w06jo07rfya` (`contact_id`),
  KEY `FKnv0hj4k5ek6cg2ileb7e4j595` (`identification_id`),
  CONSTRAINT `FK5hx4n5aut925v5w06jo07rfya` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FKnv0hj4k5ek6cg2ileb7e4j595` FOREIGN KEY (`identification_id`) REFERENCES `identification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guest_aud`
--

DROP TABLE IF EXISTS `guest_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `contact_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `identification_id` bigint DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FK33a4p314vesmft1ynvn9bjxip` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `identification`
--

DROP TABLE IF EXISTS `identification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `identification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `id_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `id_type` enum('PASSPORT','ID_CARD','DRIVERS_LICENSE') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `identification_aud`
--

DROP TABLE IF EXISTS `identification_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `identification_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `id_type` enum('PASSPORT','ID_CARD','DRIVERS_LICENSE') DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKsg78aevgfinob6chttg1admjx` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `created_by_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `made_out_to_id` bigint DEFAULT NULL,
  `payment_id` bigint DEFAULT NULL,
  `invoice_status` enum('CREATED','NOT_PAID','PAID','DUE','EXPIRED') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_5vvlr4mmb6jbwiu4dyqwevd0d` (`payment_id`),
  KEY `FKav6vvtwsm2hw2p8d0sla3uoi1` (`created_by_id`),
  KEY `FKs688967mh6xihwga4mwxdhihl` (`made_out_to_id`),
  CONSTRAINT `FKav6vvtwsm2hw2p8d0sla3uoi1` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKbaxa82hce5x7dqj0sotnc1cxf` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FKs688967mh6xihwga4mwxdhihl` FOREIGN KEY (`made_out_to_id`) REFERENCES `guest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_aud`
--

DROP TABLE IF EXISTS `invoice_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `made_out_to_id` bigint DEFAULT NULL,
  `payment_id` bigint DEFAULT NULL,
  `invoice_status` enum('CREATED','NOT_PAID','PAID','DUE','EXPIRED') DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FK57bloicw9h0k4c7xwn0i7u29p` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_date` datetime(6) DEFAULT NULL,
  `reservation_id` bigint DEFAULT NULL,
  `payment_type` enum('CASH','CREDIT_CARD') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrewpj5f9v9xehy4ga8g221nw1` (`reservation_id`),
  CONSTRAINT `FKrewpj5f9v9xehy4ga8g221nw1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_aud`
--

DROP TABLE IF EXISTS `payment_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `id` bigint NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `payment_type` enum('CASH','CREDIT_CARD') DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FK1uumpbl0vkiohnbo3v2pp4qsj` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_reservation_charges`
--

DROP TABLE IF EXISTS `payment_reservation_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_reservation_charges` (
  `payment_id` bigint NOT NULL,
  `reservation_charges_id` bigint NOT NULL,
  UNIQUE KEY `UK_91qujj1gj4pekxf7cujceobkb` (`reservation_charges_id`),
  KEY `FK7tp59uicdgd6hnvw09gqpv0nl` (`payment_id`),
  CONSTRAINT `FK7tp59uicdgd6hnvw09gqpv0nl` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FKrn2jatbw1jb5ugfwu0ywjub0n` FOREIGN KEY (`reservation_charges_id`) REFERENCES `reservation_charge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_reservation_charges_aud`
--

DROP TABLE IF EXISTS `payment_reservation_charges_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_reservation_charges_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `payment_id` bigint NOT NULL,
  `reservation_charges_id` bigint NOT NULL,
  PRIMARY KEY (`rev`,`payment_id`,`reservation_charges_id`),
  CONSTRAINT `FKjjq72943q10ui7ae3n4h8d7up` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privilege` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `privilege_aud`
--

DROP TABLE IF EXISTS `privilege_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privilege_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `id` bigint NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKtj57yxwaw5pkkxnt1a69rwidy` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `discount` double NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `discount_authorised_by_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `reservation_status` enum('FULFILLED','IN_PROGRESS','UP_COMING','CANCELLED','ABANDONED') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqiswbwd12rssb3bg38fjjhhtw` (`created_by_id`),
  KEY `FKmv4hcn185mffom67lsqxq6p9l` (`discount_authorised_by_id`),
  CONSTRAINT `FKmv4hcn185mffom67lsqxq6p9l` FOREIGN KEY (`discount_authorised_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKqiswbwd12rssb3bg38fjjhhtw` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_cancellation`
--

DROP TABLE IF EXISTS `reservation_cancellation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_cancellation` (
  `cancelled_by_id` bigint DEFAULT NULL,
  `cancelled_on` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_srfbolv81mep1v0asil24h5qp` (`reservation_id`),
  KEY `FKbi3td6b6qu94u786ic7nxva2w` (`cancelled_by_id`),
  CONSTRAINT `FKauw9rgd50xvvmksub61spebru` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `FKbi3td6b6qu94u786ic7nxva2w` FOREIGN KEY (`cancelled_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_charge`
--

DROP TABLE IF EXISTS `reservation_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_charge` (
  `quantity` int NOT NULL,
  `charge_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd7c8oa87964kpykn505h8do5f` (`charge_id`),
  KEY `FKjeqast1ewwsb2dnj9f9kfg6sr` (`reservation_id`),
  CONSTRAINT `FKd7c8oa87964kpykn505h8do5f` FOREIGN KEY (`charge_id`) REFERENCES `charge` (`id`),
  CONSTRAINT `FKjeqast1ewwsb2dnj9f9kfg6sr` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_charge_aud`
--

DROP TABLE IF EXISTS `reservation_charge_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_charge_aud` (
  `quantity` int DEFAULT NULL,
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `charge_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FK62fy0xb47mr9nkc0w5mc22apd` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_checkout`
--

DROP TABLE IF EXISTS `reservation_checkout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_checkout` (
  `checked_out_by_id` bigint DEFAULT NULL,
  `checkedout` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_id` bigint DEFAULT NULL,
  `reservation_id` bigint DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_8fcka0qbhe2lxaixpb2x82dkh` (`payment_id`),
  UNIQUE KEY `UK_lfkqv77nsodiqurxhr4nmobcu` (`reservation_id`),
  KEY `FK3yo4xeg8wp2je1l2larpj1wal` (`checked_out_by_id`),
  CONSTRAINT `FK3yo4xeg8wp2je1l2larpj1wal` FOREIGN KEY (`checked_out_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK82g0umropse0nyjio84tklpmt` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `FK8yl89eq3d4c70sjgk8o8gly4w` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_checkout_aud`
--

DROP TABLE IF EXISTS `reservation_checkout_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_checkout_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `checked_out_by_id` bigint DEFAULT NULL,
  `checkedout` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `payment_id` bigint DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FK8fcefnkhrqrokstgald7h7jjl` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_occupants`
--

DROP TABLE IF EXISTS `reservation_occupants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_occupants` (
  `occupants_id` bigint NOT NULL,
  `reservation_id` bigint NOT NULL,
  KEY `FK3hluk528j390n0wkq73y8k97y` (`occupants_id`),
  KEY `FKbktetfx2dr10morg8pdrsp2gs` (`reservation_id`),
  CONSTRAINT `FK3hluk528j390n0wkq73y8k97y` FOREIGN KEY (`occupants_id`) REFERENCES `guest` (`id`),
  CONSTRAINT `FKbktetfx2dr10morg8pdrsp2gs` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_room_rates`
--

DROP TABLE IF EXISTS `reservation_room_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_room_rates` (
  `reservation_id` bigint NOT NULL,
  `room_rates_id` bigint NOT NULL,
  KEY `FKnfh7smn3djfotfcxpq1dfnrmt` (`room_rates_id`),
  KEY `FKfh4o7xk6p4pbes8c0u485i2ys` (`reservation_id`),
  CONSTRAINT `FKfh4o7xk6p4pbes8c0u485i2ys` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `FKnfh7smn3djfotfcxpq1dfnrmt` FOREIGN KEY (`room_rates_id`) REFERENCES `room_rate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revinfo`
--

DROP TABLE IF EXISTS `revinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revinfo` (
  `rev` int NOT NULL AUTO_INCREMENT,
  `revtstmp` bigint DEFAULT NULL,
  PRIMARY KEY (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `enabled` bit(1) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_aud`
--

DROP TABLE IF EXISTS `role_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_aud` (
  `enabled` bit(1) DEFAULT NULL,
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKrks7qtsmup3w81fdp0d6omfk7` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_privileges`
--

DROP TABLE IF EXISTS `role_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_privileges` (
  `privileges_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  KEY `FKas5s9i1itvr8tgocse4xmtwox` (`privileges_id`),
  KEY `FKgelpp2j5e63axp7bcguwaqec5` (`role_id`),
  CONSTRAINT `FKas5s9i1itvr8tgocse4xmtwox` FOREIGN KEY (`privileges_id`) REFERENCES `privilege` (`id`),
  CONSTRAINT `FKgelpp2j5e63axp7bcguwaqec5` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_privileges_aud`
--

DROP TABLE IF EXISTS `role_privileges_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_privileges_aud` (
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `privileges_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`rev`,`privileges_id`,`role_id`),
  CONSTRAINT `FK155i5mp32rcan1weviqqqm8x5` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_number` int NOT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_type_id` bigint DEFAULT NULL,
  `status_id` bigint DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKm2ep0b8dlbxfaeu44b2xbb05t` (`created_by_id`),
  KEY `FKd468eq7j1cbue8mk20qfrj5et` (`room_type_id`),
  KEY `FKp8wjxnfsex5xdjqn3sn6qt863` (`status_id`),
  CONSTRAINT `FKd468eq7j1cbue8mk20qfrj5et` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`id`),
  CONSTRAINT `FKm2ep0b8dlbxfaeu44b2xbb05t` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKp8wjxnfsex5xdjqn3sn6qt863` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_rate`
--

DROP TABLE IF EXISTS `room_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_rate` (
  `day` date DEFAULT NULL,
  `value` int NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_id` bigint DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `currency` enum('EUR','CZK','USD') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_name` (`room_id`,`day`),
  CONSTRAINT `FKsw0yul8g6og45ngci0t3250oi` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_rate_aud`
--

DROP TABLE IF EXISTS `room_rate_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_rate_aud` (
  `day` date DEFAULT NULL,
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `value` int DEFAULT NULL,
  `id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `currency` enum('EUR','CZK','USD') DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKc44wbv8ar0r5bh664y12cnf0m` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_room_amenities`
--

DROP TABLE IF EXISTS `room_room_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_room_amenities` (
  `room_amenities_id` bigint NOT NULL,
  `room_id` bigint NOT NULL,
  KEY `FK5joxi683flcqbcdgow3jr3mlb` (`room_amenities_id`),
  KEY `FKfwdb850rnhlbdf4cawe7k1874` (`room_id`),
  CONSTRAINT `FK5joxi683flcqbcdgow3jr3mlb` FOREIGN KEY (`room_amenities_id`) REFERENCES `amenity` (`id`),
  CONSTRAINT `FKfwdb850rnhlbdf4cawe7k1874` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stay`
--

DROP TABLE IF EXISTS `stay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stay` (
  `duration` int NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stay_aud`
--

DROP TABLE IF EXISTS `stay_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stay_aud` (
  `duration` int DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `id` bigint NOT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FKping5ktigf1dl58suor0afndn` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stay_reservations`
--

DROP TABLE IF EXISTS `stay_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stay_reservations` (
  `reservations_id` bigint NOT NULL,
  `stay_id` bigint NOT NULL,
  KEY `FKorerx4o7h5fp9aaoj9lts59f7` (`reservations_id`),
  KEY `FKg69f8iq3q5ebqsuwca9kco9af` (`stay_id`),
  CONSTRAINT `FKg69f8iq3q5ebqsuwca9kco9af` FOREIGN KEY (`stay_id`) REFERENCES `stay` (`id`),
  CONSTRAINT `FKorerx4o7h5fp9aaoj9lts59f7` FOREIGN KEY (`reservations_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `enabled` bit(1) NOT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `disabled_by_id` bigint DEFAULT NULL,
  `disabled_on` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lastlogged_on` datetime(6) DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_userName` (`user_name`),
  KEY `FK9o7r2qptrh93devpob11veidj` (`created_by_id`),
  KEY `FKapagjng0cl2d2p4kilsg2s68t` (`disabled_by_id`),
  KEY `FKn82ha3ccdebhokx3a8fgdqeyy` (`role_id`),
  CONSTRAINT `FK9o7r2qptrh93devpob11veidj` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKapagjng0cl2d2p4kilsg2s68t` FOREIGN KEY (`disabled_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKn82ha3ccdebhokx3a8fgdqeyy` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_aud`
--

DROP TABLE IF EXISTS `user_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_aud` (
  `enabled` bit(1) DEFAULT NULL,
  `rev` int NOT NULL,
  `revtype` tinyint DEFAULT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `disabled_by_id` bigint DEFAULT NULL,
  `disabled_on` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `lastlogged_on` datetime(6) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rev`,`id`),
  CONSTRAINT `FK89ntto9kobwahrwxbne2nqcnr` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-26 11:38:20
