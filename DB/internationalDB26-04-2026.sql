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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_children`
--

LOCK TABLES `application_children` WRITE;
/*!40000 ALTER TABLE `application_children` DISABLE KEYS */;
INSERT INTO `application_children` VALUES (75,6,NULL,1),(89,3,NULL,1),(151,8,12,1);
/*!40000 ALTER TABLE `application_children` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_ups`
--

LOCK TABLES `follow_ups` WRITE;
/*!40000 ALTER TABLE `follow_ups` DISABLE KEYS */;
INSERT INTO `follow_ups` VALUES (1,2,1,1,'Applied',1,'2026-01-29','applied student',1,'2026-01-29 06:39:39'),(3,4,2,2,'Interested',1,'2026-01-29','intrested need o followup',1,'2026-01-29 12:17:50'),(4,5,1,2,'Interested',1,'2026-01-29','tested data',1,'2026-01-29 12:28:17'),(5,6,1,2,'Interested',1,'2026-02-08','q',1,'2026-02-08 07:45:31'),(6,7,1,2,'Interested',1,'2026-02-09','need to call',1,'2026-02-09 05:02:28'),(7,10,1,1,'Interested',1,'2026-02-11','Initial Status: Interested',1,'2026-02-11 16:30:48'),(8,10,1,2,'Doubtful',1,'2026-03-12','h',1,'2026-03-12 14:31:53'),(9,10,1,NULL,'Interested',1,'2026-04-15','saaa',1,'2026-04-14 04:51:55'),(10,7,1,NULL,'Interested',1,'2026-04-16','asdasa',1,'2026-04-14 04:53:02'),(11,6,1,NULL,'Interested',1,'2026-04-07','es',1,'2026-04-14 04:53:23'),(12,11,1,4,'',3,'2026-04-18','Dwdwdawd',1,'2026-04-18 03:28:56'),(13,12,2,1,'Applied',NULL,'2026-04-22','good',1,'2026-04-18 03:43:20'),(14,17,1,2,'Interested',3,'2026-04-23','remark test',1,'2026-04-23 11:21:57');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_children`
--

LOCK TABLES `registration_children` WRITE;
/*!40000 ALTER TABLE `registration_children` DISABLE KEYS */;
INSERT INTO `registration_children` VALUES (9,5,12,1),(10,5,10,0);
/*!40000 ALTER TABLE `registration_children` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_suggested_programs`
--

