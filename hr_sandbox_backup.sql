-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: hr_sandbox
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.2

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
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departments` (
  `dept_id` int NOT NULL,
  `dept_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departments`
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` VALUES (1,'Engineering'),(2,'Sales'),(3,'Marketing');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employees` (
  `emp_id` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `Employees_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Departments` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (101,'Sarah','Connor',1,'2021-03-15'),(102,'John','Wick',2,'2022-01-10'),(103,'Ellen','Ripley',1,'2020-11-01'),(104,'Bruce','Wayne',3,'2023-06-01');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Performance_Reviews`
--

DROP TABLE IF EXISTS `Performance_Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Performance_Reviews` (
  `review_id` int NOT NULL,
  `emp_id` int DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `appraisal_score` int DEFAULT NULL,
  `leadership_potential` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `Performance_Reviews_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `Employees` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Performance_Reviews`
--

LOCK TABLES `Performance_Reviews` WRITE;
/*!40000 ALTER TABLE `Performance_Reviews` DISABLE KEYS */;
INSERT INTO `Performance_Reviews` VALUES (1,101,'2023-12-15',5,'High'),(2,102,'2023-12-15',3,'Medium'),(3,103,'2023-12-15',4,'High'),(4,104,'2023-12-15',2,'Low');
/*!40000 ALTER TABLE `Performance_Reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Salaries`
--

DROP TABLE IF EXISTS `Salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Salaries` (
  `emp_id` int DEFAULT NULL,
  `base_salary` decimal(10,2) DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `Salaries_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `Employees` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Salaries`
--

LOCK TABLES `Salaries` WRITE;
/*!40000 ALTER TABLE `Salaries` DISABLE KEYS */;
INSERT INTO `Salaries` VALUES (101,115000.00,'2023-01-01'),(102,85000.00,'2023-01-01'),(103,130000.00,'2023-01-01'),(104,75000.00,'2023-06-01');
/*!40000 ALTER TABLE `Salaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_compensation_quartiles`
--

DROP TABLE IF EXISTS `vw_compensation_quartiles`;
/*!50001 DROP VIEW IF EXISTS `vw_compensation_quartiles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_compensation_quartiles` AS SELECT 
 1 AS `Department`,
 1 AS `Employee`,
 1 AS `Salary`,
 1 AS `Dept_Rank`,
 1 AS `Company_Pay_Quartile`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_master_hr_report`
--

DROP TABLE IF EXISTS `vw_master_hr_report`;
/*!50001 DROP VIEW IF EXISTS `vw_master_hr_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_master_hr_report` AS SELECT 
 1 AS `emp_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `dept_name`,
 1 AS `hire_date`,
 1 AS `tenure_years`,
 1 AS `base_salary`,
 1 AS `appraisal_score`,
 1 AS `leadership_potential`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_compensation_quartiles`
--

/*!50001 DROP VIEW IF EXISTS `vw_compensation_quartiles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_compensation_quartiles` AS select `d`.`dept_name` AS `Department`,`e`.`first_name` AS `Employee`,`s`.`base_salary` AS `Salary`,rank() OVER (PARTITION BY `d`.`dept_name` ORDER BY `s`.`base_salary` desc )  AS `Dept_Rank`,ntile(4) OVER (ORDER BY `s`.`base_salary` )  AS `Company_Pay_Quartile` from ((`Employees` `e` join `Salaries` `s` on((`e`.`emp_id` = `s`.`emp_id`))) join `Departments` `d` on((`e`.`dept_id` = `d`.`dept_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_master_hr_report`
--

/*!50001 DROP VIEW IF EXISTS `vw_master_hr_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_master_hr_report` AS select `e`.`emp_id` AS `emp_id`,`e`.`first_name` AS `first_name`,`e`.`last_name` AS `last_name`,`d`.`dept_name` AS `dept_name`,`e`.`hire_date` AS `hire_date`,timestampdiff(YEAR,`e`.`hire_date`,curdate()) AS `tenure_years`,`s`.`base_salary` AS `base_salary`,`pr`.`appraisal_score` AS `appraisal_score`,`pr`.`leadership_potential` AS `leadership_potential` from (((`Employees` `e` join `Departments` `d` on((`e`.`dept_id` = `d`.`dept_id`))) join `Salaries` `s` on((`e`.`emp_id` = `s`.`emp_id`))) join `Performance_Reviews` `pr` on((`e`.`emp_id` = `pr`.`emp_id`))) */;
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

-- Dump completed on 2026-06-12 11:01:30
