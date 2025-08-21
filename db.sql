-- phpMyAdmin SQL Dump (แก้ไขแล้ว)
-- version 5.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `project_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `project_db`;

-- ---------------------------
-- Table: user
-- ---------------------------
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `decryption` varchar(255) NOT NULL,
  `line_id` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------------------------
-- Table: student
-- ---------------------------
CREATE TABLE `student` (
  `std_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `std_name` varchar(30) NOT NULL,
  `std_lastname` varchar(30) NOT NULL,
  `std_year` int(2) UNSIGNED NOT NULL,
  `std_gpa` decimal(3,2) NOT NULL,
  `std_income` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`std_id`),
  KEY `User_id` (`user_id`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: qualification
-- ---------------------------
CREATE TABLE `qualification` (
  `qua_id` int(11) NOT NULL AUTO_INCREMENT,
  `std_year` int(1) NOT NULL,
  `std_gpa` decimal(3,2) NOT NULL,
  `std_income` int(11) NOT NULL,
  PRIMARY KEY (`qua_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: scholarship_info
-- ---------------------------
CREATE TABLE `scholarship_info` (
  `scholarship_id` int(11) NOT NULL AUTO_INCREMENT,
  `scho_name` varchar(50) NOT NULL,
  `scho_year` int(1) NOT NULL,
  `qualification` int(11) NOT NULL,
  `scho_type` varchar(20) NOT NULL,
  `scho_source` varchar(20) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `scho_desp` varchar(50) NOT NULL,
  `scho_file` varchar(500) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`scholarship_id`),
  KEY `qualification` (`qualification`),
  CONSTRAINT `fk_scho_qua` FOREIGN KEY (`qualification`) REFERENCES `qualification` (`qua_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: enroll
-- ---------------------------
CREATE TABLE `enroll` (
  `enroll_id` int(11) NOT NULL AUTO_INCREMENT,
  `std_id` int(11) NOT NULL,
  `scho_id` int(11) NOT NULL,
  `qua_id` int(11) NOT NULL,
  `enroll_status` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`enroll_id`),
  KEY `std_id` (`std_id`),
  KEY `scho_id` (`scho_id`),
  KEY `qua_id` (`qua_id`),
  CONSTRAINT `enroll_ibfk_3` FOREIGN KEY (`scho_id`) REFERENCES `scholarship_info` (`scholarship_id`) ON UPDATE CASCADE,
  CONSTRAINT `qua_id` FOREIGN KEY (`qua_id`) REFERENCES `qualification` (`qua_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `std_id` FOREIGN KEY (`std_id`) REFERENCES `student` (`std_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: bookmark
-- ---------------------------
CREATE TABLE `bookmark` (
  `bookmark_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `scho_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`bookmark_id`),
  KEY `Student_id` (`student_id`),
  KEY `scho_id` (`scho_id`),
  CONSTRAINT `bookmark_std` FOREIGN KEY (`student_id`) REFERENCES `student` (`std_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `scho_id` FOREIGN KEY (`scho_id`) REFERENCES `scholarship_info` (`scholarship_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: admin
-- ---------------------------
CREATE TABLE `admin` (
  `Admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `adm_name` varchar(50) NOT NULL,
  `adm_lastname` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Admin_id`),
  KEY `User_id` (`user_id`),
  CONSTRAINT `admin_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: admin_message
-- ---------------------------
CREATE TABLE `admin_message` (
  `adm_mes_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `mes_title` varchar(255) NOT NULL,
  `mes_desp` varchar(225) NOT NULL,
  `mes_status` varchar(225) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`adm_mes_id`),
  KEY `admin_id` (`admin_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `admin_message_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`Admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: admin_notification
-- ---------------------------
CREATE TABLE `admin_notification` (
  `adm_noti_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `noti_type` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`adm_noti_id`),
  KEY `admin_id` (`admin_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `admin_notification_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`Admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admin_notification_ibfk_3` FOREIGN KEY (`student_id`) REFERENCES `student` (`std_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: dashboard
-- ---------------------------
CREATE TABLE `dashboard` (
  `dab_id` int(11) NOT NULL AUTO_INCREMENT,
  `std_id` int(11) NOT NULL,
  `scho_id` int(11) NOT NULL,
  `enroll_id` int(11) NOT NULL,
  `std_all_total` int(100) NOT NULL,
  `std_1_total` int(100) NOT NULL,
  `std_2_total` int(100) NOT NULL,
  `std_3_total` int(100) NOT NULL,
  `std_4_total` int(100) NOT NULL,
  `std_no_scho` int(100) NOT NULL,
  `rate` decimal(3,2) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dab_id`),
  KEY `std_id` (`std_id`),
  KEY `scho_id` (`scho_id`),
  KEY `enroll_id` (`enroll_id`),
  CONSTRAINT `dashboard_ibfk_2` FOREIGN KEY (`std_id`) REFERENCES `student` (`std_id`) ON UPDATE CASCADE,
  CONSTRAINT `dashboard_ibfk_3` FOREIGN KEY (`scho_id`) REFERENCES `scholarship_info` (`scholarship_id`) ON UPDATE CASCADE,
  CONSTRAINT `enroll` FOREIGN KEY (`enroll_id`) REFERENCES `enroll` (`enroll_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: std_notification
-- ---------------------------
CREATE TABLE `std_notification` (
  `std_noti_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `std_noti_type` varchar(30) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`std_noti_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `std_notification_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`std_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------
-- Table: user_session
-- ---------------------------
CREATE TABLE `user_session` (
  `user_id` int(11) NOT NULL,
  `token` varchar(225) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
