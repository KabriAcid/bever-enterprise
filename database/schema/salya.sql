-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2025 at 03:09 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `salya`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_last_changed` datetime DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(11) NOT NULL,
  `avatar` varchar(255) NOT NULL DEFAULT 'default.png',
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`permissions`)),
  `role` varchar(50) DEFAULT 'Admin',
  `mfa_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `login_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `session_timeout` int(11) NOT NULL DEFAULT 60,
  `system_alerts` tinyint(1) NOT NULL DEFAULT 0,
  `user_activity` tinyint(1) NOT NULL DEFAULT 0,
  `position` varchar(100) NOT NULL DEFAULT 'Product Designer',
  `address` varchar(255) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp(),
  `active_sessions` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `admin_id`, `email`, `password_hash`, `password_last_changed`, `first_name`, `last_name`, `phone`, `avatar`, `permissions`, `role`, `mfa_enabled`, `login_notifications`, `session_timeout`, `system_alerts`, `user_activity`, `position`, `address`, `last_login`, `active_sessions`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN001', 'admin@salya.com', '$2y$10$vtyd0fUrm.5TbCRsXqLGC.Yrb2GUo36H7VoLDzA5XzTvfPJYcFQoK', NULL, 'Super', 'Admin', '07037943396', 'avatar.jpg', '{\"users\": {\"view\": true, \"create\": true, \"edit\": true, \"delete\": true}, \"products\": {\"view\": true, \"create\": true, \"edit\": true, \"delete\": true}, \"orders\": {\"view\": true, \"create\": true, \"edit\": true, \"delete\": true}, \"reports\": {\"view\": true, \"create\": true}, \"settings\": {\"view\": true, \"edit\": true}}', 'Super Admin', 0, 0, 60, 0, 0, 'System Administrator', '123 Admin Street, Lagos, Nigeria', '2025-08-06 22:54:57', 1, '2025-08-06 22:54:57', '2025-08-06 22:54:57'),
(2, 'ADMIN002', 'manager@salya.com', '$2y$10$vtyd0fUrm.5TbCRsXqLGC.Yrb2GUo36H7VoLDzA5XzTvfPJYcFQoK', NULL, 'John', 'Manager', '08023456789', 'default.png', '{\"users\": {\"view\": true, \"create\": true, \"edit\": true, \"delete\": false}, \"products\": {\"view\": true, \"create\": true, \"edit\": true, \"delete\": false}, \"orders\": {\"view\": true, \"create\": false, \"edit\": true, \"delete\": false}, \"reports\": {\"view\": true, \"create\": false}}', 'Manager', 0, 0, 60, 0, 0, 'Operations Manager', '456 Manager Ave, Abuja, Nigeria', '2025-08-06 22:54:57', 1, '2025-08-06 22:54:57', '2025-08-06 22:54:57'),
(3, 'ADMIN003', 'staff@salya.com', '$2y$10$vtyd0fUrm.5TbCRsXqLGC.Yrb2GUo36H7VoLDzA5XzTvfPJYcFQoK', NULL, 'Jane', 'Smith', '08034567890', 'default.png', '{\"users\": {\"view\": true, \"create\": false, \"edit\": false, \"delete\": false}, \"products\": {\"view\": true, \"create\": false, \"edit\": true, \"delete\": false}, \"orders\": {\"view\": true, \"create\": false, \"edit\": true, \"delete\": false}, \"reports\": {\"view\": true, \"create\": false}}', 'Staff', 0, 0, 60, 0, 0, 'Customer Service', '789 Staff Road, Port Harcourt, Nigeria', '2025-08-06 22:54:57', 1, '2025-08-06 22:54:57', '2025-08-06 22:54:57');

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_log`
--

CREATE TABLE `admin_activity_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action` varchar(64) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` int(11) NOT NULL,
  `type` enum('order','system','user','report','payment','stock','other') NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `reference_id` varchar(50) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_notifications`
--

