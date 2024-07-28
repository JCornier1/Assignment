-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for inyou_market
CREATE DATABASE IF NOT EXISTS `inyou_market` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `inyou_market`;

-- Dumping structure for table inyou_market.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL COMMENT 'Verbal description of each category',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.categories: ~3 rows (approximately)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `description`) VALUES
	(1, 'Supplements'),
	(2, 'Food'),
	(3, 'Cosmetics');

-- Dumping structure for table inyou_market.coupons
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discount` int(10) unsigned DEFAULT NULL COMMENT 'Discount rate for each coupon, it is meant to be implemented as percentages',
  `state` tinyint(4) DEFAULT 1 COMMENT 'Disabled/Enabled',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.coupons: ~4 rows (approximately)
DELETE FROM `coupons`;
INSERT INTO `coupons` (`id`, `discount`, `state`) VALUES
	(1, 10, 1),
	(2, 15, 1),
	(3, 20, 1),
	(4, 25, 0);

-- Dumping structure for table inyou_market.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Verbal description of each product',
  `date_added` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Date that the product was added',
  `date_modified` datetime DEFAULT NULL COMMENT 'Date that the product was edited',
  `base_price` double NOT NULL DEFAULT 0 COMMENT 'Base price of the product without using applying the discounts',
  `coupon` int(11) DEFAULT NULL COMMENT 'Foreign key related to the coupon table, default value is null',
  `active` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Disabled/Enabled',
  `stock` int(11) NOT NULL DEFAULT 0 COMMENT 'Amount of the item currently in stock',
  `category` int(11) NOT NULL DEFAULT 0 COMMENT 'Foreign key representing the category of the product',
  PRIMARY KEY (`id`),
  KEY `product_category` (`category`),
  KEY `product_coupon` (`coupon`),
  CONSTRAINT `product_category` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `product_coupon` FOREIGN KEY (`coupon`) REFERENCES `coupons` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.product: ~9 rows (approximately)
DELETE FROM `product`;
INSERT INTO `product` (`id`, `description`, `date_added`, `date_modified`, `base_price`, `coupon`, `active`, `stock`, `category`) VALUES
	(7, 'Kurosengoku Soy Sauces', '2024-07-01 15:45:14', NULL, 12, 2, 1, 10, 1),
	(13, 'Hemp oil MCT 5%', '2024-01-27 14:27:27', NULL, 27.02, NULL, 1, 2, 1),
	(14, 'Moringa Seed Beauty Oil', '2024-02-27 14:28:37', NULL, 16.06, 1, 1, 20, 1),
	(15, 'Yakushima Honey (Momoka)', '2023-09-28 14:29:15', NULL, 35.5, 3, 1, 100, 2),
	(17, 'Pesticide-free date syrup', '2022-11-03 09:25:00', NULL, 36.2, NULL, 1, 35, 2),
	(18, 'Organic spice mix', '2024-03-23 16:25:33', NULL, 90.9, 2, 1, 40, 2),
	(21, 'Rosemary & Hemp-Derived Scalp Lotion', '2022-09-26 14:32:41', NULL, 251.9, NULL, 1, 100, 3),
	(22, 'Organic Hechima Water', '2021-12-10 10:33:10', NULL, 42.2, 1, 0, 0, 3),
	(23, 'Organic Shea Butter', '2024-06-08 17:34:09', NULL, 54.2, NULL, 1, 100, 3);

-- Dumping structure for table inyou_market.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL COMMENT 'User that made the purchase',
  `date` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Date of the purchase',
  `total` double NOT NULL DEFAULT 0 COMMENT 'Sum of the items calculating all discounts',
  PRIMARY KEY (`id`),
  KEY `sales_users` (`user`),
  CONSTRAINT `sales_users` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.sales: ~2 rows (approximately)
DELETE FROM `sales`;
INSERT INTO `sales` (`id`, `user`, `date`, `total`) VALUES
	(1, 4, '2024-07-27 18:31:36', 174.25),
	(2, 1, '2024-07-27 19:20:54', 85.36);

-- Dumping structure for table inyou_market.sales_junction
CREATE TABLE IF NOT EXISTS `sales_junction` (
  `sale_id` int(11) DEFAULT NULL COMMENT 'Sale ID, can be repeated in the case the purchase contains many items.',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product ID',
  `quantity` int(11) DEFAULT NULL COMMENT 'Amount purchased',
  `subtotal` double DEFAULT NULL COMMENT 'Subtotal without the coupons',
  `total` double DEFAULT NULL COMMENT 'Total with the coupons',
  KEY `sales-junction_sales` (`sale_id`),
  KEY `sales-junctrion_product` (`product_id`),
  CONSTRAINT `sales-junction_sales` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sales-junctrion_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.sales_junction: ~6 rows (approximately)
DELETE FROM `sales_junction`;
INSERT INTO `sales_junction` (`sale_id`, `product_id`, `quantity`, `subtotal`, `total`) VALUES
	(2, 7, 2, 24, 18.36),
	(1, 23, 1, 54.2, 54.2),
	(1, 7, 2, 24, 20.4),
	(1, 14, 1, 16.06, 14.45),
	(1, 15, 3, 106.5, 85.2),
	(2, 13, 2, 78.04, 67);

-- Dumping structure for table inyou_market.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT 'Username that the user needs to login into the website',
  `password` varchar(535) NOT NULL COMMENT 'Hashed password of each user',
  `name` varchar(255) NOT NULL COMMENT 'Real name ',
  `date_of_birth` date NOT NULL,
  `email` varchar(255) NOT NULL COMMENT 'Email needed for the newsletter',
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT 'User type, defines if the user has or not discounts and/or full access to the website.',
  `newsletter` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Boolean type, defines if the user is subscribed to the newsletter.',
  PRIMARY KEY (`id`),
  KEY `users_type` (`type`),
  CONSTRAINT `users_type` FOREIGN KEY (`type`) REFERENCES `user_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.users: ~4 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `username`, `password`, `name`, `date_of_birth`, `email`, `date_created`, `date_modified`, `type`, `newsletter`) VALUES
	(1, 'jcornier', 'ef92b778bafe771e4e7a89e5a66b5486e9fd49c186c2a4f1a2d69040e1d918d8', 'Joaquin Cornier', '2000-06-08', 'joaquincornier@gmail.com', '2024-01-17 14:04:32', NULL, 3, 0),
	(2, 'mcornier', '$2b$12$E9qGHEkAaPzQBD6Z3kVVfOph1U9LQTzYPcG2ETCMiRRTRsXmcIg8y', 'Matias Cornier', '1998-06-22', 'matiascornier@gmail.com', '2024-03-19 18:08:37', NULL, 2, 1),
	(3, 'icornier', '$argon2id$v=19$m=65536,t=2,p=1$Y1hRWE5OVm9ZY3JNV3dVWQ$gJ5Fs1G7N2VmJ4VW5l4dIVtFQST8mhC8X1r6nC3M3aA', 'Ivan Cornier', '1996-02-05', 'ivancornier@gmail.com', '2024-06-11 12:35:26', NULL, 2, 1),
	(4, 'ncornier', 'b8bcefa3726c2cfb73a6f0e93d3b453cfc5b776da7f5a6d469c59c4c6d3c8f2', 'Norberto Cornier', '1982-03-08', 'norbertocornier@gmail.com', '2024-05-02 19:36:28', NULL, 1, 0);

