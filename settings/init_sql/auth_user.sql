SET FOREIGN_KEY_CHECKS=0;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'alex','','','guojiarui@gmail.com','pbkdf2_sha256$10000$GU89jw3pMMyc$EHq69+1FlUrXiTM8HzG1pNopLcXOviiyLldgbuaAhlI=',1,1,1,'2013-03-17 00:43:23','2013-02-13 22:02:45'),(2,'samini1','','','samini1@uno.edu','pbkdf2_sha256$10000$yJaPYftO5wwC$loD0AyXpCqcvJxPLfdBLBN/s6ZLc9ZL2V6+jeYClrmQ=',0,1,0,'2013-02-13 22:32:14','2013-02-13 22:31:29'),(3,'gterango','','','gterango@uno.edu','pbkdf2_sha256$10000$VCmtcknsiruu$U7CUOsVrvEYONu80gwteIgRjEn+0r8XwKpIioSBvrfM=',0,1,0,'2014-02-14 16:24:37','2014-02-14 16:18:36'),(4,'xcactus','','','xcactus@gmail.com','pbkdf2_sha256$10000$zwMmR9bSj5gs$jTp7GdMPGs4r2cQalYq+DO6BS9OpJJbN1J5XoKpGxdI=',0,1,0,'2014-03-16 01:57:04','2014-03-15 06:13:16'),(5,'alex','','','','pbkdf2_sha256$10000$qGEuWdtz96Do$nbrJSVIuRQThVtm8Vevab16EgzuttzVV+9lidh5vb60=',1,1,1,'2013-06-06 19:49:02','2013-06-06 19:48:29'),(6,'klhu','','','klhu77@gmail.com','pbkdf2_sha256$10000$biCSTgzA8uGr$8YInugkYhxXo6BfcXnc0yniHAb0qzCx1MPsskj35hk8=',0,1,0,'2013-03-15 20:22:50','2013-03-15 20:20:58'),(7,'kpark32','','','kpark32@tigers.lsu.edu','pbkdf2_sha256$10000$U1FSGck4yHZz$qK3TAQXaDKdbBH/a4+NDk8lFg+KQ4EZyxaSPZ7AUyFI=',0,1,0,'2013-05-29 18:59:55','2013-05-29 18:59:29');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
