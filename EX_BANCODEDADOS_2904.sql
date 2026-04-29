CREATE DATABASE  IF NOT EXISTS "CINEMA" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `CINEMA`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: mysql-3b5d1ac9-estudante-6967.h.aivencloud.com    Database: CINEMA
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '50a92288-3e7c-11f1-8f51-12c8edea3e45:1-81,
8aba6b95-43f7-11f1-b623-c27412d3c505:1-54';

--
-- Table structure for table `CATEGORIA`
--

DROP TABLE IF EXISTS `CATEGORIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORIA` (
  `ID_CATEGORIA` int NOT NULL AUTO_INCREMENT,
  `DESCRISAO_CAT` varchar(30) NOT NULL,
  PRIMARY KEY (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORIA`
--

LOCK TABLES `CATEGORIA` WRITE;
/*!40000 ALTER TABLE `CATEGORIA` DISABLE KEYS */;
INSERT INTO `CATEGORIA` VALUES (1,'Ação'),(2,'Comédia'),(3,'Ficção Científica'),(4,'Terror'),(5,'Animação');
/*!40000 ALTER TABLE `CATEGORIA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENTE`
--

DROP TABLE IF EXISTS `CLIENTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENTE` (
  `ID_CLIENTE` int NOT NULL AUTO_INCREMENT,
  `NOME_CLIENTE` varchar(100) NOT NULL,
  `CPF_CLIENTE` varchar(15) NOT NULL,
  `EMAIL_CLIENTE` varchar(30) NOT NULL,
  `STATUS_CLIENTE` enum('ATIVO','INATIVO') DEFAULT NULL,
  PRIMARY KEY (`ID_CLIENTE`),
  UNIQUE KEY `CPF_CLIENTE` (`CPF_CLIENTE`),
  UNIQUE KEY `EMAIL_CLIENTE` (`EMAIL_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENTE`
--

LOCK TABLES `CLIENTE` WRITE;
/*!40000 ALTER TABLE `CLIENTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FILME`
--

DROP TABLE IF EXISTS `FILME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FILME` (
  `ID_FILME` int NOT NULL AUTO_INCREMENT,
  `NOME_FILME` varchar(100) NOT NULL,
  `FAIXA_ETARIA` int DEFAULT NULL,
  `DURACAO_FILME` int NOT NULL,
  `STATUS_FILME` enum('EM CARTAZ','FORA CARTAZ') DEFAULT NULL,
  `ID_CATEGORIA_FILME` int NOT NULL,
  PRIMARY KEY (`ID_FILME`),
  KEY `ID_CATEGORIA_FILME` (`ID_CATEGORIA_FILME`),
  CONSTRAINT `FILME_ibfk_1` FOREIGN KEY (`ID_CATEGORIA_FILME`) REFERENCES `CATEGORIA` (`ID_CATEGORIA`),
  CONSTRAINT `FILME_chk_1` CHECK ((`FAIXA_ETARIA` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FILME`
--

LOCK TABLES `FILME` WRITE;
/*!40000 ALTER TABLE `FILME` DISABLE KEYS */;
/*!40000 ALTER TABLE `FILME` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INGRESSO`
--

DROP TABLE IF EXISTS `INGRESSO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INGRESSO` (
  `ID_INGRESSO` int NOT NULL AUTO_INCREMENT,
  `ID_PEDIDO` int NOT NULL,
  `ID_SESSAO` int NOT NULL,
  `ID_TIPO_INGRESSO` int NOT NULL,
  `VALOR_PAGO` decimal(5,2) NOT NULL,
  `STATUS_INGRESSO` enum('RESERVADO','PAGO','CANCELADO') DEFAULT 'RESERVADO',
  PRIMARY KEY (`ID_INGRESSO`),
  KEY `ID_PEDIDO` (`ID_PEDIDO`),
  KEY `ID_SESSAO` (`ID_SESSAO`),
  KEY `ID_TIPO_INGRESSO` (`ID_TIPO_INGRESSO`),
  CONSTRAINT `INGRESSO_ibfk_1` FOREIGN KEY (`ID_PEDIDO`) REFERENCES `PEDIDO` (`id_pedido`),
  CONSTRAINT `INGRESSO_ibfk_2` FOREIGN KEY (`ID_SESSAO`) REFERENCES `SESSAO` (`ID_SESSAO`),
  CONSTRAINT `INGRESSO_ibfk_3` FOREIGN KEY (`ID_TIPO_INGRESSO`) REFERENCES `TIPO_INGRESSO` (`ID_TIPO_INGRESSO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INGRESSO`
--

LOCK TABLES `INGRESSO` WRITE;
/*!40000 ALTER TABLE `INGRESSO` DISABLE KEYS */;
/*!40000 ALTER TABLE `INGRESSO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PEDIDO`
--

DROP TABLE IF EXISTS `PEDIDO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PEDIDO` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `ID_CLIENTE` int DEFAULT NULL,
  `status_pedido` enum('aberto','pago','cancelado') DEFAULT 'aberto',
  PRIMARY KEY (`id_pedido`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`),
  CONSTRAINT `PEDIDO_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `CLIENTE` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PEDIDO`
--

LOCK TABLES `PEDIDO` WRITE;
/*!40000 ALTER TABLE `PEDIDO` DISABLE KEYS */;
/*!40000 ALTER TABLE `PEDIDO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SALA`
--

DROP TABLE IF EXISTS `SALA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SALA` (
  `ID_SALA` int NOT NULL AUTO_INCREMENT,
  `DESCRISAO_SALA` text NOT NULL,
  `TIPO_SALA` enum('2D','3D','IMAX') DEFAULT '2D',
  `CAPACIDADE_SALA` int NOT NULL,
  `VIP_SALA` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID_SALA`),
  CONSTRAINT `SALA_chk_1` CHECK ((`CAPACIDADE_SALA` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SALA`
--

LOCK TABLES `SALA` WRITE;
/*!40000 ALTER TABLE `SALA` DISABLE KEYS */;
/*!40000 ALTER TABLE `SALA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SESSAO`
--

DROP TABLE IF EXISTS `SESSAO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SESSAO` (
  `ID_SESSAO` int NOT NULL AUTO_INCREMENT,
  `DATA_HORA` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_SALA` int NOT NULL,
  `ID_FILME` int NOT NULL,
  `STATUS_SESSAO` enum('ABERTA','ENCERRADA','CANCELADA') DEFAULT 'ABERTA',
  PRIMARY KEY (`ID_SESSAO`),
  UNIQUE KEY `DATA_HORA` (`DATA_HORA`,`ID_SALA`),
  KEY `ID_SALA` (`ID_SALA`),
  KEY `ID_FILME` (`ID_FILME`),
  CONSTRAINT `SESSAO_ibfk_1` FOREIGN KEY (`ID_SALA`) REFERENCES `SALA` (`ID_SALA`),
  CONSTRAINT `SESSAO_ibfk_2` FOREIGN KEY (`ID_FILME`) REFERENCES `FILME` (`ID_FILME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SESSAO`
--

LOCK TABLES `SESSAO` WRITE;
/*!40000 ALTER TABLE `SESSAO` DISABLE KEYS */;
/*!40000 ALTER TABLE `SESSAO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TIPO_INGRESSO`
--

DROP TABLE IF EXISTS `TIPO_INGRESSO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TIPO_INGRESSO` (
  `ID_TIPO_INGRESSO` int NOT NULL AUTO_INCREMENT,
  `DESCRISAO_INGRESSO` varchar(50) NOT NULL,
  `valor_ingresso` decimal(5,2) NOT NULL,
  PRIMARY KEY (`ID_TIPO_INGRESSO`),
  CONSTRAINT `TIPO_INGRESSO_chk_1` CHECK ((`valor_ingresso` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TIPO_INGRESSO`
--

LOCK TABLES `TIPO_INGRESSO` WRITE;
/*!40000 ALTER TABLE `TIPO_INGRESSO` DISABLE KEYS */;
/*!40000 ALTER TABLE `TIPO_INGRESSO` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-29 17:04:29
