-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2025 at 10:10 PM
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
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `s_no` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_no` int(50) NOT NULL,
  `message` varchar(50) NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `s_no` int(11) NOT NULL,
  `Title` varchar(110) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `Content` varchar(11000) NOT NULL,
  `tagline` text NOT NULL,
  `img_file` varchar(15) NOT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`s_no`, `Title`, `slug`, `Content`, `tagline`, `img_file`, `Date`) VALUES
(1, 'This is my first post.', 'first-post', 'This is my first post...and i am excited about flask and blog.', '', 'about-bg.jpg', '2025-09-22 23:53:43'),
(2, 'Rocket Science', 'second-post', 'From Wikipedia, the free encyclopedia\r\n\r\nLook up rocket science in Wiktionary, the free dictionary.\r\nRocket science is a colloquial term for aerospace engineering, astronautics and orbital mechanics.\r\n\r\nIt may also include the chemistry and engineering behind rockets.\r\n\r\nIn popular terminology, rocket science is used to refer to anything overly complex, detailed or confusing.\r\n\r\nIt may also refer to:\r\n\r\nBusiness\r\nRocket science in finance, a professional activity\r\nRocket Science Games, a video game development company\r\nEntertainment\r\nRocket Science (miniseries), a 2002 documentary series\r\nRocket Science (film), a 2007 comedy-drama film\r\nRocket Science (TV series), a 2009 BBC television series\r\nIt Is Rocket Science, a 2011–14 BBC Radio 4 series\r\nIt\'s Not Rocket Science, a British television show that aired on ITV in 2016\r\nMusic\r\nRocket Science (band), an Australian alternative rock band\r\nRocket Science (Apoptygma Berzerk album), 2009\r\nRocket Science (Hugh Blumenfeld album), by folk artist Hugh Blumenfeld\r\nRocket Science (Tribal Tech album), by the jazz fusion band Tribal Tech\r\nRocket Science (Béla Fleck and the Flecktones album), 2011\r\nRocket Science (Wolf album), 2001\r\nRocket Science (Rocket Science album), 2013\r\nRocket Science (Rick Springfield album), 2016\r\n\"Not Rocket Science\" (song), a six-song music album released by Be Your Own Pet in 2007\r\n\"Rocket Science\", a song by Swedish group Icona Pop on the Spotify release of the album Icona Pop', '', '', '2025-09-23 19:34:17'),
(3, 'Flask', 'third-post', 'Welcome to Flask’s documentation. Flask is a lightweight WSGI web application framework. It is designed to make getting started quick and easy, with the ability to scale up to complex applications.\r\n\r\nGet started with Installation and then get an overview with the Quickstart. There is also a more detailed Tutorial that shows how to create a small but complete application with Flask. Common patterns are described in the Patterns for Flask section. The rest of the docs describe each component of Flask in detail, with a full reference in the API section.\r\n\r\nFlask depends on the Werkzeug WSGI toolkit, the Jinja template engine, and the Click CLI toolkit. Be sure to check their documentation as well as Flask’s when looking for information.', '', 'flask.svg', '2025-09-23 19:35:45'),
(5, 'SQL', 'fourth-post', 'What Is SQL?\r\nStructured Query Language (SQL) refers to a standard programming language utilized to extract, organize, manage, and manipulate data stored in relational databases. SQL is thereby referred to as a database language that can execute activities on databases that consist of tables made up of rows and columns.\r\n\r\nSQL plays a crucial role in retrieving relevant data from databases, which can later be used by various platforms such as Python or R for analysis purposes. SQL can manage several data transactions simultaneously where large volumes of data are written concurrently. \r\n\r\nSQL is an American National Standards Institute (ANSI) standard that operates via multiple versions and frameworks to handle backend data across various web applications supported by relational databases such as MySQL, SQL Server, Oracle PostgreSQL, and others.\r\n\r\nTop companies owned by Meta Inc., such as Facebook, WhatsApp, and Instagram, all rely on SQL for data processing and backend storage.\r\n\r\nHow does SQL work?\r\nAs an SQL query is written and run, it is processed by the ‘query language processor’ having a parser and query optimizer. The SQL server then compiles the processed query in three stages:\r\n\r\n1. Parsing: This refers to a process that cross-checks the syntax of the query.\r\n\r\n2. Binding: This step involves verifying query semantics before executing it.\r\n\r\n3. Optimization: The final step generates the query execution plan. The objective here is to identify an efficient query execution plan that runs in minimal time. This implies that the shorter the response time for the SQL query, the better the results. Several combinations of plans are generated to have a practical end execution plan.\r\n\r\n', '', 'SQL.webp', '2025-09-23 19:51:54'),
(6, 'Hello there', 'fifth-post', 'bye-bye', 'Yo', 'img.jpg', '2025-09-28 19:08:32'),
(7, 'lets get it', 'next-post', 'its Slay Time', 'you know what time it is', 'hustle.jpg', '2025-09-28 19:13:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`s_no`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `Name` (`name`) USING HASH;

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`s_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `s_no` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `s_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
