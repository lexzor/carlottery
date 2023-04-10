-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2023 at 03:58 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `loterie`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `upassword` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `access` int(11) NOT NULL DEFAULT 0,
  `login_key` varchar(33) NOT NULL,
  `cart` text DEFAULT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `companyName` text NOT NULL,
  `country` text NOT NULL,
  `streetName` text NOT NULL,
  `houseNumber` text NOT NULL,
  `postCode` text NOT NULL,
  `city` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `upassword`, `username`, `access`, `login_key`, `cart`, `firstName`, `lastName`, `phoneNumber`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`) VALUES
(39, 'super.alexx@yahoo.com', 'parolamea', 'lexzor', 1, 'baeb4a5e048f4cd779bbd041cd9fb80b', '[{\"id\":\"73\",\"tickets\":1}]', 'Nicolae', 'Alex', '0740222107', '', 'Romania', 'strada', 'nr8', '277701', 'Craiova');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `start` text NOT NULL,
  `end` text NOT NULL,
  `max_tickets` text NOT NULL,
  `price` float NOT NULL,
  `description` text NOT NULL,
  `images` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `start`, `end`, `max_tickets`, `price`, `description`, `images`) VALUES
(67, 'dasdasdas', '05-04-2023 03:39', '13-04-2023 22:46', '1888', 2, 'dasdasdas', '[\"events_images/1680655188/16806551880download.jpg\"]'),
(73, 'pros', '06-04-2023 22:46', '13-04-2023 22:47', '500', 2, 'pors puternic', '[\"events_images/1680817636/16808176360porsche.png\"]');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `emailAddress` text NOT NULL,
  `companyName` text NOT NULL,
  `country` text NOT NULL,
  `streetName` text NOT NULL,
  `houseNumber` text NOT NULL,
  `postCode` text NOT NULL,
  `city` text NOT NULL,
  `notes` text NOT NULL,
  `products` text NOT NULL,
  `paymentStatus` text NOT NULL,
  `createdAt` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`, `createdAt`) VALUES
(1, 'Pavel', 'Marin', '+447949099021', 'super.alexx@yahoo.com', '', 'Regatul Unit', '4a malvern terrace winchester road', '', 'SO166TQ', 'Southampton', '', '[{\"id\":\"67\",\"title\":\"dasdasdas\",\"quantity\":1,\"price\":2},{\"id\":\"73\",\"title\":\"pros\",\"quantity\":1,\"price\":2}]', 'paid', '2023-04-10 03:54:42');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `accountEmail` text NOT NULL,
  `ticketQuantity` int(6) NOT NULL,
  `eventId` int(11) NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `createdAt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `accountEmail`, `ticketQuantity`, `eventId`, `invoiceId`, `createdAt`) VALUES
(1, 'super.alexx@yahoo.com', 1, 67, 1, '2023-04-10 03:54:42'),
(2, 'super.alexx@yahoo.com', 1, 73, 1, '2023-04-10 03:54:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
