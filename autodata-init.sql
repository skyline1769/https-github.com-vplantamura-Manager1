# MySQL-Front 4.2  (Build 2.83)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: localhost    Database: autodata
# ------------------------------------------------------
# Server version 5.1.54-community

DROP DATABASE IF EXISTS `autodata`;
CREATE DATABASE `autodata` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `autodata`;

#
# Table structure for table qt_bak
#

CREATE TABLE `qt_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataid` int(11) DEFAULT NULL COMMENT '配置表的ID',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '配置内容',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '配置描述',
  `addtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自动配置表';

#
# Dumping data for table qt_bak
#
LOCK TABLES `qt_bak` WRITE;
/*!40000 ALTER TABLE `qt_bak` DISABLE KEYS */;

/*!40000 ALTER TABLE `qt_bak` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_data
#

CREATE TABLE `qt_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataid` varchar(255) NOT NULL DEFAULT '' COMMENT '配置订阅键',
  `groupname` varchar(255) NOT NULL DEFAULT '' COMMENT '分组名',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '数据内容',
  `addtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '发布者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_dataid` (`dataid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';

#
# Dumping data for table qt_data
#
LOCK TABLES `qt_data` WRITE;
/*!40000 ALTER TABLE `qt_data` DISABLE KEYS */;

/*!40000 ALTER TABLE `qt_data` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_group
#

CREATE TABLE `qt_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) NOT NULL DEFAULT '' COMMENT '组名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_groupname` (`groupname`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='分组';

#
# Dumping data for table qt_group
#
LOCK TABLES `qt_group` WRITE;
/*!40000 ALTER TABLE `qt_group` DISABLE KEYS */;

INSERT INTO `qt_group` VALUES (8,'DEFAULT');
/*!40000 ALTER TABLE `qt_group` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_history
#

CREATE TABLE `qt_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataid` varchar(255) NOT NULL DEFAULT '' COMMENT '订阅键',
  `groupname` varchar(255) NOT NULL DEFAULT '' COMMENT '分组名',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '配置内容',
  `addtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `action` varchar(255) NOT NULL DEFAULT '' COMMENT '动作',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '发布者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推送历史';

#
# Dumping data for table qt_history
#
LOCK TABLES `qt_history` WRITE;
/*!40000 ALTER TABLE `qt_history` DISABLE KEYS */;

/*!40000 ALTER TABLE `qt_history` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_loginrecord
#

CREATE TABLE `qt_loginrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '登录用户',
  `logintime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登录时间',
  PRIMARY KEY (`id`),
  KEY `index_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='登录记录表';

#
# Dumping data for table qt_loginrecord
#
LOCK TABLES `qt_loginrecord` WRITE;
/*!40000 ALTER TABLE `qt_loginrecord` DISABLE KEYS */;

INSERT INTO `qt_loginrecord` VALUES (1,'admin','2011-05-12 19:09:08');
/*!40000 ALTER TABLE `qt_loginrecord` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_message
#

CREATE TABLE `qt_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT '类型',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '详细内容',
  `reportuser` varchar(255) NOT NULL DEFAULT '' COMMENT '报告人',
  `addtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '反馈时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BUG与意见表';

#
# Dumping data for table qt_message
#
LOCK TABLES `qt_message` WRITE;
/*!40000 ALTER TABLE `qt_message` DISABLE KEYS */;

/*!40000 ALTER TABLE `qt_message` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_rule
#

CREATE TABLE `qt_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pattern` varchar(255) NOT NULL DEFAULT '' COMMENT '模式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则';

#
# Dumping data for table qt_rule
#
LOCK TABLES `qt_rule` WRITE;
/*!40000 ALTER TABLE `qt_rule` DISABLE KEYS */;

/*!40000 ALTER TABLE `qt_rule` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_user
#

CREATE TABLE `qt_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '用户密码',
  `registertime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '注册时间',
  `lastlogintime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户表';

#
# Dumping data for table qt_user
#
LOCK TABLES `qt_user` WRITE;
/*!40000 ALTER TABLE `qt_user` DISABLE KEYS */;

INSERT INTO `qt_user` VALUES (1,'admin','admin','2011-04-25 19:33:13','2011-05-12 19:09:08');
/*!40000 ALTER TABLE `qt_user` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table qt_userrule
#

CREATE TABLE `qt_userrule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL COMMENT '用户ID',
  `pattern` varchar(255) NOT NULL DEFAULT '' COMMENT '规则模式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与规则对应表';

#
# Dumping data for table qt_userrule
#
LOCK TABLES `qt_userrule` WRITE;
/*!40000 ALTER TABLE `qt_userrule` DISABLE KEYS */;

/*!40000 ALTER TABLE `qt_userrule` ENABLE KEYS */;
UNLOCK TABLES;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
