-- MySQL dump 10.16  Distrib 10.1.21-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.1.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mytestdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mytestdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `mytestdb`;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `code` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturers` (
  `CODE` int(3) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet` (
  `name` varchar(20) DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  `species` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `death` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` VALUES ('Fluffy','Harold','cat','f','1993-02-04','0000-00-00'),('Claws','Gwen','cat','m','1994-03-17','0000-00-00'),('Buffy','Harold','dog','f','1989-05-13','0000-00-00'),('Fang','Benny','dog','m','1990-08-27','0000-00-00'),('Bowser','Diane','dog','m','1979-08-31','1995-07-29'),('Chirpy','Gwen','bird','f','1998-09-11','0000-00-00'),('Whistler','Gwen','bird','','1997-12-09','0000-00-00'),('Slim','Benny','snake','m','1996-04-29','0000-00-00'),('Puffball','Diane','hamster','f','1999-03-30',NULL),('fo abddfodzxfo','herold','cat','f','0000-00-00','0000-00-00'),('fofo','herold','cat','f','0000-00-00','0000-00-00');
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `Code` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Price` decimal(10,0) NOT NULL,
  `Manufacturer` int(11) DEFAULT NULL,
  PRIMARY KEY (`Code`),
  KEY `Manufacturer` (`Manufacturer`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`Manufacturer`) REFERENCES `manufacturers` (`CODE`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2),(11,'USB Driver',40,NULL),(12,'USB Driver',54,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `STUDENT_ID` int(10) NOT NULL AUTO_INCREMENT,
  `FIRSTNAME` varchar(50) NOT NULL,
  `LASTNAME` varchar(50) NOT NULL,
  `GENDER` varchar(50) NOT NULL,
  `DOB` date DEFAULT NULL,
  `CITY` varchar(30) NOT NULL,
  `COUNTRY` varchar(50) NOT NULL,
  `AGE` smallint(3) NOT NULL,
  `COURSE` varchar(50) DEFAULT 'MADT',
  `STATUS` char(1) DEFAULT 'A',
  `DOJ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MARKS` bigint(5) DEFAULT NULL,
  `YEARIFPASSING` year(4) DEFAULT NULL,
  `ACTIVE` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`STUDENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'KALPANA','RAMANAN','FEMALE','1990-05-17','TORONTO','CANADA',28,'MADT','A','2017-09-07 22:11:54',97,2017,1),(2,'SAI','PRAVEEN','MALE','1993-07-06','PETEBOROUGH','CANADA',24,'BIG DATA','A','2017-09-07 22:15:37',98,2017,1),(3,'MANOCH','RICHARD','MALE','1988-03-24','BRAMPTON','CANADA',28,'MIOS','A','2017-09-09 15:09:37',40,2015,1),(4,'SARANYA','SEKAR','FEMALE','1992-07-18','TORONTO','CANADA',28,'MAPT','A','2017-09-26 00:12:37',75,2016,1),(5,'NIMISHA','RAKASH','FEMALE','1991-02-08','BRAMPTON','CANADA',28,'CPMT','A','2017-09-05 22:15:37',67,2016,1);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t1`
--

DROP TABLE IF EXISTS `t1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t1` (
  `tcode` int(5) NOT NULL AUTO_INCREMENT,
  `tname` varchar(50) NOT NULL,
  PRIMARY KEY (`tcode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t1`
--

LOCK TABLES `t1` WRITE;
/*!40000 ALTER TABLE `t1` DISABLE KEYS */;
INSERT INTO `t1` VALUES (1,'Hard drive');
/*!40000 ALTER TABLE `t1` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-13 19:29:43
