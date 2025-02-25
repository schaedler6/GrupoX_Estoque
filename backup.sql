mysqldump: [Warning] Using a password on the command line interface can be insecure.
-- MySQL dump 10.13  Distrib 9.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: superstock_solutions
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_barras` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `quantidade` int NOT NULL,
  `id_loja` int DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_item`),
  UNIQUE KEY `codigo_barras` (`codigo_barras`),
  KEY `id_loja` (`id_loja`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_loja`) REFERENCES `lojas` (`id_loja`) ON DELETE CASCADE,
  CONSTRAINT `inventario_chk_1` CHECK ((`quantidade` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (9,'Martelo','7894561230001','Martelo de ferro com cabo de madeira',50,1,25.99),(10,'Parafuso Phillips','7894561230002','Parafuso Phillips 4x30mm',500,1,0.50),(11,'Serra Circular','7894561230003','Serra Circular 7-1/4 polegadas 1400W',20,2,329.90),(12,'Cimento Portland','7894561230004','Saco de cimento 50kg',100,3,29.90);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `superstock_solutions` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_inventario_update` AFTER UPDATE ON `inventario` FOR EACH ROW BEGIN
    INSERT INTO logs_auditoria (tabela_afetada, id_registro, acao, detalhes, id_usuario)
    VALUES ('inventario', OLD.id_item, 'UPDATE', CONCAT('Quantidade alterada de ', OLD.quantidade, ' para ', NEW.quantidade), 1);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `superstock_solutions` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;

--
-- Table structure for table `logs_auditoria`
--

DROP TABLE IF EXISTS `logs_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_auditoria` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `tabela_afetada` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_registro` int NOT NULL,
  `acao` enum('INSERT','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalhes` text COLLATE utf8mb4_unicode_ci,
  `id_usuario` int DEFAULT NULL,
  `data_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `logs_auditoria_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_auditoria`
--

LOCK TABLES `logs_auditoria` WRITE;
/*!40000 ALTER TABLE `logs_auditoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lojas`
--

DROP TABLE IF EXISTS `lojas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lojas` (
  `id_loja` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `endereco` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cidade` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_loja`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lojas`
--

LOCK TABLES `lojas` WRITE;
/*!40000 ALTER TABLE `lojas` DISABLE KEYS */;
INSERT INTO `lojas` VALUES (1,'SuperStock Solutions Matriz','Av. Central, 33','Porto Alegre','RS','90000-000'),(2,'SuperStock Solutions Filial 1','Rua Secundaria, 7','Canoas','RS','92000-000'),(3,'SuperStock Solutions Filial 2','Av. Terciaria, 9','S├úo Leopoldo','RS','93000-000');
/*!40000 ALTER TABLE `lojas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacoes`
--

DROP TABLE IF EXISTS `movimentacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacoes` (
  `id_movimentacao` int NOT NULL AUTO_INCREMENT,
  `id_item` int NOT NULL,
  `origem_id` int DEFAULT NULL,
  `destino_id` int DEFAULT NULL,
  `quantidade` int NOT NULL,
  `data_movimentacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` int DEFAULT NULL,
  `status` enum('Pendente','Aprovada','Cancelada') COLLATE utf8mb4_unicode_ci DEFAULT 'Pendente',
  PRIMARY KEY (`id_movimentacao`),
  KEY `id_item` (`id_item`),
  KEY `origem_id` (`origem_id`),
  KEY `destino_id` (`destino_id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `movimentacoes_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `inventario` (`id_item`) ON DELETE CASCADE,
  CONSTRAINT `movimentacoes_ibfk_2` FOREIGN KEY (`origem_id`) REFERENCES `lojas` (`id_loja`) ON DELETE SET NULL,
  CONSTRAINT `movimentacoes_ibfk_3` FOREIGN KEY (`destino_id`) REFERENCES `lojas` (`id_loja`) ON DELETE SET NULL,
  CONSTRAINT `movimentacoes_ibfk_4` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `movimentacoes_chk_1` CHECK ((`quantidade` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacoes`
--

LOCK TABLES `movimentacoes` WRITE;
/*!40000 ALTER TABLE `movimentacoes` DISABLE KEYS */;
INSERT INTO `movimentacoes` VALUES (9,9,NULL,1,10,'2025-02-20 12:19:07',19,'Aprovada'),(10,10,NULL,1,100,'2025-02-20 12:19:07',20,'Aprovada'),(11,11,1,2,5,'2025-02-20 12:19:07',21,'Pendente'),(12,12,2,3,50,'2025-02-20 12:19:07',22,'Cancelada');
/*!40000 ALTER TABLE `movimentacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `senha_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `perfil` enum('SuperAdmin','Administrador','Gerente','Operador') COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_loja` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_loja` (`id_loja`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_loja`) REFERENCES `lojas` (`id_loja`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (5,'Vendedor 2 Matriz','vend2_matriz@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',1),(6,'Vendedor 3 Matriz','vend3_matriz@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',1),(7,'Gerente Filial 1','gerente_filial1@eterno.com','83337c927f7e095ef92b7e10b49b6bcc650bcca5cf49581fe6895c35a21bd543','Gerente',2),(8,'Vendedor 1 Filial 1','vend1_filial1@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',2),(9,'Vendedor 2 Filial 1','vend2_filial1@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',2),(10,'Vendedor 3 Filial 1','vend3_filial1@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',2),(11,'Gerente Filial 2','gerente_filial2@eterno.com','83337c927f7e095ef92b7e10b49b6bcc650bcca5cf49581fe6895c35a21bd543','Gerente',3),(12,'Vendedor 1 Filial 2','vend1_filial2@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',3),(13,'Vendedor 2 Filial 2','vend2_filial2@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',3),(14,'Vendedor 3 Filial 2','vend3_filial2@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',3),(19,'Super Admin','superadmin@eterno.com','4459b2909cef1e99ddfb4be233208753a4ed2f43343df6d5b4561c5e9ead51c9','SuperAdmin',NULL),(20,'Admin Matriz','admin_matriz@eterno.com','fe74ab45c47474d8b251b1b36400a3339bef8329bd991499c39871ff3955a5f9','Administrador',1),(21,'Gerente Matriz','gerente_matriz@eterno.com','83337c927f7e095ef92b7e10b49b6bcc650bcca5cf49581fe6895c35a21bd543','Gerente',1),(22,'Vendedor 1 Matriz','vend1_matriz@eterno.com','d05dbcac810316f46a4562e00a7b8d81f7f8e346867f7883133799891c2b5b68','Operador',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-25  0:20:34
