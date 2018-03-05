/*
SQLyog Ultimate v11.5 (64 bit)
MySQL - 5.6.21-log : Database - pms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `pms`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(64) DEFAULT NULL COMMENT '管理员姓名',
  `admin_account` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '管理员登陆账号',
  `admin_password` varchar(64) NOT NULL,
  `admin_comment` varchar(100) DEFAULT NULL,
  `admin_createtime` datetime DEFAULT NULL,
  `admin_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_account` (`admin_account`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`admin_id`,`admin_name`,`admin_account`,`admin_password`,`admin_comment`,`admin_createtime`,`admin_updatetime`) values (1,'admin','admin','123',NULL,'2018-03-03 17:25:08','2018-03-03 17:25:58');

/*Table structure for table `college` */

DROP TABLE IF EXISTS `college`;

CREATE TABLE `college` (
  `college_id` int(11) NOT NULL AUTO_INCREMENT,
  `college_name` varchar(64) DEFAULT NULL,
  `college_comment` varchar(100) DEFAULT NULL COMMENT '备注',
  `college_createtime` datetime DEFAULT NULL,
  `college_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `college` */

insert  into `college`(`college_id`,`college_name`,`college_comment`,`college_createtime`,`college_updatetime`) values (1,'计算机系','1','2018-03-03 20:44:45',NULL);

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(64) DEFAULT NULL,
  `major_id` int(11) DEFAULT NULL,
  `course_comment` varchar(100) DEFAULT NULL COMMENT '备注',
  `course_createtime` datetime DEFAULT NULL,
  `course_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`course_id`,`course_name`,`major_id`,`course_comment`,`course_createtime`,`course_updatetime`) values (1,'java程序设计',1,NULL,'2018-02-28 17:24:34',NULL),(2,'数据结构与算法',1,NULL,'2018-02-28 17:52:04',NULL);

/*Table structure for table `major` */

DROP TABLE IF EXISTS `major`;

