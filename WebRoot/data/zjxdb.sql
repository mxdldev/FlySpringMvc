/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.0.22-community-nt : Database - zjxdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`zjxdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `zjxdb`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `artid` int(10) NOT NULL auto_increment,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `regtime` datetime NOT NULL,
  PRIMARY KEY  (`artid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `article` */

insert  into `article`(`artid`,`title`,`content`,`regtime`) values (1,'111444555','123131313131','2012-11-19 00:00:00'),(13,'fff','fff','2012-11-20 14:56:10'),(15,'f1','f1','2012-11-23 15:16:27'),(16,'f2','f2','2012-11-23 15:16:43'),(17,'f3','f3','2012-11-23 15:16:52');

/*Table structure for table `syuser` */

DROP TABLE IF EXISTS `syuser`;

CREATE TABLE `syuser` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(100) NOT NULL COMMENT '登录名',
  `PASSWORD` varchar(100) NOT NULL COMMENT '密码',
  `CREATEDATETIME` datetime default NULL COMMENT '创建时间',
  `MODIFYDATETIME` datetime default NULL COMMENT '最后修改时间',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `syuser` */

insert  into `syuser`(`ID`,`NAME`,`PASSWORD`,`CREATEDATETIME`,`MODIFYDATETIME`) values ('','admin','21232f297a57a5a743894a0e4a801fc3','2012-10-01 08:53:19','2012-11-19 08:53:19');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
