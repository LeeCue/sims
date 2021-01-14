/*
 Navicat Premium Data Transfer

 Source Server         : local_mysql
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : sims

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 10/01/2021 20:36:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for academy
-- ----------------------------
DROP TABLE IF EXISTS `academy`;
CREATE TABLE `academy`  (
  `selectFlag` tinyint NULL DEFAULT NULL COMMENT '选课标志位',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '学院id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of academy
-- ----------------------------
INSERT INTO `academy` VALUES (1, 10, '计算机科学与技术学院');
INSERT INTO `academy` VALUES (1, 11, '机械学院');

-- ----------------------------
-- Table structure for academy_major
-- ----------------------------
DROP TABLE IF EXISTS `academy_major`;
CREATE TABLE `academy_major`  (
  `academyId` int NOT NULL COMMENT '学院id',
  `majorId` int NOT NULL COMMENT '专业id',
  UNIQUE INDEX `academy_major_idx`(`academyId`, `majorId`) USING BTREE,
  INDEX `academy_major_2`(`majorId`) USING BTREE,
  CONSTRAINT `academy_major_2` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `academy_major_ibfk_1` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('123', 'LeeCue', 'https://cloud-img-1301075855.cos.ap-chengdu.myqcloud.com/sims/5081590838134141.jpg', '男', '12345678911', '哈哈哈哈哈哈哈', '2020-03-14 15:38:24', '2020-05-30 19:34:35');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班级信息',
  `count` int NULL DEFAULT 0 COMMENT '班级人数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES (10, '1701', 2);
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
  `classId` int NOT NULL COMMENT '班级id',
  `courseId` int NOT NULL COMMENT '课程id',
  UNIQUE INDEX `class_course_idx`(`classId`, `courseId`) USING BTREE,
  INDEX `class_course_ibfk_2`(`courseId`) USING BTREE,
  CONSTRAINT `class_course_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_course_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of class_course
-- ----------------------------

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '课程id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名称',
  `status` tinyint NULL DEFAULT NULL COMMENT '课程性质1代表必修，0代表选修',
  `credit` double(3, 2) NULL DEFAULT NULL COMMENT '学分',
  `period` int NULL DEFAULT NULL COMMENT '课时',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  `academyId` int NULL DEFAULT NULL COMMENT '学院id',
  `teacherId` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教师id',
  `total` int NULL DEFAULT NULL COMMENT '课程人数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `academy_course`(`academyId`) USING BTREE,
  INDEX `teacher_course`(`teacherId`) USING BTREE,
  CONSTRAINT `academy_course` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (2, '测试', 1, 1.00, 2, '2021-01-10 11:24:23', '2021-01-10 11:24:23', 10, '', NULL);
INSERT INTO `course` VALUES (3, '测试1', 3, 2.00, 12, '2021-01-10 19:55:36', '2021-01-10 19:55:36', 10, '1312', 90);

-- ----------------------------
-- Table structure for course_exam
-- ----------------------------
DROP TABLE IF EXISTS `course_exam`;
CREATE TABLE `course_exam`  (
  `classId` int NOT NULL COMMENT '班级id',
  `examId` int NOT NULL COMMENT '考试信息id',
  UNIQUE INDEX `course_exam_idx`(`classId`, `examId`) USING BTREE,
  INDEX `course_exam_ibfk_2`(`examId`) USING BTREE,
  CONSTRAINT `course_exam_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_exam_ibfk_2` FOREIGN KEY (`examId`) REFERENCES `exam_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_exam
-- ----------------------------

-- ----------------------------
-- Table structure for course_time
-- ----------------------------
DROP TABLE IF EXISTS `course_time`;
CREATE TABLE `course_time`  (
  `id` int NOT NULL COMMENT '课程时间id',
  `weekth` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '周次(单双)',
  `day` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '周内时间',
  `hour` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '具体上课时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_time
-- ----------------------------

-- ----------------------------
-- Table structure for course_to_time
-- ----------------------------
DROP TABLE IF EXISTS `course_to_time`;
CREATE TABLE `course_to_time`  (
  `courseId` int NOT NULL COMMENT '课程id',
  `courseTimeId` int NOT NULL COMMENT '课程时间id',
  UNIQUE INDEX `course_to_time_idx`(`courseId`, `courseTimeId`) USING BTREE,
  INDEX `course_to_time_ibfk_2`(`courseTimeId`) USING BTREE,
  CONSTRAINT `course_to_time_ibfk_2` FOREIGN KEY (`courseTimeId`) REFERENCES `course_time` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_to_time_ibfk_1` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_to_time
-- ----------------------------

-- ----------------------------
-- Table structure for exam_info
-- ----------------------------
DROP TABLE IF EXISTS `exam_info`;
CREATE TABLE `exam_info`  (
  `id` int NOT NULL COMMENT '考试信息id',
  `courseId` int NOT NULL COMMENT '课程id',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '考试时间',
  `place` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考试地点',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_info_ibfk_1`(`courseId`) USING BTREE,
  CONSTRAINT `exam_info_ibfk_1` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exam_info
-- ----------------------------

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '专业id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `majorId` int NOT NULL,
  `classId` int NOT NULL,
  UNIQUE INDEX `major_class_idx`(`majorId`, `classId`) USING BTREE,
  INDEX `major_class_FK2`(`classId`) USING BTREE,
  CONSTRAINT `major_class_FK1` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `major_class_FK2` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `id` int NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `path` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应的前端路由',
  `component` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件名称',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '导航所对应的名称',
  `iconCls` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '导航前的图标',
  `metaId` int NULL DEFAULT NULL COMMENT '对应的标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_ibfk_1`(`metaId`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`metaId`) REFERENCES `meta` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `menu` VALUES (18, '', 'Index', '个人信息', 'el-icon-s-custom', 1);
INSERT INTO `menu` VALUES (19, '/studentInfo', 'StudentInfo', '信息查询', NULL, 1);
INSERT INTO `menu` VALUES (20, '', 'Index', '选课', 'el-icon-star-on\r\n', 1);
INSERT INTO `menu` VALUES (21, '/selectCourse', 'SelectCourse', '学生选课', NULL, 1);

-- ----------------------------
-- Table structure for meta
-- ----------------------------
DROP TABLE IF EXISTS `meta`;
CREATE TABLE `meta`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `keepAlive` tinyint NOT NULL DEFAULT 0 COMMENT '保持连接',
  `requireAuth` tinyint NOT NULL DEFAULT 1 COMMENT '要求必须登录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `published` tinyint NULL DEFAULT NULL COMMENT '发布状态',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型名称',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice_board
-- ----------------------------
INSERT INTO `notice_board` VALUES (1, '选课通知1', 1, '<div><h1 style=\"text-align: center;\">关于2019-2020学年第二学期网络公选课选课与学习的通知</h1></div><div><p></p><div><p>各学院：</p><p>为确保“新冠肺炎”疫情防控期间 “停课不停学、学习不延期”，本学期网络公选课现开始选课，我校开设的网络公选课包括两类：①尔雅通识课；②智慧树网课。现将学生选课及课程学习有关事项通知如下：</p><p><strong>一、</strong><strong>选课</strong><strong>对象</strong></p><p>全校本科生。</p><p><strong>二、</strong><strong>选课</strong><strong>时间</strong></p><p>2020年3月2日10:00—2020年3月5日22:00。</p><p><strong>三</strong><strong>、选课</strong><strong>及学习</strong><strong>方法</strong></p><p>本次网络公选课采用自主选课模式，请学生登录对应的学习平台进行选课学习：</p><p>1.尔雅通识课：学生登录“西安科技大学网络教学平台”（http://study.xust.edu.cn/portal）或者学习通APP进行选课学习（具体操作流程见附件1）。</p><p>2.智慧树网课：学生登录“西安科技大学智慧树网课平台”（http://portals.zhihuishu.com/xust）或者知到APP进行选课学习（具体操作流程见附件2）。</p><p><strong>四</strong><strong>、学习时间安排</strong></p><p>学习时间为3月9日至5月17日，时间截止后将停止所有课程的线上教学活动，并组织线上考试（线上考试时间为5月18日至5月31日）。</p><p><strong>五</strong><strong>、成绩评定</strong></p><p>1.学生完成所有在线学习、测试、讨论互动及考试等环节，且总评成绩达到60分，可获得该课程的学分，所获学分纳入公选课学分。</p><p>2.每门网络课程的学分均按照1.0学分认定，<strong>2016级</strong><strong>学生选课门次</strong><strong>及学分</strong><strong>不受限制</strong><strong>（按公选课毕业要求学分选够为止）</strong>，其他年级每学期最多累计2.0个公选课学分（与学校开设的公选课学分不冲突），超过部分不计学分。</p><p><strong>六</strong><strong>、其他注意事项</strong></p><p><span style=\"color: rgb(194, 79, 74);\">1.本次公选课选课为2016级学生最后一次选课机会，请未修够公选课学分的2016级学生务必按要求选课，以免影响正常毕业。</span></p><p>2.考核合格并认定学分的课程，学生可在本学期末通过教务管理系统进行成绩查询。</p><p>3.严禁使用破解、快进等软件进行学习，一经发现存在刷课、快进、拖拽等任何不良记录，<strong>学校将按照按照教学及考试相关规定按违纪</strong><strong>处理</strong><strong>，同时</strong><strong>该门成绩按不合格</strong>。</p><p>4.为保证网络课程的有效实施，请各学院督促学生合理安排学习时间，按时完成各环节学习内容。</p></div></div>', '教务通知公告', '2020-06-08 13:24:00', '2020-06-08 18:25:47');
INSERT INTO `notice_board` VALUES (3, '哈哈哈哈哈2', 1, '<p>测试</p>', '教务通知公告', '2020-06-11 16:48:09', '2020-06-06 16:48:14');
INSERT INTO `notice_board` VALUES (4, '哈哈哈哈哈4', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:48:52', '2020-06-08 16:48:52');
INSERT INTO `notice_board` VALUES (5, '哈哈哈哈哈5', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:48:55', '2020-06-08 16:48:55');
INSERT INTO `notice_board` VALUES (6, '哈哈哈哈哈6', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:48:58', '2020-06-08 16:48:58');
INSERT INTO `notice_board` VALUES (7, '哈哈哈哈哈7', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:49:01', '2020-06-08 16:49:01');
INSERT INTO `notice_board` VALUES (8, '哈哈哈哈哈8', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:49:03', '2020-06-08 16:49:03');
INSERT INTO `notice_board` VALUES (9, '哈哈哈哈哈9', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:49:06', '2020-06-08 16:49:06');
INSERT INTO `notice_board` VALUES (10, '哈哈哈哈哈10', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:49:09', '2020-06-08 16:49:09');
INSERT INTO `notice_board` VALUES (11, '哈哈哈哈哈11', 1, '<p>测试</p>', '教务通知公告', '2020-06-08 16:49:24', '2020-06-08 16:49:24');

-- ----------------------------
-- Table structure for parent_menus
-- ----------------------------
DROP TABLE IF EXISTS `parent_menus`;
CREATE TABLE `parent_menus`  (
  `parentId` int NOT NULL COMMENT '父菜单id',
  `childId` int NOT NULL COMMENT '子菜单id',
  UNIQUE INDEX `parent_menu_idx`(`parentId`, `childId`) USING BTREE,
  INDEX `parent_menu_parentFK`(`parentId`) USING BTREE,
  INDEX `parent_menu_childFK`(`childId`) USING BTREE,
  CONSTRAINT `parent_menu_childFK` FOREIGN KEY (`childId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parent_menu_parentFK` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `parent_menus` VALUES (18, 19);
INSERT INTO `parent_menus` VALUES (20, 21);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of persistent_logins
-- ----------------------------
INSERT INTO `persistent_logins` VALUES ('2010100108', '9Rk44rnNIdfdRTxVnve3TA==', 'AzK8qFexO1eUt+Uh5PhDeA==', '2021-01-10 20:34:27');

-- ----------------------------
-- Table structure for registry
-- ----------------------------
DROP TABLE IF EXISTS `registry`;
CREATE TABLE `registry`  (
  `uid` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的唯一id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL COMMENT '用户的对应的身份',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `locked` tinyint NOT NULL DEFAULT 0 COMMENT '锁定状态',
  `enabled` tinyint NULL DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of registry
-- ----------------------------
INSERT INTO `registry` VALUES ('123', 'LeeCue', 1, '$2a$10$wcb.jdsbu7vRm2n3eA43Bujsk0s7CEZOzJPw38.2On4y4fonOuKam', 0, 1);
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
INSERT INTO `registry` VALUES ('2010110102', '杨强', 2, '$2a$10$3vsEG3NYwwAjC/BxayFEjeVMep5tvt04qbWRF4UfkLJyDa8zJSifK', 0, 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `description` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `id` bigint NOT NULL COMMENT '成绩id',
  `sid` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学工号',
  `courseId` int NULL DEFAULT NULL COMMENT '课程id',
  `grade` int NULL DEFAULT NULL COMMENT '成绩',
  `argueFlag` tinyint NULL DEFAULT NULL COMMENT '申请修改标志位',
  `reexam` tinyint NULL DEFAULT NULL COMMENT '补考标志位',
  `retake` tinyint NULL DEFAULT NULL COMMENT '重修标志位',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `score_ibfk_2`(`courseId`) USING BTREE,
  INDEX `socre_ibfk_1`(`sid`) USING BTREE,
  CONSTRAINT `socre_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `politicsStatus` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `idCard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份账号',
  `phoneNum` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像url',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '个性签名',
  `classId` int NULL DEFAULT NULL COMMENT '班级id',
  `academyId` int NULL DEFAULT NULL COMMENT '学院id',
  `majorId` int NULL DEFAULT NULL COMMENT '专业id',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '入学时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `student_ibfk_1`(`classId`) USING BTREE,
  INDEX `student_ibfk_2`(`academyId`) USING BTREE,
  INDEX `student_ibfk_3`(`majorId`) USING BTREE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_3` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2010100108', '李四', '汉', '男', 20, '共青团员', '123872764129746000', '12324231242', '787504485@qq.com', '', '', 13, 10, 10, '2020-12-01 08:00:00', '2020-05-31 15:40:49');
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
INSERT INTO `student` VALUES ('2010110102', '杨强', NULL, '男', 23, NULL, '23123123124123123', NULL, '787504485@qq.com', '', '', 10, 10, 11, '2020-05-06 08:00:00', '2020-05-31 20:42:27');
INSERT INTO `student` VALUES ('2010110201', '王五', NULL, '男', 23, NULL, '12312412312312321', NULL, '787504485@qq.com', '', '', 11, 10, 11, '2020-05-05 08:00:00', '2020-05-26 11:21:52');

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
  `studentId` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学生学号',
  `courseId` int NOT NULL COMMENT '课程学号',
  PRIMARY KEY (`studentId`, `courseId`) USING BTREE,
  INDEX `student_course_2`(`courseId`) USING BTREE,
  CONSTRAINT `student_course_1` FOREIGN KEY (`studentId`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_course_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_course
-- ----------------------------

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
  `academyId` int NULL DEFAULT NULL COMMENT '学院id',
  `majorId` int NULL DEFAULT NULL COMMENT '专业id',
  `createTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '入职时间',
  `updateTime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_ibfk_1`(`academyId`) USING BTREE,
  INDEX `teacher_ibfk_2`(`majorId`) USING BTREE,
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`academyId`) REFERENCES `academy` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`majorId`) REFERENCES `major` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1312', '张三', '', '男', '277128129362912873', '中共党员', '212837182738', '21327256@qq,com', '哈哈哈哈', 10, 10, '2021-01-10 11:27:41', '2021-01-10 11:27:41');

-- ----------------------------
-- Table structure for teacher_course
-- ----------------------------
DROP TABLE IF EXISTS `teacher_course`;
CREATE TABLE `teacher_course`  (
  `teacherId` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师id',
  `courseId` int NOT NULL COMMENT '课程id',
  `classId` int NOT NULL COMMENT '班级id',
  UNIQUE INDEX `teacher_course_idx`(`teacherId`, `courseId`) USING BTREE,
  INDEX `teacher_course_ibfk_2`(`courseId`) USING BTREE,
  INDEX `teacher_course_ibfk_32`(`classId`) USING BTREE,
  CONSTRAINT `teacher_course_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teacher_course_ibfk` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teacher_course_ibfk_32` FOREIGN KEY (`classId`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher_course
-- ----------------------------

-- ----------------------------
-- Table structure for user_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu`  (
  `status` int NOT NULL COMMENT '用户身份',
  `menuId` int NOT NULL COMMENT '菜单id',
  UNIQUE INDEX `user_menu_idx`(`status`, `menuId`) USING BTREE,
  INDEX `user_menu_ibfk_1`(`menuId`) USING BTREE,
  CONSTRAINT `user_menu_ibfk_1` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `user_menu` VALUES (2, 18);
INSERT INTO `user_menu` VALUES (2, 20);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `userId` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `roleId` int NOT NULL COMMENT '角色id',
  UNIQUE INDEX `user_role_idx`(`userId`, `roleId`) USING BTREE,
  INDEX `user_role_ibfk_2`(`roleId`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `registry` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('123', 1);
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
INSERT INTO `user_role` VALUES ('2010110102', 3);
INSERT INTO `user_role` VALUES ('123', 4);
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
INSERT INTO `user_role` VALUES ('2010110102', 4);

SET FOREIGN_KEY_CHECKS = 1;