CREATE TABLE `major` (
  `major_id` int(11) NOT NULL AUTO_INCREMENT,
  `major_name` varchar(64) DEFAULT NULL,
  `college_id` int(11) NOT NULL,
  `major_comment` varchar(100) DEFAULT NULL COMMENT '备注',
  `major_createtime` datetime DEFAULT NULL,
  `major_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`major_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `major` */

insert  into `major`(`major_id`,`major_name`,`college_id`,`major_comment`,`major_createtime`,`major_updatetime`) values (1,'软件工程',1,'','2018-02-28 17:22:08','2018-03-03 21:22:29');

/*Table structure for table `paper` */

DROP TABLE IF EXISTS `paper`;

CREATE TABLE `paper` (
  `paper_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `project_name` varchar(64) DEFAULT NULL,
  `stu_id` int(11) NOT NULL,
  `student_path` varchar(64) DEFAULT NULL COMMENT '学生上传的位置',
  `paper_flag` int(11) DEFAULT '0' COMMENT '0 老师未批改 1老师已批改',
  `student_uploadtime` varchar(64) DEFAULT NULL,
  `teacher_uploadtime` varchar(64) DEFAULT NULL,
  `teacher_path` varchar(64) DEFAULT NULL COMMENT '教师上传的位置',
  `paper_comment` varchar(64) DEFAULT NULL,
  `paper_createtime` datetime DEFAULT NULL,
  `paper_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`paper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `paper` */

/*Table structure for table `preselection` */

DROP TABLE IF EXISTS `preselection`;

CREATE TABLE `preselection` (
  `pre_id` int(11) NOT NULL AUTO_INCREMENT,
  `stu_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `pre_flag` int(11) DEFAULT '0' COMMENT '0未选择 1已选择选择标志',
  `pre_pass_flag` int(11) DEFAULT '0' COMMENT '通过标志 0等待  pass 1通过 -1拒绝',
  `reject_reason` varchar(200) DEFAULT NULL,
  `pre_comment` varchar(100) DEFAULT NULL,
  `pre_createtime` datetime DEFAULT NULL,
  `pre_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`pre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `preselection` */

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `course_name` varchar(64) DEFAULT NULL,
  `project_name` varchar(64) DEFAULT NULL,
  `info` varchar(100) DEFAULT NULL COMMENT '简介',
  `suggest` varchar(100) DEFAULT NULL COMMENT '建议',
  `project_comment` varchar(100) DEFAULT NULL,
  `project_createtime` datetime DEFAULT NULL,
  `project_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `project` */

insert  into `project`(`project_id`,`teacher_id`,`course_id`,`course_name`,`project_name`,`info`,`suggest`,`project_comment`,`project_createtime`,`project_updatetime`) values (1,1,1,'java程序设计','java电商系统','仿淘宝京东电商','建议java基础扎实的同学选择，如果java后端部分不懂的可以请教我哟！哈哈哈',NULL,'2018-02-28 17:24:10','2018-03-03 00:49:03'),(2,2,2,'数据结构与算法','机器人','使用各种算法完成机器人的控制','建议参加过acm的同学选择','1','2018-02-28 17:54:55','2018-03-04 14:27:33');

/*Table structure for table `question` */

DROP TABLE IF EXISTS `question`;

CREATE TABLE `question` (
  `que_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `que_name` varchar(500) DEFAULT NULL,
  `que_a` varchar(500) DEFAULT NULL,
  `que_b` varchar(500) DEFAULT NULL,
  `que_c` varchar(500) DEFAULT NULL,
  `que_d` varchar(500) DEFAULT NULL,
  `que_answer` char(1) DEFAULT NULL,
  `que_score` int(11) DEFAULT NULL,
  `que_comment` varchar(100) DEFAULT NULL,
  `que_createtime` datetime DEFAULT NULL,
  `que_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`que_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `question` */

insert  into `question`(`que_id`,`course_id`,`que_name`,`que_a`,`que_b`,`que_c`,`que_d`,`que_answer`,`que_score`,`que_comment`,`que_createtime`,`que_updatetime`) values (1,1,'java面向什么的语言？','对象','过程','服务','切面','a',5,NULL,'2018-02-28 17:26:40',NULL),(2,1,'ssh指的是什么？','a','b','c','d','a',5,NULL,NULL,NULL),(3,1,'下面包含javase的特性是哪个？','我委屈委屈为企鹅全文而且委屈去 阿斯达阿达湿答答阿斯达阿斯达阿斯达阿斯达阿斯达阿萨阿萨阿斯达阿达啊阿达萨达实打实的阿斯达斯达到阿我委屈委屈为企鹅全文而且委屈去 阿斯达阿达湿答答阿斯达阿斯达阿斯达阿斯达阿斯达阿萨阿萨阿斯达阿达啊阿达萨达实打实的阿斯达斯达到阿萨我委屈委屈为企鹅全文而且委屈去 阿斯达阿达湿答答阿斯达阿斯达阿斯达阿斯达阿斯达阿萨阿萨阿斯达阿达啊阿达萨达实打实的阿斯达斯达到阿萨萨','b','c','d','a',5,NULL,NULL,NULL),(4,1,'下面包含javaee的特性是哪个？','a','b','c','d','a',5,NULL,NULL,NULL),(5,1,'下面包含java的特性是哪个？','a','b','c','d','a',5,NULL,NULL,NULL),(6,1,'xxxxxadas adadaa ?','a','b','c','d','a',5,NULL,NULL,NULL),(7,2,'测试数据问题？','a','b','c','d','a',5,NULL,NULL,NULL),(8,2,'测试数据问题？','a','b','c','d','a',5,NULL,NULL,NULL),(9,2,'测试数据问题？','a','b','c','d','a',5,NULL,NULL,NULL),(10,2,'测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？测试数据问题？','a','b','c','d','a',5,NULL,NULL,NULL),(11,2,'数据结构与算法好学吗?','好','弱智','很好','容易','a',5,NULL,NULL,NULL);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `stu_id` int(11) NOT NULL AUTO_INCREMENT,
  `stu_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '学号登陆密码',
  `stu_name` varchar(64) DEFAULT NULL,
  `stu_sex` char(2) DEFAULT NULL,
  `stu_password` varchar(64) NOT NULL,
  `stu_logintime` varchar(100) DEFAULT NULL,
  `major_id` int(11) NOT NULL,
  `stu_email` varchar(64) DEFAULT NULL,
  `test_flag` int(11) NOT NULL DEFAULT '0' COMMENT '0未测试完 1说明 测试完成了',
  `stu_comment` varchar(100) DEFAULT NULL COMMENT '备注',
  `stu_createtime` datetime DEFAULT NULL,
  `stu_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`stu_id`),
  UNIQUE KEY `stu_no` (`stu_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`stu_id`,`stu_no`,`stu_name`,`stu_sex`,`stu_password`,`stu_logintime`,`major_id`,`stu_email`,`test_flag`,`stu_comment`,`stu_createtime`,`stu_updatetime`) values (1,'001','ming','男','123','2018-03-04 14:32:14',1,'969130721',1,NULL,'2018-02-28 17:17:25','2018-03-04 14:32:14'),(2,'002','ming2','男','123','2018-03-01 23:35:13',1,'123',1,'123',NULL,'2018-03-04 13:41:29');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `teacher_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '教号登陆密码',
  `teacher_password` varchar(64) NOT NULL,
  `teacher_name` varchar(64) DEFAULT NULL,
  `teacher_sex` char(2) DEFAULT NULL,
  `limit_count` int(11) DEFAULT NULL,
  `teacher_email` varchar(64) DEFAULT NULL,
  `teacher_logintime` varchar(100) DEFAULT NULL,
  `teacher_comment` varchar(100) DEFAULT NULL,
  `teacher_createtime` datetime DEFAULT NULL,
  `teacher_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `teacher_no` (`teacher_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`teacher_id`,`course_id`,`teacher_no`,`teacher_password`,`teacher_name`,`teacher_sex`,`limit_count`,`teacher_email`,`teacher_logintime`,`teacher_comment`,`teacher_createtime`,`teacher_updatetime`) values (1,1,'201801','123','毕向东','男',49,'969103721@qq.com','2018-03-04 14:43:52',NULL,'2018-02-28 17:18:25','2018-03-04 14:43:52'),(2,2,'201802','123','小度','女',50,'969103721@qq.com','2018-03-04 14:44:24','','2018-03-04 14:11:26','2018-03-04 14:44:24');

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `test_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) DEFAULT NULL,
  `stu_id` int(11) DEFAULT NULL,
  `test_score` int(11) DEFAULT NULL,
  `test_date` varchar(64) DEFAULT NULL,
  `test_comment` varchar(100) DEFAULT NULL,
  `test_createtime` datetime DEFAULT NULL,
  `test_updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `test` */

insert  into `test`(`test_id`,`course_id`,`stu_id`,`test_score`,`test_date`,`test_comment`,`test_createtime`,`test_updatetime`) values (2,1,1,30,'2018-03-01 17:30:42',NULL,'2018-03-01 17:30:42',NULL),(3,2,1,25,'2018-03-01 17:33:35',NULL,'2018-03-01 17:33:35',NULL),(4,2,2,25,'2018-03-01 18:50:04',NULL,'2018-03-01 18:50:04',NULL),(5,1,2,30,'2018-03-01 18:50:37',NULL,'2018-03-01 18:50:37',NULL),(6,2,3,25,'2018-03-02 00:49:41',NULL,'2018-03-02 00:49:41',NULL),(7,1,3,30,'2018-03-02 00:50:08',NULL,'2018-03-02 00:50:08',NULL),(8,1,4,30,'2018-03-04 00:28:04',NULL,'2018-03-04 00:28:04',NULL),(9,2,4,25,'2018-03-04 00:28:27',NULL,'2018-03-04 00:28:27',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
