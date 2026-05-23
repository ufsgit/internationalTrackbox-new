-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: internationaldb
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `application_adm_interest`
--

DROP TABLE IF EXISTS `application_adm_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_adm_interest` (
  `interest_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`interest_id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_adm_interest_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_adm_interest`
--

LOCK TABLES `application_adm_interest` WRITE;
/*!40000 ALTER TABLE `application_adm_interest` DISABLE KEYS */;
INSERT INTO `application_adm_interest` VALUES (16,98,'adm test','2026-04-24','2026-05-08 08:16:04');
/*!40000 ALTER TABLE `application_adm_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_admission_tests`
--

DROP TABLE IF EXISTS `application_admission_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_admission_tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `test_type` varchar(50) DEFAULT NULL,
  `quant_score` varchar(10) DEFAULT NULL,
  `verbal_score` varchar(10) DEFAULT NULL,
  `data_insights_score` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_admission_tests_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_admission_tests`
--

LOCK TABLES `application_admission_tests` WRITE;
/*!40000 ALTER TABLE `application_admission_tests` DISABLE KEYS */;
INSERT INTO `application_admission_tests` VALUES (18,9,'SAT','3','3','3'),(57,80,'GRE','2','2','2'),(64,16,'GMAT','2','2','2'),(65,16,'GRE','22','22','22'),(68,87,'GMAT','2','2','2'),(69,87,'GRE','22','22','22'),(72,88,'GRE','1','1','1'),(73,91,'GMAT','23','23','2'),(74,91,'GRE','32','22','23'),(79,92,'GMAT','3','4','5'),(80,97,'GRE','4','56','6'),(159,209,'GMAT','','','');
/*!40000 ALTER TABLE `application_admission_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_children`
--

DROP TABLE IF EXISTS `application_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_children` (
  `child_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `age` int DEFAULT NULL,
  `is_accompanying` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`child_id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_children_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=472 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_children`
--

LOCK TABLES `application_children` WRITE;
/*!40000 ALTER TABLE `application_children` DISABLE KEYS */;
INSERT INTO `application_children` VALUES (75,6,NULL,1),(89,3,NULL,1),(151,8,12,1),(262,80,3,1),(263,80,2,0),(270,16,4,1),(271,16,2,0),(276,87,4,1),(277,87,2,0),(278,91,3,1),(279,91,1,0),(288,92,4,1),(289,92,2,0),(290,97,5,1),(291,97,2,0),(322,98,4,1),(323,98,2,0),(358,133,5,1),(359,133,3,0),(453,209,2,1),(454,209,1,1),(471,196,1,1);
/*!40000 ALTER TABLE `application_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_education`
--

DROP TABLE IF EXISTS `application_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `expected_completion` date DEFAULT NULL,
  `is_highest` tinyint(1) DEFAULT '0',
  `edu_type` varchar(20) DEFAULT 'highest',
  PRIMARY KEY (`id`),
  KEY `fk_app_edu` (`application_id`),
  CONSTRAINT `fk_app_edu` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=666 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_education`
--

LOCK TABLES `application_education` WRITE;
/*!40000 ALTER TABLE `application_education` DISABLE KEYS */;
INSERT INTO `application_education` VALUES (246,9,'Germany','Bachelor','Environmental Science','Not Completed','2025-10-01',1,'highest'),(247,9,'New Zealand','Master','Finance','Not Completed','2025-11-01',0,'other'),(248,9,'Malta','Graduate Diploma','Hospitality','Completed',NULL,0,'other'),(383,80,'Singapore','Master','Law','Completed',NULL,1,'highest'),(384,80,'Australia','Associate Degree','Architecture','Not Completed','2026-05-01',0,'country'),(385,80,'Australia','Associate Degree','Environmental Science','Completed',NULL,0,'country'),(386,80,'Singapore','PhD','Health & Medicine','Completed',NULL,0,'other'),(408,16,'UAE','Graduate Certificate','Finance','Not Completed','2022-10-01',1,'highest'),(409,16,'India','High School','Hospitality','Completed','2022-10-01',0,'highest'),(410,16,'Australia','Bachelor','Architecture','Not Completed','2023-12-01',0,'country'),(411,16,'Australia','Associate Degree','Agriculture','Completed',NULL,0,'country'),(412,16,'Canada1','Master','Information Technology','Not Completed','2023-12-01',0,'country'),(413,16,'Poland','Master','Information Technology','Not Completed','2022-10-01',0,'other'),(414,16,'Germany','Graduate Certificate','Hospitality','Completed',NULL,0,'other'),(421,87,'Australia','High School','Hospitality','Not Completed','2026-05-01',1,'highest'),(422,87,'Canada1','Graduate Certificate','Finance','Completed',NULL,0,'highest'),(423,87,'Germany','Graduate Diploma','Health & Medicine','Not Completed','2026-05-01',0,'country'),(424,87,'Germany','Graduate Diploma','Finance','Completed',NULL,0,'country'),(425,87,'France','High School','Finance','Not Completed','2026-05-01',0,'other'),(426,87,'Georgia','Graduate Diploma','Finance','Completed',NULL,0,'other'),(431,88,'Malta','Graduate Diploma','Health & Medicine','Completed',NULL,1,'highest'),(432,88,'Latvia','Diploma','Hospitality','Completed',NULL,0,'other'),(433,91,'Malta','Master','Environmental Science','Not Completed','2026-05-01',1,'highest'),(434,91,'India','Diploma','Hospitality','Completed',NULL,0,'highest'),(435,91,'Poland','High School','Finance','Not Completed','2026-05-01',0,'other'),(436,91,'New Zealand','Graduate Diploma','Engineering','Completed',NULL,0,'other'),(445,92,'Malta','Graduate Diploma','Environmental Science','Completed',NULL,1,'highest'),(446,92,'UAE','Master','Information Technology','Completed',NULL,0,'other'),(447,97,'UAE','High School','Environmental Science','Not Completed','2026-05-01',1,'highest'),(448,97,'Ireland','Graduate Certificate','Engineering','Not Completed','2026-05-01',0,'other'),(479,98,'Australia','Advanced Diploma','Dentistry','Not Completed','2025-04-01',0,'highest'),(480,98,'Canada1','Certificate III','Built Environment','Completed',NULL,0,'highest'),(519,133,'France','Advanced Diploma','Agriculture','Not Completed','2026-05-01',0,'highest'),(520,133,'Georgia','Associate Degree','Accounting','Completed',NULL,0,'highest'),(631,209,'','','','Completed',NULL,0,'highest'),(664,196,'Canada1','Associate Degree','Architecture','Not Completed','2025-04-01',0,'highest'),(665,196,'France','Associate Degree','Agriculture','Completed',NULL,0,'highest');
/*!40000 ALTER TABLE `application_education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_lang_interest`
--

DROP TABLE IF EXISTS `application_lang_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_lang_interest` (
  `interest_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `is_spouse` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`interest_id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_lang_interest_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_lang_interest`
--

LOCK TABLES `application_lang_interest` WRITE;
/*!40000 ALTER TABLE `application_lang_interest` DISABLE KEYS */;
INSERT INTO `application_lang_interest` VALUES (31,98,'a language test','2026-04-24',0,'2026-05-08 08:16:04'),(32,98,'a language test','2026-04-24',1,'2026-05-08 08:16:04');
/*!40000 ALTER TABLE `application_lang_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_language_tests`
--

DROP TABLE IF EXISTS `application_language_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_language_tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `test_type` varchar(50) DEFAULT NULL,
  `writing_score` varchar(10) DEFAULT NULL,
  `listening_score` varchar(10) DEFAULT NULL,
  `speaking_score` varchar(10) DEFAULT NULL,
  `reading_score` varchar(10) DEFAULT NULL,
  `is_spouse` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_language_tests_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_language_tests`
--

LOCK TABLES `application_language_tests` WRITE;
/*!40000 ALTER TABLE `application_language_tests` DISABLE KEYS */;
INSERT INTO `application_language_tests` VALUES (18,9,'IELTS','3','3','3','3',0),(92,80,'PTE','2','2','2','2',0),(93,80,'IELTS','2','2','2','2',1),(106,16,'PTE','1','1','1','1',0),(107,16,'IELTS','11','11','11','11',0),(108,16,'TOEFL','2','2','2','2',1),(109,16,'IELTS','2','2','2','2',1),(114,87,'IELTS','1','1','1','1',0),(115,87,'PTE','11','11','11','11',0),(116,87,'IELTS','1','1','1','1',1),(117,87,'PTE','11','11','11','11',1),(120,88,'TOEFL','1','1','1','1',0),(121,91,'PTE','2','2','2','2',0),(122,91,'IELTS','2','2','23','3',0),(123,91,'IELTS','2','3','3','3',1),(124,91,'TOEFL','2','1','2','3',1),(133,92,'PTE','4','4','5','6',0),(134,92,'IELTS','3','4','5','6',1),(135,97,'PTE','4','5','6','4',0),(136,97,'IELTS','4','5','6','4',1),(303,209,'DET','','','','',0),(304,209,'IELTS','','','','',1);
/*!40000 ALTER TABLE `application_language_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_relatives`
--

DROP TABLE IF EXISTS `application_relatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_relatives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `relationship` varchar(100) DEFAULT NULL,
  `related_to` enum('Applicant','Spouse') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_relatives`
--

LOCK TABLES `application_relatives` WRITE;
/*!40000 ALTER TABLE `application_relatives` DISABLE KEYS */;
INSERT INTO `application_relatives` VALUES (1,14,'Australia','Cousin','Spouse','2026-04-29 06:55:27'),(19,78,'Australia','Parent','Spouse','2026-05-02 07:27:10'),(20,80,'Australia','Parent','Spouse','2026-05-02 07:49:42'),(24,16,'Australia','Uncle/Aunty','Spouse','2026-05-02 08:56:29'),(25,85,'Germany','Sibling','Applicant','2026-05-02 09:15:19'),(26,86,'Germany','Sibling','Applicant','2026-05-02 09:20:53'),(27,87,'Germany','Uncle/Aunty','Spouse','2026-05-02 09:46:13'),(28,91,'Germany','Sibling','Spouse','2026-05-02 10:36:20'),(33,92,'Canada1','Sibling','Spouse','2026-05-05 07:39:03'),(34,97,'Canada1','Uncle/Aunty','Spouse','2026-05-05 08:06:45'),(65,98,'Canada1','Uncle/Aunty','Applicant','2026-05-08 08:16:04'),(66,98,'Australia','Cousin','Spouse','2026-05-08 08:16:04'),(67,114,'Australia','Sibling','Applicant','2026-05-08 08:28:08'),(68,114,'Canada1','Cousin','Spouse','2026-05-08 08:28:08'),(70,115,'Australia','Uncle/Aunty','Spouse','2026-05-11 06:35:25'),(86,117,'Canada1','Sibling','Spouse','2026-05-19 10:36:19'),(87,133,'Australia','Sibling','Spouse','2026-05-19 12:03:25'),(88,134,'Australia','Uncle/Aunty','Spouse','2026-05-19 12:27:21'),(91,135,'Australia','Sibling','Spouse','2026-05-19 12:31:31'),(100,141,'Australia','Sibling','Spouse','2026-05-20 07:26:44'),(101,141,'Canada1','Uncle/Aunty','Applicant','2026-05-20 07:26:44'),(108,139,'Australia','Uncle/Aunty','Spouse','2026-05-20 10:15:01'),(109,139,'Australia','Cousin','Applicant','2026-05-20 10:15:01'),(110,148,'Australia','Uncle/Aunty','Spouse','2026-05-20 11:58:09'),(111,148,'France','Friend','Applicant','2026-05-20 11:58:09'),(112,149,'Australia','Sibling','Spouse','2026-05-20 12:30:03'),(113,149,'France','Uncle/Aunty','Applicant','2026-05-20 12:30:03'),(130,150,'Australia','Sibling','Spouse','2026-05-22 06:45:39'),(131,150,'Canada1','Friend','Applicant','2026-05-22 06:45:39'),(150,159,'Australia','Sibling','Spouse','2026-05-23 04:12:10'),(151,159,'Canada1','Friend','Applicant','2026-05-23 04:12:10'),(154,209,'Canada1','Uncle/Aunty','Spouse','2026-05-23 06:46:50'),(187,196,'Australia','Uncle/Aunty','Spouse','2026-05-23 07:39:16'),(188,196,'France','Friend','Applicant','2026-05-23 07:39:16');
/*!40000 ALTER TABLE `application_relatives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_skill`
--

DROP TABLE IF EXISTS `application_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_skill` (
  `skill_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `authority` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `sub_status` varchar(100) DEFAULT NULL,
  `is_interest` tinyint(1) DEFAULT '0',
  `remarks` text,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`skill_id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_skill_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_skill`
--

LOCK TABLES `application_skill` WRITE;
/*!40000 ALTER TABLE `application_skill` DISABLE KEYS */;
INSERT INTO `application_skill` VALUES (22,98,'Germany','Engineers Australia','Incompleted','In Progress',1,NULL,'2026-05-08 13:46:04'),(23,98,'New Zealand','Engineers Australia','Completed','Documents Pending',1,NULL,'2026-05-08 13:46:04'),(93,209,'France','','','',0,NULL,NULL);
/*!40000 ALTER TABLE `application_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_spouse_education`
--

DROP TABLE IF EXISTS `application_spouse_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_spouse_education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `expected_completion` date DEFAULT NULL,
  `edu_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_spouse_education`
--

LOCK TABLES `application_spouse_education` WRITE;
/*!40000 ALTER TABLE `application_spouse_education` DISABLE KEYS */;
INSERT INTO `application_spouse_education` VALUES (1,14,'Poland','Certificate III','Hospitality','Completed',NULL,NULL,'2026-04-29 06:55:27'),(140,78,'Australia','Associate Degree','Finance','Not Completed','2026-04-01','country','2026-05-02 07:27:10'),(141,78,'Australia','Advanced Diploma','Health & Medicine','Completed',NULL,'country','2026-05-02 07:27:10'),(142,78,'France','Associate Degree','Architecture','Not Completed','2026-04-01','highest','2026-05-02 07:27:10'),(143,78,'United Kingdom','Associate Degree','Environmental Science','Completed',NULL,'highest','2026-05-02 07:27:10'),(144,78,'Canada1','Associate Degree','Agriculture','Not Completed','2026-04-01','other','2026-05-02 07:27:10'),(145,80,'Australia','Bachelor','Architecture','Not Completed','2026-05-01','country','2026-05-02 07:49:42'),(146,80,'Australia','Associate Degree','Environmental Science','Completed',NULL,'country','2026-05-02 07:49:42'),(147,80,'Singapore','PhD','Hospitality','Completed',NULL,'highest','2026-05-02 07:49:42'),(148,80,'Poland','PG Diploma','Hospitality','Completed',NULL,'other','2026-05-02 07:49:42'),(170,16,'Australia','Associate Degree','Architecture','Not Completed','2024-06-01','country','2026-05-02 08:56:29'),(171,16,'Australia','Advanced Diploma','Agriculture','Completed',NULL,'country','2026-05-02 08:56:29'),(172,16,'Canada1','Advanced Diploma','Information Technology','Not Completed','2024-06-01','country','2026-05-02 08:56:29'),(173,16,'UAE','PG Diploma','Information Technology','Not Completed','2024-06-01','highest','2026-05-02 08:56:29'),(174,16,'New Zealand','High School','Information Technology','Completed',NULL,'highest','2026-05-02 08:56:29'),(175,16,'Latvia','Bachelor','Engineering','Not Completed','2024-06-01','other','2026-05-02 08:56:29'),(176,16,'UAE','Graduate Diploma','Dentistry','Completed',NULL,'other','2026-05-02 08:56:29'),(177,85,'Germany','Associate Degree','Architecture','Completed',NULL,'country','2026-05-02 09:15:19'),(178,85,'Poland','Associate Degree','Health & Medicine','Completed',NULL,'highest','2026-05-02 09:15:19'),(179,85,'New Zealand','High School','Health & Medicine','Completed',NULL,'other','2026-05-02 09:15:19'),(180,86,'Germany','Master','Information Technology','Completed',NULL,'country','2026-05-02 09:20:53'),(181,86,'Singapore','Master','Hospitality','Completed',NULL,'highest','2026-05-02 09:20:53'),(182,86,'New Zealand','High School','Hospitality','Completed',NULL,'other','2026-05-02 09:20:53'),(183,87,'Germany','Advanced Diploma','Built Environment','Not Completed','2026-05-01','country','2026-05-02 09:46:13'),(184,87,'Germany','Associate Degree','Arts & Humanities','Completed',NULL,'country','2026-05-02 09:46:13'),(185,87,'Ireland','Graduate Certificate','Health & Medicine','Not Completed','2026-05-01','highest','2026-05-02 09:46:13'),(186,87,'Latvia','Diploma','Finance','Completed',NULL,'highest','2026-05-02 09:46:13'),(187,87,'Malta','PG Diploma','Health & Medicine','Not Completed','2026-05-01','other','2026-05-02 09:46:13'),(188,87,'New Zealand','High School','Finance','Completed',NULL,'other','2026-05-02 09:46:13'),(189,91,'New Zealand','High School','Hospitality','Not Completed','2026-05-01','highest','2026-05-02 10:36:20'),(190,91,'Poland','Graduate Certificate','Environmental Science','Completed',NULL,'highest','2026-05-02 10:36:20'),(191,91,'New Zealand','Graduate Certificate','Finance','Not Completed','2026-05-01','other','2026-05-02 10:36:20'),(192,91,'Latvia','Diploma','Health & Medicine','Completed',NULL,'other','2026-05-02 10:36:20'),(201,92,'Poland','High School','Hospitality','Completed',NULL,'highest','2026-05-05 07:39:03'),(202,92,'Poland','Graduate Diploma','Finance','Completed',NULL,'other','2026-05-05 07:39:03'),(203,97,'Poland','Master','Health & Medicine','Not Completed','2026-05-01','highest','2026-05-05 08:06:45'),(204,97,'Latvia','High School','Environmental Science','Not Completed','2026-05-01','other','2026-05-05 08:06:45'),(235,98,'India','Certificate IV','Engineering','Not Completed','2025-04-01','highest','2026-05-08 08:16:04'),(236,98,'Ireland','High School','Finance','Not Completed','2025-11-01','highest','2026-05-08 08:16:04'),(237,114,'Canada1','Bachelor','Agriculture','Not Completed','2026-05-01','highest','2026-05-08 08:28:08'),(238,114,'Georgia','Bachelor','Architecture','Completed',NULL,'highest','2026-05-08 08:28:08'),(241,115,'Germany','Certificate III','Arts & Humanities','Not Completed','2026-04-01','highest','2026-05-11 06:35:25'),(242,115,'Georgia','Certificate III','Arts & Humanities','Completed',NULL,'highest','2026-05-11 06:35:25'),(273,117,'Malta','Advanced Diploma','Accounting','Not Completed','2025-03-01','highest','2026-05-19 10:36:19'),(274,117,'New Zealand','Associate Degree','Architecture','Completed',NULL,'highest','2026-05-19 10:36:19'),(275,133,'Ireland','Bachelor','Architecture','Not Completed','2026-05-01','highest','2026-05-19 12:03:25'),(276,133,'Latvia','Certificate III','Arts & Humanities','Completed',NULL,'highest','2026-05-19 12:03:25'),(277,134,'Latvia','Certificate III','Architecture','Not Completed','2026-05-01','highest','2026-05-19 12:27:21'),(278,134,'Malta','Certificate IV','Arts & Humanities','Completed',NULL,'highest','2026-05-19 12:27:21'),(284,135,'Georgia','Bachelor','Arts & Humanities','Not Completed','2026-03-01','highest','2026-05-19 12:31:31'),(285,135,'France','Certificate III','Arts & Humanities','Not Completed','2026-05-01','highest','2026-05-19 12:31:31'),(286,135,'Georgia','Bachelor','Agriculture','Completed','2026-04-01','highest','2026-05-19 12:31:31'),(287,138,'Canada1','Associate Degree','Architecture','Not Completed','2026-05-01','highest','2026-05-19 12:32:47'),(288,138,'France','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-19 12:32:47'),(297,141,'Canada1','Associate Degree','Agriculture','Not Completed','2026-04-01','highest','2026-05-20 07:26:44'),(298,141,'UAE','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-20 07:26:44'),(305,139,'Canada1','Bachelor','Agriculture','Not Completed','2025-11-01','highest','2026-05-20 10:15:01'),(306,139,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 10:15:01'),(307,148,'Canada1','Associate Degree','Agriculture','Not Completed','2026-05-01','highest','2026-05-20 11:58:09'),(308,148,'Georgia','Certificate III','Arts & Humanities','Completed',NULL,'highest','2026-05-20 11:58:09'),(309,149,'India','Advanced Diploma','Accounting','Not Completed','2026-05-01','highest','2026-05-20 12:30:03'),(310,149,'Ireland','Certificate III','Architecture','Completed',NULL,'highest','2026-05-20 12:30:03'),(327,150,'Australia','Associate Degree','Agriculture','Not Completed','2025-10-01','highest','2026-05-22 06:45:39'),(328,150,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-22 06:45:39'),(347,159,'Australia','Associate Degree','Agriculture','Not Completed','2025-03-01','highest','2026-05-23 04:12:10'),(348,159,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-23 04:12:10'),(363,169,'','','','Completed',NULL,'highest','2026-05-23 05:50:32'),(364,184,'','','','Completed',NULL,'highest','2026-05-23 06:08:35'),(365,185,'','','','Completed',NULL,'highest','2026-05-23 06:09:26'),(368,186,'','','','Completed',NULL,'highest','2026-05-23 06:13:04'),(369,189,'','','','Completed',NULL,'highest','2026-05-23 06:19:49'),(372,190,'','','','Completed',NULL,'highest','2026-05-23 06:24:36'),(373,193,'','','','Completed',NULL,'highest','2026-05-23 06:25:55'),(375,194,'','','','Completed',NULL,'highest','2026-05-23 06:27:09'),(390,209,'France','','','Completed',NULL,'highest','2026-05-23 06:46:50'),(423,196,'Australia','Bachelor','Agriculture','Not Completed','2025-04-01','highest','2026-05-23 07:39:16'),(424,196,'France','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-23 07:39:16');
/*!40000 ALTER TABLE `application_spouse_education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_spouse_work`
--

DROP TABLE IF EXISTS `application_spouse_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_spouse_work` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `work_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_spouse_work`
--

LOCK TABLES `application_spouse_work` WRITE;
/*!40000 ALTER TABLE `application_spouse_work` DISABLE KEYS */;
INSERT INTO `application_spouse_work` VALUES (95,78,'Singapore','2',NULL,NULL,2,2,'other','2026-05-02 07:27:10'),(96,78,'Australia','w',NULL,NULL,2,2,'curr_country','2026-05-02 07:27:10'),(97,78,'Australia','es',NULL,NULL,2,2,'other_country','2026-05-02 07:27:10'),(98,80,'Singapore','2',NULL,NULL,2,2,'other','2026-05-02 07:49:42'),(99,80,'Australia','2',NULL,NULL,2,2,'curr_country','2026-05-02 07:49:42'),(100,80,'Australia','2',NULL,NULL,2,2,'other_country','2026-05-02 07:49:42'),(117,16,'Poland','e',NULL,NULL,2,2,'curr_other','2026-05-02 08:56:29'),(118,16,'Australia','a',NULL,NULL,1,1,'curr_country','2026-05-02 08:56:29'),(119,16,'Australia','b',NULL,NULL,2,2,'curr_country','2026-05-02 08:56:29'),(120,16,'Australia','c',NULL,NULL,3,3,'other_country','2026-05-02 08:56:29'),(121,16,'Canada1','d',NULL,NULL,4,4,'other_country','2026-05-02 08:56:29'),(122,85,'Singapore','c',NULL,NULL,3,3,'curr_other','2026-05-02 09:15:19'),(123,85,'Germany','a',NULL,NULL,2,2,'curr_country','2026-05-02 09:15:19'),(124,85,'Germany','b',NULL,NULL,2,2,'other_country','2026-05-02 09:15:19'),(125,86,'Singapore','c',NULL,NULL,3,3,'curr_other','2026-05-02 09:20:53'),(126,86,'Germany','a',NULL,NULL,2,2,'curr_country','2026-05-02 09:20:53'),(127,86,'Germany','b',NULL,NULL,2,2,'other_country','2026-05-02 09:20:53'),(128,87,'Poland','c',NULL,NULL,3,3,'curr_other','2026-05-02 09:46:13'),(129,87,'Singapore','cc',NULL,NULL,33,33,'curr_other','2026-05-02 09:46:13'),(130,87,'Germany','a',NULL,NULL,1,1,'curr_country','2026-05-02 09:46:13'),(131,87,'Germany','aa',NULL,NULL,11,11,'curr_country','2026-05-02 09:46:13'),(132,87,'Germany','b',NULL,NULL,2,2,'other_country','2026-05-02 09:46:13'),(133,87,'Germany','bb',NULL,NULL,22,22,'other_country','2026-05-02 09:46:13'),(134,91,'India','a',NULL,NULL,2,3,'curr_other','2026-05-02 10:36:20'),(135,91,'Poland','aa',NULL,NULL,2,2,'curr_other','2026-05-02 10:36:20'),(141,92,'United Kingdom','tst',NULL,NULL,3,3,'curr_other','2026-05-05 07:39:03'),(142,92,'Malta','sCd',NULL,NULL,2,3,'curr_other','2026-05-05 07:39:03'),(143,97,'Malta','asdfgh',NULL,NULL,4,5,'curr_other','2026-05-05 08:06:45'),(174,98,'Latvia','a','Currently Working','2026-05-02',0,0,'curr_other','2026-05-08 08:16:04'),(175,98,'Malta','b','Completed',NULL,2,1,'curr_other','2026-05-08 08:16:04'),(176,114,'France','a','Currently Working','2026-05-08',0,0,'curr_other','2026-05-08 08:28:08'),(177,114,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-08 08:28:08'),(180,115,'Canada1','a','Currently Working','2026-05-10',0,0,'curr_other','2026-05-11 06:35:25'),(181,115,'Georgia','b','Completed',NULL,2,2,'curr_other','2026-05-11 06:35:25'),(212,117,'Poland','a','Currently Working','2026-05-05',0,0,'curr_other','2026-05-19 10:36:19'),(213,117,'Singapore','b','Completed',NULL,2,1,'curr_other','2026-05-19 10:36:19'),(214,133,'Malta','a','Currently Working','2026-05-19',0,0,'curr_other','2026-05-19 12:03:25'),(215,133,'New Zealand','b','Completed',NULL,2,1,'curr_other','2026-05-19 12:03:25'),(216,134,'New Zealand','a','Currently Working','2026-05-19',0,0,'curr_other','2026-05-19 12:27:21'),(217,134,'Poland','b','Completed',NULL,2,1,'curr_other','2026-05-19 12:27:21'),(222,135,'France','a','Currently Working','2026-05-17',0,0,'curr_other','2026-05-19 12:31:31'),(223,135,'Germany','b','Completed',NULL,2,1,'curr_other','2026-05-19 12:31:31'),(232,141,'Australia','a','Currently Working','2026-05-19',0,0,'curr_other','2026-05-20 07:26:44'),(233,141,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-20 07:26:44'),(240,139,'Australia','a','Currently Working','2026-05-14',0,0,'curr_other','2026-05-20 10:15:01'),(241,139,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 10:15:01'),(242,148,'Canada1','a','Currently Working','2026-05-20',0,0,'curr_other','2026-05-20 11:58:09'),(243,148,'UAE','b','Completed',NULL,2,1,'curr_other','2026-05-20 11:58:09'),(244,149,'Latvia','a','Currently Working','2026-05-20',0,0,'curr_other','2026-05-20 12:30:03'),(245,149,'Malta','b','Completed',NULL,2,1,'curr_other','2026-05-20 12:30:03'),(262,150,'Canada1','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-22 06:45:39'),(263,150,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-22 06:45:39');
/*!40000 ALTER TABLE `application_spouse_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_status_categories`
--

DROP TABLE IF EXISTS `application_status_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_status_categories` (
  `status_id` int NOT NULL,
  `category` varchar(50) NOT NULL,
  PRIMARY KEY (`status_id`,`category`),
  CONSTRAINT `application_status_categories_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `application_statuses` (`status_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_status_categories`
--

LOCK TABLES `application_status_categories` WRITE;
/*!40000 ALTER TABLE `application_status_categories` DISABLE KEYS */;
INSERT INTO `application_status_categories` VALUES (1,'STUDY'),(1,'WORK'),(2,'COACHING'),(2,'MIGRATION');
/*!40000 ALTER TABLE `application_status_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_statuses`
--

DROP TABLE IF EXISTS `application_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_statuses` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `unique_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_statuses`
--

LOCK TABLES `application_statuses` WRITE;
/*!40000 ALTER TABLE `application_statuses` DISABLE KEYS */;
INSERT INTO `application_statuses` VALUES (1,'one'),(2,'two');
/*!40000 ALTER TABLE `application_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_sub_statuses`
--

DROP TABLE IF EXISTS `application_sub_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_sub_statuses` (
  `sub_status_id` int NOT NULL AUTO_INCREMENT,
  `status_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`sub_status_id`),
  UNIQUE KEY `unique_sub_status` (`status_id`,`name`),
  CONSTRAINT `application_sub_statuses_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `application_statuses` (`status_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_sub_statuses`
--

LOCK TABLES `application_sub_statuses` WRITE;
/*!40000 ALTER TABLE `application_sub_statuses` DISABLE KEYS */;
INSERT INTO `application_sub_statuses` VALUES (1,1,'one sub'),(2,2,'two sub');
/*!40000 ALTER TABLE `application_sub_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_work_experience`
--

DROP TABLE IF EXISTS `application_work_experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_work_experience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `is_current` tinyint(1) DEFAULT '0',
  `work_type` varchar(20) DEFAULT 'curr_country',
  PRIMARY KEY (`id`),
  KEY `fk_app_work` (`application_id`),
  CONSTRAINT `fk_app_work` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_work_experience`
--

LOCK TABLES `application_work_experience` WRITE;
/*!40000 ALTER TABLE `application_work_experience` DISABLE KEYS */;
INSERT INTO `application_work_experience` VALUES (182,9,'France','bfb',NULL,NULL,5,6,1,'curr_other'),(351,80,'Poland','2',NULL,NULL,2,2,0,'curr_other'),(352,80,'Australia','2',NULL,NULL,2,2,1,'curr_country'),(353,80,'Australia','2',NULL,NULL,2,2,0,'other_country'),(381,16,'Malta','d',NULL,NULL,6,5,1,'curr_other'),(382,16,'New Zealand','dd',NULL,NULL,4,3,1,'curr_other'),(383,16,'Australia','a',NULL,NULL,2,3,1,'curr_country'),(384,16,'Australia','aa',NULL,NULL,5,9,1,'curr_country'),(385,16,'Australia','b',NULL,NULL,2,4,0,'other_country'),(386,16,'Australia','bb',NULL,NULL,5,6,0,'other_country'),(387,16,'Canada1','cc',NULL,NULL,4,5,1,'curr_country'),(388,16,'Canada1','ccc',NULL,NULL,4,3,1,'curr_country'),(389,16,'Canada1','ccccc',NULL,NULL,4,3,0,'other_country'),(396,87,'India','c',NULL,NULL,3,3,0,'curr_other'),(397,87,'Ireland','cc',NULL,NULL,33,33,0,'curr_other'),(398,87,'Germany','a',NULL,NULL,1,1,1,'curr_country'),(399,87,'Germany','aa',NULL,NULL,11,11,1,'curr_country'),(400,87,'Germany','b',NULL,NULL,2,2,0,'other_country'),(401,87,'Germany','bb',NULL,NULL,22,22,0,'other_country'),(404,88,'Singapore','21',NULL,NULL,2,2,1,'curr_other'),(405,91,'Georgia','aa',NULL,NULL,1,2,0,'curr_other'),(406,91,'New Zealand','bb',NULL,NULL,2,3,0,'curr_other'),(412,92,'Malta','tst',NULL,NULL,3,3,1,'curr_other'),(413,92,'New Zealand','efSc',NULL,NULL,4,5,0,'curr_other'),(414,97,'Malta','asdfgh',NULL,NULL,5,4,0,'curr_other'),(445,98,'France','a','Currently Working','2026-04-24',0,0,1,'curr_other'),(446,98,'Georgia','b','Completed',NULL,2,1,1,'curr_other'),(485,133,'Germany','a','Currently Working','2026-05-19',0,0,1,'curr_other'),(486,133,'India','b','Completed',NULL,2,1,1,'curr_other'),(589,196,'France','a','Currently Working','2026-05-10',0,0,1,'curr_other'),(590,196,'Georgia','b','Completed',NULL,1,2,1,'curr_other');
/*!40000 ALTER TABLE `application_work_experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_authorities`
--

DROP TABLE IF EXISTS `board_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_authorities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_authorities`
--

LOCK TABLES `board_authorities` WRITE;
/*!40000 ALTER TABLE `board_authorities` DISABLE KEYS */;
INSERT INTO `board_authorities` VALUES (1,'WES','2026-05-07 06:52:06'),(2,'ACS','2026-05-07 06:52:06'),(3,'Engineers Australia','2026-05-07 06:52:06'),(4,'VETASSESS','2026-05-07 06:52:06'),(5,'Other','2026-05-07 06:52:06');
/*!40000 ALTER TABLE `board_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_departments`
--

DROP TABLE IF EXISTS `branch_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch_departments` (
  `branch_id` int NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`branch_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `branch_departments_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`) ON DELETE CASCADE,
  CONSTRAINT `branch_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_departments`
--

LOCK TABLES `branch_departments` WRITE;
/*!40000 ALTER TABLE `branch_departments` DISABLE KEYS */;
INSERT INTO `branch_departments` VALUES (1,1),(2,1),(3,1),(1,2),(2,2),(1,3),(1,4);
/*!40000 ALTER TABLE `branch_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `branch_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'Kochi','2026-01-29 06:28:03'),(2,'Trivandrum','2026-01-29 06:28:03'),(3,'Calicut','2026-01-29 06:28:03');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaching_courses`
--

DROP TABLE IF EXISTS `coaching_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coaching_courses` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaching_courses`
--

LOCK TABLES `coaching_courses` WRITE;
/*!40000 ALTER TABLE `coaching_courses` DISABLE KEYS */;
INSERT INTO `coaching_courses` VALUES (2,'course test 2'),(1,'test course');
/*!40000 ALTER TABLE `coaching_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (3,'Australia'),(2,'Canada1'),(10,'France'),(15,'Georgia'),(5,'Germany'),(7,'India'),(8,'Ireland'),(13,'Latvia'),(14,'Malta'),(9,'New Zealand'),(12,'Poland'),(11,'Singapore'),(6,'UAE'),(1,'United Kingdom'),(4,'USA');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_admission`
--

DROP TABLE IF EXISTS `course_admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_admission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_admission`
--

LOCK TABLES `course_admission` WRITE;
/*!40000 ALTER TABLE `course_admission` DISABLE KEYS */;
INSERT INTO `course_admission` VALUES (7,'123'),(6,'adm test'),(1,'GMAT'),(4,'GMAT Focus'),(2,'GRE'),(3,'SAT');
/*!40000 ALTER TABLE `course_admission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_language`
--

DROP TABLE IF EXISTS `course_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_language`
--

LOCK TABLES `course_language` WRITE;
/*!40000 ALTER TABLE `course_language` DISABLE KEYS */;
INSERT INTO `course_language` VALUES (7,'a language test'),(4,'CELPIP'),(5,'DET'),(1,'IELTS'),(2,'PTE'),(3,'TOEFL');
/*!40000 ALTER TABLE `course_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_status_mappings`
--

DROP TABLE IF EXISTS `department_status_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_status_mappings` (
  `department_id` int NOT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`department_id`,`status_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `department_status_mappings_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE,
  CONSTRAINT `department_status_mappings_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`status_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_status_mappings`
--

LOCK TABLES `department_status_mappings` WRITE;
/*!40000 ALTER TABLE `department_status_mappings` DISABLE KEYS */;
INSERT INTO `department_status_mappings` VALUES (1,1),(2,1),(1,2),(2,4),(1,5),(2,6);
/*!40000 ALTER TABLE `department_status_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_name` (`department_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Counsellor','2026-01-29 06:28:03'),(2,'Admission','2026-01-29 06:28:03'),(3,'Documentation','2026-01-29 06:28:03'),(4,'Accounts','2026-01-29 06:28:03');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `educational_levels`
--

DROP TABLE IF EXISTS `educational_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `educational_levels` (
  `level_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`level_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `educational_levels`
--

LOCK TABLES `educational_levels` WRITE;
/*!40000 ALTER TABLE `educational_levels` DISABLE KEYS */;
INSERT INTO `educational_levels` VALUES (9,'Advanced Diploma'),(10,'Associate Degree'),(3,'Bachelor'),(11,'Certificate III'),(12,'Certificate IV'),(2,'Diploma'),(7,'Graduate Certificate'),(13,'Graduate Diploma'),(1,'High School'),(4,'Master'),(6,'PG Diploma'),(5,'PhD'),(14,'Secondary Education');
/*!40000 ALTER TABLE `educational_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enquiry_sources`
--

DROP TABLE IF EXISTS `enquiry_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enquiry_sources` (
  `source_id` int NOT NULL AUTO_INCREMENT,
  `source_name` varchar(100) NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE KEY `source_name` (`source_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enquiry_sources`
--

LOCK TABLES `enquiry_sources` WRITE;
/*!40000 ALTER TABLE `enquiry_sources` DISABLE KEYS */;
INSERT INTO `enquiry_sources` VALUES (2,'Facebook'),(1,'Google Ads'),(3,'Instagram'),(6,'Newspaper'),(4,'Referral'),(5,'Walk-in'),(7,'Website');
/*!40000 ALTER TABLE `enquiry_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow_ups`
--

DROP TABLE IF EXISTS `follow_ups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow_ups` (
  `follow_up_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `follow_up_date` date NOT NULL,
  `remark` text NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follow_up_id`),
  KEY `student_id` (`student_id`),
  KEY `branch_id` (`branch_id`),
  KEY `department_id` (`department_id`),
  KEY `assigned_to` (`assigned_to`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `follow_ups_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `follow_ups_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  CONSTRAINT `follow_ups_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `follow_ups_ibfk_4` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`user_id`),
  CONSTRAINT `follow_ups_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_ups`
--

LOCK TABLES `follow_ups` WRITE;
/*!40000 ALTER TABLE `follow_ups` DISABLE KEYS */;
INSERT INTO `follow_ups` VALUES (1,2,1,1,'Applied',1,'2026-01-29','applied student',1,'2026-01-29 06:39:39'),(3,4,2,2,'Interested',1,'2026-01-29','intrested need o followup',1,'2026-01-29 12:17:50'),(4,5,1,2,'Interested',1,'2026-01-29','tested data',1,'2026-01-29 12:28:17'),(5,6,1,2,'Interested',1,'2026-02-08','q',1,'2026-02-08 07:45:31'),(6,7,1,2,'Interested',1,'2026-02-09','need to call',1,'2026-02-09 05:02:28'),(7,10,1,1,'Interested',1,'2026-02-11','Initial Status: Interested',1,'2026-02-11 16:30:48'),(8,10,1,2,'Doubtful',1,'2026-03-12','h',1,'2026-03-12 14:31:53'),(9,10,1,NULL,'Interested',1,'2026-04-15','saaa',1,'2026-04-14 04:51:55'),(10,7,1,NULL,'Interested',1,'2026-04-16','asdasa',1,'2026-04-14 04:53:02'),(11,6,1,NULL,'Interested',1,'2026-04-07','es',1,'2026-04-14 04:53:23'),(12,11,1,4,'',3,'2026-04-18','Dwdwdawd',1,'2026-04-18 03:28:56'),(13,12,2,1,'Applied',NULL,'2026-04-22','good',1,'2026-04-18 03:43:20'),(14,17,1,2,'Interested',3,'2026-04-23','remark test',1,'2026-04-23 11:21:57'),(15,19,1,2,'Interested',3,'2026-04-30','remark test',1,'2026-04-29 06:40:28'),(16,22,2,2,'Interested',3,'2026-04-30','remarks tess',1,'2026-04-30 10:00:00'),(17,31,1,2,'Interested',3,'2026-01-01','h',1,'2026-05-05 10:24:20'),(18,32,1,2,'Interested',1,'2026-05-09','remark',1,'2026-05-08 08:25:12'),(19,35,2,1,'Applied',1,'2026-05-20','rmk 11',1,'2026-05-20 11:55:46'),(20,36,2,1,'Applied',NULL,'2026-05-20','Initial Status: Applied',1,'2026-05-20 12:38:30');
/*!40000 ALTER TABLE `follow_ups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_categories`
--

DROP TABLE IF EXISTS `migration_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration_categories` (
  `migration_cat_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`migration_cat_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_categories`
--

LOCK TABLES `migration_categories` WRITE;
/*!40000 ALTER TABLE `migration_categories` DISABLE KEYS */;
INSERT INTO `migration_categories` VALUES (1,'for studies'),(2,'test migration cat');
/*!40000 ALTER TABLE `migration_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupations`
--

DROP TABLE IF EXISTS `occupations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occupations` (
  `occ_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`occ_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupations`
--

LOCK TABLES `occupations` WRITE;
/*!40000 ALTER TABLE `occupations` DISABLE KEYS */;
INSERT INTO `occupations` VALUES (3,'Accountant'),(9,'Chef'),(12,'Civil Engineer'),(5,'Driver'),(8,'Electrician'),(10,'Manager'),(11,'Marketing Specialist'),(7,'Mechanic'),(2,'Nurse'),(6,'Sales Executive'),(1,'Software Engineer'),(4,'Teacher');
/*!40000 ALTER TABLE `occupations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `other_types`
--

DROP TABLE IF EXISTS `other_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_types` (
  `other_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`other_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_types`
--

LOCK TABLES `other_types` WRITE;
/*!40000 ALTER TABLE `other_types` DISABLE KEYS */;
INSERT INTO `other_types` VALUES (3,'Admission Test'),(1,'Language Test'),(5,'other test'),(4,'Skill Assessment'),(6,'Spouse Language Test');
/*!40000 ALTER TABLE `other_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_adm_interest`
--

DROP TABLE IF EXISTS `registration_adm_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_adm_interest` (
  `interest_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`interest_id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `registration_adm_interest_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_adm_interest`
--

LOCK TABLES `registration_adm_interest` WRITE;
/*!40000 ALTER TABLE `registration_adm_interest` DISABLE KEYS */;
INSERT INTO `registration_adm_interest` VALUES (10,22,'adm test','2026-04-20','2026-05-08 08:16:26');
/*!40000 ALTER TABLE `registration_adm_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_admission_tests`
--

DROP TABLE IF EXISTS `registration_admission_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_admission_tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `test_type` varchar(50) DEFAULT NULL,
  `quant` varchar(20) DEFAULT NULL,
  `verbal` varchar(20) DEFAULT NULL,
  `data_insights` varchar(20) DEFAULT NULL,
  `overall` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_admission_tests`
--

LOCK TABLES `registration_admission_tests` WRITE;
/*!40000 ALTER TABLE `registration_admission_tests` DISABLE KEYS */;
INSERT INTO `registration_admission_tests` VALUES (1,9,'GMAT','2','2','2','','2026-05-02 08:27:13'),(2,9,'GRE','22','22','22','','2026-05-02 08:27:13'),(5,10,'GMAT','2','2','2','','2026-05-02 09:12:23'),(6,10,'GRE','22','22','22','','2026-05-02 09:12:23'),(7,12,'GMAT','2','2','2','','2026-05-02 09:47:21'),(8,12,'GRE','22','22','22','','2026-05-02 09:47:21'),(10,13,'GRE','1','1','1','','2026-05-02 09:49:49'),(11,15,'GMAT','23','23','2','','2026-05-02 10:37:01'),(12,15,'GRE','32','22','23','','2026-05-02 10:37:01'),(15,16,'GMAT','3','4','5','','2026-05-05 07:39:06'),(16,19,'GRE','4','56','6','','2026-05-05 08:07:29'),(17,30,'GMAT Focus','1','1','1','','2026-05-08 08:28:55'),(18,32,'GMAT','1','1','1','','2026-05-20 05:59:48'),(19,32,'GMAT Focus','2','2','2','','2026-05-20 05:59:48'),(20,33,'GMAT','1','1','1','','2026-05-20 06:04:09'),(21,33,'GMAT Focus','2','2','2','','2026-05-20 06:04:09'),(24,34,'adm test','1','1','1','','2026-05-20 06:12:25'),(25,34,'GMAT','2','2','2','','2026-05-20 06:12:25'),(26,36,'GMAT','1','1','1','','2026-05-20 06:42:12'),(27,36,'GMAT Focus','2','2','2','','2026-05-20 06:42:12'),(28,37,'adm test','1','1','1','','2026-05-20 06:42:37'),(29,37,'GMAT','2','2','2','','2026-05-20 06:42:37'),(30,38,'GMAT','1','1','1','','2026-05-20 06:43:09'),(31,38,'GMAT Focus','2','2','2','','2026-05-20 06:43:09'),(32,39,'GMAT','1','1','1','','2026-05-20 07:10:23'),(33,39,'GMAT Focus','2','2','2','','2026-05-20 07:10:23'),(34,40,'GMAT','1','1','1','','2026-05-20 07:28:08'),(35,40,'GMAT Focus','2','2','2','','2026-05-20 07:28:08'),(36,41,'adm test','1','1','1','','2026-05-20 10:14:10'),(37,41,'GMAT','2','2','2','','2026-05-20 10:14:10'),(38,42,'GMAT','1','1','1','','2026-05-20 10:15:28'),(39,42,'GMAT Focus','2','2','2','','2026-05-20 10:15:28'),(40,43,'GMAT','1','1','1','','2026-05-20 10:16:53'),(41,43,'GMAT Focus','2','2','2','','2026-05-20 10:16:53'),(42,44,'GMAT','1','1','1','','2026-05-20 10:25:32'),(43,44,'GMAT Focus','2','2','2','','2026-05-20 10:25:32'),(44,45,'GMAT','1','1','1','','2026-05-20 11:00:33'),(45,45,'GMAT Focus','2','2','2','','2026-05-20 11:00:33'),(46,46,'GMAT','1','1','1','','2026-05-20 11:01:13'),(47,46,'GMAT Focus','2','2','2','','2026-05-20 11:01:13'),(48,47,'GMAT','1','1','1','','2026-05-20 11:18:51'),(49,47,'GMAT Focus','2','2','2','','2026-05-20 11:18:51'),(60,49,'adm test','1','1','1','','2026-05-22 08:58:22'),(61,49,'GMAT','2','2','2','','2026-05-22 08:58:22');
/*!40000 ALTER TABLE `registration_admission_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_children`
--

DROP TABLE IF EXISTS `registration_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_children` (
  `child_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `age` int DEFAULT NULL,
  `is_accompanying` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`child_id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `registration_children_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_children`
--

LOCK TABLES `registration_children` WRITE;
/*!40000 ALTER TABLE `registration_children` DISABLE KEYS */;
INSERT INTO `registration_children` VALUES (13,5,12,1),(14,5,10,0),(19,10,4,1),(20,10,2,0),(21,12,4,1),(22,12,2,0),(23,15,3,1),(24,15,1,0),(29,16,4,1),(30,16,2,0),(31,19,5,1),(32,19,2,0),(51,22,4,1),(52,22,2,0),(92,57,1,1);
/*!40000 ALTER TABLE `registration_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_education`
--

DROP TABLE IF EXISTS `registration_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `expected_completion` date DEFAULT NULL,
  `is_highest` tinyint(1) DEFAULT '0',
  `edu_type` varchar(20) DEFAULT 'highest',
  PRIMARY KEY (`id`),
  KEY `fk_reg_edu` (`registration_id`),
  CONSTRAINT `fk_reg_edu` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_education`
--

LOCK TABLES `registration_education` WRITE;
/*!40000 ALTER TABLE `registration_education` DISABLE KEYS */;
INSERT INTO `registration_education` VALUES (36,10,'UAE','Graduate Certificate','Finance','Not Completed','2022-08-01',1,'highest'),(37,10,'India','High School','Hospitality','Completed','2022-08-01',0,'highest'),(38,10,'Australia','Bachelor','Architecture','Not Completed','2023-10-01',0,'country'),(39,10,'Australia','Associate Degree','Agriculture','Completed',NULL,0,'country'),(40,10,'Canada1','Master','Information Technology','Not Completed','2023-10-01',0,'country'),(41,10,'Poland','Master','Information Technology','Not Completed','2022-08-01',0,'other'),(42,10,'Germany','Graduate Certificate','Hospitality','Completed',NULL,0,'other'),(43,12,'Australia','High School','Hospitality','Not Completed','2026-04-01',1,'highest'),(44,12,'Canada1','Graduate Certificate','Finance','Completed',NULL,0,'highest'),(45,12,'Germany','Graduate Diploma','Health & Medicine','Not Completed','2026-04-01',0,'country'),(46,12,'Germany','Graduate Diploma','Finance','Completed',NULL,0,'country'),(47,12,'France','High School','Finance','Not Completed','2026-04-01',0,'other'),(48,12,'Georgia','Graduate Diploma','Finance','Completed',NULL,0,'other'),(51,13,'Malta','Graduate Diploma','Health & Medicine','Completed',NULL,1,'highest'),(52,13,'Latvia','Diploma','Hospitality','Completed',NULL,0,'other'),(53,15,'Malta','Master','Environmental Science','Not Completed','2026-04-01',1,'highest'),(54,15,'India','Diploma','Hospitality','Completed',NULL,0,'highest'),(55,15,'Poland','High School','Finance','Not Completed','2026-04-01',0,'other'),(56,15,'New Zealand','Graduate Diploma','Engineering','Completed',NULL,0,'other'),(61,16,'Malta','Graduate Diploma','Environmental Science','Completed',NULL,1,'highest'),(62,16,'UAE','Master','Information Technology','Completed',NULL,0,'other'),(63,19,'UAE','High School','Environmental Science','Not Completed','2026-04-01',1,'highest'),(64,19,'Ireland','Graduate Certificate','Engineering','Not Completed','2026-04-01',0,'other'),(87,22,'Australia','Advanced Diploma','Dentistry','Not Completed','2024-12-01',1,'highest'),(88,22,'Canada1','Certificate III','Built Environment','Completed',NULL,0,'highest'),(142,57,'Canada1','Associate Degree','Architecture','Not Completed','2025-03-01',1,'highest'),(143,57,'France','Associate Degree','Agriculture','Completed',NULL,0,'highest');
/*!40000 ALTER TABLE `registration_education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_lang_interest`
--

DROP TABLE IF EXISTS `registration_lang_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_lang_interest` (
  `interest_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `is_spouse` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`interest_id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `registration_lang_interest_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_lang_interest`
--

LOCK TABLES `registration_lang_interest` WRITE;
/*!40000 ALTER TABLE `registration_lang_interest` DISABLE KEYS */;
INSERT INTO `registration_lang_interest` VALUES (19,22,'a language test','2026-04-20',0,'2026-05-08 08:16:26'),(20,22,'a language test','2026-04-20',1,'2026-05-08 08:16:26');
/*!40000 ALTER TABLE `registration_lang_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_language_tests`
--

DROP TABLE IF EXISTS `registration_language_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_language_tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `test_type` varchar(50) DEFAULT NULL,
  `reading` varchar(20) DEFAULT NULL,
  `writing` varchar(20) DEFAULT NULL,
  `speaking` varchar(20) DEFAULT NULL,
  `listening` varchar(20) DEFAULT NULL,
  `overall` varchar(20) DEFAULT NULL,
  `is_spouse` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_reg_lang` (`registration_id`),
  CONSTRAINT `fk_reg_lang` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_language_tests`
--

LOCK TABLES `registration_language_tests` WRITE;
/*!40000 ALTER TABLE `registration_language_tests` DISABLE KEYS */;
INSERT INTO `registration_language_tests` VALUES (9,10,'PTE','1','1','1','1','',0),(10,10,'IELTS','11','11','11','11','',0),(11,10,'TOEFL','2','2','2','2','',1),(12,10,'IELTS','2','2','2','2','',1),(13,12,'IELTS','1','1','1','1','',0),(14,12,'PTE','11','11','11','11','',0),(15,12,'IELTS','1','1','1','1','',1),(16,12,'PTE','11','11','11','11','',1),(18,13,'TOEFL','1','1','1','1','',0),(19,15,'PTE','2','2','2','2','',0),(20,15,'IELTS','3','2','23','2','',0),(21,15,'IELTS','3','2','3','3','',1),(22,15,'TOEFL','3','2','2','1','',1),(27,16,'PTE','6','4','5','4','',0),(28,16,'IELTS','6','3','5','4','',1),(29,19,'PTE','4','4','6','5','',0),(30,19,'IELTS','4','4','6','5','',1);
/*!40000 ALTER TABLE `registration_language_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_relatives`
--

DROP TABLE IF EXISTS `registration_relatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_relatives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `relationship` varchar(100) DEFAULT NULL,
  `related_to` enum('Applicant','Spouse') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_relatives`
--

LOCK TABLES `registration_relatives` WRITE;
/*!40000 ALTER TABLE `registration_relatives` DISABLE KEYS */;
INSERT INTO `registration_relatives` VALUES (1,9,'Australia','Uncle/Aunty','Spouse','2026-05-02 08:27:13'),(3,10,'Australia','Uncle/Aunty','Spouse','2026-05-02 09:12:23'),(4,12,'Germany','Uncle/Aunty','Spouse','2026-05-02 09:47:21'),(5,15,'Germany','Sibling','Spouse','2026-05-02 10:37:01'),(8,16,'Canada1','Sibling','Spouse','2026-05-05 07:39:06'),(9,19,'Canada1','Uncle/Aunty','Spouse','2026-05-05 08:07:29'),(10,20,'Australia','Uncle/Aunty','Applicant','2026-05-07 10:03:39'),(11,20,'France','Parent','Spouse','2026-05-07 10:03:39'),(12,21,'Australia','Uncle/Aunty','Applicant','2026-05-07 10:49:25'),(13,21,'France','Parent','Spouse','2026-05-07 10:49:25'),(28,22,'France','Uncle/Aunty','Applicant','2026-05-08 08:16:26'),(29,22,'Canada1','Uncle/Aunty','Spouse','2026-05-08 08:16:26'),(30,30,'Australia','Sibling','Applicant','2026-05-08 08:28:55'),(31,30,'Canada1','Cousin','Spouse','2026-05-08 08:28:55'),(32,31,'Australia','Sibling','Spouse','2026-05-19 12:23:28'),(33,32,'Australia','Uncle/Aunty','Spouse','2026-05-20 05:59:48'),(34,32,'Australia','Cousin','Applicant','2026-05-20 05:59:48'),(35,33,'Australia','Uncle/Aunty','Spouse','2026-05-20 06:04:09'),(36,33,'Australia','Cousin','Applicant','2026-05-20 06:04:09'),(39,34,'Australia','Sibling','Spouse','2026-05-20 06:12:25'),(40,34,'Canada1','Uncle/Aunty','Applicant','2026-05-20 06:12:25'),(41,36,'Australia','Uncle/Aunty','Spouse','2026-05-20 06:42:12'),(42,36,'Australia','Cousin','Applicant','2026-05-20 06:42:12'),(43,37,'Australia','Sibling','Spouse','2026-05-20 06:42:37'),(44,37,'Canada1','Uncle/Aunty','Applicant','2026-05-20 06:42:37'),(45,38,'Australia','Uncle/Aunty','Spouse','2026-05-20 06:43:09'),(46,38,'Australia','Cousin','Applicant','2026-05-20 06:43:09'),(47,39,'Australia','Uncle/Aunty','Spouse','2026-05-20 07:10:23'),(48,39,'Australia','Cousin','Applicant','2026-05-20 07:10:23'),(49,40,'Australia','Uncle/Aunty','Spouse','2026-05-20 07:28:08'),(50,40,'Australia','Cousin','Applicant','2026-05-20 07:28:08'),(51,41,'Australia','Sibling','Spouse','2026-05-20 10:14:10'),(52,41,'Canada1','Uncle/Aunty','Applicant','2026-05-20 10:14:10'),(53,42,'Australia','Uncle/Aunty','Spouse','2026-05-20 10:15:28'),(54,42,'Australia','Cousin','Applicant','2026-05-20 10:15:28'),(55,43,'Australia','Uncle/Aunty','Spouse','2026-05-20 10:16:53'),(56,43,'Australia','Cousin','Applicant','2026-05-20 10:16:53'),(57,44,'Australia','Uncle/Aunty','Spouse','2026-05-20 10:25:32'),(58,44,'Australia','Cousin','Applicant','2026-05-20 10:25:32'),(59,45,'Australia','Uncle/Aunty','Spouse','2026-05-20 11:00:33'),(60,45,'Australia','Cousin','Applicant','2026-05-20 11:00:33'),(61,46,'Australia','Uncle/Aunty','Spouse','2026-05-20 11:01:13'),(62,46,'Australia','Cousin','Applicant','2026-05-20 11:01:13'),(63,47,'Australia','Uncle/Aunty','Spouse','2026-05-20 11:18:51'),(64,47,'Australia','Cousin','Applicant','2026-05-20 11:18:51'),(65,48,'Australia','Sibling','Spouse','2026-05-20 12:31:47'),(66,48,'France','Uncle/Aunty','Applicant','2026-05-20 12:31:47'),(77,49,'Australia','Sibling','Spouse','2026-05-22 08:58:22'),(78,49,'Canada1','Friend','Applicant','2026-05-22 08:58:22'),(79,56,'Australia','Uncle/Aunty','Spouse','2026-05-23 07:38:05'),(80,56,'France','Friend','Applicant','2026-05-23 07:38:05'),(81,57,'Australia','Uncle/Aunty','Spouse','2026-05-23 07:39:39'),(82,57,'France','Friend','Applicant','2026-05-23 07:39:39');
/*!40000 ALTER TABLE `registration_relatives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_skill`
--

DROP TABLE IF EXISTS `registration_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_skill` (
  `skill_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `authority` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `sub_status` varchar(100) DEFAULT NULL,
  `is_interest` tinyint(1) DEFAULT '0',
  `remarks` text,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`skill_id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `registration_skill_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_skill`
--

LOCK TABLES `registration_skill` WRITE;
/*!40000 ALTER TABLE `registration_skill` DISABLE KEYS */;
INSERT INTO `registration_skill` VALUES (19,22,'Germany','Engineers Australia','Incompleted','In Progress',1,NULL,'2026-05-08 13:46:26'),(20,22,'New Zealand','Engineers Australia','Completed','Documents Pending',1,NULL,'2026-05-08 13:46:26');
/*!40000 ALTER TABLE `registration_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_spouse_education`
--

DROP TABLE IF EXISTS `registration_spouse_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_spouse_education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `expected_completion` date DEFAULT NULL,
  `edu_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_spouse_education`
--

LOCK TABLES `registration_spouse_education` WRITE;
/*!40000 ALTER TABLE `registration_spouse_education` DISABLE KEYS */;
INSERT INTO `registration_spouse_education` VALUES (1,9,'Australia','Associate Degree','Architecture','Not Completed','2024-09-01','country','2026-05-02 08:27:13'),(2,9,'Australia','Advanced Diploma','Agriculture','Completed',NULL,'country','2026-05-02 08:27:13'),(3,9,'Canada1','Advanced Diploma','Information Technology','Not Completed','2024-09-01','country','2026-05-02 08:27:13'),(4,9,'UAE','PG Diploma','Information Technology','Not Completed','2024-09-01','highest','2026-05-02 08:27:13'),(5,9,'New Zealand','High School','Information Technology','Completed',NULL,'highest','2026-05-02 08:27:13'),(6,9,'Latvia','Bachelor','Engineering','Not Completed','2024-09-01','other','2026-05-02 08:27:13'),(7,9,'UAE','Graduate Diploma','Dentistry','Completed',NULL,'other','2026-05-02 08:27:13'),(15,10,'Australia','Associate Degree','Architecture','Not Completed','2024-04-01','country','2026-05-02 09:12:23'),(16,10,'Australia','Advanced Diploma','Agriculture','Completed',NULL,'country','2026-05-02 09:12:23'),(17,10,'Canada1','Advanced Diploma','Information Technology','Not Completed','2024-04-01','country','2026-05-02 09:12:23'),(18,10,'UAE','PG Diploma','Information Technology','Not Completed','2024-04-01','highest','2026-05-02 09:12:23'),(19,10,'New Zealand','High School','Information Technology','Completed',NULL,'highest','2026-05-02 09:12:23'),(20,10,'Latvia','Bachelor','Engineering','Not Completed','2024-04-01','other','2026-05-02 09:12:23'),(21,10,'UAE','Graduate Diploma','Dentistry','Completed',NULL,'other','2026-05-02 09:12:23'),(22,12,'Germany','Advanced Diploma','Built Environment','Not Completed','2026-04-01','country','2026-05-02 09:47:21'),(23,12,'Germany','Associate Degree','Arts & Humanities','Completed',NULL,'country','2026-05-02 09:47:21'),(24,12,'Ireland','Graduate Certificate','Health & Medicine','Not Completed','2026-04-01','highest','2026-05-02 09:47:21'),(25,12,'Latvia','Diploma','Finance','Completed',NULL,'highest','2026-05-02 09:47:21'),(26,12,'Malta','PG Diploma','Health & Medicine','Not Completed','2026-04-01','other','2026-05-02 09:47:21'),(27,12,'New Zealand','High School','Finance','Completed',NULL,'other','2026-05-02 09:47:21'),(28,15,'New Zealand','High School','Hospitality','Not Completed','2026-04-01','highest','2026-05-02 10:37:01'),(29,15,'Poland','Graduate Certificate','Environmental Science','Completed',NULL,'highest','2026-05-02 10:37:01'),(30,15,'New Zealand','Graduate Certificate','Finance','Not Completed','2026-04-01','other','2026-05-02 10:37:01'),(31,15,'Latvia','Diploma','Health & Medicine','Completed',NULL,'other','2026-05-02 10:37:01'),(36,16,'Poland','High School','Hospitality','Completed',NULL,'highest','2026-05-05 07:39:06'),(37,16,'Poland','Graduate Diploma','Finance','Completed',NULL,'other','2026-05-05 07:39:06'),(38,19,'Poland','Master','Health & Medicine','Not Completed','2026-04-01','highest','2026-05-05 08:07:29'),(39,19,'Latvia','High School','Environmental Science','Not Completed','2026-04-01','other','2026-05-05 08:07:29'),(40,20,'India','Certificate IV','Engineering','Not Completed','2025-07-01','highest','2026-05-07 10:03:39'),(41,20,'Ireland','High School','Finance','Not Completed','2026-02-01','highest','2026-05-07 10:03:39'),(42,21,'India','Certificate IV','Engineering','Not Completed','2025-07-01','highest','2026-05-07 10:49:25'),(43,21,'Ireland','High School','Finance','Not Completed','2026-02-01','highest','2026-05-07 10:49:25'),(58,22,'India','Certificate IV','Engineering','Not Completed','2024-12-01','highest','2026-05-08 08:16:26'),(59,22,'Ireland','High School','Finance','Not Completed','2025-07-01','highest','2026-05-08 08:16:26'),(60,30,'Canada1','Bachelor','Agriculture','Not Completed','2026-04-01','highest','2026-05-08 08:28:55'),(61,30,'Georgia','Bachelor','Architecture','Completed',NULL,'highest','2026-05-08 08:28:55'),(62,31,'Ireland','Bachelor','Architecture','Not Completed','2026-04-01','highest','2026-05-19 12:23:28'),(63,31,'Latvia','Certificate III','Arts & Humanities','Completed',NULL,'highest','2026-05-19 12:23:28'),(64,32,'Canada1','Bachelor','Agriculture','Not Completed','2026-03-01','highest','2026-05-20 05:59:48'),(65,32,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 05:59:48'),(66,33,'Canada1','Bachelor','Agriculture','Not Completed','2026-03-01','highest','2026-05-20 06:04:09'),(67,33,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 06:04:09'),(70,34,'Canada1','Associate Degree','Agriculture','Not Completed','2026-03-01','highest','2026-05-20 06:12:25'),(71,34,'UAE','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-20 06:12:25'),(72,36,'Canada1','Bachelor','Agriculture','Not Completed','2026-03-01','highest','2026-05-20 06:42:12'),(73,36,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 06:42:12'),(74,37,'Canada1','Associate Degree','Agriculture','Not Completed','2026-04-01','highest','2026-05-20 06:42:37'),(75,37,'UAE','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-20 06:42:37'),(76,38,'Canada1','Bachelor','Agriculture','Not Completed','2026-03-01','highest','2026-05-20 06:43:09'),(77,38,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 06:43:09'),(78,39,'Canada1','Bachelor','Agriculture','Not Completed','2026-02-01','highest','2026-05-20 07:10:23'),(79,39,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 07:10:23'),(80,40,'Canada1','Bachelor','Agriculture','Not Completed','2026-01-01','highest','2026-05-20 07:28:08'),(81,40,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 07:28:08'),(82,41,'Canada1','Associate Degree','Agriculture','Not Completed','2026-03-01','highest','2026-05-20 10:14:10'),(83,41,'UAE','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-20 10:14:10'),(84,42,'Canada1','Bachelor','Agriculture','Not Completed','2025-10-01','highest','2026-05-20 10:15:28'),(85,42,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 10:15:28'),(86,43,'Canada1','Bachelor','Agriculture','Not Completed','2025-10-01','highest','2026-05-20 10:16:53'),(87,43,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 10:16:53'),(88,44,'Canada1','Bachelor','Agriculture','Not Completed','2025-10-01','highest','2026-05-20 10:25:32'),(89,44,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 10:25:32'),(90,45,'Canada1','Bachelor','Agriculture','Not Completed','2025-10-01','highest','2026-05-20 11:00:33'),(91,45,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 11:00:33'),(92,46,'Canada1','Bachelor','Agriculture','Not Completed','2025-10-01','highest','2026-05-20 11:01:13'),(93,46,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 11:01:13'),(94,47,'Canada1','Bachelor','Agriculture','Not Completed','2025-10-01','highest','2026-05-20 11:18:51'),(95,47,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-20 11:18:51'),(96,48,'India','Advanced Diploma','Accounting','Not Completed','2026-04-01','highest','2026-05-20 12:31:47'),(97,48,'Ireland','Certificate III','Architecture','Completed',NULL,'highest','2026-05-20 12:31:47'),(108,49,'Australia','Associate Degree','Agriculture','Not Completed','2025-12-01','highest','2026-05-22 08:58:22'),(109,49,'France','Certificate III','Agriculture','Completed',NULL,'highest','2026-05-22 08:58:22'),(110,55,'','','','Completed',NULL,'highest','2026-05-23 06:14:32'),(111,56,'Australia','Bachelor','Agriculture','Not Completed','2025-04-01','highest','2026-05-23 07:38:05'),(112,56,'France','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-23 07:38:05'),(113,57,'Australia','Bachelor','Agriculture','Not Completed','2025-03-01','highest','2026-05-23 07:39:39'),(114,57,'France','Bachelor','Agriculture','Completed',NULL,'highest','2026-05-23 07:39:39');
/*!40000 ALTER TABLE `registration_spouse_education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_spouse_work`
--

DROP TABLE IF EXISTS `registration_spouse_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_spouse_work` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `work_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_spouse_work`
--

LOCK TABLES `registration_spouse_work` WRITE;
/*!40000 ALTER TABLE `registration_spouse_work` DISABLE KEYS */;
INSERT INTO `registration_spouse_work` VALUES (1,9,'Latvia','e',NULL,NULL,5,5,'other','2026-05-02 08:27:13'),(2,9,'Australia','a',NULL,NULL,1,1,'curr_country','2026-05-02 08:27:13'),(3,9,'Australia','b',NULL,NULL,2,2,'curr_country','2026-05-02 08:27:13'),(4,9,'Australia','c',NULL,NULL,3,3,'other_country','2026-05-02 08:27:13'),(5,9,'Canada1','d',NULL,NULL,4,4,'other_country','2026-05-02 08:27:13'),(11,10,'Poland','e',NULL,NULL,2,2,'curr_other','2026-05-02 09:12:23'),(12,10,'Australia','a',NULL,NULL,1,1,'curr_country','2026-05-02 09:12:23'),(13,10,'Australia','b',NULL,NULL,2,2,'curr_country','2026-05-02 09:12:23'),(14,10,'Australia','c',NULL,NULL,3,3,'other_country','2026-05-02 09:12:23'),(15,10,'Canada1','d',NULL,NULL,4,4,'other_country','2026-05-02 09:12:23'),(16,12,'Poland','c',NULL,NULL,3,3,'curr_other','2026-05-02 09:47:21'),(17,12,'Singapore','cc',NULL,NULL,33,33,'curr_other','2026-05-02 09:47:21'),(18,12,'Germany','a',NULL,NULL,1,1,'curr_country','2026-05-02 09:47:21'),(19,12,'Germany','aa',NULL,NULL,11,11,'curr_country','2026-05-02 09:47:21'),(20,12,'Germany','b',NULL,NULL,2,2,'other_country','2026-05-02 09:47:21'),(21,12,'Germany','bb',NULL,NULL,22,22,'other_country','2026-05-02 09:47:21'),(22,15,'India','a',NULL,NULL,2,3,'curr_other','2026-05-02 10:37:01'),(23,15,'Poland','aa',NULL,NULL,2,2,'curr_other','2026-05-02 10:37:01'),(26,16,'Malta','sCd',NULL,NULL,2,3,'curr_other','2026-05-05 07:39:06'),(27,19,'Malta','asdfgh',NULL,NULL,4,5,'curr_other','2026-05-05 08:07:29'),(28,21,'Latvia','a','Currently Working','2026-05-05',0,0,'curr_other','2026-05-07 10:49:25'),(29,21,'Malta','b','Completed',NULL,2,1,'curr_other','2026-05-07 10:49:25'),(44,22,'Latvia','a','Currently Working','2026-04-28',0,0,'curr_other','2026-05-08 08:16:26'),(45,22,'Malta','b','Completed',NULL,2,1,'curr_other','2026-05-08 08:16:26'),(46,30,'France','a','Currently Working','2026-05-07',0,0,'curr_other','2026-05-08 08:28:55'),(47,30,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-08 08:28:55'),(48,31,'Malta','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-19 12:23:28'),(49,31,'New Zealand','b','Completed',NULL,2,1,'curr_other','2026-05-19 12:23:28'),(50,32,'Australia','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-20 05:59:48'),(51,32,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 05:59:48'),(52,33,'Australia','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-20 06:04:09'),(53,33,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 06:04:09'),(56,34,'Australia','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-20 06:12:25'),(57,34,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-20 06:12:25'),(58,36,'Australia','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-20 06:42:12'),(59,36,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 06:42:12'),(60,37,'Australia','a','Currently Working','2026-05-19',0,0,'curr_other','2026-05-20 06:42:37'),(61,37,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-20 06:42:37'),(62,38,'Australia','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-20 06:43:09'),(63,38,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 06:43:09'),(64,39,'Australia','a','Currently Working','2026-05-17',0,0,'curr_other','2026-05-20 07:10:23'),(65,39,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 07:10:23'),(66,40,'Australia','a','Currently Working','2026-05-16',0,0,'curr_other','2026-05-20 07:28:08'),(67,40,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 07:28:08'),(68,41,'Australia','a','Currently Working','2026-05-18',0,0,'curr_other','2026-05-20 10:14:10'),(69,41,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-20 10:14:10'),(70,42,'Australia','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-20 10:15:28'),(71,42,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 10:15:28'),(72,43,'Australia','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-20 10:16:53'),(73,43,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 10:16:53'),(74,44,'Australia','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-20 10:25:32'),(75,44,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 10:25:32'),(76,45,'Australia','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-20 11:00:33'),(77,45,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 11:00:33'),(78,46,'Australia','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-20 11:01:13'),(79,46,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 11:01:13'),(80,47,'Australia','a','Currently Working','2026-05-13',0,0,'curr_other','2026-05-20 11:18:51'),(81,47,'Canada1','b','Completed',NULL,2,1,'curr_other','2026-05-20 11:18:51'),(82,48,'Latvia','a','Currently Working','2026-05-19',0,0,'curr_other','2026-05-20 12:31:47'),(83,48,'Malta','b','Completed',NULL,2,1,'curr_other','2026-05-20 12:31:47'),(94,49,'Canada1','a','Currently Working','2026-05-15',0,0,'curr_other','2026-05-22 08:58:22'),(95,49,'Georgia','b','Completed',NULL,2,1,'curr_other','2026-05-22 08:58:22');
/*!40000 ALTER TABLE `registration_spouse_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_suggested_programs`
--

DROP TABLE IF EXISTS `registration_suggested_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_suggested_programs` (
  `sug_program_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `issystem` tinyint(1) DEFAULT '0',
  `program_type` varchar(50) DEFAULT NULL,
  `program` varchar(255) DEFAULT NULL,
  `applied_for` varchar(255) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `details2` varchar(255) DEFAULT NULL,
  `details3` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `sub_status` varchar(100) DEFAULT NULL,
  `remarks` text,
  `is_selected` tinyint(1) DEFAULT '0',
  `branch_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  PRIMARY KEY (`sug_program_id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `registration_suggested_programs_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_suggested_programs`
--

LOCK TABLES `registration_suggested_programs` WRITE;
/*!40000 ALTER TABLE `registration_suggested_programs` DISABLE KEYS */;
INSERT INTO `registration_suggested_programs` VALUES (1,2,0,NULL,'STUDY Australia',NULL,'Certificate IV Agriculture - April 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(2,3,0,NULL,'STUDY Australia',NULL,'Bachelor Business - August 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(3,3,0,NULL,'STUDY France',NULL,'Bachelor Engineering - September 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(4,3,0,NULL,'Canada',NULL,'Accountant - Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(5,3,0,NULL,'India',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(6,3,0,NULL,'',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(7,3,0,NULL,'COACHING',NULL,'test course - test',NULL,NULL,'','','',1,NULL,NULL,NULL),(8,4,0,NULL,'STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(9,4,0,NULL,'Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(46,5,0,NULL,'STUDY India',NULL,'Master Computing - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(47,5,0,NULL,'Australia',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(48,5,0,NULL,'Canada1',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(49,5,0,NULL,'France',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(50,5,0,NULL,'COACHING',NULL,'test course - inputted a',NULL,NULL,'','','',1,NULL,NULL,NULL),(51,5,0,NULL,'MIGRATION Germany',NULL,'Marketing Specialist - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(72,10,0,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(73,10,0,'STUDY','STUDY Canada1',NULL,'Associate Degree Accounting - August 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(74,10,0,'OTHER','Australia',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(75,10,0,'OTHER','Canada1',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(76,10,0,'OTHER','Australia',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(77,10,0,'OTHER','Canada1',NULL,'Spouse Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(78,10,0,'OTHER','Australia',NULL,'Accountant',NULL,NULL,'','','',1,NULL,NULL,NULL),(79,10,0,'OTHER','Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(80,10,0,'COACHING','COACHING',NULL,'test course - testa',NULL,NULL,'','','',1,NULL,NULL,NULL),(81,10,0,'COACHING','COACHING',NULL,'test course - testb',NULL,NULL,'','','',1,NULL,NULL,NULL),(82,12,0,'STUDY','STUDY France',NULL,'Advanced Diploma Accounting - April 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(83,12,0,'MIGRATION','Germany',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(84,12,0,'VISA','Australia',NULL,'Spouse Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(85,12,0,'WORK','France',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(86,12,0,'COACHING','COACHING',NULL,'test course - dsfd',NULL,NULL,'','','',1,NULL,NULL,NULL),(88,13,0,'STUDY','STUDY Poland',NULL,'Graduate Certificate Creative Arts - July 2027',NULL,NULL,'one','one sub','',1,1,1,1),(89,15,0,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(90,15,0,'MIGRATION','Germany',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(91,15,0,'VISA','Australia',NULL,'Spouse Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(92,15,0,'WORK','Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(93,15,0,'COACHING','COACHING',NULL,'test course - 343',NULL,NULL,'','','',1,NULL,NULL,NULL),(104,16,0,'STUDY','STUDY Australia',NULL,'- April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(105,16,0,'MIGRATION','Canada1',NULL,' - ',NULL,NULL,'','','',1,NULL,NULL,NULL),(106,16,0,'VISA','Georgia',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(107,16,0,'WORK','Canada1',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(108,16,0,'COACHING','COACHING',NULL,'test course - ',NULL,NULL,'','','',1,NULL,NULL,NULL),(109,19,0,'STUDY','STUDY Australia',NULL,'Associate Degree Agriculture - August 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(110,19,0,'MIGRATION','Canada1',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(111,19,0,'VISA','Canada1',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(112,19,0,'WORK','Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(113,19,0,'COACHING','COACHING',NULL,'test course - zcszc',NULL,NULL,'','','',1,NULL,NULL,NULL),(159,22,0,'STUDY','STUDY France',NULL,'Associate Degree Architecture - April 2025',NULL,NULL,'one','one sub','1',1,1,1,1),(160,22,0,'MIGRATION','Australia',NULL,'Accountant - for studies',NULL,NULL,'two','two sub','2',1,2,2,NULL),(161,22,0,'VISA','Canada1',NULL,'Dependent Visa',NULL,NULL,'','','3',1,1,1,3),(162,22,0,'WORK','Canada1',NULL,'Civil Engineer',NULL,NULL,'one','one sub','4',1,1,1,1),(163,22,0,'COACHING','COACHING',NULL,'test course - 2322344',NULL,NULL,'two','two sub','5',1,1,3,NULL),(360,57,0,'STUDY','Australia','Advanced Diploma','Accounting','April','2025',NULL,NULL,NULL,2,NULL,NULL,NULL),(361,57,0,'MIGRATION','France','Accountant','for studies','1','1',NULL,NULL,NULL,2,NULL,NULL,NULL),(362,57,0,'VISA','Canada1','Dependent Visa','1','2','2',NULL,NULL,NULL,2,NULL,NULL,NULL),(363,57,0,'WORK','Georgia','Civil Engineer','2','3','3',NULL,NULL,NULL,2,NULL,NULL,NULL),(364,57,0,'COACHING','COACHING','course test 2','3','4','4',NULL,NULL,NULL,2,NULL,NULL,NULL),(365,57,1,'Admission Test','GMAT Focus','2','5','6','6',NULL,NULL,NULL,1,NULL,NULL,NULL),(366,57,1,'Language Test','IELTS','3','6','7','7',NULL,NULL,NULL,1,NULL,NULL,NULL),(367,57,1,'Skill Assessment','Engineers Australia','4','7','8','8',NULL,NULL,NULL,2,NULL,NULL,NULL),(368,57,0,'Language Test','DET','5','8','9','9',NULL,NULL,NULL,2,NULL,NULL,NULL),(369,57,0,'Admission Test','GMAT','6','9','0','0',NULL,NULL,NULL,2,NULL,NULL,NULL),(370,57,0,'Spouse Language Test','DET','7','0','1','1',NULL,NULL,NULL,2,NULL,NULL,NULL),(371,57,0,'Skill Assessment','Engineers Australia','8','1','2','2',NULL,NULL,NULL,2,NULL,NULL,NULL),(372,57,0,'EDUCATION LOAN','ED','9','2','3','3',NULL,NULL,NULL,2,NULL,NULL,NULL),(373,57,0,'FOREX','FOR','1','4','5','5',NULL,NULL,NULL,2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `registration_suggested_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_work_experience`
--

DROP TABLE IF EXISTS `registration_work_experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_work_experience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `type` enum('current','previous') DEFAULT 'previous',
  `work_type` varchar(20) DEFAULT 'curr_country',
  PRIMARY KEY (`id`),
  KEY `fk_reg_work` (`registration_id`),
  CONSTRAINT `fk_reg_work` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_work_experience`
--

LOCK TABLES `registration_work_experience` WRITE;
/*!40000 ALTER TABLE `registration_work_experience` DISABLE KEYS */;
INSERT INTO `registration_work_experience` VALUES (39,10,'Malta','d',NULL,NULL,6,5,'current','curr_other'),(40,10,'New Zealand','dd',NULL,NULL,4,3,'current','curr_other'),(41,10,'Australia','a',NULL,NULL,2,3,'current','curr_country'),(42,10,'Australia','aa',NULL,NULL,5,9,'current','curr_country'),(43,10,'Australia','b',NULL,NULL,2,4,'previous','other_country'),(44,10,'Australia','bb',NULL,NULL,5,6,'previous','other_country'),(45,10,'Canada1','cc',NULL,NULL,4,5,'current','curr_country'),(46,10,'Canada1','ccc',NULL,NULL,4,3,'current','curr_country'),(47,10,'Canada1','ccccc',NULL,NULL,4,3,'previous','other_country'),(48,12,'India','c',NULL,NULL,3,3,'previous','curr_other'),(49,12,'Ireland','cc',NULL,NULL,33,33,'previous','curr_other'),(50,12,'Germany','a',NULL,NULL,1,1,'current','curr_country'),(51,12,'Germany','aa',NULL,NULL,11,11,'current','curr_country'),(52,12,'Germany','b',NULL,NULL,2,2,'previous','other_country'),(53,12,'Germany','bb',NULL,NULL,22,22,'previous','other_country'),(55,13,'Singapore','21',NULL,NULL,2,2,'current','curr_other'),(56,15,'Georgia','aa',NULL,NULL,1,2,'previous','curr_other'),(57,15,'New Zealand','bb',NULL,NULL,2,3,'previous','curr_other'),(60,16,'New Zealand','efSc',NULL,NULL,4,5,'previous','curr_other'),(61,19,'Malta','asdfgh',NULL,NULL,5,4,'previous','curr_other'),(80,22,'France','a','Currently Working','2026-04-20',0,0,'current','curr_other'),(81,22,'Georgia','b','Completed',NULL,2,1,'current','curr_other'),(134,57,'France','a','Currently Working','2026-05-09',0,0,'current','curr_other'),(135,57,'Georgia','b','Completed',NULL,1,2,'current','curr_other');
/*!40000 ALTER TABLE `registration_work_experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_assessment_statuses`
--

DROP TABLE IF EXISTS `skill_assessment_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill_assessment_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_assessment_statuses`
--

LOCK TABLES `skill_assessment_statuses` WRITE;
/*!40000 ALTER TABLE `skill_assessment_statuses` DISABLE KEYS */;
INSERT INTO `skill_assessment_statuses` VALUES (1,'Completed','2026-05-07 06:56:05'),(2,'Incompleted','2026-05-07 06:56:05'),(3,'Interested','2026-05-07 06:56:05'),(4,'In Progress','2026-05-07 06:56:05');
/*!40000 ALTER TABLE `skill_assessment_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_assessment_sub_statuses`
--

DROP TABLE IF EXISTS `skill_assessment_sub_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill_assessment_sub_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_assessment_sub_statuses`
--

LOCK TABLES `skill_assessment_sub_statuses` WRITE;
/*!40000 ALTER TABLE `skill_assessment_sub_statuses` DISABLE KEYS */;
INSERT INTO `skill_assessment_sub_statuses` VALUES (1,1,'Result Received','2026-05-07 06:56:05'),(2,1,'Documents Verified','2026-05-07 06:56:05'),(3,4,'Documents Pending','2026-05-07 06:56:05'),(4,4,'Payment Pending','2026-05-07 06:56:05'),(5,4,'Payment Done','2026-05-07 06:56:05'),(6,4,'Result Awaited','2026-05-07 06:56:05'),(7,3,'Initial Inquiry','2026-05-07 06:56:05'),(8,3,'Counseling Done','2026-05-07 06:56:05');
/*!40000 ALTER TABLE `skill_assessment_sub_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statuses` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(50) NOT NULL,
  `requires_followup` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `status_name` (`status_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (1,'Interested',1),(2,'Not Interested',1),(3,'Warm Lead',1),(4,'Not Responding',1),(5,'Applied',1),(6,'Offer Received',1),(7,'Visa Filed',1),(8,'Visa Granted',1),(9,'Visa Rejected',1);
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_applications`
--

DROP TABLE IF EXISTS `student_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_applications` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `passport_name` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `spouse_accompanying` tinyint(1) DEFAULT '0',
  `address_country` varchar(100) DEFAULT NULL,
  `address_state` varchar(100) DEFAULT NULL,
  `address_suburb` varchar(100) DEFAULT NULL,
  `mobile_country_code` varchar(10) DEFAULT NULL,
  `contact1_code` varchar(10) DEFAULT NULL,
  `contact1` varchar(50) DEFAULT NULL,
  `contact1_whatsapp` tinyint(1) DEFAULT '0',
  `contact1_bot` tinyint(1) DEFAULT '0',
  `contact1_telegram` tinyint(1) DEFAULT '0',
  `phone_country_code` varchar(10) DEFAULT NULL,
  `contact2_code` varchar(10) DEFAULT NULL,
  `contact2` varchar(50) DEFAULT NULL,
  `contact2_whatsapp` tinyint(1) DEFAULT '0',
  `contact2_bot` tinyint(1) DEFAULT '0',
  `contact2_telegram` tinyint(1) DEFAULT '0',
  `email` varchar(100) DEFAULT NULL,
  `citizenship_country` varchar(100) DEFAULT NULL,
  `passport_country` varchar(100) DEFAULT NULL,
  `has_second_passport` tinyint(1) DEFAULT NULL,
  `second_passport_country` varchar(100) DEFAULT NULL,
  `highest_education` varchar(100) DEFAULT NULL,
  `education_field` varchar(100) DEFAULT NULL,
  `has_canadian_edu` tinyint(1) DEFAULT '0',
  `canadian_edu_level` varchar(100) DEFAULT NULL,
  `canadian_edu_field` varchar(100) DEFAULT NULL,
  `has_australian_edu` tinyint(1) DEFAULT '0',
  `australian_edu_level` varchar(100) DEFAULT NULL,
  `australian_edu_field` varchar(100) DEFAULT NULL,
  `has_aus_specialised_edu` tinyint(1) DEFAULT '0',
  `aus_specialised_edu_level` varchar(100) DEFAULT NULL,
  `aus_specialised_edu_field` varchar(100) DEFAULT NULL,
  `has_nz_edu` tinyint(1) DEFAULT '0',
  `nz_edu_level` varchar(100) DEFAULT NULL,
  `nz_edu_field` varchar(100) DEFAULT NULL,
  `has_work_experience` tinyint(1) DEFAULT '0',
  `total_work_experience` varchar(50) DEFAULT NULL,
  `canadian_work_years` varchar(50) DEFAULT NULL,
  `australian_work_years` varchar(50) DEFAULT NULL,
  `nz_work_years` varchar(50) DEFAULT NULL,
  `has_language_test` tinyint(1) DEFAULT '0',
  `has_language_interest` tinyint(1) DEFAULT '0',
  `language_test_type` varchar(50) DEFAULT NULL,
  `writing_score` varchar(20) DEFAULT NULL,
  `listening_score` varchar(20) DEFAULT NULL,
  `speaking_score` varchar(20) DEFAULT NULL,
  `reading_score` varchar(20) DEFAULT NULL,
  `has_admission_test` tinyint(1) DEFAULT '0',
  `has_admission_interest` tinyint(1) DEFAULT '0',
  `admission_test_type` varchar(50) DEFAULT NULL,
  `quant_score` varchar(20) DEFAULT NULL,
  `verbal_score` varchar(20) DEFAULT NULL,
  `data_insights_score` varchar(20) DEFAULT NULL,
  `spouse_age` int DEFAULT NULL,
  `spouse_has_language_test` tinyint(1) DEFAULT NULL,
  `spouse_edu_level` varchar(100) DEFAULT NULL,
  `spouse_canadian_edu` tinyint(1) DEFAULT '0',
  `spouse_canadian_edu_level` varchar(100) DEFAULT NULL,
  `spouse_canadian_edu_field` varchar(100) DEFAULT NULL,
  `spouse_australian_edu` tinyint(1) DEFAULT '0',
  `spouse_australian_edu_level` varchar(100) DEFAULT NULL,
  `spouse_australian_edu_field` varchar(100) DEFAULT NULL,
  `spouse_aus_specialised_edu` tinyint(1) DEFAULT '0',
  `spouse_aus_specialised_edu_level` varchar(100) DEFAULT NULL,
  `spouse_aus_specialised_edu_field` varchar(100) DEFAULT NULL,
  `spouse_work_exp` varchar(50) DEFAULT NULL,
  `spouse_canadian_work` varchar(50) DEFAULT NULL,
  `spouse_australian_work` varchar(50) DEFAULT NULL,
  `spouse_nz_work` varchar(50) DEFAULT NULL,
  `spouse_lang_test_type` varchar(50) DEFAULT NULL,
  `spouse_writing` varchar(20) DEFAULT NULL,
  `spouse_listening` varchar(20) DEFAULT NULL,
  `spouse_speaking` varchar(20) DEFAULT NULL,
  `spouse_reading` varchar(20) DEFAULT NULL,
  `has_skill_assessment` tinyint(1) DEFAULT NULL,
  `skill_assessment_interest` tinyint(1) DEFAULT NULL,
  `has_relatives` tinyint(1) DEFAULT '0',
  `relative_relationship` varchar(100) DEFAULT NULL,
  `relative_related_to` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `student_id_2` (`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_applications`
--

LOCK TABLES `student_applications` WRITE;
/*!40000 ALTER TABLE `student_applications` DISABLE KEYS */;
INSERT INTO `student_applications` VALUES (1,2,'Ashwini Suresh',35,NULL,'Female','Single',0,'','','',NULL,NULL,'9446885925',0,0,0,NULL,NULL,'8590217598',0,0,0,'ashwini1suresh@gmail.com','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,0,'','','','','',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-02-05 11:06:21','2026-02-06 07:04:44'),(2,7,'Test1',NULL,NULL,'Male','Single',0,'Australia','','',NULL,NULL,'5895557458',0,0,0,NULL,NULL,'56875656552',0,0,0,'Test1@gmail.com','Australia',NULL,NULL,NULL,'Bachelor','Business',0,'','',0,'','',0,'','',0,'','',1,'','','','',0,0,'','','','','',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-02-14 17:36:25','2026-02-23 15:14:48'),(3,10,'sudheesh',13,NULL,'Male','Married',1,'Latvia','200','200','+91',NULL,'9099090909',0,0,0,'+971',NULL,'64654654',0,0,0,'ggyuguyg@','Canada1','',0,'','Graduate Diploma','Engineering',1,'Advanced Diploma','Agriculture',1,'Advanced Diploma','Finance',0,'','',1,'','',1,'5','','2','',1,0,'IELTS','','','','',1,0,'GMAT','','','',30,NULL,'Bachelor',1,'','',1,'','',0,'','','','','','','IELTS','','','','',NULL,NULL,0,'','','2026-03-13 14:19:58','2026-04-23 05:51:03'),(4,11,'ESDFS',21,NULL,'Male','Single',0,'United Kingdom','jn','jn',NULL,NULL,'56323',0,0,0,NULL,NULL,'5464654646',0,0,0,'saaaaa@','United Kingdom',NULL,NULL,NULL,'Bachelor','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,0,'IELTS','','yes','yes','yes',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-18 03:30:32','2026-04-18 03:37:55'),(5,12,'riju',22,NULL,'Male','Single',0,'Australia','tayankari','dd',NULL,NULL,'888888888888',0,0,0,NULL,NULL,'',0,0,0,'sabu@1','',NULL,NULL,NULL,'Advanced Diploma','Accounting',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,0,'IELTS','','','','',1,0,'','dd','dd','dd',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-18 03:44:18','2026-04-20 10:46:33'),(6,15,'malavika',6,NULL,'Male','Single',0,'Australia','ygy','rdr',NULL,NULL,'15165165',0,0,0,NULL,NULL,'6+265265265',0,0,0,'ytfytf@','United Kingdom',NULL,NULL,NULL,'PhD','Information Technology',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,0,'IELTS','nu','uu','uh','hh',1,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-21 04:46:22','2026-04-21 04:46:22'),(7,16,'jiju',NULL,NULL,'Male','Single',0,'','','','+91',NULL,'4554149515',0,0,0,'+91',NULL,'51951',0,0,0,'sasas@','','',0,'','','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,0,'IELTS','','','','yguyg',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-21 05:56:37','2026-04-23 08:44:54'),(8,17,'max',22,NULL,'Male','Married',1,'India','Kerala','Kochi','+971',NULL,'0123456789',0,0,0,'+1',NULL,'0123456789',0,0,0,'max@gmail.comww','Canada1','',0,'','Associate Degree','Education & Teaching',0,'','',1,'Bachelor','Agriculture',0,'','',0,'','',1,'','','','',1,0,'','','','','',1,0,'','','','',21,NULL,'Bachelor',1,'','',1,'','',0,'','','','1','2','3','','','','','',NULL,NULL,0,'','','2026-04-24 04:51:24','2026-04-25 11:28:31'),(9,18,'rger',22,NULL,'Male','Married',1,'Canada1','cf','cc','+91',NULL,'4545453545',0,0,0,'+91',NULL,'5454543543',0,0,0,'454545','','',0,'','','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,0,'','','','','',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-25 05:33:44','2026-04-30 06:59:07'),(16,19,'test',20,NULL,'Female','Married',1,'UAE','Kerala','Kochi',NULL,'+1','6565156511',0,0,0,NULL,'+91','5733653453',0,0,0,'test@gmail.com','Singapore','',0,'','Graduate Certificate','Finance',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,25,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-04-29 07:02:36','2026-05-02 08:56:29'),(80,22,'tess',31,NULL,'Male','Married',1,'Malta','Kerala','Kochi',NULL,'+91','4352443544',0,0,0,NULL,'+1','5345235235',0,0,0,'3524','Poland','',0,'','Master','Law',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 07:49:42','2026-05-02 07:49:42'),(87,24,'kiro',21,NULL,'Male','Married',1,'Poland','Kerala','Kochi',NULL,'+971','2354542325',0,0,0,NULL,'+1','3454523524',0,0,0,'kiro@gmail.com','Poland','',0,'','High School','Hospitality',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:46:13','2026-05-02 09:46:13'),(88,25,'non',21,NULL,'Male','Single',0,'Malta','Kerala','Kochi',NULL,'+91','5234553254',0,0,0,NULL,'+91','2345243534',0,0,0,'edfr@gmail.com','Malta','',0,'','Graduate Diploma','Health & Medicine',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:48:51','2026-05-02 09:49:27'),(91,26,'qq',21,NULL,'Male','Married',1,'Malta','Kerala','Kochi',NULL,'+1','2543265634',0,0,0,NULL,'+91','5346546546',0,0,0,'12@gmail.com','New Zealand','',0,'','Master','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 10:36:20','2026-05-02 10:36:20'),(92,29,'adsd',21,NULL,'Male','Married',1,'France','Kerala','Kochi',NULL,'+1','3452324624',0,0,0,NULL,'+971','2345345245',0,0,0,'efw@gmail.com','Germany','',0,'','Graduate Diploma','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,32,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-04 04:04:25','2026-05-05 07:39:03'),(97,30,'aa',22,NULL,'Male','Married',1,'New Zealand','Kerala','Kochi',NULL,'+971','2545253425',0,0,0,NULL,'+971','5646453453',0,0,0,'aa@gmail.com','New Zealand','',0,'','High School','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,44,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-05 08:06:45','2026-05-05 08:06:45'),(98,31,'Mathew',25,NULL,'Male','Married',1,'Singapore','Kerala','Kochi',NULL,'+971','9099878987',1,1,0,NULL,'+971','2525452444',0,1,1,'mathew@gmail.com','Poland','',0,'','','',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,NULL,22,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,NULL,NULL,'2026-05-07 09:16:32','2026-05-08 08:16:04'),(133,32,'poo',12,NULL,'Male','Married',1,'Australia','Kerala','Kochi',NULL,'+971','1234567899',1,0,1,NULL,'+1','9876543210',1,0,1,'123@gmail.com','Canada1','',0,'','','',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,0,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,'2026-05-19 12:03:25','2026-05-19 12:03:25'),(196,35,'sq',2,NULL,'Male','Married',1,'Canada1','Kerala','Kochi',NULL,'+1','5346566363',1,0,1,NULL,'+971','4556346346',1,0,1,'211mail.com','France','',0,'','','',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,0,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,'2026-05-23 06:28:57','2026-05-23 07:39:16'),(209,36,'yss',21,NULL,'Male','Married',1,'Canada1','Kerala','Kochi',NULL,'+971','5635463345',1,0,1,NULL,'+971','4564536534',1,0,1,'1221mail.com','','',0,'','','',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,NULL,12,1,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,NULL,NULL,'2026-05-23 06:46:50','2026-05-23 06:46:50');
/*!40000 ALTER TABLE `student_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_coaching`
--

DROP TABLE IF EXISTS `student_coaching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_coaching` (
  `coaching_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `course` varchar(100) DEFAULT NULL,
  `batch` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`coaching_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_coaching_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_coaching`
--

LOCK TABLES `student_coaching` WRITE;
/*!40000 ALTER TABLE `student_coaching` DISABLE KEYS */;
INSERT INTO `student_coaching` VALUES (10,2,'mtecj','A!','2026-02-04 08:42:01'),(11,5,'','','2026-02-05 15:54:55'),(16,12,'','','2026-04-20 05:35:33'),(27,16,'','','2026-04-23 09:27:47'),(28,10,'test course','test','2026-04-23 09:38:12'),(36,17,'test course','inputted a','2026-04-25 05:31:39'),(37,19,'test course','testa','2026-04-29 06:40:28'),(38,19,'test course','testb','2026-04-29 06:40:28'),(44,24,'test course','dsfd','2026-05-02 09:41:55'),(45,26,'test course','343','2026-05-02 10:33:54'),(49,29,'test course','','2026-05-05 07:39:00'),(50,30,'test course','zcszc','2026-05-05 07:50:56'),(51,22,'test course','batch a','2026-05-05 10:21:50'),(65,31,'test course','2322344','2026-05-08 03:51:57'),(66,32,'course test 2','type in','2026-05-08 08:25:12'),(69,35,'course test 2','tytt','2026-05-20 11:55:46'),(88,36,'course test 2','fsa','2026-05-22 10:09:15');
/*!40000 ALTER TABLE `student_coaching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_migration`
--

DROP TABLE IF EXISTS `student_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_migration` (
  `migration_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`migration_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_migration_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_migration`
--

LOCK TABLES `student_migration` WRITE;
/*!40000 ALTER TABLE `student_migration` DISABLE KEYS */;
INSERT INTO `student_migration` VALUES (6,4,'Canada','Chef','Spouse Visa','2026-01-29 12:17:50'),(18,2,'France','Accountant','Tourist Visa','2026-02-04 08:42:01'),(19,2,'Canada','Software Engineer','Study Visa','2026-02-04 08:42:01'),(20,2,'Georgia','Chef','Spouse Visa','2026-02-04 08:42:01'),(21,5,'Ireland','Accountant','Spouse Visa','2026-02-05 15:54:55'),(28,7,'United Kingdom','Driver','Spouse Visa','2026-02-17 19:42:13'),(38,12,'','','','2026-04-20 05:35:33'),(51,15,'','','','2026-04-23 09:15:46'),(54,16,'','','','2026-04-23 09:27:47'),(55,10,'Canada','Accountant','Dependent Visa','2026-04-23 09:38:12'),(63,17,'Australia','Accountant','for studies','2026-04-25 05:31:39'),(64,19,'Australia','Accountant','for studies','2026-04-29 06:40:28'),(65,19,'Canada1','Chef','for studies','2026-04-29 06:40:28'),(71,24,'Germany','Chef','for studies','2026-05-02 09:41:55'),(72,26,'Germany','Accountant','for studies','2026-05-02 10:33:54'),(75,30,'Canada1','Chef','for studies','2026-05-05 07:50:56'),(76,22,'Australia','Chef','for studies','2026-05-05 10:21:50'),(83,31,'Australia','Accountant','for studies','2026-05-08 03:51:57'),(84,32,'Canada1','Accountant','for studies','2026-05-08 08:25:12'),(87,35,'France','Accountant','for studies','2026-05-20 11:55:46'),(110,36,'Canada1','Chef','for studies','2026-05-22 10:09:15');
/*!40000 ALTER TABLE `student_migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_registrations`
--

DROP TABLE IF EXISTS `student_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_registrations` (
  `registration_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `passport_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `spouse_accompanying` tinyint(1) DEFAULT '0',
  `address_country` varchar(100) DEFAULT NULL,
  `address_state` varchar(100) DEFAULT NULL,
  `address_suburb` varchar(100) DEFAULT NULL,
  `address_postcode` varchar(20) DEFAULT NULL,
  `contact1_code` varchar(10) DEFAULT NULL,
  `contact1` varchar(50) DEFAULT NULL,
  `contact1_whatsapp` tinyint(1) DEFAULT '0',
  `contact1_bot` tinyint(1) DEFAULT '0',
  `contact1_telegram` tinyint(1) DEFAULT '0',
  `contact2_code` varchar(10) DEFAULT NULL,
  `contact2` varchar(50) DEFAULT NULL,
  `contact2_whatsapp` tinyint(1) DEFAULT '0',
  `contact2_bot` tinyint(1) DEFAULT '0',
  `contact2_telegram` tinyint(1) DEFAULT '0',
  `email` varchar(100) DEFAULT NULL,
  `citizenship_country` varchar(100) DEFAULT NULL,
  `passport_country` varchar(100) DEFAULT NULL,
  `has_second_passport` tinyint(1) DEFAULT NULL,
  `second_passport_country` varchar(100) DEFAULT NULL,
  `highest_education` varchar(100) DEFAULT NULL,
  `education_field` varchar(100) DEFAULT NULL,
  `has_canadian_edu` tinyint(1) DEFAULT '0',
  `canadian_edu_level` varchar(100) DEFAULT NULL,
  `canadian_edu_field` varchar(100) DEFAULT NULL,
  `has_australian_edu` tinyint(1) DEFAULT '0',
  `australian_edu_level` varchar(100) DEFAULT NULL,
  `australian_edu_field` varchar(100) DEFAULT NULL,
  `has_aus_specialised_edu` tinyint(1) DEFAULT '0',
  `aus_specialised_edu_level` varchar(100) DEFAULT NULL,
  `aus_specialised_edu_field` varchar(100) DEFAULT NULL,
  `has_nz_edu` tinyint(1) DEFAULT '0',
  `nz_edu_level` varchar(100) DEFAULT NULL,
  `nz_edu_field` varchar(100) DEFAULT NULL,
  `has_work_experience` tinyint(1) DEFAULT '0',
  `total_work_experience` varchar(50) DEFAULT NULL,
  `canadian_work_years` varchar(50) DEFAULT NULL,
  `australian_work_years` varchar(50) DEFAULT NULL,
  `nz_work_years` varchar(50) DEFAULT NULL,
  `has_language_test` tinyint(1) DEFAULT '0',
  `has_language_interest` tinyint(1) DEFAULT '0',
  `language_test_type` varchar(50) DEFAULT NULL,
  `writing_score` varchar(20) DEFAULT NULL,
  `listening_score` varchar(20) DEFAULT NULL,
  `speaking_score` varchar(20) DEFAULT NULL,
  `reading_score` varchar(20) DEFAULT NULL,
  `has_admission_test` tinyint(1) DEFAULT '0',
  `has_admission_interest` tinyint(1) DEFAULT '0',
  `admission_test_type` varchar(50) DEFAULT NULL,
  `quant_score` varchar(20) DEFAULT NULL,
  `verbal_score` varchar(20) DEFAULT NULL,
  `data_insights_score` varchar(20) DEFAULT NULL,
  `spouse_age` int DEFAULT NULL,
  `spouse_has_language_test` tinyint(1) DEFAULT NULL,
  `spouse_edu_level` varchar(100) DEFAULT NULL,
  `spouse_canadian_edu` tinyint(1) DEFAULT '0',
  `spouse_canadian_edu_level` varchar(100) DEFAULT NULL,
  `spouse_canadian_edu_field` varchar(100) DEFAULT NULL,
  `spouse_australian_edu` tinyint(1) DEFAULT '0',
  `spouse_australian_edu_level` varchar(100) DEFAULT NULL,
  `spouse_australian_edu_field` varchar(100) DEFAULT NULL,
  `spouse_aus_specialised_edu` tinyint(1) DEFAULT '0',
  `spouse_aus_specialised_edu_level` varchar(100) DEFAULT NULL,
  `spouse_aus_specialised_edu_field` varchar(100) DEFAULT NULL,
  `spouse_work_exp` varchar(50) DEFAULT NULL,
  `spouse_canadian_work` varchar(50) DEFAULT NULL,
  `spouse_australian_work` varchar(50) DEFAULT NULL,
  `spouse_nz_work` varchar(50) DEFAULT NULL,
  `spouse_lang_test_type` varchar(50) DEFAULT NULL,
  `spouse_writing` varchar(20) DEFAULT NULL,
  `spouse_listening` varchar(20) DEFAULT NULL,
  `spouse_speaking` varchar(20) DEFAULT NULL,
  `spouse_reading` varchar(20) DEFAULT NULL,
  `has_skill_assessment` tinyint(1) DEFAULT NULL,
  `skill_assessment_interest` tinyint(1) DEFAULT NULL,
  `has_relatives` tinyint(1) DEFAULT '0',
  `relative_relationship` varchar(100) DEFAULT NULL,
  `relative_related_to` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`registration_id`),
  UNIQUE KEY `student_id_2` (`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_registrations_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_registrations`
--

LOCK TABLES `student_registrations` WRITE;
/*!40000 ALTER TABLE `student_registrations` DISABLE KEYS */;
INSERT INTO `student_registrations` VALUES (1,11,'ESDFS',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,NULL,'56323',0,0,0,NULL,'',0,0,0,'','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,0,'','','','','',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-18 03:35:00','2026-04-18 03:35:00'),(2,12,'riju',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,NULL,'7777777777',0,0,0,NULL,'',0,0,0,'sabu@','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,0,'','','','','',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-18 03:45:29','2026-04-18 03:45:29'),(3,10,'sudheesh',NULL,NULL,NULL,NULL,'Male','Single',0,'France','255','255',NULL,NULL,'9099090909',0,0,0,NULL,'',0,0,0,'','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,0,'','','','','',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-20 09:50:29','2026-04-20 09:50:29'),(4,16,'jiju',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,NULL,'4554149515',0,0,0,NULL,'51951',0,0,0,'sasas@','','',0,'','','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,0,'IELTS','','','','yguyg',0,0,'','','','',NULL,NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',NULL,NULL,0,'','','2026-04-21 05:56:59','2026-04-21 05:56:59'),(5,17,'max','max','ver',1,'2025-04-01','Male','Married',1,'India','Kerala','Kochi','10','+971','0123456789',0,0,0,'+91','0123456789',0,0,0,'max@gmail.comww','Canada1','Germany',1,'New Zealand','Associate Degree','Education & Teaching',0,'','',1,'Bachelor','Agriculture',0,'','',0,'','',1,'','','','',1,0,'','','','','',1,0,'','','','',21,NULL,'Bachelor',1,'','',1,'','',0,'','','','1','2','3','IELTS','','','','',NULL,NULL,0,'','','2026-04-25 11:07:15','2026-04-29 05:37:02'),(10,19,'test','test n','x',2,'2024-01-02','Female','Married',1,'UAE','Kerala','Kochi','123','+1','6565156511',0,0,0,'+91','5733653453',0,0,0,'test@gmail.com','Singapore','France',1,'New Zealand','Graduate Certificate','Finance',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,25,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 08:58:30','2026-05-02 09:12:23'),(12,24,'kiro','kiro','x',7,'2019-01-02','Male','Married',1,'Poland','Kerala','Kochi','123','+971','2354542325',0,0,0,'+1','3454523524',0,0,0,'kiro@gmail.com','Poland','Germany',1,'UAE','High School','Hospitality',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:47:21','2026-05-02 09:47:21'),(13,25,'non','nn','n',0,'2026-04-29','Male','Single',0,'Malta','Kerala','Kochi','nn','+91','5234553254',0,0,0,'+91','2345243534',0,0,0,'edfr@gmail.com','Malta','Malta',1,'Ireland','Graduate Diploma','Health & Medicine',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:49:42','2026-05-02 09:49:49'),(15,26,'qq','q','z',6,'2020-01-28','Male','Married',1,'Malta','Kerala','Kochi','123','+1','2543265634',0,0,0,'+91','5346546546',0,0,0,'12@gmail.com','New Zealand','Australia',1,'Poland','Master','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 10:37:01','2026-05-02 10:37:01'),(16,29,'adsd','fas','afg',0,'2026-05-01','Male','Married',1,'France','Kerala','Kochi','123','+1','3452324624',0,0,0,'+971','2345345245',0,0,0,'efw@gmail.com','Germany','France',1,'New Zealand','Graduate Diploma','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,32,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-04 04:04:57','2026-05-05 07:39:06'),(19,30,'aa','aa','x',0,'2026-05-01','Male','Married',1,'New Zealand','Kerala','Kochi','123','+971','2545253425',0,0,0,'+971','5646453453',0,0,0,'aa@gmail.com','New Zealand','Georgia',1,'Malta','High School','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,44,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-05 08:07:29','2026-05-05 08:07:29'),(22,31,'Mathew','Mathew','c',24,'2002-02-02','Male','Married',1,'Malta','Kerala','Kochi','123','+971','9099878987',1,1,1,'+971','2525452444',1,1,1,'mathew@gmail.com','Poland','Poland',0,'','Advanced Diploma','Dentistry',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,NULL,22,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,NULL,NULL,'2026-05-07 10:51:37','2026-05-08 08:16:26'),(57,35,'sq','sq','',2,NULL,'Male','Married',1,'Canada1','Kerala','Kochi','','+1','5346566363',1,0,1,'+971','4556346346',1,0,1,'211mail.com','France','France',0,'','Associate Degree','Architecture',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,21,0,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,'2026-05-23 07:39:39','2026-05-23 07:39:39');
/*!40000 ALTER TABLE `student_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_study`
--

DROP TABLE IF EXISTS `student_study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_study` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `intake` varchar(50) DEFAULT NULL,
  `year` year DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`program_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_study_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_study`
--

LOCK TABLES `student_study` WRITE;
/*!40000 ALTER TABLE `student_study` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_study` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_study_programs`
--

DROP TABLE IF EXISTS `student_study_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_study_programs` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `intake` varchar(50) DEFAULT NULL,
  `year` year DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`program_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_study_programs_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_study_programs`
--

LOCK TABLES `student_study_programs` WRITE;
/*!40000 ALTER TABLE `student_study_programs` DISABLE KEYS */;
INSERT INTO `student_study_programs` VALUES (6,4,'Germany','Bachelor','Business','April',2025,'2026-01-29 12:17:50'),(7,4,'Australia','Diploma','Engineering','August',2026,'2026-01-29 12:17:50'),(20,2,'Australia','Bachelor','Engineering','December',2026,'2026-02-04 08:42:01'),(21,2,'Canada','Master','Business','August',2025,'2026-02-04 08:42:01'),(22,5,'Georgia','High School','Hospitality','February',2027,'2026-02-05 15:54:55'),(23,5,'France','Graduate Certificate','Hospitality','February',2026,'2026-02-05 15:54:55'),(35,6,'Singapore','PG Diploma','Business','October',2024,'2026-02-09 10:08:16'),(37,7,'Poland','Master','Engineering','November',2025,'2026-02-17 19:42:12'),(38,7,'Georgia','PG Diploma','Business','November',2026,'2026-02-17 19:42:12'),(39,7,'Ireland','Bachelor','Business','September',2024,'2026-02-17 19:42:13'),(54,12,'Australia','Certificate IV','Agriculture','April',2025,'2026-04-20 05:35:33'),(74,15,'Australia','Advanced Diploma','Agriculture','April',2024,'2026-04-23 09:15:46'),(79,16,'Australia','Advanced Diploma','Accounting','April',2025,'2026-04-23 09:27:47'),(80,10,'Australia','Bachelor','Business','August',2024,'2026-04-23 09:38:12'),(81,10,'France','Bachelor','Engineering','September',2024,'2026-04-23 09:38:12'),(89,17,'India','Master','Computing','April',2024,'2026-04-25 05:31:39'),(90,19,'Australia','Advanced Diploma','Accounting','April',2024,'2026-04-29 06:40:28'),(91,19,'Canada1','Associate Degree','Accounting','August',2025,'2026-04-29 06:40:28'),(97,24,'France','Advanced Diploma','Accounting','April',2025,'2026-05-02 09:41:55'),(98,26,'Australia','Advanced Diploma','Accounting','April',2024,'2026-05-02 10:33:54'),(102,29,'Australia','','','April',2024,'2026-05-05 07:39:00'),(103,30,'Australia','Associate Degree','Agriculture','August',2025,'2026-05-05 07:50:56'),(104,22,'Canada1','Advanced Diploma','Accounting','April',2024,'2026-05-05 10:21:50'),(120,31,'Canada1','Associate Degree','Architecture','April',2024,'2026-05-08 03:51:57'),(121,32,'Australia','Advanced Diploma','Accounting','April',2025,'2026-05-08 08:25:12'),(124,35,'Australia','Advanced Diploma','Accounting','April',2025,'2026-05-20 11:55:46'),(145,36,'Australia','Advanced Diploma','Accounting','April',2025,'2026-05-22 10:09:15');
/*!40000 ALTER TABLE `student_study_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_visa`
--

DROP TABLE IF EXISTS `student_visa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_visa` (
  `visa_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`visa_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_visa_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_visa`
--

LOCK TABLES `student_visa` WRITE;
/*!40000 ALTER TABLE `student_visa` DISABLE KEYS */;
INSERT INTO `student_visa` VALUES (3,4,'Georgia','Study Visa','2026-01-29 12:17:50'),(4,4,'Canada','Study Visa','2026-01-29 12:17:50'),(9,2,'India','Dependent Visa','2026-02-04 08:42:01'),(19,12,'','','2026-04-20 05:35:33'),(30,16,'','','2026-04-23 09:27:47'),(31,10,'India','Dependent Visa','2026-04-23 09:38:12'),(35,17,'Canada1','Spouse Visa','2026-04-25 05:31:39'),(36,19,'Australia','Dependent Visa','2026-04-29 06:40:28'),(37,19,'Canada1','Spouse Visa','2026-04-29 06:40:28'),(43,24,'Australia','Spouse Visa','2026-05-02 09:41:55'),(44,26,'Australia','Spouse Visa','2026-05-02 10:33:54'),(48,29,'Georgia','','2026-05-05 07:39:00'),(49,30,'Canada1','Dependent Visa','2026-05-05 07:50:56'),(50,22,'Canada1','Dependent Visa','2026-05-05 10:21:50'),(64,31,'Canada1','Dependent Visa','2026-05-08 03:51:57'),(65,32,'France','Dependent Visa','2026-05-08 08:25:12'),(68,35,'Canada1','Dependent Visa','2026-05-20 11:55:46'),(87,36,'France','Spouse Visa','2026-05-22 10:09:15');
/*!40000 ALTER TABLE `student_visa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_work`
--

DROP TABLE IF EXISTS `student_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_work` (
  `work_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`work_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_work_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_work`
--

LOCK TABLES `student_work` WRITE;
/*!40000 ALTER TABLE `student_work` DISABLE KEYS */;
INSERT INTO `student_work` VALUES (3,4,'France','Civil Engineer','2026-01-29 12:17:50'),(8,2,'Singapore','Civil Engineer','2026-02-04 08:42:01'),(9,5,'France','Accountant','2026-02-05 15:54:55'),(18,12,'','','2026-04-20 05:35:33'),(34,15,'Australia','Accountant','2026-04-23 09:15:46'),(37,16,'Canada1','Chef','2026-04-23 09:27:47'),(38,10,'','','2026-04-23 09:38:12'),(43,19,'Australia','Accountant','2026-04-29 06:40:28'),(44,19,'Canada1','Chef','2026-04-29 06:40:28'),(50,24,'France','Chef','2026-05-02 09:41:55'),(51,26,'Canada1','Chef','2026-05-02 10:33:54'),(55,29,'Canada1','','2026-05-05 07:39:00'),(56,30,'Canada1','Chef','2026-05-05 07:50:56'),(57,22,'Canada1','Civil Engineer','2026-05-05 10:21:50'),(71,31,'Canada1','Civil Engineer','2026-05-08 03:51:57'),(72,32,'Georgia','Accountant','2026-05-08 08:25:12'),(75,35,'Georgia','Civil Engineer','2026-05-20 11:55:46'),(92,36,'Australia','Chef','2026-05-22 10:09:15');
/*!40000 ALTER TABLE `student_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `student_name` varchar(100) NOT NULL,
  `mobile_country_code` varchar(10) DEFAULT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `phone_country_code` varchar(10) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `whatsapp` tinyint(1) DEFAULT '0',
  `botim` tinyint(1) DEFAULT '0',
  `telegram` tinyint(1) DEFAULT '0',
  `phone_whatsapp` tinyint(1) DEFAULT '0',
  `phone_botim` tinyint(1) DEFAULT '0',
  `phone_telegram` tinyint(1) DEFAULT '0',
  `enquiry_source` varchar(100) DEFAULT NULL,
  `study_interested` tinyint(1) DEFAULT '0',
  `migration_interested` tinyint(1) DEFAULT '0',
  `coaching_interested` tinyint(1) DEFAULT '0',
  `visa_interested` tinyint(1) DEFAULT '0',
  `work_interested` tinyint(1) DEFAULT '0',
  `branch_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `is_registered` tinyint(1) DEFAULT '0',
  `current_status` varchar(50) DEFAULT 'New Lead',
  `last_remark` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_id`),
  KEY `branch_id` (`branch_id`),
  KEY `created_by` (`created_by`),
  KEY `assigned_to` (`assigned_to`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  CONSTRAINT `students_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `students_ibfk_3` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (2,'Ashwini Suresh','+91','9446885925','+91','8590217598','ashwini1suresh@gmail.com',0,0,0,0,0,0,'fb',1,1,1,1,1,1,1,1,0,'Applied','applied student','2026-01-29 06:39:39'),(4,'test student','+91','68995875822','+91','78586922558','',0,1,1,1,0,0,'',1,1,0,1,1,1,1,1,0,'Interested','intrested need o followup','2026-01-29 12:17:50'),(5,'test data','+91','9855600245','+91','6589555895','testdata@gmail.com',1,1,0,0,1,1,'facebook',1,1,0,0,1,1,1,1,0,'Interested','tested data','2026-01-29 12:28:17'),(6,'L1','+91','9099090909','+91','','',1,1,0,0,0,0,'',1,0,0,0,0,1,1,1,0,'Interested','es','2026-02-08 07:45:30'),(7,'Test1','+91','5895557458','+91','56875656552','Test1@gmail.com',1,0,1,0,0,0,'',1,1,0,0,0,1,1,1,0,'Interested','asdasa','2026-02-09 05:02:27'),(10,'sudheesh','+91','9099090909','+91','','',1,1,1,0,0,0,'',1,0,1,1,1,1,1,1,0,'Interested','saaa','2026-02-11 16:30:47'),(11,'ESDFS','+91','56323','+91','','',0,0,0,0,0,0,'',0,0,0,0,0,1,1,3,0,'','Dwdwdawd','2026-04-17 09:27:45'),(12,'riju','+91','9999999','+91','','sabu@',0,0,0,0,0,0,'ig',1,1,1,1,1,1,1,NULL,0,'Applied','good','2026-04-18 03:43:20'),(15,'malavika','+91','15165165','+91','','ytfytf@',0,0,0,0,0,0,'asdf',1,1,0,0,1,1,1,NULL,0,'New Lead',NULL,'2026-04-21 04:45:16'),(16,'jiju','+91','4554149515','+91','51951','sasas@',0,0,0,0,0,0,'ig',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-04-21 05:27:53'),(17,'max','+91','0123456789','+91','0123456789','max123',1,1,1,1,1,1,'youtube',1,1,1,1,0,1,1,3,0,'Interested','remark test','2026-04-23 11:21:57'),(18,'rger','+91','4545453545','+91','5454543543','454545',0,0,0,0,0,0,'54545454545',0,0,0,0,0,1,1,NULL,0,'New Lead',NULL,'2026-04-25 05:29:00'),(19,'test','+971','6565156511','+1','5733653453','emailtest',1,1,1,1,1,1,'test',1,1,1,1,1,1,1,3,0,'Interested','remark test','2026-04-29 06:40:28'),(22,'tess','+91','4352443544','+1','5345235235','3524',0,0,0,0,0,0,'asd',1,1,1,1,1,1,1,3,0,'Interested','remarks tess','2026-04-30 10:00:00'),(24,'kiro','+971','2354542325','+1','3454523524','123',1,1,1,1,1,1,'as',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-05-02 09:41:55'),(25,'non','+91','5234553254','+91','2345243534','',0,0,0,0,0,0,'non',0,0,0,0,0,1,1,NULL,0,'New Lead',NULL,'2026-05-02 09:48:08'),(26,'qq','+91','2543265634','+91','5346546546','4545',0,0,0,0,0,0,'qq',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-05-02 10:33:54'),(29,'adsd','+91','3452324624','+971','2345345245','arf',0,0,0,0,0,0,'ASD',1,0,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-05-04 04:02:55'),(30,'aa','+971','2545253425','+971','5646453453','aa',1,1,1,1,1,1,'aa',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-05-05 07:50:56'),(31,'Mathew','+971','9099878987','+971','2525452444','123',1,0,1,1,1,1,'youtube',1,1,1,1,1,1,1,3,0,'Interested','h','2026-05-05 10:24:20'),(32,'poo','+971','1234567899','+1','9876543210','123',1,0,1,1,0,1,'email',1,1,1,1,1,1,1,1,0,'Interested','remark','2026-05-08 08:25:12'),(35,'sq','+1','5346566363','+971','4556346346','123',1,0,1,1,0,1,'sa',1,1,1,1,1,1,1,1,0,'Applied','rmk 11','2026-05-20 11:55:46'),(36,'yss','+971','5635463345','+971','4564536534','456',1,0,1,1,0,1,'adsa',1,1,1,1,1,1,1,NULL,0,'Applied','Initial Status: Applied','2026-05-20 12:38:30');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_fields`
--

DROP TABLE IF EXISTS `study_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_fields` (
  `field_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_fields`
--

LOCK TABLES `study_fields` WRITE;
/*!40000 ALTER TABLE `study_fields` DISABLE KEYS */;
INSERT INTO `study_fields` VALUES (7,'Accounting'),(8,'Agriculture'),(9,'Architecture'),(10,'Arts & Humanities'),(11,'Built Environment'),(3,'Business'),(12,'Communications'),(13,'Computing'),(14,'Creative Arts'),(15,'Dentistry'),(16,'Education & Teaching'),(1,'Engineering'),(17,'Environmental Science'),(18,'Finance'),(19,'Health & Medicine'),(5,'Hospitality'),(4,'Information Technology'),(20,'Law'),(21,'Management'),(22,'Marketing'),(23,'Mathematics'),(24,'Media'),(2,'Nursing'),(25,'Pharmacy'),(26,'Product Design'),(27,'Psychology'),(6,'Science'),(28,'Social Work'),(29,'Tourism & Travel');
/*!40000 ALTER TABLE `study_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_intakes`
--

DROP TABLE IF EXISTS `study_intakes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_intakes` (
  `intake_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`intake_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_intakes`
--

LOCK TABLES `study_intakes` WRITE;
/*!40000 ALTER TABLE `study_intakes` DISABLE KEYS */;
INSERT INTO `study_intakes` VALUES (4,'April'),(8,'August'),(12,'December'),(2,'February'),(1,'January'),(7,'July'),(6,'June'),(3,'March'),(5,'May'),(11,'November'),(10,'October'),(9,'September');
/*!40000 ALTER TABLE `study_intakes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggested_programs`
--

DROP TABLE IF EXISTS `suggested_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suggested_programs` (
  `sug_program_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `issystem` tinyint(1) DEFAULT '0',
  `program_type` varchar(50) DEFAULT NULL,
  `program` varchar(255) DEFAULT NULL,
  `applied_for` varchar(255) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `details2` varchar(255) DEFAULT NULL,
  `details3` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `sub_status` varchar(100) DEFAULT NULL,
  `remarks` text,
  `is_selected` tinyint(1) DEFAULT '0',
  `branch_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  PRIMARY KEY (`sug_program_id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `suggested_programs_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2715 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggested_programs`
--

LOCK TABLES `suggested_programs` WRITE;
/*!40000 ALTER TABLE `suggested_programs` DISABLE KEYS */;
INSERT INTO `suggested_programs` VALUES (60,1,0,NULL,'STUDY Poland',NULL,'Bachelor Engineering - December 2026',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(61,1,0,NULL,'STUDY Canada',NULL,'Master Business - August 2025',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(62,1,0,NULL,'MIGRATION France',NULL,'Accountant - Tourist Visa',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(63,1,0,NULL,'MIGRATION Canada',NULL,'Software Engineer - Study Visa',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(64,1,0,NULL,'MIGRATION Georgia',NULL,'Chef - Spouse Visa',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(65,1,0,NULL,'VISA India',NULL,'Dependent Visa',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(66,1,0,NULL,'WORK Singapore',NULL,'Civil Engineer',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(67,1,0,NULL,'COACHING',NULL,'mtecj - A!',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(68,1,0,NULL,'STUDY United Kingdom',NULL,'High School Hospitality - December 2026',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(69,1,0,NULL,'MIGRATION France',NULL,'Civil Engineer - Spouse Visa',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(70,1,0,NULL,'WORK India',NULL,'Driver',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(150,2,0,NULL,'STUDY Latvia',NULL,'Diploma Science - -',NULL,NULL,'one','one sub','',1,1,1,3),(151,2,0,NULL,'STUDY USA',NULL,'PhD Nursing - September 2024',NULL,NULL,'Offer Received','','',1,1,1,1),(152,2,0,NULL,'VISA',NULL,'',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(153,2,0,NULL,'MIGRATION UAE',NULL,'-',NULL,NULL,'two','two sub','',1,NULL,NULL,NULL),(154,2,0,NULL,'STUDY USA',NULL,'PhD Nursing - September 2028',NULL,NULL,'Offer Received','','',1,1,4,NULL),(155,2,0,NULL,'COACHING',NULL,'',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(156,2,0,NULL,'',NULL,'',NULL,NULL,'Application Status','','',1,NULL,NULL,NULL),(329,4,0,NULL,'STUDY USA',NULL,'Secondary Education Information Technology - October 2030',NULL,NULL,'one','one sub','64',1,NULL,NULL,NULL),(349,5,0,NULL,'STUDY Australia',NULL,'Certificate III IV Agriculture - April 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(362,6,0,NULL,'STUDY Australia',NULL,'Advanced Diploma Agriculture - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(363,6,0,NULL,'Australia',NULL,'Accountant',NULL,NULL,'','','',1,NULL,NULL,NULL),(416,3,0,NULL,'STUDY Canada',NULL,'Bachelor Business - August 2024',NULL,NULL,'one','one sub','',1,1,NULL,NULL),(417,3,0,NULL,'',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(418,3,0,NULL,'',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(419,3,0,NULL,'MIGRATION Australia',NULL,'-',NULL,NULL,'','','',1,NULL,NULL,NULL),(420,3,0,NULL,'MIGRATION Canada',NULL,'-',NULL,NULL,'','','',1,NULL,NULL,NULL),(421,3,0,NULL,'MIGRATION India',NULL,'-',NULL,NULL,'','','',1,NULL,NULL,NULL),(422,7,0,NULL,'STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(423,7,0,NULL,'Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(767,8,0,NULL,'STUDY India',NULL,'Master Computing - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(768,8,0,NULL,'Australia',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(769,8,0,NULL,'Canada1',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(770,8,0,NULL,'France',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(771,8,0,NULL,'COACHING',NULL,'test course - inputted a',NULL,NULL,'','','',1,NULL,NULL,NULL),(772,8,0,NULL,'MIGRATION Germany',NULL,'Marketing Specialist - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1314,80,0,'STUDY','STUDY Australia',NULL,'Bachelor Agriculture - August 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(1315,80,0,'MIGRATION','Australia',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1316,80,0,'VISA','Canada1',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1317,80,0,'WORK','Canada1',NULL,'Civil Engineer',NULL,NULL,'','','',1,NULL,NULL,NULL),(1318,80,0,'COACHING','COACHING',NULL,'test course - batch a',NULL,NULL,'','','',1,NULL,NULL,NULL),(1349,16,0,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(1350,16,0,'STUDY','STUDY Canada1',NULL,'Associate Degree Accounting - August 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(1351,16,0,'OTHER','Australia',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1352,16,0,'OTHER','Canada1',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1353,16,0,'OTHER','Australia',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1354,16,0,'OTHER','Canada1',NULL,'Spouse Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1355,16,0,'OTHER','Australia',NULL,'Accountant',NULL,NULL,'','','',1,NULL,NULL,NULL),(1356,16,0,'OTHER','Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(1357,16,0,'COACHING','COACHING',NULL,'test course - testa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1358,16,0,'COACHING','COACHING',NULL,'test course - testb',NULL,NULL,'','','',1,NULL,NULL,NULL),(1369,87,0,'STUDY','STUDY France',NULL,'Advanced Diploma Accounting - April 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(1370,87,0,'MIGRATION','Germany',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1371,87,0,'VISA','Australia',NULL,'Spouse Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1372,87,0,'WORK','France',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(1373,87,0,'COACHING','COACHING',NULL,'test course - dsfd',NULL,NULL,'','','',1,NULL,NULL,NULL),(1375,88,0,'STUDY','STUDY Poland',NULL,'Graduate Certificate Creative Arts - July 2027',NULL,NULL,'one','one sub','',1,1,1,1),(1376,91,0,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(1377,91,0,'MIGRATION','Germany',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1378,91,0,'VISA','Australia',NULL,'Spouse Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1379,91,0,'WORK','Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(1380,91,0,'COACHING','COACHING',NULL,'test course - 343',NULL,NULL,'','','',1,NULL,NULL,NULL),(1398,92,0,'STUDY','STUDY Australia',NULL,'- April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(1399,92,0,'VISA','Georgia',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(1400,92,0,'WORK','Canada1',NULL,'',NULL,NULL,'','','',1,NULL,NULL,NULL),(1401,92,0,'COACHING','COACHING',NULL,'test course - ',NULL,NULL,'','','',1,NULL,NULL,NULL),(1402,97,0,'STUDY','STUDY Australia',NULL,'Associate Degree Agriculture - August 2025',NULL,NULL,'','','',1,NULL,NULL,NULL),(1403,97,0,'MIGRATION','Canada1',NULL,'Chef - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1404,97,0,'VISA','Canada1',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1405,97,0,'WORK','Canada1',NULL,'Chef',NULL,NULL,'','','',1,NULL,NULL,NULL),(1406,97,0,'COACHING','COACHING',NULL,'test course - zcszc',NULL,NULL,'','','',1,NULL,NULL,NULL),(1482,98,0,'STUDY','STUDY France',NULL,'Associate Degree Architecture - April 2024',NULL,NULL,'','','',1,NULL,NULL,NULL),(1483,98,0,'MIGRATION','Australia',NULL,'Accountant - for studies',NULL,NULL,'','','',1,NULL,NULL,NULL),(1484,98,0,'VISA','Canada1',NULL,'Dependent Visa',NULL,NULL,'','','',1,NULL,NULL,NULL),(1485,98,0,'WORK','Canada1',NULL,'Civil Engineer',NULL,NULL,'','','',1,NULL,NULL,NULL),(1486,98,0,'COACHING','COACHING',NULL,'test course - 2322344',NULL,NULL,'','','',1,NULL,NULL,NULL),(1707,133,0,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025',NULL,NULL,'one','one sub','1',1,1,1,3),(1708,133,0,'MIGRATION','Canada1',NULL,'Accountant - for studies',NULL,NULL,'two','two sub','2',1,2,NULL,NULL),(1709,133,0,'VISA','VISA France',NULL,'Dependent Visa - x1',NULL,NULL,'one','one sub','3',1,2,1,NULL),(1710,133,0,'WORK','WORK Georgia',NULL,'Accountant - x2',NULL,NULL,'one','one sub','4',1,1,1,3),(1711,133,0,'COACHING','COACHING',NULL,'course test 2 - type in',NULL,NULL,'two','two sub','5',1,2,2,NULL),(1712,133,1,'OTHER','Skill Assessment',NULL,'1',NULL,NULL,'one','one sub','6',1,3,1,NULL),(1713,133,1,'OTHER','Language Test',NULL,'2',NULL,NULL,'one','one sub','7',1,1,1,1),(1714,133,1,'OTHER','Admission Test',NULL,'3',NULL,NULL,'one','one sub','8',1,2,2,NULL),(1715,133,1,'OTHER','Spouse Language Test',NULL,'4',NULL,NULL,'two','two sub','9',1,2,1,NULL),(1716,133,0,'OTHER','Language Test',NULL,'5',NULL,NULL,'two','two sub','10',0,3,1,NULL),(1717,133,0,'OTHER','Skill Assessment',NULL,'6',NULL,NULL,'one','one sub','11',1,1,2,NULL),(2431,209,0,'STUDY','STUDY Australia','Advanced Diploma','Accounting','April','2025',NULL,NULL,NULL,2,NULL,NULL,NULL),(2432,209,0,'MIGRATION','MIGRATION Canada1','Chef','for studies',NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2433,209,0,'VISA','VISA France','Spouse Visa',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2434,209,0,'WORK','WORK Australia','Chef',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2435,209,0,'COACHING','COACHING','course test 2','fsa',NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2436,209,0,'Language Test','Language Test','CELPIP',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2437,209,0,'Admission Test','Admission Test','adm test',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2438,209,0,'Spouse Language Test','Spouse Language Test','CELPIP',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2439,209,0,'Skill Assessment','Skill Assessment','Engineers Australia',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2440,209,0,'EDUCATION LOAN','EDUCATION LOAN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2441,209,0,'TICKETING','TICKETING',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2442,209,0,'FOREX','FOREX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL),(2699,196,0,'STUDY','Australia','Advanced Diploma','Accounting','April','2025',NULL,NULL,NULL,2,NULL,NULL,NULL),(2700,196,0,'MIGRATION','France','Accountant','for studies','1','1',NULL,NULL,NULL,2,NULL,NULL,NULL),(2701,196,0,'VISA','Canada1','Dependent Visa','1','2','2',NULL,NULL,NULL,2,NULL,NULL,NULL),(2702,196,0,'WORK','Georgia','Civil Engineer','2','3','3',NULL,NULL,NULL,2,NULL,NULL,NULL),(2703,196,0,'COACHING','COACHING','course test 2','3','4','4',NULL,NULL,NULL,2,NULL,NULL,NULL),(2704,196,1,'Spouse Language Test','IELTS','1','4','5','5',NULL,NULL,NULL,0,NULL,NULL,NULL),(2705,196,1,'Admission Test','GMAT Focus','2','5','6','6',NULL,NULL,NULL,1,NULL,NULL,NULL),(2706,196,1,'Language Test','IELTS','3','6','7','7',NULL,NULL,NULL,1,NULL,NULL,NULL),(2707,196,1,'Skill Assessment','Engineers Australia','4','7','8','8',NULL,NULL,NULL,2,NULL,NULL,NULL),(2708,196,0,'Language Test','DET','5','8','9','9',NULL,NULL,NULL,2,NULL,NULL,NULL),(2709,196,0,'Admission Test','GMAT','6','9','0','0',NULL,NULL,NULL,2,NULL,NULL,NULL),(2710,196,0,'Spouse Language Test','DET','7','0','1','1',NULL,NULL,NULL,2,NULL,NULL,NULL),(2711,196,0,'Skill Assessment','Engineers Australia','8','1','2','2',NULL,NULL,NULL,2,NULL,NULL,NULL),(2712,196,0,'EDUCATION LOAN','ED','9','2','3','3',NULL,NULL,NULL,2,NULL,NULL,NULL),(2713,196,0,'TICKETING','TIC','0','3','4','4',NULL,NULL,NULL,0,NULL,NULL,NULL),(2714,196,0,'FOREX','FOR','1','4','5','5',NULL,NULL,NULL,2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `suggested_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permissions_docs`
--

DROP TABLE IF EXISTS `user_permissions_docs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permissions_docs` (
  `perm_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `can_view` tinyint(1) DEFAULT '0',
  `can_view_all` tinyint(1) DEFAULT '0',
  `can_transfer` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`perm_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_permissions_docs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permissions_docs`
--

LOCK TABLES `user_permissions_docs` WRITE;
/*!40000 ALTER TABLE `user_permissions_docs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permissions_docs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permissions_pages`
--

DROP TABLE IF EXISTS `user_permissions_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permissions_pages` (
  `perm_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `menu_name` varchar(100) DEFAULT NULL,
  `can_view` tinyint(1) DEFAULT '0',
  `can_save` tinyint(1) DEFAULT '0',
  `can_edit` tinyint(1) DEFAULT '0',
  `can_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`perm_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_permissions_pages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permissions_pages`
--

LOCK TABLES `user_permissions_pages` WRITE;
/*!40000 ALTER TABLE `user_permissions_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permissions_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `user_type` varchar(50) DEFAULT 'Staff',
  `status` varchar(50) DEFAULT 'Working',
  `branch_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `user_role` varchar(100) DEFAULT NULL,
  `backup_user` varchar(100) DEFAULT NULL,
  `extension` varchar(50) DEFAULT NULL,
  `all_time_view` tinyint(1) DEFAULT '0',
  `role` varchar(50) DEFAULT 'staff',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `branch_id` (`branch_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','123','ashwini1suresh@gmail.com','3728374283774','admin','Working',1,1,'admin','','',0,'admin','2026-01-29 06:28:03'),(3,'ashwini','$2b$10$R8IWHkgB3VF96H44zk74be9MpF7/YdPyPBY08QtVaeZRwxoR9d7MC','ashwini1suresh@gmail.com','9446885925','Admin','Working',1,1,'admin','','',0,'admin','2026-01-29 09:47:49');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visa_categories`
--

DROP TABLE IF EXISTS `visa_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visa_categories` (
  `visa_cat_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`visa_cat_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visa_categories`
--

LOCK TABLES `visa_categories` WRITE;
/*!40000 ALTER TABLE `visa_categories` DISABLE KEYS */;
INSERT INTO `visa_categories` VALUES (4,'Dependent Visa'),(5,'Spouse Visa'),(1,'Study Visa'),(3,'Tourist Visa'),(2,'Work Visa');
/*!40000 ALTER TABLE `visa_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_categories`
--

DROP TABLE IF EXISTS `work_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_categories` (
  `work_cat_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`work_cat_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_categories`
--

LOCK TABLES `work_categories` WRITE;
/*!40000 ALTER TABLE `work_categories` DISABLE KEYS */;
INSERT INTO `work_categories` VALUES (1,'sgdgsgfa');
/*!40000 ALTER TABLE `work_categories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-23 13:12:33