INSERT INTO `admin_notifications` (`id`, `type`, `title`, `message`, `icon`, `color`, `reference_id`, `is_read`, `created_at`) VALUES
(1, 'order', 'New Order Received', 'Order #ORD-1234 from John Smith for $45.99', 'shopping-cart', 'orange', 'ORD-1234', 0, '2025-08-20 05:35:28'),
(2, 'stock', 'Low Stock Alert', 'Turkey Wings is running low (only 5 items left)', 'alert-triangle', 'red', NULL, 0, '2025-08-20 05:35:28'),
(3, 'user', 'New User Registration', 'Sarah Johnson just signed up for an account', 'user-plus', 'blue', NULL, 0, '2025-08-20 05:35:28'),
(4, 'system', 'System Update Complete', 'Dashboard has been updated to version 2.1.0', 'settings', 'gray', NULL, 0, '2025-08-20 05:35:28'),
(5, 'report', 'Daily Sales Report', 'Today\'s sales: $1,250.75 (23 orders)', 'bar-chart-3', 'green', NULL, 0, '2025-08-20 05:35:28'),
(6, 'payment', 'Payment Processed', 'Payment of $89.50 received from Mike Johnson', 'credit-card', 'green', NULL, 0, '2025-08-20 05:35:28'),
(7, 'payment', 'Payment Processed', 'Payment of N8943.50 received from Kabri Acid', 'credit-card', 'green', NULL, 0, '2025-08-20 05:43:59'),
(8, 'user', 'Payment Processed', 'Payment of N8943.50 received from Kabri Acid', 'credit-card', 'green', NULL, 0, '2025-08-20 05:44:49'),
(9, 'user', 'Payment Processed', 'Payment of N8943.50 received from ABdull', 'credit-card', 'green', NULL, 0, '2025-08-20 05:46:44'),
(10, 'user', 'Payment Processed', 'Payment of N8943.50 received from ABdull', 'credit-card', 'green', NULL, 0, '2025-08-20 05:47:00'),
(11, 'user', 'Payment Processed', 'Payment of ', 'credit-card', 'blue', NULL, 0, '2025-08-20 05:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `card_details`
--

CREATE TABLE `card_details` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `card_name` varchar(100) NOT NULL,
  `card_number` varchar(24) NOT NULL,
  `card_expiry` varchar(7) NOT NULL,
  `card_cvc` varchar(4) DEFAULT NULL,
  `billing_address_same` tinyint(1) DEFAULT 1,
  `payment_method` varchar(32) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(8) NOT NULL DEFAULT 'NGN',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` enum('1','0') NOT NULL,
  `image_url` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `is_active`, `image_url`, `created_at`, `updated_at`) VALUES
(2, 'Diana Patrick', 'Lillian Hahn', 'Sit eligendi irure', '0', 'category_689b21e29f219.jpg', '2025-08-12 11:13:38', '2025-08-13 01:53:26'),
(4, 'Chicken Fillet', 'chicken', 'This is a chicken fillet, tasty, yummy.', '1', 'category_68a5426c5a611.jpg', '2025-08-20 03:35:08', '2025-08-20 03:43:57');

-- --------------------------------------------------------

--
-- Table structure for table `checkouts`
--

CREATE TABLE `checkouts` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('new','read','replied','closed') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `discount_type` enum('percentage','flat') DEFAULT 'percentage',
  `discount_value` decimal(10,2) DEFAULT NULL,
  `minimum_amount` decimal(10,2) DEFAULT 0.00,
  `maximum_discount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0,
  `valid_from` datetime DEFAULT current_timestamp(),
  `valid_until` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_zones`
--

CREATE TABLE `delivery_zones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `zone_name` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `delivery_fee` decimal(10,2) DEFAULT 0.00,
  `estimated_delivery_hours` int(11) DEFAULT 24,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscriptions`
--

CREATE TABLE `newsletter_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unsubscribed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `delivery_fee` decimal(10,2) DEFAULT 0.00,
  `tax` decimal(10,2) DEFAULT 0.00,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_status` enum('pending','paid','failed','refunded') DEFAULT 'pending',
  `status` enum('pending','processing','shipped','delivered','cancelled','refunded') DEFAULT 'pending',
  `delivery_address` text DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `verification_id` varchar(100) DEFAULT NULL,
  `shipping_name` varchar(100) DEFAULT NULL,
  `shipping_phone` varchar(30) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_postal_code` varchar(20) DEFAULT NULL,
  `shipping_landmark` varchar(255) DEFAULT NULL,
  `shipping_area` varchar(100) DEFAULT NULL,
  `delivery_option` varchar(100) DEFAULT NULL,
  `special_instructions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `user_id`, `subtotal`, `delivery_fee`, `tax`, `discount_amount`, `total_amount`, `payment_method`, `payment_status`, `status`, `delivery_address`, `delivery_date`, `notes`, `created_at`, `updated_at`, `verification_id`, `shipping_name`, `shipping_phone`, `shipping_address`, `shipping_city`, `shipping_state`, `shipping_postal_code`, `shipping_landmark`, `shipping_area`, `delivery_option`, `special_instructions`) VALUES
(6, 'ORD-2025-68A55CE5E530F', 4, 2490.00, 500.00, 0.00, 0.00, 2990.00, 'bank_transfer', '', 'pending', NULL, NULL, NULL, '2025-08-20 05:28:05', '2025-08-28 00:23:23', 'VER-68A55CE5E5313', 'Yoko Knox', '08017239027', '334 Green Hague Drive', 'gwagwalada', 'fct', 'Quia repudiandae eos', 'Eligendi suscipit ad', 'paiko', 'standard', 'Sequi magnam eveniet'),
(7, 'ORD-2025-68AF996442CA4', 4, 2490.00, 500.00, 0.00, 0.00, 2990.00, 'bank_transfer', '', 'processing', NULL, NULL, 'Hola', '2025-08-27 23:48:52', '2025-08-28 00:40:20', 'VER-68AF996442CA6', 'Carolyn Burgess', '08033313892', '446 White First Avenue', 'ikeja', 'lagos', 'Perspiciatis minim ', 'Aspernatur minim pla', 'agege', 'standard', 'Soluta vel fugiat u'),
(8, 'ORD-2025-68AF99F280792', 4, 2490.00, 500.00, 0.00, 0.00, 2990.00, 'bank_transfer', '', 'pending', NULL, NULL, NULL, '2025-08-27 23:51:14', '2025-08-28 00:23:34', 'VER-68AF99F280797', 'Callum Fisher', '08026038493', '920 Oak Freeway', 'mainland', 'lagos', 'Ut officiis consecte', 'Sit quaerat harum v', 'oshodi', 'standard', 'Excepturi ut debitis'),
(9, 'ORD-68AF9D4C2A06E.5', 5, 2490.00, 500.00, 0.00, 0.00, 2990.00, 'bank_transfer', '', 'processing', NULL, NULL, NULL, '2025-08-28 00:05:32', '2025-08-28 00:23:38', 'VER-68AF9D4C2A073.5', 'Griffith Murray', '08025168721', '465 South First Boulevard', 'bwari', 'fct', 'Eum delectus elit ', 'Quis incidunt aliqu', 'gwarinpa', 'standard', 'Est laboriosam eu a');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_image` varchar(200) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `product_image`, `quantity`, `unit_price`, `total_price`, `created_at`) VALUES
(1, 6, 5, 'Chicken Fillet', 'product_68a557702da139.38657366_1755666288.jpg', 1, 2490.00, 2490.00, '2025-08-20 05:28:05'),
(2, 7, 5, 'Chicken Fillet', 'product_68a557702da139.38657366_1755666288.jpg', 1, 2490.00, 2490.00, '2025-08-27 23:48:52'),
(3, 8, 5, 'Chicken Fillet', 'product_68a557702da139.38657366_1755666288.jpg', 1, 2490.00, 2490.00, '2025-08-27 23:51:14'),
(4, 9, 5, 'Chicken Fillet', 'product_68a557702da139.38657366_1755666288.jpg', 1, 2490.00, 2490.00, '2025-08-28 00:05:32');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT 'default.png',
  `rating` decimal(3,2) DEFAULT 0.00,
  `reviews_count` int(10) UNSIGNED DEFAULT 0,
  `stock_quantity` int(11) DEFAULT 0,
  `in_stock` tinyint(1) DEFAULT 1,
  `weight` decimal(10,2) DEFAULT NULL,
  `dimensions` varchar(255) DEFAULT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `nutritional_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`nutritional_info`)),
  `is_active` tinyint(1) DEFAULT 1,
  `is_featured` tinyint(1) DEFAULT 0,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `description`, `price`, `image`, `rating`, `reviews_count`, `stock_quantity`, `in_stock`, `weight`, `dimensions`, `features`, `nutritional_info`, `is_active`, `is_featured`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES
(5, 4, 'Chicken Fillet', 'chicken-fillet', 'Ut aute enim consequ chicken fillet tasty ymmy', 2490.00, 'product_68a557702da139.38657366_1755666288.jpg', 4.00, 0, 12, 12, 2.00, '2x3 cm', '[\"Tasty\",\"Yummy\",\"Delicious\"]', '[\"Dolor, ex enim. qui am\"]', 1, 1, 'Sit ullamco itaque', 'Eos quia nostrum et', '2025-08-20 05:04:48', '2025-08-20 05:04:48');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `title` varchar(200) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_verified_purchase` tinyint(1) DEFAULT 0,
  `is_approved` tinyint(1) DEFAULT 1,
  `helpful_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `key` varchar(100) NOT NULL,
  `value` text DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `group` varchar(50) DEFAULT 'general',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`key`, `value`, `description`, `group`, `updated_at`) VALUES
('business_address', '671 New Parkway', NULL, 'general', '2025-08-20 04:16:30'),
('business_email', 'nikaj@gmail.com', NULL, 'general', '2025-08-20 04:16:30'),
('business_name', 'Hayley Farrell', NULL, 'general', '2025-08-20 04:16:30'),
('confirm_password', 'Pa$$w0rd!', NULL, 'general', '2025-08-20 04:16:55'),
('current_password', 'Pa$$w0rd!', NULL, 'general', '2025-08-20 04:16:55'),
('email_notifications', '1', NULL, 'general', '2025-08-20 04:16:48'),
('marketing_updates', '1', NULL, 'general', '2025-08-20 04:16:48'),
('order_notifications', '1', NULL, 'general', '2025-08-20 04:16:48'),
('phone_number', '08087831681', NULL, 'general', '2025-08-20 04:16:30'),
('Salaya', '$2y$10$RmL3bR.JVI0oQqz9uY8FK.JpP9Yg4ATEi2SWslRgFevu9gOStbIXG', NULL, 'general', '2025-08-20 04:16:55'),
('stock_alerts', '1', NULL, 'general', '2025-08-20 04:16:48'),
('timezone', 'Eastern Time (ET)', NULL, 'general', '2025-08-20 04:16:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `avatar` varchar(255) NOT NULL DEFAULT 'default.png',
  `password_hash` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `role` enum('loyal','regular') NOT NULL DEFAULT 'regular',
  `status` enum('Active','Inactive','Suspended','Pending') NOT NULL DEFAULT 'Active',
  `verified` enum('verified','unverified') NOT NULL DEFAULT 'unverified',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `phone`, `first_name`, `last_name`, `avatar`, `password_hash`, `address`, `city`, `state`, `postal_code`, `role`, `status`, `verified`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`, `last_login`) VALUES
