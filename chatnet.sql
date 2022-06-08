-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 23, 2022 at 10:06 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chatnet`
--

-- --------------------------------------------------------

--
-- Table structure for table `cn_chatbot`
--

CREATE TABLE `cn_chatbot` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `keyword` text NOT NULL,
  `reply` text NOT NULL,
  `is_detect_keyword` tinyint(4) NOT NULL DEFAULT 1,
  `is_matching_word` tinyint(4) NOT NULL DEFAULT 0,
  `is_global` tinyint(4) NOT NULL DEFAULT 0,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cn_chatbot`
--

INSERT INTO `cn_chatbot` (`id`, `user_id`, `keyword`, `reply`, `is_detect_keyword`, `is_matching_word`, `is_global`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'help,support', 'This is testing data', 1, 1, 0, 1, '2022-03-22 11:39:39', '2022-03-22 11:39:39'),
(2, 1, 'Testing,Test', 'This is testing data', 1, 0, 0, 1, '2022-03-22 11:40:13', '2022-03-22 11:40:13'),
(3, 1, 'friend,google,chocolate', 'This is testing data', 1, 0, 1, 2, '2022-03-22 11:40:50', '2022-03-22 11:40:50'),
(4, 2, 'help, support', 'How i can help you?', 1, 1, 1, 1, '2022-03-22 13:34:33', '2022-03-22 13:34:33'),
(5, 2, 'Issues', 'What is the issues you are facing?', 1, 1, 0, 1, '2022-03-22 14:02:14', '2022-03-22 14:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `cn_chat_groups`
--

CREATE TABLE `cn_chat_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chat_room` int(11) NOT NULL,
  `cover_image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_protected` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'True = 1, False = 0',
  `password` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT 'ACTIVE = 1, INACTIVE = 2',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_chat_groups`
--

INSERT INTO `cn_chat_groups` (`id`, `name`, `chat_room`, `cover_image`, `is_protected`, `password`, `slug`, `status`, `created_by`, `created_at`) VALUES
(1, 'General', 1, NULL, 0, NULL, 'general', 1, 1, '2022-03-22 11:22:17');

-- --------------------------------------------------------

--
-- Table structure for table `cn_chat_interactions`
--

CREATE TABLE `cn_chat_interactions` (
  `id` int(11) NOT NULL,
  `chat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `chat_type` smallint(6) NOT NULL DEFAULT 1 COMMENT 'Private Chat = 1, Group Chat = 2 ',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `is_notified` tinyint(1) NOT NULL DEFAULT 0,
  `is_starred` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `notified_at` datetime DEFAULT NULL,
  `starred_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_chat_interactions`
--

INSERT INTO `cn_chat_interactions` (`id`, `chat_id`, `user_id`, `chat_type`, `is_read`, `is_notified`, `is_starred`, `is_deleted`, `read_at`, `notified_at`, `starred_at`, `deleted_at`) VALUES
(1, 1, 2, 2, 1, 0, 0, 0, '2022-03-22 11:34:04', NULL, NULL, NULL),
(2, 2, 2, 2, 1, 0, 0, 0, '2022-03-22 11:34:04', NULL, NULL, NULL),
(3, 3, 1, 2, 1, 0, 0, 0, '2022-03-22 11:51:03', NULL, NULL, NULL),
(4, 1, 1, 1, 1, 1, 0, 0, '2022-03-22 11:52:44', '2022-03-22 11:52:44', NULL, NULL),
(5, 2, 2, 1, 1, 1, 0, 0, '2022-03-22 12:00:02', '2022-03-22 12:00:02', NULL, NULL),
(6, 3, 1, 1, 1, 1, 0, 0, '2022-03-23 13:17:15', '2022-03-23 13:17:15', NULL, NULL),
(7, 4, 1, 1, 1, 1, 0, 0, '2022-03-23 13:17:15', '2022-03-23 13:17:15', NULL, NULL),
(8, 4, 2, 2, 1, 1, 0, 0, '2022-03-23 13:16:42', '2022-03-23 13:16:33', NULL, NULL),
(9, 5, 2, 2, 1, 0, 0, 0, '2022-03-23 13:21:42', NULL, NULL, NULL),
(10, 5, 2, 1, 1, 1, 0, 0, '2022-03-23 13:35:03', '2022-03-23 13:35:03', NULL, NULL),
(11, 6, 1, 2, 1, 1, 0, 0, '2022-03-23 13:59:39', '2022-03-23 13:35:03', NULL, NULL),
(12, 6, 2, 1, 1, 1, 0, 0, '2022-03-23 14:14:59', '2022-03-23 14:14:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cn_chat_rooms`
--

CREATE TABLE `cn_chat_rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_notice_message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_notice_class` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_protected` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'True = 1, False = 0',
  `password` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'True = 1, False = 0',
  `chat_validity` int(11) DEFAULT NULL COMMENT 'hours',
  `slug` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allowed_users` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_guest_view` tinyint(1) DEFAULT NULL,
  `ad_chat_right_bar` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ad_chat_left_bar` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_background` tinyint(1) DEFAULT NULL,
  `background_image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT 'ACTIVE = 1, INACTIVE = 2',
  `created_by` int(11) DEFAULT NULL,
  `hide_chat_list` tinyint(4) DEFAULT NULL,
  `disable_private_chats` tinyint(4) DEFAULT NULL,
  `disable_group_chats` tinyint(4) DEFAULT NULL,
  `user_list_type` tinyint(4) DEFAULT NULL,
  `user_list_auth_roles` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_chat_rooms`
--

INSERT INTO `cn_chat_rooms` (`id`, `name`, `description`, `cover_image`, `room_notice_message`, `room_notice_class`, `is_protected`, `password`, `is_visible`, `chat_validity`, `slug`, `allowed_users`, `allow_guest_view`, `ad_chat_right_bar`, `ad_chat_left_bar`, `show_background`, `background_image`, `status`, `created_by`, `hide_chat_list`, `disable_private_chats`, `disable_group_chats`, `user_list_type`, `user_list_auth_roles`) VALUES
(1, 'Ketan Sodvadiya', 'This is testing Chat room', NULL, '', 'success', 0, '', 1, NULL, 'ketan-sodvadiya', '[\"1\",\"4\",\"2\"]', 0, '', '', 1, NULL, 1, 1, NULL, NULL, NULL, NULL, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `cn_group_chats`
--

CREATE TABLE `cn_group_chats` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `type` smallint(6) NOT NULL DEFAULT 1 COMMENT 'text= 1, image= 2, gif= 3',
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT 'send= 1, seen = 2, deleted = 3',
  `time` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_group_chats`
--

INSERT INTO `cn_group_chats` (`id`, `sender_id`, `group_id`, `room_id`, `type`, `message`, `status`, `time`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 'Hello', 2, '2022-03-22 11:22:36', '2022-03-22 11:34:04'),
(2, 1, 1, 1, 1, 'help', 2, '2022-03-22 11:30:11', '2022-03-22 11:34:04'),
(3, 2, 1, 1, 1, 'Hello Nehali', 2, '2022-03-22 11:34:11', '2022-03-22 11:51:03'),
(4, 1, 1, 1, 1, 'Testing', 2, '2022-03-23 13:15:58', '2022-03-23 13:16:42'),
(5, 1, 1, 1, 5, '{\"message\":\"https:\\/\\/demo.chatnet.oncodes.com\\/ketan-sodvadiya\\/Ketans?text=I%20need%20help\",\"title\":null,\"description\":null,\"image\":null,\"code\":null,\"url\":\"https:\\/\\/demo.chatnet.oncodes.com\\/ketan-sodvadiya\\/Ketans?text=I%20need%20help\"}', 3, '2022-03-23 13:21:39', '2022-03-23 13:22:04'),
(6, 2, 1, 1, 1, 'Hi', 2, '2022-03-23 13:35:02', '2022-03-23 13:59:39');

-- --------------------------------------------------------

--
-- Table structure for table `cn_group_users`
--

CREATE TABLE `cn_group_users` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `chat_group` int(11) NOT NULL,
  `user_type` smallint(6) NOT NULL DEFAULT 2 COMMENT 'Group admin = 1, Group user = 2, Guest user = 3',
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT 'Active = 1, Inactive = 2',
  `is_typing` tinyint(1) NOT NULL DEFAULT 0,
  `is_muted` tinyint(4) NOT NULL DEFAULT 0,
  `unread_count` int(11) NOT NULL DEFAULT 0,
  `is_mod` tinyint(1) NOT NULL DEFAULT 0,
  `load_chats_from` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_group_users`
--

INSERT INTO `cn_group_users` (`id`, `user`, `chat_group`, `user_type`, `status`, `is_typing`, `is_muted`, `unread_count`, `is_mod`, `load_chats_from`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1, 0, 0, 0, 0, NULL, '2022-03-22 11:22:30', '2022-03-23 15:35:46'),
(2, 2, 1, 2, 1, 0, 0, 0, 0, NULL, '2022-03-22 11:34:02', '2022-03-23 15:29:22');

-- --------------------------------------------------------

--
-- Table structure for table `cn_ip_logs`
--

CREATE TABLE `cn_ip_logs` (
  `id` int(11) NOT NULL,
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1 login, 2, register, 3 pass reset',
  `message` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cn_languages`
--

CREATE TABLE `cn_languages` (
  `code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direction` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ltr',
  `google_font_family` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_languages`
--

INSERT INTO `cn_languages` (`code`, `name`, `country`, `direction`, `google_font_family`) VALUES
('en', 'English', 'us', 'ltr', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cn_lang_terms`
--

CREATE TABLE `cn_lang_terms` (
  `id` int(11) NOT NULL,
  `term` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cn_notifications`
--

CREATE TABLE `cn_notifications` (
  `id` int(11) NOT NULL,
  `type` tinyint(4) DEFAULT 1 COMMENT '1=general, 2=mention, 3=reminder',
  `content` varchar(300) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cn_private_chats`
--

CREATE TABLE `cn_private_chats` (
  `id` int(11) NOT NULL,
  `user_1` int(11) NOT NULL,
  `user_2` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `type` smallint(6) NOT NULL DEFAULT 1 COMMENT 'text=1, image=2, gif=3',
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT 'send= 1, seen = 2, deleted = 3',
  `time` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_private_chats`
--

INSERT INTO `cn_private_chats` (`id`, `user_1`, `user_2`, `sender_id`, `room_id`, `type`, `message`, `status`, `time`, `updated_at`) VALUES
(1, 1, 2, 2, 1, 1, 'Testing', 2, '2022-03-22 11:34:21', '2022-03-22 11:52:44'),
(2, 1, 2, 1, 1, 1, 'Hello sir. Nehali here...\nThis is testing message', 2, '2022-03-22 11:53:07', '2022-03-22 12:00:02'),
(3, 1, 2, 2, 1, 1, 'Hello there', 2, '2022-03-23 11:07:15', '2022-03-23 13:17:15'),
(4, 1, 2, 2, 1, 1, 'Help', 2, '2022-03-23 12:55:31', '2022-03-23 13:17:15'),
(5, 1, 2, 1, 1, 5, '{\"message\":\"http:\\/\\/192.168.1.131\\/Chatnet\\/chatnet\\/ketan-sodvadiya\\/Ketans?text=I%20need%20help\",\"title\":\"Ketan Sodvadiya - ChatNet\",\"description\":\"This is testing Chat room\",\"image\":\"http:\\/\\/192.168.1.131\\/Chatnet\\/chatnet\\/static\\/img\\/ogimage.png\",\"code\":\"\",\"url\":\"http:\\/\\/192.168.1.131\\/Chatnet\\/chatnet\\/ketan-sodvadiya\\/Ketans?text=I%20need%20help\"}', 2, '2022-03-23 13:32:48', '2022-03-23 13:35:03'),
(6, 1, 2, 1, 1, 1, 'help', 2, '2022-03-23 14:14:27', '2022-03-23 14:14:59');

-- --------------------------------------------------------

--
-- Table structure for table `cn_private_chat_meta`
--

CREATE TABLE `cn_private_chat_meta` (
  `id` int(11) NOT NULL,
  `from_user` int(11) NOT NULL,
  `to_user` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `is_typing` tinyint(1) DEFAULT 0,
  `is_blocked` tinyint(1) DEFAULT 0,
  `is_favourite` tinyint(1) DEFAULT 0,
  `is_muted` tinyint(4) DEFAULT 0,
  `unread_count` int(11) DEFAULT 0,
  `last_chat_id` int(11) DEFAULT NULL,
  `load_chats_from` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_private_chat_meta`
--

INSERT INTO `cn_private_chat_meta` (`id`, `from_user`, `to_user`, `room_id`, `is_typing`, `is_blocked`, `is_favourite`, `is_muted`, `unread_count`, `last_chat_id`, `load_chats_from`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, 0, 0, 0, 0, 0, 6, NULL, '2022-03-22 11:34:14', '2022-03-23 15:35:47'),
(2, 1, 2, NULL, 0, 0, 0, 0, 0, 6, NULL, '2022-03-22 11:34:14', '2022-03-23 15:35:47'),
(3, 2, 2, NULL, 0, 0, 0, 0, 0, NULL, NULL, '2022-03-23 13:35:09', '2022-03-23 13:35:12');

-- --------------------------------------------------------

--
-- Table structure for table `cn_push_devices`
--

CREATE TABLE `cn_push_devices` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `device` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perm_group` tinyint(1) NOT NULL DEFAULT 0,
  `perm_private` tinyint(1) NOT NULL DEFAULT 1,
  `perm_mentions` tinyint(1) NOT NULL DEFAULT 1,
  `perm_notice` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cn_radio_stations`
--

CREATE TABLE `cn_radio_stations` (
  `id` smallint(6) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cn_reports`
--

CREATE TABLE `cn_reports` (
  `id` int(11) NOT NULL,
  `report_type` smallint(6) NOT NULL DEFAULT 1 COMMENT 'chat=1, user=2, room=3, group=4',
  `report_for` int(11) NOT NULL,
  `chat_type` int(11) DEFAULT NULL COMMENT 'private=1, group=2',
  `report_reason` int(11) DEFAULT NULL,
  `report_comment` text DEFAULT NULL,
  `reported_by` int(11) DEFAULT NULL,
  `reported_at` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL COMMENT 'reported=1, read=2',
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cn_report_reasons`
--

CREATE TABLE `cn_report_reasons` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `reason_for` smallint(6) NOT NULL DEFAULT 0 COMMENT 'all=0, chat=1, user=2, room=3, group=4'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cn_report_reasons`
--

INSERT INTO `cn_report_reasons` (`id`, `title`, `description`, `reason_for`) VALUES
(1, 'report_reason_1', 'report_reason_1_description', 0),
(2, 'report_reason_2', 'report_reason_2_description', 0),
(3, 'report_reason_3', 'report_reason_3_description', 0),
(4, 'report_reason_4', 'report_reason_4_description', 0),
(5, 'report_reason_5', 'report_reason_5_description', 0),
(6, 'report_reason_6', 'report_reason_6_description', 0),
(7, 'report_reason_7', 'report_reason_7_description', 0),
(8, 'report_reason_8', 'report_reason_8_description', 0),
(9, 'report_reason_9', 'report_reason_9_description', 0),
(10, 'report_reason_10', 'report_reason_10_description', 0);

-- --------------------------------------------------------

--
-- Table structure for table `cn_settings`
--

CREATE TABLE `cn_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_settings`
--

INSERT INTO `cn_settings` (`id`, `name`, `value`) VALUES
(1, 'timezone', 'Asia/Colombo'),
(2, 'chat_receive_seconds', '3'),
(3, 'user_list_check_seconds', '5'),
(4, 'chat_status_check_seconds', '3'),
(5, 'online_status_check_seconds', '10'),
(6, 'typing_status_check_seconds', '3'),
(7, 'current_version', '1.8.1'),
(8, 'enable_gif', '1'),
(9, 'enable_stickers', '1'),
(10, 'enable_images', '1'),
(11, 'member_registration', '1'),
(12, 'homepage_chat_room_view', 'small'),
(13, 'site_name', 'ChatNet'),
(14, 'sent_animation', 'animate__fadeIn animate__slow'),
(15, 'replies_animation', 'animate__fadeInLeft'),
(16, 'radio', '0'),
(17, 'enable_social_login', '0'),
(18, 'push_notifications', '0'),
(19, 'pwa_enabled', '0'),
(20, 'allow_multiple_sessions', '1'),
(21, 'push_provider', 'firebase'),
(22, 'guest_inactive_hours', '48'),
(23, 'enable_recaptcha', '0'),
(24, 'enable_ip_logging', '0'),
(25, 'enable_ip_blacklist', '0'),
(26, 'autodetect_country', '0'),
(27, 'geoip_api_endpoint', 'https://freegeoip.app/json/'),
(29, 'enable_email_verification', '0'),
(30, 'disable_join_confirmation', '0'),
(31, 'email_smtp', '0'),
(32, 'enable_multiple_languages', '0'),
(33, 'delete_group_chat_hours', '0'),
(34, 'delete_private_chat_hours', '0'),
(35, 'only_online_users', '0'),
(36, 'hide_chat_list', '0'),
(37, 'disable_private_chats', '0'),
(38, 'domain_filter', '0'),
(39, 'domains_list', ''),
(40, 'sso_enabled', '0'),
(41, 'sso_home_url', ''),
(42, 'sso_allowed_orgins', ''),
(43, 'sso_login_url', ''),
(44, 'sso_logout_url', ''),
(45, 'sso_allow_profile_edit', '0'),
(46, 'flood_control_message_limit', '1'),
(47, 'flood_control_time_limit', '1'),
(48, 'enable_codes', '1'),
(49, 'user_list_auth_roles', '[]'),
(50, 'boxed_bg', '0'),
(51, 'disable_group_chats', '0'),
(52, 'user_list_type', '1'),
(53, 'chatpage_layout', 'full'),
(54, 'cloud_storage', '0'),
(55, 'cloud_storage_type', 'aws'),
(56, 'cloud_storage_endpoint', ''),
(57, 'cloud_storage_region', ''),
(58, 'cloud_storage_key', ''),
(59, 'cloud_storage_secret', ''),
(60, 'cloud_storage_bucket', ''),
(61, 'cloud_storage_url', ''),
(62, 'cloud_storage_ssl_verify', '');

-- --------------------------------------------------------

--
-- Table structure for table `cn_social_logins`
--

CREATE TABLE `cn_social_logins` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cn_translations`
--

CREATE TABLE `cn_translations` (
  `id` int(11) NOT NULL,
  `lang_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term_id` int(11) DEFAULT NULL,
  `translation` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cn_users`
--

CREATE TABLE `cn_users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sex` smallint(6) DEFAULT NULL COMMENT 'MALE = 1, FEMALE = 2, OTHER = 3',
  `avatar` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_status` smallint(6) DEFAULT 1 COMMENT 'ONLINE = 1, OFFLINE = 2, BUSY = 3',
  `available_status` smallint(6) DEFAULT 1 COMMENT 'ACTIVE = 1, INACTIVE = 2',
  `last_seen` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `user_type` smallint(6) NOT NULL DEFAULT 2 COMMENT 'Admin = 1, Chat User = 2',
  `reset_key` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `timezone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Asia/Colombo',
  `country` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activation_key` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_key` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cn_users`
--

INSERT INTO `cn_users` (`id`, `user_name`, `first_name`, `last_name`, `email`, `dob`, `sex`, `avatar`, `password`, `about`, `user_status`, `available_status`, `last_seen`, `last_login`, `user_type`, `reset_key`, `created_at`, `timezone`, `country`, `activation_key`, `auth_key`) VALUES
(1, 'nehali.chauhan', 'Nehali', 'Chauhan', 'nehali.chauhan@differenzsystem.com', NULL, NULL, NULL, '$2y$10$WL0wARWGvY1Br/1v5MFw8uv3o61/HUWkBjfCkLlHSokx4ofMDm2Sy', NULL, 1, 1, '2022-03-23 15:35:46', '2022-03-23 13:21:23', 1, NULL, '2022-03-22 11:20:12', 'Asia/Colombo', NULL, NULL, '$2y$10$hTAPovGXkIGYtGImMLAqBuhHT/FN3iphg4sgEzkf2cRV1ZFiRzPCK'),
(2, 'Ketans', 'Ketan', 'Sodvadiya', 'ketan@differenzsystem.com', NULL, NULL, NULL, '$2y$10$pnTUO2ml3IkHTgmqZNFaC.p/PJ12y7UHp.mu8AzD1hrda4uJu2C7m', NULL, 1, 1, '2022-03-23 15:29:22', '2022-03-23 13:20:49', 2, NULL, '2022-03-22 11:31:50', 'Asia/Calcutta', NULL, NULL, '$2y$10$maZYIt3Rcm342ww.930WD.LEtIo5WwSn.aCA6fbq3VLjylncy5OEC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cn_chatbot`
--
ALTER TABLE `cn_chatbot`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_chat_groups`
--
ALTER TABLE `cn_chat_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_chat_groups_idx_id` (`id`),
  ADD KEY `cn_chat_groups_idx_chat_room_slug` (`chat_room`,`slug`);

--
-- Indexes for table `cn_chat_interactions`
--
ALTER TABLE `cn_chat_interactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_chat_interactio_idx_is_noti_chat_ty_user_id_chat_id` (`is_notified`,`chat_type`,`user_id`,`chat_id`),
  ADD KEY `cn_chat_interactio_idx_chat_ty_user_id_chat_id` (`chat_type`,`user_id`,`chat_id`);

--
-- Indexes for table `cn_chat_rooms`
--
ALTER TABLE `cn_chat_rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_chat_rooms_idx_created_by` (`created_by`),
  ADD KEY `cn_chat_rooms_idx_status_is_visible` (`status`,`is_visible`),
  ADD KEY `cn_chat_rooms_idx_slug` (`slug`),
  ADD KEY `cn_chat_rooms_idx_id` (`id`);

--
-- Indexes for table `cn_group_chats`
--
ALTER TABLE `cn_group_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_group_chats_idx_id_group_id_sender_id` (`id`,`group_id`,`sender_id`),
  ADD KEY `cn_group_chats_idx_group_id_room_id` (`group_id`,`room_id`),
  ADD KEY `cn_group_chats_idx_id_group_id_room_id` (`id`,`group_id`,`room_id`),
  ADD KEY `cn_group_chats_idx_updated_at_group_id` (`updated_at`,`group_id`),
  ADD KEY `cn_group_chats_idx_sender_id` (`sender_id`),
  ADD KEY `cn_group_chats_idx_sender_id_time_status` (`sender_id`,`status`,`time`);

--
-- Indexes for table `cn_group_users`
--
ALTER TABLE `cn_group_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `cn_group_users_idx_chat_group` (`chat_group`),
  ADD KEY `cn_group_users_idx_user` (`user`),
  ADD KEY `cn_group_users_idx_user_chat_group` (`user`,`chat_group`),
  ADD KEY `cn_group_users_idx_is_muted_user_chat_group` (`is_muted`,`user`,`chat_group`);

--
-- Indexes for table `cn_ip_logs`
--
ALTER TABLE `cn_ip_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_languages`
--
ALTER TABLE `cn_languages`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `cn_lang_terms`
--
ALTER TABLE `cn_lang_terms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_notifications`
--
ALTER TABLE `cn_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_notifications_idx_user_id_is_read` (`user_id`,`is_read`);

--
-- Indexes for table `cn_private_chats`
--
ALTER TABLE `cn_private_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_private_chats_idx_id` (`id`),
  ADD KEY `cn_private_chats_idx_user_1_user_2_room_id_sender_id` (`user_1`,`user_2`,`room_id`,`sender_id`),
  ADD KEY `cn_private_chats_idx_user_1_user_2_room_id` (`user_1`,`user_2`,`room_id`),
  ADD KEY `cn_private_chats_idx_id_user_1_user_2_room_id` (`id`,`user_1`,`user_2`,`room_id`),
  ADD KEY `cn_private_chats_idx_updated_at_user_1_user_2_room_id` (`updated_at`,`user_1`,`user_2`,`room_id`),
  ADD KEY `cn_private_chats_idx_user_2_sender_id` (`user_2`,`sender_id`),
  ADD KEY `cn_private_chats_idx_user_1_sender_id` (`user_1`,`sender_id`),
  ADD KEY `cn_private_chats_idx_sender_id_time_status` (`sender_id`,`status`,`time`);

--
-- Indexes for table `cn_private_chat_meta`
--
ALTER TABLE `cn_private_chat_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_private_chat_me_idx_to_user_room_id_from_user` (`to_user`,`room_id`,`from_user`),
  ADD KEY `cn_private_chat_me_idx_from_user_to_user` (`from_user`,`to_user`),
  ADD KEY `cn_private_chat_me_idx_is_muted_from_user_to_user` (`is_muted`,`from_user`,`to_user`),
  ADD KEY `cn_private_chat_me_idx_from_user_to_user_id` (`from_user`,`to_user`,`id`);

--
-- Indexes for table `cn_push_devices`
--
ALTER TABLE `cn_push_devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_radio_stations`
--
ALTER TABLE `cn_radio_stations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_reports`
--
ALTER TABLE `cn_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_report_reasons`
--
ALTER TABLE `cn_report_reasons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_settings`
--
ALTER TABLE `cn_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cn_social_logins`
--
ALTER TABLE `cn_social_logins`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `cn_translations`
--
ALTER TABLE `cn_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cn_translations_idx_term_id_lang_code` (`term_id`,`lang_code`);

--
-- Indexes for table `cn_users`
--
ALTER TABLE `cn_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`user_name`,`email`),
  ADD KEY `cn_users_idx_id` (`id`),
  ADD KEY `cn_users_idx_user_type` (`user_type`);
ALTER TABLE `cn_users` ADD FULLTEXT KEY `name` (`first_name`,`last_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cn_chatbot`
--
ALTER TABLE `cn_chatbot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cn_chat_groups`
--
ALTER TABLE `cn_chat_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cn_chat_interactions`
--
ALTER TABLE `cn_chat_interactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `cn_chat_rooms`
--
ALTER TABLE `cn_chat_rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cn_group_chats`
--
ALTER TABLE `cn_group_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cn_group_users`
--
ALTER TABLE `cn_group_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cn_ip_logs`
--
ALTER TABLE `cn_ip_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_lang_terms`
--
ALTER TABLE `cn_lang_terms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_notifications`
--
ALTER TABLE `cn_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_private_chats`
--
ALTER TABLE `cn_private_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cn_private_chat_meta`
--
ALTER TABLE `cn_private_chat_meta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cn_push_devices`
--
ALTER TABLE `cn_push_devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_radio_stations`
--
ALTER TABLE `cn_radio_stations`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_reports`
--
ALTER TABLE `cn_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_report_reasons`
--
ALTER TABLE `cn_report_reasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cn_settings`
--
ALTER TABLE `cn_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `cn_translations`
--
ALTER TABLE `cn_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cn_users`
--
ALTER TABLE `cn_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
