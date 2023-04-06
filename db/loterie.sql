-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2023 at 03:27 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `upassword`, `username`, `access`, `login_key`, `cart`, `firstName`, `lastName`, `phoneNumber`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`) VALUES
(39, 'super.alexx@yahoo.com', 'parolamea', 'lexzor', 1, '5bd49a6a4c60f1126712e37f7f19eed2', '[{\"id\":\"67\",\"tickets\":1}]', 'Nicolae', 'Alex', '0740222107', '', 'Romania', 'strada', 'nr8', '277701', 'Craiova');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `start`, `end`, `max_tickets`, `price`, `description`, `images`) VALUES
(67, 'dasdasdas', '05-04-2023 03:39', '06-04-2023 03:39', '1888', 0.1, 'dasdasdas', '[\"events_images/1680655188/16806551880download.jpg\"]');

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
  `paymentStatus` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`) VALUES
(1, 'Pavel', 'Marin', '07949099021', 'pavel@eway-design.com', '', 'Romania', 'pl n cur', '2a', '12939', 'Baicoi', 'am pl mare', '[{\"id\":\"67\",\"title\":\"BMW ROSU FA\",\"quantity\":44,\"price\":660},{\"id\":\"68\",\"title\":\"dasdsadsad\",\"quantity\":3,\"price\":45}]', 'paid'),
(2, 'Nicolae', 'Alex', '07949099021', 'super.alexx@yahoo.com', '', 'Romania', '12313', 'fwewe', 'asd', 'Baicoi2', 'am pl mareeeeeeeeeeeeeeeeeee', '[{\"id\":\"67\",\"title\":\"BMW ROSU FA\",\"quantity\":44,\"price\":660},{\"id\":\"68\",\"title\":\"dasdsadsad\",\"quantity\":3,\"price\":45}]', 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `accountEmail` text NOT NULL,
  `ticketQuantity` int(6) NOT NULL,
  `eventId` int(11) NOT NULL,
  `createdAt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `accountEmail`, `ticketQuantity`, `eventId`, `createdAt`) VALUES
(1, 'super.alexx@yahoo.com', 777, 67, '2023-04-02'),
(2, 'super.alexx@yahoo.com', 3, 68, '2023-04-02'),
(3, 'super.alexx@yahoo.com', 300, 67, '2023-04-03');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
