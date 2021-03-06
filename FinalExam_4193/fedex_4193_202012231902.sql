﻿--
-- Script was generated by Devart dbForge Studio 2020 for MySQL, Version 9.0.435.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 23/12/2020 19:02:22
-- Server version: 8.0.21
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE fedex_4193;

--
-- Drop table `stat`
--
DROP TABLE IF EXISTS stat;

--
-- Drop procedure `status`
--
DROP PROCEDURE IF EXISTS status;

--
-- Drop table `delivery`
--
DROP TABLE IF EXISTS delivery;

--
-- Drop table `status_delivery`
--
DROP TABLE IF EXISTS status_delivery;

--
-- Drop view `packages`
--
DROP VIEW IF EXISTS packages CASCADE;

--
-- Drop table `packet`
--
DROP TABLE IF EXISTS packet;

--
-- Drop table `client`
--
DROP TABLE IF EXISTS client;

--
-- Drop table `packetprice`
--
DROP TABLE IF EXISTS packetprice;

--
-- Drop table `recipient`
--
DROP TABLE IF EXISTS recipient;

--
-- Set default database
--
USE fedex_4193;

--
-- Create table `recipient`
--
CREATE TABLE recipient (
  id_recipient INT NOT NULL AUTO_INCREMENT,
  fulName VARCHAR(255) DEFAULT NULL,
  address VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id_recipient)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

