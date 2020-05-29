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

 Date: 29/05/2020 17:33:07
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
-- Table structure for announcement_type
-- ----------------------------
DROP TABLE IF EXISTS `announcement_type`;
CREATE TABLE `announcement_type`  (
  `id` int(4) NOT NULL COMMENT '公告类型id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '专业id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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

SET FOREIGN_KEY_CHECKS = 1;