(4, 'user@gmail.com', '08039063331', 'Hauwa', 'Kudu', 'user_4_68af84d98f0b14.37270741_1756333273.jpg', '$2y$10$z/93To8RjZLDoQ9ZPJf6GO2BiRzHAlLyM/19cIxnVR43DHjHh583u', '', NULL, NULL, NULL, '', 'Active', 'unverified', NULL, NULL, '2025-08-06 22:52:02', '2025-08-28 00:52:06', NULL),
(5, 'jojyq@gmail.com', '08033199959', 'Holly', 'Fletcher', 'default.png', '$2y$10$98c2mDETfidaBuEej3Y35.deHqHxWLvzTuVcnPl9Hj8wG9LUH21tC', NULL, NULL, NULL, NULL, 'regular', 'Active', 'unverified', NULL, NULL, '2025-08-28 00:04:13', '2025-08-28 00:04:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `address_name` varchar(100) DEFAULT 'Home',
  `full_address` text DEFAULT NULL,
  `type` enum('home','work','other') DEFAULT 'home',
  `street_address` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `landmark` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `user_id`, `address_name`, `full_address`, `type`, `street_address`, `city`, `state`, `postal_code`, `landmark`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 4, 'Inec Office, Sabon Gari Jalingo,', 'Inec Office, Sabon Gari Jalingo,', 'home', '', 'Jalingo', 'Federal Capital Territory', '', NULL, 1, '2025-08-12 01:13:41', '2025-08-12 01:13:41');

