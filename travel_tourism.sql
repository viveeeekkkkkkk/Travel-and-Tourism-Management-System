-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: travel_tourism
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking_members`
--

DROP TABLE IF EXISTS `booking_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_members` (
  `member_id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` bigint NOT NULL,
  `member_name` varchar(100) NOT NULL,
  PRIMARY KEY (`member_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `booking_members_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `bookings` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_members`
--

LOCK TABLES `booking_members` WRITE;
/*!40000 ALTER TABLE `booking_members` DISABLE KEYS */;
INSERT INTO `booking_members` VALUES (24,845880,'Vivek shar,a'),(25,845880,'Diya Sharma');
/*!40000 ALTER TABLE `booking_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_persons`
--

DROP TABLE IF EXISTS `booking_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_persons` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `book_id` bigint NOT NULL,
  `person_name` varchar(100) NOT NULL,
  PRIMARY KEY (`person_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `booking_persons_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `bookings` (`book_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_persons`
--

LOCK TABLES `booking_persons` WRITE;
/*!40000 ALTER TABLE `booking_persons` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `book_id` bigint NOT NULL AUTO_INCREMENT,
  `tour_id` int NOT NULL,
  `hotel_id1` int NOT NULL,
  `hotel_id2` int NOT NULL,
  `hotel_id3` int NOT NULL,
  `room_type` enum('AC','NON AC') NOT NULL,
  `bookdt` datetime NOT NULL,
  `username` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `persons` int NOT NULL DEFAULT '1',
  `rooms` int NOT NULL DEFAULT '1',
  `price_per_person` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`book_id`),
  KEY `tour_id` (`tour_id`),
  KEY `hotel_id1` (`hotel_id1`),
  KEY `hotel_id2` (`hotel_id2`),
  KEY `hotel_id3` (`hotel_id3`),
  KEY `username` (`username`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`hotel_id1`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`hotel_id2`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bookings_ibfk_4` FOREIGN KEY (`hotel_id3`) REFERENCES `hotels` (`hotel_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bookings_ibfk_5` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=996752 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (845880,102,4,5,6,'AC','2026-11-26 00:00:00','kabeer01','2026-11-11 18:22:39',2,1,55000.00,110000.00),(996749,101,1,2,3,'NON AC','2026-11-26 00:00:00','kabeer01','2026-11-12 02:40:42',6,2,20000.00,120000.00);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `hotel_id` int NOT NULL,
  `hotel_name` varchar(120) NOT NULL,
  `tplace` varchar(100) NOT NULL,
  PRIMARY KEY (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,'Grand Srinagar Hotel','Srinagar'),(2,'Mountain View Hotel','Gulmarg'),(3,'Valley Resort','Pahalgam'),(4,'The Savoy','Tower of London'),(5,'Copthorne Tara Hotel','Buckingham Palace'),(6,'Ibis London City','British Museum'),(7,'Taj Exotica Resort','Panaji'),(8,'Lemon Tree Amarante','Calangute'),(9,'Zostel Goa','Baga'),(10,'The Himalayan','Kasol'),(11,'Snow Valley Resorts','Solang'),(12,'Sterling Manali','Manali'),(13,'New York Grand Hotel','New York'),(14,'Washington Plaza Hotel','Washington D.C'),(15,'Boston Central Hotel','Boston');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_hotel_link`
--

DROP TABLE IF EXISTS `tour_hotel_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_hotel_link` (
  `tour_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `place_no` tinyint NOT NULL,
  PRIMARY KEY (`tour_id`,`hotel_id`,`place_no`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `tour_hotel_link_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tour_hotel_link_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_hotel_link`
--

LOCK TABLES `tour_hotel_link` WRITE;
/*!40000 ALTER TABLE `tour_hotel_link` DISABLE KEYS */;
INSERT INTO `tour_hotel_link` VALUES (101,1,1),(101,2,2),(101,3,3),(102,4,1),(102,5,2),(102,6,3),(103,7,1),(103,8,2),(103,9,3),(104,10,1),(104,11,2),(104,12,3),(105,13,1),(105,14,2),(105,15,3);
/*!40000 ALTER TABLE `tour_hotel_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tours`
--

DROP TABLE IF EXISTS `tours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tours` (
  `tour_id` int NOT NULL,
  `tour_nm` varchar(100) NOT NULL,
  `tplace1` varchar(100) NOT NULL,
  `tplace2` varchar(100) DEFAULT NULL,
  `tplace3` varchar(100) DEFAULT NULL,
  `startdt` date NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`tour_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tours`
--

LOCK TABLES `tours` WRITE;
/*!40000 ALTER TABLE `tours` DISABLE KEYS */;
INSERT INTO `tours` VALUES (101,'Kashmir Tour','Srinagar','Gulmarg','Pahalgam','2026-12-31',20000.00),(102,'Royal London Explorer','Tower of London','Buckingham Palace','British Museum','2026-10-11',55000.00),(103,'Goa Tour','Panaji','Calangute','Baga','2026-10-11',12000.00),(104,'Manali Tour','Manali','Solang','Kasol','2026-12-05',15000.00),(105,'USA East Coast Explorer','New York','Washington D.C.','Boston','2025-12-10',149999.00);
/*!40000 ALTER TABLE `tours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `role` enum('ADMIN','CLIENT') NOT NULL DEFAULT 'CLIENT',
  PRIMARY KEY (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','hello.123','ADMIN','admin123@gmail.com','5623415263','ADMIN'),('kabeer01','12345','Kabeer','kabeer01@gmail.com','9876543210','CLIENT'),('testuser','test123','Test User','test@example.com','9876543210','CLIENT'),('Vivek','Sharma@123','Vivek Sharma','vivekasharma0931@gmail.com','7006356523','CLIENT'),('vivek01','test123','Test User','test01@xyz.com','9999999999','CLIENT');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12 12:48:04
