-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: loansystem
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB

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
-- Table structure for table `collectionagent`
--

DROP TABLE IF EXISTS `collectionagent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collectionagent` (
  `AgentID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AgentName` varchar(30) NOT NULL,
  `AgentPhone` varchar(10) NOT NULL,
  `AgentEmail` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`AgentID`),
  KEY `idx_agent_name` (`AgentName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collectionagent`
--

LOCK TABLES `collectionagent` WRITE;
/*!40000 ALTER TABLE `collectionagent` DISABLE KEYS */;
INSERT INTO `collectionagent` VALUES (1,'Deanna','7521200112','Deanna@loan.com\r'),(2,'Louann','7901023456','Louann@loan.com\r'),(3,'Joshua','7142319023','Joshua@loan.com\r'),(4,'Debbie','7903111221','Debbie@loan.com'),(5,'Jonathan','7633122110','Jonathan@loan.com');
/*!40000 ALTER TABLE `collectionagent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CustID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustFname` varchar(20) NOT NULL,
  `CustLname` varchar(20) NOT NULL,
  `CustPhone` varchar(10) NOT NULL,
  `CustAddress` varchar(500) NOT NULL,
  PRIMARY KEY (`CustID`),
  KEY `idx_customer_name` (`CustFname`,`CustLname`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Albert','Rice','7901079010','2890 Smith Street North Framingham'),(2,'Ed','Walters','7632124112','778 University Street Vashon'),(3,'Naomi','Roberts','7472884331','402 Spring Haven Trail Lake Mohawk'),(4,'Tandy','Ortega','7801012345','3370 Vernon Street Palm Springs, CA'),(5,'Barbara','Dipalma','7185691020','2011 Kovar Road Worcester, MA 01610'),(6,'James','Smith','78911221','122-West Street, CA');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_names`
--

DROP TABLE IF EXISTS `customer_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_names` (
  `CustName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_names`
--

LOCK TABLES `customer_names` WRITE;
/*!40000 ALTER TABLE `customer_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `custview`
--

DROP TABLE IF EXISTS `custview`;
/*!50001 DROP VIEW IF EXISTS `custview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `custview` (
  `CustID` tinyint NOT NULL,
  `CustFname` tinyint NOT NULL,
  `CustLname` tinyint NOT NULL,
  `CustPhone` tinyint NOT NULL,
  `CustAddress` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan` (
  `LoanID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `LoanStartDate` date NOT NULL,
  `LoanEndDate` date NOT NULL,
  `InterestRate` float NOT NULL,
  `LoanAmount` float NOT NULL,
  `PaymentDue` float NOT NULL,
  `Duedate` date DEFAULT NULL,
  `PayFrequency` int(11) DEFAULT NULL,
  `CustID` int(10) unsigned NOT NULL,
  `AgentID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`LoanID`),
  KEY `CustID` (`CustID`),
  KEY `AgentID` (`AgentID`),
  KEY `idx_due_date` (`Duedate`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`CustID`) REFERENCES `customer` (`CustID`) ON DELETE CASCADE,
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`AgentID`) REFERENCES `collectionagent` (`AgentID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,'2015-06-23','2022-07-23',8.2,126789,1290,'2021-09-01',2,1,2),(2,'2018-05-12','2025-06-12',7.6,145673,1800,'2021-10-09',1,2,3),(3,'2017-09-10','2027-10-10',10.29,156781,1420,'2021-06-10',1,3,2),(4,'2016-06-23','2026-07-23',12.2,129000,7500,'2021-11-11',1,4,5),(5,'2019-10-12','2030-10-12',9.6,148759,4500,'2021-12-01',2,5,3);
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `PaymentID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `LoanID` int(10) unsigned NOT NULL,
  `typeID` int(10) unsigned NOT NULL,
  `PaymentDate` date NOT NULL,
  `AmountPaid` float NOT NULL,
  `Remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `typeID` (`typeID`),
  KEY `LoanID` (`LoanID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`typeID`) REFERENCES `paymenttype` (`typeID`) ON DELETE CASCADE,
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`LoanID`) REFERENCES `loan` (`LoanID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,2,'2021-10-22',1200,'partially pending\r'),(2,2,1,'2021-07-10',1600,'paid\r'),(3,3,3,'2021-10-11',1500,'paid\r'),(5,5,3,'2021-12-10',2500,'Partially paid'),(6,5,1,'2022-01-01',1400,'Not paid'),(7,4,1,'2021-09-10',4000,'Paid');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_payment_record BEFORE INSERT ON payment FOR EACH ROW BEGIN
IF NEW.PaymentDate>(SELECT CURRENT_DATE) THEN SET NEW.Remark='Not paid';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `paymentdateview`
--

DROP TABLE IF EXISTS `paymentdateview`;
/*!50001 DROP VIEW IF EXISTS `paymentdateview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `paymentdateview` (
  `AMOUNT_PAID` tinyint NOT NULL,
  `PAYMENT_DATE` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `paymenttype`
--

DROP TABLE IF EXISTS `paymenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymenttype` (
  `typeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PaymentType` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenttype`
--

LOCK TABLES `paymenttype` WRITE;
/*!40000 ALTER TABLE `paymenttype` DISABLE KEYS */;
INSERT INTO `paymenttype` VALUES (1,'Cash\r'),(2,'Online\r'),(3,'ECS\r');
/*!40000 ALTER TABLE `paymenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `custview`
--

/*!50001 DROP TABLE IF EXISTS `custview`*/;
/*!50001 DROP VIEW IF EXISTS `custview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `custview` AS (select `customer`.`CustID` AS `CustID`,`customer`.`CustFname` AS `CustFname`,`customer`.`CustLname` AS `CustLname`,`customer`.`CustPhone` AS `CustPhone`,`customer`.`CustAddress` AS `CustAddress` from `customer` order by `customer`.`CustFname`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `paymentdateview`
--

/*!50001 DROP TABLE IF EXISTS `paymentdateview`*/;
/*!50001 DROP VIEW IF EXISTS `paymentdateview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `paymentdateview` AS (select `payment`.`AmountPaid` AS `AMOUNT_PAID`,`payment`.`PaymentDate` AS `PAYMENT_DATE` from `payment` where `payment`.`PaymentDate` between '2021-10-01' and '2021-12-15') */;
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

-- Dump completed on 2021-12-15 14:58:07
