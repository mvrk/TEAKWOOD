-- MySQL dump 10.13  Distrib 5.6.21, for Linux (x86_64)
--
-- Host: localhost    Database: TEAKWOOD
-- ------------------------------------------------------
-- Server version	5.6.21

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
-- Table structure for table `accounts_userprofile`
--

DROP TABLE IF EXISTS `accounts_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `affiliation` varchar(256) DEFAULT NULL,
  `description` longtext,
  `theme` varchar(32) DEFAULT NULL,
  `public_profile` tinyint(1) NOT NULL,
  `show_hints` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_81d7010f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_userprofile`
--

LOCK TABLES `accounts_userprofile` WRITE;
/*!40000 ALTER TABLE `accounts_userprofile` DISABLE KEYS */;
INSERT INTO `accounts_userprofile` VALUES (1,1,'','','','','base',1,0),(2,3,NULL,NULL,NULL,NULL,'smoothness',1,0);
/*!40000 ALTER TABLE `accounts_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'development'),(1,'teakwood');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add registration profile',8,'add_registrationprofile'),(23,'Can change registration profile',8,'change_registrationprofile'),(24,'Can delete registration profile',8,'delete_registrationprofile'),(25,'Can add task state',9,'add_taskmeta'),(26,'Can change task state',9,'change_taskmeta'),(27,'Can delete task state',9,'delete_taskmeta'),(28,'Can add saved group result',10,'add_tasksetmeta'),(29,'Can change saved group result',10,'change_tasksetmeta'),(30,'Can delete saved group result',10,'delete_tasksetmeta'),(31,'Can add interval',11,'add_intervalschedule'),(32,'Can change interval',11,'change_intervalschedule'),(33,'Can delete interval',11,'delete_intervalschedule'),(34,'Can add crontab',12,'add_crontabschedule'),(35,'Can change crontab',12,'change_crontabschedule'),(36,'Can delete crontab',12,'delete_crontabschedule'),(37,'Can add periodic tasks',13,'add_periodictasks'),(38,'Can change periodic tasks',13,'change_periodictasks'),(39,'Can delete periodic tasks',13,'delete_periodictasks'),(40,'Can add periodic task',14,'add_periodictask'),(41,'Can change periodic task',14,'change_periodictask'),(42,'Can delete periodic task',14,'delete_periodictask'),(43,'Can add worker',15,'add_workerstate'),(44,'Can change worker',15,'change_workerstate'),(45,'Can delete worker',15,'delete_workerstate'),(46,'Can add task',16,'add_taskstate'),(47,'Can change task',16,'change_taskstate'),(48,'Can delete task',16,'delete_taskstate'),(49,'Can add machine',17,'add_machine'),(50,'Can change machine',17,'change_machine'),(51,'Can delete machine',17,'delete_machine'),(52,'Can add script template',18,'add_scripttemplate'),(53,'Can change script template',18,'change_scripttemplate'),(54,'Can delete script template',18,'delete_scripttemplate'),(55,'Can add job',19,'add_job'),(56,'Can change job',19,'change_job'),(57,'Can delete job',19,'delete_job'),(58,'Can add comparison',20,'add_comparison'),(59,'Can change comparison',20,'change_comparison'),(60,'Can delete comparison',20,'delete_comparison'),(61,'Can add coastal model',21,'add_coastalmodel'),(62,'Can change coastal model',21,'change_coastalmodel'),(63,'Can delete coastal model',21,'delete_coastalmodel'),(64,'Can add model input',22,'add_modelinput'),(65,'Can change model input',22,'change_modelinput'),(66,'Can delete model input',22,'delete_modelinput'),(67,'Can add swan parameters',23,'add_swanparameters'),(68,'Can change swan parameters',23,'change_swanparameters'),(69,'Can delete swan parameters',23,'delete_swanparameters'),(70,'Can add swan config',24,'add_swanconfig'),(71,'Can change swan config',24,'change_swanconfig'),(72,'Can delete swan config',24,'delete_swanconfig'),(73,'Can add delft3d parameters',25,'add_delft3dparameters'),(74,'Can change delft3d parameters',25,'change_delft3dparameters'),(75,'Can delete delft3d parameters',25,'delete_delft3dparameters'),(76,'Can add delft3d config',26,'add_delft3dconfig'),(77,'Can change delft3d config',26,'change_delft3dconfig'),(78,'Can delete delft3d config',26,'delete_delft3dconfig'),(79,'Can add fvcom config',27,'add_fvcomconfig'),(80,'Can change fvcom config',27,'change_fvcomconfig'),(81,'Can delete fvcom config',27,'delete_fvcomconfig'),(82,'Can add adcirc parameters',28,'add_adcircparameters'),(83,'Can change adcirc parameters',28,'change_adcircparameters'),(84,'Can delete adcirc parameters',28,'delete_adcircparameters'),(85,'Can add adcirccera',29,'add_adcirccera'),(86,'Can change adcirccera',29,'change_adcirccera'),(87,'Can delete adcirccera',29,'delete_adcirccera'),(88,'Can add adcirc config',30,'add_adcircconfig'),(89,'Can change adcirc config',30,'change_adcircconfig'),(90,'Can delete adcirc config',30,'delete_adcircconfig'),(91,'Can add ca funwave parameters',31,'add_cafunwaveparameters'),(92,'Can change ca funwave parameters',31,'change_cafunwaveparameters'),(93,'Can delete ca funwave parameters',31,'delete_cafunwaveparameters'),(94,'Can add ca funwave config',32,'add_cafunwaveconfig'),(95,'Can change ca funwave config',32,'change_cafunwaveconfig'),(96,'Can delete ca funwave config',32,'delete_cafunwaveconfig'),(97,'Can add efdc parameters',33,'add_efdcparameters'),(98,'Can change efdc parameters',33,'change_efdcparameters'),(99,'Can delete efdc parameters',33,'delete_efdcparameters'),(100,'Can add efdc config',34,'add_efdcconfig'),(101,'Can change efdc config',34,'change_efdcconfig'),(102,'Can delete efdc config',34,'delete_efdcconfig'),(103,'Can add station',35,'add_station'),(104,'Can change station',35,'change_station'),(105,'Can delete station',35,'delete_station'),(106,'Can add data request',36,'add_datarequest'),(107,'Can change data request',36,'change_datarequest'),(108,'Can delete data request',36,'delete_datarequest'),(109,'Can add buoy data',37,'add_buoydata'),(110,'Can change buoy data',37,'change_buoydata'),(111,'Can delete buoy data',37,'delete_buoydata'),(112,'Can add tide data',38,'add_tidedata'),(113,'Can change tide data',38,'change_tidedata'),(114,'Can delete tide data',38,'delete_tidedata'),(115,'Can add current data',39,'add_currentdata'),(116,'Can change current data',39,'change_currentdata'),(117,'Can delete current data',39,'delete_currentdata'),(118,'Can add report',40,'add_report'),(119,'Can change report',40,'change_report'),(120,'Can delete report',40,'delete_report'),(121,'Can add domain',41,'add_domain'),(122,'Can change domain',41,'change_domain'),(123,'Can delete domain',41,'delete_domain'),(124,'Can add plot obs',42,'add_plotobs'),(125,'Can change plot obs',42,'change_plotobs'),(126,'Can delete plot obs',42,'delete_plotobs'),(127,'Can add sim ts data',43,'add_simtsdata'),(128,'Can change sim ts data',43,'change_simtsdata'),(129,'Can delete sim ts data',43,'delete_simtsdata'),(130,'Can add plot sim',44,'add_plotsim'),(131,'Can change plot sim',44,'change_plotsim'),(132,'Can delete plot sim',44,'delete_plotsim'),(133,'Can add model input data',45,'add_modelinputdata'),(134,'Can change model input data',45,'change_modelinputdata'),(135,'Can delete model input data',45,'delete_modelinputdata'),(136,'Can add project',46,'add_project'),(137,'Can change project',46,'change_project'),(138,'Can delete project',46,'delete_project'),(139,'Can add user profile',47,'add_userprofile'),(140,'Can change user profile',47,'change_userprofile'),(141,'Can delete user profile',47,'delete_userprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'rguo','','','guojiarui@gmail.com','pbkdf2_sha256$10000$eoIs1cYxc93T$AxYX5IBAV+ln2JnrpAolCxje0OoZLcXHfgBD7nHeCzg=',1,1,1,'2014-10-10 05:25:59','2014-10-09 15:06:02'),(3,'alex','rui','guo','mvrk.guo@gmail.com','pbkdf2_sha256$10000$txA8zloGDCIC$2TpsIF8ZhfwA2T0lM6BlNTdyMuHgAR83XmPuCi3G46s=',0,1,0,'2014-10-10 02:14:51','2014-10-10 02:11:25');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `celery_taskmeta`
--

DROP TABLE IF EXISTS `celery_taskmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_taskmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` longtext,
  `date_done` datetime NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `celery_taskmeta_c91f1bf` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_taskmeta`
--

LOCK TABLES `celery_taskmeta` WRITE;
/*!40000 ALTER TABLE `celery_taskmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_taskmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `celery_tasksetmeta`
--

DROP TABLE IF EXISTS `celery_tasksetmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_tasksetmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskset_id` varchar(255) NOT NULL,
  `result` longtext NOT NULL,
  `date_done` datetime NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taskset_id` (`taskset_id`),
  KEY `celery_tasksetmeta_c91f1bf` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_tasksetmeta`
--

LOCK TABLES `celery_tasksetmeta` WRITE;
/*!40000 ALTER TABLE `celery_tasksetmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_tasksetmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_adcirccera`
--

DROP TABLE IF EXISTS `coastalmodels_adcirccera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_adcirccera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adcircid` varchar(60) DEFAULT NULL,
  `grid` varchar(60) DEFAULT NULL,
  `windmodel` varchar(60) DEFAULT NULL,
  `desc_short` varchar(60) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `hostname` varchar(60) DEFAULT NULL,
  `downloadurl` varchar(60) DEFAULT NULL,
  `elev` varchar(60) DEFAULT NULL,
  `elev_fmt` varchar(60) DEFAULT NULL,
  `wvel` varchar(60) DEFAULT NULL,
  `wvel_fmt` varchar(60) DEFAULT NULL,
  `hsign` varchar(60) DEFAULT NULL,
  `hsign_fmt` varchar(60) DEFAULT NULL,
  `tps` varchar(60) DEFAULT NULL,
  `tps_fmt` varchar(60) DEFAULT NULL,
  `maxelev` varchar(60) DEFAULT NULL,
  `maxelev_fmt` varchar(60) DEFAULT NULL,
  `maxwvel` varchar(60) DEFAULT NULL,
  `maxwvel_fmt` varchar(60) DEFAULT NULL,
  `maxhsign` varchar(60) DEFAULT NULL,
  `maxhsign_fmt` varchar(60) DEFAULT NULL,
  `maxtps` varchar(60) DEFAULT NULL,
  `maxtps_fmt` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_adcirccera`
--

LOCK TABLES `coastalmodels_adcirccera` WRITE;
/*!40000 ALTER TABLE `coastalmodels_adcirccera` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_adcirccera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_adcircconfig`
--

DROP TABLE IF EXISTS `coastalmodels_adcircconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_adcircconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) NOT NULL,
  `swan` tinyint(1) NOT NULL,
  `processor_number` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_input_id` (`model_input_id`),
  KEY `coastalmodels_adcircconfig_fbfc09f1` (`user_id`),
  KEY `coastalmodels_adcircconfig_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_fac573b` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_10f0260e` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `user_id_refs_id_5ddbf29c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_adcircconfig`
--

LOCK TABLES `coastalmodels_adcircconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_adcircconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_adcircconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_adcircparameters`
--

DROP TABLE IF EXISTS `coastalmodels_adcircparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_adcircparameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `coastalmodels_adcircparameters_fbfc09f1` (`user_id`),
  KEY `coastalmodels_adcircparameters_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_468a0619` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_ca22e2fa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_adcircparameters`
--

LOCK TABLES `coastalmodels_adcircparameters` WRITE;
/*!40000 ALTER TABLE `coastalmodels_adcircparameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_adcircparameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_cafunwaveconfig`
--

DROP TABLE IF EXISTS `coastalmodels_cafunwaveconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_cafunwaveconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) NOT NULL,
  `parameters_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_input_id` (`model_input_id`),
  UNIQUE KEY `parameters_id` (`parameters_id`),
  KEY `coastalmodels_cafunwaveconfig_fbfc09f1` (`user_id`),
  KEY `coastalmodels_cafunwaveconfig_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_e00fd526` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_c3a640ef` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `parameters_id_refs_id_a24fd201` FOREIGN KEY (`parameters_id`) REFERENCES `coastalmodels_cafunwaveparameters` (`id`),
  CONSTRAINT `user_id_refs_id_b7915213` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_cafunwaveconfig`
--

LOCK TABLES `coastalmodels_cafunwaveconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_cafunwaveconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_cafunwaveconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_cafunwaveparameters`
--

DROP TABLE IF EXISTS `coastalmodels_cafunwaveparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_cafunwaveparameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `coastalmodels_cafunwaveparameters_fbfc09f1` (`user_id`),
  KEY `coastalmodels_cafunwaveparameters_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_92ba97e0` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_4064c27f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_cafunwaveparameters`
--

LOCK TABLES `coastalmodels_cafunwaveparameters` WRITE;
/*!40000 ALTER TABLE `coastalmodels_cafunwaveparameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_cafunwaveparameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_coastalmodel`
--

DROP TABLE IF EXISTS `coastalmodels_coastalmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_coastalmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `version` varchar(20) NOT NULL,
  `description` longtext,
  `image` varchar(100) NOT NULL,
  `web_site` varchar(200) DEFAULT NULL,
  `parfile_name` varchar(60) DEFAULT NULL,
  `parfile_extension` varchar(5) DEFAULT NULL,
  `config_editor` varchar(256) DEFAULT NULL,
  `config_list` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_coastalmodel`
--

LOCK TABLES `coastalmodels_coastalmodel` WRITE;
/*!40000 ALTER TABLE `coastalmodels_coastalmodel` DISABLE KEYS */;
INSERT INTO `coastalmodels_coastalmodel` VALUES (1,'SWAN','40.91','SWAN is a third-generation wave model that computes random, short-crested wind-generated waves in coastal regions and inland waters. SWAN accounts for the following physics: Wave propagation in time and space, shoaling, refraction due to current and depth, frequency shifting due to currents and non-stationary depth, Wave generation by wind, Three- and four-wave interactions, Whitecapping, bottom friction and depth-induced breaking, Dissipation due to vegetation, Wave-induced set-up, Propagation from laboratory up to global scales, Transmission through and reflection (specular and diffuse) against obstacles, and Diffraction.','images/swan.png','http://swanmodel.sourceforge.net/','INPUT','','/model/config/swan/add/','/model/config/swan/list/'),(2,'Delft3D','5.00.00.1234','Delft3D is a flexible integrated modelling suite, which simulates two-dimensional (in either the horizontal or a vertical plane) and three-dimensional flow, sediment transport and morphology, waves, water quality and ecology is capable of handling the interactions between these processes. The suite is designed for use by domain experts and non-experts alike, which may range from consultants and engineers or contractors, to regulators and government officials, all of whom are active in one or more of the stages of the design, implementation and management cycle.','images/delft3d.png','http://www.deltaressystems.com/hydro/product/621497/delft3d-suite','','mdf','/model/config/delft3d/add/','/model/config/delft3d/list/'),(3,'ADCIRC','50.79','ADCIRC is a system of computer programs for solving time dependent, free surface circulation and transport problems in two and three dimensions. These programs utilize the finite element method in space allowing the use of highly flexible, unstructured grids. Typical ADCIRC applications have included: (i) modeling tides and wind driven circulation, (ii) analysis of hurricane storm surge and flooding, (iii) dredging feasibility and material disposal studies, (iv) larval transport studies, (v) near shore marine operations.','images/adcirc.png','http://adcirc.org/','fort.15','','/model/config/adcirc/add/','/model/config/adcirc/list/'),(4,'CaFunwave','0.9alpha','CaFunwave is developed based on the Total Variation Diminishing (TVD) version of the FUNWAVE code, which is a phase-resolving, time-stepping Boussinesq model for ocean surface wave propagation in the nearshore. Our team rewrote the FUNWAVE code in C within the Cactus Computational Framework to make it easier to couple to other modeling tools and take advantage of various features coming with Cactus, such as flexible explicit time integrator, adaptive mesh refinement, checkpointing, optimized I/O, parameter parsing, visualization, etc. Like the FUNWAVE code, CaFunwave uses the MUSCLE-TVD finite volume scheme together with adaptive Runge Kutta time stepping. The theory and numerical implementation of the code is described in Shi et al (2014)','images/cafunwave.png','http://cactuscode.org/projects/cafunwave/index.php','','par','',''),(5,'FVCOM','2.5-customized','FVCOM is a three dimensional,time dependent,primitive equations,      \r\ncoastal ocean circulation model. The model computes the momentum,       \r\ncontinuity, temperature, salinity, and density equations and is closed  \r\nphysically and mathematically using the Mellor and Yamada level-2.5     \r\nturbulent closure submodel. The irregular bottom slope is represented   \r\nusing a sigma-coordinate transformation, and the horizontal grids       \r\ncomprise unstructured triangular cells. The finite-volume method (FVM)  \r\nused in this model combines the advantages of the finite-element        \r\nmethod (FEM) for geometric flexibility and the finite-difference        \r\nmethod (FDM) for simple discrete computation. Current, temperature,     \r\nand salinity in the model are computed in the integral form of the      \r\nequations, which provides a better representation of the conservation   \r\nlaws for mass, momentum, and heat in the coastal region with complex    \r\ngeometry.','images/fvcom.jpg','http://fvcom.smast.umassd.edu/FVCOM/','','','/model/config/fvcom/add/','/model/config/fvcom/list/');
/*!40000 ALTER TABLE `coastalmodels_coastalmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_delft3dconfig`
--

DROP TABLE IF EXISTS `coastalmodels_delft3dconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_delft3dconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) NOT NULL,
  `parameters_id` int(11) DEFAULT NULL,
  `flowtype` varchar(2) NOT NULL,
  `swan` tinyint(1) NOT NULL,
  `a0_correction` double NOT NULL,
  `nested_model` tinyint(1) NOT NULL,
  `nested_runid` varchar(16) DEFAULT NULL,
  `prior_runid` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_input_id` (`model_input_id`),
  UNIQUE KEY `parameters_id` (`parameters_id`),
  KEY `coastalmodels_delft3dconfig_fbfc09f1` (`user_id`),
  KEY `coastalmodels_delft3dconfig_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_17e99824` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_4b6bb827` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `parameters_id_refs_id_2e5a5fc1` FOREIGN KEY (`parameters_id`) REFERENCES `coastalmodels_delft3dparameters` (`id`),
  CONSTRAINT `user_id_refs_id_4a109d3d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_delft3dconfig`
--

LOCK TABLES `coastalmodels_delft3dconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_delft3dconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_delft3dconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_delft3dparameters`
--

DROP TABLE IF EXISTS `coastalmodels_delft3dparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_delft3dparameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `ident` varchar(60) DEFAULT NULL,
  `runid` varchar(60) DEFAULT NULL,
  `runtxt` varchar(60) DEFAULT NULL,
  `filcco` varchar(60) DEFAULT NULL,
  `fmtcco` varchar(60) DEFAULT NULL,
  `anglat` varchar(60) DEFAULT NULL,
  `grdang` varchar(60) DEFAULT NULL,
  `filgrd` varchar(60) DEFAULT NULL,
  `fmtgrd` varchar(60) DEFAULT NULL,
  `mnkmax` varchar(60) DEFAULT NULL,
  `thick` varchar(60) DEFAULT NULL,
  `fildep` varchar(60) DEFAULT NULL,
  `fmtdep` varchar(60) DEFAULT NULL,
  `fildry` varchar(60) DEFAULT NULL,
  `fmtdry` varchar(60) DEFAULT NULL,
  `filtd` varchar(60) DEFAULT NULL,
  `fmttd` varchar(60) DEFAULT NULL,
  `nambar` varchar(60) DEFAULT NULL,
  `mnbar` varchar(60) DEFAULT NULL,
  `mnwlos` varchar(60) DEFAULT NULL,
  `itdate` varchar(60) DEFAULT NULL,
  `tunit` varchar(60) DEFAULT NULL,
  `tstart` varchar(60) DEFAULT NULL,
  `tstop` varchar(60) DEFAULT NULL,
  `dt` varchar(60) DEFAULT NULL,
  `tzone` varchar(60) DEFAULT NULL,
  `sub1` varchar(60) DEFAULT NULL,
  `sub2` varchar(60) DEFAULT NULL,
  `namc1` varchar(60) DEFAULT NULL,
  `namc2` varchar(60) DEFAULT NULL,
  `namc3` varchar(60) DEFAULT NULL,
  `namc4` varchar(60) DEFAULT NULL,
  `namc5` varchar(60) DEFAULT NULL,
  `wnsvwp` varchar(60) DEFAULT NULL,
  `filwnd` varchar(60) DEFAULT NULL,
  `fmtwnd` varchar(60) DEFAULT NULL,
  `wndint` varchar(60) DEFAULT NULL,
  `filic` varchar(60) DEFAULT NULL,
  `fmtic` varchar(60) DEFAULT NULL,
  `zeta0` varchar(60) DEFAULT NULL,
  `u0` varchar(60) DEFAULT NULL,
  `v0` varchar(60) DEFAULT NULL,
  `s0` varchar(60) DEFAULT NULL,
  `t0` varchar(60) DEFAULT NULL,
  `c01` varchar(60) DEFAULT NULL,
  `i0` varchar(60) DEFAULT NULL,
  `restid` varchar(60) DEFAULT NULL,
  `filbnd` varchar(60) DEFAULT NULL,
  `fmtbnd` varchar(60) DEFAULT NULL,
  `filbch` varchar(60) DEFAULT NULL,
  `fmtbch` varchar(60) DEFAULT NULL,
  `filbct` varchar(60) DEFAULT NULL,
  `fmtbct` varchar(60) DEFAULT NULL,
  `filbcq` varchar(60) DEFAULT NULL,
  `fmtbcq` varchar(60) DEFAULT NULL,
  `filana` varchar(60) DEFAULT NULL,
  `filcor` varchar(60) DEFAULT NULL,
  `filbcc` varchar(60) DEFAULT NULL,
  `fmtbcc` varchar(60) DEFAULT NULL,
  `rettis` varchar(60) NOT NULL,
  `rettib` varchar(60) NOT NULL,
  `ag` varchar(60) DEFAULT NULL,
  `rhow` varchar(60) DEFAULT NULL,
  `alph0` varchar(60) DEFAULT NULL,
  `tempw` varchar(60) DEFAULT NULL,
  `salw` varchar(60) DEFAULT NULL,
  `rouwav` varchar(60) DEFAULT NULL,
  `wstres` varchar(128) NOT NULL,
  `rhoa` varchar(60) DEFAULT NULL,
  `betac` varchar(60) DEFAULT NULL,
  `equili` varchar(60) DEFAULT NULL,
  `tkemod` varchar(60) DEFAULT NULL,
  `ktemp` varchar(60) DEFAULT NULL,
  `fclou` varchar(60) DEFAULT NULL,
  `sarea` varchar(60) DEFAULT NULL,
  `filtmp` varchar(60) DEFAULT NULL,
  `fmttmp` varchar(60) DEFAULT NULL,
  `temint` varchar(60) DEFAULT NULL,
  `tstmp` varchar(60) DEFAULT NULL,
  `roumet` varchar(60) DEFAULT NULL,
  `filrgh` varchar(60) DEFAULT NULL,
  `fmtrgh` varchar(60) DEFAULT NULL,
  `ccofu` varchar(60) DEFAULT NULL,
  `ccofv` varchar(60) DEFAULT NULL,
  `xlo` varchar(60) DEFAULT NULL,
  `htur2d` varchar(60) DEFAULT NULL,
  `filedy` varchar(60) DEFAULT NULL,
  `fmtedy` varchar(60) DEFAULT NULL,
  `vicouv` varchar(60) DEFAULT NULL,
  `dicouv` varchar(60) DEFAULT NULL,
  `vicoww` varchar(60) DEFAULT NULL,
  `dicoww` varchar(60) DEFAULT NULL,
  `irov` varchar(60) DEFAULT NULL,
  `z0v` varchar(60) DEFAULT NULL,
  `cmu` varchar(60) DEFAULT NULL,
  `cpran` varchar(60) DEFAULT NULL,
  `filsed` varchar(60) DEFAULT NULL,
  `filmor` varchar(60) DEFAULT NULL,
  `iter` varchar(60) DEFAULT NULL,
  `dryflp` varchar(60) DEFAULT NULL,
  `dpsopt` varchar(60) DEFAULT NULL,
  `dpuopt` varchar(60) DEFAULT NULL,
  `dryflc` varchar(60) DEFAULT NULL,
  `dco` varchar(60) DEFAULT NULL,
  `tlfsmo` varchar(60) DEFAULT NULL,
  `thetqh` varchar(60) DEFAULT NULL,
  `forfuv` varchar(60) DEFAULT NULL,
  `forfww` varchar(60) DEFAULT NULL,
  `sigcor` varchar(60) DEFAULT NULL,
  `trasol` varchar(60) DEFAULT NULL,
  `momsol` varchar(60) DEFAULT NULL,
  `filsrc` varchar(60) DEFAULT NULL,
  `fmtsrc` varchar(60) DEFAULT NULL,
  `fildis` varchar(60) DEFAULT NULL,
  `fmtdis` varchar(60) DEFAULT NULL,
  `filsta` varchar(60) DEFAULT NULL,
  `fmtsta` varchar(60) DEFAULT NULL,
  `filpar` varchar(60) DEFAULT NULL,
  `fmtpar` varchar(60) DEFAULT NULL,
  `eps` varchar(60) DEFAULT NULL,
  `filcrs` varchar(60) DEFAULT NULL,
  `fmtcrs` varchar(60) DEFAULT NULL,
  `smhydr` varchar(60) DEFAULT NULL,
  `smderv` varchar(60) DEFAULT NULL,
  `smproc` varchar(60) DEFAULT NULL,
  `pmhydr` varchar(60) DEFAULT NULL,
  `pmderv` varchar(60) DEFAULT NULL,
  `pmproc` varchar(60) DEFAULT NULL,
  `shhydr` varchar(60) DEFAULT NULL,
  `shderv` varchar(60) DEFAULT NULL,
  `shproc` varchar(60) DEFAULT NULL,
  `shflux` varchar(60) DEFAULT NULL,
  `phhydr` varchar(60) DEFAULT NULL,
  `phderv` varchar(60) DEFAULT NULL,
  `phproc` varchar(60) DEFAULT NULL,
  `phflux` varchar(60) DEFAULT NULL,
  `filfou` varchar(60) DEFAULT NULL,
  `online` varchar(60) DEFAULT NULL,
  `prmap` varchar(60) DEFAULT NULL,
  `prhis` varchar(60) NOT NULL,
  `flmap` varchar(60) NOT NULL,
  `flhis` varchar(60) NOT NULL,
  `flpp` varchar(60) NOT NULL,
  `flrst` varchar(60) DEFAULT NULL,
  `waveol` varchar(60) DEFAULT NULL,
  `addtim` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coastalmodels_delft3dparameters_fbfc09f1` (`user_id`),
  KEY `coastalmodels_delft3dparameters_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_b211cc3e` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_7ffcec51` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_delft3dparameters`
--

LOCK TABLES `coastalmodels_delft3dparameters` WRITE;
/*!40000 ALTER TABLE `coastalmodels_delft3dparameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_delft3dparameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_efdcconfig`
--

DROP TABLE IF EXISTS `coastalmodels_efdcconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_efdcconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) NOT NULL,
  `parameters_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_input_id` (`model_input_id`),
  UNIQUE KEY `parameters_id` (`parameters_id`),
  KEY `coastalmodels_efdcconfig_fbfc09f1` (`user_id`),
  KEY `coastalmodels_efdcconfig_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_9df778d1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_f990d2ec` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `parameters_id_refs_id_803272b9` FOREIGN KEY (`parameters_id`) REFERENCES `coastalmodels_efdcparameters` (`id`),
  CONSTRAINT `user_id_refs_id_900b5042` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_efdcconfig`
--

LOCK TABLES `coastalmodels_efdcconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_efdcconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_efdcconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_efdcparameters`
--

DROP TABLE IF EXISTS `coastalmodels_efdcparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_efdcparameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `coastalmodels_efdcparameters_fbfc09f1` (`user_id`),
  KEY `coastalmodels_efdcparameters_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_2681da7d` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_6356311c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_efdcparameters`
--

LOCK TABLES `coastalmodels_efdcparameters` WRITE;
/*!40000 ALTER TABLE `coastalmodels_efdcparameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_efdcparameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_fvcomconfig`
--

DROP TABLE IF EXISTS `coastalmodels_fvcomconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_fvcomconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) NOT NULL,
  `case_name` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_input_id` (`model_input_id`),
  KEY `coastalmodels_fvcomconfig_fbfc09f1` (`user_id`),
  KEY `coastalmodels_fvcomconfig_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_56ea60b1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_5fc900cc` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `user_id_refs_id_77df5f62` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_fvcomconfig`
--

LOCK TABLES `coastalmodels_fvcomconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_fvcomconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_fvcomconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_modelinput`
--

DROP TABLE IF EXISTS `coastalmodels_modelinput`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_modelinput` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `project_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `prior_model_id` int(11) DEFAULT NULL,
  `input_dir` varchar(256) NOT NULL,
  `upload_now` tinyint(1) NOT NULL,
  `parfile_ready` tinyint(1) NOT NULL,
  `poi_type` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coastalmodels_modelinput_fbfc09f1` (`user_id`),
  KEY `coastalmodels_modelinput_bda51c3c` (`group_id`),
  KEY `coastalmodels_modelinput_b6620684` (`project_id`),
  KEY `coastalmodels_modelinput_aff30766` (`model_id`),
  KEY `coastalmodels_modelinput_e017daff` (`prior_model_id`),
  CONSTRAINT `group_id_refs_id_d6fd24d0` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_id_refs_id_de42b048` FOREIGN KEY (`model_id`) REFERENCES `coastalmodels_coastalmodel` (`id`),
  CONSTRAINT `prior_model_id_refs_id_9d31afcd` FOREIGN KEY (`prior_model_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `project_id_refs_id_ab0b773b` FOREIGN KEY (`project_id`) REFERENCES `workflow_project` (`id`),
  CONSTRAINT `user_id_refs_id_dd22bd31` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_modelinput`
--

LOCK TABLES `coastalmodels_modelinput` WRITE;
/*!40000 ALTER TABLE `coastalmodels_modelinput` DISABLE KEYS */;
INSERT INTO `coastalmodels_modelinput` VALUES (1,'RGUO_SWAN_M1',1,1,'2014-10-09 16:39:01','2014-10-09 16:39:05','',1,1,NULL,'users/U1/P1/M1/MODELINPUT',1,1,NULL),(3,'RGUO_SWAN_M3',1,1,'2014-10-09 21:09:19','2014-10-09 21:09:27','',2,1,1,'users/U1/P2/M3/MODELINPUT',1,1,'file'),(4,'RGUO_SWAN_M4',1,2,'2014-10-10 02:32:24','2014-10-10 02:32:44','',3,1,1,'users/U1/P3/M4/MODELINPUT',1,1,'file');
/*!40000 ALTER TABLE `coastalmodels_modelinput` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_swanconfig`
--

DROP TABLE IF EXISTS `coastalmodels_swanconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_swanconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) NOT NULL,
  `parameters_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_input_id` (`model_input_id`),
  UNIQUE KEY `parameters_id` (`parameters_id`),
  KEY `coastalmodels_swanconfig_fbfc09f1` (`user_id`),
  KEY `coastalmodels_swanconfig_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_52ddf534` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_dfe3d54f` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `parameters_id_refs_id_43eb87f1` FOREIGN KEY (`parameters_id`) REFERENCES `coastalmodels_swanparameters` (`id`),
  CONSTRAINT `user_id_refs_id_6c6d1b6b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_swanconfig`
--

LOCK TABLES `coastalmodels_swanconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_swanconfig` DISABLE KEYS */;
INSERT INTO `coastalmodels_swanconfig` VALUES (1,'RGUO_SWAN_M1_C1',1,1,'2014-10-09 16:39:05','2014-10-09 16:39:05',NULL,1,NULL),(3,'RGUO_SWAN_M3_C3',1,1,'2014-10-09 21:09:26','2014-10-09 21:09:27',NULL,3,NULL),(4,'RGUO_SWAN_M4_C4',1,2,'2014-10-10 02:32:44','2014-10-10 02:32:44',NULL,4,NULL);
/*!40000 ALTER TABLE `coastalmodels_swanconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coastalmodels_swanparameters`
--

DROP TABLE IF EXISTS `coastalmodels_swanparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coastalmodels_swanparameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `proj` varchar(60) NOT NULL,
  `mode` varchar(60) NOT NULL,
  `coord` varchar(60) NOT NULL,
  `set` varchar(60) NOT NULL,
  `friction` varchar(60) NOT NULL,
  `triad` varchar(60) DEFAULT NULL,
  `prop` varchar(60) NOT NULL,
  `gen3` varchar(60) NOT NULL,
  `breaking` varchar(60) DEFAULT NULL,
  `wcap` varchar(60) DEFAULT NULL,
  `off` varchar(60) NOT NULL,
  `cgrid` longtext NOT NULL,
  `read_coor` varchar(60) NOT NULL,
  `inpgrid_bottom` longtext NOT NULL,
  `read_bottom` varchar(60) NOT NULL,
  `inpgrid_wind` longtext NOT NULL,
  `read_wind` varchar(60) NOT NULL,
  `numeric` varchar(60) NOT NULL,
  `output` varchar(60) NOT NULL,
  `points` longtext NOT NULL,
  `table` longtext NOT NULL,
  `time_start` varchar(60) NOT NULL,
  `time_end` varchar(60) NOT NULL,
  `time_interval` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coastalmodels_swanparameters_fbfc09f1` (`user_id`),
  KEY `coastalmodels_swanparameters_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_9780be6a` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_8fb3e157` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_swanparameters`
--

LOCK TABLES `coastalmodels_swanparameters` WRITE;
/*!40000 ALTER TABLE `coastalmodels_swanparameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `coastalmodels_swanparameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datafactory_buoydata`
--

DROP TABLE IF EXISTS `datafactory_buoydata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datafactory_buoydata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(16) NOT NULL,
  `time` datetime NOT NULL,
  `wdir` int(11) NOT NULL,
  `wspd` double NOT NULL,
  `gst` double NOT NULL,
  `wvht` double NOT NULL,
  `dpd` double NOT NULL,
  `apd` double NOT NULL,
  `mwd` int(11) NOT NULL,
  `pres` double NOT NULL,
  `atmp` double NOT NULL,
  `wtmp` double NOT NULL,
  `dewp` double NOT NULL,
  `vis` double NOT NULL,
  `tide` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_buoydata`
--

LOCK TABLES `datafactory_buoydata` WRITE;
/*!40000 ALTER TABLE `datafactory_buoydata` DISABLE KEYS */;
/*!40000 ALTER TABLE `datafactory_buoydata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datafactory_currentdata`
--

DROP TABLE IF EXISTS `datafactory_currentdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datafactory_currentdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(16) NOT NULL,
  `time` datetime NOT NULL,
  `currentspd` double NOT NULL,
  `currentdir` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_currentdata`
--

LOCK TABLES `datafactory_currentdata` WRITE;
/*!40000 ALTER TABLE `datafactory_currentdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `datafactory_currentdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datafactory_datarequest`
--

DROP TABLE IF EXISTS `datafactory_datarequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datafactory_datarequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `provider` varchar(64) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datafactory_datarequest_fbfc09f1` (`user_id`),
  KEY `datafactory_datarequest_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_5ae96b34` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_ae98ecd3` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_datarequest`
--

LOCK TABLES `datafactory_datarequest` WRITE;
/*!40000 ALTER TABLE `datafactory_datarequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `datafactory_datarequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datafactory_datarequest_stations`
--

DROP TABLE IF EXISTS `datafactory_datarequest_stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datafactory_datarequest_stations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datarequest_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datarequest_id` (`datarequest_id`,`station_id`),
  KEY `datafactory_datarequest_stations_939d1704` (`datarequest_id`),
  KEY `datafactory_datarequest_stations_15e3331d` (`station_id`),
  CONSTRAINT `datarequest_id_refs_id_6a3dbf02` FOREIGN KEY (`datarequest_id`) REFERENCES `datafactory_datarequest` (`id`),
  CONSTRAINT `station_id_refs_id_cf09f7f1` FOREIGN KEY (`station_id`) REFERENCES `datafactory_station` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_datarequest_stations`
--

LOCK TABLES `datafactory_datarequest_stations` WRITE;
/*!40000 ALTER TABLE `datafactory_datarequest_stations` DISABLE KEYS */;
/*!40000 ALTER TABLE `datafactory_datarequest_stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datafactory_station`
--

DROP TABLE IF EXISTS `datafactory_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datafactory_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL,
  `source` varchar(10) NOT NULL,
  `measurement` varchar(10) NOT NULL,
  `provider` varchar(60) DEFAULT NULL,
  `description` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1318 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_station`
--

LOCK TABLES `datafactory_station` WRITE;
/*!40000 ALTER TABLE `datafactory_station` DISABLE KEYS */;
INSERT INTO `datafactory_station` VALUES (1,'0y2w3',44.794,-87.313,'NDBC','MET','U.S.C.G. Marine Reporting Stations','Sturgeon Bay CG Station, WS(IOOS Partners)\r'),(2,'13001',12,-23,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','NE Extension(International Partners)\r'),(3,'13002',21,-23,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','NE Extension(International Partners)\r'),(4,'13008',15,-38,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Reggae(International Partners)\r'),(5,'13009',8,-38,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Lambada(International Partners)\r'),(6,'13010',0,0,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Soul(International Partners)\r'),(7,'15001',-10,-10,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Gavotte(International Partners)\r'),(8,'15002',0,-10,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Java(International Partners)\r'),(9,'15006',-6,-10,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Valse(International Partners)\r'),(10,'21346',40.416,146.196,'NDBC','MET','Japanese Meteorological Agency','21346  380km East of Iwate, Japan(Tsunami)\r'),(11,'21347',39.301,145.751,'NDBC','MET','Japanese Meteorological Agency','21347  320km East of Iwate, Japan(Tsunami)\r'),(12,'21348',38.064,145.588,'NDBC','MET','Japanese Meteorological Agency','21348   350km East of Miyagi, Japan(Tsunami)\r'),(13,'21401',42.617,152.583,'NDBC','MET','Hydromet (RFERHRI)','250NM Southeast of Iturup Island(Tsunami)\r'),(14,'21402',46.488,158.343,'NDBC','MET','Hydromet (RFERHRI)','286NM East of Simushir Island(Tsunami)\r'),(15,'21413',30.515,152.117,'NDBC','MET','NDBC','SOUTHEAST TOKYO - 700NM SSE of Tokyo, JP(Tsunami)\r'),(16,'21414',48.948,178.263,'NDBC','MET','NDBC',' AMCHITKA - 170 NM South of Amchitka, AK(Tsunami)\r'),(17,'21415',50.183,171.847,'NDBC','MET','NDBC','ATTU - 175 NM South of Attu, AK(Tsunami)\r'),(18,'21416',48.058,163.505,'NDBC','MET','NDBC','KAMCHATKA PENINSULA -240NM SE of Kamchatka Peninsula, RU (Tsunami)\r'),(19,'21418',38.711,148.694,'NDBC','MET','NDBC','NORTHEAST TOKYO - 450 NM NE of Tokyo, JP(Tsunami)\r'),(20,'21419',44.455,155.736,'NDBC','MET','NDBC','KURIL ISLANDS - 209NM SE of Kuril Is. (Tsunami)\r'),(21,'22101',37.23,126.02,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(22,'22102',34.8,125.77,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(23,'22103',34,127.5,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(24,'22104',34.77,128.9,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(25,'22105',37.53,130,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(26,'22106',36.35,129.78,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(27,'22107',33.08,126.03,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(28,'22108',36.25,125.75,'NDBC','MET','Korean Meteorological Administration','(International Partners)\r'),(29,'23227',6.255,88.792,'NDBC','MET','Indian National Center for Ocean Information Services','Bay of Bengal(Tsunami)\r'),(30,'23228',20.799,65.347,'NDBC','MET','Indian National Center for Ocean Information Services','Arabian Sea(Tsunami)\r'),(31,'23401',8.904,88.54,'NDBC','MET','Thailand Meteorological Department','600 NM West-Northwest of Phuket, Thailand(Tsunami)\r'),(32,'28401',32.4,144.6,'NDBC','MET','NOAA/PMEL','Kuroshio Extension Observatory (KEO)(IOOS Partners)\r'),(33,'28906',30,-90,'NDBC','MET','University of Washington - APL','SG121(IOOS Partners)\r'),(34,'28907',30,-90,'NDBC','MET','University of Washington - APL','SG171(IOOS Partners)\r'),(35,'31001',0,-35,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Samba(International Partners)\r'),(36,'31002',4,-38,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Frevo(International Partners)\r'),(37,'31003',-8,-30,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','SW Extension(International Partners)\r'),(38,'31004',-14,-32,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','SW Extension(International Partners)\r'),(39,'31005',-19,-34,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','SW Extension(International Partners)\r'),(40,'31006',4,-23,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','NE Extension(International Partners)\r'),(41,'31007',0,-23,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Jazz(International Partners)\r'),(42,'31051',-25.283,-44.933,'NDBC','MET','Brazilian Navy Hydrographic Center','Santos(International Partners)\r'),(43,'31052',-8.15,-34.567,'NDBC','MET','Brazilian Navy Hydrographic Center','RECIFE(International Partners)\r'),(44,'31053',-32.595,-51.353,'NDBC','MET','Brazilian Navy Hydrographic Center',' RIO GRANDE DO SUL(International Partners)\r'),(45,'32014',-19.691,-85.567,'NDBC','MET','Woods Hole Oceanographic Institution','Woods Hole Stratus Wave Station (IOOS Partners)\r'),(46,'32066',-1.136,-81.765,'NDBC','MET','Instituto Oceanografico de la Armada','Ecuador INOCAR(Tsunami)\r'),(47,'32303',5,-95,'NDBC','MET','NDBC','5N 95W(TAO)\r'),(48,'32304',-5,-95,'NDBC','MET','NDBC','5S 95W(TAO)\r'),(49,'32305',-8,-95,'NDBC','MET','NDBC','8S 95W(TAO)\r'),(50,'32315',5,-110,'NDBC','MET','NDBC','5N 110W(TAO)\r'),(51,'32316',2,-110,'NDBC','MET','NDBC','2N 110W(TAO)\r'),(52,'32317',-2,-110,'NDBC','MET','NDBC','2S 110W(TAO)\r'),(53,'32318',-5,-110,'NDBC','MET','NDBC','5S 110W(TAO)\r'),(54,'32319',-8,-110,'NDBC','MET','NDBC','8S 110W(TAO)\r'),(55,'32320',2,-95,'NDBC','MET','NDBC','2N 95W(TAO)\r'),(56,'32321',0,-95,'NDBC','MET','NDBC','0 95W(TAO)\r'),(57,'32322',-2,-95,'NDBC','MET','NDBC','2S 95W(TAO)\r'),(58,'32323',0,-110,'NDBC','MET','NDBC','0 110W(TAO)\r'),(59,'32401',-19.297,-74.746,'NDBC','MET','Hydrographic and Oceanographic Service of the Chilean Navy (','260 NM West-Southwest of Arica Chile(Tsunami)\r'),(60,'32402',-26.743,-73.983,'NDBC','MET','Hydrographic and Oceanographic Service of the Chilean Navy (','180 NM  West of Caldera, Chile(Tsunami)\r'),(61,'32411',4.999,-90.841,'NDBC','MET','NDBC','WEST PANAMA - 710 NM WSW of Panama City, Panama(Tsunami)\r'),(62,'32412',-17.8484,-126.401,'NDBC','MET','NDBC','SOUTHWEST LIMA - 645 NM SW of Lima, Peru(Tsunami)\r'),(63,'32413',-10.2916,-153.638,'NDBC','MET','NDBC','NORTHWEST LIMA - 1000 NM WNW of Lima, Peru(Tsunami)\r'),(64,'32st0',-19.713,-85.585,'NDBC','MET','Woods Hole Oceanographic Institution','Stratus(IOOS Partners)\r'),(65,'41001',34.561,-72.631,'NDBC','MET','NDBC','EAST HATTERAS - 150 NM East of Cape Hatteras(NDBC Meteorological/Ocean)\r'),(66,'41002',31.862,-74.835,'NDBC','MET','NDBC','SOUTH HATTERAS - 225 South of Cape Hatteras(NDBC Meteorological/Ocean)\r'),(67,'41004',32.501,-79.099,'NDBC','MET','NDBC','EDISTO - 41 NM Southeast of Charleston, SC(NDBC Meteorological/Ocean)\r'),(68,'41008',31.4,-80.868,'NDBC','MET','NDBC','GRAYS REEF - 40 NM Southeast of Savannah, GA(NDBC Meteorological/Ocean)\r'),(69,'41009',28.523,-80.184,'NDBC','MET','NDBC','CANAVERAL 20 NM East of Cape Canaveral, FL(NDBC Meteorological/Ocean)\r'),(70,'41010',28.906,-78.471,'NDBC','MET','NDBC','CANAVERAL EAST - 120NM East of Cape Canaveral(NDBC Meteorological/Ocean)\r'),(71,'41012',30.042,-80.534,'NDBC','MET','NDBC','St. Augustine, FL 40NM ENE of St Augustine, FL(NDBC Meteorological/Ocean)\r'),(72,'41013',33.436,-77.743,'NDBC','MET','NDBC','Frying Pan Shoals, NC Buoy(NDBC Meteorological/Ocean)\r'),(73,'41024',33.848,-78.489,'NDBC','MET','CaroCOOPS','Sunset Nearshore (SUN 2)(IOOS Partners)\r'),(74,'41025',35.006,-75.402,'NDBC','MET','NDBC','Diamond Shoals(NDBC Meteorological/Ocean)\r'),(75,'41026',12,-38,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','Forro(International Partners)\r'),(76,'41029',32.81,-79.63,'NDBC','MET','CaroCOOPS','Capers Nearshore (CAP 2)(IOOS Partners)\r'),(77,'41033',32.28,-80.41,'NDBC','MET','CaroCOOPS','Fripp Nearshore (FRP 2)(IOOS Partners)\r'),(78,'41036',34.207,-76.949,'NDBC','MET','NDBC','Onslow Bay Outer, NC(NDBC Meteorological/Ocean)\r'),(79,'41037',33.991,-77.36,'NDBC','MET','CORMP','ILM3 - 27 miles SE of Wrightsville Beach, NC(IOOS Partners)\r'),(80,'41038',34.141,-77.715,'NDBC','MET','CORMP','ILM2 - 5 miles SE of Wrightsville Beach, NC(IOOS Partners)\r'),(81,'41040',14.516,-53.024,'NDBC','MET','NDBC','NORTH EQUATORIAL ONE- 470 NM East of Martinique(NDBC Meteorological/Ocean)\r'),(82,'41041',14.329,-46.082,'NDBC','MET','NDBC','NORTH EQUATORIAL TWO - 890 NM East of Martinique (NDBC Meteorological/Ocean)\r'),(83,'41043',21.061,-64.966,'NDBC','MET','NDBC','NE PUERTO RICO  - 170 NM NNE of San Juan,  P R(NDBC Meteorological/Ocean)\r'),(84,'41044',21.562,-58.641,'NDBC','MET','NDBC','NE ST MARTIN - 330 NM NE St Martin Is(NDBC Meteorological/Ocean)\r'),(85,'41046',23.838,-68.333,'NDBC','MET','NDBC','EAST BAHAMAS - 335 NM East of San Salvador Is,  Bahamas (NDBC Meteorological/Ocean)\r'),(86,'41047',27.517,-71.483,'NDBC','MET','NDBC','NE BAHAMAS - 350 NM ENE of Nassau, Bahamas(NDBC Meteorological/Ocean)\r'),(87,'41048',31.95,-69.497,'NDBC','MET','NDBC','WEST BERMUDA - 240 NM West of Bermuda(NDBC Meteorological/Ocean)\r'),(88,'41049',27.537,-62.945,'NDBC','MET','NDBC','SOUTH BERMUDA - 300 NM SSE of Bermuda(NDBC Meteorological/Ocean)\r'),(89,'41051',18.257,-65.004,'NDBC','MET','Caribbean Integrated Coastal Ocean Observing System (CarICoo','South of St. Thomas, VI(IOOS Partners)\r'),(90,'41052',18.251,-64.763,'NDBC','MET','Caribbean Integrated Coastal Ocean Observing System (CarICoo','South of St. John, Virgin Islands(IOOS Partners)\r'),(91,'41053',18.476,-66.099,'NDBC','MET','Caribbean Integrated Coastal Ocean Observing System (CarICoo','San Juan, PR(IOOS Partners)\r'),(92,'41060',14.749,-50.95,'NDBC','MET','Woods Hole Oceanographic Institution','Woods Hole Northwest Tropical Atlantic Wave Station(IOOS Partners)\r'),(93,'41061',24.581,-38,'NDBC','MET','Woods Hole Oceanographic Institution','Woods Hole SPURS Wave Station(IOOS Partners)\r'),(94,'41096',16.533,-61.404,'NDBC','MET','Meteo France','North of Guadeloupe(International Partners)\r'),(95,'41108',33.721,-78.015,'NDBC','MET','SCRIPPS','Wilmington Harbor, NC - 200(IOOS Partners)\r'),(96,'41109',34.483,-77.3,'NDBC','MET','SCRIPPS','New River Inlet, NC - 190(IOOS Partners)\r'),(97,'41110',34.141,-77.709,'NDBC','MET','CORMP','Masonboro Inlet, NC(IOOS Partners)\r'),(98,'41112',30.719,-81.293,'NDBC','MET','SCRIPPS','Offshore Fernandina Beach, FL (132)(IOOS Partners)\r'),(99,'41113',28.4,-80.53,'NDBC','MET','SCRIPPS','Cape Canaveral Nearshore, FL (143)(IOOS Partners)\r'),(100,'41114',27.551,-80.225,'NDBC','MET','SCRIPPS','Fort Pierce, FL (134)(IOOS Partners)\r'),(101,'41115',18.376,-67.28,'NDBC','MET','Caribbean Integrated Coastal Ocean Observing System (CarICoo','Rincon, Puerto Rico (181)(IOOS Partners)\r'),(102,'41139',20,-38,'NDBC','MET','Prediction and Research Moored Array in the Atlantic','(International Partners)\r'),(103,'41300',15.85,-57.467,'NDBC','MET','Meteo France','West Indies(International Partners)\r'),(104,'41420',23.49,-67.325,'NDBC','MET','NDBC','NORTH SANTO DOMINGO - 328NM NNE of Santo Domingo, DO(Tsunami)\r'),(105,'41421',23.409,-63.906,'NDBC','MET','NDBC','NORTH ST THOMAS - 300NM North of St Thomas, Virgin Is(Tsunami)\r'),(106,'41424',32.922,-72.466,'NDBC','MET','NDBC','EAST CHARLESTON - 370 NM East of Charleston, SC(Tsunami)\r'),(107,'41nt0',14.825,-51.017,'NDBC','MET','Woods Hole Oceanographic Institution','NTAS - Northwest Tropical Atlantic(IOOS Partners)\r'),(108,'42001',25.888,-89.658,'NDBC','MET','NDBC','MID GULF - 180 nm South of Southwest Pass, LA(NDBC Meteorological/Ocean)\r'),(109,'42002',25.79,-93.666,'NDBC','MET','NDBC','WEST GULF - 207 NM East of Brownsville, TX(NDBC Meteorological/Ocean)\r'),(110,'42003',26.044,-85.612,'NDBC','MET','NDBC','East GULF - 208 MN West of Naples, FL(NDBC Meteorological/Ocean)\r'),(111,'42014',30.065,-87.555,'NDBC','MET','NDBC','ORANGE BEACH - 44 NM SE of Mobile, AL(NDBC Meteorological/Ocean)\r'),(112,'42013',27.169,-82.926,'NDBC','MET','COMPS (University of South Florida)','C10 - Navy-2(IOOS Partners)\r'),(113,'42019',27.913,-95.353,'NDBC','MET','NDBC','FREEPORT, TX - 60 NM South of Freeport, TX(NDBC Meteorological/Ocean)\r'),(114,'42020',26.968,-96.694,'NDBC','MET','NDBC','CORPUS CHRISTI, TX - 60NM SSE of Corpus Christi, TX(NDBC Meteorological/Ocean)\r'),(115,'42021',28.311,-83.306,'NDBC','MET','COMPS (University of South Florida)','C14 - Pasco County Buoy, FL(IOOS Partners)\r'),(116,'42022',27.498,-83.722,'NDBC','MET','COMPS (University of South Florida)','C12 - West Florida Central Buoy(IOOS Partners)\r'),(117,'42023',26.064,-83.074,'NDBC','MET','COMPS (University of South Florida)','C13 - West Florida South Buoy(IOOS Partners)\r'),(118,'42035',29.232,-94.413,'NDBC','MET','NDBC','GALVESTON,TX -  22 NM East of Galveston, TX(NDBC Meteorological/Ocean)\r'),(119,'42036',28.5,-84.517,'NDBC','MET','NDBC','WEST TAMPA  - 112 NM WNW of Tampa, FL(NDBC Meteorological/Ocean)\r'),(120,'42039',28.794,-86.006,'NDBC','MET','NDBC','PENSACOLA - 115NM ESE of Pensacola, FL(NDBC Meteorological/Ocean)\r'),(121,'42040',29.212,-88.207,'NDBC','MET','NDBC','LUKE OFFSHORE TEST PLATFORM - 64 NM South of Dauphin Island, AL(NDBC Meteorological/Ocean)\r'),(122,'42043',28.982,-94.919,'NDBC','MET','TABS','GA-252 TABS B(IOOS Partners)\r'),(123,'42044',26.191,-97.051,'NDBC','MET','TABS','PS-1126 TABS J(IOOS Partners)\r'),(124,'42045',26.217,-96.5,'NDBC','MET','TABS','PI-745 TABS K(IOOS Partners)\r'),(125,'42046',27.89,-94.037,'NDBC','MET','TABS','HI-A595 TABS N(IOOS Partners)\r'),(126,'42047',27.897,-93.597,'NDBC','MET','TABS','HI-A389 TABS V(IOOS Partners)\r'),(127,'42048',27.94,-96.843,'NDBC','MET','TABS','TABS D(IOOS Partners)\r'),(128,'42049',28.351,-96.006,'NDBC','MET','TABS','TABS W(IOOS Partners)\r'),(129,'42050',28.843,-94.242,'NDBC','MET','TABS','TABS F(IOOS Partners)\r'),(130,'42051',29.635,-93.642,'NDBC','MET','TABS','TABS R(IOOS Partners)\r'),(131,'42055',22.203,-94,'NDBC','MET','NDBC','BAY OF CAMPECHE - 214 NM NE OF Veracruz, MX(NDBC Meteorological/Ocean)\r'),(132,'42056',19.802,-84.857,'NDBC','MET','NDBC',' Yucatan Basin - 120 NM ESE of Cozumel, MX(NDBC Meteorological/Ocean)\r'),(133,'42057',17.002,-81.501,'NDBC','MET','NDBC','Western Caribbean - 195 NM WSW of Negril Jamiaca(NDBC Meteorological/Ocean)\r'),(134,'42058',14.923,-74.918,'NDBC','MET','NDBC','Central Caribbean - 210 NM SSE of Kingston, Jamaica(NDBC Meteorological/Ocean)\r'),(135,'42059',15.058,-67.528,'NDBC','MET','NDBC','Eastern Caribbean - 190 NM NNE of Curacao(NDBC Meteorological/Ocean)\r'),(136,'42060',16.332,-63.24,'NDBC','MET','NDBC','Caribbean Valley - 63 NM WSW of Plymouth, Montserrat (NDBC Meteorological/Ocean)\r'),(137,'42067',30.043,-88.649,'NDBC','MET','USM','USM3M02(IOOS Partners)\r'),(138,'42085',17.86,-66.524,'NDBC','MET','Caribbean Integrated Coastal Ocean Observing System (CarICoo','Southeast of Ponce, PR(IOOS Partners)\r'),(139,'42099',27.34,-84.245,'NDBC','MET','SCRIPPS','Offshore St. Petersburg, FL (144)(IOOS Partners)\r'),(140,'42360',26.7,-90.46,'NDBC','MET','Petrobras','BW Pioneer buoy - Walker Ridge 249(Oil and Gas Industry)\r'),(141,'42361',27.55,-92.49,'NDBC','MET','Shell Oil','Auger - Garden Banks 426(Oil and Gas Industry)\r'),(142,'42362',27.8,-90.67,'NDBC','MET','Shell Oil','Brutus - Green Canyon 158(Oil and Gas Industry)\r'),(143,'42363',28.16,-89.22,'NDBC','MET','Shell Oil','Mars - Mississippi Canyon 807(Oil and Gas Industry)\r'),(144,'42364',29.06,-88.09,'NDBC','MET','Shell Oil','Ram-Powell - Viosca Knoll 956(Oil and Gas Industry)\r'),(145,'42365',28.2,-89.12,'NDBC','MET','Shell Oil','Ursa - Mississippi Canyon 809(Oil and Gas Industry)\r'),(146,'42366',27.122,-91.959,'NDBC','MET','Kerr-McGee','Red Hawk - Garden Banks 877(Oil and Gas Industry)\r'),(147,'42367',28.743,-88.826,'NDBC','MET','Total USA','Matterhorn - Mississippi Canyon 243(Oil and Gas Industry)\r'),(148,'42368',27.204,-92.203,'NDBC','MET','ConocoPhillips','Magnolia - Garden Banks 783(Oil and Gas Industry)\r'),(149,'42369',27.207,-90.283,'NDBC','MET','BP Inc','Mad Dog - Green Canyon 782(Oil and Gas Industry)\r'),(150,'42370',27.321,-90.536,'NDBC','MET','BP Inc','Holstein - Green Canyon 645(Oil and Gas Industry)\r'),(151,'42372',27.779,-90.519,'NDBC','MET','Chevron','Genesis - Green Canyon 205(Oil and Gas Industry)\r'),(152,'42373',27.354,-94.625,'NDBC','MET','Kerr-McGee','Boomvang - East Breaks 643(Oil and Gas Industry)\r'),(153,'42374',28.866,-88.056,'NDBC','MET','BP Inc','Horn Mountain - Mississippi Canyon 126 and 127(Oil and Gas Industry)\r'),(154,'42375',28.521,-88.289,'NDBC','MET','BP Inc','Na Kika - Mississippi Canyon 474(Oil and Gas Industry)\r'),(155,'42376',29.108,-87.944,'NDBC','MET','BP Inc','Marlin - Viosca Knoll 915(Oil and Gas Industry)\r'),(156,'42377',27.293,-90.968,'NDBC','MET','Kerr-McGee','Constitution - Green Canyon 680(Oil and Gas Industry)\r'),(157,'42379',27.362,-90.181,'NDBC','MET','Anadarko','Marco Polo - Green Canyon 608(Oil and Gas Industry)\r'),(158,'42380',28.209,-88.738,'NDBC','MET','Williams','Devil\'s Tower - Mississippi Canyon 773(Oil and Gas Industry)\r'),(159,'42381',28.221,-89.616,'NDBC','MET','ATP','Innovator - Mississippi Canyon 711(Oil and Gas Industry)\r'),(160,'42382',27.304,-93.538,'NDBC','MET','Kerr-McGee','Gunnison - Garden Banks 668(Oil and Gas Industry)\r'),(161,'42383',27.37,-89.924,'NDBC','MET','BHP','Neptune - Green Canyon 613(Oil and Gas Industry)\r'),(162,'42384',27.993,-90.326,'NDBC','MET','El Paso E&P Company, L.P.','Prince TLP - Ewing Bank 1003(Oil and Gas Industry)\r'),(163,'42385',28.34,-88.266,'NDBC','MET','Chevron','Blind Faith - Mississippi Canyon 696(Oil and Gas Industry)\r'),(164,'42386',27.326,-90.714,'NDBC','MET','Chevron','Tahiti - Green Canyon 641(Oil and Gas Industry)\r'),(165,'42387',28.267,-88.399,'NDBC','MET','Murphy','Thunderhawk - Mississippi Canyon 734(Oil and Gas Industry)\r'),(166,'42388',27.73,-91.109,'NDBC','MET','Helix','Producer 1 - Green Canyon 237(Oil and Gas Industry)\r'),(167,'42390',26.129,-94.898,'NDBC','MET','Shell Oil','Perdido Host - Alaminos Canyon 857(Oil and Gas Industry)\r'),(168,'42391',28.034,-89.101,'NDBC','MET','ATP','Titan - Mississippi Canyon 941(Oil and Gas Industry)\r'),(169,'42392',27.196,-90.027,'NDBC','MET','BP Inc','Atlantis - Green Canyon ###(Oil and Gas Industry)\r'),(170,'42393',27.301,-90.135,'NDBC','MET','BHP','Shenzi - Green Canyon 653(Oil and Gas Industry)\r'),(171,'42407',15.289,-68.215,'NDBC','MET','NDBC','SOUTH PUERTO RICO - 230 NM South of San Juan, PR(Tsunami)\r'),(172,'42429',27.401,-85.671,'NDBC','MET','NDBC','DART WAVE GLIDER STATION (Tsunami)\r'),(173,'42851',26.863,-91.587,'NDBC','MET','Shell Oil','Globetrotter 1 - Walker Ridge 95(Oil and Gas Industry)\r'),(174,'42852',28.501,-89.769,'NDBC','MET','LLOG','Who Dat - Mississippi Canyon 547(Oil and Gas Industry)\r'),(175,'42854',27.589,-92.282,'NDBC','MET','Amerada Hess','Atwood Condor - Garden Banks 386(Oil and Gas Industry)\r'),(176,'42855',26.157,-91.873,'NDBC','MET','Anadarko','ENSCO 8506 - Walker Ridge 793(Oil and Gas Industry)\r'),(177,'42856',26.52,-90.531,'NDBC','MET','Petrobras','Titanium Explorer - Walker Ridge 425(Oil and Gas Industry)\r'),(178,'42861',28.634,-87.982,'NDBC','MET','Shell Oil','Deepwater Nautilus -  Mississippi Canyon 348(Oil and Gas Industry)\r'),(179,'42862',27.862,-90.539,'NDBC','MET','Shell Oil','Jim Thompson - Green Canyon 158(Oil and Gas Industry)\r'),(180,'42863',27.589,-90.311,'NDBC','MET','ENI Petroleum','Ocean Victory - Green Canyon 385(Oil and Gas Industry)\r'),(181,'42866',28.491,-88.997,'NDBC','MET','ENI Petroleum','Transocean Amirante - Mississippi Canyon 460(Oil and Gas Industry)\r'),(182,'42867',27.317,-90.754,'NDBC','MET','Chevron','DeepSeas - Green Canyon 640(Oil and Gas Industry)\r'),(183,'42868',28.221,-88.533,'NDBC','MET','BP Inc','Discoverer Enterprise - Mississippi Canyon 777(Oil and Gas Industry)\r'),(184,'42869',28.695,-87.931,'NDBC','MET','ATP','Ocean Confidence - Mississippi Canyon 305(Oil and Gas Industry)\r'),(185,'42870',27.458,-90.867,'NDBC','MET','Mariner Energy Inc. for MMS','Ocean America - Green Canyon 505(Oil and Gas Industry)\r'),(186,'42871',27.3,-90.086,'NDBC','MET','BHP','C R Luigs - Green Canyon 654(Oil and Gas Industry)\r'),(187,'42873',28.252,-89.622,'NDBC','MET','ATP','Ocean Quest - Mississippi Canyon 711(Oil and Gas Industry)\r'),(188,'42875',28.445,-89.044,'NDBC','MET','LLOG','Amos Runner - Mississippi Canyon 547(Oil and Gas Industry)\r'),(189,'42876',27.676,-92.534,'NDBC','MET','Newfield Exploration Company','Ocean Star - Garden Banks 293(Oil and Gas Industry)\r'),(190,'42877',28.18,-89.29,'NDBC','MET','Shell Oil','Cajun Express - Mississippi Canyon 762(Oil and Gas Industry)\r'),(191,'42878',27.726,-90.73,'NDBC','MET','Marathon Oil','Paul Romano - Green Canyon 244(Oil and Gas Industry)\r'),(192,'42881',27.554,-88.361,'NDBC','MET','ENI Petroleum','Transocean Marianas - Atwater Valley 428(Oil and Gas Industry)\r'),(193,'42882',27.339,-94.47,'NDBC','MET','Anadarko','Ocean Valiant - East Breaks 646(Oil and Gas Industry)\r'),(194,'42885',28.249,-88.828,'NDBC','MET','BP Inc','Development Driller II - Mississippi Canyon 727(Oil and Gas Industry)\r'),(195,'42886',27.267,-90.809,'NDBC','MET','Anadarko','Discoverer Spirit - Green Canyon 727(Oil and Gas Industry)\r'),(196,'42887',28.191,-88.496,'NDBC','MET','BP Inc','Thunder Horse - Mississippi Canyon 778(Oil and Gas Industry)\r'),(197,'42889',28.394,-89.465,'NDBC','MET','Murphy','Medusa - Mississippi Canyon 582(Oil and Gas Industry)\r'),(198,'42890',27.625,-90.441,'NDBC','MET','Murphy','Front Runner - Green Canyon 338(Oil and Gas Industry)\r'),(199,'42892',27.599,-92.298,'NDBC','MET','Amerada Hess','Ocean Baroness - Garden Banks 386(Oil and Gas Industry)\r'),(200,'42894',28.77,-88.834,'NDBC','MET','LLOG','Lorris Bouzigard - Mississippi Canyon 199(Oil and Gas Industry)\r'),(201,'42897',27.327,-90.148,'NDBC','MET','BHP','Development Driller 1 - Green Canyon 653(Oil and Gas Industry)\r'),(202,'42899',27.066,-92.06,'NDBC','MET','ExxonMobil','Ocean Endeavor - Keathley Canyon 919(Oil and Gas Industry)\r'),(203,'42900',28.36,-89.423,'NDBC','MET','Walter Oil and Gas','Ocean Saratoga - Mississippi Canyon 583(Oil and Gas Industry)\r'),(204,'42902',26.13,-94.9,'NDBC','MET','Shell Oil','Clyde Boudreaux - Alaminos Canyon 857(Oil and Gas Industry)\r'),(205,'42904',28.085,-87.986,'NDBC','MET','Anadarko','Independence Hub -  Mississippi Canyon 920(Oil and Gas Industry)\r'),(206,'42905',27.396,-90.305,'NDBC','MET','Anadarko','Belford Dolphin - Green Canyon 561(Oil and Gas Industry)\r'),(207,'42908',26.679,-92.573,'NDBC','MET','BP Inc','West Sirius - Keathley Canyon 292(Oil and Gas Industry)\r'),(208,'42909',26.157,-91.873,'NDBC','MET','Anadarko','ENSCO 8500 - Walker Ridge 793(Oil and Gas Industry)\r'),(209,'42910',27.378,-92.624,'NDBC','MET','Shell Oil','Frontier Driller - Green Canyon 248(Oil and Gas Industry)\r'),(210,'42911',27.464,-92.433,'NDBC','MET','Marathon Oil','Ocean Monarch - Garden Banks 515(Oil and Gas Industry)\r'),(211,'42912',26.317,-91.086,'NDBC','MET','Chevron','Discoverer Clear Leader - WR634(Oil and Gas Industry)\r'),(212,'42913',27.631,-90.465,'NDBC','MET','Walter Oil and Gas','ENSCO 8501 - Green Canyon 038(Oil and Gas Industry)\r'),(213,'42914',26.442,-91.19,'NDBC','MET','Statoil Hydro','Discoverer Americas - Walker Ridge 543(Oil and Gas Industry)\r'),(214,'42915',25.975,-91.835,'NDBC','MET','Maersk Drilling USA','Maersk Developer - Walker Ridge 970(Oil and Gas Industry)\r'),(215,'42916',27.267,-90.033,'NDBC','MET','BP Inc','Development Driller 3 -  Green Canyon 743(Oil and Gas Industry)\r'),(216,'42917',26.298,-91.093,'NDBC','MET','Chevron','Discoverer Inspiration - Walker Ridge 678(Oil and Gas Industry)\r'),(217,'42918',26.094,-94.904,'NDBC','MET','Shell Oil','Noble Danny Adkins - Alaminos Canyon 857(Oil and Gas Industry)\r'),(218,'42919',27.504,-90.532,'NDBC','MET','Amerada Hess','Stenna Forth - Green Canyon 469(Oil and Gas Industry)\r'),(219,'42921',28.354,-87.82,'NDBC','MET','ENI Petroleum','Deepwater Pathfinder - DeSoto Canyon 618(Oil and Gas Industry)\r'),(220,'42922',28.445,-87.899,'NDBC','MET','Shell Oil','Noble Jim Day - DeSoto Canyon 529(Oil and Gas Industry)\r'),(221,'42923',28.747,-89.361,'NDBC','MET','LLOG','Ensco 8502 - MC253(Oil and Gas Industry)\r'),(222,'42924',27.08,-91.163,'NDBC','MET','Cobalt Energy','Ensco 8503 - Green Canyon 896(Oil and Gas Industry)\r'),(223,'42925',26.736,-90.492,'NDBC','MET','Petrobras','Ensco 5 - Walker Ridge 250(Oil and Gas Industry)\r'),(224,'42926',26.273,-92.367,'NDBC','MET','Chevron','Discoverer India - Keathley Canyon 736(Oil and Gas Industry)\r'),(225,'42927',27.555,-90.07,'NDBC','MET','Shell Oil','Noble Bully 1 - Green Canyon 434(Oil and Gas Industry)\r'),(226,'42928',27.224,-90.97,'NDBC','MET','Anadarko','ENSCO 8505 - Green Canyon 768(Oil and Gas Industry)\r'),(227,'42929',26.846,-91.438,'NDBC','MET','Chevron','Pacific Santa Ana - Walker Ridge 98(Oil and Gas Industry)\r'),(228,'42930',26.519,-90.951,'NDBC','MET','ConocoPhillips','Deepwater Champion - Walker Ridge 460(Oil and Gas Industry)\r'),(229,'43001',8,-110,'NDBC','MET','NDBC','8N 110W(TAO)\r'),(230,'43301',8,-95,'NDBC','MET','NDBC','8N 95W(TAO)\r'),(231,'43412',16.069,-106.996,'NDBC','MET','NDBC','SOUTHWEST  MANZANILLO - 240 NM SW OF Manzanillo, MX(Tsunami)\r'),(232,'43413',11.065,-99.853,'NDBC','MET','NDBC','SOUTH ACAPULCO - 360NM South of Acapulco, MX(Tsunami)\r'),(233,'44005',43.204,-69.128,'NDBC','MET','NDBC','GULF OF MAINE - 78 NM East of Portsmouth, NH(NDBC Meteorological/Ocean)\r'),(234,'44007',43.531,-70.144,'NDBC','MET','NDBC','PORTLAND 12 NM Southeast of Portland,ME(NDBC Meteorological/Ocean)\r'),(235,'44008',40.502,-69.247,'NDBC','MET','NDBC','NANTUCKET 54NM Southeast of Nantucket(NDBC Meteorological/Ocean)\r'),(236,'44009',38.461,-74.703,'NDBC','MET','NDBC','DELAWARE BAY 26 NM Southeast of Cape May, NJ(NDBC Meteorological/Ocean)\r'),(237,'44011',41.105,-66.6,'NDBC','MET','NDBC','GEORGES BANK 170 NM East of Hyannis, MA(NDBC Meteorological/Ocean)\r'),(238,'44013',42.346,-70.651,'NDBC','MET','NDBC','BOSTON 16 NM East of Boston, MA(NDBC Meteorological/Ocean)\r'),(239,'44014',36.611,-74.842,'NDBC','MET','NDBC','VIRGINIA BEACH 64 NM East of Virginia Beach, VA(NDBC Meteorological/Ocean)\r'),(240,'44017',40.694,-72.048,'NDBC','MET','NDBC','MONTAUK POINT -23 NM SSW of Montauk Point, NY(NDBC Meteorological/Ocean)\r'),(241,'44018',42.126,-69.63,'NDBC','MET','NDBC','CAPE COD - 24 NM East of Provincetown, MA(NDBC Meteorological/Ocean)\r'),(242,'44020',41.443,-70.186,'NDBC','MET','NDBC','NANTUCKET SOUND(NDBC Meteorological/Ocean)\r'),(243,'44021',43.762,-69.988,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy D - New Meadows River(IOOS Partners)\r'),(244,'44022',40.88,-73.73,'NDBC','MET','MYSOUND','Execution Rocks(IOOS Partners)\r'),(245,'44024',42.312,-65.927,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','N01 - Northeast Channel(IOOS Partners)\r'),(246,'44025',40.25,-73.167,'NDBC','MET','NDBC','LONG ISLAND - 30 NM South of Islip, NY(NDBC Meteorological/Ocean)\r'),(247,'44027',44.287,-67.307,'NDBC','MET','NDBC','Jonesport, ME - 20 NM SE of Jonesport, ME(NDBC Meteorological/Ocean)\r'),(248,'44029',42.52,-70.57,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy A01 - Mass. Bay/Stellwagen(IOOS Partners)\r'),(249,'44030',43.183,-70.418,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy B01 - Western Maine Shelf(IOOS Partners)\r'),(250,'44032',43.715,-69.358,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy E01 - Central Maine Shelf(IOOS Partners)\r'),(251,'44033',44.06,-69,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy F01 - West Penobscot Bay(IOOS Partners)\r'),(252,'44034',44.11,-68.11,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy I01 - Eastern Maine Shelf(IOOS Partners)\r'),(253,'44037',43.484,-67.883,'NDBC','MET','Northeastern Regional Association of Coastal Ocean Observing','Buoy M01 - Jordan Basin(IOOS Partners)\r'),(254,'44039',41.138,-72.655,'NDBC','MET','MYSOUND','Central Long Island Sound(IOOS Partners)\r'),(255,'44040',40.956,-73.58,'NDBC','MET','MYSOUND','Western Long Island Sound(IOOS Partners)\r'),(256,'44041',37.204,-76.777,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Jamestown, VA(IOOS Partners)\r'),(257,'44042',38.033,-76.336,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Potomac, MD(IOOS Partners)\r'),(258,'44043',39.152,-76.391,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Patapsco, MD(IOOS Partners)\r'),(259,'44056',36.2,-75.714,'NDBC','MET','U.S. Army Corps of Engineers','Duck FRF, NC(IOOS Partners)\r'),(260,'44057',39.544,-76.075,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Susquehanna, MD(IOOS Partners)\r'),(261,'44058',37.552,-76.251,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Stingray Point, VA(IOOS Partners)\r'),(262,'44059',36.846,-76.298,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Norfolk, VA(IOOS Partners)\r'),(263,'44060',41.263,-72.067,'NDBC','MET','MYSOUND','Eastern Long Island Sound(IOOS Partners)\r'),(264,'44061',38.785,-77.036,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Upper Potomac, MD(IOOS Partners)\r'),(265,'44062',38.556,-76.415,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Gooses Reef, MD(IOOS Partners)\r'),(266,'44063',38.963,-76.448,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','Annapolis(IOOS Partners)\r'),(267,'44064',36.979,-76.043,'NDBC','MET','Chesapeake Bay Interpretive Buoy System (CBIBS)','FIRST LANDING(IOOS Partners)\r'),(268,'44065',40.369,-73.703,'NDBC','MET','NDBC','New York Harbor Entrance - 15 NM SE of Breezy Point , NY(NDBC Meteorological/Ocean)\r'),(269,'44066',39.584,-72.6,'NDBC','MET','NDBC','Texas Tower #4 - 75 NM East of Long Beach, NJ(NDBC Meteorological/Ocean)\r'),(270,'44067',38.368,-76.996,'NDBC','MET','Intellicheck Mobilisa','Potomac River, Near HWY 301(IOOS Partners)\r'),(271,'44095',35.75,-75.33,'NDBC','MET','SCRIPPS','Oregon Inlet, NC  - 192(IOOS Partners)\r'),(272,'44096',37.023,-75.81,'NDBC','MET','SCRIPPS','Cape Charles, VA - 186(IOOS Partners)\r'),(273,'44097',40.981,-71.117,'NDBC','MET','SCRIPPS','Block Island, RI  (154)(IOOS Partners)\r'),(274,'44098',42.801,-70.169,'NDBC','MET','University of New Hampshire','Jeffrey\'s Ledge, NH (160)(IOOS Partners)\r'),(275,'44099',36.901,-75.72,'NDBC','MET','SCRIPPS','Cape Henry, VA (147)(IOOS Partners)\r'),(276,'44100',36.258,-75.591,'NDBC','MET','SCRIPPS','Duck FRF 26m, NC (430)(IOOS Partners)\r'),(277,'44137',42.234,-62.018,'NDBC','MET','Environment Canada','East Scotia Slope(International Partners)\r'),(278,'44138',44.251,-53.633,'NDBC','MET','Environment Canada','SW Grand Banks(International Partners)\r'),(279,'44139',44.24,-57.103,'NDBC','MET','Environment Canada','Banqureau Banks(International Partners)\r'),(280,'44140',42.868,-51.467,'NDBC','MET','Environment Canada','Tail of the Bank(International Partners)\r'),(281,'44141',42.993,-57.958,'NDBC','MET','Environment Canada','Laurentian Fan(International Partners)\r'),(282,'44150',42.505,-64.018,'NDBC','MET','Environment Canada','La Have Bank(International Partners)\r'),(283,'44174',49.063,-60.856,'NDBC','MET','Environment Canada','Anticosti(International Partners)\r'),(284,'44175',46.877,-62,'NDBC','MET','Environment Canada','iles de la Madeleine(International Partners)\r'),(285,'44251',46.444,-53.392,'NDBC','MET','Environment Canada','Nickerson Bank(International Partners)\r'),(286,'44255',47.267,-57.336,'NDBC','MET','Environment Canada','NE Burgeo Bank(International Partners)\r'),(287,'44258',44.502,-63.403,'NDBC','MET','Environment Canada','Halifax Harbour(International Partners)\r'),(288,'44401',32.9292,-54.7817,'NDBC','MET','NDBC','NORTHEAST CASTLE ROCK SEAMOUNT - 620NM South of St John\'s Newfoundland, CN(Tsunami)\r'),(289,'44402',39.399,-70.942,'NDBC','MET','NDBC','SOUTHEAST BLOCK CANYON - 130 NM SE of Fire Island, NY.(Tsunami)\r'),(290,'45001',48.064,-87.777,'NDBC','MET','NDBC','MID SUPERIOR 60NM North Northeast Hancock, MI(NDBC Meteorological/Ocean)\r'),(291,'45002',45.344,-86.411,'NDBC','MET','NDBC','NORTH MICHIGAN- Halfway between North Manitou and Washington Islands.(NDBC Meteorological/Ocean)\r'),(292,'45003',45.351,-82.84,'NDBC','MET','NDBC','NORTH HURON - 32NM Northeast of Alpena, MI(NDBC Meteorological/Ocean)\r'),(293,'45004',47.584,-86.587,'NDBC','MET','NDBC','EAST SUPERIOR -70 NM NE Marquette, MI(NDBC Meteorological/Ocean)\r'),(294,'45005',41.677,-82.398,'NDBC','MET','NDBC','WEST ERIE - 16 NM NW of Lorain, OH(NDBC Meteorological/Ocean)\r'),(295,'45006',47.335,-89.793,'NDBC','MET','NDBC','WEST SUPERIOR - 30NM NE of Outer Island, WI(NDBC Meteorological/Ocean)\r'),(296,'45007',42.674,-87.026,'NDBC','MET','NDBC','SOUTH MICHIGAN - 43NM East Southeast of Milwaukee, WI(NDBC Meteorological/Ocean)\r'),(297,'45008',44.283,-82.416,'NDBC','MET','NDBC','SOUTH HURON - 43NM East of Oscoda, MI(NDBC Meteorological/Ocean)\r'),(298,'45012',43.619,-77.405,'NDBC','MET','NDBC','EAST Lake Ontario  - 20NM North Northeast of Rochester, NY(NDBC Meteorological/Ocean)\r'),(299,'45013',43.098,-87.85,'NDBC','MET','University of Wisconsin-Milwaukee','Atwater Park, WI(IOOS Partners)\r'),(300,'45014',44.795,-87.759,'NDBC','MET','University of Wisconsin-Milwaukee','Central Green Bay, WI(IOOS Partners)\r'),(301,'45015',41.714,-87.527,'NDBC','MET','Chicago Park District','Calumet Beach(IOOS Partners)\r'),(302,'45016',41.783,-87.573,'NDBC','MET','Chicago Park District','Sixth-third St Beach(IOOS Partners)\r'),(303,'45017',41.903,-87.622,'NDBC','MET','Chicago Park District','Oak St Beach(IOOS Partners)\r'),(304,'45018',41.968,-87.637,'NDBC','MET','Chicago Park District','Montrose Ave Beach(IOOS Partners)\r'),(305,'45019',41.979,-87.649,'NDBC','MET','Chicago Park District','Foster Ave. Beach(IOOS Partners)\r'),(306,'45022',45.403,-85.088,'NDBC','MET','Michigan Technological University','Little Traverse Bay, MI(IOOS Partners)\r'),(307,'45023',47.279,-88.611,'NDBC','MET','Michigan Technological University','Portage Canal(IOOS Partners)\r'),(308,'45024',43.977,-86.56,'NDBC','MET','University of Michigan','Ludington, MI(IOOS Partners)\r'),(309,'45025',46.95,-88.409,'NDBC','MET','Michigan Technological University','South Entrance to Keweenaw Waterway, MI(IOOS Partners)\r'),(310,'45026',41.983,-86.617,'NDBC','MET','Limno Tech','St. Joseph, MI(IOOS Partners)\r'),(311,'45027',46.864,-91.929,'NDBC','MET','University of Minnesota, Duluth','North of Duluth, MN(IOOS Partners)\r'),(312,'45028',46.812,-91.835,'NDBC','MET','University of Minnesota, Duluth','Western Lake Superior(IOOS Partners)\r'),(313,'45029',42.9,-86.272,'NDBC','MET','Limno Tech','Holland, MI(IOOS Partners)\r'),(314,'45132',42.467,-81.216,'NDBC','MET','Environment Canada','Port Stanley(International Partners)\r'),(315,'45135',43.791,-76.874,'NDBC','MET','Environment Canada','Prince Edward Pt(International Partners)\r'),(316,'45136',48.535,-86.953,'NDBC','MET','Environment Canada','Slate Island(International Partners)\r'),(317,'45137',45.544,-81.015,'NDBC','MET','Environment Canada','Georgian Bay(International Partners)\r'),(318,'45138',49.543,-65.76,'NDBC','MET','Environment Canada','Mount Louis(International Partners)\r'),(319,'45139',43.264,-79.541,'NDBC','MET','Environment Canada','West Lake Ontario - Grimsby(International Partners)\r'),(320,'45140',50.8,-96.733,'NDBC','MET','Environment Canada','Lake Winnipeg S. Basin(International Partners)\r'),(321,'45141',61.181,-115.314,'NDBC','MET','Environment Canada','Great Slave Lake(International Partners)\r'),(322,'45142',42.737,-79.29,'NDBC','MET','Environment Canada','Port Colborne(International Partners)\r'),(323,'45143',44.945,-80.627,'NDBC','MET','Environment Canada','South Georgian Bay(International Partners)\r'),(324,'45144',53.23,-98.29,'NDBC','MET','Environment Canada','Lake Winnipeg North(International Partners)\r'),(325,'45145',51.87,-96.97,'NDBC','MET','Environment Canada','Lake Winnipeg Narrows(International Partners)\r'),(326,'45147',42.43,-82.683,'NDBC','MET','Environment Canada','Lake St Clair(International Partners)\r'),(327,'45148',49.66,-94.519,'NDBC','MET','Environment Canada','Lake of the Woods(International Partners)\r'),(328,'45149',43.542,-82.075,'NDBC','MET','Environment Canada','Southern Lake Huron(International Partners)\r'),(329,'45150',61.98,-114.129,'NDBC','MET','Environment Canada','Great Slave Lake, North Arm(International Partners)\r'),(330,'45151',44.5,-79.368,'NDBC','MET','Environment Canada','Lake Simcoe(International Partners)\r'),(331,'45152',46.233,-79.716,'NDBC','MET','Environment Canada','Lake Nipissing(International Partners)\r'),(332,'45154',46.051,-82.637,'NDBC','MET','Environment Canada','North Channel East(International Partners)\r'),(333,'45158',59,-94,'NDBC','MET','Environment Canada','Hudson Bay(International Partners)\r'),(334,'45159',43.767,-78.984,'NDBC','MET','Environment Canada','NW Lake Ontario Ajax(International Partners)\r'),(335,'45161',43.178,-86.361,'NDBC','MET','GLERL','Muskegon, MI(IOOS Partners)\r'),(336,'45162',44.984,-83.269,'NDBC','MET','GLERL','Alpena, MI(IOOS Partners)\r'),(337,'45163',43.988,-83.599,'NDBC','MET','GLERL','Saginaw Bay, MI(IOOS Partners)\r'),(338,'45164',41.734,-81.698,'NDBC','MET','GLERL','Cleveland, OH(IOOS Partners)\r'),(339,'45165',41.806,-83.271,'NDBC','MET','Limno Tech','Monroe, MI(IOOS Partners)\r'),(340,'45170',41.755,-86.968,'NDBC','MET','Illinois-Indiana Sea Grant and Purdue Civil Engineering','Michigan City, Indiana(IOOS Partners)\r'),(341,'46001',56.304,-147.92,'NDBC','MET','NDBC','WESTERN GULF OF ALASKA  - 175NM SE of Kodiak, AK(NDBC Meteorological/Ocean)\r'),(342,'46002',42.589,-130.474,'NDBC','MET','NDBC','WEST OREGON - 275NM West of Coos Bay, OR(NDBC Meteorological/Ocean)\r'),(343,'46004',50.93,-136.095,'NDBC','MET','Environment Canada','Middle Nomad(International Partners)\r'),(344,'46005',46.1,-131.001,'NDBC','MET','NDBC','WEST WASHINGTON - 300NM West of Aberdeen, WA(NDBC Meteorological/Ocean)\r'),(345,'46006',40.754,-137.464,'NDBC','MET','NDBC','SOUTHEAST PAPA - 600NM West of Eureka, CA(NDBC Meteorological/Ocean)\r'),(346,'46011',35,-120.992,'NDBC','MET','NDBC','SANTA MARIA - 21NM NW of Point Arguello, CA(NDBC Meteorological/Ocean)\r'),(347,'46012',37.363,-122.881,'NDBC','MET','NDBC','HALF MOON BAY - 24NM SSW of San Francisco, CA(NDBC Meteorological/Ocean)\r'),(348,'46013',38.242,-123.301,'NDBC','MET','NDBC','BODEGA BAY - 48NM NNW of San Francisco, CA(NDBC Meteorological/Ocean)\r'),(349,'46014',39.235,-123.974,'NDBC','MET','NDBC','PT ARENA - 19NM North of Point Arena, CA(NDBC Meteorological/Ocean)\r'),(350,'46015',42.764,-124.832,'NDBC','MET','NDBC','PORT ORFORD - 15 NM West of Port Orford, OR(NDBC Meteorological/Ocean)\r'),(351,'46022',40.724,-124.578,'NDBC','MET','NDBC','EEL RIVER - 17NM WSW of Eureka, CA(NDBC Meteorological/Ocean)\r'),(352,'46025',33.749,-119.053,'NDBC','MET','NDBC','Santa Monica Basin - 33NM WSW of Santa Monica, CA(NDBC Meteorological/Ocean)\r'),(353,'46026',37.755,-122.839,'NDBC','MET','NDBC','SAN FRANCISCO - 18NM West of San Francisco, CA(NDBC Meteorological/Ocean)\r'),(354,'46027',41.85,-124.381,'NDBC','MET','NDBC','ST GEORGES - 8NM NW of Crescent City, CA(NDBC Meteorological/Ocean)\r'),(355,'46028',35.741,-121.884,'NDBC','MET','NDBC','CAPE SAN MARTIN - 55NM West NW of Morro Bay, CA(NDBC Meteorological/Ocean)\r'),(356,'46029',46.159,-124.514,'NDBC','MET','NDBC','COLUMBIA RIVER BAR - 20NM West of Columbia River Mouth(NDBC Meteorological/Ocean)\r'),(357,'46035',57.067,-177.75,'NDBC','MET','NDBC','CENTRAL BERING SEA - 310 NM North of Adak, AK(NDBC Meteorological/Ocean)\r'),(358,'46036',48.355,-133.938,'NDBC','MET','Environment Canada','South Nomad(International Partners)\r'),(359,'46041',47.349,-124.708,'NDBC','MET','NDBC','CAPE ELIZABETH- 45NM NW of Aberdeen, WA(NDBC Meteorological/Ocean)\r'),(360,'46042',36.785,-122.469,'NDBC','MET','NDBC','MONTEREY - 27NM WNW of Monterey, CA(NDBC Meteorological/Ocean)\r'),(361,'46047',32.403,-119.536,'NDBC','MET','NDBC','TANNER BANK - 121NM West of San Diego, CA(NDBC Meteorological/Ocean)\r'),(362,'46050',44.639,-124.534,'NDBC','MET','NDBC','STONEWALL BANK - 20NM West of Newport, OR(NDBC Meteorological/Ocean)\r'),(363,'46053',34.248,-119.841,'NDBC','MET','NDBC','EAST SANTA BARBARA  - 12NM Southwest of Santa Barbara, CA(NDBC Meteorological/Ocean)\r'),(364,'46054',34.274,-120.462,'NDBC','MET','NDBC','WEST SANTA BARBARA  38 NM West of Santa Barbara, CA(NDBC Meteorological/Ocean)\r'),(365,'46059',38.047,-129.969,'NDBC','MET','NDBC','WEST CALIFORNIA - 357NM West of San Francisco, CA(NDBC Meteorological/Ocean)\r'),(366,'46060',60.584,-146.784,'NDBC','MET','NDBC','WEST ORCA BAY - 8NM NW of Hinchinbrook  IS , AK(NDBC Meteorological/Ocean)\r'),(367,'46061',60.233,-146.834,'NDBC','MET','NDBC','Seal Rocks - Between Montague and Hinchinbrook Islands, AK(NDBC Meteorological/Ocean)\r'),(368,'46066',52.737,-154.961,'NDBC','MET','NDBC','SOUTH KODIAK - 310NM SSW of Kodiak, AK(NDBC Meteorological/Ocean)\r'),(369,'46069',33.67,-120.2,'NDBC','MET','NDBC','SOUTH SANTA ROSA IS. CA(NDBC Meteorological/Ocean)\r'),(370,'46070',55.083,175.27,'NDBC','MET','NDBC','SOUTHWEST BERING SEA - 142NM NNE OF ATTU IS, AK(NDBC Meteorological/Ocean)\r'),(371,'46071',51.141,179.119,'NDBC','MET','NDBC','WESTERN ALEUTIANS - 14NM SOUTH OF AMCHITKA IS, AK (NDBC Meteorological/Ocean)\r'),(372,'46072',51.663,-172.162,'NDBC','MET','NDBC','CENTRAL ALEUTIANS 230NM SW Dutch Harbor(NDBC Meteorological/Ocean)\r'),(373,'46073',55.011,-171.981,'NDBC','MET','NDBC','SOUTHEAST BERING SEA -205NM WNW of Dutch Harbor, AK(NDBC Meteorological/Ocean)\r'),(374,'46075',53.911,-160.806,'NDBC','MET','NDBC','SHUMAGIN ISLANDS - 85NM South of Sand Point, AK(NDBC Meteorological/Ocean)\r'),(375,'46076',59.498,-147.983,'NDBC','MET','NDBC','CAPE CLEARE - 17 NM South of Montague Is,  AK(NDBC Meteorological/Ocean)\r'),(376,'46077',57.892,-154.291,'NDBC','MET','NDBC','SHELIKOF  STRAIT, AK(NDBC Meteorological/Ocean)\r'),(377,'46078',56.074,-152.572,'NDBC','MET','NDBC','ALBATROSS BANK - 104NM South of Kodiak, AK(NDBC Meteorological/Ocean)\r'),(378,'46080',57.924,-149.865,'NDBC','MET','NDBC','PORTLOCK BANK- 76NM ENE of Kodiak, AK(NDBC Meteorological/Ocean)\r'),(379,'46081',60.803,-148.263,'NDBC','MET','NDBC','Western Prince William Sound(NDBC Meteorological/Ocean)\r'),(380,'46082',59.668,-143.392,'NDBC','MET','NDBC','Cape Suckling - 35 NM SE of Kayak Is, AK(NDBC Meteorological/Ocean)\r'),(381,'46083',58.237,-137.986,'NDBC','MET','NDBC','Fairweather Ground 105NM West  of Juno, AK(NDBC Meteorological/Ocean)\r'),(382,'46084',56.612,-136.065,'NDBC','MET','NDBC','Cape Edgecumbe - 25NM SSW of Cape Edgecumbe, AK(NDBC Meteorological/Ocean)\r'),(383,'46085',55.868,-142.492,'NDBC','MET','NDBC','CENTRAL GULF OF ALASKA -  265NM West of Cape Ommaney, AKk(NDBC Meteorological/Ocean)\r'),(384,'46086',32.491,-118.034,'NDBC','MET','NDBC','SAN CLEMENTE BASIN - 27NM SE OF San Clemente Is, CA(NDBC Meteorological/Ocean)\r'),(385,'46087',48.494,-124.728,'NDBC','MET','NDBC','Neah Bay, - 6NM North of Cape Flattery, WA     (Traffic Separation Lighted Buoy)(NDBC Meteorological/Ocean)\r'),(386,'46088',48.336,-123.159,'NDBC','MET','NDBC','New Dungeness - 17 NM NE of Port Angeles, WA(NDBC Meteorological/Ocean)\r'),(387,'46089',45.893,-125.819,'NDBC','MET','NDBC','Tillamook, OR - 85 NM WNW of Tillamook, OR(NDBC Meteorological/Ocean)\r'),(388,'46091',36.835,-121.899,'NDBC','MET','MBARI','MBM0(IOOS Partners)\r'),(389,'46092',36.75,-122.02,'NDBC','MET','MBARI','MBM1(IOOS Partners)\r'),(390,'46093',36.69,-122.41,'NDBC','MET','MBARI','MBM2(IOOS Partners)\r'),(391,'46094',44.633,-124.304,'NDBC','MET','Oregon Coastal Ocean Observing System','West of Newport NH-10, OR(IOOS Partners)\r'),(392,'46096',46.173,-124.127,'NDBC','MET','Center for Coastal Margin Observation and Prediction','Columbia River Entrance - SATURN Station #02 Offshore(IOOS Partners)\r'),(393,'46105',59.049,-152.233,'NDBC','MET','NDBC','South Cook Inlet - 10NM NW of East Amatuli Light, AK(NDBC Meteorological/Ocean)\r'),(394,'46108',59.736,-152.006,'NDBC','MET','SCRIPPS','Central Cook Inlet - 175(IOOS Partners)\r'),(395,'46109',48.123,-123.395,'NDBC','MET','Intellicheck Mobilisa','Port Angeles Buoy(IOOS Partners)\r'),(396,'46110',48.115,-123.032,'NDBC','MET','Intellicheck Mobilisa','Sequim Buoy(IOOS Partners)\r'),(397,'46111',48.131,-122.748,'NDBC','MET','Intellicheck Mobilisa','Fort Worden Buoy(IOOS Partners)\r'),(398,'46112',48.1,-122.73,'NDBC','MET','Intellicheck Mobilisa','Marrowstone Buoy(IOOS Partners)\r'),(399,'46113',47.73,-122.646,'NDBC','MET','Intellicheck Mobilisa','Poulsbo Buoy(IOOS Partners)\r'),(400,'46120',47.761,-122.397,'NDBC','MET','University of Washington','Pt Wells, WA (U of Wash)(IOOS Partners)\r'),(401,'46121',47.28,-122.73,'NDBC','MET','University of Washington','Carr Inlet, WA (U of Wash) (IOOS Partners)\r'),(402,'46122',47.803,-122.803,'NDBC','MET','University of Washington','Dabob Bay, WA (U of Wash)(IOOS Partners)\r'),(403,'46123',47.375,-123.008,'NDBC','MET','University of Washington','Twanoh - Hood Canal, WA (U of Wash)(IOOS Partners)\r'),(404,'46124',47.422,-123.112,'NDBC','MET','University of Washington','Hoodsport - Hood Canal, WA (U of Wash)(IOOS Partners)\r'),(405,'46125',47.907,-122.627,'NDBC','MET','University of Washington','Hansville - Hood Canal, WA(IOOS Partners)\r'),(406,'46131',49.906,-124.985,'NDBC','MET','Environment Canada','Sentry Shoal(International Partners)\r'),(407,'46132',49.738,-127.931,'NDBC','MET','Environment Canada','South Brooks(International Partners)\r'),(408,'46134',48.648,-123.495,'NDBC','MET','Environment Canada','Pat Bay(International Partners)\r'),(409,'46138',52.437,-129.795,'NDBC','MET','Environment Canada','South Hecate Strait, Canada (174)(IOOS Partners)\r'),(410,'46139',48.84,-126,'NDBC','MET','Environment Canada','La Perouse Bank DWR, Canada  (215)(IOOS Partners)\r'),(411,'46145',54.366,-132.417,'NDBC','MET','Environment Canada','Central Dixon Entrance Buoy(International Partners)\r'),(412,'46146',49.34,-123.727,'NDBC','MET','Environment Canada','Halibut Bank(International Partners)\r'),(413,'46147',51.828,-131.225,'NDBC','MET','Environment Canada','South Moresby(International Partners)\r'),(414,'46181',53.833,-128.831,'NDBC','MET','Environment Canada','Nanakwa Shoal(International Partners)\r'),(415,'46183',53.617,-131.105,'NDBC','MET','Environment Canada','North Hecate Strait(International Partners)\r'),(416,'46184',53.915,-138.851,'NDBC','MET','Environment Canada','North Nomad(International Partners)\r'),(417,'46185',52.425,-129.792,'NDBC','MET','Environment Canada','South Hecate Strait(International Partners)\r'),(418,'46204',51.384,-128.767,'NDBC','MET','Environment Canada','West Sea Otter(International Partners)\r'),(419,'46205',54.165,-134.283,'NDBC','MET','Environment Canada','West Dixon Entrance(International Partners)\r'),(420,'46206',48.835,-125.998,'NDBC','MET','Environment Canada','La Perouse Bank(International Partners)\r'),(421,'46207',50.874,-129.916,'NDBC','MET','Environment Canada','East Dellwood(International Partners)\r'),(422,'46208',52.515,-132.693,'NDBC','MET','Environment Canada','West Moresby(International Partners)\r'),(423,'46211',46.857,-124.244,'NDBC','MET','SCRIPPS','Grays Harbor, WA (036)(IOOS Partners)\r'),(424,'46213',40.294,-124.74,'NDBC','MET','SCRIPPS','Cape Mendocino, CA (094)(IOOS Partners)\r'),(425,'46214',37.945,-123.47,'NDBC','MET','SCRIPPS','Point Reyes, CA (029)(IOOS Partners)\r'),(426,'46215',35.204,-120.86,'NDBC','MET','SCRIPPS','Diablo Canyon, CA (076)(IOOS Partners)\r'),(427,'46216',34.334,-119.804,'NDBC','MET','SCRIPPS','Goleta Point, CA (107)(IOOS Partners)\r'),(428,'46217',34.167,-119.435,'NDBC','MET','SCRIPPS','Anacapa Passage, CA (111)(IOOS Partners)\r'),(429,'46218',34.451,-120.769,'NDBC','MET','SCRIPPS','Harvest, CA (071)(IOOS Partners)\r'),(430,'46219',33.221,-119.882,'NDBC','MET','SCRIPPS','San Nicolas Island, CA (067)(IOOS Partners)\r'),(431,'46221',33.854,-118.633,'NDBC','MET','SCRIPPS','Santa Monica Bay, CA (028)(IOOS Partners)\r'),(432,'46222',33.618,-118.317,'NDBC','MET','SCRIPPS','San Pedro, CA (092)(IOOS Partners)\r'),(433,'46223',33.458,-117.767,'NDBC','MET','SCRIPPS','Dana Point, CA (096)(IOOS Partners)\r'),(434,'46224',33.179,-117.471,'NDBC','MET','SCRIPPS','Oceanside Offshore, CA (045)(IOOS Partners)\r'),(435,'46225',32.93,-117.393,'NDBC','MET','SCRIPPS','Torrey Pines Outer, CA (100)(IOOS Partners)\r'),(436,'46229',43.769,-124.551,'NDBC','MET','SCRIPPS','UMPQUA OFFSHORE, OR (139)(IOOS Partners)\r'),(437,'46232',32.53,-117.431,'NDBC','MET','SCRIPPS','Point Loma South, CA  (191)(IOOS Partners)\r'),(438,'46236',36.761,-121.947,'NDBC','MET','SCRIPPS','Monterey Canyon Outer, CA  (156)(IOOS Partners)\r'),(439,'46237',37.781,-122.599,'NDBC','MET','SCRIPPS','San Francisco Bar, CA  (142)(IOOS Partners)\r'),(440,'46238',33.499,-119.49,'NDBC','MET','SCRIPPS','San Nicolas Island North, CA (167)(IOOS Partners)\r'),(441,'46239',36.338,-122.101,'NDBC','MET','SCRIPPS','Point Sur, CA (157)(IOOS Partners)\r'),(442,'46240',36.626,-121.907,'NDBC','MET','SCRIPPS','Cabrillo Point, Monterey Bay, CA  (158)(IOOS Partners)\r'),(443,'46242',33.22,-117.44,'NDBC','MET','SCRIPPS','Camp Pendleton Nearshore, CA  (043)(IOOS Partners)\r'),(444,'46243',46.216,-124.128,'NDBC','MET','SCRIPPS','Clatsop Spit, OR - 162(IOOS Partners)\r'),(445,'46244',40.888,-124.357,'NDBC','MET','SCRIPPS','Humboldt Bay, North Spit, CA(IOOS Partners)\r'),(446,'46246',49.985,-145.089,'NDBC','MET','SCRIPPS','Ocean Station PAPA  (166)(IOOS Partners)\r'),(447,'46248',46.133,-124.667,'NDBC','MET','SCRIPPS','Astoria Canyon, OR  (179)(IOOS Partners)\r'),(448,'46402',51.068,-164.02,'NDBC','MET','NDBC',' South Dutch Harbor - 220 NM SSE of Dutch Harbor, AK(Tsunami)\r'),(449,'46403',52.65,-156.943,'NDBC','MET','NDBC','Southeast Shumagin Island - 186 NM SE of Shumagin Is, AK(Tsunami)\r'),(450,'46404',45.855,-128.775,'NDBC','MET','NDBC','WEST ASTORIA - 230 NM West of Astoria, OR(Tsunami)\r'),(451,'46407',42.664,-128.807,'NDBC','MET','NDBC','NEWPORT - 210NM West of Coos Bay, OR(Tsunami)\r'),(452,'46408',49.626,-169.855,'NDBC','MET','NDBC',' NIKOLSKI - 212NM South of Umnak Is, AK(Tsunami)\r'),(453,'46409',55.3,-148.515,'NDBC','MET','NDBC','SOUTHEAST KODIAK - 210 NM SE of Kodiak, AK(Tsunami)\r'),(454,'46410',57.635,-143.786,'NDBC','MET','NDBC','SOUTH CORDOVA 188NM SSE of Cordova, AK(Tsunami)\r'),(455,'46411',39.349,-127.021,'NDBC','MET','NDBC','Mendocino - 150 NM West of  Mendocino Bay, CA(Tsunami)\r'),(456,'46412',32.456,-120.558,'NDBC','MET','NDBC','San Diego - 175 NM West of San Diego, CA(Tsunami)\r'),(457,'46413',48.305,-174.212,'NDBC','MET','NDBC','SOUTH-SOUTHEAST ADAK - 230NM SSE of Adak, AK(Tsunami)\r'),(458,'46419',48.766,-129.633,'NDBC','MET','NDBC','NORTHWEST SEATTLE - 300 NM WNW of Seattle, WA(Tsunami)\r'),(459,'46518',44.5,-170,'NDBC','MET','NWS Alaska Region','Drifting Buoy(International Partners)\r'),(460,'46561',28.39,-171.29,'NDBC','MET','Environment Canada','Drifting Buoy(International Partners)\r'),(461,'46562',47.16,-157.67,'NDBC','MET','Environment Canada','Drifting Buoy(International Partners)\r'),(462,'48211',70.37,-146.04,'NDBC','MET','Shell Arctic','Camden Bay (Shell Arctic)(IOOS Partners)\r'),(463,'48212',70.874,-150.279,'NDBC','MET','Shell Arctic','Harrison Bay (Shell Arctic) (IOOS Partners)\r'),(464,'48213',71.502,-164.134,'NDBC','MET','Shell Arctic','Burger (MOB2)(IOOS Partners)\r'),(465,'48214',70.872,-165.249,'NDBC','MET','ConocoPhillips','Klondike (MOB1)(IOOS Partners)\r'),(466,'48216',70.387,-145.979,'NDBC','MET','Shell Arctic','Camden Bay ADCP (Shell Arctic)(Oil and Gas Industry)\r'),(467,'48400',50,-145,'NDBC','MET','NOAA/PMEL','Ocean Climate Station Papa(IOOS Partners)\r'),(468,'48911',30,-90,'NDBC','MET','Shell Oil','SG553(IOOS Partners)\r'),(469,'51000',31.3574,-156.599,'NDBC','MET','NDBC','NORTHERN HAWAII ONE - 245NM NE of Honolulu HI(NDBC Meteorological/Ocean)\r'),(470,'51001',23.445,-162.279,'NDBC','MET','NDBC','NORTHWESTERN HAWAII ONE - 170 NM West Northwest of Kauai Island(NDBC Meteorological/Ocean)\r'),(471,'51002',19.2666,170.8641,'NDBC','MET','NDBC','SOUTHWEST HAWAII - 215NM SSW of Hilo, HI(NDBC Meteorological/Ocean)\r'),(472,'51003',19.018,-160.582,'NDBC','MET','NDBC','WESTERN  HAWAII - 205 NM SW of Honolulu, HI(NDBC Meteorological/Ocean)\r'),(473,'51004',17.525,-152.382,'NDBC','MET','NDBC','SOUTHEAST HAWAII - 205 NM Southeast of Hilo, HI(NDBC Meteorological/Ocean)\r'),(474,'51006',9,-140,'NDBC','MET','NDBC','9N 140W(TAO)\r'),(475,'51007',5,-140,'NDBC','MET','NDBC','5N 140W(TAO)\r'),(476,'51008',2,-140,'NDBC','MET','NDBC','2N 140W(TAO)\r'),(477,'51009',-2,-140,'NDBC','MET','NDBC','2S 140W(TAO)\r'),(478,'51010',0,-170,'NDBC','MET','NDBC','0 170W(TAO)\r'),(479,'51011',0,-125,'NDBC','MET','NDBC','0 125W(TAO)\r'),(480,'51014',-5,-140,'NDBC','MET','NDBC','5S 140W(TAO)\r'),(481,'51015',5,-125,'NDBC','MET','NDBC','5N 125W(TAO)\r'),(482,'51016',2,-125,'NDBC','MET','NDBC','2N 125W(TAO)\r'),(483,'51017',-2,-125,'NDBC','MET','NDBC','2S 125W(TAO)\r'),(484,'51018',-5,-125,'NDBC','MET','NDBC','5S 125W(TAO)\r'),(485,'51019',-5,-155,'NDBC','MET','NDBC','5S 155W(TAO)\r'),(486,'51020',5,-155,'NDBC','MET','NDBC','5N 155W(TAO)\r'),(487,'51021',2,-155,'NDBC','MET','NDBC','2N 155W(TAO)\r'),(488,'51022',-2,-155,'NDBC','MET','NDBC','2S 155W(TAO)\r'),(489,'51023',0,-155,'NDBC','MET','NDBC','0 155W(TAO)\r'),(490,'51100',23.558,-153.9,'NDBC','MET','NDBC','NORTHERN HAWAII TWO - 252NM NE of Honolulu, HI(NDBC Meteorological/Ocean)\r'),(491,'51101',24.321,-162.058,'NDBC','MET','NDBC','NORTHWESTERN HAWAII TWO - 190NM NW of Kauai Is, HI  (NDBC Meteorological/Ocean)\r'),(492,'51201',21.673,-158.116,'NDBC','MET','Pacific Islands Ocean Observing System','Waimea Bay, HI (106)(IOOS Partners)\r'),(493,'51202',21.417,-157.668,'NDBC','MET','Pacific Islands Ocean Observing System','Mokapu Point, HI (098)(IOOS Partners)\r'),(494,'51203',20.788,-157.01,'NDBC','MET','Pacific Islands Ocean Observing System','Kaumalapau, HI (146)(IOOS Partners)\r'),(495,'51204',21.281,-158.124,'NDBC','MET','Pacific Islands Ocean Observing System','Barbers Point, HI #2 (165)(IOOS Partners)\r'),(496,'51205',21.019,-156.427,'NDBC','MET','Pacific Islands Ocean Observing System','Pauwela, Maui, HI (187)(IOOS Partners)\r'),(497,'51206',19.78,-154.97,'NDBC','MET','Pacific Islands Ocean Observing System','Hilo, Hawaii, HI - 188(IOOS Partners)\r'),(498,'51207',21.477,-157.753,'NDBC','MET','Pacific Islands Ocean Observing System','Kaneohe Bay, HI - 198(IOOS Partners)\r'),(499,'51301',8,-155,'NDBC','MET','NDBC','8N 155W(TAO)\r'),(500,'51302',-8,-155,'NDBC','MET','NDBC','8S 155W(TAO)\r'),(501,'51303',5,-170,'NDBC','MET','NDBC','5N 170W(TAO)\r'),(502,'51304',-5,-170,'NDBC','MET','NDBC','5S 170W(TAO)\r'),(503,'51305',2,-170,'NDBC','MET','NDBC','2N 170W(TAO)\r'),(504,'51306',-2,-170,'NDBC','MET','NDBC','2S 170W(TAO)\r'),(505,'51307',8,-125,'NDBC','MET','NDBC','8N 125W(TAO)\r'),(506,'51308',-8,-125,'NDBC','MET','NDBC','8S 125W(TAO)\r'),(507,'51309',8,-170,'NDBC','MET','NDBC','8N 170W(TAO)\r'),(508,'51310',-8,-170,'NDBC','MET','NDBC','8S 170W(TAO)\r'),(509,'51311',0,-140,'NDBC','MET','NDBC','0 140W(TAO)\r'),(510,'51407',19.591,-156.585,'NDBC','MET','NDBC','HAWAII - 34NM West of Kailua-Kona, HI(Tsunami)\r'),(511,'51425',-9.51,-176.241,'NDBC','MET','NDBC','NORTHWEST APIA - 370 NM NW of Apia, Samoa(Tsunami)\r'),(512,'51426',-25.4559,171.62,'NDBC','MET','NDBC','SOUTHEAST TONGA - 400NM SE of Tonga(Tsunami)\r'),(513,'51wh0',22.667,-157.95,'NDBC','MET','Woods Hole Oceanographic Institution','WHOTS - Woods Hole Ocean Time-series(IOOS Partners)\r'),(514,'52001',2,165,'NDBC','MET','NDBC','2N 165E(TAO)\r'),(515,'52002',-2,165,'NDBC','MET','NDBC','2S 165E(TAO)\r'),(516,'52003',5,165,'NDBC','MET','NDBC','5N 165E(TAO)\r'),(517,'52004',-5,165,'NDBC','MET','NDBC','5S 165E(TAO)\r'),(518,'52006',8,165,'NDBC','MET','NDBC','8N 165E(TAO)\r'),(519,'52007',-8,165,'NDBC','MET','NDBC','8S 165E(TAO)\r'),(520,'52200',13.354,144.789,'NDBC','MET','Pacific Islands Ocean Observing System','Ipan, Guam (121)(IOOS Partners)\r'),(521,'52201',7.092,171.395,'NDBC','MET','Pacific Islands Ocean Observing System','Kalo, Majuro, Marshall Islands - 163(IOOS Partners)\r'),(522,'52202',13.683,144.812,'NDBC','MET','Pacific Islands Ocean Observing System','Ritidian Point, Guam - 196(IOOS Partners)\r'),(523,'52211',15.267,145.662,'NDBC','MET','Pacific Islands Ocean Observing System','Tanapag, Saipan, NMI - 197(IOOS Partners)\r'),(524,'52309',5,180,'NDBC','MET','NDBC','5N 180W(TAO)\r'),(525,'52310',2,180,'NDBC','MET','NDBC','2N 180W(TAO)\r'),(526,'52311',0,180,'NDBC','MET','NDBC','0 180W(TAO)\r'),(527,'52312',-2,180,'NDBC','MET','NDBC','2S 180W(TAO)\r'),(528,'52313',-5,180,'NDBC','MET','NDBC','5S 180W(TAO)\r'),(529,'52315',8,180,'NDBC','MET','NDBC','8N 180W(TAO)\r'),(530,'52316',-8,180,'NDBC','MET','NDBC','8S 180W(TAO)\r'),(531,'52321',0,165,'NDBC','MET','NDBC','0 165E(TAO)\r'),(532,'52401',19.261,155.771,'NDBC','MET','NDBC','NORTHEAST SAIPAN - 610 NM ENE of Saipan(Tsunami)\r'),(533,'52402',11.869,154.039,'NDBC','MET','NDBC','SOUTHEAST SAIPAN - 540NM ESE of Saipan(Tsunami)\r'),(534,'52403',4.052,145.592,'NDBC','MET','NDBC','NORTH MANUS - 345NM North of Manus Is , New Guinea(Tsunami)\r'),(535,'52404',23.0156,125.522,'NDBC','MET','NDBC','NORTH PHILIPPINE SEA - 750 NM NE of Manila, Philippines(Tsunami)\r'),(536,'52405',12.881,132.333,'NDBC','MET','NDBC','SOUTH PHILIPPINE SEA -725 NM West of Agana, Guam(Tsunami)\r'),(537,'52406',-5.293,165.002,'NDBC','MET','NDBC','NORTHEAST SOLOMON - 370NM NE of the Guadalcanal(Tsunami)\r'),(538,'52839',5.758,143,'NDBC','MET','AOML','(IOOS Partners)\r'),(539,'52841',5.943,149,'NDBC','MET','AOML','(IOOS Partners)\r'),(540,'52901',15,155.104,'NDBC','MET','AOML','(IOOS Partners)\r'),(541,'53046',-11.445,113.607,'NDBC','MET','Australian Bureau of Meteorology','South Bali(Tsunami)\r'),(542,'54401',-34.9071,-157.219,'NDBC','MET','NDBC','NORTHEAST NEW ZEALAND - 640NM NE of Auckland, NZ(Tsunami)\r'),(543,'55012',-15.799,158.4,'NDBC','MET','Australian Bureau of Meteorology','Coral Sea 1     -     1285km ENE of Townsville(Tsunami)\r'),(544,'55013',-46.665,161.001,'NDBC','MET','Australian Bureau of Meteorology','TASMAN SEA 3     -     1160km ESE of Hobart(Tsunami)\r'),(545,'55015',-46.84,160.254,'NDBC','MET','Australian Bureau of Meteorology','TASMAN SEA 1     -     1110km ESE of Hobart(Tsunami)\r'),(546,'55016',-26,176,'NDBC','MET','Australian Bureau of Meteorology','ETD Fiji Basin(Tsunami)\r'),(547,'55023',-14.8,153.58,'NDBC','MET','Australian Bureau of Meteorology','Coral Sea 2     -     870km NE of Townsville(Tsunami)\r'),(548,'55042',-44.853,161.728,'NDBC','MET','Australian Bureau of Meteorology','Tasman Sea 2     -     1175km ESE of Hobart(Tsunami)\r'),(549,'56001',-13.985,110.005,'NDBC','MET','Australian Bureau of Meteorology','Indian Ocean 1     -      1025km NW of Dampier(Tsunami)\r'),(550,'56003',-15.021,117.989,'NDBC','MET','Australian Bureau of Meteorology','Indian Ocean 2     -     630km NNE of Dampier(Tsunami)\r'),(551,'58904',30,-90,'NDBC','MET','University of Washington - APL','SG170(IOOS Partners)\r'),(552,'58906',30,-90,'NDBC','MET','University of Washington - APL','SB124(IOOS Partners)\r'),(553,'61001',43.4,7.8,'NDBC','MET','Meteo France','Nice Buoy(International Partners)\r'),(554,'61002',42.102,4.703,'NDBC','MET','Meteo France','Lion Buoy(International Partners)\r'),(555,'62001',45.201,-5,'NDBC','MET','UK Met Office','Gascogne Buoy(International Partners)\r'),(556,'62027',49.082,-2.218,'NDBC','MET','Meteorological Dept, States of Jersey','Jersey Buoy, English Channel - 5 nm south of Jersey, UK(International Partners)\r'),(557,'62028',50.59,-2.3,'NDBC','MET','UK Met Office','Weymouth Bay, UK(International Partners)\r'),(558,'62029',48.701,-12.401,'NDBC','MET','UK Met Office','K1 Buoy(International Partners)\r'),(559,'62081',51,-13.301,'NDBC','MET','UK Met Office','K2 Buoy(International Partners)\r'),(560,'62092',51.217,-10.55,'NDBC','MET','Met Eireann','M3 - 30 NM Southwest of Mizen Head(International Partners)\r'),(561,'62093',55,-10,'NDBC','MET','Met Eireann','M4 - Donegal Bay(International Partners)\r'),(562,'62094',51.69,-6.704,'NDBC','MET','Met Eireann','M5 - South East(International Partners)\r'),(563,'62095',53.056,-15.924,'NDBC','MET','Met Eireann','M6 - West Coast(International Partners)\r'),(564,'62103',49.9,-2.9,'NDBC','MET','UK Met Office','Channel Lightship(International Partners)\r'),(565,'62105',55.4,-12.2,'NDBC','MET','UK Met Office','K4 Buoy(International Partners)\r'),(566,'62107',50.103,-6.1,'NDBC','MET','UK Met Office','Sevenstones Lightship(International Partners)\r'),(567,'62114',58.3,0.1,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(568,'62121',53.5,2.7,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(569,'62125',53.8,-3.5,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(570,'62126',53.9,-3.6,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(571,'62127',54,0.7,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(572,'62130',53,1.7,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(573,'62135',54,-3.8,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(574,'62142',53,2.101,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(575,'62144',53.4,1.7,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(576,'62145',53.103,2.8,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(577,'62146',53.8,2.8,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(578,'62147',57.603,1.7,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(579,'62148',53.6,1.5,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(580,'62149',53.7,1.1,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(581,'62150',53.6,0.7,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(582,'62163',47.5,-8.5,'NDBC','MET','UK Met Office','Brittany Buoy(International Partners)\r'),(583,'62164',57.201,0.5,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(584,'62165',54,1.1,'NDBC','MET','Private Industry Oil Platform','(International Partners)\r'),(585,'62301',52.3,-4.5,'NDBC','MET','UK Met Office','Aberporth Buoy(International Partners)\r'),(586,'62303',51.603,-5.1,'NDBC','MET','UK Met Office','Pembroke Buoy(International Partners)\r'),(587,'62304',51.103,1.8,'NDBC','MET','UK Met Office','Sandettie Lightship(International Partners)\r'),(588,'62305',50.4,0,'NDBC','MET','UK Met Office','Greenwich Lightship(International Partners)\r'),(589,'63105',61,1.7,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(590,'63110',59.5,1.5,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(591,'63112',61.103,0,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(592,'63113',61,1.7,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(593,'63117',61.4,1.2,'NDBC','MET','Private Industry Oil Platform','North Sea(International Partners)\r'),(594,'64045',59.1,-11.401,'NDBC','MET','UK Met Office','K5 Buoy(International Partners)\r'),(595,'64046',60.701,-4.5,'NDBC','MET','UK Met Office','K7 Buoy(International Partners)\r'),(596,'aamc1',37.772,-122.298,'NDBC','MET','NOS','9414750 - Alameda, CA(NOS/CO-OPS)\r'),(597,'acqs1',32.523,-80.357,'NDBC','MET','National Estuarine Research Reserve System','St. Pierre, Ace Basin Reserve, SC(NERRS)\r'),(598,'acxs1',32.559,-80.454,'NDBC','MET','National Estuarine Research Reserve System','ACE Basin Reserve, SC(NERRS)\r'),(599,'acyn4',39.355,-74.418,'NDBC','MET','NOS','8534720 - Atlantic City, NJ(NOS/CO-OPS)\r'),(600,'adka2',51.863,-176.632,'NDBC','MET','NOS','9461380 - Adak Island, AK(NOS/CO-OPS)\r'),(601,'agcm4',42.621,-82.527,'NDBC','MET','NOS','9014070 - Algonac, MI(NOS/CO-OPS)\r'),(602,'agmw3',44.608,-87.433,'NDBC','MET','NWS Central Region','Algoma City Marina WI(IOOS Partners)\r'),(603,'alia2',56.898,-154.247,'NDBC','MET','NOS','9457804 - Alitak, AK(NOS/CO-OPS)\r'),(604,'alxn6',44.33,-75.933,'NDBC','MET','NOS','8311062 - Alexandria Bay, NY(NOS/CO-OPS)\r'),(605,'amaa2',58.915,-151.952,'NDBC','MET','NDBC','East Amatuli Island Light, AK(NDBC Meteorological/Ocean)\r'),(606,'amrl1',29.45,-91.338,'NDBC','MET','NOS','8764227 - Amerada Pass, LA(NOS/CO-OPS)\r'),(607,'ancf1',28.193,-82.789,'NDBC','MET','COMPS (University of South Florida)','Anclote Gulf Park, FL(IOOS Partners)\r'),(608,'anmf1',27.55,-82.75,'NDBC','MET','COMPS (University of South Florida)','ANM - Anna Maria, FL(IOOS Partners)\r'),(609,'anmn6',42.018,-73.917,'NDBC','MET','National Estuarine Research Reserve System','Hudson River Reserve, NY(NERRS)\r'),(610,'anrn6',42.027,-73.926,'NDBC','MET','National Estuarine Research Reserve System','Tivoli South, Hudson River Reserve, NY(NERRS)\r'),(611,'anta2',61.238,-149.89,'NDBC','MET','NOS','9455920 - Anchorage, AK(NOS/CO-OPS)\r'),(612,'anvc1',38.913,-123.708,'NDBC','MET','NOS','9416841 - Arena Cove, CA(NOS/CO-OPS)\r'),(613,'apam2',38.983,-76.48,'NDBC','MET','NOS','8575512 - Annapolis, MD(NOS/CO-OPS)\r'),(614,'apcf1',29.727,-84.982,'NDBC','MET','NOS','8728690 - Apalachicola, FL(NOS/CO-OPS)\r'),(615,'apnm4',45.06,-83.424,'NDBC','MET','GLERL','Alpena Harbor Light, MI(IOOS Partners)\r'),(616,'apqf1',29.786,-84.875,'NDBC','MET','National Estuarine Research Reserve System','East Bay, Apalachicola Reserve, FL(NERRS)\r'),(617,'aprp7',13.442,144.653,'NDBC','MET','NOS','1630000 - Apra Harbor, Guam(NOS/CO-OPS)\r'),(618,'apxf1',29.791,-84.883,'NDBC','MET','National Estuarine Research Reserve System','Apalachicola Reserve, FL(NERRS)\r'),(619,'arop4',18.48,-66.702,'NDBC','MET','Puerto Rico Seismic Network','9757809 - Arecibo, PR(IOOS Partners)\r'),(620,'arpf1',28.433,-82.667,'NDBC','MET','COMPS (University of South Florida)','APK - Aripeka, FL(IOOS Partners)\r'),(621,'asto3',46.208,-123.767,'NDBC','MET','NOS','9439040 - Astoria, OR(NOS/CO-OPS)\r'),(622,'atgm1',44.392,-68.205,'NDBC','MET','NOS','8413320 - Bar Harbor, ME(NOS/CO-OPS)\r'),(623,'atka2',52.232,-174.173,'NDBC','MET','NOS','9461710 - Atka, AK(NOS/CO-OPS)\r'),(624,'audp4',18.458,-67.164,'NDBC','MET','NOS','9759412 - Aquadilla, PR(NOS/CO-OPS)\r'),(625,'auga2',59.378,-153.348,'NDBC','MET','NDBC','Augustine Island, AK(NDBC Meteorological/Ocean)\r'),(626,'babt2',27.301,-97.416,'NDBC','MET','TCOON','8776604 - Baffin Bay; Point of Rocks, TX(IOOS Partners)\"\r\n;bara9;17.591;-61.821;NDBC;MET;NOS;9761115 - Barbuda, Barbuda('),(627,'lmdf1',25.174,-80.632,'NDBC','MET','Everglades National Park','Little Madeira, FL(IOOS Partners)\r'),(628,'lmfs1',34.107,-81.271,'NDBC','MET','NWS Eastern Region','Lake Murray SC(IOOS Partners)\r'),(629,'lmrf1',25.554,-81.169,'NDBC','MET','Everglades National Park','Lostmans River, FL(IOOS Partners)\r'),(630,'lmss1',33.552,-80.501,'NDBC','MET','NWS Eastern Region','Lake Marion, SC(IOOS Partners)\r'),(631,'lndc1',37.795,-122.288,'NDBC','MET','NOS','9414763 - Oakland, CA(NOS/CO-OPS)\r'),(632,'lonf1',24.843,-80.862,'NDBC','MET','NDBC','Long Key, FL(NDBC Meteorological/Ocean)\r'),(633,'lopl1',28.885,-90.024,'NDBC','MET','Louisiana Offshore Oil Port','Louisiana Offshore Oil Port, LA(IOOS Partners)\r'),(634,'lopw1',46.108,-122.957,'NDBC','MET','NOS','9440422 - Longview, WA(NOS/CO-OPS)\r'),(635,'lpnm4',45.063,-83.428,'NDBC','MET','NOS','9075065 - Alpena, MI (NOS/CO-OPS)\r'),(636,'lprp4',17.939,-67.052,'NDBC','MET','Integrated Coral Observing Network (ICON)','Media Luna, La Parguera, PR(IOOS Partners)\r'),(637,'lpwa2',56.388,-134.637,'NDBC','MET','National Marine Fisheries Service','Little Port Walter, AK(IOOS Partners)\r'),(638,'lrif1',25.284,-80.894,'NDBC','MET','Everglades National Park','Lane River, FL (IOOS Partners)\r'),(639,'lrkf1',24.979,-80.826,'NDBC','MET','Everglades National Park','Little Rabbit Key, FL(IOOS Partners)\r'),(640,'lsio3',46.256,-123.982,'NDBC','MET','Center for Coastal Margin Observation and Prediction','Lower Sand Island Light, OR(IOOS Partners)\r'),(641,'lsnf1',25.233,-80.457,'NDBC','MET','Everglades National Park','Long Sound, FL(IOOS Partners)\r'),(642,'ltbv3',17.697,-64.753,'NDBC','MET','NOS','9751401 - Lime Tree Bay, VI(NOS/CO-OPS)\r'),(643,'ltqm2',39.451,-76.275,'NDBC','MET','National Estuarine Research Reserve System','Otter Point Creek, Chesapeake Bay Reserve, MD(NERRS)\r'),(644,'ltrm4',46.485,-84.3,'NDBC','MET','NOS','9076033 - Little Rapids, MI(NOS/CO-OPS)\r'),(645,'luml1',29.253,-90.663,'NDBC','MET','LUMCON','LUMCON Marine Center, LA(IOOS Partners)\r'),(646,'lwsd1',38.782,-75.12,'NDBC','MET','NOS','8557380 - Lewes, DE(NOS/CO-OPS)\r'),(647,'lwtv2',37.995,-76.465,'NDBC','MET','NOS','8635750 - Lewisetta, VA(NOS/CO-OPS)\r'),(648,'macm4',45.778,-84.725,'NDBC','MET','NOS','9075080 - Mackinaw City, MI(NOS/CO-OPS)\r'),(649,'maqt2',27.98,-97.029,'NDBC','MET','National Estuarine Research Reserve System','Mission-Aransas Reserve, TX(NERRS)\r'),(650,'maxt2',28.132,-97.034,'NDBC','MET','National Estuarine Research Reserve System','Mission-Aransas Reserve, TX(NERRS)\r'),(651,'mbla1',30.437,-88.012,'NDBC','MET','Dauphin Island Sea Lab','Middle Bay Light, AL(IOOS Partners)\r'),(652,'mbrm4',42.974,-82.42,'NDBC','MET','NOS','9014090 - Mouth of the Black River, MI (NOS/CO-OPS)\r'),(653,'mcga1',30.648,-88.058,'NDBC','MET','NOS','8736897 - Coast Guard Sector Mobile, AL(NOS/CO-OPS)\r'),(654,'mcgm4',46.545,-87.378,'NDBC','MET','NOS','9099018 - Marquette C.G., MI(NOS/CO-OPS)\r'),(655,'mcyf1',27.913,-82.425,'NDBC','MET','NOS','8726667 - McKay Bay Entrance, FL(NOS/CO-OPS)\r'),(656,'mcyi3',41.729,-86.913,'NDBC','MET','GLERL','Michigan City, IN(IOOS Partners)\r'),(657,'mdrm1',43.968,-68.128,'NDBC','MET','NDBC','Mt Desert Rock, ME(NDBC Meteorological/Ocean)\r'),(658,'meem4',44.248,-86.346,'NDBC','MET','NWS Central Region','Manistee Harbor, MI(IOOS Partners)\r'),(659,'mgip4',17.972,-67.047,'NDBC','MET','NOS','9759110 - Magueyes Islands, PR(NOS/CO-OPS)\r'),(660,'mgpt2',29.682,-94.985,'NDBC','MET','NOS','8770613 - Morgans Point, TX(NOS/CO-OPS)\r'),(661,'mgzp4',18.218,-67.159,'NDBC','MET','Puerto Rico Seismic Network','9759394 - Mayaguez, PR(IOOS Partners)\r'),(662,'mhpa1',30.667,-87.936,'NDBC','MET','Dauphin Island Sea Lab','Meaher Park, AL(IOOS Partners)\r'),(663,'mism1',43.783,-68.855,'NDBC','MET','NDBC','Matinicus Rock, ME(NDBC Meteorological/Ocean)\r'),(664,'misp4',18.09,-67.939,'NDBC','MET','NOS','9759938 - Mona Island, PR(NOS/CO-OPS)\r'),(665,'mkgm4',43.228,-86.339,'NDBC','MET','GLERL','Muskegon, MI(IOOS Partners)\r'),(666,'mlrf1',25.012,-80.376,'NDBC','MET','NDBC','Molasses Reef, FL(NDBC Meteorological/Ocean)\r'),(667,'mlsc1',36.807,-121.788,'NDBC','MET','Moss Landing Marine Lab','Moss Landing, South Harbor, CA(IOOS Partners)\r'),(668,'mlww3',43.046,-87.879,'NDBC','MET','GLERL','Milwaukee, WI(IOOS Partners)\r'),(669,'mnmm4',45.096,-87.59,'NDBC','MET','NOS','9087088 - Menominee, MI(NOS/CO-OPS)\r'),(670,'mnpv2',36.778,-76.302,'NDBC','MET','NOS','8639348 - Money Point, VA(NOS/CO-OPS)\r'),(671,'mokh1',21.432,-157.79,'NDBC','MET','NOS','1612480 - Mokuoloe, HI(NOS/CO-OPS)\r'),(672,'mqtt2',27.58,-97.217,'NDBC','MET','NOS','8775870 - Malaquite Beach (Corpus Christi), TX(NOS/CO-OPS)\r'),(673,'mrcp1',39.812,-75.41,'NDBC','MET','NOS','8540433 - Marcus Hook, PA(NOS/CO-OPS)\r'),(674,'mrho1',41.545,-82.732,'NDBC','MET','NOS','9063079 - Marblehead, OH(NOS/CO-OPS)\r'),(675,'mrka2',61.082,-146.662,'NDBC','MET','NDBC','Middle Rock Light, AK(NDBC Meteorological/Ocean)\r'),(676,'mrna2',58.198,-134.257,'NDBC','MET','Marine Exchange of Alaska','Marmion Island, AK(IOOS Partners)\r'),(677,'mros1',33.655,-78.918,'NDBC','MET','NOS','8661070 - Springmaid Pier, SC(NOS/CO-OPS)\r'),(678,'mrsl1',29.44,-92.061,'NDBC','MET','LSU CSI','Marsh Island, LA / CSI03(IOOS Partners)\r'),(679,'mrya2',55.099,-131.182,'NDBC','MET','Marine Exchange of Alaska','Mary Island, AK(IOOS Partners)\r'),(680,'mtbf1',27.661,-82.594,'NDBC','MET','COMPS (University of South Florida)','Middle Tampa Bay(IOOS Partners)\r'),(681,'mtkn6',41.048,-71.96,'NDBC','MET','NOS','8510560 - Montauk, NY(NOS/CO-OPS)\r'),(682,'mtyc1',36.605,-121.888,'NDBC','MET','NOS','9413450 - Monterey, CA(NOS/CO-OPS)\r'),(683,'mukf1',25.104,-80.942,'NDBC','MET','Everglades National Park','Murray Key, FL(IOOS Partners)\r'),(684,'mypf1',30.397,-81.43,'NDBC','MET','NOS','8720218 - Mayport (Bar Pilots Dock), FL(NOS/CO-OPS)\r'),(685,'mzxc1',38.033,-122.125,'NDBC','MET','NOS','9415102 - Martinez-Amorco CA(NOS/CO-OPS)\r'),(686,'nabm4',46.087,-85.443,'NDBC','MET','NWS Central Region','Naubinway, MI(IOOS Partners)\r'),(687,'naqr1',41.579,-71.321,'NDBC','MET','National Estuarine Research Reserve System','T-Wharf Bottom, Narragansett Bay Reserve, RI(NERRS)\r'),(688,'naxr1',41.639,-71.339,'NDBC','MET','National Estuarine Research Reserve System','Narragansett Bay Reserve, RI(NERRS)\r'),(689,'nblp1',40.137,-74.75,'NDBC','MET','NOS','8548989 - Newbold, PA(NOS/CO-OPS)\r'),(690,'ncht2',29.726,-95.266,'NDBC','MET','TCOON','8770777 - Manchester, TX (IOOS Partners)\r'),(691,'neaw1',48.368,-124.617,'NDBC','MET','NOS','9443090 - Neah Bay, WA(NOS/CO-OPS)\r'),(692,'nfbf1',25.084,-81.096,'NDBC','MET','COMPS (University of South Florida)','NFB - Northwest Florida Bay, FL(IOOS Partners)\r'),(693,'nglt2',27.822,-97.203,'NDBC','MET','TCOON','8775283 - Port Ingleside, TX(IOOS Partners)\r'),(694,'nian6',43.077,-79.013,'NDBC','MET','NOS','9063012 - Niagara Intake, NY(NOS/CO-OPS)\r'),(695,'niqs1',33.349,-79.193,'NDBC','MET','National Estuarine Research Reserve System','Oyster Landing, North Inlet-Winyah Bay Reserve, SC(NERRS)\r'),(696,'niws1',33.349,-79.193,'NDBC','MET','National Estuarine Research Reserve System','North Inlet-Winyah Bay Reserve, SC(NERRS)\r'),(697,'nkta2',60.683,-151.398,'NDBC','MET','NOS','9455760 - Nikiski, AK(NOS/CO-OPS)\r'),(698,'nlnc3',41.355,-72.087,'NDBC','MET','NOS','8461490 - New London, CT(NOS/CO-OPS)\r'),(699,'nmta2',64.5,-165.43,'NDBC','MET','NOS','9468756 - Nome, Norton Sound, AK(NOS/CO-OPS)\r'),(700,'noqn7',34.156,-77.85,'NDBC','MET','National Estuarine Research Reserve System','Research Creek, North Carolina Reserve, NC(NERRS)\r'),(701,'noxn7',34.156,-77.851,'NDBC','MET','National Estuarine Research Reserve System','North Carolina Reserve, NC(NERRS)\r'),(702,'npdw3',45.29,-86.978,'NDBC','MET','NWS Central Region','Northport Pier at Death\'s Door WI(IOOS Partners)\r'),(703,'npsf1',26.13,-81.807,'NDBC','MET','NOS','8725110 - Naples, FL(NOS/CO-OPS)\r'),(704,'nstp6',-14.28,-170.688,'NDBC','MET','NOS','1770000 - Pago Pago(NOS/CO-OPS)\r'),(705,'ntbc1',34.408,-119.685,'NDBC','MET','NOS','9411340 - Santa Barbara, CA (NOS/CO-OPS)\r'),(706,'ntkm3',41.285,-70.097,'NDBC','MET','NOS','8449130 - Nantucket Island, MA(NOS/CO-OPS)\r'),(707,'nwcl1',30.027,-90.113,'NDBC','MET','NOS','8761927 - New Canal, LA(NOS/CO-OPS)\r'),(708,'nwhc3',41.283,-72.908,'NDBC','MET','NOS','8465705 - New Haven, CT(NOS/CO-OPS)\r'),(709,'nwpo3',44.613,-124.067,'NDBC','MET','NDBC','Newport, OR(NDBC Meteorological/Ocean)\r'),(710,'nwpr1',41.505,-71.327,'NDBC','MET','NOS','8452660 - Newport, RI(NOS/CO-OPS)\r'),(711,'nwwh1',21.953,-159.355,'NDBC','MET','NOS','1611400 - Nawiliwili, HI(NOS/CO-OPS)\r'),(712,'obgn6',44.703,-75.495,'NDBC','MET','NOS','8311030 - Ogdensburg, NY(NOS/CO-OPS)\r'),(713,'obla1',30.708,-88.043,'NDBC','MET','NOS','8737048 - Mobile State Docks, AL(NOS/CO-OPS)\r'),(714,'ocgn4',40.209,-74.004,'NDBC','MET','Stevens','Ocean Grove, NJ(IOOS Partners)\r'),(715,'ocim2',38.328,-75.092,'NDBC','MET','NOS','8570283 - Ocean City Inlet, MD(NOS/CO-OPS)\r'),(716,'ocpn7',33.908,-78.148,'NDBC','MET','CORMP','OCP1 - Ocean Crest Pier, NC(IOOS Partners)\r'),(717,'ocsm2',38.339,-75.07,'NDBC','MET','U.S. Army Corps of Engineers','Ocean City, MD(IOOS Partners)\r'),(718,'ohbc1',33.72,-118.272,'NDBC','MET','NOS','9410660 - Los Angeles, CA(NOS/CO-OPS)\r'),(719,'oksi2',41.912,-87.624,'NDBC','MET','Chicago Park District','Oak ST, Chicago, IL (CPD)(IOOS Partners)\r'),(720,'okxc1',37.811,-122.333,'NDBC','MET','NOS','9414776 - Oakland (Berth 34), CA(NOS/CO-OPS)\r'),(721,'olcn6',43.341,-78.719,'NDBC','MET','NWS Eastern Region','Olcott Harbor, NY(IOOS Partners)\r'),(722,'olsa2',52.941,-168.871,'NDBC','MET','NOS','9462450 - Nokolski, AK(NOS/CO-OPS)\r'),(723,'omhc1',37.8,-122.33,'NDBC','MET','NOS','9414769 - Oakland Middle Harbor Met, CA(NOS/CO-OPS)\r'),(724,'oouh1',21.307,-157.867,'NDBC','MET','NOS','1612340 - Honolulu, HI(NOS/CO-OPS)\r'),(725,'optf1',27.858,-82.553,'NDBC','MET','NOS','8726607 - Old Port Tampa, FL(NOS/CO-OPS)\r'),(726,'orin7',35.795,-75.548,'NDBC','MET','NOS','8652587 - Oregon Inlet Marina, NC(NOS/CO-OPS)\r'),(727,'osgn6',43.463,-76.512,'NDBC','MET','NOS','9052030 - Oswego, NY(NOS/CO-OPS)\r'),(728,'otnm4',46.874,-89.329,'NDBC','MET','NWS Central Region','Ontonagon, MI(IOOS Partners)\r'),(729,'ovia2',59.44,-151.72,'NDBC','MET','NOS','9455500 - Seldovia, AK(NOS/CO-OPS)\r'),(730,'owqo1',41.382,-82.514,'NDBC','MET','National Estuarine Research Reserve System','Lower Estuary, Old Woman Creek Reserve, OH(NERRS)\r'),(731,'owxo1',41.378,-82.508,'NDBC','MET','National Estuarine Research Reserve System','Old Woman Creek, OH(NERRS)\r'),(732,'pacf1',30.152,-85.667,'NDBC','MET','NOS','8729108 - Panama City, FL(NOS/CO-OPS)\r'),(733,'pact2',27.633,-97.237,'NDBC','MET','TCOON','8775792 - Packery Channel, TX(IOOS Partners)\r'),(734,'pbfw1',48.464,-122.468,'NDBC','MET','National Estuarine Research Reserve System','Padilla Bay Reserve, WA(NERRS)\r'),(735,'pblw1',48.556,-122.53,'NDBC','MET','National Estuarine Research Reserve System','Joe Leary Slough, Padilla Bay Reserve, WA(NERRS)\r'),(736,'pbpa2',58.203,-134.148,'NDBC','MET','NWS Alaska Region','Point Bishop, AK(IOOS Partners)\r'),(737,'pcgt2',26.077,-97.177,'NDBC','MET','TCOON','8779748 - South Padre Island CGS, TX (IOOS Partners)\r'),(738,'pclf1',30.403,-87.212,'NDBC','MET','NOS','8729840 - Pensacola, FL(NOS/CO-OPS)\r'),(739,'pclm4',47.276,-88.528,'NDBC','MET','NWS Central Region','Portage Canal, MI(IOOS Partners)\r'),(740,'pcnt2',28.452,-96.388,'NDBC','MET','TCOON','8773701 - Matagorda Bay; Port O\'Connor, TX(IOOS Partners)\"\r\n;pcoc1;38.057;-122.038;NDBC;MET;NOS;9415144 - Port Chicago, '),(741,'sanf1',24.454,-81.877,'NDBC','MET','NDBC','Sand Key, FL(NDBC Meteorological/Ocean)\r'),(742,'sapf1',27.76,-82.627,'NDBC','MET','NOS','8726520 - St. Petersburg, FL(NOS/CO-OPS)\r'),(743,'saqg1',31.418,-81.296,'NDBC','MET','National Estuarine Research Reserve System','Lower Duplin, Sapelo Island Reserve, GA(NERRS)\r'),(744,'sauf1',29.857,-81.265,'NDBC','MET','NDBC','St. Augustine, FL(NDBC Meteorological/Ocean)\r'),(745,'saxg1',31.418,-81.295,'NDBC','MET','National Estuarine Research Reserve System','Sapelo Island Reserve, GA(NERRS)\r'),(746,'sbeo3',44.625,-124.043,'NDBC','MET','NOS','9435380 - South Beach, OR(NOS/CO-OPS)\r'),(747,'sbio1',41.628,-82.842,'NDBC','MET','NDBC','South Bass Island, OH(NDBC Meteorological/Ocean)\r'),(748,'sblf1',27.923,-82.445,'NDBC','MET','NOS','8726673 - Seabulk, Tampa, FL(NOS/CO-OPS)\r'),(749,'sblm4',43.806,-83.719,'NDBC','MET','NWS Central Region','Saginaw Bay Light #1, MI(IOOS Partners)\r'),(750,'sbpt2',29.73,-93.87,'NDBC','MET','NOS','8770570 - Sabine Pass North, TX(NOS/CO-OPS)\r'),(751,'scld1',39.085,-75.461,'NDBC','MET','National Estuarine Research Reserve System','Scotton Landing, Delaware Reserve, DE(NERRS)\r'),(752,'scqc1',38.001,-122.46,'NDBC','MET','National Estuarine Research Reserve System','China Camp, San Francisco Bay Reserve, CA(NERRS)\r'),(753,'sdbc1',32.713,-117.173,'NDBC','MET','NOS','9410170 - San Diego, CA(NOS/CO-OPS)\r'),(754,'sdhn4',40.467,-74.01,'NDBC','MET','NOS','8531680 - Sandy Hook, NJ(NOS/CO-OPS)\r'),(755,'sdia2',58.277,-134.389,'NDBC','MET','NWS Alaska Region','South Douglas, AK(IOOS Partners)\r'),(756,'sdrt2',28.407,-96.712,'NDBC','MET','TCOON','8773037 - Seadrift, TX(IOOS Partners)\r'),(757,'sefo3',46.204,-123.759,'NDBC','MET','Center for Coastal Margin Observation and Prediction','SATURN Estuary Station #04 at Mott Basin(IOOS Partners)\r'),(758,'seqa2',59.441,-151.719,'NDBC','MET','National Estuarine Research Reserve System','Katchemak Bay near Seldovia, AK(NERRS)\r'),(759,'seto3',46.2,-123.94,'NDBC','MET','Center for Coastal Margin Observation and Prediction','SATURN Estuary Station #03(IOOS Partners)\r'),(760,'sfxc1',38.223,-122.026,'NDBC','MET','National Estuarine Research Reserve System','San Francisco Bay Reserve, CA(NERRS)\r'),(761,'sgnw3',43.75,-87.692,'NDBC','MET','NDBC','Sheboygan, WI(NDBC Meteorological/Ocean)\r'),(762,'sgof1',29.407,-84.863,'NDBC','MET','NDBC','Tyndall AFB Tower C (N4), FL(NDBC Meteorological/Ocean)\r'),(763,'shbl1',29.868,-89.673,'NDBC','MET','NOS','8761305 - Shell Beach, LA(NOS/CO-OPS)\r'),(764,'shpf1',30.06,-84.291,'NDBC','MET','COMPS (University of South Florida)','SHP - Shell Point, FL(IOOS Partners)\r'),(765,'sipf1',27.862,-80.445,'NDBC','MET','Florida Institute of Technology','Sebastian Inlet State Park, FL(IOOS Partners)\r'),(766,'sisa2',58.171,-135.256,'NDBC','MET','NWS Alaska Region','Sisters Island, AK(IOOS Partners)\r'),(767,'sisw1',48.318,-122.843,'NDBC','MET','NDBC','Smith Island, WA(NDBC Meteorological/Ocean)\r'),(768,'sjnp4',18.462,-66.117,'NDBC','MET','NOS','9755371 - San Juan, PR(NOS/CO-OPS)\r'),(769,'sjom4',42.099,-86.494,'NDBC','MET','NWS Central Region','St. Joseph, MI(IOOS Partners)\r'),(770,'sjsn4',39.305,-75.375,'NDBC','MET','NOS','8537121 - Ship John Shoal, NJ(NOS/CO-OPS)\r'),(771,'skta2',59.45,-135.327,'NDBC','MET','NOS','9452400 - Skagway, AK(NOS/CO-OPS)\r'),(772,'slim2',38.317,-76.45,'NDBC','MET','NOS','8577330 - Solomons Island, MD(NOS/CO-OPS)\r'),(773,'sloo3',43.296,-124.311,'NDBC','MET','National Estuarine Research Reserve System','Elliot Creek - South Slough Reserve, OR(NERRS)\r'),(774,'slpl1',29.517,-91.55,'NDBC','MET','LSU CSI','Salt Point, LA  / CSI14(IOOS Partners)\r'),(775,'slvm5',47.269,-91.252,'NDBC','MET','NWS Central Region','Silver Bay, MN(IOOS Partners)\r'),(776,'smbs1',33.655,-78.918,'NDBC','MET','South Carolina Nearshore Monitoring System','Springmaid pier, SC(IOOS Partners)\r'),(777,'smkf1',24.628,-81.111,'NDBC','MET','NDBC','Sombrero Key, FL(NDBC Meteorological/Ocean)\r'),(778,'snda2',55.337,-160.502,'NDBC','MET','NOS','9459450 - Sand Point, AK(NOS/CO-OPS)\r'),(779,'sndp5',28.212,-177.36,'NDBC','MET','NOS','1619910 - Sand Island, Midway Islands(NOS/CO-OPS)\r'),(780,'soqo3',43.317,-124.322,'NDBC','MET','National Estuarine Research Reserve System','Valino Island, South Slough Reserve, OR(NERRS)\r'),(781,'spgf1',26.704,-78.994,'NDBC','MET','NDBC','Settlement Point, GBI(NDBC Meteorological/Ocean)\r'),(782,'spll1',28.867,-90.483,'NDBC','MET','LSU CSI','South Timbalier Block 52, LA / CSI06(IOOS Partners)\r'),(783,'sptm4',44.713,-83.273,'NDBC','MET','NWS Central Region','Sturgeon Point Light, MI(IOOS Partners)\r'),(784,'srbv3',17.784,-64.762,'NDBC','MET','Integrated Coral Observing Network (ICON)','Salt River Bay, St. Croix, U.S. Virgin Islands(IOOS Partners)\r'),(785,'srfw1',46.184,-123.188,'NDBC','MET','Center for Coastal Margin Observation and Prediction','SATURN River Station #05(IOOS Partners)\r'),(786,'srst2',29.683,-94.033,'NDBC','MET','NDBC','Sabine Pass, TX(NDBC Meteorological/Ocean)\r'),(787,'ssbn7',33.842,-78.476,'NDBC','MET','CORMP','Sunset Beach Nearshore Waves(IOOS Partners)\r'),(788,'stdm4',47.183,-87.225,'NDBC','MET','NDBC','Stannard Rock, MI(NDBC Meteorological/Ocean)\r'),(789,'svnm4',42.401,-86.289,'NDBC','MET','GLERL','South Haven, MI(IOOS Partners)\r'),(790,'swla2',60.12,-149.427,'NDBC','MET','NOS','9455090 - Seward, AK(NOS/CO-OPS)\r'),(791,'swpm4',46.502,-84.373,'NDBC','MET','NOS','9076070 - S.W. Pier, MI(NOS/CO-OPS)\r'),(792,'swpv2',36.947,-76.33,'NDBC','MET','NOS','8638610 - Sewells Point, VA(NOS/CO-OPS)\r'),(793,'sxhw3',46.563,-90.44,'NDBC','MET','NWS Central Region','Saxon Harbor, WI(IOOS Partners)\r'),(794,'syww3',45.202,-87.121,'NDBC','MET','NWS Central Region','Yacht Works Sister Bay WI(IOOS Partners)\r'),(795,'taml1',29.188,-90.665,'NDBC','MET','LUMCON','Tambour Bay, LA(IOOS Partners)\r'),(796,'tano3',46.189,-123.919,'NDBC','MET','Center for Coastal Margin Observation and Prediction','Tansy Point, OR(IOOS Partners)\r'),(797,'taqt2',27.812,-97.39,'NDBC','MET','TCOON','8775296 - Texas State Aquarium, TX(IOOS Partners)\r'),(798,'tarf1',28.156,-82.758,'NDBC','MET','COMPS (University of South Florida)','TAS - Tarpon Springs, FL(IOOS Partners)\r'),(799,'tawm4',44.256,-83.443,'NDBC','MET','NWS Central Region','Tawas City, MI(IOOS Partners)\r'),(800,'tbim4',45.035,-83.194,'NDBC','MET','GLERL','Thunder Bay Island, MI(IOOS Partners)\r'),(801,'tcbm2',39.213,-76.245,'NDBC','MET','NOS','8573364 - Tolchester Beach, MD(NOS/CO-OPS)\r'),(802,'tcmw1',47.276,-122.418,'NDBC','MET','NOS','9446482 - Tacoma Met, WA(NOS/CO-OPS)\r'),(803,'tcnw1',47.267,-122.413,'NDBC','MET','NOS','9446484 - Tacoma, WA(NOS/CO-OPS)\r'),(804,'tcvf1',25.209,-80.533,'NDBC','MET','Everglades National Park','Trout Cove, FL(IOOS Partners)\r'),(805,'tdpc1',41.055,-124.147,'NDBC','MET','Humboldt State University','Trinidad Pier Trinidad, CA(IOOS Partners)\r'),(806,'tesl1',29.667,-91.237,'NDBC','MET','NOS','8764044 - Tesoro Marine Terminal -  Berwick, LA(NOS/CO-OPS)\r'),(807,'tfblk',65.698,-24.778,'NDBC','MET','Icelandic Maritime Administration','10.0 nm WNW on Blakknes, Iceland(International Partners)\r'),(808,'thlo1',41.826,-83.194,'NDBC','MET','GLERL','Toledo Light No. 2 OH(IOOS Partners)\r'),(809,'thro1',41.693,-83.472,'NDBC','MET','NOS','9063085 - Toledo, OH(NOS/CO-OPS)\r'),(810,'tibc1',37.891,-122.447,'NDBC','MET','San Francisco State','Tiburon Pier, San Francisco Bay, CA(IOOS Partners)\r'),(811,'tiqc1',32.568,-117.131,'NDBC','MET','National Estuarine Research Reserve System','Oneonta Slough, Tijuana River Reserve, CA(NERRS)\r'),(812,'tixc1',32.574,-117.127,'NDBC','MET','National Estuarine Research Reserve System','Tijuana River Reserve, CA(NERRS)\r'),(813,'tkea2',57.779,-135.219,'NDBC','MET','Marine Exchange of Alaska','Tenakee Springs, AK(IOOS Partners)\r'),(814,'tlbo3',45.555,-123.912,'NDBC','MET','NOS','9437540 - Garibaldi, Tillamook Bay, OR(NOS/CO-OPS)\r'),(815,'tnso3',46.238,-123.468,'NDBC','MET','Center for Coastal Margin Observation and Prediction','Tenasillahe Island USFW Dock, OR(IOOS Partners)\r'),(816,'tokw1',46.708,-123.965,'NDBC','MET','NOS','9440910 - Toke Point, WA(NOS/CO-OPS)\r'),(817,'tpaf1',27.933,-82.433,'NDBC','MET','NOS','8726694 - TPA Cruise Terminal 2, Tampa, FL(NOS/CO-OPS)\r'),(818,'tpbn4',40.012,-75.042,'NDBC','MET','NOS','8538886 - Tacony-Palmyra Bridge, NJ(NOS/CO-OPS)\r'),(819,'tpef1',25.408,-80.964,'NDBC','MET','Everglades National Park','Tarpon Bay East, FL(IOOS Partners)\r'),(820,'tplm2',38.898,-76.437,'NDBC','MET','NDBC','Thomas Point, MD(NDBC Meteorological/Ocean)\r'),(821,'trbl1',29.167,-90.583,'NDBC','MET','LUMCON','Terrebonne Bay, LA(IOOS Partners)\r'),(822,'trdf1',28.415,-80.593,'NDBC','MET','NOS','8721604 - Trident Pier, FL(NOS/CO-OPS)\r'),(823,'trrf1',25.223,-80.653,'NDBC','MET','Everglades National Park','Taylor River, FL(IOOS Partners)\r'),(824,'tshf1',27.928,-82.425,'NDBC','MET','NOS','8726679  - East Bay Causeway, FL(NOS/CO-OPS)\r'),(825,'ttiw1',48.392,-124.735,'NDBC','MET','NDBC','Tatoosh Island, WA(NDBC Meteorological/Ocean)\r'),(826,'txpt2',29.689,-93.842,'NDBC','MET','NOS','8770822 - Texas Point, TX (NOS/CO-OPS)\r'),(827,'ulam6',30.348,-88.505,'NDBC','MET','NOS','8741041 - Dock E. Port of Pascagoula, MS(NOS/CO-OPS)\r'),(828,'unla2',53.879,-166.54,'NDBC','MET','NOS','9462620 - Unalaska, AK(NOS/CO-OPS)\r'),(829,'upbc1',38.038,-122.121,'NDBC','MET','NOS','9415118 - Union Pacific Rail Road Bridge, Martinez, CA(NOS/CO-OPS)\r'),(830,'vakf1',25.732,-80.162,'NDBC','MET','NOS','8723214 - Virginia Key, FL(NOS/CO-OPS)\r'),(831,'vcaf1',24.712,-81.105,'NDBC','MET','NOS','8723970 - Vaca Key, FL(NOS/CO-OPS)\r'),(832,'vcat2',28.64,-96.595,'NDBC','MET','TCOON','8773259 - Port Lavaca, TX (IOOS Partners)\r'),(833,'vcva2',57.125,-170.285,'NDBC','MET','NOS','9464212 - Village Cove, St Paul, AK(NOS/CO-OPS)\r'),(834,'vdza2',61.125,-146.362,'NDBC','MET','NOS','9454240 - Valdez, AK(NOS/CO-OPS)\r'),(835,'venf1',27.07,-82.45,'NDBC','MET','NDBC','Venice, FL(NDBC Meteorological/Ocean)\r'),(836,'verv4',19.202,-96.113,'NDBC','MET','EPA &amp; Mexican Government Cooperative Program','Veracruz Harbor, MX(NDBC Meteorological/Ocean)\r'),(837,'vqsp4',18.153,-65.444,'NDBC','MET','Puerto Rico Seismic Network','9752619 - Isabel Segunda, Vieques, PR(IOOS Partners)\r'),(838,'wahv2',37.607,-75.687,'NDBC','MET','NOS','8631044 - Wachapreague, VA(NOS/CO-OPS)\r'),(839,'wakp8',19.29,166.618,'NDBC','MET','NOS','1890000 - Wake Island(NOS/CO-OPS)\r'),(840,'waqm3',41.552,-70.549,'NDBC','MET','National Estuarine Research Reserve System','Menauhant, Waquoit Bay Reserve, MA(NERRS)\r'),(841,'wasd2',38.87,-77.02,'NDBC','MET','NOS','8594900 - Washington, DC(NOS/CO-OPS)\r'),(842,'wats1',34.335,-80.702,'NDBC','MET','NWS Eastern Region','Lake Wateree, SC(IOOS Partners)\r'),(843,'waxm3',41.582,-70.525,'NDBC','MET','National Estuarine Research Reserve System','Waquoit Bay Reserve, MA(NERRS)\r'),(844,'wbya1',30.417,-87.825,'NDBC','MET','NOS',' 8732828 - Weeks Bay, AL (NOS/CO-OPS)\r'),(845,'wdel1',28.662,-89.551,'NDBC','MET','Shell Oil','Shell West Delta 143(IOOS Partners)\r'),(846,'wdsv2',36.982,-76.322,'NDBC','MET','NOS','8638614 - Willoughby Deguassing Station, VA(NOS/CO-OPS)\r'),(847,'wdyo3',46.252,-123.534,'NDBC','MET','Center for Coastal Margin Observation and Prediction','Woody Island, OR(IOOS Partners)\r'),(848,'welm1',43.32,-70.563,'NDBC','MET','NOS','8419317 - Wells, ME(NOS/CO-OPS)\r'),(849,'weqm1',43.345,-70.549,'NDBC','MET','National Estuarine Research Reserve System','Skinner Mill, Wells Reserve, ME(NERRS)\r'),(850,'wexm1',43.338,-70.55,'NDBC','MET','National Estuarine Research Reserve System','Wells Reserve, ME(NERRS)\r'),(851,'wfpm4',46.762,-84.966,'NDBC','MET','NWS Central Region','Whitefish Point, MI(IOOS Partners)\r'),(852,'whri2',42.361,-87.813,'NDBC','MET','NWS Central Region','Waukegan Harbor, IL(IOOS Partners)\r'),(853,'wiwf1',25.619,-81.044,'NDBC','MET','Everglades National Park','Willy Willy, FL(IOOS Partners)\r'),(854,'wkqa1',30.416,-87.823,'NDBC','MET','National Estuarine Research Reserve System','Fish River, Weeks Bay Reserve, AL(NERRS)\r'),(855,'wkxa1',30.421,-87.829,'NDBC','MET','National Estuarine Research Reserve System','Weeks Bay Reserve, AL(NERRS)\r'),(856,'wlon7',34.227,-77.953,'NDBC','MET','NOS','8658120 - Wilmington, NC(NOS/CO-OPS)\r'),(857,'wnem4',46.283,-84.205,'NDBC','MET','NOS','9076027 - West Neebish, MI(NOS/CO-OPS)\r'),(858,'wplf1',25.708,-81.248,'NDBC','MET','Everglades National Park','Watson Place, FL(IOOS Partners)\r'),(859,'wpow1',47.662,-122.436,'NDBC','MET','NDBC','West Point, WA(NDBC Meteorological/Ocean)\r'),(860,'wptw1',46.904,-124.105,'NDBC','MET','NOS','9441102 - Westport, WA(NOS/CO-OPS)\r'),(861,'wrbf1',25.077,-80.728,'NDBC','MET','Everglades National Park','Whipray Basin, FL(IOOS Partners)\r'),(862,'wwef1',25.23,-80.939,'NDBC','MET','Everglades National Park','White Water -West, FL(IOOS Partners)\r'),(863,'wycm6',30.326,-89.326,'NDBC','MET','NOS','8747437 - Bay Waveland Yacht Club, MS(NOS/CO-OPS)\r'),(864,'yabp4',18.055,-65.833,'NDBC','MET','Puerto Rico Seismic Network','9754228 - Yabucoa Harbor, PR(IOOS Partners)\r'),(865,'yata2',59.548,-139.733,'NDBC','MET','NOS','9453220 - Yakutat, AK(NOS/CO-OPS)\r'),(866,'ygnn6',43.261,-79.064,'NDBC','MET','NWS Eastern Region','Niagara Coast Guard Station, NY(IOOS Partners)\r'),(867,'ykrv2',37.25,-76.333,'NDBC','MET','NOS','8637611 - York River East Rear Range Light, VA(NOS/CO-OPS)\r'),(868,'yktv2',37.227,-76.478,'NDBC','MET','NOS','8637689 - Yorktown, VA(NOS/CO-OPS)\r'),(869,'yrsv2',37.414,-76.713,'NDBC','MET','National Estuarine Research Reserve System','Chesapeake Bay,VA(NERRS)\r'),(870,'zbqn7',33.955,-77.935,'NDBC','MET','National Estuarine Research Reserve System','Zeke\'s Basin, North Carolina(NERRS)\r'),(871,'cb0102',36.95922,-76.01302,'CO-OPS','CURRENT',' Cape Henry LB 2CH',' Chesapeake Bay South PORTS\r'),(872,'cb0201',37.13983,-76.1435,'CO-OPS','CURRENT',' York Spit LBB 22',' Chesapeake Bay South PORTS\r'),(873,'cb0301',37.0111,-76.24948,'CO-OPS','CURRENT',' Thimble Shoal LB 18',' Chesapeake Bay South PORTS\r'),(874,'cb0402',36.96238,-76.33387,'CO-OPS','CURRENT',' Naval Station Norfolk LB 7',' Chesapeake Bay South PORTS\r'),(875,'cb0601',36.95602,-76.41448,'CO-OPS','CURRENT',' Newport News Channel LB 14',' Chesapeake Bay South PORTS\r'),(876,'cb0701',36.96233,-76.42417,'CO-OPS','CURRENT',' Dominion Terminal',' Chesapeake Bay South PORTS\r'),(877,'cb0801',36.67442,-76.15462,'CO-OPS','CURRENT',' Rappahannock Shoal Channel LBB 60',' Chesapeake Bay North PORTS\r'),(878,'cb0901',38.1149,-76.53068,'CO-OPS','CURRENT',' Potomac River MidChannel LWB B',' Chesapeake Bay North PORTS\r'),(879,'cb1001',38.40283,-76.38417,'CO-OPS','CURRENT',' Cove Point LNG Pier',' Chesapeake Bay North PORTS\r'),(880,'cb1101',38.98215,-76.38467,'CO-OPS','CURRENT',' Chesapeake Channel LBB 92',' Chesapeake Bay North PORTS\r'),(881,'cb1201',39.13987,-76.33035,'CO-OPS','CURRENT',' Tolchester Front Range',' Chesapeake Bay North PORTS\r'),(882,'cb1301',39.53053,-75.82762,'CO-OPS','CURRENT',' Chesapeake City',' Chesapeake Bay North PORTS\r'),(883,'cp0101',48.8628,-122.761,'CO-OPS','CURRENT',' Cherry Point',' Cherry Point PORTS\r'),(884,'db0301',39.94623,-75.1396,'CO-OPS','CURRENT',' Philadelphia',' Delaware Bay PORTS\r'),(885,'db0501',38.92185,-75.09998,'CO-OPS','CURRENT',' Brown Shoal Light',' Delaware Bay PORTS\r'),(886,'g06010',29.34222,-94.74083,'CO-OPS','CURRENT',' Galveston Bay Entr Channel LB 11',' Houston/Galveston PORTS\r'),(887,'gl0101',41.49448,-81.70292,'CO-OPS','CURRENT',' Cuyahoga River',' Great Lakes Real-Time Currents Monitoring\r'),(888,'gl0201',41.62913,-83.53022,'CO-OPS','CURRENT',' Maumee River',' Great Lakes Real-Time Currents Monitoring\r'),(889,'gl0301',42.99873,-82.42527,'CO-OPS','CURRENT',' St Clair River',' Great Lakes Real-Time Currents Monitoring\r'),(890,'hb0101',40.76678,-124.24981,'CO-OPS','CURRENT',' Humboldt Bay Bar Channel LBB #2',' Humboldt Bay PORTS\r'),(891,'hb0201',40.75697,-124.22367,'CO-OPS','CURRENT',' Humboldt Bay Entrance Channel LB 9',' Humboldt Bay PORTS\r'),(892,'hb0301',40.74233,-124.22506,'CO-OPS','CURRENT',' Hookton Channel Day Marker 5',' Humboldt Bay PORTS\r'),(893,'hb0401',40.7775,-124.19661,'CO-OPS','CURRENT',' Chevron Pier',' Humboldt Bay PORTS\r'),(894,'lc0101',29.69347,-93.33118,'CO-OPS','CURRENT',' Calcasieu Channel LB 36',' Lake Charles PORTS\r'),(895,'lc0201',29.76414,-93.34292,'CO-OPS','CURRENT',' Cameron Fishing Pier',' Lake Charles PORTS\r'),(896,'lc0301',30.21783,-93.24944,'CO-OPS','CURRENT',' Lake Charles City Docks',' Lake Charles PORTS\r'),(897,'lm0101',29.92244,-90.07114,'CO-OPS','CURRENT',' First Street Wharf',' Lower Mississippi River PORTS\r'),(898,'mb0101',30.1253,-88.0687,'CO-OPS','CURRENT',' Mobile Bay Buoy M',' Mobile Bay PORTS\r'),(899,'mb0301',30.72111,-88.04278,'CO-OPS','CURRENT',' Mobile State Dock Pier E',' Mobile Bay PORTS\r'),(900,'mb0401',30.66444,-88.03222,'CO-OPS','CURRENT',' Mobile Container Terminal',' Mobile Bay PORTS\r'),(901,'n05010',40.67207,-74.03993,'CO-OPS','CURRENT',' Gowanus Flats LBB 32',' New York/New Jersey PORTS\r'),(902,'nb0201',41.699,-71.17842,'CO-OPS','CURRENT',' Fall River',' Narragansett Bay PORTS\r'),(903,'nb0301',41.58367,-71.397,'CO-OPS','CURRENT',' Quonset Point',' Narragansett Bay PORTS\r'),(904,'nl0101',41.39172,-72.09236,'CO-OPS','CURRENT',' Groton  Thames River  Pier 6',' New London PORTS\r'),(905,'ps0201',30.21525,-88.99411,'CO-OPS','CURRENT',' Pascagoula Harbor LB 17',' Pascagoula PORTS\r'),(906,'ps0301',30.35978,-88.56406,'CO-OPS','CURRENT',' Northrop Grumman Pier',' Pascagoula PORTS\r'),(907,'ps0401',30.19576,-88.52237,'CO-OPS','CURRENT',' Pascagoula Harbor LB 10',' Pascagoula PORTS\r'),(908,'s06010',38.03463,-122.12525,'CO-OPS','CURRENT',' Martinez-AMORCO Pier',' San Francisco Bay PORTS\r'),(909,'s08010',37.91625,-122.42233,'CO-OPS','CURRENT',' Southampton Shoal Channel LB 6',' San Francisco Bay PORTS\r'),(910,'s09010',37.8082,-122.34434,'CO-OPS','CURRENT',' Oakland Outer Harbor LB3',' San Francisco Bay PORTS\r'),(911,'sn0101',29.62892,-93.81615,'CO-OPS','CURRENT',' Sabine Bank Channel LBB 34',' Sabine Neches PORTS\r'),(912,'sn0201',29.72861,-93.87001,'CO-OPS','CURRENT',' USCG Sabine',' Sabine Neches PORTS\r'),(913,'sn0301',29.75086,-93.89012,'CO-OPS','CURRENT',' Sabine Front Range',' Sabine Neches PORTS\r'),(914,'sn0401',29.82389,-93.96417,'CO-OPS','CURRENT',' West Port Arthur Bridge',' Sabine Neches PORTS\r'),(915,'sn0501',29.97948,-93.87058,'CO-OPS','CURRENT',' Rainbow Bridge',' Sabine Neches PORTS\r'),(916,'sn0601',30.0797,-94.08625,'CO-OPS','CURRENT',' Port of Beaumont',' Sabine Neches PORTS\r'),(917,'sn0701',29.86708,-93.93111,'CO-OPS','CURRENT',' Port Arthur',' Sabine Neches PORTS\r'),(918,'t01010',27.625,-82.655,'CO-OPS','CURRENT',' Sunshine Skyway Bridge',' Tampa Bay PORTS\r'),(919,'t02010',27.86287,-82.55373,'CO-OPS','CURRENT',' Old Port Tampa',' Tampa Bay PORTS\r'),(920,'1611347',21.9033,-159.592,'CO-OPS','TIDE','PORT ALLEN, HANAPEPE BAY','PORT ALLEN, HANAPEPE BAY\r'),(921,'1611400',21.9544444444444,-159.356111111111,'CO-OPS','TIDE','NAWILIWILI','NAWILIWILI\r'),(922,'1612340',21.3067,-157.867,'CO-OPS','TIDE','HONOLULU','HONOLULU\r'),(923,'1612480',21.4330555555556,-157.79,'CO-OPS','TIDE','MOKUOLOE','MOKUOLOE\r'),(924,'1615680',20.895,-156.476666666667,'CO-OPS','TIDE','KAHULUI','KAHULUI\r'),(925,'1617433',20.0365833332804,-155.829361111323,'CO-OPS','TIDE','KAWAIHAE','KAWAIHAE\r'),(926,'1617760',19.7302777777778,-155.055833333333,'CO-OPS','TIDE','HILO','HILO\r'),(927,'1619000',16.7383,-169.53,'CO-OPS','TIDE','JOHNSTON ATOLL','JOHNSTON ATOLL\r'),(928,'1619910',28.2117,-177.36,'CO-OPS','TIDE','SAND ISLAND, MIDWAY ISLANDS','SAND ISLAND, MIDWAY ISLANDS\r'),(929,'1630000',13.43872,144.653944444391,'CO-OPS','TIDE','APRA HARBOR, GUAM','APRA HARBOR, GUAM\r'),(930,'1631428',13.4283,144.797,'CO-OPS','TIDE','PAGO BAY, GUAM','PAGO BAY, GUAM\r'),(931,'1633227',15.2267,145.737,'CO-OPS','TIDE','SAIPAN','SAIPAN\r'),(932,'1732417',-17.535,-149.572,'CO-OPS','TIDE','FARE UTE POINT','FARE UTE POINT\r'),(933,'1770000',-14.28,-170.69,'CO-OPS','TIDE','PAGO PAGO','PAGO PAGO\r'),(934,'1820000',8.73161,167.736222222116,'CO-OPS','TIDE','KWAJALEIN, MARSHALL ISLANDS','KWAJALEIN, MARSHALL ISLANDS\r'),(935,'1840000',7.44667,151.847,'CO-OPS','TIDE','CHUUK, MOEN ISLAND','CHUUK, MOEN ISLAND\r'),(936,'1890000',19.29,166.618,'CO-OPS','TIDE','WAKE ISLAND','WAKE ISLAND\r'),(937,'2695540',32.3733888888889,-64.7033055555556,'CO-OPS','TIDE','BERMUDA ESSO PIER','BERMUDA ESSO PIER\r'),(938,'8410140',44.9046,-66.9829,'CO-OPS','TIDE','EASTPORT','EASTPORT\r'),(939,'8411250',44.6417,-67.2967,'CO-OPS','TIDE','CUTLER NAVAL BASE','CUTLER NAVAL BASE\r'),(940,'8413320',44.3917,-68.205,'CO-OPS','TIDE','BAR HARBOR','BAR HARBOR\r'),(941,'8414612',44.785,-68.7667,'CO-OPS','TIDE','BANGOR','BANGOR\r'),(942,'8415490',44.105,-69.1017,'CO-OPS','TIDE','ROCKLAND','ROCKLAND\r'),(943,'8417134',44.2333,-69.7667,'CO-OPS','TIDE','GARDINER','GARDINER\r'),(944,'8417177',43.755,-69.785,'CO-OPS','TIDE','HUNNIWELL POINT','HUNNIWELL POINT\r'),(945,'8417208',44.0883,-69.7983,'CO-OPS','TIDE','RICHMOND','RICHMOND\r'),(946,'8418150',43.6567,-70.2467,'CO-OPS','TIDE','PORTLAND','PORTLAND\r'),(947,'8419317',43.32,-70.5633055555556,'CO-OPS','TIDE','WELLS','WELLS\r'),(948,'8419870',43.08,-70.7417,'CO-OPS','TIDE','SEAVEY ISLAND','SEAVEY ISLAND\r'),(949,'8423898',43.0717,-70.7117,'CO-OPS','TIDE','FORT POINT','FORT POINT\r'),(950,'8443970',42.3548,-71.0534,'CO-OPS','TIDE','BOSTON','BOSTON\r'),(951,'8447270',41.7417,-70.6167,'CO-OPS','TIDE','BUZZARDS BAY','BUZZARDS BAY\r'),(952,'8447368',41.7117,-70.715,'CO-OPS','TIDE','GREAT HILL','GREAT HILL\r'),(953,'8447386',41.7043,-71.1641,'CO-OPS','TIDE','FALL RIVER','FALL RIVER\r'),(954,'8447435',41.6884722222222,-69.9510833333333,'CO-OPS','TIDE','CHATHAM','CHATHAM\r'),(955,'8447930',41.5233,-70.6717,'CO-OPS','TIDE','WOODS HOLE','WOODS HOLE\r'),(956,'8448558',41.3883,-70.5117,'CO-OPS','TIDE','EDGARTOWN','EDGARTOWN\r'),(957,'8448725',41.3544444444444,-70.7678333333333,'CO-OPS','TIDE','MENEMSHA HARBOR, MA','MENEMSHA HARBOR, MA\r'),(958,'8449130',41.285,-70.0967,'CO-OPS','TIDE','NANTUCKET ISLAND','NANTUCKET ISLAND\r'),(959,'8452660',41.505,-71.3267,'CO-OPS','TIDE','NEWPORT','NEWPORT\r'),(960,'8452944',41.7167,-71.3433,'CO-OPS','TIDE','CONIMICUT LIGHT','CONIMICUT LIGHT\r'),(961,'8454000',41.8071,-71.4012,'CO-OPS','TIDE','PROVIDENCE','PROVIDENCE\r'),(962,'8454049',41.5868,-71.411,'CO-OPS','TIDE','QUONSET POINT','QUONSET POINT\r'),(963,'8459681',41.1633,-71.61,'CO-OPS','TIDE','BLOCK ISLAND','BLOCK ISLAND\r'),(964,'8461490',41.3613888888889,-72.0899722222222,'CO-OPS','TIDE','NEW LONDON','NEW LONDON\r'),(965,'8465705',41.2833,-72.9083,'CO-OPS','TIDE','NEW HAVEN','NEW HAVEN\r'),(966,'8467150',41.1733,-73.1817,'CO-OPS','TIDE','BRIDGEPORT','BRIDGEPORT\r'),(967,'8510560',41.0483,-71.96,'CO-OPS','TIDE','MONTAUK','MONTAUK\r'),(968,'8510719',41.2567,-72.03,'CO-OPS','TIDE','SILVER EEL POND','SILVER EEL POND\r'),(969,'8512668',41.015,-72.5617,'CO-OPS','TIDE','MATTITUCK INLET','MATTITUCK INLET\r'),(970,'8512735',40.935,-72.5817,'CO-OPS','TIDE','SOUTH JAMESPORT','SOUTH JAMESPORT\r'),(971,'8515786',40.9533,-73.4,'CO-OPS','TIDE','EATONS NECK','EATONS NECK\r'),(972,'8516945',40.8103,-73.7649,'CO-OPS','TIDE','KINGS POINT','KINGS POINT\r'),(973,'8516990',40.7933,-73.7817,'CO-OPS','TIDE','WILLETS POINT','WILLETS POINT\r'),(974,'8518668',40.7767,-73.9417,'CO-OPS','TIDE','HORNS HOOK','HORNS HOOK\r'),(975,'8518750',40.7006,-74.0142,'CO-OPS','TIDE','THE BATTERY','THE BATTERY\r'),(976,'8518995',42.65,-73.7467,'CO-OPS','TIDE','ALBANY','ALBANY\r'),(977,'8519483',40.6367,-74.1417,'CO-OPS','TIDE','BERGEN POINT WEST REACH','BERGEN POINT WEST REACH\r'),(978,'8530882',40.6733,-74.14,'CO-OPS','TIDE','PORT ELIZABETH','PORT ELIZABETH\r'),(979,'8531680',40.4669,-74.0094,'CO-OPS','TIDE','SANDY HOOK','SANDY HOOK\r'),(980,'8534720',39.355,-74.4183,'CO-OPS','TIDE','ATLANTIC CITY','ATLANTIC CITY\r'),(981,'8536110',38.9683333333333,-74.96,'CO-OPS','TIDE','CAPE MAY','CAPE MAY\r'),(982,'8537121',39.305,-75.375,'CO-OPS','TIDE','SHIP JOHN SHOAL','SHIP JOHN SHOAL\r'),(983,'8538886',40.01194,-75.0429999997881,'CO-OPS','TIDE','TACONY-PALMYRA BRIDGE','TACONY-PALMYRA BRIDGE\r'),(984,'8539094',40.0817,-74.8697,'CO-OPS','TIDE','BURLINGTON, DELAWARE RIVER','BURLINGTON, DELAWARE RIVER\r'),(985,'8540433',39.8117,-75.41,'CO-OPS','TIDE','MARCUS HOOK','MARCUS HOOK\r'),(986,'8545240',39.9333333333333,-75.1416666666667,'CO-OPS','TIDE','PHILADELPHIA','PHILADELPHIA\r'),(987,'8545530',39.9533,-75.1383,'CO-OPS','TIDE','PHILADELPHIA, MUNICIPAL PIER 11, PA.','PHILADELPHIA, MUNICIPAL PIER 11, PA.\r'),(988,'8548989',40.1367,-74.7517,'CO-OPS','TIDE','NEWBOLD','NEWBOLD\r'),(989,'8551762',39.5817,-75.5883,'CO-OPS','TIDE','DELAWARE CITY','DELAWARE CITY\r'),(990,'8551910',39.5583055555556,-75.5733055555555,'CO-OPS','TIDE','REEDY POINT','REEDY POINT\r'),(991,'8555889',38.98667,-75.1133333333333,'CO-OPS','TIDE','BRANDYWINE SHOAL LIGHT','BRANDYWINE SHOAL LIGHT\r'),(992,'8557380',38.7816944444444,-75.12,'CO-OPS','TIDE','LEWES','LEWES\r'),(993,'8558690',38.61,-75.07,'CO-OPS','TIDE','INDIAN RIVER INLET (COAST GUARD STATION)','INDIAN RIVER INLET (COAST GUARD STATION)\r'),(994,'8570280',38.3267,-75.0833,'CO-OPS','TIDE','OCEAN CITY (FISHING PIER)','OCEAN CITY (FISHING PIER)\r'),(995,'8570283',38.32833,-75.0916666666667,'CO-OPS','TIDE','OCEAN CITY INLET','OCEAN CITY INLET\r'),(996,'8571359',38.17833,-75.3966666666667,'CO-OPS','TIDE','SNOW HILL','SNOW HILL\r'),(997,'8571421',38.22,-76.0383,'CO-OPS','TIDE','BISHOPS HEAD','BISHOPS HEAD\r'),(998,'8571559',38.3,-76.005,'CO-OPS','TIDE','MC CREADYS CREEK','MC CREADYS CREEK\r'),(999,'8571702',38.42833,-76.2366666666667,'CO-OPS','TIDE','BEAVERDAM CREEK','BEAVERDAM CREEK\r'),(1000,'8571773',38.48333,-75.8183333333333,'CO-OPS','TIDE','VIENNA','VIENNA\r'),(1001,'8571892',38.5733,-76.0683,'CO-OPS','TIDE','CAMBRIDGE','CAMBRIDGE\r'),(1002,'8572669',38.9167,-75.945,'CO-OPS','TIDE','HILLSBORO','HILLSBORO\r'),(1003,'8573349',39.245,-75.925,'CO-OPS','TIDE','CRUMPTON','CRUMPTON\r'),(1004,'8573364',39.21333,-76.245,'CO-OPS','TIDE','TOLCHESTER BEACH','TOLCHESTER BEACH\r'),(1005,'8573927',39.5267,-75.81,'CO-OPS','TIDE','CHESAPEAKE CITY','CHESAPEAKE CITY\r'),(1006,'8574070',39.5367,-76.09,'CO-OPS','TIDE','HAVRE DE GRACE','HAVRE DE GRACE\r'),(1007,'8574680',39.26667,-76.5783333333333,'CO-OPS','TIDE','BALTIMORE','BALTIMORE\r'),(1008,'8575512',38.98328,-76.4815555551317,'CO-OPS','TIDE','ANNAPOLIS','ANNAPOLIS\r'),(1009,'8577330',38.31667,-76.4516666666667,'CO-OPS','TIDE','SOLOMONS ISLAND','SOLOMONS ISLAND\r'),(1010,'8579542',38.655,-76.6833333333333,'CO-OPS','TIDE','LOWER MARLBORO','LOWER MARLBORO\r'),(1011,'8594900',38.87333,-77.0216666666667,'CO-OPS','TIDE','WASHINGTON','WASHINGTON\r'),(1012,'8630308',37.9067,-75.405,'CO-OPS','TIDE','CHINCOTEAGUE CHANNEL (SOUTH END)','CHINCOTEAGUE CHANNEL (SOUTH END)\r'),(1013,'8631044',37.60667,-75.6866666666667,'CO-OPS','TIDE','WACHAPREAGUE','WACHAPREAGUE\r'),(1014,'8632200',37.16519,-75.9884444443385,'CO-OPS','TIDE','KIPTOPEKE','KIPTOPEKE\r'),(1015,'8632837',37.5383,-76.015,'CO-OPS','TIDE','RAPPAHANNOCK LIGHT','RAPPAHANNOCK LIGHT\r'),(1016,'8632869',37.5567,-75.9167,'CO-OPS','TIDE','GASKINS POINT, OCCOHANNOCK CREEK','GASKINS POINT, OCCOHANNOCK CREEK\r'),(1017,'8633532',37.8283,-75.9933,'CO-OPS','TIDE','TANGIER ISLAND','TANGIER ISLAND\r'),(1018,'8635257',38.2133,-77.2433,'CO-OPS','TIDE','RAPPAHANNOCK BEND','RAPPAHANNOCK BEND\r'),(1019,'8635750',37.9961111111111,-76.4644444444444,'CO-OPS','TIDE','LEWISETTA','LEWISETTA\r'),(1020,'8635985',37.8733,-76.7833,'CO-OPS','TIDE','WARES WHARF','WARES WHARF\r'),(1021,'8636580',37.6162,-76.29,'CO-OPS','TIDE','WINDMILL POINT','WINDMILL POINT\r'),(1022,'8636653',37.5833,-76.99,'CO-OPS','TIDE','LESTER MANOR','LESTER MANOR\r'),(1023,'8637624',37.2467,-76.5,'CO-OPS','TIDE','GLOUCESTER POINT','GLOUCESTER POINT\r'),(1024,'8637689',37.2266666666667,-76.4783333333333,'CO-OPS','TIDE','YORKTOWN USCG TRAINING CENTER','YORKTOWN USCG TRAINING CENTER\r'),(1025,'8638424',37.22,-76.6633,'CO-OPS','TIDE','KINGSMILL','KINGSMILL\r'),(1026,'8638433',37.185,-76.7833,'CO-OPS','TIDE','SCOTLAND','SCOTLAND\r'),(1027,'8638445',37.4033,-76.9117,'CO-OPS','TIDE','LANEXA, CHICAHOMNY RIVER','LANEXA, CHICAHOMNY RIVER\r'),(1028,'8638450',37.24,-76.9433,'CO-OPS','TIDE','TETTINGTON, JAMES RIVER','TETTINGTON, JAMES RIVER\r'),(1029,'8638489',37.2667,-77.3717,'CO-OPS','TIDE','PUDDLEDOCK','PUDDLEDOCK\r'),(1030,'8638495',37.525,-77.42,'CO-OPS','TIDE','RICHMOND RIVER LOCKS, JAMES RIVER','RICHMOND RIVER LOCKS, JAMES RIVER\r'),(1031,'8638610',36.9466666666667,-76.33,'CO-OPS','TIDE','SEWELLS POINT','SEWELLS POINT\r'),(1032,'8638660',36.8217,-76.2933,'CO-OPS','TIDE','PORTSMOUTH, NAVAL SHIPYARD','PORTSMOUTH, NAVAL SHIPYARD\r'),(1033,'8638863',36.9666666666667,-76.1133333333333,'CO-OPS','TIDE','CHESAPEAKE BAY BRIDGE TUNNEL','CHESAPEAKE BAY BRIDGE TUNNEL\r'),(1034,'8639207',36.8317,-75.9733,'CO-OPS','TIDE','RUDEE INLET','RUDEE INLET\r'),(1035,'8639348',36.7783,-76.3017,'CO-OPS','TIDE','MONEY POINT','MONEY POINT\r'),(1036,'8651370',36.1833333333333,-75.7466666666667,'CO-OPS','TIDE','DUCK','DUCK\r'),(1037,'8652587',35.795,-75.5483,'CO-OPS','TIDE','OREGON INLET MARINA','OREGON INLET MARINA\r'),(1038,'8654400',35.2233,-75.635,'CO-OPS','TIDE','CAPE HATTERAS FISHING PIER','CAPE HATTERAS FISHING PIER\r'),(1039,'8654792',35.115,-75.9883,'CO-OPS','TIDE','OCRACOKE, OCRACOKE ISLAND','OCRACOKE, OCRACOKE ISLAND\r'),(1040,'8655875',34.875,-76.3433,'CO-OPS','TIDE','SEA LEVEL','SEA LEVEL\r'),(1041,'8656483',34.72,-76.67,'CO-OPS','TIDE','BEAUFORT','BEAUFORT\r'),(1042,'8658120',34.2267,-77.9533,'CO-OPS','TIDE','WILMINGTON','WILMINGTON\r'),(1043,'8658163',34.2133,-77.7867,'CO-OPS','TIDE','WRIGHTSVILLE BEACH','WRIGHTSVILLE BEACH\r'),(1044,'8659084',33.915,-78.0183,'CO-OPS','TIDE','SOUTHPORT','SOUTHPORT\r'),(1045,'8659897',33.865,-78.5067,'CO-OPS','TIDE','SUNSET BEACH','SUNSET BEACH\r'),(1046,'8661070',33.655,-78.9183,'CO-OPS','TIDE','SPRINGMAID PIER','SPRINGMAID PIER\r'),(1047,'8662245',33.3517,-79.1867,'CO-OPS','TIDE','OYSTER LANDING (N. INLET ESTUARY)','OYSTER LANDING (N. INLET ESTUARY)\r'),(1048,'8664022',33.0083,-79.9233,'CO-OPS','TIDE','GENERAL DYNAMICS PIER','GENERAL DYNAMICS PIER\r'),(1049,'8664941',32.8567,-79.7067,'CO-OPS','TIDE','SOUTH CAPERS ISLAND','SOUTH CAPERS ISLAND\r'),(1050,'8665530',32.7817,-79.925,'CO-OPS','TIDE','CHARLESTON','CHARLESTON\r'),(1051,'8667633',32.3357,-80.7841,'CO-OPS','TIDE','CLARENDON PLANTATION','CLARENDON PLANTATION\r'),(1052,'8668498',32.34,-80.465,'CO-OPS','TIDE','FRIPPS INLET','FRIPPS INLET\r'),(1053,'8670870',32.0333,-80.9017,'CO-OPS','TIDE','FORT PULASKI','FORT PULASKI\r'),(1054,'8677344',31.1317,-81.3967,'CO-OPS','TIDE','ST.SIMONS ISLAND','ST.SIMONS ISLAND\r'),(1055,'8679511',30.7967,-81.515,'CO-OPS','TIDE','KINGS BAY, NAVY BASE','KINGS BAY, NAVY BASE\r'),(1056,'8720011',30.7083,-81.465,'CO-OPS','TIDE','CUT 1N FRONT RANGE, ST MARYS RIVER ENTR','CUT 1N FRONT RANGE, ST MARYS RIVER ENTR\r'),(1057,'8720030',30.6717,-81.465,'CO-OPS','TIDE','FERNANDINA BEACH','FERNANDINA BEACH\r'),(1058,'8720059',30.63,-81.5767,'CO-OPS','TIDE','VAUGHNS LANDING','VAUGHNS LANDING\r'),(1059,'8720098',30.5683,-81.515,'CO-OPS','TIDE','NASSAUVILLE','NASSAUVILLE\r'),(1060,'8720145',30.5017,-81.5417,'CO-OPS','TIDE','EDWARDS CREEK','EDWARDS CREEK\r'),(1061,'8720211',30.4,-81.4133,'CO-OPS','TIDE','MAYPORT NAVAL STA., ST JOHNS RIVER','MAYPORT NAVAL STA., ST JOHNS RIVER\r'),(1062,'8720218',30.3967,-81.43,'CO-OPS','TIDE','MAYPORT (BAR PILOTS DOCK)','MAYPORT (BAR PILOTS DOCK)\r'),(1063,'8720219',30.3867,-81.5583,'CO-OPS','TIDE','DAME POINT','DAME POINT\r'),(1064,'8720220',30.3933,-81.4317,'CO-OPS','TIDE','MAYPORT (FERRY DEPOT)','MAYPORT (FERRY DEPOT)\r'),(1065,'8720226',30.32,-81.6583,'CO-OPS','TIDE','MAIN STREET BRIDGE, ST JOHNS RIVER','MAIN STREET BRIDGE, ST JOHNS RIVER\r'),(1066,'8720242',30.36,-81.62,'CO-OPS','TIDE','LONGBRANCH','LONGBRANCH\r'),(1067,'8720357',30.1917,-81.6917,'CO-OPS','TIDE','I-295 BRIDGE, ST JOHNS RIVER','I-295 BRIDGE, ST JOHNS RIVER\r'),(1068,'8720503',29.9783,-81.6283,'CO-OPS','TIDE','RED BAY POINT, ST JOHNS RIVER','RED BAY POINT, ST JOHNS RIVER\r'),(1069,'8720554',29.9167,-81.3,'CO-OPS','TIDE','VILANO BEACH ICWW','VILANO BEACH ICWW\r'),(1070,'8720582',29.8667,-81.3067,'CO-OPS','TIDE','STATE ROAD 312, MATANZAS RIVER','STATE ROAD 312, MATANZAS RIVER\r'),(1071,'8720587',29.8567,-81.2633,'CO-OPS','TIDE','ST. AUGUSTINE BEACH','ST. AUGUSTINE BEACH\r'),(1072,'8720625',29.8017,-81.5483,'CO-OPS','TIDE','RACY POINT, ST JOHNS RIVER','RACY POINT, ST JOHNS RIVER\r'),(1073,'8720651',29.7683,-81.2583,'CO-OPS','TIDE','CRESCENT BEACH, MATANZAS RIVER','CRESCENT BEACH, MATANZAS RIVER\r'),(1074,'8720757',29.615,-81.205,'CO-OPS','TIDE','BINGS LANDING, MATANZAS RIVER','BINGS LANDING, MATANZAS RIVER\r'),(1075,'8720767',29.595,-81.6817,'CO-OPS','TIDE','BUFFALO BLUFF, ST JOHNS RIVER','BUFFALO BLUFF, ST JOHNS RIVER\r'),(1076,'8720774',29.6433,-81.6317,'CO-OPS','TIDE','PALATKA, ST JOHNS RIVER','PALATKA, ST JOHNS RIVER\r'),(1077,'8720832',29.4767,-81.675,'CO-OPS','TIDE','WELAKA','WELAKA\r'),(1078,'8721147',29.0633,-80.915,'CO-OPS','TIDE','PONCE DE LEON INLET SOUTH','PONCE DE LEON INLET SOUTH\r'),(1079,'8721604',28.4158,-80.5931,'CO-OPS','TIDE','TRIDENT PIER','TRIDENT PIER\r'),(1080,'8722548',26.8433,-80.0667,'CO-OPS','TIDE','PGA BOULEVARD BRIDGE, PALM BEACH','PGA BOULEVARD BRIDGE, PALM BEACH\r'),(1081,'8722588',26.77,-80.0517,'CO-OPS','TIDE','PORT OF WEST PALM BEACH','PORT OF WEST PALM BEACH\r'),(1082,'8722669',26.6133,-80.0467,'CO-OPS','TIDE','LAKE WORTH ICW','LAKE WORTH ICW\r'),(1083,'8723080',25.9033,-80.12,'CO-OPS','TIDE','HAULOVER PIER, N. MIAMI BEACH','HAULOVER PIER, N. MIAMI BEACH\r'),(1084,'8723170',25.7683,-80.1317,'CO-OPS','TIDE','MIAMI BEACH','MIAMI BEACH\r'),(1085,'8723178',25.7633,-80.13,'CO-OPS','TIDE','GOVERNMENT CUT, MIAMI HARBOR ENTRANCE','GOVERNMENT CUT, MIAMI HARBOR ENTRANCE\r'),(1086,'8723214',25.7314,-80.1618,'CO-OPS','TIDE','VIRGINIA KEY','VIRGINIA KEY\r'),(1087,'8723962',24.7183,-81.0167,'CO-OPS','TIDE','KEY COLONY BEACH','KEY COLONY BEACH\r'),(1088,'8723970',24.7117,-81.105,'CO-OPS','TIDE','VACA KEY','VACA KEY\r'),(1089,'8724580',24.5557,-81.8079,'CO-OPS','TIDE','KEY WEST','KEY WEST\r'),(1090,'8724698',24.6317,-82.92,'CO-OPS','TIDE','LOGGERHEAD KEY','LOGGERHEAD KEY\r'),(1091,'8725110',26.1317,-81.8075,'CO-OPS','TIDE','NAPLES','NAPLES\r'),(1092,'8725520',26.6477,-81.8712,'CO-OPS','TIDE','FORT MYERS','FORT MYERS\r'),(1093,'8726384',27.6387,-82.5621,'CO-OPS','TIDE','PORT MANATEE','PORT MANATEE\r'),(1094,'8726520',27.7606,-82.6269,'CO-OPS','TIDE','ST. PETERSBURG','ST. PETERSBURG\r'),(1095,'8726607',27.8577777777778,-82.5526944444444,'CO-OPS','TIDE','OLD PORT TAMPA','OLD PORT TAMPA\r'),(1096,'8726667',27.9133333333333,-82.425,'CO-OPS','TIDE','MCKAY BAY ENTRANCE','MCKAY BAY ENTRANCE\r'),(1097,'8726724',27.9783,-82.8317,'CO-OPS','TIDE','CLEARWATER BEACH','CLEARWATER BEACH\r'),(1098,'8727235',28.6917,-82.6383,'CO-OPS','TIDE','JOHNS ISLAND, CHASSAHOWITZKA BAY','JOHNS ISLAND, CHASSAHOWITZKA BAY\r'),(1099,'8727246',28.715,-82.5767,'CO-OPS','TIDE','CHASSAHOWITZKA, CHASSAHOWITZKA RIVER','CHASSAHOWITZKA, CHASSAHOWITZKA RIVER\r'),(1100,'8727274',28.7617,-82.6383,'CO-OPS','TIDE','MASON CREEK, HOMOSASSA BAY','MASON CREEK, HOMOSASSA BAY\r'),(1101,'8727277',28.7717,-82.695,'CO-OPS','TIDE','TUCKERS ISLAND, HOMOSASSA RIVER','TUCKERS ISLAND, HOMOSASSA RIVER\r'),(1102,'8727293',28.8,-82.6033,'CO-OPS','TIDE','HALLS RIVER BRIDGE, HOMOSASSA RIVER','HALLS RIVER BRIDGE, HOMOSASSA RIVER\r'),(1103,'8727306',28.825,-82.6583,'CO-OPS','TIDE','OZELLO, ST. MARTINS RIVER','OZELLO, ST. MARTINS RIVER\r'),(1104,'8727328',28.8633,-82.6667,'CO-OPS','TIDE','OZELLO NORTH, CRYSTAL BAY','OZELLO NORTH, CRYSTAL BAY\r'),(1105,'8727333',28.87,-82.7233,'CO-OPS','TIDE','MANGROVE POINT','MANGROVE POINT\r'),(1106,'8727336',28.8817,-82.635,'CO-OPS','TIDE','DIXIE BAY, SALT RIVER, CRYSTAL BAY','DIXIE BAY, SALT RIVER, CRYSTAL BAY\r'),(1107,'8727343',28.8983,-82.5983,'CO-OPS','TIDE','KINGS BAY','KINGS BAY\r'),(1108,'8727348',28.905,-82.6383,'CO-OPS','TIDE','TWIN RIVERS MARINA','TWIN RIVERS MARINA\r'),(1109,'8727359',28.9233,-82.6917,'CO-OPS','TIDE','SHELL ISLAND, NORTH END','SHELL ISLAND, NORTH END\r'),(1110,'8727520',29.135,-83.0317,'CO-OPS','TIDE','CEDAR KEY','CEDAR KEY\r'),(1111,'8728130',30.0783,-84.1783,'CO-OPS','TIDE','ST. MARKS RIVER ENTRANCE','ST. MARKS RIVER ENTRANCE\r'),(1112,'8728229',30.06,-84.29,'CO-OPS','TIDE','SHELL POINT, WALKER CREEK','SHELL POINT, WALKER CREEK\r'),(1113,'8728360',29.915,-84.5117,'CO-OPS','TIDE','TURKEY POINT, ST. JAMES ISLAND','TURKEY POINT, ST. JAMES ISLAND\r'),(1114,'8728690',29.7267,-84.9817,'CO-OPS','TIDE','APALACHICOLA','APALACHICOLA\r'),(1115,'8728853',29.8806944444444,-85.2214444444444,'CO-OPS','TIDE','WHITE CITY, ICWW','WHITE CITY, ICWW\r'),(1116,'8729108',30.1522777777778,-85.6669444444444,'CO-OPS','TIDE','PANAMA CITY','PANAMA CITY\r'),(1117,'8729210',30.2133,-85.8783,'CO-OPS','TIDE','PANAMA CITY BEACH','PANAMA CITY BEACH\r'),(1118,'8729501',30.5033,-86.4933,'CO-OPS','TIDE','VALPARAISO','VALPARAISO\r'),(1119,'8729678',30.3767,-86.865,'CO-OPS','TIDE','NAVARRE BEACH','NAVARRE BEACH\r'),(1120,'8729840',30.4044,-87.2112,'CO-OPS','TIDE','PENSACOLA','PENSACOLA\r'),(1121,'8729905',30.4183,-87.3567,'CO-OPS','TIDE','MILLVIEW, PERDIDO BAY','MILLVIEW, PERDIDO BAY\r'),(1122,'8729941',30.3869444444444,-87.4288055555556,'CO-OPS','TIDE','BLUE ANGELS PARK','BLUE ANGELS PARK\r'),(1123,'8730667',30.2786111111111,-87.555,'CO-OPS','TIDE','ALABAMA POINT','ALABAMA POINT\r'),(1124,'8731439',30.2798888888889,-87.6842777777778,'CO-OPS','TIDE','GULF SHORES, ICWW','GULF SHORES, ICWW\r'),(1125,'8732828',30.4167,-87.825,'CO-OPS','TIDE','WEEKS BAY','WEEKS BAY\r'),(1126,'8735180',30.25,-88.075,'CO-OPS','TIDE','DAUPHIN ISLAND','DAUPHIN ISLAND\r'),(1127,'8735181',30.25,-88.075,'CO-OPS','TIDE','DAUPHIN ISLAND HYDRO','DAUPHIN ISLAND HYDRO\r'),(1128,'8736897',30.6483,-88.0583,'CO-OPS','TIDE','COAST GUARD SECTOR MOBILE','COAST GUARD SECTOR MOBILE\r'),(1129,'8737048',30.7083,-88.0433,'CO-OPS','TIDE','MOBILE STATE DOCKS','MOBILE STATE DOCKS\r'),(1130,'8737373',30.9783,-87.8733,'CO-OPS','TIDE','LOWER BRYANT LANDING','LOWER BRYANT LANDING\r'),(1131,'8741041',30.3477,-88.5054,'CO-OPS','TIDE','DOCK E, PORT OF PASCAGOULA','DOCK E, PORT OF PASCAGOULA\r'),(1132,'8741196',30.34,-88.5333,'CO-OPS','TIDE','PASCAGOULA POINT','PASCAGOULA POINT\r'),(1133,'8741533',30.3679,-88.563,'CO-OPS','TIDE','PASCAGOULA NOAA LAB','PASCAGOULA NOAA LAB\r'),(1134,'8742221',30.2383,-88.6667,'CO-OPS','TIDE','HORN ISLAND','HORN ISLAND\r'),(1135,'8743281',30.3917,-88.7983,'CO-OPS','TIDE','OCEAN SPRINGS','OCEAN SPRINGS\r'),(1136,'8744117',30.4117,-88.9033,'CO-OPS','TIDE','BILOXI','BILOXI\r'),(1137,'8745557',30.36,-89.0817,'CO-OPS','TIDE','GULFPORT HARBOR','GULFPORT HARBOR\r'),(1138,'8747437',30.3263888888889,-89.3257777777778,'CO-OPS','TIDE','BAY WAVELAND YACHT CLUB','BAY WAVELAND YACHT CLUB\r'),(1139,'8747766',30.2817,-89.3667,'CO-OPS','TIDE','WAVELAND','WAVELAND\r'),(1140,'8760417',29.20075,-89.0444666666667,'CO-OPS','TIDE','DEVON ENERGY FACILITY','DEVON ENERGY FACILITY\r'),(1141,'8760551',28.99,-89.14,'CO-OPS','TIDE','SOUTH PASS','SOUTH PASS\r'),(1142,'8760889',29.3865555555556,-89.3801388888889,'CO-OPS','TIDE','OLGA COMPRESSOR STATION, GRAND BAY','OLGA COMPRESSOR STATION, GRAND BAY\r'),(1143,'8760922',28.9322,-89.4075,'CO-OPS','TIDE','PILOTS STATION EAST, SW PASS','PILOTS STATION EAST, SW PASS\r'),(1144,'8760943',28.925,-89.4183,'CO-OPS','TIDE','SW PASS','SW PASS\r'),(1145,'8761305',29.8681111111111,-89.67325,'CO-OPS','TIDE','SHELL BEACH','SHELL BEACH\r'),(1146,'8761529',29.945,-89.835,'CO-OPS','TIDE','MARTELLO CASTLE, LAKE BORGNE','MARTELLO CASTLE, LAKE BORGNE\r'),(1147,'8761724',29.2633333333333,-89.9566666666667,'CO-OPS','TIDE','GRAND ISLE','GRAND ISLE\r'),(1148,'8761819',29.4017,-90.0383,'CO-OPS','TIDE','TEXACO DOCK, HACKBERRY BAY','TEXACO DOCK, HACKBERRY BAY\r'),(1149,'8761927',30.0271666666667,-90.1134166666667,'CO-OPS','TIDE','NEW CANAL STATION','NEW CANAL STATION\r'),(1150,'8762075',29.11425,-90.19925,'CO-OPS','TIDE','PORT FOURCHON','PORT FOURCHON\r'),(1151,'8762372',30.0503333333333,-90.368,'CO-OPS','TIDE','EAST BANK 1, NORCO, B. LABRANCHE','EAST BANK 1, NORCO, B. LABRANCHE\r'),(1152,'8762482',29.7885555555556,-90.4201944444444,'CO-OPS','TIDE','WEST BANK 1, BAYOU GAUCHE','WEST BANK 1, BAYOU GAUCHE\r'),(1153,'8764025',29.7433,-91.23,'CO-OPS','TIDE','STOUTS PASS AT SIX MILE LAKE','STOUTS PASS AT SIX MILE LAKE\r'),(1154,'8764044',29.6675,-91.2376111111111,'CO-OPS','TIDE','TESORO MARINE TERMINAL','TESORO MARINE TERMINAL\r'),(1155,'8764227',29.4495833333333,-91.3381111111111,'CO-OPS','TIDE','LAWMA, AMERADA PASS','LAWMA, AMERADA PASS\r'),(1156,'8765251',29.7133611111111,-91.88,'CO-OPS','TIDE','CYPREMORT POINT','CYPREMORT POINT\r'),(1157,'8766072',29.555,-92.305,'CO-OPS','TIDE','FRESHWATER CANAL LOCKS','FRESHWATER CANAL LOCKS\r'),(1158,'8767816',30.2236388888889,-93.2216666666667,'CO-OPS','TIDE','LAKE CHARLES','LAKE CHARLES\r'),(1159,'8767961',30.1903055555556,-93.3006944444444,'CO-OPS','TIDE','BULK TERMINAL','BULK TERMINAL\r'),(1160,'8768094',29.7681666666667,-93.3428888888889,'CO-OPS','TIDE','CALCASIEU PASS','CALCASIEU PASS\r'),(1161,'8770475',29.8667,-93.93,'CO-OPS','TIDE','PORT ARTHUR','PORT ARTHUR\r'),(1162,'8770520',29.98,-93.8817,'CO-OPS','TIDE','RAINBOW BRIDGE','RAINBOW BRIDGE\r'),(1163,'8770539',29.7667,-93.895,'CO-OPS','TIDE','MESQUITE POINT','MESQUITE POINT\r'),(1164,'8770559',29.7133,-94.69,'CO-OPS','TIDE','ROUND POINT','ROUND POINT\r'),(1165,'8770570',29.7284,-93.8701,'CO-OPS','TIDE','SABINE PASS NORTH','SABINE PASS NORTH\r'),(1166,'8770613',29.6817,-94.985,'CO-OPS','TIDE','MORGANS POINT','MORGANS POINT\r'),(1167,'8770733',29.765,-95.0783,'CO-OPS','TIDE','LYNCHBURG LANDING','LYNCHBURG LANDING\r'),(1168,'8770743',29.7567,-95.09,'CO-OPS','TIDE','BATTLESHIP TEXAS STATE PARK','BATTLESHIP TEXAS STATE PARK\r'),(1169,'8770777',29.7262777777778,-95.2658055555556,'CO-OPS','TIDE','MANCHESTER','MANCHESTER\r'),(1170,'8770933',29.5633,-95.0667,'CO-OPS','TIDE','CLEAR LAKE','CLEAR LAKE\r'),(1171,'8770971',29.515,-94.5133,'CO-OPS','TIDE','ROLLOVER PASS','ROLLOVER PASS\r'),(1172,'8771013',29.48,-94.9183,'CO-OPS','TIDE','EAGLE POINT','EAGLE POINT\r'),(1173,'8771328',29.365,-94.78,'CO-OPS','TIDE','PORT BOLIVAR','PORT BOLIVAR\r'),(1174,'8771341',29.3583,-94.725,'CO-OPS','TIDE','GALVESTON BAY ENTRANCE, NORTH JETTY','GALVESTON BAY ENTRANCE, NORTH JETTY\r'),(1175,'8771450',29.31,-94.7933,'CO-OPS','TIDE','GALVESTON PIER 21','GALVESTON PIER 21\r'),(1176,'8771510',29.2853,-94.7894,'CO-OPS','TIDE','GALVESTON PLEASURE PIER','GALVESTON PLEASURE PIER\r'),(1177,'8772440',28.9483,-95.3083,'CO-OPS','TIDE','FREEPORT','FREEPORT\r'),(1178,'8772447',28.9433055555556,-95.3025,'CO-OPS','TIDE','USCG FREEPORT','USCG FREEPORT\r'),(1179,'8773037',28.4083,-96.7117,'CO-OPS','TIDE','SEADRIFT','SEADRIFT\r'),(1180,'8773259',28.64,-96.595,'CO-OPS','TIDE','PORT LAVACA','PORT LAVACA\r'),(1181,'8773701',28.4517,-96.3883,'CO-OPS','TIDE','PORT O\'CONNOR','PORT O\'CONNOR\r'),(1182,'8774513',28.1183,-97.0217,'CO-OPS','TIDE','COPANO BAY','COPANO BAY\r'),(1183,'8774770',28.0217,-97.0467,'CO-OPS','TIDE','ROCKPORT','ROCKPORT\r'),(1184,'8775188',27.8583,-97.475,'CO-OPS','TIDE','WHITE POINT','WHITE POINT\r'),(1185,'8775237',27.8383,-97.0733,'CO-OPS','TIDE','PORT ARANSAS','PORT ARANSAS\r'),(1186,'8775270',27.8267,-97.05,'CO-OPS','TIDE','PORT ARANSAS (H. CALDWELL PIER)','PORT ARANSAS (H. CALDWELL PIER)\r'),(1187,'8775283',27.8217,-97.2033,'CO-OPS','TIDE','PORT INGLESIDE, CORPUS CHRISTI BAY','PORT INGLESIDE, CORPUS CHRISTI BAY\r'),(1188,'8775296',27.8117,-97.39,'CO-OPS','TIDE','TEXAS STATE AQUARIUM','TEXAS STATE AQUARIUM\r'),(1189,'8775421',27.705,-97.28,'CO-OPS','TIDE','NAVAL AIR STATION','NAVAL AIR STATION\r'),(1190,'8775792',27.6333,-97.2367,'CO-OPS','TIDE','PACKERY CHANNEL','PACKERY CHANNEL\r'),(1191,'8775870',27.58,-97.2167,'CO-OPS','TIDE','CORPUS CHRISTI','CORPUS CHRISTI\r'),(1192,'8779748',26.0767,-97.1767,'CO-OPS','TIDE','SOUTH PADRE ISLAND C.G STATION','SOUTH PADRE ISLAND C.G STATION\r'),(1193,'8779750',26.0683,-97.1567,'CO-OPS','TIDE','PADRE ISLAND (SOUTH END)','PADRE ISLAND (SOUTH END)\r'),(1194,'8779770',26.06,-97.215,'CO-OPS','TIDE','PORT ISABEL','PORT ISABEL\r'),(1195,'9410170',32.71419,-117.173583333227,'CO-OPS','TIDE','SAN DIEGO','SAN DIEGO\r'),(1196,'9410230',32.8667,-117.258,'CO-OPS','TIDE','LA JOLLA','LA JOLLA\r'),(1197,'9410580',33.6033,-117.883,'CO-OPS','TIDE','NEWPORT BAY ENTRANCE, CORONA DEL MAR','NEWPORT BAY ENTRANCE, CORONA DEL MAR\r'),(1198,'9410660',33.72,-118.272,'CO-OPS','TIDE','LOS ANGELES','LOS ANGELES\r'),(1199,'9410680',33.7517,-118.227,'CO-OPS','TIDE','LONG BEACH, TERMINAL ISLAND','LONG BEACH, TERMINAL ISLAND\r'),(1200,'9410840',34.0083,-118.5,'CO-OPS','TIDE','SANTA MONICA','SANTA MONICA\r'),(1201,'9411340',34.4083,-119.685,'CO-OPS','TIDE','SANTA BARBARA','SANTA BARBARA\r'),(1202,'9411406',34.4683,-120.673,'CO-OPS','TIDE','OIL PLATFORM HARVEST','OIL PLATFORM HARVEST\r'),(1203,'9412110',35.1767,-120.76,'CO-OPS','TIDE','PORT SAN LUIS','PORT SAN LUIS\r'),(1204,'9413450',36.605,-121.888,'CO-OPS','TIDE','MONTEREY','MONTEREY\r'),(1205,'9413663',36.85667,-121.755,'CO-OPS','TIDE','ELKHORN SLOUGH RAILROAD BRIDGE','ELKHORN SLOUGH RAILROAD BRIDGE\r'),(1206,'9414290',37.8066944444445,-122.465,'CO-OPS','TIDE','SAN FRANCISCO','SAN FRANCISCO\r'),(1207,'9414317',37.79,-122.387,'CO-OPS','TIDE','RINCON POINT, PIER 22 1/2','RINCON POINT, PIER 22 1/2\r'),(1208,'9414358',37.73,-122.357,'CO-OPS','TIDE','HUNTERS POINT','HUNTERS POINT\r'),(1209,'9414458',37.58,-122.253,'CO-OPS','TIDE','SAN MATEO BRIDGE','SAN MATEO BRIDGE\r'),(1210,'9414509',37.5067,-122.115,'CO-OPS','TIDE','DUMBARTON BRIDGE','DUMBARTON BRIDGE\r'),(1211,'9414523',37.5067,-122.21,'CO-OPS','TIDE','REDWOOD CITY','REDWOOD CITY\r'),(1212,'9414575',37.465,-122.023,'CO-OPS','TIDE','COYOTE CREEK','COYOTE CREEK\r'),(1213,'9414688',37.695,-122.192,'CO-OPS','TIDE','SAN LEANDRO MARINA','SAN LEANDRO MARINA\r'),(1214,'9414750',37.7716666666667,-122.298333333333,'CO-OPS','TIDE','ALAMEDA','ALAMEDA\r'),(1215,'9414811',38.1833,-121.923,'CO-OPS','TIDE','BRADMOOR ISLAND','BRADMOOR ISLAND\r'),(1216,'9414863',37.9283,-122.4,'CO-OPS','TIDE','RICHMOND','RICHMOND\r'),(1217,'9414958',37.9079555555556,-122.678544444444,'CO-OPS','TIDE','BOLINAS, BOLINAS LAGOON','BOLINAS, BOLINAS LAGOON\r'),(1218,'9415020',37.9961,-122.9767,'CO-OPS','TIDE','POINT REYES','POINT REYES\r'),(1219,'9415144',38.056,-122.0395,'CO-OPS','TIDE','PORT CHICAGO','PORT CHICAGO\r'),(1220,'9415218',38.07,-122.25,'CO-OPS','TIDE','MARE ISLAND','MARE ISLAND\r'),(1221,'9416841',38.9133,-123.708,'CO-OPS','TIDE','ARENA COVE','ARENA COVE\r'),(1222,'9418767',40.7667,-124.217,'CO-OPS','TIDE','NORTH SPIT','NORTH SPIT\r'),(1223,'9419750',41.745,-124.183,'CO-OPS','TIDE','CRESCENT CITY','CRESCENT CITY\r'),(1224,'9432780',43.345,-124.322,'CO-OPS','TIDE','CHARLESTON','CHARLESTON\r'),(1225,'9435380',44.625,-124.043,'CO-OPS','TIDE','SOUTH BEACH','SOUTH BEACH\r'),(1226,'9435827',44.81,-124.058,'CO-OPS','TIDE','DEPOE BAY','DEPOE BAY\r'),(1227,'9437540',45.55453,-123.918944444391,'CO-OPS','TIDE','GARIBALDI','GARIBALDI\r'),(1228,'9439040',46.20731,-123.768305555582,'CO-OPS','TIDE','ASTORIA','ASTORIA\r'),(1229,'9439099',46.16,-123.405,'CO-OPS','TIDE','WAUNA','WAUNA\r'),(1230,'9439189',45.6967,-122.868,'CO-OPS','TIDE','ROCKY POINT','ROCKY POINT\r'),(1231,'9439201',45.865,-122.797,'CO-OPS','TIDE','SAINT HELENS','SAINT HELENS\r'),(1232,'9439221',45.51,-122.673,'CO-OPS','TIDE','PORTLAND MORRISON STREET BRIDGE','PORTLAND MORRISON STREET BRIDGE\r'),(1233,'9440083',45.6317,-122.697,'CO-OPS','TIDE','VANCOUVER','VANCOUVER\r'),(1234,'9440422',46.1061111111111,-122.954166666667,'CO-OPS','TIDE','LONGVIEW','LONGVIEW\r'),(1235,'9440569',46.2667,-123.452,'CO-OPS','TIDE','SKAMOKAWA','SKAMOKAWA\r'),(1236,'9440875',46.6633,-123.798,'CO-OPS','TIDE','SOUTH BEND, WILLAPA RIVER','SOUTH BEND, WILLAPA RIVER\r'),(1237,'9440910',46.70747,-123.96691666666,'CO-OPS','TIDE','TOKE POINT','TOKE POINT\r'),(1238,'9441102',46.90431,-124.105083333121,'CO-OPS','TIDE','WESTPORT','WESTPORT\r'),(1239,'9441187',46.9683,-123.853,'CO-OPS','TIDE','ABERDEEN','ABERDEEN\r'),(1240,'9442396',47.9133,-124.637,'CO-OPS','TIDE','LA PUSH','LA PUSH\r'),(1241,'9443090',48.36667,-124.611666666667,'CO-OPS','TIDE','NEAH BAY','NEAH BAY\r'),(1242,'9444090',48.125,-123.44,'CO-OPS','TIDE','PORT ANGELES','PORT ANGELES\r'),(1243,'9444900',48.1117,-122.758,'CO-OPS','TIDE','PORT TOWNSEND','PORT TOWNSEND\r'),(1244,'9445133',47.7483,-122.727,'CO-OPS','TIDE','BANGOR','BANGOR\r'),(1245,'9446484',47.26667,-122.413333333333,'CO-OPS','TIDE','TACOMA','TACOMA\r'),(1246,'9447130',47.6026388888889,-122.339305555556,'CO-OPS','TIDE','SEATTLE, PUGET SOUND, WA','SEATTLE, PUGET SOUND, WA\r'),(1247,'9449424',48.8633,-122.758,'CO-OPS','TIDE','CHERRY POINT','CHERRY POINT\r'),(1248,'9449880',48.5466666666667,-123.01,'CO-OPS','TIDE','FRIDAY HARBOR','FRIDAY HARBOR\r'),(1249,'9450460',55.33183,-131.626194444233,'CO-OPS','TIDE','KETCHIKAN','KETCHIKAN\r'),(1250,'9450463',55.3516666666667,-132.938055555556,'CO-OPS','TIDE','TROCADERO BAY','TROCADERO BAY\r'),(1251,'9450551',55.4883,-133.142,'CO-OPS','TIDE','CRAIG','CRAIG\r'),(1252,'9450623',55.6,-132.95,'CO-OPS','TIDE','BIG SALT LAKE','BIG SALT LAKE\r'),(1253,'9450753',55.7882833333333,-132.190883333333,'CO-OPS','TIDE','MAGNETIC POINT, UNION BAY, EARNEST SOUND','MAGNETIC POINT, UNION BAY, EARNEST SOUND\r'),(1254,'9450970',56.1183,-132.078,'CO-OPS','TIDE','THOMS POINT','THOMS POINT\r'),(1255,'9451054',56.2467,-134.647,'CO-OPS','TIDE','PORT ALEXANDER','PORT ALEXANDER\r'),(1256,'9451247',56.535,-133.767,'CO-OPS','TIDE','MONTE CARLO ISLAND','MONTE CARLO ISLAND\r'),(1257,'9451349',56.6824222222222,-133.736908333333,'CO-OPS','TIDE','THE SUMMIT','THE SUMMIT\r'),(1258,'9451434',56.8,-132.98,'CO-OPS','TIDE','TURN POINT','TURN POINT\r'),(1259,'9451438',56.8117,-133.787,'CO-OPS','TIDE','ENTRANCE ISLAND','ENTRANCE ISLAND\r'),(1260,'9451600',57.0517,-135.342,'CO-OPS','TIDE','SITKA','SITKA\r'),(1261,'9451625',57.0883333333333,-134.825,'CO-OPS','TIDE','BARANOF,  WARM SPRING BAY','BARANOF,  WARM SPRING BAY\r'),(1262,'9451953',57.5333,-134.417,'CO-OPS','TIDE','TARGET ISLAND, MITCHELL BAY','TARGET ISLAND, MITCHELL BAY\r'),(1263,'9452210',58.2983,-134.412,'CO-OPS','TIDE','JUNEAU','JUNEAU\r'),(1264,'9452328',57.9667,-134.935,'CO-OPS','TIDE','FALSE BAY, CHATHAM STRAIT','FALSE BAY, CHATHAM STRAIT\r'),(1265,'9452400',59.45,-135.327,'CO-OPS','TIDE','SKAGWAY','SKAGWAY\r'),(1266,'9452634',58.19472,-136.346944444444,'CO-OPS','TIDE','ELFIN COVE','ELFIN COVE\r'),(1267,'9453220',59.5485,-139.7334,'CO-OPS','TIDE','YAKUTAT','YAKUTAT\r'),(1268,'9454050',60.5583,-145.753,'CO-OPS','TIDE','CORDOVA','CORDOVA\r'),(1269,'9454240',61.125,-146.362,'CO-OPS','TIDE','VALDEZ','VALDEZ\r'),(1270,'9454562',59.875,-147.403,'CO-OPS','TIDE','WOODED ISLAND','WOODED ISLAND\r'),(1271,'9454949',60.7783,-148.665,'CO-OPS','TIDE','WHITTIER','WHITTIER\r'),(1272,'9455090',60.12,-149.426666666667,'CO-OPS','TIDE','SEWARD','SEWARD\r'),(1273,'9455500',59.4405277777778,-151.719944444445,'CO-OPS','TIDE','SELDOVIA','SELDOVIA\r'),(1274,'9455760',60.6833,-151.398,'CO-OPS','TIDE','NIKISKI','NIKISKI\r'),(1275,'9455920',61.2383055555556,-149.89,'CO-OPS','TIDE','ANCHORAGE','ANCHORAGE\r'),(1276,'9457292',57.7317,-152.512,'CO-OPS','TIDE','KODIAK ISLAND','KODIAK ISLAND\r'),(1277,'9457804',56.8983,-154.247,'CO-OPS','TIDE','ALITAK','ALITAK\r'),(1278,'9458293',55.8083,-155.74,'CO-OPS','TIDE','CHIRIKOF ISLAND','CHIRIKOF ISLAND\r'),(1279,'9459016',55.89,-158.82,'CO-OPS','TIDE','MITROFANIA ISLAND','MITROFANIA ISLAND\r'),(1280,'9459450',55.3317,-160.5043,'CO-OPS','TIDE','SAND POINT','SAND POINT\r'),(1281,'9459758',55.1217,-161.792,'CO-OPS','TIDE','DOLGOI HARBOR, DOLGOI ISLAND','DOLGOI HARBOR, DOLGOI ISLAND\r'),(1282,'9459881',55.0617,-162.327,'CO-OPS','TIDE','KING COVE','KING COVE\r'),(1283,'9461380',51.8633,-176.632,'CO-OPS','TIDE','ADAK ISLAND','ADAK ISLAND\r'),(1284,'9461710',52.2317,-174.173,'CO-OPS','TIDE','ATKA','ATKA\r'),(1285,'9462450',52.94061,-168.871305555767,'CO-OPS','TIDE','NIKOLSKI','NIKOLSKI\r'),(1286,'9462620',53.88,-166.537,'CO-OPS','TIDE','UNALASKA','UNALASKA\r'),(1287,'9462645',53.8289166666667,-166.21625,'CO-OPS','TIDE','BIORKA VILLAGE, BIVERLY INLET','BIORKA VILLAGE, BIVERLY INLET\r'),(1288,'9462694',54.1332777777778,-165.777305555556,'CO-OPS','TIDE','AKUTAN, ALASKA','AKUTAN, ALASKA\r'),(1289,'9462787',54.6,-164.928,'CO-OPS','TIDE','CAPE SARICHEF, UNIMAK ISLAND','CAPE SARICHEF, UNIMAK ISLAND\r'),(1290,'9463502',55.99,-160.562,'CO-OPS','TIDE','PORT MOLLER','PORT MOLLER\r'),(1291,'9464212',57.1253055555556,-170.285166666667,'CO-OPS','TIDE','VILLAGE COVE, ST. PAUL ISLAND','VILLAGE COVE, ST. PAUL ISLAND\r'),(1292,'9465374',59.04,-158.447,'CO-OPS','TIDE','SNAG POINT, DILLINGHAM','SNAG POINT, DILLINGHAM\r'),(1293,'9468756',64.5,-165.43,'CO-OPS','TIDE','NOME, NORTON SOUND','NOME, NORTON SOUND\r'),(1294,'9469338',65.39,-167.145,'CO-OPS','TIDE','LOST RIVER, SEWARD PENINSULA','LOST RIVER, SEWARD PENINSULA\r'),(1295,'9469439',65.5583,-167.975,'CO-OPS','TIDE','TIN CITY, BERING SEA','TIN CITY, BERING SEA\r'),(1296,'9469854',66.2633,-166.02,'CO-OPS','TIDE','SHISHMAREF INLET 2','SHISHMAREF INLET 2\r'),(1297,'9490424',66.9017,-162.582,'CO-OPS','TIDE','KOTZEBUE','KOTZEBUE\r'),(1298,'9491094',67.5767,-164.065,'CO-OPS','TIDE','RED DOG DOCK','RED DOG DOCK\r'),(1299,'9491253',67.7267,-164.592,'CO-OPS','TIDE','KIVALINA','KIVALINA\r'),(1300,'9497645',70.4,-148.527,'CO-OPS','TIDE','PRUDHOE BAY','PRUDHOE BAY\r'),(1301,'9499176',70.1285555555556,-143.611027777778,'CO-OPS','TIDE','BARTER ISLAND','BARTER ISLAND\r'),(1302,'9500966',22.2617,-97.795,'CO-OPS','TIDE','MADERO, TAMPICO HARBOR, MEXICO','MADERO, TAMPICO HARBOR, MEXICO\r'),(1303,'9710441',26.71,-78.9967,'CO-OPS','TIDE','SETTLEMENT POINT','SETTLEMENT POINT\r'),(1304,'9751364',17.75,-64.705,'CO-OPS','TIDE','CHRISTIANSTED HARBOR, ST CROIX','CHRISTIANSTED HARBOR, ST CROIX\r'),(1305,'9751381',18.318249999947,-64.7242222224342,'CO-OPS','TIDE','LAMESHUR BAY, ST. JOHN','LAMESHUR BAY, ST. JOHN\r'),(1306,'9751401',17.68447,-64.7540277777778,'CO-OPS','TIDE','LIME TREE BAY','LIME TREE BAY\r'),(1307,'9751639',18.3358333333333,-64.92,'CO-OPS','TIDE','CHARLOTTE AMALIE','CHARLOTTE AMALIE\r'),(1308,'9752235',18.30086,-65.3024722221163,'CO-OPS','TIDE','CULEBRA','CULEBRA\r'),(1309,'9752695',18.09386,-65.4713611110052,'CO-OPS','TIDE','ESPERANZA, VIEQUES ISLAND','ESPERANZA, VIEQUES ISLAND\r'),(1310,'9754228',18.0550833333333,-65.833,'CO-OPS','TIDE','YABUCOA HARBOR','YABUCOA HARBOR\r'),(1311,'9755371',18.45894,-66.1164166662428,'CO-OPS','TIDE','SAN JUAN','SAN JUAN\r'),(1312,'9757809',18.4805277777778,-66.7023611111111,'CO-OPS','TIDE','ARECIBO','ARECIBO\r'),(1313,'9758053',17.9725277777778,-66.7617777777778,'CO-OPS','TIDE','PENUELAS (PUNTA GUAYANILLA)','PENUELAS (PUNTA GUAYANILLA)\r'),(1314,'9759110',17.97008,-67.0464166662428,'CO-OPS','TIDE','MAGUEYES ISLAND','MAGUEYES ISLAND\r'),(1315,'9759394',18.22,-67.16,'CO-OPS','TIDE','MAYAGUEZ','MAYAGUEZ\r'),(1316,'9759412',18.45664,-67.1645833333333,'CO-OPS','TIDE','AGUADILLA','AGUADILLA\r'),(1317,'9759938',18.0899166668786,-67.938500000106,'CO-OPS','TIDE','MONA ISLAND','MONA ISLAND\r');
/*!40000 ALTER TABLE `datafactory_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datafactory_tidedata`
--

DROP TABLE IF EXISTS `datafactory_tidedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datafactory_tidedata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(16) NOT NULL,
  `time` datetime NOT NULL,
  `pred` double NOT NULL,
  `type` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_tidedata`
--

LOCK TABLES `datafactory_tidedata` WRITE;
/*!40000 ALTER TABLE `datafactory_tidedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `datafactory_tidedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-10-09 16:33:59',1,17,'4','SuperMike-II',2,'Changed account, workingdirectory, accountingid and rsynctostorage.'),(2,'2014-10-09 16:36:35',1,17,'1','Queen Bee',3,''),(3,'2014-10-09 16:36:53',1,17,'3','localhost',3,''),(4,'2014-10-09 16:37:28',1,17,'4','SuperMike-II',2,'No fields changed.'),(5,'2014-10-09 16:47:03',1,18,'10','SWAN_SuperMike-II_Scripts',1,''),(6,'2014-10-09 19:15:23',1,47,'1','rguo',2,'Changed theme.'),(7,'2014-10-09 19:21:31',1,47,'1','rguo',2,'Changed theme.'),(8,'2014-10-10 02:11:25',1,3,'3','alex',1,''),(9,'2014-10-10 02:11:53',1,3,'3','alex',2,'Changed password, first_name, last_name and email.'),(10,'2014-10-10 02:24:22',1,47,'1','rguo',2,'Changed theme.'),(11,'2014-10-10 02:25:16',1,47,'1','rguo',2,'Changed theme.'),(12,'2014-10-10 02:27:54',1,47,'1','rguo',2,'Changed theme.'),(13,'2014-10-10 02:28:10',1,47,'1','rguo',2,'Changed theme.'),(14,'2014-10-10 02:28:36',1,47,'1','rguo',2,'Changed theme.'),(15,'2014-10-10 02:28:52',1,47,'1','rguo',2,'Changed theme.'),(16,'2014-10-10 06:40:44',1,6,'1','localhost:8090',3,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'registration profile','registration','registrationprofile'),(9,'task state','djcelery','taskmeta'),(10,'saved group result','djcelery','tasksetmeta'),(11,'interval','djcelery','intervalschedule'),(12,'crontab','djcelery','crontabschedule'),(13,'periodic tasks','djcelery','periodictasks'),(14,'periodic task','djcelery','periodictask'),(15,'worker','djcelery','workerstate'),(16,'task','djcelery','taskstate'),(17,'machine','simfactory','machine'),(18,'script template','simfactory','scripttemplate'),(19,'job','simfactory','job'),(20,'comparison','simlab','comparison'),(21,'coastal model','coastalmodels','coastalmodel'),(22,'model input','coastalmodels','modelinput'),(23,'swan parameters','coastalmodels','swanparameters'),(24,'swan config','coastalmodels','swanconfig'),(25,'delft3d parameters','coastalmodels','delft3dparameters'),(26,'delft3d config','coastalmodels','delft3dconfig'),(27,'fvcom config','coastalmodels','fvcomconfig'),(28,'adcirc parameters','coastalmodels','adcircparameters'),(29,'adcirccera','coastalmodels','adcirccera'),(30,'adcirc config','coastalmodels','adcircconfig'),(31,'ca funwave parameters','coastalmodels','cafunwaveparameters'),(32,'ca funwave config','coastalmodels','cafunwaveconfig'),(33,'efdc parameters','coastalmodels','efdcparameters'),(34,'efdc config','coastalmodels','efdcconfig'),(35,'station','datafactory','station'),(36,'data request','datafactory','datarequest'),(37,'buoy data','datafactory','buoydata'),(38,'tide data','datafactory','tidedata'),(39,'current data','datafactory','currentdata'),(40,'report','simreport','report'),(41,'domain','simesh','domain'),(42,'plot obs','simviz','plotobs'),(43,'sim ts data','simviz','simtsdata'),(44,'plot sim','simviz','plotsim'),(45,'model input data','fileupload','modelinputdata'),(46,'project','workflow','project'),(47,'user profile','accounts','userprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('a95a1325f9a3eb6bc77a0167fad6e9d9','YzIyNjY1ZjkwZjk0ZDI3NjgxNmQ3OGQ1MjI2MzM3NmJkZWU1ODI5NzqAAn1xAVUKdGVzdGNvb2tp\nZVUGd29ya2VkcQJzLg==\n','2014-10-24 17:35:49');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (2,'localhost:8000','Teakwood'),(3,'Ubuntu','Alex\'s Laptop');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_crontabschedule`
--

DROP TABLE IF EXISTS `djcelery_crontabschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_crontabschedule`
--

LOCK TABLES `djcelery_crontabschedule` WRITE;
/*!40000 ALTER TABLE `djcelery_crontabschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_crontabschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_intervalschedule`
--

DROP TABLE IF EXISTS `djcelery_intervalschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_intervalschedule`
--

LOCK TABLES `djcelery_intervalschedule` WRITE;
/*!40000 ALTER TABLE `djcelery_intervalschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_intervalschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_periodictask`
--

DROP TABLE IF EXISTS `djcelery_periodictask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_periodictask_17d2d99d` (`interval_id`),
  KEY `djcelery_periodictask_7aa5fda` (`crontab_id`),
  CONSTRAINT `crontab_id_refs_id_ebff5e74` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  CONSTRAINT `interval_id_refs_id_f2054349` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_periodictask`
--

LOCK TABLES `djcelery_periodictask` WRITE;
/*!40000 ALTER TABLE `djcelery_periodictask` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_periodictask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_periodictasks`
--

DROP TABLE IF EXISTS `djcelery_periodictasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_periodictasks`
--

LOCK TABLES `djcelery_periodictasks` WRITE;
/*!40000 ALTER TABLE `djcelery_periodictasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_periodictasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_taskstate`
--

DROP TABLE IF EXISTS `djcelery_taskstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_355bfc27` (`state`),
  KEY `djcelery_taskstate_52094d6e` (`name`),
  KEY `djcelery_taskstate_f0ba6500` (`tstamp`),
  KEY `djcelery_taskstate_20fc5b84` (`worker_id`),
  KEY `djcelery_taskstate_c91f1bf` (`hidden`),
  CONSTRAINT `worker_id_refs_id_4e3453a` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_taskstate`
--

LOCK TABLES `djcelery_taskstate` WRITE;
/*!40000 ALTER TABLE `djcelery_taskstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_taskstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_workerstate`
--

DROP TABLE IF EXISTS `djcelery_workerstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_eb8ac7e4` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_workerstate`
--

LOCK TABLES `djcelery_workerstate` WRITE;
/*!40000 ALTER TABLE `djcelery_workerstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_workerstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileupload_modelinputdata`
--

DROP TABLE IF EXISTS `fileupload_modelinputdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileupload_modelinputdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `model_input_id` int(11) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fileupload_modelinputdata_fbfc09f1` (`user_id`),
  KEY `fileupload_modelinputdata_bda51c3c` (`group_id`),
  KEY `fileupload_modelinputdata_f37dbb15` (`model_input_id`),
  CONSTRAINT `group_id_refs_id_7b43f415` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `model_input_id_refs_id_879871e` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `user_id_refs_id_bcbcea4c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileupload_modelinputdata`
--

LOCK TABLES `fileupload_modelinputdata` WRITE;
/*!40000 ALTER TABLE `fileupload_modelinputdata` DISABLE KEYS */;
INSERT INTO `fileupload_modelinputdata` VALUES (1,'bath.bot',1,1,'2014-10-09 16:39:57','2014-10-09 16:39:57','',1,'/home/alex/TEAKWOOD/media/users/U1/P1/M1/MODELINPUT/bath.bot'),(2,'buoy.loc',1,1,'2014-10-09 16:39:57','2014-10-09 16:39:57','',1,'/home/alex/TEAKWOOD/media/users/U1/P1/M1/MODELINPUT/buoy.loc'),(3,'grid.xy',1,1,'2014-10-09 16:39:57','2014-10-09 16:39:57','',1,'/home/alex/TEAKWOOD/media/users/U1/P1/M1/MODELINPUT/grid.xy'),(4,'ncep2011.wd',1,1,'2014-10-09 16:39:57','2014-10-09 16:39:57','',1,'/home/alex/TEAKWOOD/media/users/U1/P1/M1/MODELINPUT/ncep2011.wd'),(6,'INPUT',1,1,'2014-10-09 19:04:29','2014-10-09 19:04:29','',1,'/home/alex/TEAKWOOD/media/users/U1/P1/M1/MODELINPUT/INPUT'),(12,'bath.bot',1,1,'2014-10-09 21:09:56','2014-10-09 21:09:56','',3,'/home/alex/TEAKWOOD/media/users/U1/P2/M3/MODELINPUT/bath.bot'),(13,'buoy.loc',1,1,'2014-10-09 21:09:58','2014-10-09 21:09:58','',3,'/home/alex/TEAKWOOD/media/users/U1/P2/M3/MODELINPUT/buoy.loc'),(14,'INPUT',1,1,'2014-10-09 21:09:59','2014-10-09 21:09:59','',3,'/home/alex/TEAKWOOD/media/users/U1/P2/M3/MODELINPUT/INPUT'),(15,'grid.xy',1,1,'2014-10-09 21:09:59','2014-10-09 21:09:59','',3,'/home/alex/TEAKWOOD/media/users/U1/P2/M3/MODELINPUT/grid.xy'),(16,'ncep2011.wd',1,1,'2014-10-09 21:09:59','2014-10-09 21:09:59','',3,'/home/alex/TEAKWOOD/media/users/U1/P2/M3/MODELINPUT/ncep2011.wd'),(17,'bath.bot',1,2,'2014-10-10 02:33:21','2014-10-10 02:33:21','',4,'/home/alex/TEAKWOOD/media/users/U1/P3/M4/MODELINPUT/bath.bot'),(18,'buoy.loc',1,2,'2014-10-10 02:33:21','2014-10-10 02:33:21','',4,'/home/alex/TEAKWOOD/media/users/U1/P3/M4/MODELINPUT/buoy.loc'),(19,'grid.xy',1,2,'2014-10-10 02:33:21','2014-10-10 02:33:21','',4,'/home/alex/TEAKWOOD/media/users/U1/P3/M4/MODELINPUT/grid.xy'),(20,'INPUT',1,2,'2014-10-10 02:33:21','2014-10-10 02:33:21','',4,'/home/alex/TEAKWOOD/media/users/U1/P3/M4/MODELINPUT/INPUT'),(21,'ncep2011.wd',1,2,'2014-10-10 02:33:21','2014-10-10 02:33:21','',4,'/home/alex/TEAKWOOD/media/users/U1/P3/M4/MODELINPUT/ncep2011.wd');
/*!40000 ALTER TABLE `fileupload_modelinputdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_registrationprofile`
--

DROP TABLE IF EXISTS `registration_registrationprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_cecd7f3c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_registrationprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simesh_domain`
--

DROP TABLE IF EXISTS `simesh_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simesh_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `project_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `latitude_min` double NOT NULL,
  `longitude_min` double NOT NULL,
  `latitude_max` double NOT NULL,
  `longitude_max` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `simesh_domain_fbfc09f1` (`user_id`),
  KEY `simesh_domain_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_5bef17cc` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `project_id_refs_id_f1de7cbf` FOREIGN KEY (`project_id`) REFERENCES `workflow_project` (`id`),
  CONSTRAINT `user_id_refs_id_9d613195` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simesh_domain`
--

LOCK TABLES `simesh_domain` WRITE;
/*!40000 ALTER TABLE `simesh_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `simesh_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simfactory_job`
--

DROP TABLE IF EXISTS `simfactory_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simfactory_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `jobid` varchar(64) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `model_input_id` int(11) NOT NULL,
  `exitstatus` int(10) unsigned DEFAULT NULL,
  `annotation` varchar(64) DEFAULT NULL,
  `jobstate` varchar(1) DEFAULT NULL,
  `jobsubstate` varchar(64) DEFAULT NULL,
  `machine_id` int(11) NOT NULL,
  `nodes` int(10) unsigned NOT NULL,
  `slots` int(10) unsigned NOT NULL,
  `queuename` varchar(64) NOT NULL,
  `wallclocktime` int(10) unsigned NOT NULL,
  `wallclocktimestring` varchar(12) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `emailonstarted` tinyint(1) NOT NULL,
  `emailonterminated` tinyint(1) NOT NULL,
  `dispatchtime` datetime DEFAULT NULL,
  `finishtime` datetime DEFAULT NULL,
  `accountingid` varchar(64) DEFAULT NULL,
  `local_dir` varchar(256) DEFAULT NULL,
  `remote_dir` varchar(256) DEFAULT NULL,
  `script_template_id` int(11) DEFAULT NULL,
  `script_name` varchar(64) DEFAULT NULL,
  `qstat_xml` longtext,
  `progress` smallint(5) unsigned NOT NULL,
  `submit_now` tinyint(1) NOT NULL,
  `stdout` longtext,
  `stderr` longtext,
  PRIMARY KEY (`id`),
  KEY `simfactory_job_fbfc09f1` (`user_id`),
  KEY `simfactory_job_bda51c3c` (`group_id`),
  KEY `simfactory_job_b6620684` (`project_id`),
  KEY `simfactory_job_f37dbb15` (`model_input_id`),
  KEY `simfactory_job_5a994bc4` (`machine_id`),
  KEY `simfactory_job_593a7b` (`script_template_id`),
  CONSTRAINT `group_id_refs_id_dfbde064` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `machine_id_refs_id_bb39aefb` FOREIGN KEY (`machine_id`) REFERENCES `simfactory_machine` (`id`),
  CONSTRAINT `model_input_id_refs_id_ddd32fe7` FOREIGN KEY (`model_input_id`) REFERENCES `coastalmodels_modelinput` (`id`),
  CONSTRAINT `project_id_refs_id_5990d2a9` FOREIGN KEY (`project_id`) REFERENCES `workflow_project` (`id`),
  CONSTRAINT `script_template_id_refs_id_52e2009a` FOREIGN KEY (`script_template_id`) REFERENCES `simfactory_scripttemplate` (`id`),
  CONSTRAINT `user_id_refs_id_6aa2d403` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simfactory_job`
--

LOCK TABLES `simfactory_job` WRITE;
/*!40000 ALTER TABLE `simfactory_job` DISABLE KEYS */;
INSERT INTO `simfactory_job` VALUES (12,'RGUO_SWAN_M1_J12',1,1,'2014-10-09 19:04:41','2014-10-10 02:36:36','',NULL,1,1,NULL,NULL,'A',NULL,4,1,1,'checkpt',1,'1:00:00','guojiarui@gmail.com',1,1,NULL,NULL,'hpc_charcol01','users/U1/P1/M1/RGUO_SWAN_M1_J12','/home/rguo/work/RGUO_SWAN_M1_J12',10,'teakwood.pbs','',98,1,'+time 20110104.210000   , step     93; iteration   12; sweep 4\n+time 20110104.210000   , step     93; iteration   13; sweep 1\n+time 20110104.210000   , step     93; iteration   13; sweep 2\n+time 20110104.210000   , step     93; iteration   13; sweep 3\n+time 20110104.210000   , step     93; iteration   13; sweep 4\n+time 20110104.210000   , step     93; iteration   14; sweep 1\n+time 20110104.210000   , step     93; iteration   14; sweep 2\n+time 20110104.210000   , step     93; iteration   14; sweep 3\n+time 20110104.210000   , step     93; iteration   14; sweep 4\n+time 20110104.210000   , step     93; iteration   15; sweep 1\n+time 20110104.210000   , step     93; iteration   15; sweep 2\n+time 20110104.210000   , step     93; iteration   15; sweep 3\n+time 20110104.210000   , step     93; iteration   15; sweep 4\n+SWAN is processing output request    1\n+time 20110104.220000   , step     94; iteration    1; sweep 1\n+time 20110104.220000   , step     94; iteration    1; sweep 2\n+time 20110104.220000   , step     94; iteration    1; sweep 3\n+time 20110104.220000   , step     94; iteration    1; sweep 4\n+time 20110104.220000   , step     94; iteration    2; sweep 1\n+time 20110104.220000   , step     94; iteration    2; sweep 2\n+time 20110104.220000   , step     94; iteration    2; sweep 3\n+time 20110104.220000   , step     94; iteration    2; sweep 4\n+time 20110104.220000   , step     94; iteration    3; sweep 1\n+time 20110104.220000   , step     94; iteration    3; sweep 2\n+time 20110104.220000   , step     94; iteration    3; sweep 3\n+time 20110104.220000   , step     94; iteration    3; sweep 4\n+time 20110104.220000   , step     94; iteration    4; sweep 1\n+time 20110104.220000   , step     94; iteration    4; sweep 2\n+time 20110104.220000   , step     94; iteration    4; sweep 3\n+time 20110104.220000   , step     94; iteration    4; sweep 4\n+time 20110104.220000   , step     94; iteration    5; sweep 1\n+time 20110104.220000   , step     94; iteration    5; sweep 2\n+time 20110104.220000   , step     94; iteration    5; sweep 3\n+time 20110104.220000   , step     94; iteration    5; sweep 4\n+time 20110104.220000   , step     94; iteration    6; sweep 1\n+time 20110104.220000   , step     94; iteration    6; sweep 2\n+time 20110104.220000   , step     94; iteration    6; sweep 3\n+time 20110104.220000   , step     94; iteration    6; sweep 4\n+time 20110104.220000   , step     94; iteration    7; sweep 1\n+time 20110104.220000   , step     94; iteration    7; sweep 2\n+time 20110104.220000   , step     94; iteration    7; sweep 3\n+time 20110104.220000   , step     94; iteration    7; sweep 4\n+time 20110104.220000   , step     94; iteration    8; sweep 1\n+time 20110104.220000   , step     94; iteration    8; sweep 2\n+time 20110104.220000   , step     94; iteration    8; sweep 3\n+time 20110104.220000   , step     94; iteration    8; sweep 4\n+time 20110104.220000   , step     94; iteration    9; sweep 1\n+time 20110104.220000   , step     94; iteration    9; sweep 2\n+time 20110104.220000   , step     94; iteration    9; sweep 3\n+time 20110104.220000   , step     94; iteration    9; sweep 4\n+time 20110104.220000   , step     94; iteration   10; sweep 1\n+time 20110104.220000   , step     94; iteration   10; sweep 2\n+time 20110104.220000   , step     94; iteration   10; sweep 3\n+time 20110104.220000   , step     94; iteration   10; sweep 4\n+time 20110104.220000   , step     94; iteration   11; sweep 1\n+time 20110104.220000   , step     94; iteration   11; sweep 2\n+time 20110104.220000   , step     94; iteration   11; sweep 3\n+time 20110104.220000   , step     94; iteration   11; sweep 4\n+time 20110104.220000   , step     94; iteration   12; sweep 1\n+time 20110104.220000   , step     94; iteration   12; sweep 2\n+time 20110104.220000   , step     94; iteration   12; sweep 3\n+time 20110104.220000   , step     94; iteration   12; sweep 4\n+time 20110104.220000   , step     94; iteration   13; sweep 1\n+time 20110104.220000   , step     94; iteration   13; sweep 2\n+time 20110104.220000   , step     94; iteration   13; sweep 3\n+time 20110104.220000   , step     94; iteration   13; sweep 4\n+time 20110104.220000   , step     94; iteration   14; sweep 1\n+time 20110104.220000   , step     94; iteration   14; sweep 2\n+time 20110104.220000   , step     94; iteration   14; sweep 3\n+time 20110104.220000   , step     94; iteration   14; sweep 4\n+time 20110104.220000   , step     94; iteration   15; sweep 1\n+time 20110104.220000   , step     94; iteration   15; sweep 2\n+time 20110104.220000   , step     94; iteration   15; sweep 3\n+time 20110104.220000   , step     94; iteration   15; sweep 4\n+SWAN is processing output request    1\n+time 20110104.230000   , step     95; iteration    1; sweep 1\n+time 20110104.230000   , step     95; iteration    1; sweep 2\n+time 20110104.230000   , step     95; iteration    1; sweep 3\n+time 20110104.230000   , step     95; iteration    1; sweep 4\n+time 20110104.230000   , step     95; iteration    2; sweep 1\n+time 20110104.230000   , step     95; iteration    2; sweep 2\n+time 20110104.230000   , step     95; iteration    2; sweep 3\n+time 20110104.230000   , step     95; iteration    2; sweep 4\n+time 20110104.230000   , step     95; iteration    3; sweep 1\n+time 20110104.230000   , step     95; iteration    3; sweep 2\n+time 20110104.230000   , step     95; iteration    3; sweep 3\n+time 20110104.230000   , step     95; iteration    3; sweep 4\n+time 20110104.230000   , step     95; iteration    4; sweep 1\n+time 20110104.230000   , step     95; iteration    4; sweep 2\n+time 20110104.230000   , step     95; iteration    4; sweep 3\n+time 20110104.230000   , step     95; iteration    4; sweep 4\n+time 20110104.230000   , step     95; iteration    5; sweep 1\n+time 20110104.230000   , step     95; iteration    5; sweep 2\n+time 20110104.230000   , step     95; iteration    5; sweep 3\n+time 20110104.230000   , step     95; iteration    5; sweep 4\n+time 20110104.230000   , step     95; iteration    6; sweep 1\n+time 20110104.230000   , step     95; iteration    6; sweep 2\n+time 20110104.230000   , step     95; iteration    6; sweep 3\n+time 20110104.230000   , step     95; iteration    6; sweep 4\n+time 20110104.230000   , step     95; iteration    7; sweep 1\n+time 20110104.230000   , step     95; iteration    7; sweep 2\n+time 20110104.230000   , step     95; iteration    7; sweep 3\n+time 20110104.230000   , step     95; iteration    7; sweep 4\n+time 20110104.230000   , step     95; iteration    8; sweep 1\n+time 20110104.230000   , step     95; iteration    8; sweep 2\n+time 20110104.230000   , step     95; iteration    8; sweep 3\n+time 20110104.230000   , step     95; iteration    8; sweep 4\n+time 20110104.230000   , step     95; iteration    9; sweep 1\n+time 20110104.230000   , step     95; iteration    9; sweep 2\n+time 20110104.230000   , step     95; iteration    9; sweep 3\n+time 20110104.230000   , step     95; iteration    9; sweep 4\n+time 20110104.230000   , step     95; iteration   10; sweep 1\n+time 20110104.230000   , step     95; iteration   10; sweep 2\n+time 20110104.230000   , step     95; iteration   10; sweep 3\n+time 20110104.230000   , step     95; iteration   10; sweep 4\n+time 20110104.230000   , step     95; iteration   11; sweep 1\n+time 20110104.230000   , step     95; iteration   11; sweep 2\n+time 20110104.230000   , step     95; iteration   11; sweep 3\n+time 20110104.230000   , step     95; iteration   11; sweep 4\n+time 20110104.230000   , step     95; iteration   12; sweep 1\n+time 20110104.230000   , step     95; iteration   12; sweep 2\n+time 20110104.230000   , step     95; iteration   12; sweep 3\n+time 20110104.230000   , step     95; iteration   12; sweep 4\n+time 20110104.230000   , step     95; iteration   13; sweep 1\n+time 20110104.230000   , step     95; iteration   13; sweep 2\n+time 20110104.230000   , step     95; iteration   13; sweep 3\n+time 20110104.230000   , step     95; iteration   13; sweep 4\n+time 20110104.230000   , step     95; iteration   14; sweep 1\n+time 20110104.230000   , step     95; iteration   14; sweep 2\n+time 20110104.230000   , step     95; iteration   14; sweep 3\n+time 20110104.230000   , step     95; iteration   14; sweep 4\n+time 20110104.230000   , step     95; iteration   15; sweep 1\n+time 20110104.230000   , step     95; iteration   15; sweep 2\n+time 20110104.230000   , step     95; iteration   15; sweep 3\n+time 20110104.230000   , step     95; iteration   15; sweep 4\n+SWAN is processing output request    1\n+time 20110105.000000   , step     96; iteration    1; sweep 1\n+time 20110105.000000   , step     96; iteration    1; sweep 2\n+time 20110105.000000   , step     96; iteration    1; sweep 3\n+time 20110105.000000   , step     96; iteration    1; sweep 4\n+time 20110105.000000   , step     96; iteration    2; sweep 1\n+time 20110105.000000   , step     96; iteration    2; sweep 2\n+time 20110105.000000   , step     96; iteration    2; sweep 3\n+time 20110105.000000   , step     96; iteration    2; sweep 4\n+time 20110105.000000   , step     96; iteration    3; sweep 1\n+time 20110105.000000   , step     96; iteration    3; sweep 2\n+time 20110105.000000   , step     96; iteration    3; sweep 3\n+time 20110105.000000   , step     96; iteration    3; sweep 4\n+time 20110105.000000   , step     96; iteration    4; sweep 1\n+time 20110105.000000   , step     96; iteration    4; sweep 2\n+time 20110105.000000   , step     96; iteration    4; sweep 3\n+time 20110105.000000   , step     96; iteration    4; sweep 4\n+time 20110105.000000   , step     96; iteration    5; sweep 1\n+time 20110105.000000   , step     96; iteration    5; sweep 2\n+time 20110105.000000   , step     96; iteration    5; sweep 3\n+time 20110105.000000   , step     96; iteration    5; sweep 4\n+time 20110105.000000   , step     96; iteration    6; sweep 1\n+time 20110105.000000   , step     96; iteration    6; sweep 2\n+time 20110105.000000   , step     96; iteration    6; sweep 3\n+time 20110105.000000   , step     96; iteration    6; sweep 4\n+time 20110105.000000   , step     96; iteration    7; sweep 1\n+time 20110105.000000   , step     96; iteration    7; sweep 2\n+time 20110105.000000   , step     96; iteration    7; sweep 3\n+time 20110105.000000   , step     96; iteration    7; sweep 4\n+time 20110105.000000   , step     96; iteration    8; sweep 1\n+time 20110105.000000   , step     96; iteration    8; sweep 2\n+time 20110105.000000   , step     96; iteration    8; sweep 3\n+time 20110105.000000   , step     96; iteration    8; sweep 4\n+time 20110105.000000   , step     96; iteration    9; sweep 1\n+time 20110105.000000   , step     96; iteration    9; sweep 2\n+time 20110105.000000   , step     96; iteration    9; sweep 3\n+time 20110105.000000   , step     96; iteration    9; sweep 4\n+time 20110105.000000   , step     96; iteration   10; sweep 1\n+time 20110105.000000   , step     96; iteration   10; sweep 2\n+time 20110105.000000   , step     96; iteration   10; sweep 3\n+time 20110105.000000   , step     96; iteration   10; sweep 4\n+time 20110105.000000   , step     96; iteration   11; sweep 1\n+time 20110105.000000   , step     96; iteration   11; sweep 2\n+time 20110105.000000   , step     96; iteration   11; sweep 3\n+time 20110105.000000   , step     96; iteration   11; sweep 4\n+time 20110105.000000   , step     96; iteration   12; sweep 1\n+time 20110105.000000   , step     96; iteration   12; sweep 2\n+time 20110105.000000   , step     96; iteration   12; sweep 3\n+time 20110105.000000   , step     96; iteration   12; sweep 4\n+time 20110105.000000   , step     96; iteration   13; sweep 1\n+time 20110105.000000   , step     96; iteration   13; sweep 2\n+time 20110105.000000   , step     96; iteration   13; sweep 3\n+time 20110105.000000   , step     96; iteration   13; sweep 4\n+time 20110105.000000   , step     96; iteration   14; sweep 1\n+time 20110105.000000   , step     96; iteration   14; sweep 2\n+time 20110105.000000   , step     96; iteration   14; sweep 3\n+time 20110105.000000   , step     96; iteration   14; sweep 4\n+time 20110105.000000   , step     96; iteration   15; sweep 1\n+time 20110105.000000   , step     96; iteration   15; sweep 2\n+time 20110105.000000   , step     96; iteration   15; sweep 3\n+time 20110105.000000   , step     96; iteration   15; sweep 4\n+SWAN is processing output request    1\n+time 20110105.010000   , step     97; iteration    1; sweep 1\n+time 20110105.010000   , step     97; iteration    1; sweep 2\n+time 20110105.010000   , step     97; iteration    1; sweep 3\n+time 20110105.010000   , step     97; iteration    1; sweep 4\n+time 20110105.010000   , step     97; iteration    2; sweep 1\n+time 20110105.010000   , step     97; iteration    2; sweep 2\n+time 20110105.010000   , step     97; iteration    2; sweep 3\n+time 20110105.010000   , step     97; iteration    2; sweep 4\n+time 20110105.010000   , step     97; iteration    3; sweep 1\n+time 20110105.010000   , step     97; iteration    3; sweep 2\n+time 20110105.010000   , step     97; iteration    3; sweep 3\n+time 20110105.010000   , step     97; iteration    3; sweep 4\n+time 20110105.010000   , step     97; iteration    4; sweep 1\n+time 20110105.010000   , step     97; iteration    4; sweep 2\n+time 20110105.010000   , step     97; iteration    4; sweep 3\n+time 20110105.010000   , step     97; iteration    4; sweep 4\n+time 20110105.010000   , step     97; iteration    5; sweep 1\n+time 20110105.010000   , step     97; iteration    5; sweep 2\n+time 20110105.010000   , step     97; iteration    5; sweep 3\n+time 20110105.010000   , step     97; iteration    5; sweep 4\n+time 20110105.010000   , step     97; iteration    6; sweep 1\n+time 20110105.010000   , step     97; iteration    6; sweep 2\n+time 20110105.010000   , step     97; iteration    6; sweep 3\n+time 20110105.010000   , step     97; iteration    6; sweep 4\n+time 20110105.010000   , step     97; iteration    7; sweep 1\n+time 20110105.010000   , step     97; iteration    7; sweep 2\n+time 20110105.010000   , step     97; iteration    7; sweep 3\n+time 20110105.010000   , step     97; iteration    7; sweep 4\n+time 20110105.010000   , step     97; iteration    8; sweep 1\n+time 20110105.010000   , step     97; iteration    8; sweep 2\n+time 20110105.010000   , step     97; iteration    8; sweep 3\n+time 20110105.010000   , step     97; iteration    8; sweep 4\n+time 20110105.010000   , step     97; iteration    9; sweep 1\n+time 20110105.010000   , step     97; iteration    9; sweep 2\n+time 20110105.010000   , step     97; iteration    9; sweep 3\n+time 20110105.010000   , step     97; iteration    9; sweep 4\n+time 20110105.010000   , step     97; iteration   10; sweep 1\n+time 20110105.010000   , step     97; iteration   10; sweep 2\n+time 20110105.010000   , step     97; iteration   10; sweep 3\n+time 20110105.010000   , step     97; iteration   10; sweep 4\n+time 20110105.010000   , step     97; iteration   11; sweep 1\n+time 20110105.010000   , step     97; iteration   11; sweep 2\n+time 20110105.010000   , step     97; iteration   11; sweep 3\n+time 20110105.010000   , step     97; iteration   11; sweep 4\n+time 20110105.010000   , step     97; iteration   12; sweep 1\n+time 20110105.010000   , step     97; iteration   12; sweep 2\n+time 20110105.010000   , step     97; iteration   12; sweep 3\n+time 20110105.010000   , step     97; iteration   12; sweep 4\n+time 20110105.010000   , step     97; iteration   13; sweep 1\n+time 20110105.010000   , step     97; iteration   13; sweep 2\n+time 20110105.010000   , step     97; iteration   13; sweep 3\n+time 20110105.010000   , step     97; iteration   13; sweep 4\n+time 20110105.010000   , step     97; iteration   14; sweep 1\n+time 20110105.010000   , step     97; iteration   14; sweep 2\n+time 20110105.010000   , step     97; iteration   14; sweep 3\n+time 20110105.010000   , step     97; iteration   14; sweep 4\n+time 20110105.010000   , step     97; iteration   15; sweep 1\n+time 20110105.010000   , step     97; iteration   15; sweep 2\n+time 20110105.010000   , step     97; iteration   15; sweep 3\n+time 20110105.010000   , step     97; iteration   15; sweep 4\n+SWAN is processing output request    1\n+time 20110105.020000   , step     98; iteration    1; sweep 1\n+time 20110105.020000   , step     98; iteration    1; sweep 2\n+time 20110105.020000   , step     98; iteration    1; sweep 3\n+time 20110105.020000   , step     98; iteration    1; sweep 4\n+time 20110105.020000   , step     98; iteration    2; sweep 1\n+time 20110105.020000   , step     98; iteration    2; sweep 2\n+time 20110105.020000   , step     98; iteration    2; sweep 3\n+time 20110105.020000   , step     98; iteration    2; sweep 4\n+time 20110105.020000   , step     98; iteration    3; sweep 1\n+time 20110105.020000   , step     98; iteration    3; sweep 2\n+time 20110105.020000   , step     98; iteration    3; sweep 3\n+time 20110105.020000   , step     98; iteration    3; sweep 4\n+time 20110105.020000   , step     98; iteration    4; sweep 1\n+time 20110105.020000   , step     98; iteration    4; sweep 2\n+time 20110105.020000   , step     98; iteration    4; sweep 3\n+time 20110105.020000   , step     98; iteration    4; sweep 4\n+time 20110105.020000   , step     98; iteration    5; sweep 1\n+time 20110105.020000   , step     98; iteration    5; sweep 2\n+time 20110105.020000   , step     98; iteration    5; sweep 3\n+time 20110105.020000   , step     98; iteration    5; sweep 4\n+time 20110105.020000   , step     98; iteration    6; sweep 1\n+time 20110105.020000   , step     98; iteration    6; sweep 2\n+time 20110105.020000   , step     98; iteration    6; sweep 3\n+time 20110105.020000   , step     98; iteration    6; sweep 4\n+time 20110105.020000   , step     98; iteration    7; sweep 1\n+time 20110105.020000   , step     98; iteration    7; sweep 2\n+time 20110105.020000   , step     98; iteration    7; sweep 3\n+time 20110105.020000   , step     98; iteration    7; sweep 4\n+time 20110105.020000   , step     98; iteration    8; sweep 1\n+time 20110105.020000   , step     98; iteration    8; sweep 2\n+time 20110105.020000   , step     98; iteration    8; sweep 3\n+time 20110105.020000   , step     98; iteration    8; sweep 4\n+time 20110105.020000   , step     98; iteration    9; sweep 1\n+time 20110105.020000   , step     98; iteration    9; sweep 2\n+time 20110105.020000   , step     98; iteration    9; sweep 3\n+time 20110105.020000   , step     98; iteration    9; sweep 4\n+time 20110105.020000   , step     98; iteration   10; sweep 1\n+time 20110105.020000   , step     98; iteration   10; sweep 2\n+time 20110105.020000   , step     98; iteration   10; sweep 3\n+time 20110105.020000   , step     98; iteration   10; sweep 4\n+time 20110105.020000   , step     98; iteration   11; sweep 1\n+time 20110105.020000   , step     98; iteration   11; sweep 2\n','mpirun: killing job...\n\nforrtl: error (78): process killed (SIGTERM)\nImage              PC                Routine            Line        Source             \nswan.exe           00000000004E8691  swsnl2_                  1395  swancom4.f\nswan.exe           00000000004C2E3A  source_                  6552  swancom1.f\nswan.exe           00000000004BA658  swompu_                  2984  swancom1.f\nswan.exe           00000000004A6E1C  swcomp_                  1652  swancom1.f\nswan.exe           000000000044261C  swmain_                   609  swanmain.f\nswan.exe           0000000000441144  MAIN__                    122  swanmain.f\nswan.exe           000000000040385C  Unknown               Unknown  Unknown\nlibc.so.6          0000003D5A61ECDD  Unknown               Unknown  Unknown\nswan.exe           0000000000403759  Unknown               Unknown  Unknown\n'),(13,'RGUO_SWAN_M1_J13',1,1,'2014-10-09 20:38:48','2014-10-10 02:36:36','','250944',1,1,NULL,NULL,'Q',NULL,4,1,1,'checkpt',2,'2:00:00','guojiarui@gmail.com',1,1,NULL,NULL,'hpc_charcol01','users/U1/P1/M1/RGUO_SWAN_M1_J13','/home/rguo/work/RGUO_SWAN_M1_J13',10,'teakwood.pbs','<Data><Job><Job_Id>250944.mike3</Job_Id><Job_Name>RGUO_SWAN_M1_J13</Job_Name><Job_Owner>rguo@mike1</Job_Owner><job_state>Q</job_state><queue>checkpt</queue><server>mike3</server><Account_Name>hpc_charcol01</Account_Name><Checkpoint>u</Checkpoint><ctime>1412887141</ctime><Error_Path>mike1:/home/rguo/work/RGUO_SWAN_M1_J13/RGUO_SWAN_M1_J13.err</Error_Path><Hold_Types>n</Hold_Types><Join_Path>n</Join_Path><Keep_Files>n</Keep_Files><Mail_Points>bea</Mail_Points><Mail_Users>guojiarui@gmail.com</Mail_Users><mtime>1412887141</mtime><Output_Path>mike1:/home/rguo/work/RGUO_SWAN_M1_J13/RGUO_SWAN_M1_J13.out</Output_Path><Priority>0</Priority><qtime>1412887141</qtime><Rerunable>True</Rerunable><Resource_List><ncpus>1</ncpus><nodect>1</nodect><nodes>1:ppn=16</nodes><walltime>02:00:00</walltime></Resource_List><Variable_List>PBS_O_QUEUE=checkpt,PBS_O_HOST=mike1,PBS_O_HOME=/home/rguo,PBS_O_LANG=en_US.UTF-8,PBS_O_LOGNAME=rguo,PBS_O_PATH=/usr/lib64/qt-3.3/bin:/usr/local/compilers/Intel/composer_xe_2013.0.079/bin/intel64:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/bin:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/local/packages/softenv/bin:/opt/bin:/opt/dell/srvadmin/bin,PBS_O_MAIL=/var/mail/rguo,PBS_O_SHELL=/bin/bash,PBS_SERVER=mike3,PBS_O_WORKDIR=/home/rguo,MXM_LOG_LEVEL=fatal,MKLROOT=/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl,MANPATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/man/en_US:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/man:/usr/X11R6/man:/usr/share/man:/usr/share/locale/en/man:/usr/bin/man:/usr/local/share/man:/usr/local/man:/usr/local/packages/softenv/man,INTEL_LICENSE_FILE=/usr/local/compilers/Intel:/usr/local/compilers/Intel/intel_fc_10.1/licenses:/usr/local/compilers/Intel/composer_xe_2013.0.079/licenses:/opt/intel/licenses,SHELL=/bin/bash,SSH_CLIENT=167.96.42.74 39389 22,LIBRARY_PATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/compiler/lib/intel64:/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl/lib/intel64,QTDIR=/usr/lib64/qt-3.3,LANGUAGE_TERRITORY=en_US,QTINC=/usr/lib64/qt-3.3/include,INCLUDE_PATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl/include,MIC_LD_LIBRARY_PATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/compiler/lib/mic:/opt/intel/mic/coi/device-linux-release/lib:/opt/intel/mic/myo/lib:/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl/lib/mic,openmpi_HOME=/usr/local/packages/openmpi/1.6.2/Intel-13.0.0,USER=rguo,LD_LIBRARY_PATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/compiler/lib/intel64:/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl/lib/intel64:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/lib:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/lib64,CPATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl/include:/usr/local/compilers/Intel/composer_xe_2013.0.079/tbb/include,PGI=/usr/local/compilers/pgi,NLSPATH=/usr/local/compilers/Intel/composer_xe_2013.0.079/compiler/lib/intel64/locale/en_US:/usr/local/compilers/Intel/composer_xe_2013.0.079/mkl/lib/intel64/locale/en_US,MAIL=/var/mail/rguo,PATH=/usr/lib64/qt-3.3/bin:/usr/local/compilers/Intel/composer_xe_2013.0.079/bin/intel64:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/bin:/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/local/packages/softenv/bin:/opt/bin:/opt/dell/srvadmin/bin,CUDA_NIC_INTEROP=1,SOFTENV_ALIASES=/usr/local/packages/softenv-1.6.2/etc/softenv-aliases.sh,PWD=/home/rguo,LANG=en_US.UTF-8,MOABHOMEDIR=/usr/moab,WHATAMI=Linux,PLATFORM=Linux,SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass,SOFTENV_LOAD=/usr/local/packages/softenv-1.6.2/etc/softenv-load.sh,HOME=/home/rguo,SHLVL=2,LD_INCLUDE_PATH=/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/include,MATHEMATICA_HOME=/usr/local/packages/license/mathematica/10.0,LOGNAME=rguo,CVS_RSH=ssh,QTLIB=/usr/lib64/qt-3.3/lib,SSH_CONNECTION=167.96.42.74 39389 204.90.44.21 22,MXM_SHM_RX_MAX_BUFFERS=32768,LESSOPEN=|/usr/bin/lesspipe.sh %s,ARCH=Linux,G_BROKEN_FILENAMES=1,_=/usr/local/bin/qsub1</Variable_List><etime>1412887141</etime><submit_args>/home/rguo/work/RGUO_SWAN_M1_J13/teakwood.pbs</submit_args><fault_tolerant>False</fault_tolerant><submit_host>mike1</submit_host><init_work_dir>/home/rguo</init_work_dir></Job></Data>\n',0,1,NULL,NULL),(16,'RGUO_SWAN_M3_J16',1,1,'2014-10-09 21:11:23','2014-10-10 02:36:35','',NULL,2,3,NULL,NULL,'A',NULL,4,1,1,'checkpt',1,'1:00:00','guojiarui@gmail.com',1,1,NULL,NULL,'hpc_charcol01','users/U1/P2/M3/RGUO_SWAN_M3_J16','/home/rguo/work/RGUO_SWAN_M3_J16',10,'teakwood.pbs',NULL,0,1,NULL,NULL),(17,'RGUO_SWAN_M4_J17',1,2,'2014-10-10 02:34:37','2014-10-10 02:36:35','',NULL,3,4,NULL,NULL,'A',NULL,4,1,1,'checkpt',2,'2:00:00','guojiarui@gmail.com',1,1,NULL,NULL,'hpc_charcol01','users/U1/P3/M4/RGUO_SWAN_M4_J17','/home/rguo/work/RGUO_SWAN_M4_J17',10,'teakwood.pbs',NULL,0,1,NULL,NULL);
/*!40000 ALTER TABLE `simfactory_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simfactory_machine`
--

DROP TABLE IF EXISTS `simfactory_machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simfactory_machine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `hostname` varchar(60) NOT NULL,
  `account` varchar(60) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `sockets` int(10) unsigned NOT NULL,
  `corespersocket` int(10) unsigned NOT NULL,
  `threadpercore` int(10) unsigned NOT NULL,
  `ppn` int(10) unsigned NOT NULL,
  `maxnodes` int(10) unsigned NOT NULL,
  `maxslots` int(10) unsigned NOT NULL,
  `maxwallclocktime` int(10) unsigned NOT NULL,
  `physmemory` int(10) unsigned NOT NULL,
  `virtmemory` int(10) unsigned NOT NULL,
  `machineos` varchar(10) NOT NULL,
  `machineosversion` varchar(60) NOT NULL,
  `machinearch` varchar(10) NOT NULL,
  `location` varchar(60) NOT NULL,
  `webpage` varchar(60) NOT NULL,
  `contact` varchar(256) DEFAULT NULL,
  `workingdirectory` varchar(256) NOT NULL,
  `queuename` varchar(60) DEFAULT NULL,
  `accountingid` varchar(64) DEFAULT NULL,
  `storageuser` varchar(60) DEFAULT NULL,
  `storagehost` varchar(60) DEFAULT NULL,
  `storagedirectory` varchar(256) NOT NULL,
  `rsynccmd` varchar(60) NOT NULL,
  `rsyncoptions` varchar(256) NOT NULL,
  `rsynctostorage` tinyint(1) NOT NULL,
  `vizuser` varchar(60) NOT NULL,
  `vizhost` varchar(60) NOT NULL,
  `vizdirectory` varchar(256) NOT NULL,
  `vizscript` varchar(60) NOT NULL,
  `rsynctoviz` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `simfactory_machine_fbfc09f1` (`user_id`),
  KEY `simfactory_machine_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_1a70a462` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_5d48ed75` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simfactory_machine`
--

LOCK TABLES `simfactory_machine` WRITE;
/*!40000 ALTER TABLE `simfactory_machine` DISABLE KEYS */;
INSERT INTO `simfactory_machine` VALUES (2,'Teakwood',1,1,'2013-03-18 07:23:37','2013-03-18 10:46:01','A virtual machine at LSU','localhost:8000','teakwood',1,2,2,1,4,1,4,100000,2051316,4128764,'linux','3.6.11-1.fc17.x86_64','x64','CCT, LSU','http://localhost:8000','guojiarui@gmail.com','/data/teakwood','batch','','teakwood','localhost:8000','/data/teakwood','rsync','-rLptgoD --chmod=Dugo+x --chmod=ugo+r',1,'','','','',0),(4,'SuperMike-II',1,2,'2013-04-12 20:13:21','2014-10-09 16:37:28','LSU HPC\'s largest Dell cluster','mike.hpc.lsu.edu','rguo',1,2,8,1,16,382,6112,72,32836256,100663288,'linux','2.6.32-279.19.1.el6.x86_64','x64','HPC, LSU','http://www.hpc.lsu.edu/resources/hpc/system.php','sys-help@loni.org','/home/rguo/work','checkpt','hpc_charcol01','teakwood','localhost:8000','/data/teakwood','rsync','-rLptgoD --chmod=Dugo+x --chmod=ugo+r',0,'teakwood','localhost:8000','/data/teakwood','/data/klhu/viz/d3d_field_view.sh',0);
/*!40000 ALTER TABLE `simfactory_machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simfactory_scripttemplate`
--

DROP TABLE IF EXISTS `simfactory_scripttemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simfactory_scripttemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) DEFAULT NULL,
  `machine_id` int(11) DEFAULT NULL,
  `preprocessor` longtext,
  `postprocessor` longtext,
  `cmd_line` longtext,
  `native_script` longtext,
  `viz_script` longtext,
  `viz_scriptname` varchar(64) DEFAULT NULL,
  `data_file` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_id` (`model_id`,`machine_id`),
  KEY `simfactory_scripttemplate_aff30766` (`model_id`),
  KEY `simfactory_scripttemplate_5a994bc4` (`machine_id`),
  CONSTRAINT `machine_id_refs_id_b8f2c96a` FOREIGN KEY (`machine_id`) REFERENCES `simfactory_machine` (`id`),
  CONSTRAINT `model_id_refs_id_f4f11917` FOREIGN KEY (`model_id`) REFERENCES `coastalmodels_coastalmodel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simfactory_scripttemplate`
--

LOCK TABLES `simfactory_scripttemplate` WRITE;
/*!40000 ALTER TABLE `simfactory_scripttemplate` DISABLE KEYS */;
INSERT INTO `simfactory_scripttemplate` VALUES (2,1,2,'# intel compiler\r\nsource /home/teakwood/local/intel/composer_xe_2013.0.079/bin/compilervars.sh intel64\r\n\r\nexport SWAN_HOME=/home/teakwood/swan\r\n\r\nMPI_RUN=/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/bin/mpirun\r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=$SWAN_HOME:/home/teakwood/local/lib:/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/lib:$LD_LIBRARY_PATH','date','$MPI_RUN  -np $NPROCS $SWAN_HOME/swan.exe  > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err',NULL,NULL,NULL,NULL),(4,2,2,'# intel compiler\r\nsource /home/teakwood/local/intel/composer_xe_2013.0.079/bin/compilervars.sh intel64\r\n\r\n# Specify the config file to be used here (will be set in Teakwood)\r\nargfile=config_flow2d3d.ini\r\n\r\nexport ARCH=intel\r\nexport D3D_HOME=/home/teakwood/delft3d/trunk/bin/lnx\r\n\r\nexedir=$D3D_HOME/flow2d3d/bin\r\nlibdir=$D3D_HOME/flow2d3d/lib\r\n\r\nMPI_RUN=/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/bin/mpirun\r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=$exedir:$libdir:/home/teakwood/local/lib:/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/lib:$LD_LIBRARY_PATH','date','$MPI_RUN  -np $NPROCS $exedir/deltares_hydro.exe $argfile > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err',NULL,NULL,NULL,NULL),(5,4,2,'# intel compiler\r\nsource /home/teakwood/local/intel/composer_xe_2013.0.079/bin/compilervars.sh intel64\r\n\r\nexport CAFUNWAVE_HOME=/home/teakwood/cafunwave\r\n\r\nMPI_RUN=/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/bin/mpirun\r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=/home/teakwood/local/lib:/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/lib:$LD_LIBRARY_PATH','date','$MPI_RUN  -np $NPROCS $CAFUNWAVE_HOME/exe/cafunwave.exe  cafunwave.par > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err',NULL,NULL,NULL,NULL),(8,3,4,'# set environment variables\r\nexport MPI_RUN=/usr/local/packages/mvapich2/1.8.1/Intel-13.0.0/bin/mpirun\r\nexport ADCIRC_HOME=/home/alex/tools/adcirc\r\n\r\n# create option files for adcprep\r\ncat > ./opt1 <<DELIM\r\n$NPROCS\r\n1\r\nfort.14\r\nDELIM\r\n\r\ncat > ./opt2 <<DELIM\r\n$NPROCS\r\n2\r\nDELIM','date','#run adcirc prepariation\r\n\r\n$ADCIRC_HOME/adcprep < opt1\r\n$ADCIRC_HOME/adcprep < opt2\r\n\r\n# run mpi job\r\nif $SWAN; then\r\n  $MPI_RUN -np $NPROCS $ADCIRC_HOME/padcswan > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\nelse\r\n  $MPI_RUN -np $NPROCS $ADCIRC_HOME/padcirc > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\nfi','','','',''),(9,6,2,'export WINE=/usr/bin/wine\r\nexport EFDC=/home/teakwood/efdc/efdc.exe','date','$WINE  $EFDC  > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err','','','',''),(10,1,4,'export SWAN_HOME=/home/rguo/swan4101\r\nMPI_RUN=/usr/local/packages/openmpi/1.6.2/Intel-13.0.0/bin/mpirun\r\n','date','$MPI_RUN  -np $NPROCS $SWAN_HOME/swan.exe  > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err','','','','');
/*!40000 ALTER TABLE `simfactory_scripttemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simlab_comparison`
--

DROP TABLE IF EXISTS `simlab_comparison`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simlab_comparison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `job_ids` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `simlab_comparison_fbfc09f1` (`user_id`),
  KEY `simlab_comparison_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_aa7c2a8` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_385c93f7` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simlab_comparison`
--

LOCK TABLES `simlab_comparison` WRITE;
/*!40000 ALTER TABLE `simlab_comparison` DISABLE KEYS */;
/*!40000 ALTER TABLE `simlab_comparison` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simreport_report`
--

DROP TABLE IF EXISTS `simreport_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simreport_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `simreport_report_fbfc09f1` (`user_id`),
  KEY `simreport_report_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_e5b9974f` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `project_id_refs_id_cd1c5b1c` FOREIGN KEY (`project_id`) REFERENCES `workflow_project` (`id`),
  CONSTRAINT `user_id_refs_id_100686b0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simreport_report`
--

LOCK TABLES `simreport_report` WRITE;
/*!40000 ALTER TABLE `simreport_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `simreport_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simviz_plotobs`
--

DROP TABLE IF EXISTS `simviz_plotobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simviz_plotobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_request_id` int(11) NOT NULL,
  `field_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `simviz_plotobs_1c4130b6` (`data_request_id`),
  CONSTRAINT `data_request_id_refs_id_c5db9ef8` FOREIGN KEY (`data_request_id`) REFERENCES `datafactory_datarequest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simviz_plotobs`
--

LOCK TABLES `simviz_plotobs` WRITE;
/*!40000 ALTER TABLE `simviz_plotobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `simviz_plotobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simviz_plotsim`
--

DROP TABLE IF EXISTS `simviz_plotsim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simviz_plotsim` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid_id` int(11) NOT NULL,
  `field_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `simviz_plotsim_55f4c957` (`sid_id`),
  CONSTRAINT `sid_id_refs_id_c24424aa` FOREIGN KEY (`sid_id`) REFERENCES `datafactory_station` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simviz_plotsim`
--

LOCK TABLES `simviz_plotsim` WRITE;
/*!40000 ALTER TABLE `simviz_plotsim` DISABLE KEYS */;
/*!40000 ALTER TABLE `simviz_plotsim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simviz_simtsdata`
--

DROP TABLE IF EXISTS `simviz_simtsdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simviz_simtsdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `xwindv` double NOT NULL,
  `ywindv` double NOT NULL,
  `hs` double NOT NULL,
  `dir` double NOT NULL,
  `rtp` double NOT NULL,
  `per` double NOT NULL,
  `tm01` double NOT NULL,
  `tm02` double NOT NULL,
  `pdi` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `simviz_simtsdata_55f4c957` (`sid_id`),
  CONSTRAINT `sid_id_refs_id_6a66a5dc` FOREIGN KEY (`sid_id`) REFERENCES `datafactory_station` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simviz_simtsdata`
--

LOCK TABLES `simviz_simtsdata` WRITE;
/*!40000 ALTER TABLE `simviz_simtsdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `simviz_simtsdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_project`
--

DROP TABLE IF EXISTS `workflow_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `description` longtext,
  `cwd` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_project_fbfc09f1` (`user_id`),
  KEY `workflow_project_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_d734ab5a` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_c436e247` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_project`
--

LOCK TABLES `workflow_project` WRITE;
/*!40000 ALTER TABLE `workflow_project` DISABLE KEYS */;
INSERT INTO `workflow_project` VALUES (1,'tt',1,1,'2014-10-09 16:38:50','2014-10-09 16:38:50','','users/U1/P1'),(2,'test2',1,1,'2014-10-09 20:54:31','2014-10-09 20:54:31','','users/U1/P2'),(3,'test3',1,2,'2014-10-10 02:29:45','2014-10-10 02:29:45','this is a test','users/U1/P3');
/*!40000 ALTER TABLE `workflow_project` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-10 12:36:04