-- --------------------------------------------------------

--
-- Table structure for table `user_feedback`
--

CREATE TABLE `user_feedback` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('bug','suggestion','complaint','praise','other') NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `admin_response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT 'info',
  `read` tinyint(1) DEFAULT 0,
  `time` datetime DEFAULT current_timestamp(),
  `icon` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `action_label` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `user_id`, `title`, `message`, `type`, `read`, `time`, `icon`, `color`, `action_label`) VALUES
(1, 4, 'Order Shipped', 'Your order #ORD-2025-001 has been shipped and is on its way!', 'orders', 0, '2025-08-27 23:49:02', 'fas fa-box text-blue-600', 'bg-blue-100', 'Track Order'),
(2, 4, 'Special Offer!', 'Get 20% off on all frozen foods this weekend. Use code FROZEN20 at checkout.', 'promotions', 0, '2025-08-27 23:52:58', 'fas fa-tags text-orange-500', 'bg-orange-100', 'Shop Now'),
(3, 4, 'App Update', 'We have improved our checkout experience. Try it out now!', 'updates', 0, '2025-08-26 23:52:58', 'fas fa-info-circle text-purple-600', 'bg-blue-100', 'Learn More'),
(4, 4, 'Profile Updated', 'Your profile information was updated successfully.', 'updates', 0, '2025-08-28 00:38:39', 'fas fa-user-edit text-blue-600', 'bg-orange-100', 'View Profile'),
(5, 4, 'Password Changed', 'Your password was updated successfully.', 'security', 0, '2025-08-28 00:39:10', 'fas fa-key text-danger-600', 'bg-red-100', 'View Profile'),
(6, 4, 'Profile Updated', 'Your profile information was updated successfully.', 'updates', 0, '2025-08-28 00:44:27', 'fas fa-user-edit text-blue-600', 'bg-orange-100', 'View Profile'),
(7, 4, 'Order Placed', 'Your order #ORD-2025-68AF996442CA4 has been placed successfully.', 'orders', 0, '2025-08-28 00:48:52', 'fa-solid fa-bag-shopping', '#ea580c', 'View'),
(8, 4, 'Order Placed', 'Your order #ORD-2025-68AF99F280792 has been placed successfully.', 'orders', 0, '2025-08-28 00:51:14', 'fa-solid fa-bag-shopping text-purple-600', '#ea580c', 'View'),
(9, 4, 'Profile Updated', 'Your profile information was updated successfully.', 'updates', 0, '2025-08-28 01:03:20', 'fas fa-user-edit text-blue-600', 'bg-orange-100', 'View Profile'),
(10, 4, 'Profile Updated', 'Your profile information was updated successfully.', 'updates', 0, '2025-08-28 01:03:21', 'fas fa-user-edit text-blue-600', 'bg-orange-100', 'View Profile'),
(11, 4, 'Profile Updated', 'Your profile information was updated successfully.', 'updates', 0, '2025-08-28 01:03:22', 'fas fa-user-edit text-blue-600', 'bg-orange-100', 'View Profile'),
(12, 5, 'Order Placed', 'Your order #ORD-68AF9D4C2A06E.5 has been placed successfully.', 'orders', 0, '2025-08-28 01:05:32', 'fa-solid fa-bag-shopping text-purple-600', '#ea580c', 'View');

-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE `user_preferences` (
  `id` bigint(11) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  `push_notifications` tinyint(1) NOT NULL DEFAULT 1,
  `email_updates` tinyint(1) NOT NULL DEFAULT 0,
  `language` varchar(10) NOT NULL DEFAULT 'en',
  `theme` varchar(20) NOT NULL DEFAULT 'light',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `virtual_accounts`
--

CREATE TABLE `virtual_accounts` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `account_reference` varchar(100) DEFAULT NULL,
  `account_number` varchar(20) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `bank_code` varchar(10) DEFAULT NULL,
  `customer_email` varchar(255) NOT NULL,
  `full_customer_name` varchar(255) NOT NULL,
  `currency_code` varchar(3) DEFAULT 'NGN',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `virtual_accounts`
--

INSERT INTO `virtual_accounts` (`id`, `user_id`, `account_reference`, `account_number`, `account_name`, `bank_name`, `bank_code`, `customer_email`, `full_customer_name`, `currency_code`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 4, NULL, '4114425465', 'Mys', 'Wema bank', NULL, 'musty@gmail.com', 'Mysterio Abukur', 'NGN', 1, '2025-08-06 22:52:04', '2025-08-06 22:52:04'),
(2, 5, NULL, '3319357320', 'Hol', 'Wema bank', NULL, 'jojyq@gmail.com', 'Holly Fletcher', 'NGN', 1, '2025-08-28 00:04:17', '2025-08-28 00:04:17');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(3) DEFAULT 'NGN',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `balance`, `currency`, `is_active`, `created_at`, `updated_at`) VALUES
(3, 4, 453.13, 'NGN', 1, '2025-08-06 22:52:03', '2025-08-27 22:58:02'),
(4, 5, 0.00, 'NGN', 1, '2025-08-28 00:04:13', '2025-08-28 00:04:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_id` (`admin_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `card_details`
--
ALTER TABLE `card_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_product` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `checkouts`
--
ALTER TABLE `checkouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `delivery_zones`
--
ALTER TABLE `delivery_zones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_state` (`city`,`state`);

--
-- Indexes for table `newsletter_subscriptions`
--
ALTER TABLE `newsletter_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `is_active` (`is_active`),
  ADD KEY `is_featured` (`is_featured`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_product` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `rating` (`rating`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`key`),
  ADD KEY `group` (`group`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `status` (`status`),
  ADD KEY `role` (`role`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_feedback`
--
ALTER TABLE `user_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `virtual_accounts`
--
ALTER TABLE `virtual_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `customer_email` (`customer_email`),
  ADD KEY `is_active` (`is_active`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `card_details`
--
ALTER TABLE `card_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `checkouts`
--
ALTER TABLE `checkouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_zones`
--
ALTER TABLE `delivery_zones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `newsletter_subscriptions`
--
ALTER TABLE `newsletter_subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_feedback`
--
ALTER TABLE `user_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `virtual_accounts`
--
ALTER TABLE `virtual_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_items_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reviews_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `user_addresses_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_feedback`
--
ALTER TABLE `user_feedback`
  ADD CONSTRAINT `user_feedback_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `virtual_accounts`
--
ALTER TABLE `virtual_accounts`
  ADD CONSTRAINT `virtual_accounts_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
