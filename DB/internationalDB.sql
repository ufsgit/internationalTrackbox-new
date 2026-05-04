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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_admission_tests`
--

LOCK TABLES `application_admission_tests` WRITE;
/*!40000 ALTER TABLE `application_admission_tests` DISABLE KEYS */;
INSERT INTO `application_admission_tests` VALUES (18,9,'SAT','3','3','3'),(57,80,'GRE','2','2','2'),(64,16,'GMAT','2','2','2'),(65,16,'GRE','22','22','22'),(68,87,'GMAT','2','2','2'),(69,87,'GRE','22','22','22'),(72,88,'GRE','1','1','1'),(73,91,'GMAT','23','23','2'),(74,91,'GRE','32','22','23');
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
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_children`
--

LOCK TABLES `application_children` WRITE;
/*!40000 ALTER TABLE `application_children` DISABLE KEYS */;
INSERT INTO `application_children` VALUES (75,6,NULL,1),(89,3,NULL,1),(151,8,12,1),(262,80,3,1),(263,80,2,0),(270,16,4,1),(271,16,2,0),(276,87,4,1),(277,87,2,0),(278,91,3,1),(279,91,1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_education`
--

LOCK TABLES `application_education` WRITE;
/*!40000 ALTER TABLE `application_education` DISABLE KEYS */;
INSERT INTO `application_education` VALUES (246,9,'Germany','Bachelor','Environmental Science','Not Completed','2025-10-01',1,'highest'),(247,9,'New Zealand','Master','Finance','Not Completed','2025-11-01',0,'other'),(248,9,'Malta','Graduate Diploma','Hospitality','Completed',NULL,0,'other'),(383,80,'Singapore','Master','Law','Completed',NULL,1,'highest'),(384,80,'Australia','Associate Degree','Architecture','Not Completed','2026-05-01',0,'country'),(385,80,'Australia','Associate Degree','Environmental Science','Completed',NULL,0,'country'),(386,80,'Singapore','PhD','Health & Medicine','Completed',NULL,0,'other'),(408,16,'UAE','Graduate Certificate','Finance','Not Completed','2022-10-01',1,'highest'),(409,16,'India','High School','Hospitality','Completed','2022-10-01',0,'highest'),(410,16,'Australia','Bachelor','Architecture','Not Completed','2023-12-01',0,'country'),(411,16,'Australia','Associate Degree','Agriculture','Completed',NULL,0,'country'),(412,16,'Canada1','Master','Information Technology','Not Completed','2023-12-01',0,'country'),(413,16,'Poland','Master','Information Technology','Not Completed','2022-10-01',0,'other'),(414,16,'Germany','Graduate Certificate','Hospitality','Completed',NULL,0,'other'),(421,87,'Australia','High School','Hospitality','Not Completed','2026-05-01',1,'highest'),(422,87,'Canada1','Graduate Certificate','Finance','Completed',NULL,0,'highest'),(423,87,'Germany','Graduate Diploma','Health & Medicine','Not Completed','2026-05-01',0,'country'),(424,87,'Germany','Graduate Diploma','Finance','Completed',NULL,0,'country'),(425,87,'France','High School','Finance','Not Completed','2026-05-01',0,'other'),(426,87,'Georgia','Graduate Diploma','Finance','Completed',NULL,0,'other'),(431,88,'Malta','Graduate Diploma','Health & Medicine','Completed',NULL,1,'highest'),(432,88,'Latvia','Diploma','Hospitality','Completed',NULL,0,'other'),(433,91,'Malta','Master','Environmental Science','Not Completed','2026-05-01',1,'highest'),(434,91,'India','Diploma','Hospitality','Completed',NULL,0,'highest'),(435,91,'Poland','High School','Finance','Not Completed','2026-05-01',0,'other'),(436,91,'New Zealand','Graduate Diploma','Engineering','Completed',NULL,0,'other');
/*!40000 ALTER TABLE `application_education` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_language_tests`
--

LOCK TABLES `application_language_tests` WRITE;
/*!40000 ALTER TABLE `application_language_tests` DISABLE KEYS */;
INSERT INTO `application_language_tests` VALUES (18,9,'IELTS','3','3','3','3',0),(92,80,'PTE','2','2','2','2',0),(93,80,'IELTS','2','2','2','2',1),(106,16,'PTE','1','1','1','1',0),(107,16,'IELTS','11','11','11','11',0),(108,16,'TOEFL','2','2','2','2',1),(109,16,'IELTS','2','2','2','2',1),(114,87,'IELTS','1','1','1','1',0),(115,87,'PTE','11','11','11','11',0),(116,87,'IELTS','1','1','1','1',1),(117,87,'PTE','11','11','11','11',1),(120,88,'TOEFL','1','1','1','1',0),(121,91,'PTE','2','2','2','2',0),(122,91,'IELTS','2','2','23','3',0),(123,91,'IELTS','2','3','3','3',1),(124,91,'TOEFL','2','1','2','3',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_relatives`
--

LOCK TABLES `application_relatives` WRITE;
/*!40000 ALTER TABLE `application_relatives` DISABLE KEYS */;
INSERT INTO `application_relatives` VALUES (1,14,'Australia','Cousin','Spouse','2026-04-29 06:55:27'),(19,78,'Australia','Parent','Spouse','2026-05-02 07:27:10'),(20,80,'Australia','Parent','Spouse','2026-05-02 07:49:42'),(24,16,'Australia','Uncle/Aunty','Spouse','2026-05-02 08:56:29'),(25,85,'Germany','Sibling','Applicant','2026-05-02 09:15:19'),(26,86,'Germany','Sibling','Applicant','2026-05-02 09:20:53'),(27,87,'Germany','Uncle/Aunty','Spouse','2026-05-02 09:46:13'),(28,91,'Germany','Sibling','Spouse','2026-05-02 10:36:20');
/*!40000 ALTER TABLE `application_relatives` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_spouse_education`
--

LOCK TABLES `application_spouse_education` WRITE;
/*!40000 ALTER TABLE `application_spouse_education` DISABLE KEYS */;
INSERT INTO `application_spouse_education` VALUES (1,14,'Poland','Certificate III','Hospitality','Completed',NULL,NULL,'2026-04-29 06:55:27'),(140,78,'Australia','Associate Degree','Finance','Not Completed','2026-04-01','country','2026-05-02 07:27:10'),(141,78,'Australia','Advanced Diploma','Health & Medicine','Completed',NULL,'country','2026-05-02 07:27:10'),(142,78,'France','Associate Degree','Architecture','Not Completed','2026-04-01','highest','2026-05-02 07:27:10'),(143,78,'United Kingdom','Associate Degree','Environmental Science','Completed',NULL,'highest','2026-05-02 07:27:10'),(144,78,'Canada1','Associate Degree','Agriculture','Not Completed','2026-04-01','other','2026-05-02 07:27:10'),(145,80,'Australia','Bachelor','Architecture','Not Completed','2026-05-01','country','2026-05-02 07:49:42'),(146,80,'Australia','Associate Degree','Environmental Science','Completed',NULL,'country','2026-05-02 07:49:42'),(147,80,'Singapore','PhD','Hospitality','Completed',NULL,'highest','2026-05-02 07:49:42'),(148,80,'Poland','PG Diploma','Hospitality','Completed',NULL,'other','2026-05-02 07:49:42'),(170,16,'Australia','Associate Degree','Architecture','Not Completed','2024-06-01','country','2026-05-02 08:56:29'),(171,16,'Australia','Advanced Diploma','Agriculture','Completed',NULL,'country','2026-05-02 08:56:29'),(172,16,'Canada1','Advanced Diploma','Information Technology','Not Completed','2024-06-01','country','2026-05-02 08:56:29'),(173,16,'UAE','PG Diploma','Information Technology','Not Completed','2024-06-01','highest','2026-05-02 08:56:29'),(174,16,'New Zealand','High School','Information Technology','Completed',NULL,'highest','2026-05-02 08:56:29'),(175,16,'Latvia','Bachelor','Engineering','Not Completed','2024-06-01','other','2026-05-02 08:56:29'),(176,16,'UAE','Graduate Diploma','Dentistry','Completed',NULL,'other','2026-05-02 08:56:29'),(177,85,'Germany','Associate Degree','Architecture','Completed',NULL,'country','2026-05-02 09:15:19'),(178,85,'Poland','Associate Degree','Health & Medicine','Completed',NULL,'highest','2026-05-02 09:15:19'),(179,85,'New Zealand','High School','Health & Medicine','Completed',NULL,'other','2026-05-02 09:15:19'),(180,86,'Germany','Master','Information Technology','Completed',NULL,'country','2026-05-02 09:20:53'),(181,86,'Singapore','Master','Hospitality','Completed',NULL,'highest','2026-05-02 09:20:53'),(182,86,'New Zealand','High School','Hospitality','Completed',NULL,'other','2026-05-02 09:20:53'),(183,87,'Germany','Advanced Diploma','Built Environment','Not Completed','2026-05-01','country','2026-05-02 09:46:13'),(184,87,'Germany','Associate Degree','Arts & Humanities','Completed',NULL,'country','2026-05-02 09:46:13'),(185,87,'Ireland','Graduate Certificate','Health & Medicine','Not Completed','2026-05-01','highest','2026-05-02 09:46:13'),(186,87,'Latvia','Diploma','Finance','Completed',NULL,'highest','2026-05-02 09:46:13'),(187,87,'Malta','PG Diploma','Health & Medicine','Not Completed','2026-05-01','other','2026-05-02 09:46:13'),(188,87,'New Zealand','High School','Finance','Completed',NULL,'other','2026-05-02 09:46:13'),(189,91,'New Zealand','High School','Hospitality','Not Completed','2026-05-01','highest','2026-05-02 10:36:20'),(190,91,'Poland','Graduate Certificate','Environmental Science','Completed',NULL,'highest','2026-05-02 10:36:20'),(191,91,'New Zealand','Graduate Certificate','Finance','Not Completed','2026-05-01','other','2026-05-02 10:36:20'),(192,91,'Latvia','Diploma','Health & Medicine','Completed',NULL,'other','2026-05-02 10:36:20');
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
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `work_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_spouse_work`
--

LOCK TABLES `application_spouse_work` WRITE;
/*!40000 ALTER TABLE `application_spouse_work` DISABLE KEYS */;
INSERT INTO `application_spouse_work` VALUES (95,78,'Singapore','2',2,2,'other','2026-05-02 07:27:10'),(96,78,'Australia','w',2,2,'curr_country','2026-05-02 07:27:10'),(97,78,'Australia','es',2,2,'other_country','2026-05-02 07:27:10'),(98,80,'Singapore','2',2,2,'other','2026-05-02 07:49:42'),(99,80,'Australia','2',2,2,'curr_country','2026-05-02 07:49:42'),(100,80,'Australia','2',2,2,'other_country','2026-05-02 07:49:42'),(117,16,'Poland','e',2,2,'curr_other','2026-05-02 08:56:29'),(118,16,'Australia','a',1,1,'curr_country','2026-05-02 08:56:29'),(119,16,'Australia','b',2,2,'curr_country','2026-05-02 08:56:29'),(120,16,'Australia','c',3,3,'other_country','2026-05-02 08:56:29'),(121,16,'Canada1','d',4,4,'other_country','2026-05-02 08:56:29'),(122,85,'Singapore','c',3,3,'curr_other','2026-05-02 09:15:19'),(123,85,'Germany','a',2,2,'curr_country','2026-05-02 09:15:19'),(124,85,'Germany','b',2,2,'other_country','2026-05-02 09:15:19'),(125,86,'Singapore','c',3,3,'curr_other','2026-05-02 09:20:53'),(126,86,'Germany','a',2,2,'curr_country','2026-05-02 09:20:53'),(127,86,'Germany','b',2,2,'other_country','2026-05-02 09:20:53'),(128,87,'Poland','c',3,3,'curr_other','2026-05-02 09:46:13'),(129,87,'Singapore','cc',33,33,'curr_other','2026-05-02 09:46:13'),(130,87,'Germany','a',1,1,'curr_country','2026-05-02 09:46:13'),(131,87,'Germany','aa',11,11,'curr_country','2026-05-02 09:46:13'),(132,87,'Germany','b',2,2,'other_country','2026-05-02 09:46:13'),(133,87,'Germany','bb',22,22,'other_country','2026-05-02 09:46:13'),(134,91,'India','a',2,3,'curr_other','2026-05-02 10:36:20'),(135,91,'Poland','aa',2,2,'curr_other','2026-05-02 10:36:20');
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
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `is_current` tinyint(1) DEFAULT '0',
  `work_type` varchar(20) DEFAULT 'curr_country',
  PRIMARY KEY (`id`),
  KEY `fk_app_work` (`application_id`),
  CONSTRAINT `fk_app_work` FOREIGN KEY (`application_id`) REFERENCES `student_applications` (`application_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_work_experience`
--

LOCK TABLES `application_work_experience` WRITE;
/*!40000 ALTER TABLE `application_work_experience` DISABLE KEYS */;
INSERT INTO `application_work_experience` VALUES (182,9,'France','bfb',5,6,1,'curr_other'),(351,80,'Poland','2',2,2,0,'curr_other'),(352,80,'Australia','2',2,2,1,'curr_country'),(353,80,'Australia','2',2,2,0,'other_country'),(381,16,'Malta','d',6,5,1,'curr_other'),(382,16,'New Zealand','dd',4,3,1,'curr_other'),(383,16,'Australia','a',2,3,1,'curr_country'),(384,16,'Australia','aa',5,9,1,'curr_country'),(385,16,'Australia','b',2,4,0,'other_country'),(386,16,'Australia','bb',5,6,0,'other_country'),(387,16,'Canada1','cc',4,5,1,'curr_country'),(388,16,'Canada1','ccc',4,3,1,'curr_country'),(389,16,'Canada1','ccccc',4,3,0,'other_country'),(396,87,'India','c',3,3,0,'curr_other'),(397,87,'Ireland','cc',33,33,0,'curr_other'),(398,87,'Germany','a',1,1,1,'curr_country'),(399,87,'Germany','aa',11,11,1,'curr_country'),(400,87,'Germany','b',2,2,0,'other_country'),(401,87,'Germany','bb',22,22,0,'other_country'),(404,88,'Singapore','21',2,2,1,'curr_other'),(405,91,'Georgia','aa',1,2,0,'curr_other'),(406,91,'New Zealand','bb',2,3,0,'curr_other');
/*!40000 ALTER TABLE `application_work_experience` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaching_courses`
--

LOCK TABLES `coaching_courses` WRITE;
/*!40000 ALTER TABLE `coaching_courses` DISABLE KEYS */;
INSERT INTO `coaching_courses` VALUES (1,'test course');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_ups`
--

LOCK TABLES `follow_ups` WRITE;
/*!40000 ALTER TABLE `follow_ups` DISABLE KEYS */;
INSERT INTO `follow_ups` VALUES (1,2,1,1,'Applied',1,'2026-01-29','applied student',1,'2026-01-29 06:39:39'),(3,4,2,2,'Interested',1,'2026-01-29','intrested need o followup',1,'2026-01-29 12:17:50'),(4,5,1,2,'Interested',1,'2026-01-29','tested data',1,'2026-01-29 12:28:17'),(5,6,1,2,'Interested',1,'2026-02-08','q',1,'2026-02-08 07:45:31'),(6,7,1,2,'Interested',1,'2026-02-09','need to call',1,'2026-02-09 05:02:28'),(7,10,1,1,'Interested',1,'2026-02-11','Initial Status: Interested',1,'2026-02-11 16:30:48'),(8,10,1,2,'Doubtful',1,'2026-03-12','h',1,'2026-03-12 14:31:53'),(9,10,1,NULL,'Interested',1,'2026-04-15','saaa',1,'2026-04-14 04:51:55'),(10,7,1,NULL,'Interested',1,'2026-04-16','asdasa',1,'2026-04-14 04:53:02'),(11,6,1,NULL,'Interested',1,'2026-04-07','es',1,'2026-04-14 04:53:23'),(12,11,1,4,'',3,'2026-04-18','Dwdwdawd',1,'2026-04-18 03:28:56'),(13,12,2,1,'Applied',NULL,'2026-04-22','good',1,'2026-04-18 03:43:20'),(14,17,1,2,'Interested',3,'2026-04-23','remark test',1,'2026-04-23 11:21:57'),(15,19,1,2,'Interested',3,'2026-04-30','remark test',1,'2026-04-29 06:40:28'),(16,22,2,2,'Interested',3,'2026-04-30','remarks tess',1,'2026-04-30 10:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_categories`
--

LOCK TABLES `migration_categories` WRITE;
/*!40000 ALTER TABLE `migration_categories` DISABLE KEYS */;
INSERT INTO `migration_categories` VALUES (1,'for studies');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_admission_tests`
--

LOCK TABLES `registration_admission_tests` WRITE;
/*!40000 ALTER TABLE `registration_admission_tests` DISABLE KEYS */;
INSERT INTO `registration_admission_tests` VALUES (1,9,'GMAT','2','2','2','','2026-05-02 08:27:13'),(2,9,'GRE','22','22','22','','2026-05-02 08:27:13'),(5,10,'GMAT','2','2','2','','2026-05-02 09:12:23'),(6,10,'GRE','22','22','22','','2026-05-02 09:12:23'),(7,12,'GMAT','2','2','2','','2026-05-02 09:47:21'),(8,12,'GRE','22','22','22','','2026-05-02 09:47:21'),(10,13,'GRE','1','1','1','','2026-05-02 09:49:49'),(11,15,'GMAT','23','23','2','','2026-05-02 10:37:01'),(12,15,'GRE','32','22','23','','2026-05-02 10:37:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_children`
--

LOCK TABLES `registration_children` WRITE;
/*!40000 ALTER TABLE `registration_children` DISABLE KEYS */;
INSERT INTO `registration_children` VALUES (13,5,12,1),(14,5,10,0),(19,10,4,1),(20,10,2,0),(21,12,4,1),(22,12,2,0),(23,15,3,1),(24,15,1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_education`
--

LOCK TABLES `registration_education` WRITE;
/*!40000 ALTER TABLE `registration_education` DISABLE KEYS */;
INSERT INTO `registration_education` VALUES (36,10,'UAE','Graduate Certificate','Finance','Not Completed','2022-08-01',1,'highest'),(37,10,'India','High School','Hospitality','Completed','2022-08-01',0,'highest'),(38,10,'Australia','Bachelor','Architecture','Not Completed','2023-10-01',0,'country'),(39,10,'Australia','Associate Degree','Agriculture','Completed',NULL,0,'country'),(40,10,'Canada1','Master','Information Technology','Not Completed','2023-10-01',0,'country'),(41,10,'Poland','Master','Information Technology','Not Completed','2022-08-01',0,'other'),(42,10,'Germany','Graduate Certificate','Hospitality','Completed',NULL,0,'other'),(43,12,'Australia','High School','Hospitality','Not Completed','2026-04-01',1,'highest'),(44,12,'Canada1','Graduate Certificate','Finance','Completed',NULL,0,'highest'),(45,12,'Germany','Graduate Diploma','Health & Medicine','Not Completed','2026-04-01',0,'country'),(46,12,'Germany','Graduate Diploma','Finance','Completed',NULL,0,'country'),(47,12,'France','High School','Finance','Not Completed','2026-04-01',0,'other'),(48,12,'Georgia','Graduate Diploma','Finance','Completed',NULL,0,'other'),(51,13,'Malta','Graduate Diploma','Health & Medicine','Completed',NULL,1,'highest'),(52,13,'Latvia','Diploma','Hospitality','Completed',NULL,0,'other'),(53,15,'Malta','Master','Environmental Science','Not Completed','2026-04-01',1,'highest'),(54,15,'India','Diploma','Hospitality','Completed',NULL,0,'highest'),(55,15,'Poland','High School','Finance','Not Completed','2026-04-01',0,'other'),(56,15,'New Zealand','Graduate Diploma','Engineering','Completed',NULL,0,'other');
/*!40000 ALTER TABLE `registration_education` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_language_tests`
--

LOCK TABLES `registration_language_tests` WRITE;
/*!40000 ALTER TABLE `registration_language_tests` DISABLE KEYS */;
INSERT INTO `registration_language_tests` VALUES (9,10,'PTE','1','1','1','1','',0),(10,10,'IELTS','11','11','11','11','',0),(11,10,'TOEFL','2','2','2','2','',1),(12,10,'IELTS','2','2','2','2','',1),(13,12,'IELTS','1','1','1','1','',0),(14,12,'PTE','11','11','11','11','',0),(15,12,'IELTS','1','1','1','1','',1),(16,12,'PTE','11','11','11','11','',1),(18,13,'TOEFL','1','1','1','1','',0),(19,15,'PTE','2','2','2','2','',0),(20,15,'IELTS','3','2','23','2','',0),(21,15,'IELTS','3','2','3','3','',1),(22,15,'TOEFL','3','2','2','1','',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_relatives`
--

LOCK TABLES `registration_relatives` WRITE;
/*!40000 ALTER TABLE `registration_relatives` DISABLE KEYS */;
INSERT INTO `registration_relatives` VALUES (1,9,'Australia','Uncle/Aunty','Spouse','2026-05-02 08:27:13'),(3,10,'Australia','Uncle/Aunty','Spouse','2026-05-02 09:12:23'),(4,12,'Germany','Uncle/Aunty','Spouse','2026-05-02 09:47:21'),(5,15,'Germany','Sibling','Spouse','2026-05-02 10:37:01');
/*!40000 ALTER TABLE `registration_relatives` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_spouse_education`
--

LOCK TABLES `registration_spouse_education` WRITE;
/*!40000 ALTER TABLE `registration_spouse_education` DISABLE KEYS */;
INSERT INTO `registration_spouse_education` VALUES (1,9,'Australia','Associate Degree','Architecture','Not Completed','2024-09-01','country','2026-05-02 08:27:13'),(2,9,'Australia','Advanced Diploma','Agriculture','Completed',NULL,'country','2026-05-02 08:27:13'),(3,9,'Canada1','Advanced Diploma','Information Technology','Not Completed','2024-09-01','country','2026-05-02 08:27:13'),(4,9,'UAE','PG Diploma','Information Technology','Not Completed','2024-09-01','highest','2026-05-02 08:27:13'),(5,9,'New Zealand','High School','Information Technology','Completed',NULL,'highest','2026-05-02 08:27:13'),(6,9,'Latvia','Bachelor','Engineering','Not Completed','2024-09-01','other','2026-05-02 08:27:13'),(7,9,'UAE','Graduate Diploma','Dentistry','Completed',NULL,'other','2026-05-02 08:27:13'),(15,10,'Australia','Associate Degree','Architecture','Not Completed','2024-04-01','country','2026-05-02 09:12:23'),(16,10,'Australia','Advanced Diploma','Agriculture','Completed',NULL,'country','2026-05-02 09:12:23'),(17,10,'Canada1','Advanced Diploma','Information Technology','Not Completed','2024-04-01','country','2026-05-02 09:12:23'),(18,10,'UAE','PG Diploma','Information Technology','Not Completed','2024-04-01','highest','2026-05-02 09:12:23'),(19,10,'New Zealand','High School','Information Technology','Completed',NULL,'highest','2026-05-02 09:12:23'),(20,10,'Latvia','Bachelor','Engineering','Not Completed','2024-04-01','other','2026-05-02 09:12:23'),(21,10,'UAE','Graduate Diploma','Dentistry','Completed',NULL,'other','2026-05-02 09:12:23'),(22,12,'Germany','Advanced Diploma','Built Environment','Not Completed','2026-04-01','country','2026-05-02 09:47:21'),(23,12,'Germany','Associate Degree','Arts & Humanities','Completed',NULL,'country','2026-05-02 09:47:21'),(24,12,'Ireland','Graduate Certificate','Health & Medicine','Not Completed','2026-04-01','highest','2026-05-02 09:47:21'),(25,12,'Latvia','Diploma','Finance','Completed',NULL,'highest','2026-05-02 09:47:21'),(26,12,'Malta','PG Diploma','Health & Medicine','Not Completed','2026-04-01','other','2026-05-02 09:47:21'),(27,12,'New Zealand','High School','Finance','Completed',NULL,'other','2026-05-02 09:47:21'),(28,15,'New Zealand','High School','Hospitality','Not Completed','2026-04-01','highest','2026-05-02 10:37:01'),(29,15,'Poland','Graduate Certificate','Environmental Science','Completed',NULL,'highest','2026-05-02 10:37:01'),(30,15,'New Zealand','Graduate Certificate','Finance','Not Completed','2026-04-01','other','2026-05-02 10:37:01'),(31,15,'Latvia','Diploma','Health & Medicine','Completed',NULL,'other','2026-05-02 10:37:01');
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
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `work_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_spouse_work`
--

LOCK TABLES `registration_spouse_work` WRITE;
/*!40000 ALTER TABLE `registration_spouse_work` DISABLE KEYS */;
INSERT INTO `registration_spouse_work` VALUES (1,9,'Latvia','e',5,5,'other','2026-05-02 08:27:13'),(2,9,'Australia','a',1,1,'curr_country','2026-05-02 08:27:13'),(3,9,'Australia','b',2,2,'curr_country','2026-05-02 08:27:13'),(4,9,'Australia','c',3,3,'other_country','2026-05-02 08:27:13'),(5,9,'Canada1','d',4,4,'other_country','2026-05-02 08:27:13'),(11,10,'Poland','e',2,2,'curr_other','2026-05-02 09:12:23'),(12,10,'Australia','a',1,1,'curr_country','2026-05-02 09:12:23'),(13,10,'Australia','b',2,2,'curr_country','2026-05-02 09:12:23'),(14,10,'Australia','c',3,3,'other_country','2026-05-02 09:12:23'),(15,10,'Canada1','d',4,4,'other_country','2026-05-02 09:12:23'),(16,12,'Poland','c',3,3,'curr_other','2026-05-02 09:47:21'),(17,12,'Singapore','cc',33,33,'curr_other','2026-05-02 09:47:21'),(18,12,'Germany','a',1,1,'curr_country','2026-05-02 09:47:21'),(19,12,'Germany','aa',11,11,'curr_country','2026-05-02 09:47:21'),(20,12,'Germany','b',2,2,'other_country','2026-05-02 09:47:21'),(21,12,'Germany','bb',22,22,'other_country','2026-05-02 09:47:21'),(22,15,'India','a',2,3,'curr_other','2026-05-02 10:37:01'),(23,15,'Poland','aa',2,2,'curr_other','2026-05-02 10:37:01');
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
  `program_type` varchar(50) DEFAULT NULL,
  `program` varchar(255) DEFAULT NULL,
  `applied_for` varchar(255) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_suggested_programs`
--

LOCK TABLES `registration_suggested_programs` WRITE;
/*!40000 ALTER TABLE `registration_suggested_programs` DISABLE KEYS */;
INSERT INTO `registration_suggested_programs` VALUES (1,2,NULL,'STUDY Australia',NULL,'Certificate IV Agriculture - April 2025','','','',1,NULL,NULL,NULL),(2,3,NULL,'STUDY Australia',NULL,'Bachelor Business - August 2024','','','',1,NULL,NULL,NULL),(3,3,NULL,'STUDY France',NULL,'Bachelor Engineering - September 2024','','','',1,NULL,NULL,NULL),(4,3,NULL,'Canada',NULL,'Accountant - Dependent Visa','','','',1,NULL,NULL,NULL),(5,3,NULL,'India',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(6,3,NULL,'',NULL,'','','','',1,NULL,NULL,NULL),(7,3,NULL,'COACHING',NULL,'test course - test','','','',1,NULL,NULL,NULL),(8,4,NULL,'STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025','','','',1,NULL,NULL,NULL),(9,4,NULL,'Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(46,5,NULL,'STUDY India',NULL,'Master Computing - April 2024','','','',1,NULL,NULL,NULL),(47,5,NULL,'Australia',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(48,5,NULL,'Canada1',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(49,5,NULL,'France',NULL,'Chef','','','',1,NULL,NULL,NULL),(50,5,NULL,'COACHING',NULL,'test course - inputted a','','','',1,NULL,NULL,NULL),(51,5,NULL,'MIGRATION Germany',NULL,'Marketing Specialist - for studies','','','',1,NULL,NULL,NULL),(72,10,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024','','','',1,NULL,NULL,NULL),(73,10,'STUDY','STUDY Canada1',NULL,'Associate Degree Accounting - August 2025','','','',1,NULL,NULL,NULL),(74,10,'OTHER','Australia',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(75,10,'OTHER','Canada1',NULL,'Chef - for studies','','','',1,NULL,NULL,NULL),(76,10,'OTHER','Australia',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(77,10,'OTHER','Canada1',NULL,'Spouse Visa','','','',1,NULL,NULL,NULL),(78,10,'OTHER','Australia',NULL,'Accountant','','','',1,NULL,NULL,NULL),(79,10,'OTHER','Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(80,10,'COACHING','COACHING',NULL,'test course - testa','','','',1,NULL,NULL,NULL),(81,10,'COACHING','COACHING',NULL,'test course - testb','','','',1,NULL,NULL,NULL),(82,12,'STUDY','STUDY France',NULL,'Advanced Diploma Accounting - April 2025','','','',1,NULL,NULL,NULL),(83,12,'MIGRATION','Germany',NULL,'Chef - for studies','','','',1,NULL,NULL,NULL),(84,12,'VISA','Australia',NULL,'Spouse Visa','','','',1,NULL,NULL,NULL),(85,12,'WORK','France',NULL,'Chef','','','',1,NULL,NULL,NULL),(86,12,'COACHING','COACHING',NULL,'test course - dsfd','','','',1,NULL,NULL,NULL),(88,13,'STUDY','STUDY Poland',NULL,'Graduate Certificate Creative Arts - July 2027','one','one sub','',1,1,1,1),(89,15,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024','','','',1,NULL,NULL,NULL),(90,15,'MIGRATION','Germany',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(91,15,'VISA','Australia',NULL,'Spouse Visa','','','',1,NULL,NULL,NULL),(92,15,'WORK','Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(93,15,'COACHING','COACHING',NULL,'test course - 343','','','',1,NULL,NULL,NULL);
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
  `work_years` int DEFAULT '0',
  `work_months` int DEFAULT '0',
  `type` enum('current','previous') DEFAULT 'previous',
  `work_type` varchar(20) DEFAULT 'curr_country',
  PRIMARY KEY (`id`),
  KEY `fk_reg_work` (`registration_id`),
  CONSTRAINT `fk_reg_work` FOREIGN KEY (`registration_id`) REFERENCES `student_registrations` (`registration_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_work_experience`
--

LOCK TABLES `registration_work_experience` WRITE;
/*!40000 ALTER TABLE `registration_work_experience` DISABLE KEYS */;
INSERT INTO `registration_work_experience` VALUES (39,10,'Malta','d',6,5,'current','curr_other'),(40,10,'New Zealand','dd',4,3,'current','curr_other'),(41,10,'Australia','a',2,3,'current','curr_country'),(42,10,'Australia','aa',5,9,'current','curr_country'),(43,10,'Australia','b',2,4,'previous','other_country'),(44,10,'Australia','bb',5,6,'previous','other_country'),(45,10,'Canada1','cc',4,5,'current','curr_country'),(46,10,'Canada1','ccc',4,3,'current','curr_country'),(47,10,'Canada1','ccccc',4,3,'previous','other_country'),(48,12,'India','c',3,3,'previous','curr_other'),(49,12,'Ireland','cc',33,33,'previous','curr_other'),(50,12,'Germany','a',1,1,'current','curr_country'),(51,12,'Germany','aa',11,11,'current','curr_country'),(52,12,'Germany','b',2,2,'previous','other_country'),(53,12,'Germany','bb',22,22,'previous','other_country'),(55,13,'Singapore','21',2,2,'current','curr_other'),(56,15,'Georgia','aa',1,2,'previous','curr_other'),(57,15,'New Zealand','bb',2,3,'previous','curr_other');
/*!40000 ALTER TABLE `registration_work_experience` ENABLE KEYS */;
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
  `phone_country_code` varchar(10) DEFAULT NULL,
  `contact2_code` varchar(10) DEFAULT NULL,
  `contact2` varchar(50) DEFAULT NULL,
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
  `language_test_type` varchar(50) DEFAULT NULL,
  `writing_score` varchar(20) DEFAULT NULL,
  `listening_score` varchar(20) DEFAULT NULL,
  `speaking_score` varchar(20) DEFAULT NULL,
  `reading_score` varchar(20) DEFAULT NULL,
  `has_admission_test` tinyint(1) DEFAULT '0',
  `admission_test_type` varchar(50) DEFAULT NULL,
  `quant_score` varchar(20) DEFAULT NULL,
  `verbal_score` varchar(20) DEFAULT NULL,
  `data_insights_score` varchar(20) DEFAULT NULL,
  `spouse_age` int DEFAULT NULL,
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
  `has_relatives` tinyint(1) DEFAULT '0',
  `relative_relationship` varchar(100) DEFAULT NULL,
  `relative_related_to` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `student_id_2` (`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_applications`
--

LOCK TABLES `student_applications` WRITE;
/*!40000 ALTER TABLE `student_applications` DISABLE KEYS */;
INSERT INTO `student_applications` VALUES (1,2,'Ashwini Suresh',35,NULL,'Female','Single',0,'','','',NULL,NULL,'9446885925',NULL,NULL,'8590217598','ashwini1suresh@gmail.com','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-02-05 11:06:21','2026-02-06 07:04:44'),(2,7,'Test1',NULL,NULL,'Male','Single',0,'Australia','','',NULL,NULL,'5895557458',NULL,NULL,'56875656552','Test1@gmail.com','Australia',NULL,NULL,NULL,'Bachelor','Business',0,'','',0,'','',0,'','',0,'','',1,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-02-14 17:36:25','2026-02-23 15:14:48'),(3,10,'sudheesh',13,NULL,'Male','Married',1,'Latvia','200','200','+91',NULL,'9099090909','+971',NULL,'64654654','ggyuguyg@','Canada1','',0,'','Graduate Diploma','Engineering',1,'Advanced Diploma','Agriculture',1,'Advanced Diploma','Finance',0,'','',1,'','',1,'5','','2','',1,'IELTS','','','','',1,'GMAT','','','',30,'Bachelor',1,'','',1,'','',0,'','','','','','','IELTS','','','','',0,'','','2026-03-13 14:19:58','2026-04-23 05:51:03'),(4,11,'ESDFS',21,NULL,'Male','Single',0,'United Kingdom','jn','jn',NULL,NULL,'56323',NULL,NULL,'5464654646','saaaaa@','United Kingdom',NULL,NULL,NULL,'Bachelor','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','yes','yes','yes',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-18 03:30:32','2026-04-18 03:37:55'),(5,12,'riju',22,NULL,'Male','Single',0,'Australia','tayankari','dd',NULL,NULL,'888888888888',NULL,NULL,'','sabu@1','',NULL,NULL,NULL,'Advanced Diploma','Accounting',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','','','',1,'','dd','dd','dd',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-18 03:44:18','2026-04-20 10:46:33'),(6,15,'malavika',6,NULL,'Male','Single',0,'Australia','ygy','rdr',NULL,NULL,'15165165',NULL,NULL,'6+265265265','ytfytf@','United Kingdom',NULL,NULL,NULL,'PhD','Information Technology',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','nu','uu','uh','hh',1,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-21 04:46:22','2026-04-21 04:46:22'),(7,16,'jiju',NULL,NULL,'Male','Single',0,'','','','+91',NULL,'4554149515','+91',NULL,'51951','sasas@','','',0,'','','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','','','yguyg',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-21 05:56:37','2026-04-23 08:44:54'),(8,17,'max',22,NULL,'Male','Married',1,'India','Kerala','Kochi','+971',NULL,'0123456789','+1',NULL,'0123456789','max@gmail.comww','Canada1','',0,'','Associate Degree','Education & Teaching',0,'','',1,'Bachelor','Agriculture',0,'','',0,'','',1,'','','','',1,'','','','','',1,'','','','',21,'Bachelor',1,'','',1,'','',0,'','','','1','2','3','','','','','',0,'','','2026-04-24 04:51:24','2026-04-25 11:28:31'),(9,18,'rger',22,NULL,'Male','Married',1,'Canada1','cf','cc','+91',NULL,'4545453545','+91',NULL,'5454543543','454545','','',0,'','','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-25 05:33:44','2026-04-30 06:59:07'),(16,19,'test',20,NULL,'Female','Married',1,'UAE','Kerala','Kochi',NULL,'+1','6565156511',NULL,'+91','5733653453','test@gmail.com','Singapore','',0,'','Graduate Certificate','Finance',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,25,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-04-29 07:02:36','2026-05-02 08:56:29'),(80,22,'tess',31,NULL,'Male','Married',1,'Malta','Kerala','Kochi',NULL,'+91','4352443544',NULL,'+1','5345235235','3524','Poland','',0,'','Master','Law',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,21,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 07:49:42','2026-05-02 07:49:42'),(87,24,'kiro',21,NULL,'Male','Married',1,'Poland','Kerala','Kochi',NULL,'+971','2354542325',NULL,'+1','3454523524','kiro@gmail.com','Poland','',0,'','High School','Hospitality',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,21,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:46:13','2026-05-02 09:46:13'),(88,25,'non',21,NULL,'Male','Single',0,'Malta','Kerala','Kochi',NULL,'+91','5234553254',NULL,'+91','2345243534','edfr@gmail.com','Malta','',0,'','Graduate Diploma','Health & Medicine',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:48:51','2026-05-02 09:49:27'),(91,26,'qq',21,NULL,'Male','Married',1,'Malta','Kerala','Kochi',NULL,'+1','2543265634',NULL,'+91','5346546546','12@gmail.com','New Zealand','',0,'','Master','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,21,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 10:36:20','2026-05-02 10:36:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_coaching`
--

LOCK TABLES `student_coaching` WRITE;
/*!40000 ALTER TABLE `student_coaching` DISABLE KEYS */;
INSERT INTO `student_coaching` VALUES (10,2,'mtecj','A!','2026-02-04 08:42:01'),(11,5,'','','2026-02-05 15:54:55'),(16,12,'','','2026-04-20 05:35:33'),(27,16,'','','2026-04-23 09:27:47'),(28,10,'test course','test','2026-04-23 09:38:12'),(36,17,'test course','inputted a','2026-04-25 05:31:39'),(37,19,'test course','testa','2026-04-29 06:40:28'),(38,19,'test course','testb','2026-04-29 06:40:28'),(41,22,'test course','batch a','2026-05-02 05:36:16'),(44,24,'test course','dsfd','2026-05-02 09:41:55'),(45,26,'test course','343','2026-05-02 10:33:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_migration`
--

LOCK TABLES `student_migration` WRITE;
/*!40000 ALTER TABLE `student_migration` DISABLE KEYS */;
INSERT INTO `student_migration` VALUES (6,4,'Canada','Chef','Spouse Visa','2026-01-29 12:17:50'),(18,2,'France','Accountant','Tourist Visa','2026-02-04 08:42:01'),(19,2,'Canada','Software Engineer','Study Visa','2026-02-04 08:42:01'),(20,2,'Georgia','Chef','Spouse Visa','2026-02-04 08:42:01'),(21,5,'Ireland','Accountant','Spouse Visa','2026-02-05 15:54:55'),(28,7,'United Kingdom','Driver','Spouse Visa','2026-02-17 19:42:13'),(38,12,'','','','2026-04-20 05:35:33'),(51,15,'','','','2026-04-23 09:15:46'),(54,16,'','','','2026-04-23 09:27:47'),(55,10,'Canada','Accountant','Dependent Visa','2026-04-23 09:38:12'),(63,17,'Australia','Accountant','for studies','2026-04-25 05:31:39'),(64,19,'Australia','Accountant','for studies','2026-04-29 06:40:28'),(65,19,'Canada1','Chef','for studies','2026-04-29 06:40:28'),(68,22,'Australia','Chef','for studies','2026-05-02 05:36:16'),(71,24,'Germany','Chef','for studies','2026-05-02 09:41:55'),(72,26,'Germany','Accountant','for studies','2026-05-02 10:33:54');
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
  `contact2_code` varchar(10) DEFAULT NULL,
  `contact2` varchar(50) DEFAULT NULL,
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
  `language_test_type` varchar(50) DEFAULT NULL,
  `writing_score` varchar(20) DEFAULT NULL,
  `listening_score` varchar(20) DEFAULT NULL,
  `speaking_score` varchar(20) DEFAULT NULL,
  `reading_score` varchar(20) DEFAULT NULL,
  `has_admission_test` tinyint(1) DEFAULT '0',
  `admission_test_type` varchar(50) DEFAULT NULL,
  `quant_score` varchar(20) DEFAULT NULL,
  `verbal_score` varchar(20) DEFAULT NULL,
  `data_insights_score` varchar(20) DEFAULT NULL,
  `spouse_age` int DEFAULT NULL,
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
  `has_relatives` tinyint(1) DEFAULT '0',
  `relative_relationship` varchar(100) DEFAULT NULL,
  `relative_related_to` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`registration_id`),
  UNIQUE KEY `student_id_2` (`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_registrations_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_registrations`
--

LOCK TABLES `student_registrations` WRITE;
/*!40000 ALTER TABLE `student_registrations` DISABLE KEYS */;
INSERT INTO `student_registrations` VALUES (1,11,'ESDFS',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,NULL,'56323',NULL,'','','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-18 03:35:00','2026-04-18 03:35:00'),(2,12,'riju',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,NULL,'7777777777',NULL,'','sabu@','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-18 03:45:29','2026-04-18 03:45:29'),(3,10,'sudheesh',NULL,NULL,NULL,NULL,'Male','Single',0,'France','255','255',NULL,NULL,'9099090909',NULL,'','','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-20 09:50:29','2026-04-20 09:50:29'),(4,16,'jiju',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,NULL,'4554149515',NULL,'51951','sasas@','','',0,'','','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','','','yguyg',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','2026-04-21 05:56:59','2026-04-21 05:56:59'),(5,17,'max','max','ver',1,'2025-04-01','Male','Married',1,'India','Kerala','Kochi','10','+971','0123456789','+91','0123456789','max@gmail.comww','Canada1','Germany',1,'New Zealand','Associate Degree','Education & Teaching',0,'','',1,'Bachelor','Agriculture',0,'','',0,'','',1,'','','','',1,'','','','','',1,'','','','',21,'Bachelor',1,'','',1,'','',0,'','','','1','2','3','IELTS','','','','',0,'','','2026-04-25 11:07:15','2026-04-29 05:37:02'),(10,19,'test','test n','x',2,'2024-01-02','Female','Married',1,'UAE','Kerala','Kochi','123','+1','6565156511','+91','5733653453','test@gmail.com','Singapore','France',1,'New Zealand','Graduate Certificate','Finance',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,25,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 08:58:30','2026-05-02 09:12:23'),(12,24,'kiro','kiro','x',7,'2019-01-02','Male','Married',1,'Poland','Kerala','Kochi','123','+971','2354542325','+1','3454523524','kiro@gmail.com','Poland','Germany',1,'UAE','High School','Hospitality',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,21,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:47:21','2026-05-02 09:47:21'),(13,25,'non','nn','n',0,'2026-04-29','Male','Single',0,'Malta','Kerala','Kochi','nn','+91','5234553254','+91','2345243534','edfr@gmail.com','Malta','Malta',1,'Ireland','Graduate Diploma','Health & Medicine',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 09:49:42','2026-05-02 09:49:49'),(15,26,'qq','q','z',6,'2020-01-28','Male','Married',1,'Malta','Kerala','Kochi','123','+1','2543265634','+91','5346546546','12@gmail.com','New Zealand','Australia',1,'Poland','Master','Environmental Science',0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,21,NULL,0,NULL,NULL,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-05-02 10:37:01','2026-05-02 10:37:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_study_programs`
--

LOCK TABLES `student_study_programs` WRITE;
/*!40000 ALTER TABLE `student_study_programs` DISABLE KEYS */;
INSERT INTO `student_study_programs` VALUES (6,4,'Germany','Bachelor','Business','April',2025,'2026-01-29 12:17:50'),(7,4,'Australia','Diploma','Engineering','August',2026,'2026-01-29 12:17:50'),(20,2,'Australia','Bachelor','Engineering','December',2026,'2026-02-04 08:42:01'),(21,2,'Canada','Master','Business','August',2025,'2026-02-04 08:42:01'),(22,5,'Georgia','High School','Hospitality','February',2027,'2026-02-05 15:54:55'),(23,5,'France','Graduate Certificate','Hospitality','February',2026,'2026-02-05 15:54:55'),(35,6,'Singapore','PG Diploma','Business','October',2024,'2026-02-09 10:08:16'),(37,7,'Poland','Master','Engineering','November',2025,'2026-02-17 19:42:12'),(38,7,'Georgia','PG Diploma','Business','November',2026,'2026-02-17 19:42:12'),(39,7,'Ireland','Bachelor','Business','September',2024,'2026-02-17 19:42:13'),(54,12,'Australia','Certificate IV','Agriculture','April',2025,'2026-04-20 05:35:33'),(74,15,'Australia','Advanced Diploma','Agriculture','April',2024,'2026-04-23 09:15:46'),(79,16,'Australia','Advanced Diploma','Accounting','April',2025,'2026-04-23 09:27:47'),(80,10,'Australia','Bachelor','Business','August',2024,'2026-04-23 09:38:12'),(81,10,'France','Bachelor','Engineering','September',2024,'2026-04-23 09:38:12'),(89,17,'India','Master','Computing','April',2024,'2026-04-25 05:31:39'),(90,19,'Australia','Advanced Diploma','Accounting','April',2024,'2026-04-29 06:40:28'),(91,19,'Canada1','Associate Degree','Accounting','August',2025,'2026-04-29 06:40:28'),(94,22,'Australia','Bachelor','Agriculture','August',2025,'2026-05-02 05:36:16'),(97,24,'France','Advanced Diploma','Accounting','April',2025,'2026-05-02 09:41:55'),(98,26,'Australia','Advanced Diploma','Accounting','April',2024,'2026-05-02 10:33:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_visa`
--

LOCK TABLES `student_visa` WRITE;
/*!40000 ALTER TABLE `student_visa` DISABLE KEYS */;
INSERT INTO `student_visa` VALUES (3,4,'Georgia','Study Visa','2026-01-29 12:17:50'),(4,4,'Canada','Study Visa','2026-01-29 12:17:50'),(9,2,'India','Dependent Visa','2026-02-04 08:42:01'),(19,12,'','','2026-04-20 05:35:33'),(30,16,'','','2026-04-23 09:27:47'),(31,10,'India','Dependent Visa','2026-04-23 09:38:12'),(35,17,'Canada1','Spouse Visa','2026-04-25 05:31:39'),(36,19,'Australia','Dependent Visa','2026-04-29 06:40:28'),(37,19,'Canada1','Spouse Visa','2026-04-29 06:40:28'),(40,22,'Canada1','Dependent Visa','2026-05-02 05:36:16'),(43,24,'Australia','Spouse Visa','2026-05-02 09:41:55'),(44,26,'Australia','Spouse Visa','2026-05-02 10:33:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_work`
--

LOCK TABLES `student_work` WRITE;
/*!40000 ALTER TABLE `student_work` DISABLE KEYS */;
INSERT INTO `student_work` VALUES (3,4,'France','Civil Engineer','2026-01-29 12:17:50'),(8,2,'Singapore','Civil Engineer','2026-02-04 08:42:01'),(9,5,'France','Accountant','2026-02-05 15:54:55'),(18,12,'','','2026-04-20 05:35:33'),(34,15,'Australia','Accountant','2026-04-23 09:15:46'),(37,16,'Canada1','Chef','2026-04-23 09:27:47'),(38,10,'','','2026-04-23 09:38:12'),(43,19,'Australia','Accountant','2026-04-29 06:40:28'),(44,19,'Canada1','Chef','2026-04-29 06:40:28'),(47,22,'Canada1','Civil Engineer','2026-05-02 05:36:16'),(50,24,'France','Chef','2026-05-02 09:41:55'),(51,26,'Canada1','Chef','2026-05-02 10:33:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (2,'Ashwini Suresh','+91','9446885925','+91','8590217598','ashwini1suresh@gmail.com',0,0,0,0,0,0,'fb',1,1,1,1,1,1,1,1,0,'Applied','applied student','2026-01-29 06:39:39'),(4,'test student','+91','68995875822','+91','78586922558','',0,1,1,1,0,0,'',1,1,0,1,1,1,1,1,0,'Interested','intrested need o followup','2026-01-29 12:17:50'),(5,'test data','+91','9855600245','+91','6589555895','testdata@gmail.com',1,1,0,0,1,1,'facebook',1,1,0,0,1,1,1,1,0,'Interested','tested data','2026-01-29 12:28:17'),(6,'L1','+91','9099090909','+91','','',1,1,0,0,0,0,'',1,0,0,0,0,1,1,1,0,'Interested','es','2026-02-08 07:45:30'),(7,'Test1','+91','5895557458','+91','56875656552','Test1@gmail.com',1,0,1,0,0,0,'',1,1,0,0,0,1,1,1,0,'Interested','asdasa','2026-02-09 05:02:27'),(10,'sudheesh','+91','9099090909','+91','','',1,1,1,0,0,0,'',1,0,1,1,1,1,1,1,0,'Interested','saaa','2026-02-11 16:30:47'),(11,'ESDFS','+91','56323','+91','','',0,0,0,0,0,0,'',0,0,0,0,0,1,1,3,0,'','Dwdwdawd','2026-04-17 09:27:45'),(12,'riju','+91','9999999','+91','','sabu@',0,0,0,0,0,0,'ig',1,1,1,1,1,1,1,NULL,0,'Applied','good','2026-04-18 03:43:20'),(15,'malavika','+91','15165165','+91','','ytfytf@',0,0,0,0,0,0,'asdf',1,1,0,0,1,1,1,NULL,0,'New Lead',NULL,'2026-04-21 04:45:16'),(16,'jiju','+91','4554149515','+91','51951','sasas@',0,0,0,0,0,0,'ig',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-04-21 05:27:53'),(17,'max','+91','0123456789','+91','0123456789','max123',1,1,1,1,1,1,'youtube',1,1,1,1,0,1,1,3,0,'Interested','remark test','2026-04-23 11:21:57'),(18,'rger','+91','4545453545','+91','5454543543','454545',0,0,0,0,0,0,'54545454545',0,0,0,0,0,1,1,NULL,0,'New Lead',NULL,'2026-04-25 05:29:00'),(19,'test','+971','6565156511','+1','5733653453','emailtest',1,1,1,1,1,1,'test',1,1,1,1,1,1,1,3,0,'Interested','remark test','2026-04-29 06:40:28'),(22,'tess','+91','4352443544','+1','5345235235','3524',0,0,0,0,0,0,'asd',1,1,1,1,1,1,1,3,0,'Interested','remarks tess','2026-04-30 10:00:00'),(24,'kiro','+971','2354542325','+1','3454523524','123',1,1,1,1,1,1,'as',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-05-02 09:41:55'),(25,'non','+91','5234553254','+91','2345243534','',0,0,0,0,0,0,'non',0,0,0,0,0,1,1,NULL,0,'New Lead',NULL,'2026-05-02 09:48:08'),(26,'qq','+91','2543265634','+91','5346546546','4545',0,0,0,0,0,0,'qq',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-05-02 10:33:54');
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
  `program_type` varchar(50) DEFAULT NULL,
  `program` varchar(255) DEFAULT NULL,
  `applied_for` varchar(255) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggested_programs`
--

LOCK TABLES `suggested_programs` WRITE;
/*!40000 ALTER TABLE `suggested_programs` DISABLE KEYS */;
INSERT INTO `suggested_programs` VALUES (60,1,NULL,'STUDY Poland',NULL,'Bachelor Engineering - December 2026','Application Status','','',1,NULL,NULL,NULL),(61,1,NULL,'STUDY Canada',NULL,'Master Business - August 2025','Application Status','','',1,NULL,NULL,NULL),(62,1,NULL,'MIGRATION France',NULL,'Accountant - Tourist Visa','Application Status','','',1,NULL,NULL,NULL),(63,1,NULL,'MIGRATION Canada',NULL,'Software Engineer - Study Visa','Application Status','','',1,NULL,NULL,NULL),(64,1,NULL,'MIGRATION Georgia',NULL,'Chef - Spouse Visa','Application Status','','',1,NULL,NULL,NULL),(65,1,NULL,'VISA India',NULL,'Dependent Visa','Application Status','','',1,NULL,NULL,NULL),(66,1,NULL,'WORK Singapore',NULL,'Civil Engineer','Application Status','','',1,NULL,NULL,NULL),(67,1,NULL,'COACHING',NULL,'mtecj - A!','Application Status','','',1,NULL,NULL,NULL),(68,1,NULL,'STUDY United Kingdom',NULL,'High School Hospitality - December 2026','Application Status','','',1,NULL,NULL,NULL),(69,1,NULL,'MIGRATION France',NULL,'Civil Engineer - Spouse Visa','Application Status','','',1,NULL,NULL,NULL),(70,1,NULL,'WORK India',NULL,'Driver','Application Status','','',1,NULL,NULL,NULL),(150,2,NULL,'STUDY Latvia',NULL,'Diploma Science - -','one','one sub','',1,1,1,3),(151,2,NULL,'STUDY USA',NULL,'PhD Nursing - September 2024','Offer Received','','',1,1,1,1),(152,2,NULL,'VISA',NULL,'','Application Status','','',1,NULL,NULL,NULL),(153,2,NULL,'MIGRATION UAE',NULL,'-','two','two sub','',1,NULL,NULL,NULL),(154,2,NULL,'STUDY USA',NULL,'PhD Nursing - September 2028','Offer Received','','',1,1,4,NULL),(155,2,NULL,'COACHING',NULL,'','Application Status','','',1,NULL,NULL,NULL),(156,2,NULL,'',NULL,'','Application Status','','',1,NULL,NULL,NULL),(329,4,NULL,'STUDY USA',NULL,'Secondary Education Information Technology - October 2030','one','one sub','64',1,NULL,NULL,NULL),(349,5,NULL,'STUDY Australia',NULL,'Certificate III IV Agriculture - April 2025','','','',1,NULL,NULL,NULL),(362,6,NULL,'STUDY Australia',NULL,'Advanced Diploma Agriculture - April 2024','','','',1,NULL,NULL,NULL),(363,6,NULL,'Australia',NULL,'Accountant','','','',1,NULL,NULL,NULL),(416,3,NULL,'STUDY Canada',NULL,'Bachelor Business - August 2024','one','one sub','',1,1,NULL,NULL),(417,3,NULL,'',NULL,'','','','',1,NULL,NULL,NULL),(418,3,NULL,'',NULL,'','','','',1,NULL,NULL,NULL),(419,3,NULL,'MIGRATION Australia',NULL,'-','','','',1,NULL,NULL,NULL),(420,3,NULL,'MIGRATION Canada',NULL,'-','','','',1,NULL,NULL,NULL),(421,3,NULL,'MIGRATION India',NULL,'-','','','',1,NULL,NULL,NULL),(422,7,NULL,'STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025','','','',1,NULL,NULL,NULL),(423,7,NULL,'Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(767,8,NULL,'STUDY India',NULL,'Master Computing - April 2024','','','',1,NULL,NULL,NULL),(768,8,NULL,'Australia',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(769,8,NULL,'Canada1',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(770,8,NULL,'France',NULL,'Chef','','','',1,NULL,NULL,NULL),(771,8,NULL,'COACHING',NULL,'test course - inputted a','','','',1,NULL,NULL,NULL),(772,8,NULL,'MIGRATION Germany',NULL,'Marketing Specialist - for studies','','','',1,NULL,NULL,NULL),(1314,80,'STUDY','STUDY Australia',NULL,'Bachelor Agriculture - August 2025','','','',1,NULL,NULL,NULL),(1315,80,'MIGRATION','Australia',NULL,'Chef - for studies','','','',1,NULL,NULL,NULL),(1316,80,'VISA','Canada1',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(1317,80,'WORK','Canada1',NULL,'Civil Engineer','','','',1,NULL,NULL,NULL),(1318,80,'COACHING','COACHING',NULL,'test course - batch a','','','',1,NULL,NULL,NULL),(1349,16,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024','','','',1,NULL,NULL,NULL),(1350,16,'STUDY','STUDY Canada1',NULL,'Associate Degree Accounting - August 2025','','','',1,NULL,NULL,NULL),(1351,16,'OTHER','Australia',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(1352,16,'OTHER','Canada1',NULL,'Chef - for studies','','','',1,NULL,NULL,NULL),(1353,16,'OTHER','Australia',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(1354,16,'OTHER','Canada1',NULL,'Spouse Visa','','','',1,NULL,NULL,NULL),(1355,16,'OTHER','Australia',NULL,'Accountant','','','',1,NULL,NULL,NULL),(1356,16,'OTHER','Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(1357,16,'COACHING','COACHING',NULL,'test course - testa','','','',1,NULL,NULL,NULL),(1358,16,'COACHING','COACHING',NULL,'test course - testb','','','',1,NULL,NULL,NULL),(1369,87,'STUDY','STUDY France',NULL,'Advanced Diploma Accounting - April 2025','','','',1,NULL,NULL,NULL),(1370,87,'MIGRATION','Germany',NULL,'Chef - for studies','','','',1,NULL,NULL,NULL),(1371,87,'VISA','Australia',NULL,'Spouse Visa','','','',1,NULL,NULL,NULL),(1372,87,'WORK','France',NULL,'Chef','','','',1,NULL,NULL,NULL),(1373,87,'COACHING','COACHING',NULL,'test course - dsfd','','','',1,NULL,NULL,NULL),(1375,88,'STUDY','STUDY Poland',NULL,'Graduate Certificate Creative Arts - July 2027','one','one sub','',1,1,1,1),(1376,91,'STUDY','STUDY Australia',NULL,'Advanced Diploma Accounting - April 2024','','','',1,NULL,NULL,NULL),(1377,91,'MIGRATION','Germany',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(1378,91,'VISA','Australia',NULL,'Spouse Visa','','','',1,NULL,NULL,NULL),(1379,91,'WORK','Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(1380,91,'COACHING','COACHING',NULL,'test course - 343','','','',1,NULL,NULL,NULL);
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

-- Dump completed on 2026-05-02 16:10:35
