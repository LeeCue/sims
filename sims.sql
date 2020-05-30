/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : sims

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 30/05/2020 16:46:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for academy
-- ----------------------------
DROP TABLE IF EXISTS `academy`;
CREATE TABLE `academy`  (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '学院id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of academy
-- ----------------------------
INSERT INTO `academy` VALUES (10, '计算机科学与技术学院');
INSERT INTO `academy` VALUES (11, '机械学院');

-- ----------------------------
-- Table structure for academy_major
-- ----------------------------
DROP TABLE IF EXISTS `academy_major`;
CREATE TABLE `academy_major`  (
  `academyId` int(5) NOT NULL COMMENT '学院id',
  `majorId` int(5) NOT NULL COMMENT '专业id',
  UNIQUE INDEX `academy_major_idx`(`academyId`, `majorId`) USING BTREE,
  INDEX `academy_major_2`(`majorId`) USING BTREE,
  CONSTRAINT `academy_major_2` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `academy_major_ibfk_1` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of academy_major
-- ----------------------------
INSERT INTO `academy_major` VALUES (10, 10);
INSERT INTO `academy_major` VALUES (10, 11);
INSERT INTO `academy_major` VALUES (10, 12);
INSERT INTO `academy_major` VALUES (11, 13);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员账号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像url',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `phoneNum` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性签名',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTIme` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('123', '李四', 'https://cloud-img-1301075855.cos.ap-chengdu.myqcloud.com/sims/3811584871891418.jpg', '男', '12345678911', '哈哈哈哈哈哈哈', '2020-03-14 15:38:24', '2020-03-22 18:11:34');

-- ----------------------------
-- Table structure for announcement_type
-- ----------------------------
DROP TABLE IF EXISTS `announcement_type`;
CREATE TABLE `announcement_type`  (
  `id` int(4) NOT NULL COMMENT '公告类型id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement_type
-- ----------------------------

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班级信息',
  `count` int(5) NULL DEFAULT 0 COMMENT '班级人数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES (10, '1701', 1);
INSERT INTO `class` VALUES (11, '1702', 1);
INSERT INTO `class` VALUES (12, '1703', 0);
INSERT INTO `class` VALUES (13, '1701', 38);
INSERT INTO `class` VALUES (14, '1702', 0);
INSERT INTO `class` VALUES (15, '1703', 0);
INSERT INTO `class` VALUES (16, '1704', 1);
INSERT INTO `class` VALUES (17, '1701', 0);
INSERT INTO `class` VALUES (18, '1702', 0);
INSERT INTO `class` VALUES (19, '1703', 0);

-- ----------------------------
-- Table structure for class_course
-- ----------------------------
DROP TABLE IF EXISTS `class_course`;
CREATE TABLE `class_course`  (
  `classId` int(10) NOT NULL COMMENT '班级id',
  `courseId` int(10) NOT NULL COMMENT '课程id',
  UNIQUE INDEX `class_course_idx`(`classId`, `courseId`) USING BTREE,
  INDEX `class_course_ibfk_2`(`courseId`) USING BTREE,
  CONSTRAINT `class_course_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_course_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of class_course
-- ----------------------------

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int(10) NOT NULL COMMENT '课程id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名称',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '课程性质1代表必修，0代表选修',
  `credit` double(3, 2) NULL DEFAULT NULL COMMENT '学分',
  `period` int(3) NULL DEFAULT NULL COMMENT '课时',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------

-- ----------------------------
-- Table structure for course_exam
-- ----------------------------
DROP TABLE IF EXISTS `course_exam`;
CREATE TABLE `course_exam`  (
  `classId` int(10) NOT NULL COMMENT '班级id',
  `examId` int(10) NOT NULL COMMENT '考试信息id',
  UNIQUE INDEX `course_exam_idx`(`classId`, `examId`) USING BTREE,
  INDEX `course_exam_ibfk_2`(`examId`) USING BTREE,
  CONSTRAINT `course_exam_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_exam_ibfk_2` FOREIGN KEY (`examId`) REFERENCES `exam_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_exam
-- ----------------------------

-- ----------------------------
-- Table structure for course_time
-- ----------------------------
DROP TABLE IF EXISTS `course_time`;
CREATE TABLE `course_time`  (
  `id` int(10) NOT NULL COMMENT '课程时间id',
  `weekth` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '周次(单双)',
  `day` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '周内时间',
  `hour` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '具体上课时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_time
-- ----------------------------

-- ----------------------------
-- Table structure for course_to_time
-- ----------------------------
DROP TABLE IF EXISTS `course_to_time`;
CREATE TABLE `course_to_time`  (
  `courseId` int(10) NOT NULL COMMENT '课程id',
  `courseTimeId` int(10) NOT NULL COMMENT '课程时间id',
  UNIQUE INDEX `course_to_time_idx`(`courseId`, `courseTimeId`) USING BTREE,
  INDEX `course_to_time_ibfk_2`(`courseTimeId`) USING BTREE,
  CONSTRAINT `course_to_time_ibfk_1` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_to_time_ibfk_2` FOREIGN KEY (`courseTimeId`) REFERENCES `course_time` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_to_time
-- ----------------------------

-- ----------------------------
-- Table structure for exam_info
-- ----------------------------
DROP TABLE IF EXISTS `exam_info`;
CREATE TABLE `exam_info`  (
  `id` int(10) NOT NULL COMMENT '考试信息id',
  `courseId` int(10) NOT NULL COMMENT '课程id',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '考试时间',
  `place` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考试地点',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_info_ibfk_1`(`courseId`) USING BTREE,
  CONSTRAINT `exam_info_ibfk_1` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_info
-- ----------------------------

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '专业id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (10, '软件工程');
INSERT INTO `major` VALUES (11, '计算机科学与技术');
INSERT INTO `major` VALUES (12, '网络工程');
INSERT INTO `major` VALUES (13, '机械与制造');

-- ----------------------------
-- Table structure for major_class
-- ----------------------------
DROP TABLE IF EXISTS `major_class`;
CREATE TABLE `major_class`  (
  `majorId` int(5) NOT NULL,
  `classId` int(10) NOT NULL,
  UNIQUE INDEX `major_class_idx`(`majorId`, `classId`) USING BTREE,
  INDEX `major_class_FK2`(`classId`) USING BTREE,
  CONSTRAINT `major_class_FK1` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `major_class_FK2` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of major_class
-- ----------------------------
INSERT INTO `major_class` VALUES (11, 10);
INSERT INTO `major_class` VALUES (11, 11);
INSERT INTO `major_class` VALUES (11, 12);
INSERT INTO `major_class` VALUES (10, 13);
INSERT INTO `major_class` VALUES (10, 14);
INSERT INTO `major_class` VALUES (10, 15);
INSERT INTO `major_class` VALUES (10, 16);
INSERT INTO `major_class` VALUES (12, 17);
INSERT INTO `major_class` VALUES (12, 18);
INSERT INTO `major_class` VALUES (12, 19);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `path` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应的前端路由',
  `component` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件名称',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '导航所对应的名称',
  `iconCls` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '导航前的图标',
  `metaId` int(4) NULL DEFAULT NULL COMMENT '对应的标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_ibfk_1`(`metaId`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`metaId`) REFERENCES `meta` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '', 'Index', '信息管理', 'el-icon-s-custom', 1);
INSERT INTO `menu` VALUES (2, '/personalInfo', 'PersonalInfoManage', '用户管理', NULL, 1);
INSERT INTO `menu` VALUES (3, '/teacherInfoManager', 'TeacherInfoManage', '教师信息管理', NULL, 1);
INSERT INTO `menu` VALUES (4, '', 'Index', '教务管理', 'el-icon-menu', 1);
INSERT INTO `menu` VALUES (6, '/publish', 'PublishBoard', '公告管理', NULL, 1);
INSERT INTO `menu` VALUES (7, '/courseManager', 'CourseManage', '课程管理', NULL, 1);
INSERT INTO `menu` VALUES (8, '', 'Index', '成绩管理', 'el-icon-menu', 1);
INSERT INTO `menu` VALUES (9, '/scoreInfo', 'ScoreInfo', '成绩信息', NULL, 1);
INSERT INTO `menu` VALUES (10, '/uploadScore', 'ScoreUpload', '成绩上传', NULL, 1);
INSERT INTO `menu` VALUES (11, '', 'Index', '更多应用', 'el-icon-more', 1);
INSERT INTO `menu` VALUES (12, '/center', 'Center', '个人中心', NULL, 1);
INSERT INTO `menu` VALUES (13, '/scoreArchieve', 'ScoreArchive', '成绩统计', NULL, 1);
INSERT INTO `menu` VALUES (14, '/studentInfoManage', 'StudentInfoManage', '学生信息管理', NULL, 1);
INSERT INTO `menu` VALUES (15, '', 'Index', '校园中心', 'el-icon-s-home', 1);
INSERT INTO `menu` VALUES (16, '/home', 'Home', '主页', NULL, 1);
INSERT INTO `menu` VALUES (17, '/academyManage', 'AcademyManage', '学院管理', NULL, 1);

-- ----------------------------
-- Table structure for meta
-- ----------------------------
DROP TABLE IF EXISTS `meta`;
CREATE TABLE `meta`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `keepAlive` tinyint(4) NOT NULL DEFAULT 0 COMMENT '保持连接',
  `requireAuth` tinyint(4) NOT NULL DEFAULT 1 COMMENT '要求必须登录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meta
-- ----------------------------
INSERT INTO `meta` VALUES (1, 1, 1);
INSERT INTO `meta` VALUES (2, 0, 1);
INSERT INTO `meta` VALUES (3, 1, 0);
INSERT INTO `meta` VALUES (4, 0, 0);

-- ----------------------------
-- Table structure for notice_board
-- ----------------------------
DROP TABLE IF EXISTS `notice_board`;
CREATE TABLE `notice_board`  (
  `id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `typeId` int(4) NOT NULL COMMENT '公告类型id',
  `adminId` bigint(15) NOT NULL COMMENT '管理员id',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` timestamp(0) NULL DEFAULT NULL COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notice_board_ibfk_1`(`typeId`) USING BTREE,
  INDEX `notice_board_ibfk_2`(`adminId`) USING BTREE,
  CONSTRAINT `notice_board_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `announcement_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notice_board_ibfk_2` FOREIGN KEY (`id`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice_board
-- ----------------------------

-- ----------------------------
-- Table structure for parent_menus
-- ----------------------------
DROP TABLE IF EXISTS `parent_menus`;
CREATE TABLE `parent_menus`  (
  `parentId` int(4) NOT NULL COMMENT '父菜单id',
  `childId` int(4) NOT NULL COMMENT '子菜单id',
  UNIQUE INDEX `parent_menu_idx`(`parentId`, `childId`) USING BTREE,
  INDEX `parent_menu_parentFK`(`parentId`) USING BTREE,
  INDEX `parent_menu_childFK`(`childId`) USING BTREE,
  CONSTRAINT `parent_menu_childFK` FOREIGN KEY (`childId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parent_menu_parentFK` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of parent_menus
-- ----------------------------
INSERT INTO `parent_menus` VALUES (1, 2);
INSERT INTO `parent_menus` VALUES (1, 3);
INSERT INTO `parent_menus` VALUES (1, 14);
INSERT INTO `parent_menus` VALUES (4, 6);
INSERT INTO `parent_menus` VALUES (4, 7);
INSERT INTO `parent_menus` VALUES (4, 17);
INSERT INTO `parent_menus` VALUES (8, 9);
INSERT INTO `parent_menus` VALUES (8, 10);
INSERT INTO `parent_menus` VALUES (8, 13);
INSERT INTO `parent_menus` VALUES (11, 12);
INSERT INTO `parent_menus` VALUES (15, 16);

-- ----------------------------
-- Table structure for persistent_logins
-- ----------------------------
DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins`  (
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `series` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_used` timestamp(0) NOT NULL,
  PRIMARY KEY (`series`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of persistent_logins
-- ----------------------------

-- ----------------------------
-- Table structure for registry
-- ----------------------------
DROP TABLE IF EXISTS `registry`;
CREATE TABLE `registry`  (
  `uid` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的唯一id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(4) NOT NULL COMMENT '用户的对应的身份',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `locked` tinyint(4) NOT NULL DEFAULT 0 COMMENT '锁定状态',
  `enabled` tinyint(4) NULL DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registry
-- ----------------------------
INSERT INTO `registry` VALUES ('123', '李四', 1, '$2a$10$wcb.jdsbu7vRm2n3eA43Bujsk0s7CEZOzJPw38.2On4y4fonOuKam', 0, 1);
INSERT INTO `registry` VALUES ('2010100106', '李四', 2, '$2a$10$tBAJt6HBw6np6dsBdK1PDumilOuUmbVPWsfDU./ms9av7zCd63FOa', 0, 1);
INSERT INTO `registry` VALUES ('2010100107', '李四', 2, '$2a$10$S/eJm3nBmW/rmIUD8QJn6.YvG3RUgmFw/zfmZWXo3lxXWLnB2Tb3S', 0, 1);
INSERT INTO `registry` VALUES ('2010100108', '李四', 2, '$2a$10$W8qF4EL.U05eQZiUswauROtt9uBjmbYrMj1bOkNwAYuPAAK9wsIFm', 0, 1);
INSERT INTO `registry` VALUES ('2010100109', '李四', 2, '$2a$10$DGOKrqf6s4fngL4Ma9AaCOVOHXxJk05zyTMmPgHmSy6I3QSzRqH8G', 0, 1);
INSERT INTO `registry` VALUES ('2010100110', '李四', 2, '$2a$10$ue7r/g3Eu4PbjkpXpTIJVeB0S8ubiHANbT4DTbx01nS57Mgmx/nr2', 0, 1);
INSERT INTO `registry` VALUES ('2010100111', '李四', 2, '$2a$10$oGGmzb6Yxh6SKzv71pb9dez0Aw0RazoreIylw9boWk2TAhMeKEJPi', 0, 1);
INSERT INTO `registry` VALUES ('2010100112', '李四', 2, '$2a$10$NBBPrLrr.UG3KStP2ferAOvQ6dCtbOiHaR7LwE.WTbVirUDGTGX/G', 0, 1);
INSERT INTO `registry` VALUES ('2010100113', '李四', 2, '$2a$10$ZYY827M1z3T.cH2bWcLAruZ/sq40OEWQ6oaBfeuIvwibsNB4hS3Vu', 0, 1);
INSERT INTO `registry` VALUES ('2010100114', '王五', 2, '$2a$10$X01xz5RFEukG3FEBC4jMPuBjkkwNspzioGdYObjoTtn5OYBjKgaoa', 0, 1);
INSERT INTO `registry` VALUES ('2010100115', '赵六', 2, '$2a$10$.3ng9VTf9e.wGyFyG17X0eYY4psN.0DE.zWxC7nypAZEhIyXa3w8W', 0, 1);
INSERT INTO `registry` VALUES ('2010100116', '李四', 2, '$2a$10$yKAfXKuvr/x8Vn2sJEePWuwHQQ.pbHMBGSGNsQcGnn7xgZXaWBAHy', 0, 1);
INSERT INTO `registry` VALUES ('2010100117', '李四', 2, '$2a$10$ittQu74oQZO5iEkslzSZnuJSNfLOLXnJhQI5oAip3QkfAxXWqitGa', 0, 1);
INSERT INTO `registry` VALUES ('2010100118', '李四', 2, '$2a$10$vYsUvH4YsTbLrQ4PffkIle6gYFD8JSPuktfqm9BSbr/v2Gat.04TC', 0, 1);
INSERT INTO `registry` VALUES ('2010100119', '李四', 2, '$2a$10$BHRqWvnE2NfC4FuWjSIB9.XtGfxBlsIQL.eFhcgCCTu5RV8Kt0Xq.', 0, 1);
INSERT INTO `registry` VALUES ('2010100120', '李四', 2, '$2a$10$/P8XBRYN9VTjmd6CSfOkTe/KeHbIHDs.W6suI95Pwgmb8kR05RxIS', 0, 1);
INSERT INTO `registry` VALUES ('2010100121', '李四', 2, '$2a$10$mCR8mU59vRGEBVBoIPI8/OC/HjSaYGsaPy0xnKDJ1pfh1c50bYX7e', 0, 1);
INSERT INTO `registry` VALUES ('2010100122', '李四', 2, '$2a$10$z4Y9ezxkvzWOTiZe/e9Ua..12wd0ogAl6WoFXJZ8rYkW9ZTgk00h.', 0, 1);
INSERT INTO `registry` VALUES ('2010100123', '李四', 2, '$2a$10$SsY8tT88YOLb4VlzC.bZiODc4jLyB2j344/O7bml9sYld1gRqnvJK', 0, 1);
INSERT INTO `registry` VALUES ('2010100124', '李四', 2, '$2a$10$YTjjyG5vLOYwzb8u5UKADucT/nAucczr.rBVQ9.tkOqshy4lCEuQ6', 0, 1);
INSERT INTO `registry` VALUES ('2010100125', '李四', 2, '$2a$10$XozR7rw7Ov.vhvMSD2MfY.fbEYoDc95Noh.xaw56s29Qw47VrhgsW', 0, 1);
INSERT INTO `registry` VALUES ('2010100126', '王五', 2, '$2a$10$oCoaMcciiSluqZsAmKITv.1yc5snD6SsuwIuodRIROJMg/PWYNcJC', 0, 1);
INSERT INTO `registry` VALUES ('2010100127', '赵六', 2, '$2a$10$FB1tIU3p022XMXDaZaWqr.0wydhPTLusOP4Txc4B25/quO3A1ZBGy', 0, 1);
INSERT INTO `registry` VALUES ('2010100128', '李四', 2, '$2a$10$yICYPR1Qrlktbw7jLu8NOecD.xjFWecD2BgwVNmk0uZ3TgmK57lJy', 0, 1);
INSERT INTO `registry` VALUES ('2010100129', '李四', 2, '$2a$10$HuRimjMFlEdq2ryH.G83NuDXHGyaSZgTrw6w9Dz571ithX47py3Ka', 0, 1);
INSERT INTO `registry` VALUES ('2010100130', '李四', 2, '$2a$10$i9iZqlG/QoFPAyluapObDeKE7.cPgBE2Z4VQPmCv25XQ8yEBc9K9C', 0, 1);
INSERT INTO `registry` VALUES ('2010100131', '李四', 2, '$2a$10$/SDAyCLfXHDtePD0FrbO/e6BmNls/GX3YC8MW0IHq4CA89ufOcOpC', 0, 1);
INSERT INTO `registry` VALUES ('2010100132', '李四', 2, '$2a$10$U6KJiJxY48qmcCl58wlEI.UgXsNoEqDxWy3uEx7fkGq9etiJUzjuW', 0, 1);
INSERT INTO `registry` VALUES ('2010100133', '李四', 2, '$2a$10$dLvrzcCbnSU7rTGBGedgN.wABNrubZbRc7DBHcV5559kS89q0xDtq', 0, 1);
INSERT INTO `registry` VALUES ('2010100134', '李四', 2, '$2a$10$LI8Sea.5OBpwP6hc0sQvJ.01O9wXlbmvmnMJcg.gxHUuunOp4fJH2', 0, 1);
INSERT INTO `registry` VALUES ('2010100135', '李四', 2, '$2a$10$Uo8UMeAEwe07VuO/lqjEm.KhYnkSLj2JKESVba/9n20Zmtt.8csK.', 0, 1);
INSERT INTO `registry` VALUES ('2010100136', '李四', 2, '$2a$10$CvqnVB2MVyOWCvRslyEu/.6CHkHeKunwUD2k7g45HMF1QUcTMrzhu', 0, 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `description` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_admin', '管理员');
INSERT INTO `role` VALUES (2, 'ROLE_teacher', '教师');
INSERT INTO `role` VALUES (3, 'ROLE_student', '学生');
INSERT INTO `role` VALUES (4, 'ROLE_user', '基础用户');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `id` bigint(25) NOT NULL COMMENT '成绩id',
  `sid` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学工号',
  `courseId` int(10) NULL DEFAULT NULL COMMENT '课程id',
  `grade` int(4) NULL DEFAULT NULL COMMENT '成绩',
  `argueFlag` tinyint(4) NULL DEFAULT NULL COMMENT '申请修改标志位',
  `reexam` tinyint(4) NULL DEFAULT NULL COMMENT '补考标志位',
  `retake` tinyint(4) NULL DEFAULT NULL COMMENT '重修标志位',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `score_ibfk_2`(`courseId`) USING BTREE,
  INDEX `socre_ibfk_1`(`sid`) USING BTREE,
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `socre_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学工号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `nation` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '民族',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别\r\n',
  `age` int(4) NULL DEFAULT NULL COMMENT '年龄',
  `politicsStatus` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `idCard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份账号',
  `phoneNum` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像url',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性签名',
  `classId` int(10) NULL DEFAULT NULL COMMENT '班级id',
  `academyId` int(5) NULL DEFAULT NULL COMMENT '学院id',
  `majorId` int(5) NULL DEFAULT NULL COMMENT '专业id',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '入学时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `student_ibfk_1`(`classId`) USING BTREE,
  INDEX `student_ibfk_2`(`academyId`) USING BTREE,
  INDEX `student_ibfk_3`(`majorId`) USING BTREE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_3` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2010100106', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 11, 10, 11, '2020-12-01 08:00:00', '2020-05-30 14:08:09');
INSERT INTO `student` VALUES ('2010100107', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 14:59:54');
INSERT INTO `student` VALUES ('2010100108', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 14:59:54');
INSERT INTO `student` VALUES ('2010100109', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 14:59:54');
INSERT INTO `student` VALUES ('2010100110', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 14:59:54');
INSERT INTO `student` VALUES ('2010100111', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 14:59:54');
INSERT INTO `student` VALUES ('2010100112', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 14:59:54');
INSERT INTO `student` VALUES ('2010100113', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100114', '王五', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100115', '赵六', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100116', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100117', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100118', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100119', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100120', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100121', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100122', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100123', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100124', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 15:02:10');
INSERT INTO `student` VALUES ('2010100125', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100126', '王五', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100127', '赵六', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100128', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100129', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100130', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100131', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100132', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100133', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100134', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100135', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010100136', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-02 00:00:00', '2020-05-24 19:37:30');
INSERT INTO `student` VALUES ('2010110101', '王五', NULL, '男', 23, NULL, '12312412312312321', NULL, '787504485@qq.com', '', '', 10, 10, 11, '2020-05-05 08:00:00', '2020-05-26 11:37:48');
INSERT INTO `student` VALUES ('2010110201', '王五', NULL, '男', 23, NULL, '12312412312312321', NULL, '787504485@qq.com', '', '', 11, 10, 11, '2020-05-05 08:00:00', '2020-05-26 11:21:52');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教工号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像url',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `idCard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `politilcsStatus` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `phoneNum` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性签名',
  `academyId` int(5) NULL DEFAULT NULL COMMENT '学院id',
  `majorId` int(5) NULL DEFAULT NULL COMMENT '专业id',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '入职时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_ibfk_1`(`academyId`) USING BTREE,
  INDEX `teacher_ibfk_2`(`majorId`) USING BTREE,
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------

-- ----------------------------
-- Table structure for teacher_course
-- ----------------------------
DROP TABLE IF EXISTS `teacher_course`;
CREATE TABLE `teacher_course`  (
  `teacherId` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师id',
  `courseId` int(10) NOT NULL COMMENT '课程id',
  UNIQUE INDEX `teacher_course_idx`(`teacherId`, `courseId`) USING BTREE,
  INDEX `teacher_course_ibfk_2`(`courseId`) USING BTREE,
  CONSTRAINT `teacher_course_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teacher_course_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher_course
-- ----------------------------

-- ----------------------------
-- Table structure for user_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu`  (
  `status` int(4) NOT NULL COMMENT '用户身份',
  `menuId` int(4) NOT NULL COMMENT '菜单id',
  UNIQUE INDEX `user_menu_idx`(`status`, `menuId`) USING BTREE,
  INDEX `user_menu_ibfk_1`(`menuId`) USING BTREE,
  CONSTRAINT `user_menu_ibfk_1` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES (1, 1);
INSERT INTO `user_menu` VALUES (1, 4);
INSERT INTO `user_menu` VALUES (1, 8);
INSERT INTO `user_menu` VALUES (1, 11);
INSERT INTO `user_menu` VALUES (2, 11);
INSERT INTO `user_menu` VALUES (1, 15);
INSERT INTO `user_menu` VALUES (2, 15);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `userId` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `roleId` int(4) NOT NULL COMMENT '角色id',
  UNIQUE INDEX `user_role_idx`(`userId`, `roleId`) USING BTREE,
  INDEX `user_role_ibfk_2`(`roleId`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `registry` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('123', 1);
INSERT INTO `user_role` VALUES ('2010100106', 3);
INSERT INTO `user_role` VALUES ('2010100107', 3);
INSERT INTO `user_role` VALUES ('2010100108', 3);
INSERT INTO `user_role` VALUES ('2010100109', 3);
INSERT INTO `user_role` VALUES ('2010100110', 3);
INSERT INTO `user_role` VALUES ('2010100111', 3);
INSERT INTO `user_role` VALUES ('2010100112', 3);
INSERT INTO `user_role` VALUES ('2010100113', 3);
INSERT INTO `user_role` VALUES ('2010100114', 3);
INSERT INTO `user_role` VALUES ('2010100115', 3);
INSERT INTO `user_role` VALUES ('2010100116', 3);
INSERT INTO `user_role` VALUES ('2010100117', 3);
INSERT INTO `user_role` VALUES ('2010100118', 3);
INSERT INTO `user_role` VALUES ('2010100119', 3);
INSERT INTO `user_role` VALUES ('2010100120', 3);
INSERT INTO `user_role` VALUES ('2010100121', 3);
INSERT INTO `user_role` VALUES ('2010100122', 3);
INSERT INTO `user_role` VALUES ('2010100123', 3);
INSERT INTO `user_role` VALUES ('2010100124', 3);
INSERT INTO `user_role` VALUES ('2010100125', 3);
INSERT INTO `user_role` VALUES ('2010100126', 3);
INSERT INTO `user_role` VALUES ('2010100127', 3);
INSERT INTO `user_role` VALUES ('2010100128', 3);
INSERT INTO `user_role` VALUES ('2010100129', 3);
INSERT INTO `user_role` VALUES ('2010100130', 3);
INSERT INTO `user_role` VALUES ('2010100131', 3);
INSERT INTO `user_role` VALUES ('2010100132', 3);
INSERT INTO `user_role` VALUES ('2010100133', 3);
INSERT INTO `user_role` VALUES ('2010100134', 3);
INSERT INTO `user_role` VALUES ('2010100135', 3);
INSERT INTO `user_role` VALUES ('2010100136', 3);
INSERT INTO `user_role` VALUES ('123', 4);
INSERT INTO `user_role` VALUES ('2010100106', 4);
INSERT INTO `user_role` VALUES ('2010100107', 4);
INSERT INTO `user_role` VALUES ('2010100108', 4);
INSERT INTO `user_role` VALUES ('2010100109', 4);
INSERT INTO `user_role` VALUES ('2010100110', 4);
INSERT INTO `user_role` VALUES ('2010100111', 4);
INSERT INTO `user_role` VALUES ('2010100112', 4);
INSERT INTO `user_role` VALUES ('2010100113', 4);
INSERT INTO `user_role` VALUES ('2010100114', 4);
INSERT INTO `user_role` VALUES ('2010100115', 4);
INSERT INTO `user_role` VALUES ('2010100116', 4);
INSERT INTO `user_role` VALUES ('2010100117', 4);
INSERT INTO `user_role` VALUES ('2010100118', 4);
INSERT INTO `user_role` VALUES ('2010100119', 4);
INSERT INTO `user_role` VALUES ('2010100120', 4);
INSERT INTO `user_role` VALUES ('2010100121', 4);
INSERT INTO `user_role` VALUES ('2010100122', 4);
INSERT INTO `user_role` VALUES ('2010100123', 4);
INSERT INTO `user_role` VALUES ('2010100124', 4);
INSERT INTO `user_role` VALUES ('2010100125', 4);
INSERT INTO `user_role` VALUES ('2010100126', 4);
INSERT INTO `user_role` VALUES ('2010100127', 4);
INSERT INTO `user_role` VALUES ('2010100128', 4);
INSERT INTO `user_role` VALUES ('2010100129', 4);
INSERT INTO `user_role` VALUES ('2010100130', 4);
INSERT INTO `user_role` VALUES ('2010100131', 4);
INSERT INTO `user_role` VALUES ('2010100132', 4);
INSERT INTO `user_role` VALUES ('2010100133', 4);
INSERT INTO `user_role` VALUES ('2010100134', 4);
INSERT INTO `user_role` VALUES ('2010100135', 4);
INSERT INTO `user_role` VALUES ('2010100136', 4);

SET FOREIGN_KEY_CHECKS = 1;
