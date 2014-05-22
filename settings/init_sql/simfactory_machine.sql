SET FOREIGN_KEY_CHECKS=0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `simulocean`
--

-- --------------------------------------------------------

--
-- Table structure for table `simfactory_machine`
--

CREATE TABLE IF NOT EXISTS `simfactory_machine` (
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
  KEY `simfactory_machine_bda51c3c` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `simfactory_machine`
--

INSERT INTO `simfactory_machine` (`id`, `name`, `user_id`, `group_id`, `time_created`, `last_modified`, `description`, `hostname`, `account`, `available`, `sockets`, `corespersocket`, `threadpercore`, `ppn`, `maxnodes`, `maxslots`, `maxwallclocktime`, `physmemory`, `virtmemory`, `machineos`, `machineosversion`, `machinearch`, `location`, `webpage`, `contact`, `workingdirectory`, `queuename`, `accountingid`, `storageuser`, `storagehost`, `storagedirectory`, `rsynccmd`, `rsyncoptions`, `rsynctostorage`, `vizuser`, `vizhost`, `vizdirectory`, `vizscript`, `rsynctoviz`) VALUES
(1, 'Queen Bee', 1, 1, '2013-03-18 07:23:37', '2013-03-18 10:46:01', 'The large LONI Linux cluster', 'qb.loni.org', 'alex', 1, 2, 4, 1, 8, 256, 2048, 72, 8172892, 25165812, 'other_os', '2.6.9-78.0.22.EL_lustre.1.6.7.2_loni', 'x64', 'LONI, LSU', 'http://hpc.loni.org/resources/hpc/system.php?system=QueenBee', 'sys-help@loni.org', '/work/alex', 'workq', 'loni_ngchc_2013', 'simulocean', 'localhost:8000', '/data/simulocean', '/home/alex/tools/rsync/bin/rsync', '-rLptgoD --chmod=Dugo+x --chmod=ugo+r', 1, 'simulocean', 'localhost:8000', '/data/simulocean', '/data/klhu/viz/d3d_field_view.sh', 0),
(2, 'Simulocean', 1, 1, '2013-03-18 07:23:37', '2013-03-18 10:46:01', 'A virtual machine at LSU', 'localhost:8000', 'simulocean', 1, 2, 2, 1, 4, 1, 4, 100000, 2051316, 4128764, 'linux', '3.6.11-1.fc17.x86_64', 'x64', 'CCT, LSU', 'http://localhost:8000', 'guojiarui@gmail.com', '/data/simulocean', 'batch', '', 'simulocean', 'localhost:8000', '/data/simulocean', 'rsync', '-rLptgoD --chmod=Dugo+x --chmod=ugo+r', 1, '', '', '', '', 0),
(3, 'localhost', 1, 1, '2013-03-18 07:23:37', '2013-03-18 10:46:01', 'Jian''s persona laptop', 'localhost.localdomain', 'simulocean', 1, 1, 4, 2, 4, 1, 8, 100000, 16388144, 0, 'linux', '3.6.11-1.fc17.x86_64', 'x64', 'Johnston 210, CCT, LSU', 'http://localhost:8000', 'guojiarui@gmail.com', '/var/www/html/Simulocean/media/simulations', 'batch', '', 'simulocean', 'localhost:8000', '/data/simulocean', 'rsync', '-rLptgoD --chmod=Dugo+x --chmod=ugo+r', 1, '', '', '', '', 0),
(4, 'SuperMike-II', 1, 2, '2013-04-12 20:13:21', '2013-04-15 20:06:58', 'LSU HPC''s largest Dell cluster', 'mike.hpc.lsu.edu', 'alex', 1, 2, 8, 1, 16, 382, 6112, 72, 32836256, 100663288, 'linux', '2.6.32-279.19.1.el6.x86_64', 'x64', 'HPC, LSU', 'http://www.hpc.lsu.edu/resources/hpc/system.php', 'sys-help@loni.org', '/work/alex', 'checkpt', 'hpc_charcol', 'simulocean', 'localhost:8000', '/data/simulocean', 'rsync', '-rLptgoD --chmod=Dugo+x --chmod=ugo+r', 1, 'simulocean', 'localhost:8000', '/data/simulocean', '/data/klhu/viz/d3d_field_view.sh', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
