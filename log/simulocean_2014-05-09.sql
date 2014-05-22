-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: simulocean
-- ------------------------------------------------------
-- Server version	5.1.73

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
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_userprofile`
--

LOCK TABLES `accounts_userprofile` WRITE;
/*!40000 ALTER TABLE `accounts_userprofile` DISABLE KEYS */;
INSERT INTO `accounts_userprofile` VALUES (1,1,'RUI','GUO','CCT','STUDENT','flick',1,0);
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'cct');
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
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `auth_permission_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=142 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add task state',8,'add_taskmeta'),(23,'Can change task state',8,'change_taskmeta'),(24,'Can delete task state',8,'delete_taskmeta'),(25,'Can add saved group result',9,'add_tasksetmeta'),(26,'Can change saved group result',9,'change_tasksetmeta'),(27,'Can delete saved group result',9,'delete_tasksetmeta'),(28,'Can add interval',10,'add_intervalschedule'),(29,'Can change interval',10,'change_intervalschedule'),(30,'Can delete interval',10,'delete_intervalschedule'),(31,'Can add crontab',11,'add_crontabschedule'),(32,'Can change crontab',11,'change_crontabschedule'),(33,'Can delete crontab',11,'delete_crontabschedule'),(34,'Can add periodic tasks',12,'add_periodictasks'),(35,'Can change periodic tasks',12,'change_periodictasks'),(36,'Can delete periodic tasks',12,'delete_periodictasks'),(37,'Can add periodic task',13,'add_periodictask'),(38,'Can change periodic task',13,'change_periodictask'),(39,'Can delete periodic task',13,'delete_periodictask'),(40,'Can add worker',14,'add_workerstate'),(41,'Can change worker',14,'change_workerstate'),(42,'Can delete worker',14,'delete_workerstate'),(43,'Can add task',15,'add_taskstate'),(44,'Can change task',15,'change_taskstate'),(45,'Can delete task',15,'delete_taskstate'),(46,'Can add machine',16,'add_machine'),(47,'Can change machine',16,'change_machine'),(48,'Can delete machine',16,'delete_machine'),(49,'Can add script template',17,'add_scripttemplate'),(50,'Can change script template',17,'change_scripttemplate'),(51,'Can delete script template',17,'delete_scripttemplate'),(52,'Can add job',18,'add_job'),(53,'Can change job',18,'change_job'),(54,'Can delete job',18,'delete_job'),(55,'Can add comparison',19,'add_comparison'),(56,'Can change comparison',19,'change_comparison'),(57,'Can delete comparison',19,'delete_comparison'),(58,'Can add coastal model',20,'add_coastalmodel'),(59,'Can change coastal model',20,'change_coastalmodel'),(60,'Can delete coastal model',20,'delete_coastalmodel'),(61,'Can add model input',21,'add_modelinput'),(62,'Can change model input',21,'change_modelinput'),(63,'Can delete model input',21,'delete_modelinput'),(64,'Can add swan parameters',22,'add_swanparameters'),(65,'Can change swan parameters',22,'change_swanparameters'),(66,'Can delete swan parameters',22,'delete_swanparameters'),(67,'Can add swan config',23,'add_swanconfig'),(68,'Can change swan config',23,'change_swanconfig'),(69,'Can delete swan config',23,'delete_swanconfig'),(70,'Can add delft3d parameters',24,'add_delft3dparameters'),(71,'Can change delft3d parameters',24,'change_delft3dparameters'),(72,'Can delete delft3d parameters',24,'delete_delft3dparameters'),(73,'Can add delft3d config',25,'add_delft3dconfig'),(74,'Can change delft3d config',25,'change_delft3dconfig'),(75,'Can delete delft3d config',25,'delete_delft3dconfig'),(76,'Can add fvcom config',26,'add_fvcomconfig'),(77,'Can change fvcom config',26,'change_fvcomconfig'),(78,'Can delete fvcom config',26,'delete_fvcomconfig'),(79,'Can add adcirc parameters',27,'add_adcircparameters'),(80,'Can change adcirc parameters',27,'change_adcircparameters'),(81,'Can delete adcirc parameters',27,'delete_adcircparameters'),(82,'Can add adcirccera',28,'add_adcirccera'),(83,'Can change adcirccera',28,'change_adcirccera'),(84,'Can delete adcirccera',28,'delete_adcirccera'),(85,'Can add adcirc config',29,'add_adcircconfig'),(86,'Can change adcirc config',29,'change_adcircconfig'),(87,'Can delete adcirc config',29,'delete_adcircconfig'),(88,'Can add ca funwave parameters',30,'add_cafunwaveparameters'),(89,'Can change ca funwave parameters',30,'change_cafunwaveparameters'),(90,'Can delete ca funwave parameters',30,'delete_cafunwaveparameters'),(91,'Can add ca funwave config',31,'add_cafunwaveconfig'),(92,'Can change ca funwave config',31,'change_cafunwaveconfig'),(93,'Can delete ca funwave config',31,'delete_cafunwaveconfig'),(94,'Can add efdc parameters',32,'add_efdcparameters'),(95,'Can change efdc parameters',32,'change_efdcparameters'),(96,'Can delete efdc parameters',32,'delete_efdcparameters'),(97,'Can add efdc config',33,'add_efdcconfig'),(98,'Can change efdc config',33,'change_efdcconfig'),(99,'Can delete efdc config',33,'delete_efdcconfig'),(100,'Can add station',34,'add_station'),(101,'Can change station',34,'change_station'),(102,'Can delete station',34,'delete_station'),(103,'Can add data request',35,'add_datarequest'),(104,'Can change data request',35,'change_datarequest'),(105,'Can delete data request',35,'delete_datarequest'),(106,'Can add buoy data',36,'add_buoydata'),(107,'Can change buoy data',36,'change_buoydata'),(108,'Can delete buoy data',36,'delete_buoydata'),(109,'Can add tide data',37,'add_tidedata'),(110,'Can change tide data',37,'change_tidedata'),(111,'Can delete tide data',37,'delete_tidedata'),(112,'Can add current data',38,'add_currentdata'),(113,'Can change current data',38,'change_currentdata'),(114,'Can delete current data',38,'delete_currentdata'),(115,'Can add report',39,'add_report'),(116,'Can change report',39,'change_report'),(117,'Can delete report',39,'delete_report'),(118,'Can add domain',40,'add_domain'),(119,'Can change domain',40,'change_domain'),(120,'Can delete domain',40,'delete_domain'),(121,'Can add plot obs',41,'add_plotobs'),(122,'Can change plot obs',41,'change_plotobs'),(123,'Can delete plot obs',41,'delete_plotobs'),(124,'Can add sim ts data',42,'add_simtsdata'),(125,'Can change sim ts data',42,'change_simtsdata'),(126,'Can delete sim ts data',42,'delete_simtsdata'),(127,'Can add plot sim',43,'add_plotsim'),(128,'Can change plot sim',43,'change_plotsim'),(129,'Can delete plot sim',43,'delete_plotsim'),(130,'Can add model input data',44,'add_modelinputdata'),(131,'Can change model input data',44,'change_modelinputdata'),(132,'Can delete model input data',44,'delete_modelinputdata'),(133,'Can add project',45,'add_project'),(134,'Can change project',45,'change_project'),(135,'Can delete project',45,'delete_project'),(136,'Can add user profile',46,'add_userprofile'),(137,'Can change user profile',46,'change_userprofile'),(138,'Can delete user profile',46,'delete_userprofile'),(139,'Can add registration profile',47,'add_registrationprofile'),(140,'Can change registration profile',47,'change_registrationprofile'),(141,'Can delete registration profile',47,'delete_registrationprofile');
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
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$uW4EaneAvi7y$gz93HxopXYFhWBOzBUJ/RHvf8pWeF78JpQD9p0rh6TQ=','2014-05-09 07:28:31',1,'alex','','','guojiarui@gmail.com',1,1,'2014-05-06 07:40:49');
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
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `celery_taskmeta_2ff6b945` (`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `celery_tasksetmeta_2ff6b945` (`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_adcircconfig_6340c63c` (`user_id`),
  KEY `coastalmodels_adcircconfig_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_adcircparameters_6340c63c` (`user_id`),
  KEY `coastalmodels_adcircparameters_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_cafunwaveconfig_6340c63c` (`user_id`),
  KEY `coastalmodels_cafunwaveconfig_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_cafunwaveparameters_6340c63c` (`user_id`),
  KEY `coastalmodels_cafunwaveparameters_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_coastalmodel`
--

LOCK TABLES `coastalmodels_coastalmodel` WRITE;
/*!40000 ALTER TABLE `coastalmodels_coastalmodel` DISABLE KEYS */;
INSERT INTO `coastalmodels_coastalmodel` VALUES (1,'model1','1.0','as','images/accept.png','','','','','');
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
  KEY `coastalmodels_delft3dconfig_6340c63c` (`user_id`),
  KEY `coastalmodels_delft3dconfig_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_delft3dparameters_6340c63c` (`user_id`),
  KEY `coastalmodels_delft3dparameters_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_efdcconfig_6340c63c` (`user_id`),
  KEY `coastalmodels_efdcconfig_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_efdcparameters_6340c63c` (`user_id`),
  KEY `coastalmodels_efdcparameters_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_fvcomconfig_6340c63c` (`user_id`),
  KEY `coastalmodels_fvcomconfig_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `coastalmodels_modelinput_6340c63c` (`user_id`),
  KEY `coastalmodels_modelinput_5f412f9a` (`group_id`),
  KEY `coastalmodels_modelinput_37952554` (`project_id`),
  KEY `coastalmodels_modelinput_29840309` (`model_id`),
  KEY `coastalmodels_modelinput_4f87a9d8` (`prior_model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_modelinput`
--

LOCK TABLES `coastalmodels_modelinput` WRITE;
/*!40000 ALTER TABLE `coastalmodels_modelinput` DISABLE KEYS */;
INSERT INTO `coastalmodels_modelinput` VALUES (1,'delft3d input',1,1,'2014-05-09 07:56:10','2014-05-09 07:56:10','dd',1,1,NULL,'~/Downloads',1,0,NULL),(2,'ALEX_MODEL1_M2',1,1,'2014-05-09 08:02:23','2014-05-09 08:02:23','',1,1,1,'test1/M2/MODELINPUT',1,0,'file');
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
  KEY `coastalmodels_swanconfig_6340c63c` (`user_id`),
  KEY `coastalmodels_swanconfig_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coastalmodels_swanconfig`
--

LOCK TABLES `coastalmodels_swanconfig` WRITE;
/*!40000 ALTER TABLE `coastalmodels_swanconfig` DISABLE KEYS */;
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
  KEY `coastalmodels_swanparameters_6340c63c` (`user_id`),
  KEY `coastalmodels_swanparameters_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `datafactory_datarequest_6340c63c` (`user_id`),
  KEY `datafactory_datarequest_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `datafactory_datarequest_stations_cecc205b` (`datarequest_id`),
  KEY `datafactory_datarequest_stations_5ab29bba` (`station_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datafactory_station`
--

LOCK TABLES `datafactory_station` WRITE;
/*!40000 ALTER TABLE `datafactory_station` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-05-06 08:26:50',1,2,'1','cct',1,''),(2,'2014-05-06 08:26:52',1,2,'1','cct',2,'No fields changed.'),(3,'2014-05-06 08:28:15',1,45,'1','test1',1,''),(4,'2014-05-09 07:39:40',1,46,'1','alex',2,'Changed first_name, last_name, affiliation, description, theme and show_hints.'),(5,'2014-05-09 07:42:23',1,46,'1','alex',2,'Changed theme.'),(6,'2014-05-09 07:44:08',1,46,'1','alex',2,'Changed theme.'),(7,'2014-05-09 07:44:41',1,46,'1','alex',2,'Changed theme.'),(8,'2014-05-09 07:45:35',1,46,'1','alex',2,'Changed theme.'),(9,'2014-05-09 07:55:31',1,20,'1','model1 (1.0)',1,''),(10,'2014-05-09 07:56:10',1,21,'1','delft3d input',1,''),(11,'2014-05-09 08:00:07',1,16,'1','queenbee',1,''),(12,'2014-05-09 08:00:44',1,17,'1','model1_queenbee_Scripts',1,''),(13,'2014-05-09 08:00:49',1,18,'1','RUI',1,''),(14,'2014-05-09 08:07:32',1,39,'1','report1',1,'');
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
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'task state','djcelery','taskmeta'),(9,'saved group result','djcelery','tasksetmeta'),(10,'interval','djcelery','intervalschedule'),(11,'crontab','djcelery','crontabschedule'),(12,'periodic tasks','djcelery','periodictasks'),(13,'periodic task','djcelery','periodictask'),(14,'worker','djcelery','workerstate'),(15,'task','djcelery','taskstate'),(16,'machine','simfactory','machine'),(17,'script template','simfactory','scripttemplate'),(18,'job','simfactory','job'),(19,'comparison','simlab','comparison'),(20,'coastal model','coastalmodels','coastalmodel'),(21,'model input','coastalmodels','modelinput'),(22,'swan parameters','coastalmodels','swanparameters'),(23,'swan config','coastalmodels','swanconfig'),(24,'delft3d parameters','coastalmodels','delft3dparameters'),(25,'delft3d config','coastalmodels','delft3dconfig'),(26,'fvcom config','coastalmodels','fvcomconfig'),(27,'adcirc parameters','coastalmodels','adcircparameters'),(28,'adcirccera','coastalmodels','adcirccera'),(29,'adcirc config','coastalmodels','adcircconfig'),(30,'ca funwave parameters','coastalmodels','cafunwaveparameters'),(31,'ca funwave config','coastalmodels','cafunwaveconfig'),(32,'efdc parameters','coastalmodels','efdcparameters'),(33,'efdc config','coastalmodels','efdcconfig'),(34,'station','datafactory','station'),(35,'data request','datafactory','datarequest'),(36,'buoy data','datafactory','buoydata'),(37,'tide data','datafactory','tidedata'),(38,'current data','datafactory','currentdata'),(39,'report','simreport','report'),(40,'domain','simesh','domain'),(41,'plot obs','simviz','plotobs'),(42,'sim ts data','simviz','simtsdata'),(43,'plot sim','simviz','plotsim'),(44,'model input data','fileupload','modelinputdata'),(45,'project','workflow','project'),(46,'user profile','accounts','userprofile'),(47,'registration profile','registration','registrationprofile');
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
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('eda266f56453ca70c3650523bd8d945a','NDljZmE4MTk5NTdlNTZkMDMwMjE5ZDdiMmI5MDM5ZTY2N2M2YWEzMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2014-05-20 07:59:11'),('ab656a6192fd4f79213a2bd28b295a4d','NGNiMDk1NGMyYmNlNDQ3Y2QxMWExNDJiM2Q0ZmU0OWFjMmI3YjE0MDqAAn1xAS4=\n','2014-05-22 22:19:58'),('2c68f45759af1841ab90fb29c2e15196','NDljZmE4MTk5NTdlNTZkMDMwMjE5ZDdiMmI5MDM5ZTY2N2M2YWEzMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2014-05-23 07:28:31');
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `djcelery_periodictask_8905f60d` (`interval_id`),
  KEY `djcelery_periodictask_7280124f` (`crontab_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `djcelery_taskstate_5654bf12` (`state`),
  KEY `djcelery_taskstate_4da47e07` (`name`),
  KEY `djcelery_taskstate_abaacd02` (`tstamp`),
  KEY `djcelery_taskstate_cac6a03d` (`worker_id`),
  KEY `djcelery_taskstate_2ff6b945` (`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `djcelery_workerstate_11e400ef` (`last_heartbeat`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `fileupload_modelinputdata_6340c63c` (`user_id`),
  KEY `fileupload_modelinputdata_5f412f9a` (`group_id`),
  KEY `fileupload_modelinputdata_a76bb860` (`model_input_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileupload_modelinputdata`
--

LOCK TABLES `fileupload_modelinputdata` WRITE;
/*!40000 ALTER TABLE `fileupload_modelinputdata` DISABLE KEYS */;
INSERT INTO `fileupload_modelinputdata` VALUES (1,'ajax-loader.gif',1,1,'2014-05-09 08:02:35','2014-05-09 08:02:35','',2,'/home/alex/SCGATE/media/test1/M2/MODELINPUT/ajax-loader.gif'),(2,'bg_button.gif',1,1,'2014-05-09 08:22:09','2014-05-09 08:22:09','',1,'/home/alex/SCGATE/media/~/Downloads/bg_button.gif');
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
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `simesh_domain_6340c63c` (`user_id`),
  KEY `simesh_domain_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `simfactory_job_6340c63c` (`user_id`),
  KEY `simfactory_job_5f412f9a` (`group_id`),
  KEY `simfactory_job_37952554` (`project_id`),
  KEY `simfactory_job_a76bb860` (`model_input_id`),
  KEY `simfactory_job_dbaea34e` (`machine_id`),
  KEY `simfactory_job_1afbace2` (`script_template_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simfactory_job`
--

LOCK TABLES `simfactory_job` WRITE;
/*!40000 ALTER TABLE `simfactory_job` DISABLE KEYS */;
INSERT INTO `simfactory_job` VALUES (1,'RUI',1,1,'2014-05-09 08:00:49','2014-05-09 08:00:49','as','001',1,1,NULL,'','U','LOUISIANA',1,2,2,'testq',1,'','guojiarui@gmail.com',1,1,NULL,NULL,'','','',1,'','',0,1,'','');
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
  KEY `simfactory_machine_6340c63c` (`user_id`),
  KEY `simfactory_machine_5f412f9a` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simfactory_machine`
--

LOCK TABLES `simfactory_machine` WRITE;
/*!40000 ALTER TABLE `simfactory_machine` DISABLE KEYS */;
INSERT INTO `simfactory_machine` VALUES (1,'queenbee',1,1,'2014-05-09 08:00:07','2014-05-09 08:00:07','','localhost:8000','alex',0,1,2,4,2,2,1,1,48,1,'linux','centos 6.5','x64','LSU','www.google.com','','~/Downloads','','','','','~/Downloads','rsync','-rLptgoD --delete',1,'alex','localhost','~/Downloads','script',0);
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
  KEY `simfactory_scripttemplate_29840309` (`model_id`),
  KEY `simfactory_scripttemplate_dbaea34e` (`machine_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simfactory_scripttemplate`
--

LOCK TABLES `simfactory_scripttemplate` WRITE;
/*!40000 ALTER TABLE `simfactory_scripttemplate` DISABLE KEYS */;
INSERT INTO `simfactory_scripttemplate` VALUES (1,1,1,'','','','','','','');
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
  KEY `simlab_comparison_6340c63c` (`user_id`),
  KEY `simlab_comparison_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `simreport_report_6340c63c` (`user_id`),
  KEY `simreport_report_5f412f9a` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simreport_report`
--

LOCK TABLES `simreport_report` WRITE;
/*!40000 ALTER TABLE `simreport_report` DISABLE KEYS */;
INSERT INTO `simreport_report` VALUES (1,'report1',1,1,'2014-05-09 08:07:32','2014-05-09 08:07:32','',1);
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
  KEY `simviz_plotobs_978bcce1` (`data_request_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `simviz_plotsim_9563f214` (`sid_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `simviz_simtsdata_9563f214` (`sid_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
  KEY `workflow_project_6340c63c` (`user_id`),
  KEY `workflow_project_5f412f9a` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_project`
--

LOCK TABLES `workflow_project` WRITE;
/*!40000 ALTER TABLE `workflow_project` DISABLE KEYS */;
INSERT INTO `workflow_project` VALUES (1,'test1',1,1,'2014-05-06 08:28:15','2014-05-06 08:28:15','','test1');
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

-- Dump completed on 2014-05-09  3:34:08
