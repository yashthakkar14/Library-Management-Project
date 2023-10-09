-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: library_management
-- ------------------------------------------------------
-- Server version	8.0.30

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

CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `bookID` int NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  `authors` varchar(256) DEFAULT NULL,
  `average_rating` decimal(3,2) DEFAULT NULL,
  `isbn` varchar(10) DEFAULT NULL,
  `isbn13` varchar(13) DEFAULT NULL,
  `language_code` varchar(10) DEFAULT NULL,
  `num_pages` int DEFAULT NULL,
  `ratings_count` int DEFAULT NULL,
  `text_reviews_count` int DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `publisher` varchar(256) DEFAULT NULL,
  `total_quantity` int DEFAULT '1',
  `available_quantity` int DEFAULT '1',
  `book_fees` int DEFAULT '50',
  PRIMARY KEY (`bookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Harry Potter and the Half-Blood Prince (Harry Potter  #6)','J.K. Rowling/Mary GrandPré',4.57,'0439785960','9780439785969','eng',NULL,2095690,27591,'2006-09-16','Scholastic Inc.',18,16,200),(2,'Harry Potter and the Order of the Phoenix (Harry Potter  #5)','J.K. Rowling/Mary GrandPré',4.49,'0439358078','9780439358071','eng',NULL,2153167,29221,'2004-09-01','Scholastic Inc.',9,9,50),(4,'Harry Potter and the Chamber of Secrets (Harry Potter  #2)','J.K. Rowling',4.42,'0439554896','9780439554893','eng',NULL,6333,244,'2003-11-01','Scholastic',9,9,50),(8,'Harry Potter Boxed Set  Books 1-5 (Harry Potter  #1-5)','J.K. Rowling/Mary GrandPré',4.78,'0439682584','9780439682589','eng',NULL,41428,164,'2004-09-13','Scholastic',18,18,50),(1177,'Liar\'s Poker: A Harry Garnish Mystery','Frank McConnell',3.31,'0802732291','9780802732293','eng',NULL,13,1,'1993-06-01','Walker & Company',6,4,50),(1226,'Life of Pi','Yann Martel',3.91,'0156030209','9780156030205','en-US',NULL,4318,668,'2004-05-03','Mariner Books / Harvest Books',1,1,50),(2002,'Harry Potter Schoolbooks Box Set: Two Classic Books from the Library of Hogwarts School of Witchcraft and Wizardry','J.K. Rowling',4.40,'043932162X','9780439321624','eng',NULL,11515,139,'2001-11-01','Arthur A. Levine',9,9,50),(2123,'The 36-Hour Day: A Family Guide to Caring for Persons with Alzheimer Disease  Related Dementing Illnesses  and Memory Loss in Later Life','Nancy L. Mace/Peter V. Rabins',4.24,'0446618764','9780446618762','eng',NULL,69,6,'2006-11-01','Grand Central Life & Style',1,1,50),(2543,'Las intermitencias de la muerte','José Saramago/Pilar del Río',4.00,'9587043642','9789587043648','spa',NULL,2862,306,'2005-12-01','Alfaguara',1,1,50),(2912,'Escape from Fire Mountain (World of Adventure  #3)','Gary Paulsen/Steve Chorney',3.67,'0440410258','9780440410256','eng',NULL,114,17,'1995-01-01','Yearling',1,1,50),(8598,'Eats  Shoots & Leaves: Why  Commas Really Do Make a Difference!','Lynne Truss/Bonnie Timmons',4.15,'0399244913','9780399244919','eng',NULL,1371,205,'2006-07-25','G.P. Putnam\'s Sons Books for Young Readers',1,1,50),(9742,'The Audacity of Hope: Thoughts on Reclaiming the American Dream','Barack Obama',3.75,'0307237699','9780307237699','eng',NULL,127324,4496,'2006-10-17','Crown',1,1,50),(10767,'Merde!: The Real French You Were Never Taught at School','Geneviève/Michael    Heath',3.96,'0684854279','9780684854274','eng',NULL,155,13,'1998-12-09','Gallery Books',1,1,50),(10970,'Outlander','Matt Keefe',3.85,'184416411X','9781844164110','eng',NULL,54,5,'2006-12-26','Games Workshop(uk)',1,1,50),(13028,'Alice In Wonderland','Lewis Carroll/John Tenniel',4.02,'0439291496','9780439291491','eng',NULL,143,18,'2001-09-01','Scholastic Paperbacks',2,2,50),(14258,'English Passengers','Matthew Kneale',4.06,'0140285210','9780140285215','en-GB',NULL,537,65,'2001-04-26','Penguin',1,1,50),(15004,'First Love: A Gothic Tale','Joyce Carol Oates/Barry Moser/Erhan Sunar',3.19,'088001508X','9780880015080','eng',NULL,579,83,'1997-08-21','Ecco',1,1,50),(15867,'Mugglenet.Com\'s What Will Happen in Harry Potter 7: Who Lives  Who Dies  Who Falls in Love and How Will the Adventure Finally End?','Ben Schoen/Andy Gordon/Gretchen Stull/Emerson Spartz/Jamie Lawrence',4.23,'1569755833','9781569755839','en-GB',NULL,9023,112,'2006-10-19','Ulysses Press',9,9,50),(15876,'Harry Potter y la Orden del Fénix (Harry Potter  #5)','J.K. Rowling',4.49,'8478888845','9788478888849','spa',NULL,5637,458,'2004-02-21','Emece Editores',9,9,50),(15877,'Ultimate Unofficial Guide to the Mysteries of Harry Potter: Analysis of Books 1-4','Galadriel Waters/Astre Mithrandir',4.05,'0972393617','9780972393614','en-US',NULL,2774,37,'2003-01-01','Wizarding World Press',9,9,50),(17946,'Seven Nights','Jorge Luis Borges/Eliot Weinberger',4.33,'0811209059','9780811209052','eng',NULL,1037,60,'1985-05-29','New Directions Publishing Corporation',1,1,50),(18297,'The Anime Encyclopedia: A Guide to Japanese Animation Since 1917','Jonathan Clements/Helen McCarthy',4.04,'1933330104','9781933330105','eng',NULL,25,5,'2006-11-01','Stone Bridge Press',1,1,50),(21539,'Echo Park (Harry Bosch  #12; Harry Bosch Universe  #16)','Michael Connelly/Len Cariou',4.12,'1594835896','9781594835896','eng',NULL,174,35,'2006-10-09','Little  Brown & Company',6,6,50),(25257,'Mein Urgroßvater  die Helden und ich','James Krüss',4.30,'3551552711','9783551552716','ger',NULL,16,1,'2002-12-01','Carlsen',1,1,50),(28869,'Pégate un tiro para sobrevivir: un viaje personal por la América de los mitos','Chuck Klosterman',3.81,'8439720033','9788439720034','spa',NULL,27,2,'2006-02-28','Literatura Random House',1,1,50),(29680,'The Coen Brothers: Interviews','William Rodney Allen',3.82,'1578068894','9781578068890','eng',NULL,73,3,'2006-08-18','University Press of Mississippi',1,1,50),(31819,'Harry Potter and Philosophy: If Aristotle Ran Hogwarts','David Baggett/Shawn E. Klein',4.48,'0812694554','9780812694550','eng',NULL,11422,78,'2004-09-10','Open Court',9,9,50),(32501,'Echo Park (Harry Bosch  #12; Harry Bosch Universe  #16)','Michael Connelly',4.12,'0316734950','9780316734950','eng',NULL,36333,1511,'2006-10-09','Little  Brown & Company',6,6,50),(32637,'Imajica: The Reconciliation','Clive Barker',4.42,'0061094153','9780061094156','eng',NULL,2583,30,'1995-05-10','HarperTorch',1,1,50),(32816,'The Canterbury Tales: Fifteen Tales and the General Prologue','Geoffrey Chaucer/V.A. Kolve/Glending Olson',3.95,'0393925870','9780393925876','enm',NULL,1149,41,'2005-08-01','W. W. Norton & Company',1,1,50),(33308,'There\'s No Toilet Paper . . . on the Road Less Traveled: The Best of Travel Humor and Misadventure','Doug Lansky',3.38,'1932361278','9781932361278','eng',NULL,413,53,'2005-11-16','Travelers\' Tales',1,1,50),(39763,'The Mystical Poems of Rumi 1: First Selection  Poems 1-200','Rumi/A.J. Arberry',4.28,'0226731510','9780226731513','eng',NULL,114,8,'1974-03-15','University Of Chicago Press',1,1,50),(41909,'Harry Potter ve Sırlar Odası (Harry Potter  #2)','J.K. Rowling/Sevin Okyay',4.42,'3570211029','9783570211021','tur',NULL,1000,41,'2001-10-01','Yapı Kredi Yayınları',9,9,50),(44145,'The Bar on the Seine','Georges Simenon/David Watson',3.69,'0143038311','9780143038313','en-US',NULL,380,54,'2006-12-26','Penguin Books',1,1,50),(44229,'The Silver Pigs (Marcus Didius Falco  #1)','Lindsey Davis',3.94,'0345369076','9780345369079','eng',NULL,144,26,'1991-02-13','Fawcett Books',1,1,50);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `memberID` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone_number` bigint DEFAULT NULL,
  `outstanding_balance` int DEFAULT NULL,
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'John Doe','john@example.com',1234567890,0),(2,'Alice Smith','alice@example.com',9876543210,0),(3,'Bob Johnson','bobj@example.com',5551234567,0),(4,'Eva Brown','eva@example.com',7778889999,500),(5,'Charlie Lee','charlie@example.com',1112223333,0),(230,'Yash','yasht1407@gmail.com',9076225742,0),(231,'Sagar','sagar@gmail.com',1234567890,0),(232,'Vinit','vinit@gmail.com',1234567890,0),(233,'Tom','tom@gmail.com',1234567890,0),(234,'Abhay','abha2y@gmail.com',987654321,0);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `bookID` int DEFAULT NULL,
  `memberID` int DEFAULT NULL,
  `bookPrice` int DEFAULT NULL,
  `bookAssigned` tinyint(1) DEFAULT NULL,
  `bookReturned` tinyint(1) DEFAULT NULL,
  `transactionID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`transactionID`),
  KEY `FK_bookID` (`bookID`),
  KEY `FK_memberID` (`memberID`),
  CONSTRAINT `FK_bookID` FOREIGN KEY (`bookID`) REFERENCES `books` (`bookID`),
  CONSTRAINT `FK_memberID` FOREIGN KEY (`memberID`) REFERENCES `members` (`memberID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,230,200,1,1,1),(2,231,50,1,1,2),(1177,4,50,1,0,3),(1,4,200,1,0,4),(1,4,200,1,0,5),(1177,4,50,1,0,6),(1226,234,50,1,1,7);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-09 16:49:34