LOCK TABLES `registration_suggested_programs` WRITE;
/*!40000 ALTER TABLE `registration_suggested_programs` DISABLE KEYS */;
INSERT INTO `registration_suggested_programs` VALUES (1,2,'STUDY Australia',NULL,'Certificate IV Agriculture - April 2025','','','',1,NULL,NULL,NULL),(2,3,'STUDY Australia',NULL,'Bachelor Business - August 2024','','','',1,NULL,NULL,NULL),(3,3,'STUDY France',NULL,'Bachelor Engineering - September 2024','','','',1,NULL,NULL,NULL),(4,3,'Canada',NULL,'Accountant - Dependent Visa','','','',1,NULL,NULL,NULL),(5,3,'India',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(6,3,'',NULL,'','','','',1,NULL,NULL,NULL),(7,3,'COACHING',NULL,'test course - test','','','',1,NULL,NULL,NULL),(8,4,'STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025','','','',1,NULL,NULL,NULL),(9,4,'Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(34,5,'STUDY India',NULL,'Master Computing - April 2024','','','',1,NULL,NULL,NULL),(35,5,'Australia',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(36,5,'Canada1',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(37,5,'France',NULL,'Chef','','','',1,NULL,NULL,NULL),(38,5,'COACHING',NULL,'test course - inputted a','','','',1,NULL,NULL,NULL),(39,5,'MIGRATION Germany',NULL,'Marketing Specialist - for studies','','','',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `registration_suggested_programs` ENABLE KEYS */;
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
  `education_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `migration_data` json DEFAULT NULL,
  `migration_spouse_data` json DEFAULT NULL,
  `relatives_data` json DEFAULT NULL,
  PRIMARY KEY (`application_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_applications`
--

LOCK TABLES `student_applications` WRITE;
/*!40000 ALTER TABLE `student_applications` DISABLE KEYS */;
INSERT INTO `student_applications` VALUES (1,2,'Ashwini Suresh',35,NULL,'Female','Single',0,'','','',NULL,NULL,'9446885925',NULL,NULL,'8590217598','ashwini1suresh@gmail.com','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','',NULL,'2026-02-05 11:06:21','2026-02-06 07:04:44','{\"Canada\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"Poland\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"United Kingdom\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}}','{\"India\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Canada\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"France\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Poland\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Georgia\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Australia\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"Singapore\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"United Kingdom\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}}','{\"India\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Canada\": {\"has_edu\": false, \"edu_field\": \"\", \"edu_level\": \"\"}, \"France\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Poland\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Georgia\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Australia\": {\"has_edu\": false, \"edu_field\": \"\", \"edu_level\": \"\"}, \"Singapore\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"United Kingdom\": {\"has_edu\": false, \"edu_field\": \"\", \"edu_level\": \"\"}}'),(2,7,'Test1',NULL,NULL,'Male','Single',0,'Australia','','',NULL,NULL,'5895557458',NULL,NULL,'56875656552','Test1@gmail.com','Australia',NULL,NULL,NULL,'Bachelor','Business',0,'','',0,'','',0,'','',0,'','',1,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"UAE\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"USA\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"Poland\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"Georgia\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"United Kingdom\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}}','2026-02-14 17:36:25','2026-02-23 15:14:48','{\"UAE\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"USA\": {\"has_edu\": true, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Poland\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Georgia\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"United Kingdom\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{\"UAE\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"USA\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Poland\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Georgia\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"United Kingdom\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{\"UAE\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"USA\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Poland\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Georgia\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"United Kingdom\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}}'),(3,10,'sudheesh',13,NULL,'Male','Married',1,'Latvia','200','200','+91',NULL,'9099090909','+971',NULL,'64654654','ggyuguyg@','Canada1','',0,'','Graduate Diploma','Engineering',1,'Advanced Diploma','Agriculture',1,'Advanced Diploma','Finance',0,'','',1,'','',1,'5','','2','',1,'IELTS','','','','',1,'GMAT','','','',30,'Bachelor',1,'','',1,'','',0,'','','','','','','IELTS','','','','',0,'','','{\"a\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"n\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"au\": {\"field\": \"\", \"level\": \"\", \"has_edu\": false}, \"India\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Canada\": {\"field\": \"Agriculture\", \"level\": \"Advanced Diploma\", \"status\": \"Completed\", \"has_edu\": true, \"additional_entries\": [], \"expected_completion\": \"2026-04\"}, \"Australia\": {\"field\": \"Finance\", \"level\": \"Advanced Diploma\", \"status\": \"Completed\", \"has_edu\": true, \"additional_entries\": []}, \"additional\": [], \"New Zealand\": {\"field\": \"\", \"level\": \"\", \"has_edu\": true}, \"spouse_education\": [], \"spouse_edu_status\": \"Not Completed\", \"spouse_edu_expected\": \"2026-04\", \"has_other_country_edu\": false, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"highest_education_expected\": \"2026-04\", \"spouse_has_other_country_edu\": true, \"spouse_other_country_edu_list\": [{\"field\": \"Engineering\", \"level\": \"Master\", \"status\": \"Not Completed\", \"expected_completion\": \"2026-04\"}]}','2026-03-13 14:19:58','2026-04-23 05:51:03','{\"a\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"n\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"au\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"India\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada\": {\"has_edu\": true, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Australia\": {\"has_edu\": true, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"2\", \"is_currently_working\": true, \"current_work_experience_list\": [{\"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"employment_country\": \"\"}]}, \"New Zealand\": {\"has_edu\": true, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{\"a\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"n\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"au\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"India\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada\": {\"status\": \"Completed\", \"has_edu\": true, \"has_work\": false, \"edu_field\": \"Hospitality\", \"edu_level\": \"Graduate Diploma\", \"work_years\": \"\", \"expected_completion\": \"2026-04\"}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Australia\": {\"status\": \"Completed\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Dentistry\", \"edu_level\": \"Certificate III\", \"work_years\": \"\", \"expected_completion\": \"2026-04\", \"is_currently_working\": false, \"current_work_experience_list\": [{\"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"employment_country\": \"\"}]}, \"New Zealand\": {\"has_edu\": true, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{\"a\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"n\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"au\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"India\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Canada\": {\"has_rel\": true, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Australia\": {\"has_rel\": true, \"related_to\": \"Applicant\", \"relationship\": \"Parent\"}, \"New Zealand\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}}'),(4,11,'ESDFS',21,NULL,'Male','Single',0,'United Kingdom','jn','jn',NULL,NULL,'56323',NULL,NULL,'5464654646','saaaaa@','United Kingdom',NULL,NULL,NULL,'Bachelor','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','yes','yes','yes',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"additional\": [], \"spouse_education\": [], \"spouse_edu_status\": \"Completed\", \"spouse_edu_expected\": \"\", \"has_other_country_edu\": false, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"highest_education_expected\": \"\", \"spouse_has_other_country_edu\": false, \"spouse_other_country_edu_list\": []}','2026-04-18 03:30:32','2026-04-18 03:37:55','{}','{\"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{}'),(5,12,'riju',22,NULL,'Male','Single',0,'Australia','tayankari','dd',NULL,NULL,'888888888888',NULL,NULL,'','sabu@1','',NULL,NULL,NULL,'Advanced Diploma','Accounting',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','','','',1,'','dd','dd','dd',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"additional\": [], \"spouse_education\": [], \"spouse_edu_status\": \"Completed\", \"spouse_edu_expected\": \"\", \"has_other_country_edu\": false, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"highest_education_expected\": \"\", \"spouse_has_other_country_edu\": false, \"spouse_other_country_edu_list\": []}','2026-04-18 03:44:18','2026-04-20 10:46:33','{}','{\"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{}'),(6,15,'malavika',6,NULL,'Male','Single',0,'Australia','ygy','rdr',NULL,NULL,'15165165',NULL,NULL,'6+265265265','ytfytf@','United Kingdom',NULL,NULL,NULL,'PhD','Information Technology',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','nu','uu','uh','hh',1,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"additional\": [], \"spouse_education\": [], \"spouse_edu_status\": \"Completed\", \"spouse_edu_expected\": \"\", \"has_other_country_edu\": true, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"highest_education_expected\": \"\", \"spouse_has_other_country_edu\": false, \"spouse_other_country_edu_list\": []}','2026-04-21 04:46:22','2026-04-21 04:46:22','{}','{\"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{}'),(7,16,'jiju',NULL,NULL,'Male','Single',0,'','','','+91',NULL,'4554149515','+91',NULL,'51951','sasas@','','',0,'','','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','','','yguyg',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"Other\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Canada\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Australia\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"additional\": [], \"New Zealand\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"spouse_education\": [], \"spouse_edu_status\": \"Completed\", \"spouse_edu_expected\": \"\", \"has_other_country_edu\": false, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"highest_education_expected\": \"\", \"spouse_has_other_country_edu\": false, \"spouse_other_country_edu_list\": []}','2026-04-21 05:56:37','2026-04-23 08:44:54','{}','{\"Other\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}, \"Australia\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"New Zealand\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}}','{}'),(8,17,'max',22,NULL,'Male','Married',1,'India','Kerala','Kochi','+971',NULL,'0123456789','+1',NULL,'0123456789','max@gmail.comww','Canada1','',0,'','Associate Degree','Education & Teaching',0,'','',1,'Bachelor','Agriculture',0,'','',0,'','',1,'','','','',1,'','','','','',1,'','','','',21,'Bachelor',1,'','',1,'','',0,'','','','1','2','3','','','','','',0,'','','{\"Other\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Canada\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Germany\": {\"field\": \"Health & Medicine\", \"level\": \"PhD\", \"status\": \"Not Completed\", \"has_edu\": true, \"additional_entries\": [], \"expected_completion\": \"2026-12\"}, \"Australia\": {\"field\": \"Agriculture\", \"level\": \"Bachelor\", \"status\": \"Not Completed\", \"has_edu\": true, \"additional_entries\": [{\"field\": \"Accounting\", \"level\": \"Bachelor\", \"status\": \"Completed\"}], \"expected_completion\": \"2026-04\"}, \"additional\": [{\"field\": \"Agriculture\", \"level\": \"Bachelor\", \"status\": \"Completed\"}], \"New Zealand\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"spouse_edu_field\": \"Accounting\", \"spouse_education\": [{\"field\": \"Information Technology\", \"level\": \"Master\", \"status\": \"Completed\"}], \"spouse_edu_status\": \"Not Completed\", \"language_test_list\": [{\"type\": \"IELTS\", \"reading\": \"6\", \"writing\": \"3\", \"speaking\": \"5\", \"listening\": \"4\"}, {\"type\": \"TOEFL\", \"reading\": \"34\", \"writing\": \"43\", \"speaking\": \"34\", \"listening\": \"434\"}], \"admission_test_list\": [{\"type\": \"GMAT\", \"quant\": \"2\", \"verbal\": \"3\", \"data_insights\": \"4\"}, {\"type\": \"GRE\", \"quant\": \"34\", \"verbal\": \"343\", \"data_insights\": \"43\"}], \"spouse_edu_expected\": \"2026-04\", \"has_other_country_edu\": true, \"other_country_edu_list\": [{\"field\": \"Accounting\", \"level\": \"Associate Degree\", \"status\": \"Not Completed\", \"expected_completion\": \"2026-04\"}, {\"field\": \"Architecture\", \"level\": \"Bachelor\", \"status\": \"Completed\", \"expected_completion\": \"\"}], \"highest_education_status\": \"Not Completed\", \"spouse_has_language_test\": true, \"spouse_language_test_list\": [{\"type\": \"IELTS\", \"reading\": \"9\", \"writing\": \"9\", \"speaking\": \"9\", \"listening\": \"9\"}, {\"type\": \"TOEFL\", \"reading\": \"7\", \"writing\": \"9\", \"speaking\": \"7\", \"listening\": \"7\"}], \"highest_education_expected\": \"2026-04\", \"spouse_has_other_country_edu\": true, \"spouse_other_country_edu_list\": [{\"field\": \"Hospitality\", \"level\": \"PG Diploma\", \"status\": \"Not Completed\", \"expected_completion\": \"2026-04\"}, {\"field\": \"Finance\", \"level\": \"Graduate Certificate\", \"status\": \"Completed\", \"expected_completion\": \"\"}]}','2026-04-24 04:51:24','2026-04-25 11:28:31','{\"India\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada1\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"work_experience_list\": [], \"has_other_work_experience\": true, \"other_work_experience_list\": [{\"job_title\": \"accounting typed5\", \"work_years\": 1, \"work_months\": 2, \"employment_country\": \"New Zealand\"}, {\"job_title\": \"typed6\", \"work_years\": 0, \"work_months\": 1, \"employment_country\": \"Latvia\"}]}, \"Germany\": {\"has_edu\": false, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": true, \"is_currently_working\": true, \"other_work_experience_list\": [{\"job_title\": \"accounting typed5\", \"work_years\": 2, \"work_months\": 0, \"employment_country\": \"\"}], \"current_work_experience_list\": [{\"job_title\": \"accounting typed5\", \"work_years\": 1, \"work_months\": 0, \"employment_country\": \"\"}]}, \"Australia\": {\"has_edu\": true, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": true, \"is_currently_working\": true, \"other_work_experience_list\": [{\"job_title\": \"accounting typed3\", \"work_years\": 4, \"work_months\": 0, \"employment_country\": \"\"}, {\"job_title\": \"accounting typed4\", \"work_years\": 0, \"work_months\": 6, \"employment_country\": \"\"}], \"current_work_experience_list\": [{\"job_title\": \"accounting typed\", \"work_years\": 2, \"work_months\": 4, \"employment_country\": \"\"}, {\"job_title\": \"accounting typed2\", \"work_years\": 1, \"work_months\": 0, \"employment_country\": \"\"}]}}','{\"India\": {\"status\": \"Completed\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"additional_entries\": [], \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Other\": {\"status\": \"\", \"has_edu\": false, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": 1, \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada\": {\"status\": \"\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Engineering\", \"edu_level\": \"High School\", \"work_years\": \"1\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada1\": {\"status\": \"Completed\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"additional_entries\": [], \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"spouse_has_other_work_experience\": true, \"spouse_other_work_experience_list\": [{\"job_title\": \"job5\", \"work_years\": 9, \"work_months\": 10, \"employment_country\": \"UAE\"}, {\"job_title\": \"job6\", \"work_years\": 11, \"work_months\": 12, \"employment_country\": \"New Zealand\"}]}, \"Germany\": {\"has_edu\": false, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": true, \"is_currently_working\": false, \"other_work_experience_list\": [{\"job_title\": \"job3\", \"work_years\": 5, \"work_months\": 6, \"employment_country\": \"\"}, {\"job_title\": \"job4\", \"work_years\": 7, \"work_months\": 8, \"employment_country\": \"\"}], \"current_work_experience_list\": []}, \"Australia\": {\"status\": \"Not Completed\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Environmental Science\", \"edu_level\": \"High School\", \"work_years\": \"2\", \"has_other_work\": false, \"additional_entries\": [{\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"expected_completion\": \"\"}], \"expected_completion\": \"2026-04\", \"is_currently_working\": true, \"other_work_experience_list\": [{\"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"employment_country\": \"\"}], \"current_work_experience_list\": [{\"job_title\": \"job1\", \"work_years\": 1, \"work_months\": 2, \"employment_country\": \"\"}, {\"job_title\": \"job2\", \"work_years\": 3, \"work_months\": 4, \"employment_country\": \"\"}]}, \"New Zealand\": {\"status\": \"Not Completed\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Environmental Science\", \"edu_level\": \"PG Diploma\", \"work_years\": \"3\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}}','{\"India\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Canada1\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Germany\": {\"has_rel\": true, \"related_to\": \"Applicant\", \"relationship\": \"Uncle/Aunty\"}, \"Australia\": {\"has_rel\": false, \"related_to\": \"Spouse\", \"relationship\": \"\"}}'),(9,18,'rger',22,NULL,'Other','Single',0,'','','','+91',NULL,'4545453545','+91',NULL,'5454543543','454545','','',0,'','','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"Other\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Canada\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Australia\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"additional\": [], \"New Zealand\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"spouse_edu_field\": \"\", \"spouse_education\": [], \"spouse_edu_status\": \"Completed\", \"language_test_list\": [], \"admission_test_list\": [], \"spouse_edu_expected\": \"\", \"has_other_country_edu\": false, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"spouse_has_language_test\": false, \"spouse_language_test_list\": [], \"highest_education_expected\": \"\", \"spouse_has_other_country_edu\": false, \"spouse_other_country_edu_list\": []}','2026-04-25 05:33:44','2026-04-25 10:43:14','{\"General\": {\"work_experience_list\": [], \"has_other_work_experience\": false, \"other_work_experience_list\": []}}','{\"Other\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"spouse_has_other_work_experience\": false, \"spouse_other_work_experience_list\": []}, \"Australia\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"New Zealand\": {\"status\": \"\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}}','{}');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_coaching`
--

LOCK TABLES `student_coaching` WRITE;
/*!40000 ALTER TABLE `student_coaching` DISABLE KEYS */;
INSERT INTO `student_coaching` VALUES (10,2,'mtecj','A!','2026-02-04 08:42:01'),(11,5,'','','2026-02-05 15:54:55'),(16,12,'','','2026-04-20 05:35:33'),(27,16,'','','2026-04-23 09:27:47'),(28,10,'test course','test','2026-04-23 09:38:12'),(36,17,'test course','inputted a','2026-04-25 05:31:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_migration`
--

LOCK TABLES `student_migration` WRITE;
/*!40000 ALTER TABLE `student_migration` DISABLE KEYS */;
INSERT INTO `student_migration` VALUES (6,4,'Canada','Chef','Spouse Visa','2026-01-29 12:17:50'),(18,2,'France','Accountant','Tourist Visa','2026-02-04 08:42:01'),(19,2,'Canada','Software Engineer','Study Visa','2026-02-04 08:42:01'),(20,2,'Georgia','Chef','Spouse Visa','2026-02-04 08:42:01'),(21,5,'Ireland','Accountant','Spouse Visa','2026-02-05 15:54:55'),(28,7,'United Kingdom','Driver','Spouse Visa','2026-02-17 19:42:13'),(38,12,'','','','2026-04-20 05:35:33'),(51,15,'','','','2026-04-23 09:15:46'),(54,16,'','','','2026-04-23 09:27:47'),(55,10,'Canada','Accountant','Dependent Visa','2026-04-23 09:38:12'),(63,17,'Australia','Accountant','for studies','2026-04-25 05:31:39');
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
  `education_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `migration_data` json DEFAULT NULL,
  `migration_spouse_data` json DEFAULT NULL,
  `relatives_data` json DEFAULT NULL,
  PRIMARY KEY (`registration_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `student_registrations_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_registrations`
--

LOCK TABLES `student_registrations` WRITE;
/*!40000 ALTER TABLE `student_registrations` DISABLE KEYS */;
INSERT INTO `student_registrations` VALUES (1,11,'ESDFS',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,'56323',NULL,'','','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"additional\": []}','2026-04-18 03:35:00','2026-04-18 03:35:00','{}','{\"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"work_experience_list\": []}}','{}'),(2,12,'riju',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,'7777777777',NULL,'','sabu@','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"additional\": []}','2026-04-18 03:45:29','2026-04-18 03:45:29','{}','{\"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"work_experience_list\": []}}','{}'),(3,10,'sudheesh',NULL,NULL,NULL,NULL,'Male','Single',0,'France','255','255',NULL,'9099090909',NULL,'','','',NULL,NULL,NULL,'','',0,'','',0,'','',0,'','',0,'','',0,'','','','',0,'','','','','',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"Canada\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"additional\": []}','2026-04-20 09:50:29','2026-04-20 09:50:29','{\"Canada\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"work_experience_list\": [], \"other_work_experience_list\": [], \"current_work_experience_list\": []}}','{\"Canada\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"work_experience_list\": [], \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"work_experience_list\": []}}','{\"Canada\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}}'),(4,16,'jiju',NULL,NULL,NULL,NULL,'Male','Single',0,'','','',NULL,'4554149515',NULL,'51951','sasas@','','',0,'','','',0,'','',0,'','',0,'','',0,'','',1,'','','','',1,'IELTS','','','','yguyg',0,'','','','',NULL,'',0,'','',0,'','',0,'','','','','','','','','','','',0,'','','{\"additional\": [], \"spouse_education\": [], \"spouse_edu_status\": \"Completed\", \"spouse_edu_expected\": \"\", \"has_other_country_edu\": false, \"other_country_edu_list\": [], \"highest_education_status\": \"Completed\", \"highest_education_expected\": \"\", \"spouse_has_other_country_edu\": false, \"spouse_other_country_edu_list\": []}','2026-04-21 05:56:59','2026-04-21 05:56:59','{}','{\"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\"}}','{}'),(5,17,'max','max','ver',1,'2025-04-01','Male','Married',1,'India','Kerala','Kochi','+971','0123456789','+91','0123456789','max@gmail.comww','Canada1','Germany',1,'New Zealand','Associate Degree','Education & Teaching',0,'','',1,'Bachelor','Agriculture',0,'','',0,'','',1,'','','','',1,'','','','','',1,'','','','',21,'Bachelor',1,'','',1,'','',0,'','','','1','2','3','IELTS','','','','',0,'','','{\"Other\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Canada\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"Germany\": {\"field\": \"Health & Medicine\", \"level\": \"PhD\", \"status\": \"Not Completed\", \"has_edu\": true, \"additional_entries\": [], \"expected_completion\": \"2026-12\"}, \"Australia\": {\"field\": \"Agriculture\", \"level\": \"Bachelor\", \"status\": \"Not Completed\", \"has_edu\": true, \"additional_entries\": [{\"field\": \"Accounting\", \"level\": \"Bachelor\", \"status\": \"Completed\"}], \"expected_completion\": \"2026-04\"}, \"additional\": [{\"field\": \"Agriculture\", \"level\": \"Bachelor\", \"status\": \"Completed\"}], \"New Zealand\": {\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"has_edu\": false, \"additional_entries\": [], \"expected_completion\": \"\"}, \"spouse_edu_field\": \"Accounting\", \"spouse_education\": [{\"field\": \"Information Technology\", \"level\": \"Master\", \"status\": \"Completed\"}], \"spouse_edu_status\": \"Not Completed\", \"language_test_list\": [{\"type\": \"IELTS\", \"reading\": \"6\", \"writing\": \"3\", \"speaking\": \"5\", \"listening\": \"4\"}, {\"type\": \"TOEFL\", \"reading\": \"34\", \"writing\": \"43\", \"speaking\": \"34\", \"listening\": \"434\"}], \"admission_test_list\": [{\"type\": \"GMAT\", \"quant\": \"2\", \"verbal\": \"3\", \"data_insights\": \"4\"}, {\"type\": \"GRE\", \"quant\": \"34\", \"verbal\": \"343\", \"data_insights\": \"43\"}], \"spouse_edu_expected\": \"2026-04\", \"has_other_country_edu\": true, \"other_country_edu_list\": [{\"field\": \"Accounting\", \"level\": \"Associate Degree\", \"status\": \"Not Completed\", \"expected_completion\": \"2026-04\"}, {\"field\": \"Architecture\", \"level\": \"Bachelor\", \"status\": \"Completed\", \"expected_completion\": \"\"}], \"highest_education_status\": \"Not Completed\", \"spouse_has_language_test\": true, \"spouse_language_test_list\": [{\"type\": \"IELTS\", \"reading\": \"9\", \"writing\": \"9\", \"speaking\": \"9\", \"listening\": \"9\"}, {\"type\": \"TOEFL\", \"reading\": \"7\", \"writing\": \"9\", \"speaking\": \"7\", \"listening\": \"7\"}], \"highest_education_expected\": \"2026-04\", \"spouse_has_other_country_edu\": true, \"spouse_other_country_edu_list\": [{\"field\": \"Hospitality\", \"level\": \"PG Diploma\", \"status\": \"Not Completed\", \"expected_completion\": \"2026-04\"}, {\"field\": \"Finance\", \"level\": \"Graduate Certificate\", \"status\": \"Completed\", \"expected_completion\": \"\"}]}','2026-04-25 11:07:15','2026-04-25 11:29:55','{\"India\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada1\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"work_experience_list\": [], \"has_other_work_experience\": true, \"other_work_experience_list\": [{\"job_title\": \"accounting typed5\", \"work_years\": 1, \"work_months\": 2, \"employment_country\": \"New Zealand\"}, {\"job_title\": \"typed6\", \"work_years\": 0, \"work_months\": 1, \"employment_country\": \"Latvia\"}]}, \"Germany\": {\"has_edu\": false, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": true, \"is_currently_working\": true, \"other_work_experience_list\": [{\"job_title\": \"accounting typed5\", \"work_years\": 2, \"work_months\": 0, \"employment_country\": \"\"}], \"current_work_experience_list\": [{\"job_title\": \"accounting typed5\", \"work_years\": 1, \"work_months\": 0, \"employment_country\": \"\"}]}, \"Australia\": {\"has_edu\": true, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": true, \"is_currently_working\": true, \"other_work_experience_list\": [{\"job_title\": \"accounting typed3\", \"work_years\": 4, \"work_months\": 0, \"employment_country\": \"\"}, {\"job_title\": \"accounting typed4\", \"work_years\": 0, \"work_months\": 6, \"employment_country\": \"\"}], \"current_work_experience_list\": [{\"job_title\": \"accounting typed\", \"work_years\": 2, \"work_months\": 4, \"employment_country\": \"\"}, {\"job_title\": \"accounting typed2\", \"work_years\": 1, \"work_months\": 0, \"employment_country\": \"\"}]}}','{\"India\": {\"status\": \"Completed\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"additional_entries\": [], \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Other\": {\"status\": \"\", \"has_edu\": false, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": 1, \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada\": {\"status\": \"\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Engineering\", \"edu_level\": \"High School\", \"work_years\": \"1\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"Canada1\": {\"status\": \"Completed\", \"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": false, \"additional_entries\": [], \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}, \"General\": {\"has_edu\": false, \"has_work\": false, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"spouse_has_other_work_experience\": true, \"spouse_other_work_experience_list\": [{\"job_title\": \"job5\", \"work_years\": 9, \"work_months\": 10, \"employment_country\": \"UAE\"}, {\"job_title\": \"job6\", \"work_years\": 11, \"work_months\": 12, \"employment_country\": \"New Zealand\"}]}, \"Germany\": {\"has_edu\": false, \"has_work\": true, \"edu_field\": \"\", \"edu_level\": \"\", \"work_years\": \"\", \"has_other_work\": true, \"is_currently_working\": false, \"other_work_experience_list\": [{\"job_title\": \"job3\", \"work_years\": 5, \"work_months\": 6, \"employment_country\": \"\"}, {\"job_title\": \"job4\", \"work_years\": 7, \"work_months\": 8, \"employment_country\": \"\"}], \"current_work_experience_list\": []}, \"Australia\": {\"status\": \"Not Completed\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Environmental Science\", \"edu_level\": \"High School\", \"work_years\": \"2\", \"has_other_work\": false, \"additional_entries\": [{\"field\": \"\", \"level\": \"\", \"status\": \"Completed\", \"expected_completion\": \"\"}], \"expected_completion\": \"2026-04\", \"is_currently_working\": true, \"other_work_experience_list\": [{\"job_title\": \"\", \"work_years\": \"\", \"work_months\": \"\", \"employment_country\": \"\"}], \"current_work_experience_list\": [{\"job_title\": \"job1\", \"work_years\": 1, \"work_months\": 2, \"employment_country\": \"\"}, {\"job_title\": \"job2\", \"work_years\": 3, \"work_months\": 4, \"employment_country\": \"\"}]}, \"New Zealand\": {\"status\": \"Not Completed\", \"has_edu\": true, \"has_work\": true, \"edu_field\": \"Environmental Science\", \"edu_level\": \"PG Diploma\", \"work_years\": \"3\", \"has_other_work\": false, \"is_currently_working\": false, \"other_work_experience_list\": [], \"current_work_experience_list\": []}}','{\"India\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Canada1\": {\"has_rel\": false, \"related_to\": \"Applicant\", \"relationship\": \"\"}, \"Germany\": {\"has_rel\": true, \"related_to\": \"Applicant\", \"relationship\": \"Uncle/Aunty\"}, \"Australia\": {\"has_rel\": false, \"related_to\": \"Spouse\", \"relationship\": \"\"}}');
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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_study_programs`
--

LOCK TABLES `student_study_programs` WRITE;
/*!40000 ALTER TABLE `student_study_programs` DISABLE KEYS */;
INSERT INTO `student_study_programs` VALUES (6,4,'Germany','Bachelor','Business','April',2025,'2026-01-29 12:17:50'),(7,4,'Australia','Diploma','Engineering','August',2026,'2026-01-29 12:17:50'),(20,2,'Australia','Bachelor','Engineering','December',2026,'2026-02-04 08:42:01'),(21,2,'Canada','Master','Business','August',2025,'2026-02-04 08:42:01'),(22,5,'Georgia','High School','Hospitality','February',2027,'2026-02-05 15:54:55'),(23,5,'France','Graduate Certificate','Hospitality','February',2026,'2026-02-05 15:54:55'),(35,6,'Singapore','PG Diploma','Business','October',2024,'2026-02-09 10:08:16'),(37,7,'Poland','Master','Engineering','November',2025,'2026-02-17 19:42:12'),(38,7,'Georgia','PG Diploma','Business','November',2026,'2026-02-17 19:42:12'),(39,7,'Ireland','Bachelor','Business','September',2024,'2026-02-17 19:42:13'),(54,12,'Australia','Certificate IV','Agriculture','April',2025,'2026-04-20 05:35:33'),(74,15,'Australia','Advanced Diploma','Agriculture','April',2024,'2026-04-23 09:15:46'),(79,16,'Australia','Advanced Diploma','Accounting','April',2025,'2026-04-23 09:27:47'),(80,10,'Australia','Bachelor','Business','August',2024,'2026-04-23 09:38:12'),(81,10,'France','Bachelor','Engineering','September',2024,'2026-04-23 09:38:12'),(89,17,'India','Master','Computing','April',2024,'2026-04-25 05:31:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_visa`
--

LOCK TABLES `student_visa` WRITE;
/*!40000 ALTER TABLE `student_visa` DISABLE KEYS */;
INSERT INTO `student_visa` VALUES (3,4,'Georgia','Study Visa','2026-01-29 12:17:50'),(4,4,'Canada','Study Visa','2026-01-29 12:17:50'),(9,2,'India','Dependent Visa','2026-02-04 08:42:01'),(19,12,'','','2026-04-20 05:35:33'),(30,16,'','','2026-04-23 09:27:47'),(31,10,'India','Dependent Visa','2026-04-23 09:38:12'),(35,17,'Canada1','Spouse Visa','2026-04-25 05:31:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_work`
--

LOCK TABLES `student_work` WRITE;
/*!40000 ALTER TABLE `student_work` DISABLE KEYS */;
INSERT INTO `student_work` VALUES (3,4,'France','Civil Engineer','2026-01-29 12:17:50'),(8,2,'Singapore','Civil Engineer','2026-02-04 08:42:01'),(9,5,'France','Accountant','2026-02-05 15:54:55'),(18,12,'','','2026-04-20 05:35:33'),(34,15,'Australia','Accountant','2026-04-23 09:15:46'),(37,16,'Canada1','Chef','2026-04-23 09:27:47'),(38,10,'','','2026-04-23 09:38:12');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (2,'Ashwini Suresh','+91','9446885925','+91','8590217598','ashwini1suresh@gmail.com',0,0,0,0,0,0,'fb',1,1,1,1,1,1,1,1,0,'Applied','applied student','2026-01-29 06:39:39'),(4,'test student','+91','68995875822','+91','78586922558','',0,1,1,1,0,0,'',1,1,0,1,1,1,1,1,0,'Interested','intrested need o followup','2026-01-29 12:17:50'),(5,'test data','+91','9855600245','+91','6589555895','testdata@gmail.com',1,1,0,0,1,1,'facebook',1,1,0,0,1,1,1,1,0,'Interested','tested data','2026-01-29 12:28:17'),(6,'L1','+91','9099090909','+91','','',1,1,0,0,0,0,'',1,0,0,0,0,1,1,1,0,'Interested','es','2026-02-08 07:45:30'),(7,'Test1','+91','5895557458','+91','56875656552','Test1@gmail.com',1,0,1,0,0,0,'',1,1,0,0,0,1,1,1,0,'Interested','asdasa','2026-02-09 05:02:27'),(10,'sudheesh','+91','9099090909','+91','','',1,1,1,0,0,0,'',1,0,1,1,1,1,1,1,0,'Interested','saaa','2026-02-11 16:30:47'),(11,'ESDFS','+91','56323','+91','','',0,0,0,0,0,0,'',0,0,0,0,0,1,1,3,0,'','Dwdwdawd','2026-04-17 09:27:45'),(12,'riju','+91','9999999','+91','','sabu@',0,0,0,0,0,0,'ig',1,1,1,1,1,1,1,NULL,0,'Applied','good','2026-04-18 03:43:20'),(15,'malavika','+91','15165165','+91','','ytfytf@',0,0,0,0,0,0,'asdf',1,1,0,0,1,1,1,NULL,0,'New Lead',NULL,'2026-04-21 04:45:16'),(16,'jiju','+91','4554149515','+91','51951','sasas@',0,0,0,0,0,0,'ig',1,1,1,1,1,1,1,NULL,0,'New Lead',NULL,'2026-04-21 05:27:53'),(17,'max','+91','0123456789','+91','0123456789','max123',1,1,1,1,1,1,'youtube',1,1,1,1,0,1,1,3,0,'Interested','remark test','2026-04-23 11:21:57'),(18,'rger','+91','4545453545','+91','5454543543','454545',0,0,0,0,0,0,'54545454545',0,0,0,0,0,1,1,NULL,0,'New Lead',NULL,'2026-04-25 05:29:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=773 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggested_programs`
--

LOCK TABLES `suggested_programs` WRITE;
/*!40000 ALTER TABLE `suggested_programs` DISABLE KEYS */;
INSERT INTO `suggested_programs` VALUES (60,1,'STUDY Poland',NULL,'Bachelor Engineering - December 2026','Application Status','','',1,NULL,NULL,NULL),(61,1,'STUDY Canada',NULL,'Master Business - August 2025','Application Status','','',1,NULL,NULL,NULL),(62,1,'MIGRATION France',NULL,'Accountant - Tourist Visa','Application Status','','',1,NULL,NULL,NULL),(63,1,'MIGRATION Canada',NULL,'Software Engineer - Study Visa','Application Status','','',1,NULL,NULL,NULL),(64,1,'MIGRATION Georgia',NULL,'Chef - Spouse Visa','Application Status','','',1,NULL,NULL,NULL),(65,1,'VISA India',NULL,'Dependent Visa','Application Status','','',1,NULL,NULL,NULL),(66,1,'WORK Singapore',NULL,'Civil Engineer','Application Status','','',1,NULL,NULL,NULL),(67,1,'COACHING',NULL,'mtecj - A!','Application Status','','',1,NULL,NULL,NULL),(68,1,'STUDY United Kingdom',NULL,'High School Hospitality - December 2026','Application Status','','',1,NULL,NULL,NULL),(69,1,'MIGRATION France',NULL,'Civil Engineer - Spouse Visa','Application Status','','',1,NULL,NULL,NULL),(70,1,'WORK India',NULL,'Driver','Application Status','','',1,NULL,NULL,NULL),(150,2,'STUDY Latvia',NULL,'Diploma Science - -','one','one sub','',1,1,1,3),(151,2,'STUDY USA',NULL,'PhD Nursing - September 2024','Offer Received','','',1,1,1,1),(152,2,'VISA',NULL,'','Application Status','','',1,NULL,NULL,NULL),(153,2,'MIGRATION UAE',NULL,'-','two','two sub','',1,NULL,NULL,NULL),(154,2,'STUDY USA',NULL,'PhD Nursing - September 2028','Offer Received','','',1,1,4,NULL),(155,2,'COACHING',NULL,'','Application Status','','',1,NULL,NULL,NULL),(156,2,'',NULL,'','Application Status','','',1,NULL,NULL,NULL),(329,4,'STUDY USA',NULL,'Secondary Education Information Technology - October 2030','one','one sub','64',1,NULL,NULL,NULL),(349,5,'STUDY Australia',NULL,'Certificate III IV Agriculture - April 2025','','','',1,NULL,NULL,NULL),(362,6,'STUDY Australia',NULL,'Advanced Diploma Agriculture - April 2024','','','',1,NULL,NULL,NULL),(363,6,'Australia',NULL,'Accountant','','','',1,NULL,NULL,NULL),(416,3,'STUDY Canada',NULL,'Bachelor Business - August 2024','one','one sub','',1,1,NULL,NULL),(417,3,'',NULL,'','','','',1,NULL,NULL,NULL),(418,3,'',NULL,'','','','',1,NULL,NULL,NULL),(419,3,'MIGRATION Australia',NULL,'-','','','',1,NULL,NULL,NULL),(420,3,'MIGRATION Canada',NULL,'-','','','',1,NULL,NULL,NULL),(421,3,'MIGRATION India',NULL,'-','','','',1,NULL,NULL,NULL),(422,7,'STUDY Australia',NULL,'Advanced Diploma Accounting - April 2025','','','',1,NULL,NULL,NULL),(423,7,'Canada1',NULL,'Chef','','','',1,NULL,NULL,NULL),(767,8,'STUDY India',NULL,'Master Computing - April 2024','','','',1,NULL,NULL,NULL),(768,8,'Australia',NULL,'Accountant - for studies','','','',1,NULL,NULL,NULL),(769,8,'Canada1',NULL,'Dependent Visa','','','',1,NULL,NULL,NULL),(770,8,'France',NULL,'Chef','','','',1,NULL,NULL,NULL),(771,8,'COACHING',NULL,'test course - inputted a','','','',1,NULL,NULL,NULL),(772,8,'MIGRATION Germany',NULL,'Marketing Specialist - for studies','','','',1,NULL,NULL,NULL);
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

-- Dump completed on 2026-04-27 10:42:06