-- Dumping structure for table inyou_market.user_type
CREATE TABLE IF NOT EXISTS `user_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL COMMENT 'Verbal name of the user role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.user_type: ~3 rows (approximately)
DELETE FROM `user_type`;
INSERT INTO `user_type` (`id`, `type_name`) VALUES
	(1, 'normal'),
	(2, 'vip'),
	(3, 'admin');

-- Dumping structure for table inyou_market.vip
CREATE TABLE IF NOT EXISTS `vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) DEFAULT NULL COMMENT 'If an user is subscribed to the VIP service, they have unique discounts',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `tier` int(11) DEFAULT 1 COMMENT 'Loyalty based tier system',
  `status` tinyint(4) DEFAULT 1 COMMENT 'Enabled/Disabled',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user`),
  KEY `vip_tier` (`tier`),
  CONSTRAINT `vip_tier` FOREIGN KEY (`tier`) REFERENCES `vip_tiers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `vip_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.vip: ~3 rows (approximately)
DELETE FROM `vip`;
INSERT INTO `vip` (`id`, `user`, `start_date`, `end_date`, `tier`, `status`) VALUES
	(1, 1, '2024-04-03', NULL, 3, 1),
	(4, 2, '2024-07-27', NULL, 1, 1),
	(5, 4, '2024-06-05', '2024-07-05', 1, 0);

-- Dumping structure for table inyou_market.vip_tiers
CREATE TABLE IF NOT EXISTS `vip_tiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL COMMENT 'Name of the VIP tiers',
  `min_length` int(11) DEFAULT NULL COMMENT 'Minimum length of months that a user needs to be subscribed to recieve the tier',
  `discount` double DEFAULT NULL COMMENT 'Percentage of discount this user recieves according to the minimum length',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table inyou_market.vip_tiers: ~3 rows (approximately)
DELETE FROM `vip_tiers`;
INSERT INTO `vip_tiers` (`id`, `description`, `min_length`, `discount`) VALUES
	(1, 'VIP Member', 0, 5),
	(2, 'Gold VIP Member', 1, 7),
	(3, 'Deluxe VIP Member', 2, 10);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
