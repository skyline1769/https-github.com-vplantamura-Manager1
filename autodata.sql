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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='自动配置表';

#
# Dumping data for table qt_bak
#
LOCK TABLES `qt_bak` WRITE;
/*!40000 ALTER TABLE `qt_bak` DISABLE KEYS */;

INSERT INTO `qt_bak` VALUES (8,4,'qingtian modify it','test','2011-05-10 13:16:13');
INSERT INTO `qt_bak` VALUES (9,5,'1','1','2011-05-11 12:40:47');
INSERT INTO `qt_bak` VALUES (10,6,'1','1','2011-05-11 18:54:43');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='配置表';

#
# Dumping data for table qt_data
#
LOCK TABLES `qt_data` WRITE;
/*!40000 ALTER TABLE `qt_data` DISABLE KEYS */;

INSERT INTO `qt_data` VALUES (5,'org.qingtian.test3','DEFAULT','1','2011-05-11 12:41:10','admin');
INSERT INTO `qt_data` VALUES (6,'org.qingtian.test1','DEFAULT','test1 by test','2011-05-11 18:37:36','admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='推送历史';

#
# Dumping data for table qt_history
#
LOCK TABLES `qt_history` WRITE;
/*!40000 ALTER TABLE `qt_history` DISABLE KEYS */;

INSERT INTO `qt_history` VALUES (8,'org.qingtian.*','DEFAULT','hello world!','2011-05-04 20:45:06','发布','admin');
INSERT INTO `qt_history` VALUES (9,'org.qingtian.*','DEFAULT','修改数据啤！','2011-05-05 14:38:14','修改','admin');
INSERT INTO `qt_history` VALUES (10,'org.qingtian.*','DEFAULT','modify it from web-console','2011-05-05 15:54:44','修改','admin');
INSERT INTO `qt_history` VALUES (11,'org.qingtian.*','DEFAULT','hello','2011-05-05 16:35:21','修改','admin');
INSERT INTO `qt_history` VALUES (12,'org.qingtian.*','DEFAULT','change it again','2011-05-05 16:37:39','修改','admin');
INSERT INTO `qt_history` VALUES (13,'org.qingtian.*','DEFAULT','change it again','2011-05-07 16:19:44','删除','admin');
INSERT INTO `qt_history` VALUES (14,'org.qingtian.*','DEFAULT','hello world! chart is ready now~~~','2011-05-08 19:53:23','发布','admin');
INSERT INTO `qt_history` VALUES (15,'org.qingtian.*','DEFAULT','hello world! chart is ready now~~~','2011-05-10 10:08:45','删除','admin');
INSERT INTO `qt_history` VALUES (16,'org.qingtian.*','DEFAULT','hello world!','2011-05-10 10:09:59','发布','admin');
INSERT INTO `qt_history` VALUES (17,'org.qingtian.*','DEFAULT','hello world!','2011-05-10 10:14:20','删除','admin');
INSERT INTO `qt_history` VALUES (18,'org.qingtian.*','DEFAULT','hello world!','2011-05-10 10:16:03','发布','admin');
INSERT INTO `qt_history` VALUES (19,'org.qingtian.*','DEFAULT','hello world!','2011-05-10 10:16:28','删除','admin');
INSERT INTO `qt_history` VALUES (20,'org.qingtian.*','DEFAULT','hello world!','2011-05-10 10:17:14','发布','admin');
INSERT INTO `qt_history` VALUES (21,'org.qingtian.*','DEFAULT','1','2011-05-10 11:36:27','切换','admin');
INSERT INTO `qt_history` VALUES (22,'org.qingtian.*','DEFAULT','qingtian modify it','2011-05-10 13:17:00','切换','admin');
INSERT INTO `qt_history` VALUES (23,'org.qingtian.test3','DEFAULT','test push data test3','2011-05-10 16:30:37','发布','admin');
INSERT INTO `qt_history` VALUES (24,'org.qingtian.test3','DEFAULT','test3-1','2011-05-10 21:14:27','修改','admin');
INSERT INTO `qt_history` VALUES (25,'org.qingtian.test3','DEFAULT','test3-2','2011-05-10 21:14:49','修改','admin');
INSERT INTO `qt_history` VALUES (26,'org.qingtian.test3','DEFAULT','test-1','2011-05-10 21:18:55','修改','admin');
INSERT INTO `qt_history` VALUES (27,'org.qingtian.test3','DEFAULT','test-2','2011-05-10 21:19:06','修改','admin');
INSERT INTO `qt_history` VALUES (28,'org.qingtian.test3','DEFAULT','test-3','2011-05-10 21:19:13','修改','admin');
INSERT INTO `qt_history` VALUES (29,'org.qingtian.test3','DEFAULT','ha','2011-05-11 09:27:10','修改','admin');
INSERT INTO `qt_history` VALUES (30,'org.qingtian.test3','DEFAULT','haha','2011-05-11 09:27:16','修改','admin');
INSERT INTO `qt_history` VALUES (31,'org.qingtian.test3','DEFAULT','hahaha','2011-05-11 09:27:51','修改','admin');
INSERT INTO `qt_history` VALUES (32,'org.qingtian.test3','DEFAULT','test','2011-05-11 10:18:00','修改','admin');
INSERT INTO `qt_history` VALUES (33,'org.qingtian.test3','DEFAULT','1','2011-05-11 10:37:27','修改','admin');
INSERT INTO `qt_history` VALUES (34,'org.qingtian.test3','DEFAULT','2','2011-05-11 10:37:42','修改','admin');
INSERT INTO `qt_history` VALUES (35,'org.qingtian.test3','DEFAULT','3','2011-05-11 10:44:07','修改','admin');
INSERT INTO `qt_history` VALUES (36,'org.qingtian.test3','DEFAULT','4','2011-05-11 10:46:40','修改','admin');
INSERT INTO `qt_history` VALUES (37,'org.qingtian.test3','DEFAULT','5','2011-05-11 10:51:12','修改','admin');
INSERT INTO `qt_history` VALUES (38,'org.qingtian.test3','DEFAULT','haha dta','2011-05-11 10:51:31','修改','admin');
INSERT INTO `qt_history` VALUES (39,'org.qingtian.test3','DEFAULT','data is modify','2011-05-11 10:52:25','修改','admin');
INSERT INTO `qt_history` VALUES (40,'org.qingtian.test3','DEFAULT','haha','2011-05-11 10:56:34','修改','admin');
INSERT INTO `qt_history` VALUES (41,'org.qingtian.test3','DEFAULT','test 2','2011-05-11 10:56:55','修改','admin');
INSERT INTO `qt_history` VALUES (42,'org.qingtian.test3','DEFAULT','test 3','2011-05-11 10:57:27','修改','admin');
INSERT INTO `qt_history` VALUES (43,'org.qingtian.test3','DEFAULT','test 3 => 1','2011-05-11 12:41:10','切换','admin');
INSERT INTO `qt_history` VALUES (44,'org.qingtian.test1','DEFAULT','test1 by test','2011-05-11 18:37:36','发布','test');
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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='登录记录表';

#
# Dumping data for table qt_loginrecord
#
LOCK TABLES `qt_loginrecord` WRITE;
/*!40000 ALTER TABLE `qt_loginrecord` DISABLE KEYS */;

INSERT INTO `qt_loginrecord` VALUES (35,'admin','2011-05-03 19:19:52');
INSERT INTO `qt_loginrecord` VALUES (36,'test_3','2011-05-03 19:40:43');
INSERT INTO `qt_loginrecord` VALUES (37,'test_1','2011-05-03 20:31:57');
INSERT INTO `qt_loginrecord` VALUES (38,'admin','2011-05-03 22:16:20');
INSERT INTO `qt_loginrecord` VALUES (39,'admin','2011-05-04 10:13:47');
INSERT INTO `qt_loginrecord` VALUES (40,'admin','2011-05-04 12:37:08');
INSERT INTO `qt_loginrecord` VALUES (41,'admin','2011-05-04 14:07:52');
INSERT INTO `qt_loginrecord` VALUES (42,'admin','2011-05-04 14:58:21');
INSERT INTO `qt_loginrecord` VALUES (43,'test_1','2011-05-04 14:58:42');
INSERT INTO `qt_loginrecord` VALUES (44,'test_2','2011-05-04 15:49:26');
INSERT INTO `qt_loginrecord` VALUES (45,'admin','2011-05-04 15:59:23');
INSERT INTO `qt_loginrecord` VALUES (46,'test_1','2011-05-04 16:01:42');
INSERT INTO `qt_loginrecord` VALUES (47,'admin','2011-05-04 16:42:51');
INSERT INTO `qt_loginrecord` VALUES (48,'test_1','2011-05-04 19:08:19');
INSERT INTO `qt_loginrecord` VALUES (49,'admin','2011-05-04 19:20:44');
INSERT INTO `qt_loginrecord` VALUES (50,'admin','2011-05-04 19:52:58');
INSERT INTO `qt_loginrecord` VALUES (51,'test_1','2011-05-04 20:01:19');
INSERT INTO `qt_loginrecord` VALUES (52,'admin','2011-05-04 20:18:20');
INSERT INTO `qt_loginrecord` VALUES (53,'admin','2011-05-05 11:05:20');
INSERT INTO `qt_loginrecord` VALUES (54,'admin','2011-05-05 13:18:45');
INSERT INTO `qt_loginrecord` VALUES (55,'admin','2011-05-05 14:37:32');
INSERT INTO `qt_loginrecord` VALUES (56,'admin','2011-05-05 15:54:14');
INSERT INTO `qt_loginrecord` VALUES (57,'admin','2011-05-05 16:35:11');
INSERT INTO `qt_loginrecord` VALUES (58,'admin','2011-05-05 19:21:52');
INSERT INTO `qt_loginrecord` VALUES (59,'admin','2011-05-06 10:02:05');
INSERT INTO `qt_loginrecord` VALUES (60,'admin','2011-05-06 11:46:05');
INSERT INTO `qt_loginrecord` VALUES (61,'admin','2011-05-06 12:24:37');
INSERT INTO `qt_loginrecord` VALUES (62,'admin','2011-05-06 14:05:48');
INSERT INTO `qt_loginrecord` VALUES (63,'admin','2011-05-06 15:30:23');
INSERT INTO `qt_loginrecord` VALUES (64,'admin','2011-05-06 20:20:24');
INSERT INTO `qt_loginrecord` VALUES (65,'test_1','2011-05-06 21:24:43');
INSERT INTO `qt_loginrecord` VALUES (66,'admin','2011-05-06 21:29:31');
INSERT INTO `qt_loginrecord` VALUES (67,'admin','2011-05-07 14:08:05');
INSERT INTO `qt_loginrecord` VALUES (68,'admin','2011-05-07 15:34:51');
INSERT INTO `qt_loginrecord` VALUES (69,'admin','2011-05-07 18:42:41');
INSERT INTO `qt_loginrecord` VALUES (70,'admin','2011-05-08 19:52:55');
INSERT INTO `qt_loginrecord` VALUES (71,'admin','2011-05-09 16:16:48');
INSERT INTO `qt_loginrecord` VALUES (72,'admin','2011-05-09 19:12:19');
INSERT INTO `qt_loginrecord` VALUES (73,'admin','2011-05-10 09:54:24');
INSERT INTO `qt_loginrecord` VALUES (74,'admin','2011-05-10 11:50:29');
INSERT INTO `qt_loginrecord` VALUES (75,'admin','2011-05-10 13:11:54');
INSERT INTO `qt_loginrecord` VALUES (76,'test-5','2011-05-10 13:34:55');
INSERT INTO `qt_loginrecord` VALUES (77,'admin','2011-05-10 16:26:22');
INSERT INTO `qt_loginrecord` VALUES (78,'test-5','2011-05-10 19:01:54');
INSERT INTO `qt_loginrecord` VALUES (79,'admin','2011-05-10 21:13:39');
INSERT INTO `qt_loginrecord` VALUES (80,'admin','2011-05-11 09:26:14');
INSERT INTO `qt_loginrecord` VALUES (81,'test_1','2011-05-11 11:56:09');
INSERT INTO `qt_loginrecord` VALUES (82,'admin','2011-05-11 12:39:39');
INSERT INTO `qt_loginrecord` VALUES (83,'admin','2011-05-11 15:28:10');
INSERT INTO `qt_loginrecord` VALUES (84,'test','2011-05-11 17:52:43');
INSERT INTO `qt_loginrecord` VALUES (85,'admin','2011-05-11 18:20:47');
INSERT INTO `qt_loginrecord` VALUES (86,'test','2011-05-11 18:21:08');
INSERT INTO `qt_loginrecord` VALUES (87,'admin','2011-05-12 09:30:56');
INSERT INTO `qt_loginrecord` VALUES (88,'admin','2011-05-12 10:12:36');
INSERT INTO `qt_loginrecord` VALUES (89,'admin','2011-05-12 12:05:43');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='规则';

#
# Dumping data for table qt_rule
#
LOCK TABLES `qt_rule` WRITE;
/*!40000 ALTER TABLE `qt_rule` DISABLE KEYS */;

INSERT INTO `qt_rule` VALUES (6,'org.qingtian.test1');
INSERT INTO `qt_rule` VALUES (7,'org.qingtian.test2');
INSERT INTO `qt_rule` VALUES (8,'org.qingtian.test3');
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

INSERT INTO `qt_user` VALUES (1,'admin','admin','2011-04-25 19:33:13','2011-05-12 12:05:43');
INSERT INTO `qt_user` VALUES (3,'test_1','123456','2011-05-03 19:40:13','2011-05-11 11:56:09');
INSERT INTO `qt_user` VALUES (4,'test_2','123456','2011-05-03 19:40:26','2011-05-04 15:49:26');
INSERT INTO `qt_user` VALUES (5,'test_4','123456','2011-05-05 13:18:07','2011-05-05 13:18:07');
INSERT INTO `qt_user` VALUES (6,'test-5','test-5','2011-05-10 13:34:49','2011-05-10 19:01:54');
INSERT INTO `qt_user` VALUES (7,'test','test','2011-05-11 16:16:16','2011-05-11 18:21:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='用户与规则对应表';

#
# Dumping data for table qt_userrule
#
LOCK TABLES `qt_userrule` WRITE;
/*!40000 ALTER TABLE `qt_userrule` DISABLE KEYS */;

INSERT INTO `qt_userrule` VALUES (17,5,'org.qingtian.test1');
INSERT INTO `qt_userrule` VALUES (18,3,'org.qingtian.test1');
INSERT INTO `qt_userrule` VALUES (19,4,'org.qingtian.test2');
INSERT INTO `qt_userrule` VALUES (20,6,'org.qingtian.test2');
INSERT INTO `qt_userrule` VALUES (21,1,'org.qingtian.test3');
INSERT INTO `qt_userrule` VALUES (22,7,'org.qingtian.test1');
/*!40000 ALTER TABLE `qt_userrule` ENABLE KEYS */;
UNLOCK TABLES;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