--
-- Create table `packetprice`
--
CREATE TABLE packetprice (
  id_packet_Price INT NOT NULL AUTO_INCREMENT,
  weight VARCHAR(255) NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (id_packet_Price)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

--
-- Create table `client`
--
CREATE TABLE client (
  id_Client INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_Client)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

--
-- Create table `packet`
--
CREATE TABLE packet (
  id_packet INT NOT NULL AUTO_INCREMENT,
  Fk_price_packet INT NOT NULL,
  Fk_client INT NOT NULL,
  Fk_recipient INT NOT NULL,
  datePacket DATETIME DEFAULT NULL,
  PRIMARY KEY (id_packet)
)
ENGINE = INNODB,
AUTO_INCREMENT = 12,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

--
-- Create foreign key
--
ALTER TABLE packet 
  ADD CONSTRAINT FK_packet_client_id_Client FOREIGN KEY (Fk_client)
    REFERENCES client(id_Client);

--
-- Create foreign key
--
ALTER TABLE packet 
  ADD CONSTRAINT FK_packet_packetprice_id_packet_Price FOREIGN KEY (Fk_price_packet)
    REFERENCES packetprice(id_packet_Price);

--
-- Create foreign key
--
ALTER TABLE packet 
  ADD CONSTRAINT FK_packet_recipient_id_recipient FOREIGN KEY (Fk_recipient)
    REFERENCES recipient(id_recipient);

--
-- Create view `packages`
--
CREATE 
	DEFINER = 'root'@'localhost'
VIEW packages
AS
SELECT
  `client`.`id_Client` AS `ClientID`,
  SUM(`packet`.`id_packet`) AS `PacketSum`
FROM (`client`
  JOIN `packet`
    ON ((`client`.`id_Client` = `packet`.`Fk_client`)));

--
-- Create table `status_delivery`
--
CREATE TABLE status_delivery (
  Id_status INT NOT NULL AUTO_INCREMENT,
  status VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (Id_status)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

--
-- Create table `delivery`
--
CREATE TABLE delivery (
  Id_delivery INT NOT NULL AUTO_INCREMENT,
  Id_packet INT NOT NULL,
  Id_status INT NOT NULL,
  date_delivered DATETIME NOT NULL,
  PRIMARY KEY (Id_delivery)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

--
-- Create foreign key
--
ALTER TABLE delivery 
  ADD CONSTRAINT FK_delivery_packet_id_packet FOREIGN KEY (Id_packet)
    REFERENCES packet(id_packet);

--
-- Create foreign key
--
ALTER TABLE delivery 
  ADD CONSTRAINT FK_delivery_status_delivery_Id_status FOREIGN KEY (Id_status)
    REFERENCES status_delivery(Id_status);

DELIMITER $$

--
-- Create procedure `status`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE status(IN packet_id INTEGER)
BEGIN
SELECT
  packet.id_packet,
  status_delivery.status
FROM packet
  INNER JOIN delivery
    ON packet.id_packet = delivery.Id_packet
  INNER JOIN status_delivery
    ON delivery.Id_status = status_delivery.Id_status
WHERE packet.id_packet = packet_id;
END
$$

DELIMITER ;

--
-- Create table `stat`
--
CREATE TABLE stat (
  ID_STAT INT NOT NULL AUTO_INCREMENT,
  Desc_STAT VARCHAR(500) DEFAULT NULL,
  DATE_STAT DATETIME NOT NULL,
  PRIMARY KEY (ID_STAT)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

-- 
-- Dumping data for table recipient
--
INSERT INTO recipient VALUES
(1, 'Recipient 1', 'Address 1'),
(2, 'Recipient 2', 'Address 2'),
(3, 'Recipient 3', 'Address 3');

-- 
-- Dumping data for table packetprice
--
INSERT INTO packetprice VALUES
(1, '0-2 kg', 200),
(2, '2-4 kg', 400),
(3, '4-8 kg', 800),
(4, '8-12 kg', 1500),
(5, '12 kg+', 4000);

-- 
-- Dumping data for table client
--
INSERT INTO client VALUES
(1, 'Client 1', 'pClient 1', 'address 1', 'City 1', 'email1@mail.com'),
(2, 'Client 2', 'pClient 2', 'address 2', 'City 2', 'email2@mail.com'),
(3, 'Client 3', 'pClient 3', 'address 3', 'City 3', 'email3@mail.com');

-- 
-- Dumping data for table status_delivery
--
INSERT INTO status_delivery VALUES
(1, 'Packet preparation'),
(2, 'Packet in Transit'),
(3, 'Delivery Completed'),
(4, 'Cancelled'),
(5, 'UnKnown');

-- 
-- Dumping data for table packet
--
INSERT INTO packet VALUES
(1, 1, 1, 1, '2015-09-01 10:02:21'),
(2, 2, 2, 2, '2012-12-05 10:03:31'),
(3, 3, 3, 3, '2013-07-11 10:10:02'),
(4, 4, 1, 2, '2015-08-12 15:10:32'),
(5, 5, 3, 1, '2015-12-02 11:26:00'),
(7, 2, 1, 1, '2015-12-08 11:40:04'),
(8, 2, 3, 1, '2015-12-12 11:40:54'),
(9, 4, 1, 2, NULL),
(10, 4, 1, 2, NULL),
(11, 4, 1, 2, NULL);

-- 
-- Dumping data for table stat
--
INSERT INTO stat VALUES
(1, 'Inserted packet with 9and price4', '2020-12-23 17:57:00'),
(2, 'Inserted packet with ID 10and price 4', '2020-12-23 17:58:02'),
(3, 'Inserted packet with ID 11 and price 4', '2020-12-23 17:58:44');

-- 
-- Dumping data for table delivery
--
INSERT INTO delivery VALUES
(1, 1, 1, '2015-10-07 10:12:52'),
(2, 1, 2, '2015-10-09 10:12:52'),
(3, 1, 3, '2015-10-20 10:12:52'),
(4, 2, 1, '2015-01-15 00:00:00'),
(5, 2, 2, '2015-02-04 00:00:00'),
(6, 3, 1, '2015-12-01 10:20:48'),
(7, 3, 2, '2015-12-08 10:21:04'),
(8, 3, 4, '2015-12-15 10:21:25'),
(9, 4, 1, '2015-12-09 10:25:03'),
(10, 4, 5, '2015-12-11 10:25:16');

--
-- Set default database
--
USE fedex_4193;

--
-- Drop trigger `packetin`
--
DROP TRIGGER IF EXISTS packetin;

--
-- Set default database
--
USE fedex_4193;

DELIMITER $$

--
-- Create trigger `packetin`
--
CREATE 
	DEFINER = 'root'@'localhost'
TRIGGER packetin
	AFTER INSERT
	ON packet
	FOR EACH ROW
BEGIN
declare p int(11);
SELECT
  Fk_price_packet INTO p
FROM packet
WHERE id_packet = new.id_packet;

INSERT INTO stat
SET DESC_Stat = CONCAT('Inserted packet with ID ', NEW.id_packet, ' and price ', p),
    Date_Stat = NOW();
END
$$

DELIMITER ;

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;