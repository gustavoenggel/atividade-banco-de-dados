CREATE DATABASE  IF NOT EXISTS "lojinhaMA78" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lojinhaMA78`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: mysql-3b5d1ac9-estudante-6967.h.aivencloud.com    Database: lojinhaMA78
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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '50a92288-3e7c-11f1-8f51-12c8edea3e45:1-81';

--
-- Table structure for table `ESTOQUE`
--

DROP TABLE IF EXISTS `ESTOQUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ESTOQUE` (
  `ID_ESTOQUE` int NOT NULL AUTO_INCREMENT,
  `id_produto` int DEFAULT NULL,
  `QUANTIDADE_ESTOQUE` int NOT NULL,
  `QUANTIDADE_MINIMA_ESTOQUE` int NOT NULL,
  `LOCALIZACAO_ESTOQUE` varchar(30) NOT NULL,
  `DATA_HORA_ENTRADA` datetime NOT NULL,
  `DATA_HORA_SAIDA` datetime NOT NULL,
  `LOTE` varchar(20) NOT NULL,
  `VALIDADE` date NOT NULL,
  `STATUS_ESTOQUE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_ESTOQUE`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `ESTOQUE_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ESTOQUE`
--

LOCK TABLES `ESTOQUE` WRITE;
/*!40000 ALTER TABLE `ESTOQUE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ESTOQUE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FORNECEDOR`
--

DROP TABLE IF EXISTS `FORNECEDOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FORNECEDOR` (
  `ID_FORNECEDOR` int NOT NULL AUTO_INCREMENT,
  `NOME_FORNECEDOR` varchar(100) NOT NULL,
  `CNPJ_FORNECEDOR` varchar(20) NOT NULL,
  `TELEFONE_FORNECEDOR` varchar(20) NOT NULL,
  `EMAIL_FORNECEDOR` varchar(100) NOT NULL,
  `STATUS_FORNECEDOR` enum('ATIVO','INATIVO','BLOQUEADO') DEFAULT NULL,
  PRIMARY KEY (`ID_FORNECEDOR`),
  UNIQUE KEY `CNPJ_FORNECEDOR` (`CNPJ_FORNECEDOR`),
  UNIQUE KEY `EMAIL_FORNECEDOR` (`EMAIL_FORNECEDOR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FORNECEDOR`
--

LOCK TABLES `FORNECEDOR` WRITE;
/*!40000 ALTER TABLE `FORNECEDOR` DISABLE KEYS */;
/*!40000 ALTER TABLE `FORNECEDOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_VENDA`
--

DROP TABLE IF EXISTS `ITEM_VENDA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_VENDA` (
  `ID_ITEM_VENDA` int NOT NULL AUTO_INCREMENT,
  `ID_VENDA` int DEFAULT NULL,
  `id_produto` int DEFAULT NULL,
  `QUANTIDADE_ITEM` int NOT NULL,
  `PRECO_ITEM` decimal(5,2) NOT NULL,
  `SUBTOTAL_ITEM` decimal(5,2) NOT NULL,
  `IMPOSTO_ITEM` decimal(5,2) DEFAULT NULL,
  `OBSERVACAO_ITEM` text,
  PRIMARY KEY (`ID_ITEM_VENDA`),
  UNIQUE KEY `ID_VENDA` (`ID_VENDA`,`id_produto`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `ITEM_VENDA_ibfk_1` FOREIGN KEY (`ID_VENDA`) REFERENCES `VENDA` (`ID_VENDA`),
  CONSTRAINT `ITEM_VENDA_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_VENDA`
--

LOCK TABLES `ITEM_VENDA` WRITE;
/*!40000 ALTER TABLE `ITEM_VENDA` DISABLE KEYS */;
/*!40000 ALTER TABLE `ITEM_VENDA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PAGAMENTO`
--

DROP TABLE IF EXISTS `PAGAMENTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PAGAMENTO` (
  `ID_PAGAMENTO` int NOT NULL AUTO_INCREMENT,
  `ID_VENDA` int DEFAULT NULL,
  `TIPO_PAGAMENTO` varchar(20) NOT NULL,
  `VALOR_PAGAMENTO` decimal(5,2) NOT NULL,
  `DATA_PAGAMENTO` datetime NOT NULL,
  `PARCELAS_PAGAMENTO` int NOT NULL,
  `IMPOSTO_PAGAMENTO` decimal(5,2) NOT NULL,
  `BANDEIRA_PAGAMENTO` varchar(20) DEFAULT 'PAGAMENTO SEM CARTAO',
  `OBSERVACAO_PAGAMENTO` text,
  PRIMARY KEY (`ID_PAGAMENTO`),
  KEY `ID_VENDA` (`ID_VENDA`),
  CONSTRAINT `PAGAMENTO_ibfk_1` FOREIGN KEY (`ID_VENDA`) REFERENCES `VENDA` (`ID_VENDA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PAGAMENTO`
--

LOCK TABLES `PAGAMENTO` WRITE;
/*!40000 ALTER TABLE `PAGAMENTO` DISABLE KEYS */;
/*!40000 ALTER TABLE `PAGAMENTO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VENDA`
--

DROP TABLE IF EXISTS `VENDA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VENDA` (
  `ID_VENDA` int NOT NULL AUTO_INCREMENT,
  `DATA_HORA_VENDA` datetime NOT NULL,
  `VALOR_TOTAL` decimal(5,2) NOT NULL,
  `FORMA_PAGAMENTO` varchar(30) NOT NULL,
  `DESCONTO_VENDA` decimal(5,2) DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `STATUS_VENDA` varchar(20) NOT NULL,
  `OBSERVACOES_VENDA` text,
  `CAIXA_VENDA` int NOT NULL,
  PRIMARY KEY (`ID_VENDA`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `VENDA_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VENDA`
--

LOCK TABLES `VENDA` WRITE;
/*!40000 ALTER TABLE `VENDA` DISABLE KEYS */;
/*!40000 ALTER TABLE `VENDA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome_cliente` varchar(100) NOT NULL,
  `sobrenome_cliente` varchar(100) DEFAULT NULL,
  `cpf_cliente` varchar(11) NOT NULL,
  `telefone_cliente` varchar(20) NOT NULL,
  `email_cliente` varchar(80) NOT NULL,
  `cidade_cliente` varchar(50) NOT NULL,
  `cep_cliente` varchar(10) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf_cliente` (`cpf_cliente`),
  UNIQUE KEY `telefone_cliente` (`telefone_cliente`),
  UNIQUE KEY `email_cliente` (`email_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Carlos','Silva','11122233344','11988887777','carlos.silva@email.com','São Paulo','01001000'),(2,'Ana','Souza','55566677788','21977776666','ana.souza@email.com','Rio de Janeiro','20040000'),(3,'Marcos','Oliveira','99988877766','47999998888','marcos.oli@email.com','Jaraguá do Sul','89251000');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `nome_produto` varchar(100) NOT NULL,
  `descricao_produto` text,
  `preco_produto` decimal(5,2) NOT NULL,
  `categoria_produto` varchar(20) NOT NULL,
  `marca_produto` varchar(20) NOT NULL,
  `codigo_barras` varchar(50) NOT NULL,
  `data_validade_produto` date DEFAULT '2026-01-01',
  `peso_produto` decimal(5,2) NOT NULL,
  `status_produto` enum('disponivel','indisponivel','NAN') DEFAULT NULL,
  PRIMARY KEY (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
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

-- Dump completed on 2026-04-22 21:29:28
