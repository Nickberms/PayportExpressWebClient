-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: payport_express_db
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

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `birthdate` date NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (100,'Admin','Kein','2002-10-22','Male','Musuan, Maramag, Bukidnon','09999999999','kein@gmail.com','123','2023-11-25 16:44:02','2023-11-25 16:44:02'),(101,'Admin','Bebong','1999-12-10','Male','Musuan, Maramag, Bukidnon','09888888888','bebong@gmail.com','123','2023-11-25 16:47:00','2023-11-25 16:47:00');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `operation_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (126,'Active','Branch One','Branch, One, Address','2023-12-05 17:27:33','2023-12-05 17:27:33'),(127,'Active','Branch Two','Branch, Two, Address','2023-12-05 17:27:33','2023-12-05 17:27:33'),(128,'Active','Branch Three','Branch, Three, Address','2023-12-05 17:27:33','2023-12-05 17:27:33'),(129,'Active','Branch Four','Branch, Four, Address','2023-12-05 17:27:33','2023-12-05 17:27:33'),(130,'Active','Branch Five','Branch, Five, Address','2023-12-05 17:27:33','2023-12-05 17:27:33'),(131,'Active','Branch Six','Branch, Six, Address','2023-12-05 17:27:33','2023-12-05 17:27:33'),(132,'Inactive','Branch Seven','Branch, Seven, Address','2023-12-05 17:27:33','2023-12-05 18:32:36'),(133,'Inactive','Branch Eight','Branch, Eight, Address','2023-12-05 17:27:33','2023-12-05 18:32:40'),(134,'Inactive','Branch Nine','Branch, Nine, Address','2023-12-05 17:27:33','2023-12-05 18:32:45'),(135,'Inactive','Branch Ten','Branch, Ten, Address','2023-12-05 17:27:33','2023-12-05 18:32:49');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `branch_stationed` int NOT NULL,
  `working_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `birthdate` date NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`employee_id`) USING BTREE,
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `branch_id_idx` (`branch_stationed`),
  CONSTRAINT `branch_stationed` FOREIGN KEY (`branch_stationed`) REFERENCES `branches` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1054 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1034,126,'Active','Employee','One','1999-12-01','Male','Employee, One, Address','09111111111','one@gmail.com','123','2023-12-05 17:54:01','2023-12-05 17:54:01'),(1035,127,'Active','Employee','Two','1999-12-02','Female','Employee, Two, Address','09111111112','two@gmail.com','123','2023-12-05 17:54:01','2023-12-05 17:54:01'),(1036,128,'Active','Employee','Three','1999-12-03','Male','Employee, Three, Address','09111111113','three@gmail.com','123','2023-12-05 17:54:01','2023-12-05 17:54:01'),(1037,129,'Active','Employee','Four','1999-12-04','Female','Employee, Four, Address','09111111114','four@gmail.com','123','2023-12-05 17:54:01','2023-12-05 17:54:01'),(1038,130,'On Leave','Employee','Five','1999-12-05','Male','Employee, Five, Address','09111111115','five@gmail.com','123','2023-12-05 17:54:01','2023-12-05 18:27:37'),(1039,131,'On Leave','Employee','Six','1999-12-06','Female','Employee, Six, Address','09111111116','six@gmail.com','123','2023-12-05 17:54:01','2023-12-05 18:27:47'),(1040,132,'On Leave','Employee','Seven','1999-12-07','Male','Employee, Seven, Address','09111111117','seven@gmail.com','123','2023-12-05 17:54:01','2023-12-05 18:27:59'),(1041,133,'Fired','Employee','Eight','1999-12-08','Female','Employee, Eight, Address','09111111118','eight@gmail.com','123','2023-12-05 17:54:01','2023-12-05 18:28:08'),(1042,134,'Fired','Employee','Nine','1999-12-09','Male','Employee, Nine, Address','09111111119','nine@gmail.com','123','2023-12-05 17:54:01','2023-12-05 18:28:13'),(1043,135,'Fired','Employee','Ten','1999-12-10','Female','Employee, Ten, Address','09111111110','ten@gmail.com','123','2023-12-05 17:54:01','2023-12-05 18:28:17');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `control_number` int NOT NULL AUTO_INCREMENT,
  `fee_status` varchar(255) NOT NULL,
  `service_fee` float NOT NULL,
  `sender_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender_contact_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `receiver_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `receiver_contact_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` float NOT NULL,
  `sender_employee` int DEFAULT NULL,
  `receiver_employee` int DEFAULT NULL,
  `branch_sent` int DEFAULT NULL,
  `branch_withdrawn` int DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `date_withdrawn` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`control_number`),
  UNIQUE KEY `control_number` (`control_number`),
  KEY `sender_employee_idx` (`sender_employee`),
  KEY `receiver_employee_idx` (`receiver_employee`),
  KEY `branch_sent_idx` (`branch_sent`),
  KEY `branch_withdrawn_idx` (`branch_withdrawn`),
  CONSTRAINT `branch_sent` FOREIGN KEY (`branch_sent`) REFERENCES `branches` (`branch_id`),
  CONSTRAINT `branch_withdrawn` FOREIGN KEY (`branch_withdrawn`) REFERENCES `branches` (`branch_id`),
  CONSTRAINT `receiver_employee` FOREIGN KEY (`receiver_employee`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `sender_employee` FOREIGN KEY (`sender_employee`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100068 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (100048,'Unpaid',20,'Sender One','09101010101','Receiver One','09020202020',1000,NULL,NULL,NULL,NULL,NULL,NULL,'2023-12-05 18:06:12','2023-12-05 18:06:12'),(100049,'Paid',20,'Sender Two','09101010102','Receiver Two','09020202021',1000,1034,1035,126,127,'2023-12-05 18:23:35','2023-12-05 18:24:17','2023-12-05 18:06:12','2023-12-05 18:24:17'),(100050,'Unpaid',20,'Sender Three','09101010103','Receiver Three','09020202022',1000,NULL,NULL,NULL,NULL,NULL,NULL,'2023-12-05 18:06:12','2023-12-05 18:06:12'),(100051,'Paid',20,'Sender Four','09101010104','Receiver Four','09020202023',1000,1034,1035,126,127,'2023-12-05 18:23:39','2023-12-05 18:24:20','2023-12-05 18:06:12','2023-12-05 18:24:20'),(100052,'Unpaid',20,'Sender Five','09101010105','Receiver Five','09020202024',1000,NULL,NULL,NULL,NULL,NULL,NULL,'2023-12-05 18:06:12','2023-12-05 18:06:12'),(100053,'Paid',20,'Sender Six','09101010106','Receiver Six','09020202025',1000,1034,1035,126,127,'2023-12-05 18:23:42','2023-12-05 18:24:22','2023-12-05 18:06:12','2023-12-05 18:24:22'),(100054,'Unpaid',20,'Sender Seven','09101010107','Receiver Seven','09020202026',1000,NULL,NULL,NULL,NULL,NULL,NULL,'2023-12-05 18:06:12','2023-12-05 18:06:12'),(100055,'Paid',20,'Sender Eight','09101010108','Receiver Eight','09020202027',1000,1034,1035,126,127,'2023-12-05 18:23:45','2023-12-05 18:24:25','2023-12-05 18:06:13','2023-12-05 18:24:25'),(100056,'Unpaid',20,'Sender Nine','09101010109','Receiver Nine','09020202028',1000,NULL,NULL,NULL,NULL,NULL,NULL,'2023-12-05 18:06:13','2023-12-05 18:06:13'),(100057,'Paid',20,'Sender Ten','09101010110','Receiver Ten','09020202029',1000,1034,1035,126,127,'2023-12-05 18:23:47','2023-12-05 18:24:27','2023-12-05 18:06:13','2023-12-05 18:24:27');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-05 20:20:41
