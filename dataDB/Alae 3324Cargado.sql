-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.39 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para alae
CREATE DATABASE IF NOT EXISTS `alae` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `alae`;

-- Volcando estructura para tabla alae.alae_analyte
CREATE TABLE IF NOT EXISTS `alae_analyte` (
  `pk_analyte` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `shortening` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_analyte`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_analyte_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_analyte: ~227 rows (aproximadamente)
DELETE FROM `alae_analyte`;
/*!40000 ALTER TABLE `alae_analyte` DISABLE KEYS */;
INSERT INTO `alae_analyte` (`pk_analyte`, `name`, `shortening`, `updated_at`, `status`, `fk_user`) VALUES
	(1, 'Atorvastatin', 'ATOR', '2014-04-16 14:14:47', 1, 8),
	(2, 'Anapharina', 'ANAP', '2014-04-29 11:02:43', 0, 12),
	(3, 'Atorvastatin-d5', 'ATOR-d5', '2014-04-16 14:20:12', 1, 8),
	(4, 'Efavirenz', 'EFA', '2014-04-30 12:29:17', 1, 8),
	(5, 'Efavirenz-d5', 'EFA-d5', '2014-04-30 12:29:50', 1, 8),
	(6, 'Moxifloxacin', 'MOXI', '2014-07-17 12:44:38', 1, 8),
	(7, 'Moxifloxacin-d4', 'MOXI-d4', '2014-07-17 12:45:14', 1, 8),
	(8, 'Ivabradine', 'IVA', '2014-08-05 11:06:10', 1, 8),
	(9, 'Ivabradine-d6', 'IVA-d6', '2014-08-05 11:06:47', 1, 8),
	(10, 'R-Doxylamine', 'R-DOX', '2014-08-08 11:16:46', 1, 8),
	(11, 'S-Doxylamine', 'S-DOX', '2014-08-08 11:17:39', 1, 8),
	(12, 'R-Doxylamine-d5', 'R-DOX-d5', '2014-08-08 11:30:08', 1, 8),
	(13, 'S-Doxylamine-d5', 'S-DOX-d5', '2014-08-08 11:30:08', 1, 8),
	(14, 'Amlodipine', 'AML', '2014-09-03 10:21:33', 1, 8),
	(15, 'Amlodipine-d4', 'AML-d4', '2014-09-03 10:22:54', 1, 8),
	(16, '(+)-Donepezil', '(+)-DON', '2014-09-29 14:57:07', 1, 8),
	(17, '(-)-Donepezil', '(-)-DON', '2014-09-29 14:58:04', 1, 8),
	(18, 'Donepezil-d4', 'DON-d4', '2014-09-29 14:58:55', 1, 8),
	(19, 'Pyridoxal', 'PYR', '2014-09-29 14:59:38', 1, 8),
	(20, 'Pyridoxal-d3', 'PYR-d3', '2014-09-29 15:00:20', 1, 8),
	(21, 'Pyridoxine', 'PYRE', '2014-09-29 15:00:52', 1, 8),
	(22, 'Pyridoxine-d3', 'PYRE-d3', '2014-09-29 15:01:54', 1, 8),
	(23, 'Pyridoxal 5-Phosphate', '5P-PYR', '2014-09-29 15:05:30', 1, 8),
	(24, 'Pyridoxal-d3 5-Phosphate', '5P-PYR-d3', '2014-09-29 15:06:25', 1, 8),
	(25, '3-Hydroxy Desloratadine', '3-OH-DESLO', '2014-09-29 15:08:53', 1, 8),
	(26, 'Desloratadine-d5', 'DESLO-d5', '2014-09-29 15:13:08', 1, 8),
	(27, 'Dutasteride', 'DUT', '2014-10-17 11:27:19', 1, 14),
	(28, 'Dutasteride-13C6', 'DUT-13C6', '2014-10-17 11:29:53', 1, 14),
	(29, 'Rasagiline', 'RAS', '2014-11-06 08:47:55', 1, 8),
	(30, 'Rasagiline-13C3', 'RAS-13C3', '2014-11-06 08:48:50', 1, 8),
	(31, 'Sildenafil', 'SIL', '2014-11-24 08:35:08', 1, 8),
	(32, 'Sildenafil-d8', 'SIL-d8', '2014-11-24 08:35:38', 1, 8),
	(33, 'Tiotropium', 'TIO', '2014-11-25 11:00:35', 1, 8),
	(34, 'Tiotropium-d3', 'TIO-d3', '2014-11-25 11:01:24', 1, 8),
	(35, 'Ezetimibe', 'EZE', '2014-11-25 14:48:39', 1, 8),
	(36, 'Ezetimibe-d4', 'EZE-d4', '2014-11-25 14:48:39', 1, 8),
	(37, 'Desloratadine', 'DESLO', '2014-11-26 09:41:38', 1, 8),
	(38, 'Bilastine', 'BILA', '2014-12-01 09:08:56', 1, 8),
	(39, 'Bilastine-d6', 'BILA-d6', '2014-12-01 09:09:32', 1, 8),
	(40, 'Trazodone', 'TRAZO', '2014-12-09 12:40:11', 1, 8),
	(41, 'Trazodone-d6', 'TRAZO-d6', '2014-12-09 12:40:45', 1, 8),
	(42, 'Vitamin D3', 'VD3', '2014-12-19 09:46:19', 1, 8),
	(43, 'Vitamin D3-d7', 'VD3-d7', '2014-12-19 09:45:38', 1, 8),
	(73, 'Risperidone', 'RISP', '2014-12-24 16:59:34', 1, 8),
	(74, 'Risperidone-d4', 'RISP-d4', '2014-12-24 17:00:05', 1, 8),
	(75, '9-Hydroxy Risperidone', 'OH-RISP', '2014-12-24 17:00:43', 1, 8),
	(76, '9-Hydroxy Risperidone-d4', 'OH-RISP-d4', '2014-12-24 17:01:13', 1, 8),
	(77, 'Alendronic Acid', 'ALEN', '2014-12-24 17:41:57', 1, 8),
	(78, 'Alendronic Acid-d6', 'ALEN-d6', '2014-12-24 17:42:20', 1, 8),
	(79, 'Rosuvastatin', 'ROSU', '2015-01-05 07:37:19', 1, 8),
	(80, 'Rosuvastatin-d3', 'ROSU-d3', '2015-01-05 07:37:47', 1, 8),
	(81, 'Olmesartan', 'OLM', '2015-02-18 12:32:35', 1, 8),
	(82, 'Olmesartan-d4', 'OLM-d4', '2015-02-18 12:33:02', 1, 8),
	(83, 'Hydrochlorothiazide', 'HCTZ', '2015-02-18 12:33:46', 1, 8),
	(84, 'Hydrochlorothiazide15N2-13C-d2', 'HCTZ15N2-13C-d2', '2015-02-19 08:05:43', 1, 8),
	(85, '4-Methylaminoantipyrine', 'MAA', '2015-03-19 09:09:06', 1, 8),
	(86, 'Ramifenazone', 'RMF', '2015-03-19 09:09:06', 1, 8),
	(87, 'Solifenacin', 'SOL', '2015-03-30 12:16:07', 1, 8),
	(88, 'Solifenacin-d5', 'SOL-d5', '2015-03-30 12:16:07', 1, 8),
	(89, 'N-Acetyl-L-Cysteine', 'NAC', '2015-04-01 11:20:37', 1, 8),
	(90, 'N-Acetyl-L-Cysteine-d3', 'NAC-d3', '2015-04-01 11:20:37', 1, 8),
	(91, 'Valsartan', 'VALS', '2015-04-02 10:59:30', 1, 8),
	(92, 'Valsartan-d9', 'VALS-d9', '2015-04-02 10:59:30', 1, 8),
	(93, 'Diltiazem', 'DILM', '2015-04-10 08:48:00', 1, 8),
	(94, 'Desacetyl Diltiazem', 'DESA', '2015-04-10 08:48:00', 1, 8),
	(95, 'Diltiazem-d4', 'DILM-d4', '2015-04-10 08:54:07', 1, 8),
	(96, 'Desacetyl Diltiazem-d6', 'DESA-d6', '2015-04-10 08:54:07', 1, 8),
	(97, 'Pioglitazone', 'PIO', '2015-04-13 07:55:56', 1, 8),
	(98, 'Pioglitazone-d4', 'PIO-d4', '2015-04-13 07:55:56', 1, 8),
	(99, 'Etoricoxib', 'ETOR', '2015-04-13 10:06:06', 1, 8),
	(100, 'Etoricoxib-13C-d3', 'ETOR-13C-d3', '2015-04-13 10:06:06', 1, 8),
	(101, 'Salmeterol', 'SALM', '2015-04-20 13:07:17', 1, 8),
	(102, 'Salmeterol-d3', 'SALM-d3', '2015-04-20 13:07:17', 1, 8),
	(103, 'Cinacalcet', 'CIN', '2015-04-22 07:15:40', 1, 8),
	(104, 'Cinacalcet-d3', 'CIN-d3', '2015-04-22 07:15:40', 1, 8),
	(105, 'Voriconazole', 'VORI', '2015-04-24 10:10:08', 1, 8),
	(106, 'Voriconazole-d3', 'VORI-d3', '2015-04-24 10:10:08', 1, 8),
	(107, 'Metformin', 'MET', '2015-04-27 08:37:03', 1, 8),
	(108, 'Metformin-d6', 'MET-d6', '2015-04-27 08:37:03', 1, 8),
	(109, 'Fluticasone Propionate', 'FLUT', '2015-04-28 11:09:49', 1, 8),
	(110, 'Fluticasone Propionate-d3', 'FLUT-d3', '2015-04-28 11:09:49', 1, 8),
	(111, 'Tadalafil', 'TADA', '2015-05-13 10:51:21', 1, 8),
	(112, 'Tadalafil-d3', 'TADA-d3', '2015-05-13 10:51:21', 1, 8),
	(113, 'Erlotinib', 'ERLO', '2015-05-18 12:22:14', 1, 8),
	(114, 'Erlotinib-d6', 'ERLO-d6', '2015-05-18 12:22:14', 1, 8),
	(115, 'Aripiprazole', 'ARI', '2015-05-21 09:57:39', 1, 8),
	(116, 'Aripiprazole-d8', 'ARI-d8', '2015-05-21 09:57:39', 1, 8),
	(117, 'Dasatinib', 'DASA', '2015-05-22 09:42:42', 1, 8),
	(118, 'Dasatinib-d8', 'DASA-d8', '2015-05-22 09:42:43', 1, 8),
	(119, 'Thiorphan', 'THI', '2015-05-22 09:43:39', 1, 8),
	(120, 'Thiorphan-d7', 'THI-d7', '2015-05-22 09:43:39', 1, 8),
	(121, '5-Hydroxymethyl Tolterodine', 'HMT', '2015-05-26 13:19:31', 1, 8),
	(122, 'Tolterodine-d14', 'TOL-d14', '2015-05-26 13:19:31', 1, 8),
	(123, 'Bisoprolol', 'BISO', '2015-06-04 10:55:15', 1, 29),
	(124, 'Bisoprolol-d5', 'BISO-d5', '2015-06-04 10:55:15', 1, 29),
	(125, 'Pirlindole', 'PIRLIN', '2015-06-15 10:45:41', 1, 8),
	(126, 'Pirlindole-d4', 'PIRLIN-d4', '2015-06-15 10:45:41', 1, 8),
	(127, 'Diosmetin-3-O-Glucuronide', '3G-DIOS', '2015-06-15 13:54:02', 1, 8),
	(128, 'Diosmetin-d3', 'DIOS-d3', '2015-06-15 12:36:39', 1, 8),
	(129, 'Hesperetin 3-O-β-D-Glucuronid', '3D-G-HESP', '2015-06-15 13:53:48', 1, 8),
	(130, 'Hesperetin-d3', 'HESP-d3', '2015-06-15 12:36:39', 1, 8),
	(131, 'Diosmetin', 'DIOS', '2015-06-15 14:01:10', 1, 8),
	(132, 'Hesperetin', 'HESP', '2015-06-15 14:01:10', 1, 8),
	(133, 'Zonisamide', 'ZONI', '2015-06-18 14:01:12', 1, 8),
	(134, 'Zonisamide-d4', 'ZONI-d4', '2015-06-18 14:01:13', 1, 8),
	(135, 'Ezetimibe Phenoxy β-D-Glucuron', 'G-EZE', '2015-06-29 08:57:06', 1, 8),
	(136, 'Benznidazole', 'BEZ', '2015-07-03 08:51:29', 1, 8),
	(137, 'Benznidazole-d7', 'BEZ-d7', '2015-07-03 08:51:29', 1, 8),
	(138, 'Ibandronic Acid', 'IBAN', '2015-07-08 08:26:34', 1, 8),
	(139, 'Ibandronic Acid-d3', 'IBAN-d3', '2015-07-08 08:26:34', 1, 8),
	(140, '25-Hydroxy Vitamin D3', 'OHVD3', '2015-07-13 08:36:21', 1, 8),
	(141, '25-Hydroxy Vitamin D3-d6', 'OHVD3-d6', '2015-07-13 08:36:21', 1, 8),
	(142, 'Sitagliptin', 'SIT', '2015-07-24 11:03:15', 1, 8),
	(143, 'Sitagliptin-d4', 'SIT-d4', '2015-07-24 11:03:15', 1, 8),
	(144, 'Methotrexate', 'METHO', '2015-07-24 11:04:18', 1, 8),
	(145, 'Methotrexate-d3', 'METHO-d3', '2015-07-24 11:04:18', 1, 8),
	(146, 'Memantine', 'MEM', '2015-07-24 16:32:18', 1, 8),
	(147, 'Memantine-d6', 'MEM-d6', '2015-07-24 16:32:18', 1, 8),
	(148, 'Levonorgestrel', 'NGES', '2015-10-09 14:11:02', 1, 8),
	(149, 'Levonorgestrel-d6', 'NGES-d6', '2015-10-09 14:11:02', 1, 8),
	(150, 'Simvastatin', 'SIM', '2015-10-19 08:24:51', 1, 8),
	(151, 'Simvastatin-d6', 'SIM-d6', '2015-10-19 08:24:51', 1, 8),
	(152, 'Tenofovir', 'TEN', '2015-11-03 12:50:55', 1, 8),
	(153, 'Tenofovir-d6', 'TEN-d6', '2015-11-03 12:50:55', 1, 8),
	(154, 'Mycophenolic Acid', 'MYCO', '2015-11-09 08:53:40', 1, 8),
	(155, 'Mycophenolic Acid-d3', 'MYCO-d3', '2015-11-09 08:53:40', 1, 8),
	(156, 'Emtricitabine', 'EMT', '2015-11-09 14:10:59', 1, 8),
	(157, 'Emtricitabine-13C,15N2', 'EMT-13C-15N2', '2015-11-09 14:10:59', 1, 8),
	(158, 'Amoxicillin', 'AMOX', '2015-11-13 12:35:13', 1, 8),
	(159, 'Amoxicillin-d4', 'AMOX-d4', '2015-11-13 12:35:13', 1, 8),
	(160, 'Imatinib', 'IMA', '2015-11-17 13:10:37', 1, 8),
	(161, 'Imatinib-d3', 'IMA-d3', '2015-11-17 13:10:37', 1, 8),
	(162, 'Clavulanic acid', 'CLAV', '2015-11-19 09:35:53', 1, 8),
	(163, 'Oylimidazole Clavulanic-d3', 'OY-CLAV-d3', '2015-11-19 09:35:53', 1, 8),
	(164, '6-Mercaptopurine', '6-MER', '2015-11-23 08:03:10', 1, 8),
	(165, '6-Mercaptopurine-13C2,15N', '6-MER-13C2-15N', '2015-11-23 08:03:10', 1, 8),
	(166, 'Drospirenone', 'DROS', '2015-12-17 09:58:24', 1, 8),
	(167, 'Drospirenone-d4', 'DROS-d4', '2015-12-17 09:58:24', 1, 8),
	(168, 'Carbocisteine', 'CACIS', '2015-12-21 07:44:40', 1, 8),
	(169, 'Carbocisteine-13C3', 'CACIS-13C3', '2015-12-21 07:44:40', 1, 8),
	(170, 'Vardenafil', 'VARD', '2016-02-08 09:48:57', 1, 8),
	(171, 'Vardenafil-d5', 'VARD-d5', '2016-02-08 09:48:57', 1, 8),
	(172, 'Valproic acid', 'VALP', '2016-03-02 07:49:35', 1, 6),
	(173, 'Valproic acid-d6', 'VALP-d6', '2016-03-02 07:50:15', 1, 6),
	(174, 'Ramipril', 'RAMI', '2016-03-03 09:27:00', 1, 6),
	(175, 'Ramipril-d5', 'RAMI-d5', '2016-03-03 09:27:21', 1, 6),
	(176, 'Chlorthalidone', 'CLTL', '2016-03-09 09:24:47', 1, 6),
	(177, 'Chlorthalidone-d4', 'CLTL-d4', '2016-03-09 09:25:18', 1, 6),
	(178, 'Sunitinib', 'SUN', '2016-04-07 10:23:39', 1, 29),
	(179, 'Sunitinib-d10', 'SUN-d10', '2016-04-07 10:23:39', 1, 29),
	(180, 'Vildagliptin', 'VIL', '2016-04-20 08:39:56', 1, 6),
	(181, 'Vildagliptin-13C5,15N', 'VIL-13C5-15N', '2016-04-20 08:41:24', 1, 6),
	(182, 'Oxycodone', 'OXY', '2016-04-25 12:48:45', 1, 29),
	(183, 'Oxycodone-d6', 'OXY-d6', '2016-04-25 12:48:45', 1, 29),
	(184, 'Acetaminophen', 'PARA', '2016-04-25 12:49:53', 1, 29),
	(185, 'Acetaminophen-d4', 'PARA-d4', '2016-04-25 12:49:53', 1, 29),
	(186, 'Entecavir', 'ENTE', '2016-05-09 12:53:26', 1, 29),
	(187, 'Entecavir-13C2,15N', 'ENTE-13C2-15N', '2016-05-09 12:53:26', 1, 29),
	(188, 'NRP2945', 'NRP', '2016-06-01 07:46:32', 1, 10),
	(189, 'NRP2945-Pro', 'NRP-Pro', '2016-06-01 07:48:00', 1, 10),
	(190, 'R-(-)-Ibuprofen', 'R-IBU', '2016-06-13 09:13:07', 1, 29),
	(191, 'S-(+)-Ibuprofen', 'S-IBU', '2016-06-13 09:13:07', 1, 29),
	(192, 'Ibuprofen-d3', 'IBU-d3', '2016-06-13 09:13:07', 1, 29),
	(193, 'Lenalidomide', 'LENA', '2016-07-06 12:46:18', 1, 29),
	(194, 'Lenalidomide-d5', 'LENA-d5', '2016-07-06 12:46:18', 1, 29),
	(195, 'o-OH-Atorvastatin', 'o-ATOR', '2016-07-12 10:16:36', 1, 29),
	(196, 'p-OH-Atorvastatin', 'p-ATOR', '2016-07-12 10:16:36', 1, 29),
	(197, 'o-OH-Atorvastatin-d5', 'o-ATOR-d5', '2016-07-12 10:16:36', 1, 29),
	(198, 'p-OH-Atorvastatin-d5', 'p-ATOR-d5', '2016-07-12 10:16:36', 1, 29),
	(199, 'Leuprolide', 'LEU', '2016-07-15 09:34:14', 1, 29),
	(200, 'Leuprolide-d10', 'LEU-d10', '2016-07-15 09:34:14', 1, 29),
	(201, 'Abiraterone', 'ABI', '2016-08-01 17:41:31', 1, 29),
	(202, 'Abiraterone-d4', 'ABI-d4', '2016-08-01 17:41:31', 1, 29),
	(203, 'Rupatadine', 'RUP', '2016-08-03 08:29:24', 1, 6),
	(204, 'Rupatadine-d6', 'RUP-d6', '2016-08-03 08:29:55', 1, 6),
	(205, 'Pseudoephedrine', 'PSE', '2016-08-10 13:57:50', 1, 29),
	(206, 'Pseudoephedrine-d3', 'PSE-d3', '2016-08-10 13:57:50', 1, 29),
	(207, 'Agomelatine', 'AGOM', '2016-08-10 13:57:50', 1, 29),
	(208, 'Agomelatine-d6', 'AGOM-d6', '2016-08-10 13:57:50', 1, 29),
	(209, 'Phenylephrine', 'PHENY', '2016-10-14 11:54:37', 1, 29),
	(210, 'Phenylephrine-d3', 'PHENY-d3', '2016-10-14 11:54:37', 1, 29),
	(211, 'Tamsulosin', 'TAM', '2016-10-19 17:54:54', 1, 29),
	(212, 'Tamsulosin-d4', 'TAM-d4', '2016-10-19 17:54:54', 1, 29),
	(213, 'Clopidogrel', 'CLOPI', '2016-10-21 17:11:22', 1, 29),
	(214, 'Clopidogrel-d4', 'CLOPI-d4', '2016-10-21 17:11:22', 1, 29),
	(215, 'Acetylsalicylic Acid', 'AAS', '2016-10-25 15:04:31', 1, 8),
	(216, 'Salicylic Acid', 'AS', '2016-10-25 15:04:31', 1, 8),
	(217, '2-Acetoxybenzoic-d4 Acid', 'AAS-d4', '2016-10-25 15:04:31', 1, 8),
	(218, '2-Hydroxybenzoic Acid-d6', 'AS-d6', '2016-10-25 15:04:31', 1, 8),
	(219, 'Ivermectin B1a', 'IVEB1a', '2016-11-04 09:20:26', 1, 29),
	(220, 'Ivermectin B1b', 'IVE B1b', '2016-10-27 10:40:18', 1, 29),
	(221, 'Doramectin', 'DORA', '2016-10-27 10:40:18', 1, 29),
	(222, 'Irinotecan', 'IRIN', '2016-11-04 08:53:16', 1, 8),
	(223, 'Irinotecan-d10', 'IRIN-d10', '2016-11-04 08:53:16', 1, 8),
	(224, 'SN-38', 'SN-38', '2016-11-04 08:53:16', 1, 8),
	(225, 'SN-38-d5', 'SN-38-d5', '2016-11-04 08:53:16', 1, 8),
	(226, 'IvermectinB1b', 'IVEB1b', '2016-11-04 17:11:14', 1, 29),
	(227, 'Diclofenac', 'DICLO', '2016-11-25 09:08:07', 1, 29),
	(228, 'Diclofenac-d4', 'DICLO-d4', '2016-11-25 09:08:07', 1, 29),
	(229, 'Irbesartan', 'IRBE', '2016-11-30 08:18:49', 1, 8),
	(230, 'Irbesartan-d4', 'IRBE-d4', '2016-11-30 08:18:49', 1, 8),
	(231, 'Mirtazapine', 'MTZP', '2017-01-09 08:50:27', 1, 8),
	(232, 'Mirtazapine-d4', 'MTZP-d4', '2017-01-09 08:50:27', 1, 8),
	(233, 'Alprazolam', 'ALP', '2017-01-09 08:55:25', 1, 8),
	(234, 'Alprazolam-d5', 'ALP-d5', '2017-01-09 08:55:25', 1, 8),
	(235, 'Ethinyl Estradiol', 'EE', '2017-01-18 11:08:14', 1, 8),
	(236, 'Ethinyl Estradiol-d4', 'EE-d4', '2017-01-18 11:08:14', 1, 8),
	(237, 'Dienogest', 'DIEN', '2017-01-24 10:48:43', 1, 8),
	(238, 'Dienogest-d6', 'DIEN-d6', '2017-01-24 10:48:43', 1, 8),
	(239, 'Lanreotide', 'LAN', '2017-02-06 09:23:23', 1, 8),
	(240, 'Triptorelin', 'TRIP', '2017-02-06 09:23:23', 1, 8),
	(241, 'Anagrelide', 'ANG', '2017-02-20 18:29:07', 1, 29),
	(242, 'Anagrelide-13C3', 'ANG-13C3', '2017-02-20 18:29:07', 1, 29),
	(243, 'Acyclovir', 'ACY', '2017-02-23 09:27:32', 1, 29),
	(244, 'Acyclovir-d4', 'ACY-d4', '2017-02-23 09:27:32', 1, 29),
	(245, 'Febuxostat', 'FEBU', '2017-04-25 07:37:28', 1, 8),
	(246, 'Febuxostat-d7', 'FEBU-d7', '2017-04-25 07:37:28', 1, 8),
	(247, 'R-95913', 'R-95913', '2017-05-04 12:46:48', 1, 29),
	(248, 'R-95913-d4', 'R-95913-d4', '2017-05-04 12:46:48', 1, 29),
	(249, 'Clobazam', 'CLOBA', '2017-05-15 12:44:29', 1, 8),
	(250, 'N-Desmethylclobazam', 'N-D-CLOBA', '2017-05-15 12:44:29', 1, 8),
	(251, 'Clobazam-13C6', 'CLOBA-13C6', '2017-05-15 12:44:29', 1, 8),
	(252, 'N-Desmethylclobazam-13C6', 'N-D-CLOBA-13C6', '2017-05-15 12:44:29', 1, 8),
	(253, 'Rivaroxaban', 'RIVX', '2017-06-06 12:41:56', 1, 29),
	(254, 'Rivaroxaban-d4', 'RIVX-d4', '2017-06-06 12:41:56', 1, 29),
	(255, 'Octreotide', 'OCT', '2019-10-28 06:59:00', 1, 15),
	(256, 'Octreotide-d8', 'OCT-d8', '2019-10-28 06:59:41', 1, 15);
/*!40000 ALTER TABLE `alae_analyte` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_analyte_study
CREATE TABLE IF NOT EXISTS `alae_analyte_study` (
  `pk_analyte_study` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cs_number` int(11) NOT NULL DEFAULT '8',
  `qc_number` int(11) NOT NULL DEFAULT '4',
  `cs_values` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `qc_values` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `internal_standard` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_study` bigint(20) unsigned NOT NULL,
  `fk_analyte` bigint(20) unsigned NOT NULL,
  `fk_analyte_is` bigint(20) unsigned NOT NULL,
  `fk_unit` int(11) NOT NULL,
  `fk_user` bigint(20) unsigned NOT NULL,
  `fk_user_approve` bigint(20) unsigned DEFAULT NULL,
  `hdqc_values` decimal(19,2) DEFAULT NULL,
  `ldqc_values` decimal(19,2) DEFAULT NULL,
  `retention_time_analyte` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `retention_time_is` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `acceptance_margin` decimal(10,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`pk_analyte_study`),
  KEY `fk_study` (`fk_study`),
  KEY `fk_analyte` (`fk_analyte`),
  KEY `fk_analyte_is` (`fk_analyte_is`),
  KEY `fk_unit` (`fk_unit`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_analyte_study_ibfk_1` FOREIGN KEY (`fk_study`) REFERENCES `alae_study` (`pk_study`),
  CONSTRAINT `alae_analyte_study_ibfk_2` FOREIGN KEY (`fk_analyte`) REFERENCES `alae_analyte` (`pk_analyte`),
  CONSTRAINT `alae_analyte_study_ibfk_3` FOREIGN KEY (`fk_analyte_is`) REFERENCES `alae_analyte` (`pk_analyte`),
  CONSTRAINT `alae_analyte_study_ibfk_4` FOREIGN KEY (`fk_unit`) REFERENCES `alae_unit` (`pk_unit`),
  CONSTRAINT `alae_analyte_study_ibfk_5` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=378 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_analyte_study: ~1 rows (aproximadamente)
DELETE FROM `alae_analyte_study`;
/*!40000 ALTER TABLE `alae_analyte_study` DISABLE KEYS */;
INSERT INTO `alae_analyte_study` (`pk_analyte_study`, `cs_number`, `qc_number`, `cs_values`, `qc_values`, `internal_standard`, `status`, `is_used`, `updated_at`, `fk_study`, `fk_analyte`, `fk_analyte_is`, `fk_unit`, `fk_user`, `fk_user_approve`, `hdqc_values`, `ldqc_values`, `retention_time_analyte`, `retention_time_is`, `acceptance_margin`) VALUES
	(377, 8, 3, '50,100,1000,10000,20000,30000,40000,50000', '150,25000,37500', 50.0000, 1, 1, '2019-10-28 16:27:02', 348, 255, 256, 2, 15, 15, 500000.00, 75000.00, 0.0000, 0.0000, 0.0000);
/*!40000 ALTER TABLE `alae_analyte_study` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_audit_session
CREATE TABLE IF NOT EXISTS `alae_audit_session` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_session_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla alae.alae_audit_session: ~0 rows (aproximadamente)
DELETE FROM `alae_audit_session`;
/*!40000 ALTER TABLE `alae_audit_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_audit_session` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_audit_session_error
CREATE TABLE IF NOT EXISTS `alae_audit_session_error` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(25) NOT NULL,
  `message` varchar(500) NOT NULL,
  PRIMARY KEY (`pk_audit_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla alae.alae_audit_session_error: ~0 rows (aproximadamente)
DELETE FROM `alae_audit_session_error`;
/*!40000 ALTER TABLE `alae_audit_session_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_audit_session_error` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_audit_transaction
CREATE TABLE IF NOT EXISTS `alae_audit_transaction` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `section` varchar(250) NOT NULL,
  `description` varchar(500) NOT NULL,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_transaction_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla alae.alae_audit_transaction: ~3 rows (aproximadamente)
DELETE FROM `alae_audit_transaction`;
/*!40000 ALTER TABLE `alae_audit_transaction` DISABLE KEYS */;
INSERT INTO `alae_audit_transaction` (`pk_audit_session`, `created_at`, `section`, `description`, `fk_user`) VALUES
	(1, '2019-10-28 18:29:22', 'Fin de sesión', 'El usuario toni ha cerrado sesión', 15),
	(2, '2019-10-28 18:35:19', 'Inicio de sesión', 'El usuario toni ha iniciado sesión', 15),
	(3, '2019-11-02 07:38:39', 'Inicio de sesión', 'El usuario toni ha iniciado sesión', 15);
/*!40000 ALTER TABLE `alae_audit_transaction` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_audit_transaction_error
CREATE TABLE IF NOT EXISTS `alae_audit_transaction_error` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `section` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  `message` varchar(500) NOT NULL,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_transaction_error_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla alae.alae_audit_transaction_error: ~0 rows (aproximadamente)
DELETE FROM `alae_audit_transaction_error`;
/*!40000 ALTER TABLE `alae_audit_transaction_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_audit_transaction_error` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_batch
CREATE TABLE IF NOT EXISTS `alae_batch` (
  `pk_batch` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `serial` int(11) DEFAULT NULL,
  `file_name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `file_size` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `valid_flag` tinyint(1) DEFAULT NULL,
  `accepted_flag` tinyint(1) DEFAULT NULL,
  `justification` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `validation_date` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `code_error` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `intercept` float DEFAULT NULL,
  `slope` float DEFAULT NULL,
  `correlation_coefficient` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `cs_total` int(11) NOT NULL DEFAULT '0',
  `qc_total` int(11) NOT NULL DEFAULT '0',
  `ldqc_total` int(11) NOT NULL DEFAULT '0',
  `hdqc_total` int(11) NOT NULL DEFAULT '0',
  `cs_accepted_total` int(11) NOT NULL DEFAULT '0',
  `qc_accepted_total` int(11) NOT NULL DEFAULT '0',
  `ldqc_accepted_total` int(11) NOT NULL DEFAULT '0',
  `hdqc_accepted_total` int(11) NOT NULL DEFAULT '0',
  `is_cs_qc_accepted_avg` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `analyte_concentration_units` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `calculated_concentration_units` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `fk_parameter` int(11) DEFAULT NULL,
  `fk_analyte` bigint(20) unsigned DEFAULT NULL,
  `fk_user` bigint(20) unsigned DEFAULT NULL,
  `fk_study` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`pk_batch`),
  KEY `fk_parameter` (`fk_parameter`),
  KEY `fk_analyte` (`fk_analyte`),
  KEY `fk_user` (`fk_user`),
  KEY `fk_study` (`fk_study`),
  CONSTRAINT `alae_batch_ibfk_1` FOREIGN KEY (`fk_parameter`) REFERENCES `alae_parameter` (`pk_parameter`),
  CONSTRAINT `alae_batch_ibfk_2` FOREIGN KEY (`fk_analyte`) REFERENCES `alae_analyte` (`pk_analyte`),
  CONSTRAINT `alae_batch_ibfk_3` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`),
  CONSTRAINT `alae_batch_ibfk_4` FOREIGN KEY (`fk_study`) REFERENCES `alae_study` (`pk_study`)
) ENGINE=InnoDB AUTO_INCREMENT=8246 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_batch: ~1 rows (aproximadamente)
DELETE FROM `alae_batch`;
/*!40000 ALTER TABLE `alae_batch` DISABLE KEYS */;
INSERT INTO `alae_batch` (`pk_batch`, `serial`, `file_name`, `file_size`, `created_at`, `updated_at`, `valid_flag`, `accepted_flag`, `justification`, `validation_date`, `code_error`, `intercept`, `slope`, `correlation_coefficient`, `cs_total`, `qc_total`, `ldqc_total`, `hdqc_total`, `cs_accepted_total`, `qc_accepted_total`, `ldqc_accepted_total`, `hdqc_accepted_total`, `is_cs_qc_accepted_avg`, `analyte_concentration_units`, `calculated_concentration_units`, `fk_parameter`, `fk_analyte`, `fk_user`, `fk_study`) VALUES
	(8245, 1, '001-3324+O_OCT.txt', '99261', '2019-11-02 07:52:10', NULL, NULL, NULL, NULL, NULL, NULL, 0.00287, 0.000242, 0.9994, 0, 0, 0, 0, 0, 0, 0, 0, 0.0000, 'pg/mL', 'pg/mL', NULL, 255, 1, 348);
/*!40000 ALTER TABLE `alae_batch` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_error
CREATE TABLE IF NOT EXISTS `alae_error` (
  `pk_error` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fk_parameter` int(11) NOT NULL,
  `fk_sample_batch` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_error`),
  KEY `fk_parameter` (`fk_parameter`),
  KEY `fk_sample_batch` (`fk_sample_batch`),
  CONSTRAINT `alae_error_ibfk_1` FOREIGN KEY (`fk_parameter`) REFERENCES `alae_parameter` (`pk_parameter`),
  CONSTRAINT `alae_error_ibfk_2` FOREIGN KEY (`fk_sample_batch`) REFERENCES `alae_sample_batch` (`pk_sample_batch`)
) ENGINE=InnoDB AUTO_INCREMENT=37404 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_error: ~0 rows (aproximadamente)
DELETE FROM `alae_error`;
/*!40000 ALTER TABLE `alae_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_error` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_parameter
CREATE TABLE IF NOT EXISTS `alae_parameter` (
  `pk_parameter` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `verification` text COLLATE utf8_bin,
  `min_value` int(11) NOT NULL DEFAULT '0',
  `max_value` int(11) NOT NULL DEFAULT '0',
  `code_error` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `message_error` text COLLATE utf8_bin,
  `type_param` tinyint(1) NOT NULL DEFAULT '1',
  `fk_user` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`pk_parameter`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_parameter_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_parameter: ~45 rows (aproximadamente)
DELETE FROM `alae_parameter`;
/*!40000 ALTER TABLE `alae_parameter` DISABLE KEYS */;
INSERT INTO `alae_parameter` (`pk_parameter`, `rule`, `verification`, `min_value`, `max_value`, `code_error`, `message_error`, `type_param`, `fk_user`) VALUES
	(1, 'V1', 'Revisión del archivo exportado  (código de estudio)', 0, 0, NULL, 'V1 - EXPORT ERRÓNEO', 1, 1),
	(2, 'V2', 'Revisión del archivo exportado (abreviatura analito)', 0, 0, NULL, 'V2 - ANALITO ERRÓNEO', 1, 1),
	(3, 'V3', 'Revisión del archivo exportado  (nº de lote)', 0, 0, NULL, 'V3 - EXPORT ERRÓNEO', 1, 1),
	(4, 'V4', 'Sample Type', 0, 0, NULL, 'V4 - SAMPLE TYPE ERRÓNEO', 1, 1),
	(5, 'V5', 'Concentración nominal de CS/QC', 0, 0, NULL, 'V5 - CONCENTRACIÓN NOMINAL ERRÓNEA', 1, 1),
	(6, 'V6.1', 'Replicados CS (mínimo)', 2, 0, NULL, 'V6.1 - REPLICADOS INSUFICIENTES', 1, 1),
	(7, 'V6.2', 'Replicados QC (mínimo)', 2, 0, NULL, 'V6.2 - REPLICADOS INSUFICIENTES', 1, 1),
	(8, 'V7', 'Sample Name repetido', 0, 0, NULL, 'V7 - SAMPLE NAME REPETIDO', 1, 1),
	(9, 'V8', 'Búsqueda de Muestras reinyectadas', 0, 0, NULL, NULL, 1, 1),
	(10, 'V9.1', 'Accuracy (Sample Name + Rx*)', -15, 15, 'O', 'V9.1 - (Sample Name + Rx*) ACCURACY FUERA DE RANGO', 1, 1),
	(11, 'V9.2', 'Use record = 0 ( Sample Name + Rx* )', 0, 0, 'O', 'V9.2 - Sample Name + Rx*  USE RECORD NO VALIDO', 1, 1),
	(12, 'V9.3', 'Que tanto V 9.1 como V 9.2 se cumplan', 0, 0, 'O', 'V9.3 - CONTROL DE REINYECCIÓN NO VÁLIDO', 1, 1),
	(13, 'V10.1', 'Accuracy (CS1)', 80, 120, 'O', 'V10.1 - NO CUMPLE ACCURACY', 1, 1),
	(14, 'V10.2', 'Accuracy (CS2-CSx)', 85, 115, 'O', 'V10.2 - NO CUMPLE ACCURACY', 1, 1),
	(15, 'V10.3', 'Accuracy (QC)', 85, 115, 'O', 'V10.3 - NO CUMPLE ACCURACY', 1, 1),
	(16, 'V10.4', 'Accuracy (DQC)', 85, 115, 'O', 'V10.4 - NO CUMPLE ACCURACY', 1, 1),
	(17, 'V11', 'Revisión del dilution factor en HDQC / LDQC', 0, 0, 'O', 'V11- FACTOR DILUCIÓN ERRÓNEO', 1, 1),
	(18, 'V12', 'Use record (CS/QC/DQC)', 0, 0, NULL, 'V12 Toni UseRecordErroneo', 1, 1),
	(19, 'V13.1', 'Selección manual de los CS válidos', 0, 0, NULL, NULL, 1, 1),
	(20, 'V13.2', 'Interf. Analito en BLK', 20, 0, 'O', 'V13.2 - BLK NO CUMPLE', 1, 1),
	(21, 'V13.3', 'Interf. IS en BLK', 5, 0, 'O', 'V13.3 - BLK NO CUMPLE', 1, 1),
	(22, 'V13.4', 'Interf. Analito en ZS', 20, 0, 'O', 'V13.4 - ZS NO CUMPLE', 1, 1),
	(23, 'V15', '75% CS', 75, 0, NULL, 'V15 - LOTE RECHAZADO (75% CS)', 1, 1),
	(24, 'V16', 'CS consecutivos', 0, 0, NULL, 'V16 - LOTE RECHAZADO (CS CONSECUTIVOS)', 1, 1),
	(25, 'V17', 'r > 0.99', 99, 0, NULL, 'V17 - LOTE RECHAZADO (r< 0.99)', 1, 1),
	(26, 'V18', '67% QC', 67, 0, NULL, 'V18 - LOTE RECHAZADO (67% QC)', 1, 1),
	(27, 'V19', '50% de cada nivel de QC', 50, 0, NULL, 'V19 - LOTE RECHAZADO (50% QCx)', 1, 1),
	(28, 'V20.1', '50% BLK', 50, 0, NULL, 'V20.1 - LOTE RECHAZADO (INTERF. BLK)', 1, 1),
	(29, 'V20.2', '50% ZS', 50, 0, 'C1', 'V20.2 - LOTE RECHAZADO (INTERF. ZS)', 1, 1),
	(30, 'V21', 'Conc. (unknown) > ULOQ ( E )', 0, 0, 'E', 'V21 - CONC. SUPERIOR AL ULOQ', 1, 1),
	(31, 'V22', 'Variabilidad IS (unknown) ( H )', 0, 0, 'H', 'V22 - VARIABILIDAD IS', 1, 1),
	(32, 'V23', '< 5% respuesta IS (unknown) ( B )', 5, 0, 'B', 'V23 - ERROR EXTRACCIÓN IS', 1, 1),
	(33, 'V24', 'Fuera rango recta truncada ( F )', 0, 0, 'F', 'V24 - FUERA DE RANGO/RECTA TRUNCADA', 1, 1),
	(34, 'V12.1', NULL, 0, 0, 'O', 'V12 - No cumple S/N', 0, 1),
	(35, 'V12.2', NULL, 0, 0, 'F', 'V12 - Recta truncada al CS2', 0, 1),
	(36, 'V12.3', NULL, 0, 0, 'O', 'V12 - Recta truncada al CS7', 0, 1),
	(37, 'V12.4', NULL, 0, 0, 'A', 'V12 - Muestra perdida durante la extracción', 0, 1),
	(38, 'V12.5', NULL, 0, 0, 'B', 'V12 - Error de extracción', 0, 1),
	(39, 'V12.6', NULL, 0, 0, 'C', 'V12 - Problemas de cromatografía', 0, 1),
	(40, 'V12.7', NULL, 0, 0, 'D', 'V12 - Fallos técnicos de equipos / software', 0, 1),
	(41, 'V12.8', NULL, 0, 0, NULL, 'V12 - Use Record Erróneo', 0, 1),
	(42, 'V25', 'Basal cuantificable (Unknown) (J)', 0, 0, 'J', 'V25 - Basal cuantificable', 1, 1),
	(43, 'V26', 'Tiempo de retención (C2)', 0, 0, 'C2', 'V26 - Tiempo de retención inaceptable', 1, 1),
	(44, 'V27', 'LOTE NO VÁLIDO Use Record Erróneo CS/QC (C2)', 0, 0, 'C2', 'V27 - Lote no válido Use record Erróneo', 1, 1),
	(45, 'V1.1', 'Revisión del tamaño del archivo exportado', 10, 10, NULL, 'V1.1 - NO ES EL TAMAÑO ADECUADO', 1, NULL);
/*!40000 ALTER TABLE `alae_parameter` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_profile
CREATE TABLE IF NOT EXISTS `alae_profile` (
  `pk_profile` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`pk_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_profile: ~7 rows (aproximadamente)
DELETE FROM `alae_profile`;
/*!40000 ALTER TABLE `alae_profile` DISABLE KEYS */;
INSERT INTO `alae_profile` (`pk_profile`, `name`) VALUES
	(1, 'Sustancias'),
	(2, 'Laboratorio'),
	(3, 'Director Estudio'),
	(4, 'UGC'),
	(5, 'Administrador'),
	(6, 'Cron'),
	(7, 'Sin asignar');
/*!40000 ALTER TABLE `alae_profile` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_sample_batch
CREATE TABLE IF NOT EXISTS `alae_sample_batch` (
  `pk_sample_batch` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sample_name` varchar(250) COLLATE utf8_bin NOT NULL,
  `analyte_peak_name` varchar(250) COLLATE utf8_bin NOT NULL,
  `sample_type` varchar(250) COLLATE utf8_bin NOT NULL,
  `file_name` varchar(250) COLLATE utf8_bin NOT NULL,
  `dilution_factor` decimal(19,4) NOT NULL,
  `analyte_peak_area` int(11) NOT NULL,
  `is_peak_name` varchar(250) COLLATE utf8_bin NOT NULL,
  `is_peak_area` int(11) NOT NULL,
  `analyte_concentration` decimal(19,4) DEFAULT NULL,
  `analyte_concentration_units` varchar(250) COLLATE utf8_bin NOT NULL,
  `calculated_concentration` decimal(19,4) DEFAULT NULL,
  `calculated_concentration_units` varchar(250) COLLATE utf8_bin NOT NULL,
  `accuracy` decimal(19,4) DEFAULT NULL,
  `use_record` int(11) DEFAULT '0',
  `valid_flag` tinyint(1) DEFAULT '1',
  `is_used` tinyint(1) NOT NULL DEFAULT '1',
  `code_error` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `parameters` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sample_id` int(11) DEFAULT NULL,
  `sample_comment` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `set_number` int(11) DEFAULT NULL,
  `acquisition_method` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `rack_type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `rack_position` int(11) DEFAULT NULL,
  `vial_position` int(11) DEFAULT NULL,
  `plate_type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `plate_position` int(11) DEFAULT NULL,
  `weight_to_volume_ratio` decimal(19,4) DEFAULT NULL,
  `sample_annotation` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `disposition` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_units` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `acquisition_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `analyte_peak_area_for_dad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_peak_height` decimal(19,4) DEFAULT NULL,
  `analyte_peak_height_for_dad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_retention_time` decimal(19,4) DEFAULT NULL,
  `analyte_expected_rt` decimal(19,4) DEFAULT NULL,
  `analyte_rt_window` decimal(19,4) DEFAULT NULL,
  `analyte_centroid_location` decimal(19,4) DEFAULT NULL,
  `analyte_start_scan` decimal(19,4) DEFAULT NULL,
  `analyte_start_time` decimal(19,4) DEFAULT NULL,
  `analyte_stop_scan` int(11) DEFAULT NULL,
  `analyte_stop_time` decimal(19,4) DEFAULT NULL,
  `analyte_integration_type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_signal_to_noise` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_peak_width` decimal(19,4) DEFAULT NULL,
  `analyte_standar_query_status` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_mass_ranges` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_wavelength_ranges` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `height_ratio` decimal(19,4) DEFAULT NULL,
  `analyte_annotation` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_channel` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_peak_width_at_50_height` decimal(19,4) DEFAULT NULL,
  `analyte_slope_of_baseline` decimal(19,4) DEFAULT NULL,
  `analyte_processing_alg` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `analyte_peak_asymmetry` decimal(19,4) DEFAULT NULL,
  `is_units` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_peak_area_for_dad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_peak_height` decimal(19,4) DEFAULT NULL,
  `is_peak_height_for_dad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_concentration` decimal(19,4) DEFAULT NULL,
  `is_retention_time` decimal(19,4) DEFAULT NULL,
  `is_expected_rt` decimal(19,4) DEFAULT NULL,
  `is_rt_windows` decimal(19,4) DEFAULT NULL,
  `is_centroid_location` decimal(19,4) DEFAULT NULL,
  `is_start_scan` int(11) DEFAULT NULL,
  `is_start_time` decimal(19,4) DEFAULT NULL,
  `is_stop_scan` int(11) DEFAULT NULL,
  `is_stop_time` decimal(19,4) DEFAULT NULL,
  `is_integration_type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_signal_to_noise` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_peak_width` decimal(19,4) DEFAULT NULL,
  `is_mass_ranges` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_wavelength_ranges` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_channel` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_peak_width_al_50_height` decimal(19,4) DEFAULT NULL,
  `is_slope_of_baseline` decimal(19,4) DEFAULT NULL,
  `is_processing_alg` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_peak_asymemtry` decimal(19,4) DEFAULT NULL,
  `record_modified` int(11) DEFAULT NULL,
  `area_ratio` decimal(19,4) DEFAULT NULL,
  `calculated_concentration_for_dad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `relative_retention_time` decimal(19,4) DEFAULT NULL,
  `response_factor` decimal(19,4) DEFAULT NULL,
  `fk_batch` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_sample_batch`),
  KEY `fk_batch` (`fk_batch`),
  CONSTRAINT `alae_sample_batch_ibfk_1` FOREIGN KEY (`fk_batch`) REFERENCES `alae_batch` (`pk_batch`)
) ENGINE=InnoDB AUTO_INCREMENT=931642 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_sample_batch: ~181 rows (aproximadamente)
DELETE FROM `alae_sample_batch`;
/*!40000 ALTER TABLE `alae_sample_batch` DISABLE KEYS */;
INSERT INTO `alae_sample_batch` (`pk_sample_batch`, `sample_name`, `analyte_peak_name`, `sample_type`, `file_name`, `dilution_factor`, `analyte_peak_area`, `is_peak_name`, `is_peak_area`, `analyte_concentration`, `analyte_concentration_units`, `calculated_concentration`, `calculated_concentration_units`, `accuracy`, `use_record`, `valid_flag`, `is_used`, `code_error`, `parameters`, `created_at`, `updated_at`, `sample_id`, `sample_comment`, `set_number`, `acquisition_method`, `rack_type`, `rack_position`, `vial_position`, `plate_type`, `plate_position`, `weight_to_volume_ratio`, `sample_annotation`, `disposition`, `analyte_units`, `acquisition_date`, `analyte_peak_area_for_dad`, `analyte_peak_height`, `analyte_peak_height_for_dad`, `analyte_retention_time`, `analyte_expected_rt`, `analyte_rt_window`, `analyte_centroid_location`, `analyte_start_scan`, `analyte_start_time`, `analyte_stop_scan`, `analyte_stop_time`, `analyte_integration_type`, `analyte_signal_to_noise`, `analyte_peak_width`, `analyte_standar_query_status`, `analyte_mass_ranges`, `analyte_wavelength_ranges`, `height_ratio`, `analyte_annotation`, `analyte_channel`, `analyte_peak_width_at_50_height`, `analyte_slope_of_baseline`, `analyte_processing_alg`, `analyte_peak_asymmetry`, `is_units`, `is_peak_area_for_dad`, `is_peak_height`, `is_peak_height_for_dad`, `is_concentration`, `is_retention_time`, `is_expected_rt`, `is_rt_windows`, `is_centroid_location`, `is_start_scan`, `is_start_time`, `is_stop_scan`, `is_stop_time`, `is_integration_type`, `is_signal_to_noise`, `is_peak_width`, `is_mass_ranges`, `is_wavelength_ranges`, `is_channel`, `is_peak_width_al_50_height`, `is_slope_of_baseline`, `is_processing_alg`, `is_peak_asymemtry`, `record_modified`, `area_ratio`, `calculated_concentration_for_dad`, `relative_retention_time`, `response_factor`, `fk_batch`) VALUES
	(931461, 'ES-3325-01-1', 'OCT', 'Solvent', '001-3324\\001.wiff', 1.0000, 0, 'OCT-d8', 39, 0.0000, 'pg/mL', 0.0000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 84, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-21 16:01:11', 'N/A', 0.0000, 'N/A', 0.0000, 2.2600, 30.0000, 0.0000, 0.0000, 0.0000, 0, 0.0000, 'No Peak', 'N/A', 0.0000, 'N/A', '510.300/120.200 Da', 'N/A', 0.0000, '', 'N/A', 0.0000, 0.0000, 'Analyst Classic', 0.0000, 'ng/mL', 'N/A', 39.6000, 'N/A', 0.0000, 2.2500, 2.2500, 30.0000, 2.2500, 328, 2.2300, 333, 2.2700, 'Base To Base', 'N/A', 0.0342, '514.300/120.200 Da', 'N/A', 'N/A', 0.0178, -1200.0000, 'Analyst Classic', 0.7560, 0, 0.0000, 'N/A', 0.0000, 0.0000, 8245),
	(931462, 'ES-3325-01-2', 'OCT', 'Solvent', '001-3324\\002.wiff', 1.0000, 0, 'OCT-d8', 6, 0.0000, 'pg/mL', 0.0000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 84, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-21 16:07:18', 'N/A', 0.0000, 'N/A', 0.0000, 2.2600, 30.0000, 0.0000, 0.0000, 0.0000, 0, 0.0000, 'No Peak', 'N/A', 0.0000, 'N/A', '510.300/120.200 Da', 'N/A', 0.0000, '', 'N/A', 0.0000, 0.0000, 'Analyst Classic', 0.0000, 'ng/mL', 'N/A', 8.2100, 'N/A', 0.0000, 2.2500, 2.2500, 30.0000, 2.2600, 329, 2.2400, 333, 2.2700, 'Base To Base', 'N/A', 0.0273, '514.300/120.200 Da', 'N/A', 'N/A', 0.0128, 1670.0000, 'Analyst Classic', 1.0700, 0, 0.0000, 'N/A', 0.0000, 0.0000, 8245),
	(931463, 'BLK-1', 'OCT', 'Blank', '001-3324\\003.wiff', 1.0000, 671, 'OCT-d8', 66, 0.0000, 'pg/mL', 0.0000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 1, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:12:50', 'N/A', 218.0000, 'N/A', 2.2700, 2.2600, 30.0000, 2.2900, 328.0000, 2.2300, 343, 2.3400, 'Base To Base', 'N/A', 0.1030, 'N/A', '510.300/120.200 Da', 'N/A', 3.7900, '', 'N/A', 0.0627, -90.9000, 'Analyst Classic', 1.6300, 'ng/mL', 'N/A', 57.5000, 'N/A', 1.0000, 2.2600, 2.2500, 30.0000, 2.2600, 329, 2.2400, 334, 2.2800, 'Base To Base', 'N/A', 0.0342, '514.300/120.200 Da', 'N/A', 'N/A', 0.0218, 827.0000, 'Analyst Classic', 1.2200, 0, 10.1431, 'N/A', 1.0100, 0.0000, 8245),
	(931464, 'ZS-1', 'OCT', 'Blank', '001-3324\\004.wiff', 1.0000, 1039, 'OCT-d8', 185416, 0.0000, 'pg/mL', 0.0000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 2, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:18:22', 'N/A', 275.0000, 'N/A', 2.2800, 2.2600, 30.0000, 2.2700, 324.0000, 2.2100, 341, 2.3200, 'Base To Base', 'N/A', 0.1160, 'N/A', '510.300/120.200 Da', 'N/A', 0.0040, '', 'N/A', 0.0674, 56.8000, 'Analyst Classic', 0.6420, 'ng/mL', 'N/A', 68200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 318, 2.1700, 342, 2.3300, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0424, 1.0100, 'Analyst Classic', 1.4800, 0, 0.0056, 'N/A', 1.0200, 0.0000, 8245),
	(931465, 'CS1-1', 'OCT', 'Standard', '001-3324\\005.wiff', 1.0000, 2773, 'OCT-d8', 218115, 50.0000, 'pg/mL', 40.7500, 'pg/mL', 81.5000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 3, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:23:54', 'N/A', 988.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 339, 2.3100, 'Base To Base', 'N/A', 0.1230, 'N/A', '510.300/120.200 Da', 'N/A', 0.0126, '', 'N/A', 0.0457, 1.2900, 'Analyst Classic', 1.0700, 'ng/mL', 'N/A', 78600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0431, 1.5500, 'Analyst Classic', 1.1800, 0, 0.0127, 'N/A', 1.0100, 0.0003, 8245),
	(931466, 'CS2-1', 'OCT', 'Standard', '001-3324\\006.wiff', 1.0000, 4657, 'OCT-d8', 177938, 100.0000, 'pg/mL', 96.4800, 'pg/mL', 96.4800, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 4, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:29:25', 'N/A', 1520.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0238, '', 'N/A', 0.0481, -56.5000, 'Analyst Classic', 1.2600, 'ng/mL', 'N/A', 63700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 318, 2.1700, 343, 2.3400, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0434, 0.4710, 'Analyst Classic', 1.8200, 0, 0.0262, 'N/A', 1.0100, 0.0003, 8245),
	(931467, 'CS3-1', 'OCT', 'Standard', '001-3324\\007.wiff', 1.0000, 53955, 'OCT-d8', 230719, 1000.0000, 'pg/mL', 956.4300, 'pg/mL', 95.6400, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 5, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:34:58', 'N/A', 18700.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 345, 2.3500, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.2210, '', 'N/A', 0.0457, -5.0500, 'Analyst Classic', 1.8400, 'ng/mL', 'N/A', 84300.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0423, 0.6340, 'Analyst Classic', 1.6900, 0, 0.2339, 'N/A', 1.0100, 0.0002, 8245),
	(931468, 'CS4-1', 'OCT', 'Standard', '001-3324\\008.wiff', 1.0000, 498249, 'OCT-d8', 207331, 10000.0000, 'pg/mL', 9938.7400, 'pg/mL', 99.3900, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 6, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:40:32', 'N/A', 175000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 353, 2.4100, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 2.3100, '', 'N/A', 0.0443, -0.4600, 'Analyst Classic', 1.8000, 'ng/mL', 'N/A', 75800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0434, 0.6390, 'Analyst Classic', 1.7000, 0, 2.4032, 'N/A', 1.0100, 0.0002, 8245),
	(931469, 'CS5-1', 'OCT', 'Standard', '001-3324\\009.wiff', 1.0000, 990458, 'OCT-d8', 205194, 20000.0000, 'pg/mL', 19974.7000, 'pg/mL', 99.8700, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 7, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:46:04', 'N/A', 346000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 349, 2.3800, 'Base To Base', 'N/A', 0.2050, 'N/A', '510.300/120.200 Da', 'N/A', 4.5900, '', 'N/A', 0.0447, -0.0068, 'Analyst Classic', 1.9100, 'ng/mL', 'N/A', 75200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 318, 2.1700, 345, 2.3500, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0420, 0.7830, 'Analyst Classic', 2.0000, 0, 4.8269, 'N/A', 1.0100, 0.0002, 8245),
	(931470, 'CS6-1', 'OCT', 'Standard', '001-3324\\010.wiff', 1.0000, 1578559, 'OCT-d8', 212101, 30000.0000, 'pg/mL', 30804.7800, 'pg/mL', 102.6800, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 8, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:51:35', 'N/A', 547000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 353, 2.4100, 'Base To Base', 'N/A', 0.2320, 'N/A', '510.300/120.200 Da', 'N/A', 7.0900, '', 'N/A', 0.0455, -0.0460, 'Analyst Classic', 2.2600, 'ng/mL', 'N/A', 77100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 318, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0425, 0.0734, 'Analyst Classic', 2.2300, 0, 7.4425, 'N/A', 1.0100, 0.0002, 8245),
	(931471, 'CS7-1', 'OCT', 'Standard', '001-3324\\011.wiff', 1.0000, 1969027, 'OCT-d8', 211240, 40000.0000, 'pg/mL', 38584.3200, 'pg/mL', 96.4600, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 9, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 16:57:07', 'N/A', 684000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 356, 2.4300, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 9.0000, '', 'N/A', 0.0451, -0.1320, 'Analyst Classic', 2.5600, 'ng/mL', 'N/A', 76100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 318, 2.1700, 345, 2.3500, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0432, 0.1870, 'Analyst Classic', 1.9500, 0, 9.3213, 'N/A', 1.0100, 0.0002, 8245),
	(931472, 'CS8-1', 'OCT', 'Standard', '001-3324\\012.wiff', 1.0000, 2277650, 'OCT-d8', 191337, 50000.0000, 'pg/mL', 49277.8100, 'pg/mL', 98.5600, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 10, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:02:39', 'N/A', 787000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 356, 2.4300, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 11.5000, '', 'N/A', 0.0448, -0.1090, 'Analyst Classic', 2.3500, 'ng/mL', 'N/A', 68400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 317, 2.1600, 346, 2.3600, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0436, 0.6830, 'Analyst Classic', 1.7200, 0, 11.9039, 'N/A', 1.0100, 0.0002, 8245),
	(931473, 'A1-1.01', 'OCT', 'Unknown', '001-3324\\013.wiff', 20.0000, 681634, 'OCT-d8', 224199, 0.0000, 'pg/mL', 251539.4600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 11, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:08:12', 'N/A', 239000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 308.0000, 2.1000, 351, 2.3900, 'Base To Base', 'N/A', 0.2940, 'N/A', '510.300/120.200 Da', 'N/A', 2.9100, '', 'N/A', 0.0442, 0.5240, 'Analyst Classic', 0.9710, 'ng/mL', 'N/A', 82200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0431, 0.8180, 'Analyst Classic', 1.4500, 0, 3.0403, 'N/A', 1.0100, 0.0000, 8245),
	(931474, 'A1-1.03', 'OCT', 'Unknown', '001-3324\\014.wiff', 20.0000, 178891, 'OCT-d8', 226299, 0.0000, 'pg/mL', 65226.5600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 12, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:13:45', 'N/A', 63300.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 346, 2.3600, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.7570, '', 'N/A', 0.0440, -0.6530, 'Analyst Classic', 1.8400, 'ng/mL', 'N/A', 83600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 319, 2.1700, 348, 2.3700, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0428, 0.0982, 'Analyst Classic', 2.4300, 0, 0.7905, 'N/A', 1.0100, 0.0000, 8245),
	(931475, 'QC3-1', 'OCT', 'Quality Control', '001-3324\\015.wiff', 1.0000, 1694546, 'OCT-d8', 196197, 37500.0000, 'pg/mL', 35750.7600, 'pg/mL', 95.3400, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 13, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:19:16', 'N/A', 592000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 355, 2.4200, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 8.2800, '', 'N/A', 0.0445, -0.0280, 'Analyst Classic', 2.5400, 'ng/mL', 'N/A', 71400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 318, 2.1700, 342, 2.3300, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0428, 1.5700, 'Analyst Classic', 1.7400, 0, 8.6370, 'N/A', 1.0100, 0.0002, 8245),
	(931476, 'A1-1.05', 'OCT', 'Unknown', '001-3324\\016.wiff', 1.0000, 947033, 'OCT-d8', 262811, 0.0000, 'pg/mL', 14908.8500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 14, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:24:48', 'N/A', 329000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 3.4400, '', 'N/A', 0.0452, 0.3680, 'Analyst Classic', 1.5600, 'ng/mL', 'N/A', 95600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0428, 2.1100, 'Analyst Classic', 1.2400, 0, 3.6035, 'N/A', 1.0100, 0.0000, 8245),
	(931477, 'A1-1.07', 'OCT', 'Unknown', '001-3324\\017.wiff', 1.0000, 1132963, 'OCT-d8', 242066, 0.0000, 'pg/mL', 19367.9500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 15, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:30:20', 'N/A', 393000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 360, 2.4500, 'Base To Base', 'N/A', 0.2940, 'N/A', '510.300/120.200 Da', 'N/A', 4.4800, '', 'N/A', 0.0450, -0.0262, 'Analyst Classic', 2.3700, 'ng/mL', 'N/A', 87600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0434, 1.0100, 'Analyst Classic', 1.4700, 0, 4.6804, 'N/A', 1.0100, 0.0000, 8245),
	(931478, 'A1-1.09', 'OCT', 'Unknown', '001-3324\\018.wiff', 1.0000, 1031859, 'OCT-d8', 247278, 0.0000, 'pg/mL', 17266.5000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 16, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:35:51', 'N/A', 361000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 350, 2.3900, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 3.9800, '', 'N/A', 0.0452, 0.4890, 'Analyst Classic', 1.6500, 'ng/mL', 'N/A', 90900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 345, 2.3500, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0423, 0.5130, 'Analyst Classic', 1.3500, 0, 4.1729, 'N/A', 1.0100, 0.0000, 8245),
	(931479, 'A1-1.10', 'OCT', 'Unknown', '001-3324\\019.wiff', 1.0000, 299465, 'OCT-d8', 251240, 0.0000, 'pg/mL', 4923.5600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 17, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:41:23', 'N/A', 105000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 349, 2.3800, 'Base To Base', 'N/A', 0.2120, 'N/A', '510.300/120.200 Da', 'N/A', 1.1500, '', 'N/A', 0.0445, 0.9770, 'Analyst Classic', 1.7800, 'ng/mL', 'N/A', 91200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 342, 2.3300, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0428, 1.5600, 'Analyst Classic', 1.1900, 0, 1.1919, 'N/A', 1.0100, 0.0000, 8245),
	(931480, 'A2-1.01', 'OCT', 'Unknown', '001-3324\\020.wiff', 20.0000, 1130987, 'OCT-d8', 242418, 0.0000, 'pg/mL', 386121.4200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 18, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:46:55', 'N/A', 398000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 314.0000, 2.1400, 352, 2.4000, 'Base To Base', 'N/A', 0.2600, 'N/A', '510.300/120.200 Da', 'N/A', 4.4500, '', 'N/A', 0.0448, 0.1190, 'Analyst Classic', 1.4600, 'ng/mL', 'N/A', 89400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0420, 0.3950, 'Analyst Classic', 1.6100, 0, 4.6654, 'N/A', 1.0100, 0.0000, 8245),
	(931481, 'A2-1.03', 'OCT', 'Unknown', '001-3324\\021.wiff', 20.0000, 372821, 'OCT-d8', 230282, 0.0000, 'pg/mL', 133834.6900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 19, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:52:27', 'N/A', 132000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 314.0000, 2.1400, 347, 2.3600, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 1.5500, '', 'N/A', 0.0436, 0.5080, 'Analyst Classic', 1.0800, 'ng/mL', 'N/A', 85500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 318, 2.1700, 345, 2.3500, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0426, 0.8950, 'Analyst Classic', 1.8400, 0, 1.6190, 'N/A', 1.0100, 0.0000, 8245),
	(931482, 'A2-1.05', 'OCT', 'Unknown', '001-3324\\022.wiff', 1.0000, 1213485, 'OCT-d8', 221833, 0.0000, 'pg/mL', 22638.5800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 20, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 17:57:59', 'N/A', 420000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 368, 2.5100, 'Base To Base', 'N/A', 0.3550, 'N/A', '510.300/120.200 Da', 'N/A', 5.2200, '', 'N/A', 0.0447, -0.0099, 'Analyst Classic', 2.9500, 'ng/mL', 'N/A', 80400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 348, 2.3700, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0427, 0.8370, 'Analyst Classic', 2.1600, 0, 5.4703, 'N/A', 1.0100, 0.0000, 8245),
	(931483, 'A2-1.07', 'OCT', 'Unknown', '001-3324\\023.wiff', 1.0000, 3354591, 'OCT-d8', 290618, 0.0000, 'pg/mL', 47783.4500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 21, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:03:32', 'N/A', 1180000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 358, 2.4400, 'Base To Base', 'N/A', 0.2870, 'N/A', '510.300/120.200 Da', 'N/A', 11.2000, '', 'N/A', 0.0442, 0.0433, 'Analyst Classic', 2.1600, 'ng/mL', 'N/A', 106000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0426, 1.4500, 'Analyst Classic', 1.3500, 0, 11.5430, 'N/A', 1.0100, 0.0000, 8245),
	(931484, 'A2-1.09', 'OCT', 'Unknown', '001-3324\\024.wiff', 1.0000, 2107363, 'OCT-d8', 226285, 0.0000, 'pg/mL', 38549.4400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 22, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:09:05', 'N/A', 741000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 357, 2.4300, 'Base To Base', 'N/A', 0.2870, 'N/A', '510.300/120.200 Da', 'N/A', 8.8500, '', 'N/A', 0.0451, 0.1150, 'Analyst Classic', 1.9000, 'ng/mL', 'N/A', 83800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0420, 1.3900, 'Analyst Classic', 1.4300, 0, 9.3129, 'N/A', 1.0100, 0.0000, 8245),
	(931485, 'A2-1.10', 'OCT', 'Unknown', '001-3324\\025.wiff', 1.0000, 599749, 'OCT-d8', 224784, 0.0000, 'pg/mL', 11035.8500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 23, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:14:38', 'N/A', 213000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, 'N/A', '510.300/120.200 Da', 'N/A', 2.5700, '', 'N/A', 0.0437, 0.6820, 'Analyst Classic', 1.3600, 'ng/mL', 'N/A', 82800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 343, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0421, 1.2000, 'Analyst Classic', 1.2600, 0, 2.6681, 'N/A', 1.0100, 0.0000, 8245),
	(931486, 'A3-1.01', 'OCT', 'Unknown', '001-3324\\026.wiff', 20.0000, 764128, 'OCT-d8', 245921, 0.0000, 'pg/mL', 257080.0300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 24, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:20:10', 'N/A', 270000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 313.0000, 2.1300, 348, 2.3700, 'Base To Base', 'N/A', 0.2390, 'N/A', '510.300/120.200 Da', 'N/A', 2.9800, '', 'N/A', 0.0439, 0.4180, 'Analyst Classic', 1.1600, 'ng/mL', 'N/A', 90600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0420, 0.9160, 'Analyst Classic', 1.3700, 0, 3.1072, 'N/A', 1.0100, 0.0000, 8245),
	(931487, 'A3-1.03', 'OCT', 'Unknown', '001-3324\\027.wiff', 20.0000, 362085, 'OCT-d8', 240308, 0.0000, 'pg/mL', 124540.9800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 25, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:25:43', 'N/A', 129000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 1.4600, '', 'N/A', 0.0444, 0.2410, 'Analyst Classic', 1.2100, 'ng/mL', 'N/A', 88600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0421, 0.2260, 'Analyst Classic', 1.8600, 0, 1.5068, 'N/A', 1.0100, 0.0000, 8245),
	(931488, 'A3-1.05', 'OCT', 'Unknown', '001-3324\\028.wiff', 1.0000, 850036, 'OCT-d8', 222792, 0.0000, 'pg/mL', 15786.2500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 26, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:31:14', 'N/A', 300000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 348, 2.3700, 'Base To Base', 'N/A', 0.2120, 'N/A', '510.300/120.200 Da', 'N/A', 3.6400, '', 'N/A', 0.0450, 0.6910, 'Analyst Classic', 1.4900, 'ng/mL', 'N/A', 82500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0421, 1.3300, 'Analyst Classic', 1.3300, 0, 3.8154, 'N/A', 1.0100, 0.0000, 8245),
	(931489, 'A3-1.07', 'OCT', 'Unknown', '001-3324\\029.wiff', 1.0000, 1380216, 'OCT-d8', 243779, 0.0000, 'pg/mL', 23431.4500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 27, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:36:47', 'N/A', 489000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 350, 2.3900, 'Base To Base', 'N/A', 0.2320, 'N/A', '510.300/120.200 Da', 'N/A', 5.4900, '', 'N/A', 0.0437, 0.4180, 'Analyst Classic', 1.5900, 'ng/mL', 'N/A', 89000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 318, 2.1700, 344, 2.3400, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0426, 0.8930, 'Analyst Classic', 1.9500, 0, 5.6618, 'N/A', 1.0100, 0.0000, 8245),
	(931490, 'QC2-1', 'OCT', 'Quality Control', '001-3324\\030.wiff', 1.0000, 1494228, 'OCT-d8', 238887, 25000.0000, 'pg/mL', 25887.6600, 'pg/mL', 103.5500, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 28, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:42:19', 'N/A', 528000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 355, 2.4200, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 5.9900, '', 'N/A', 0.0442, -0.1760, 'Analyst Classic', 2.2800, 'ng/mL', 'N/A', 88200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0420, 0.8370, 'Analyst Classic', 1.3400, 0, 6.2550, 'N/A', 1.0100, 0.0003, 8245),
	(931491, 'A3-1.09', 'OCT', 'Unknown', '001-3324\\031.wiff', 1.0000, 1597677, 'OCT-d8', 257907, 0.0000, 'pg/mL', 25638.5000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 29, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:47:51', 'N/A', 561000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 354, 2.4100, 'Base To Base', 'N/A', 0.2600, 'N/A', '510.300/120.200 Da', 'N/A', 5.9000, '', 'N/A', 0.0453, 0.2030, 'Analyst Classic', 1.8200, 'ng/mL', 'N/A', 95000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0422, 0.9910, 'Analyst Classic', 1.6700, 0, 6.1948, 'N/A', 1.0100, 0.0000, 8245),
	(931492, 'A3-1.10', 'OCT', 'Unknown', '001-3324\\032.wiff', 1.0000, 464811, 'OCT-d8', 246953, 0.0000, 'pg/mL', 7781.5700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 30, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:53:23', 'N/A', 166000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 1.8000, '', 'N/A', 0.0441, 0.4900, 'Analyst Classic', 1.6500, 'ng/mL', 'N/A', 92000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 342, 2.3300, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0418, 1.7300, 'Analyst Classic', 1.4300, 0, 1.8822, 'N/A', 1.0100, 0.0000, 8245),
	(931493, 'A4-1.02', 'OCT', 'Unknown', '001-3324\\033.wiff', 20.0000, 651919, 'OCT-d8', 240622, 0.0000, 'pg/mL', 224128.1900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 31, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 18:58:54', 'N/A', 232000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 2.6000, '', 'N/A', 0.0436, 0.0958, 'Analyst Classic', 1.3200, 'ng/mL', 'N/A', 89200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0422, 1.5700, 'Analyst Classic', 1.3100, 0, 2.7093, 'N/A', 1.0100, 0.0000, 8245),
	(931494, 'A4-1.04', 'OCT', 'Unknown', '001-3324\\034.wiff', 20.0000, 33337, 'OCT-d8', 241222, 0.0000, 'pg/mL', 11207.2800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 32, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:04:35', 'N/A', 11700.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 342, 2.3300, 'Base To Base', 'N/A', 0.1430, 'N/A', '510.300/120.200 Da', 'N/A', 0.1310, '', 'N/A', 0.0448, -6.1900, 'Analyst Classic', 1.5900, 'ng/mL', 'N/A', 89700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0417, 0.5290, 'Analyst Classic', 1.7700, 0, 0.1382, 'N/A', 1.0100, 0.0000, 8245),
	(931495, 'A4-1.06', 'OCT', 'Unknown', '001-3324\\035.wiff', 1.0000, 676225, 'OCT-d8', 251763, 0.0000, 'pg/mL', 11109.7100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 33, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:10:07', 'N/A', 240000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 349, 2.3800, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 2.5800, '', 'N/A', 0.0443, 0.5250, 'Analyst Classic', 1.5800, 'ng/mL', 'N/A', 93000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 345, 2.3500, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0418, 0.7110, 'Analyst Classic', 1.3800, 0, 2.6860, 'N/A', 1.0100, 0.0000, 8245),
	(931496, 'A4-1.08', 'OCT', 'Unknown', '001-3324\\036.wiff', 1.0000, 585372, 'OCT-d8', 264432, 0.0000, 'pg/mL', 9154.2500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 34, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:15:40', 'N/A', 209000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 2.1100, '', 'N/A', 0.0442, 0.2880, 'Analyst Classic', 1.6700, 'ng/mL', 'N/A', 99000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0412, 0.3390, 'Analyst Classic', 1.7900, 0, 2.2137, 'N/A', 1.0100, 0.0000, 8245),
	(931497, 'A4-1.09', 'OCT', 'Unknown', '001-3324\\037.wiff', 1.0000, 361574, 'OCT-d8', 256451, 0.0000, 'pg/mL', 5826.0800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 35, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:21:13', 'N/A', 127000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 1.3200, '', 'N/A', 0.0443, 0.2900, 'Analyst Classic', 1.4500, 'ng/mL', 'N/A', 95800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0415, 0.9350, 'Analyst Classic', 1.6000, 0, 1.4099, 'N/A', 1.0100, 0.0000, 8245),
	(931498, 'A4-1.10', 'OCT', 'Unknown', '001-3324\\038.wiff', 1.0000, 87048, 'OCT-d8', 266144, 0.0000, 'pg/mL', 1342.4100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 36, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:26:45', 'N/A', 30800.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 349, 2.3800, 'Base To Base', 'N/A', 0.2050, 'N/A', '510.300/120.200 Da', 'N/A', 0.3160, '', 'N/A', 0.0443, 1.7200, 'Analyst Classic', 1.8400, 'ng/mL', 'N/A', 97700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0424, 0.5790, 'Analyst Classic', 1.8500, 0, 0.3271, 'N/A', 1.0100, 0.0000, 8245),
	(931499, 'A5-1.02', 'OCT', 'Unknown', '001-3324\\039.wiff', 20.0000, 470786, 'OCT-d8', 203953, 0.0000, 'pg/mL', 190919.7800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 37, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:32:18', 'N/A', 170000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 310.0000, 2.1100, 348, 2.3700, 'Base To Base', 'N/A', 0.2600, 'N/A', '510.300/120.200 Da', 'N/A', 2.2400, '', 'N/A', 0.0434, 0.5650, 'Analyst Classic', 0.9640, 'ng/mL', 'N/A', 75700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0416, 0.5690, 'Analyst Classic', 1.5700, 0, 2.3083, 'N/A', 1.0100, 0.0000, 8245),
	(931500, 'A5-1.04', 'OCT', 'Unknown', '001-3324\\040.wiff', 20.0000, 10563, 'OCT-d8', 239448, 0.0000, 'pg/mL', 3415.5900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 38, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:37:49', 'N/A', 3690.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1230, 'N/A', '510.300/120.200 Da', 'N/A', 0.0413, '', 'N/A', 0.0453, -19.8000, 'Analyst Classic', 1.6000, 'ng/mL', 'N/A', 89300.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0415, 0.6440, 'Analyst Classic', 1.6000, 0, 0.0441, 'N/A', 1.0100, 0.0000, 8245),
	(931501, 'A5-1.06', 'OCT', 'Unknown', '001-3324\\041.wiff', 1.0000, 127333, 'OCT-d8', 269098, 0.0000, 'pg/mL', 1947.4000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 39, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:43:21', 'N/A', 45800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1980, 'N/A', '510.300/120.200 Da', 'N/A', 0.4580, '', 'N/A', 0.0431, 0.6130, 'Analyst Classic', 1.5800, 'ng/mL', 'N/A', 100000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 343, 2.3400, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0414, 1.1700, 'Analyst Classic', 1.6400, 0, 0.4732, 'N/A', 1.0100, 0.0000, 8245),
	(931502, 'A5-1.08', 'OCT', 'Unknown', '001-3324\\042.wiff', 1.0000, 81637, 'OCT-d8', 258937, 0.0000, 'pg/mL', 1293.5600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 40, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:48:53', 'N/A', 29500.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, 'N/A', '510.300/120.200 Da', 'N/A', 0.3050, '', 'N/A', 0.0437, 0.8770, 'Analyst Classic', 1.1700, 'ng/mL', 'N/A', 97000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0413, 0.6980, 'Analyst Classic', 1.6700, 0, 0.3153, 'N/A', 1.0100, 0.0000, 8245),
	(931503, 'A5-1.09', 'OCT', 'Unknown', '001-3324\\043.wiff', 1.0000, 53496, 'OCT-d8', 251290, 0.0000, 'pg/mL', 869.6100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 41, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:54:24', 'N/A', 19000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, 'N/A', '510.300/120.200 Da', 'N/A', 0.2050, '', 'N/A', 0.0439, 2.7500, 'Analyst Classic', 0.9930, 'ng/mL', 'N/A', 93000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 353, 2.4100, 'Base To Base', 'N/A', 0.2530, '514.300/120.200 Da', 'N/A', 'N/A', 0.0416, 0.4250, 'Analyst Classic', 2.4300, 0, 0.2129, 'N/A', 1.0100, 0.0000, 8245),
	(931504, 'QC1-1', 'OCT', 'Quality Control', '001-3324\\044.wiff', 1.0000, 9602, 'OCT-d8', 201142, 150.0000, 'pg/mL', 185.7700, 'pg/mL', 123.8500, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 42, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 19:59:56', 'N/A', 3270.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 344, 2.3400, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0440, '', 'N/A', 0.0462, -23.0000, 'Analyst Classic', 2.1100, 'ng/mL', 'N/A', 74500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0417, 0.4160, 'Analyst Classic', 1.4300, 0, 0.0477, 'N/A', 1.0100, 0.0003, 8245),
	(931505, 'A5-1.10', 'OCT', 'Unknown', '001-3324\\045.wiff', 1.0000, 10268, 'OCT-d8', 239596, 0.0000, 'pg/mL', 165.5700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 43, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:05:28', 'N/A', 3740.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0416, '', 'N/A', 0.0434, 21.3000, 'Analyst Classic', 1.2800, 'ng/mL', 'N/A', 89800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0413, 1.8300, 'Analyst Classic', 1.2600, 0, 0.0429, 'N/A', 1.0100, 0.0000, 8245),
	(931506, 'A6-1.02', 'OCT', 'Unknown', '001-3324\\046.wiff', 20.0000, 1052690, 'OCT-d8', 246752, 0.0000, 'pg/mL', 353057.8100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 44, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:11:00', 'N/A', 378000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 313.0000, 2.1300, 353, 2.4100, 'Base To Base', 'N/A', 0.2730, 'N/A', '510.300/120.200 Da', 'N/A', 4.0700, '', 'N/A', 0.0432, 0.0859, 'Analyst Classic', 1.4700, 'ng/mL', 'N/A', 92800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 346, 2.3600, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0410, 0.4890, 'Analyst Classic', 1.9400, 0, 4.2662, 'N/A', 1.0100, 0.0000, 8245),
	(931507, 'A6-1.04', 'OCT', 'Unknown', '001-3324\\047.wiff', 20.0000, 156170, 'OCT-d8', 265376, 0.0000, 'pg/mL', 48496.3900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 45, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:16:32', 'N/A', 56000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, 'N/A', '510.300/120.200 Da', 'N/A', 0.5650, '', 'N/A', 0.0432, -1.4000, 'Analyst Classic', 1.2500, 'ng/mL', 'N/A', 99000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0419, 0.4190, 'Analyst Classic', 1.5900, 0, 0.5885, 'N/A', 1.0100, 0.0000, 8245),
	(931508, 'A6-1.06', 'OCT', 'Unknown', '001-3324\\048.wiff', 1.0000, 2637107, 'OCT-d8', 257148, 0.0000, 'pg/mL', 42451.3300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 46, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:22:04', 'N/A', 940000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 373, 2.5400, 'Base To Base', 'N/A', 0.3900, 'N/A', '510.300/120.200 Da', 'N/A', 9.7100, '', 'N/A', 0.0438, -0.0696, 'Analyst Classic', 3.2700, 'ng/mL', 'N/A', 96800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0411, 1.1800, 'Analyst Classic', 1.3500, 0, 10.2552, 'N/A', 1.0100, 0.0000, 8245),
	(931509, 'A6-1.08', 'OCT', 'Unknown', '001-3324\\049.wiff', 1.0000, 2801113, 'OCT-d8', 241028, 0.0000, 'pg/mL', 48108.8000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 47, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:27:37', 'N/A', 1000000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 355, 2.4200, 'Base To Base', 'N/A', 0.2670, 'N/A', '510.300/120.200 Da', 'N/A', 11.2000, '', 'N/A', 0.0432, 0.1370, 'Analyst Classic', 2.0000, 'ng/mL', 'N/A', 89700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0418, 0.8980, 'Analyst Classic', 1.8300, 0, 11.6215, 'N/A', 1.0100, 0.0000, 8245),
	(931510, 'A6-1.09', 'OCT', 'Unknown', '001-3324\\050.wiff', 1.0000, 2397877, 'OCT-d8', 258398, 0.0000, 'pg/mL', 38412.4000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 48, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:33:10', 'N/A', 852000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 362, 2.4700, 'Base To Base', 'N/A', 0.3140, 'N/A', '510.300/120.200 Da', 'N/A', 8.8100, '', 'N/A', 0.0434, 0.0286, 'Analyst Classic', 2.5100, 'ng/mL', 'N/A', 96700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0413, 0.7640, 'Analyst Classic', 1.5200, 0, 9.2798, 'N/A', 1.0100, 0.0000, 8245),
	(931511, 'A6-1.10', 'OCT', 'Unknown', '001-3324\\051.wiff', 1.0000, 643451, 'OCT-d8', 260678, 0.0000, 'pg/mL', 10208.8000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 49, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:38:42', 'N/A', 232000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 2.3900, '', 'N/A', 0.0434, 0.7400, 'Analyst Classic', 1.4000, 'ng/mL', 'N/A', 97000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 341, 2.3200, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0419, 1.3500, 'Analyst Classic', 1.4000, 0, 2.4684, 'N/A', 1.0100, 0.0000, 8245),
	(931512, 'B1-1.01', 'OCT', 'Unknown', '001-3324\\052.wiff', 20.0000, 1002679, 'OCT-d8', 229196, 0.0000, 'pg/mL', 362048.9700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 50, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:44:14', 'N/A', 360000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 294.0000, 2.0000, 348, 2.3700, 'Base To Base', 'N/A', 0.3690, 'N/A', '510.300/120.200 Da', 'N/A', 4.1600, '', 'N/A', 0.0430, 0.6600, 'Analyst Classic', 0.5380, 'ng/mL', 'N/A', 86500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0409, 0.4840, 'Analyst Classic', 1.6000, 0, 4.3748, 'N/A', 1.0100, 0.0000, 8245),
	(931513, 'B1-1.03', 'OCT', 'Unknown', '001-3324\\053.wiff', 20.0000, 1001470, 'OCT-d8', 249353, 0.0000, 'pg/mL', 332362.5600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 51, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:49:45', 'N/A', 359000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 356, 2.4300, 'Base To Base', 'N/A', 0.2600, 'N/A', '510.300/120.200 Da', 'N/A', 3.8200, '', 'N/A', 0.0430, -0.0096, 'Analyst Classic', 2.4900, 'ng/mL', 'N/A', 93900.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0417, 0.4320, 'Analyst Classic', 1.7700, 0, 4.0163, 'N/A', 1.0100, 0.0000, 8245),
	(931514, 'B1-1.05', 'OCT', 'Unknown', '001-3324\\054.wiff', 1.0000, 2303267, 'OCT-d8', 241595, 0.0000, 'pg/mL', 39463.4200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 52, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 20:55:16', 'N/A', 830000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 359, 2.4500, 'Base To Base', 'N/A', 0.2940, 'N/A', '510.300/120.200 Da', 'N/A', 9.0700, '', 'N/A', 0.0430, 0.0058, 'Analyst Classic', 2.2600, 'ng/mL', 'N/A', 91400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0409, 1.0500, 'Analyst Classic', 1.7500, 0, 9.5336, 'N/A', 1.0100, 0.0000, 8245),
	(931515, 'B1-1.07', 'OCT', 'Unknown', '001-3324\\055.wiff', 1.0000, 2757191, 'OCT-d8', 264919, 0.0000, 'pg/mL', 43082.6100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 53, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:00:47', 'N/A', 984000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 367, 2.5000, 'Base To Base', 'N/A', 0.3490, 'N/A', '510.300/120.200 Da', 'N/A', 9.8600, '', 'N/A', 0.0433, -0.0367, 'Analyst Classic', 2.9100, 'ng/mL', 'N/A', 99800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 345, 2.3500, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0412, 0.5850, 'Analyst Classic', 1.4600, 0, 10.4077, 'N/A', 1.0100, 0.0000, 8245),
	(931516, 'B1-1.09', 'OCT', 'Unknown', '001-3324\\056.wiff', 1.0000, 1173832, 'OCT-d8', 203333, 0.0000, 'pg/mL', 23891.8600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 54, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:06:19', 'N/A', 419000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 351, 2.3900, 'Base To Base', 'N/A', 0.2390, 'N/A', '510.300/120.200 Da', 'N/A', 5.4700, '', 'N/A', 0.0432, 0.2420, 'Analyst Classic', 1.7000, 'ng/mL', 'N/A', 76700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 341, 2.3200, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0409, 1.0500, 'Analyst Classic', 1.5000, 0, 5.7729, 'N/A', 1.0100, 0.0000, 8245),
	(931517, 'B1-1.10', 'OCT', 'Unknown', '001-3324\\057.wiff', 1.0000, 343325, 'OCT-d8', 238071, 0.0000, 'pg/mL', 5959.4100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 55, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:11:50', 'N/A', 124000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, 'N/A', '510.300/120.200 Da', 'N/A', 1.3900, '', 'N/A', 0.0432, 0.6350, 'Analyst Classic', 1.3300, 'ng/mL', 'N/A', 89600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0411, 0.6250, 'Analyst Classic', 1.5900, 0, 1.4421, 'N/A', 1.0100, 0.0000, 8245),
	(931518, 'QC3-2', 'OCT', 'Quality Control', '001-3324\\058.wiff', 1.0000, 2120948, 'OCT-d8', 244145, 37500.0000, 'pg/mL', 35958.9900, 'pg/mL', 95.8900, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 56, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:17:21', 'N/A', 762000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 355, 2.4200, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 8.2300, '', 'N/A', 0.0431, -0.0824, 'Analyst Classic', 2.3800, 'ng/mL', 'N/A', 92500.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 317, 2.1600, 342, 2.3300, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0415, 1.1300, 'Analyst Classic', 1.6100, 0, 8.6873, 'N/A', 1.0100, 0.0002, 8245),
	(931519, 'B2-1.01', 'OCT', 'Unknown', '001-3324\\059.wiff', 20.0000, 845615, 'OCT-d8', 259043, 0.0000, 'pg/mL', 270095.7300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 57, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:22:52', 'N/A', 304000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 348, 2.3700, 'Base To Base', 'N/A', 0.2050, 'N/A', '510.300/120.200 Da', 'N/A', 3.1500, '', 'N/A', 0.0431, -0.1120, 'Analyst Classic', 1.7300, 'ng/mL', 'N/A', 96400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 345, 2.3500, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0419, 0.2910, 'Analyst Classic', 1.9000, 0, 3.2644, 'N/A', 1.0100, 0.0000, 8245),
	(931520, 'B2-1.03', 'OCT', 'Unknown', '001-3324\\060.wiff', 20.0000, 1039408, 'OCT-d8', 245097, 0.0000, 'pg/mL', 350955.3000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 58, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:28:25', 'N/A', 377000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 308.0000, 2.1000, 355, 2.4200, 'Base To Base', 'N/A', 0.3210, 'N/A', '510.300/120.200 Da', 'N/A', 4.0400, '', 'N/A', 0.0430, 0.1780, 'Analyst Classic', 1.2100, 'ng/mL', 'N/A', 93400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0402, 0.7270, 'Analyst Classic', 1.3400, 0, 4.2408, 'N/A', 1.0100, 0.0000, 8245),
	(931521, 'B2-1.05', 'OCT', 'Unknown', '001-3324\\061.wiff', 1.0000, 7021019, 'OCT-d8', 248426, 0.0000, 'pg/mL', 117011.0900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:10', '2019-11-02 07:52:10', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 59, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:33:57', 'N/A', 2500000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 374, 2.5500, 'Base To Base', 'N/A', 0.3960, 'N/A', '510.300/120.200 Da', 'N/A', 27.2000, '', 'N/A', 0.0432, -0.0437, 'Analyst Classic', 3.4900, 'ng/mL', 'N/A', 92200.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 313, 2.1300, 343, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0424, 0.8200, 'Analyst Classic', 1.2200, 0, 28.2620, 'N/A', 1.0100, 0.0000, 8245),
	(931522, 'B2-1.07', 'OCT', 'Unknown', '001-3324\\062.wiff', 1.0000, 1654725, 'OCT-d8', 180272, 0.0000, 'pg/mL', 37995.2100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 60, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:39:29', 'N/A', 593000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 351, 2.3900, 'Base To Base', 'N/A', 0.2390, 'N/A', '510.300/120.200 Da', 'N/A', 8.7600, '', 'N/A', 0.0430, 0.1640, 'Analyst Classic', 1.6700, 'ng/mL', 'N/A', 67700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 313, 2.1300, 343, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0414, 1.2500, 'Analyst Classic', 1.1800, 0, 9.1790, 'N/A', 1.0100, 0.0000, 8245),
	(931523, 'B2-1.09', 'OCT', 'Unknown', '001-3324\\063.wiff', 1.0000, 1781469, 'OCT-d8', 252019, 0.0000, 'pg/mL', 29257.4700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 61, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:45:02', 'N/A', 644000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 355, 2.4200, 'Base To Base', 'N/A', 0.2600, 'N/A', '510.300/120.200 Da', 'N/A', 6.7800, '', 'N/A', 0.0430, 0.1060, 'Analyst Classic', 2.1100, 'ng/mL', 'N/A', 95000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 349, 2.3800, 'Base To Base', 'N/A', 0.2260, '514.300/120.200 Da', 'N/A', 'N/A', 0.0410, 0.4310, 'Analyst Classic', 2.0400, 0, 7.0688, 'N/A', 1.0100, 0.0000, 8245),
	(931524, 'B2-1.10', 'OCT', 'Unknown', '001-3324\\064.wiff', 1.0000, 559275, 'OCT-d8', 278402, 0.0000, 'pg/mL', 8306.1700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 62, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:50:33', 'N/A', 202000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 350, 2.3900, 'Base To Base', 'N/A', 0.2390, 'N/A', '510.300/120.200 Da', 'N/A', 1.9400, '', 'N/A', 0.0426, 0.2250, 'Analyst Classic', 1.5200, 'ng/mL', 'N/A', 104000.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0420, 0.7600, 'Analyst Classic', 1.7600, 0, 2.0089, 'N/A', 1.0100, 0.0000, 8245),
	(931525, 'B3-1.01', 'OCT', 'Unknown', '001-3324\\065.wiff', 20.0000, 757702, 'OCT-d8', 247911, 0.0000, 'pg/mL', 252866.9300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 63, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 21:56:04', 'N/A', 274000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 309.0000, 2.1000, 351, 2.3900, 'Base To Base', 'N/A', 0.2870, 'N/A', '510.300/120.200 Da', 'N/A', 2.9300, '', 'N/A', 0.0427, 0.2700, 'Analyst Classic', 1.0900, 'ng/mL', 'N/A', 93600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0406, 0.8420, 'Analyst Classic', 1.1900, 0, 3.0563, 'N/A', 1.0100, 0.0000, 8245),
	(931526, 'B3-1.03', 'OCT', 'Unknown', '001-3324\\066.wiff', 20.0000, 1248151, 'OCT-d8', 251477, 0.0000, 'pg/mL', 410785.5400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 64, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:01:35', 'N/A', 454000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 314.0000, 2.1400, 350, 2.3900, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 4.7400, '', 'N/A', 0.0426, 0.2440, 'Analyst Classic', 1.3700, 'ng/mL', 'N/A', 95800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 0.3820, 'Analyst Classic', 1.7600, 0, 4.9633, 'N/A', 1.0100, 0.0000, 8245),
	(931527, 'B3-1.05', 'OCT', 'Unknown', '001-3324\\067.wiff', 1.0000, 2796657, 'OCT-d8', 239793, 0.0000, 'pg/mL', 48279.6100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 65, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:07:07', 'N/A', 1000000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 357, 2.4300, 'Base To Base', 'N/A', 0.2800, 'N/A', '510.300/120.200 Da', 'N/A', 11.1000, '', 'N/A', 0.0432, 0.0713, 'Analyst Classic', 2.2000, 'ng/mL', 'N/A', 90500.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0419, 1.0800, 'Analyst Classic', 1.4000, 0, 11.6628, 'N/A', 1.0100, 0.0000, 8245),
	(931528, 'B3-1.07', 'OCT', 'Unknown', '001-3324\\068.wiff', 1.0000, 2301489, 'OCT-d8', 254260, 0.0000, 'pg/mL', 37468.0500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 66, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:12:38', 'N/A', 836000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 8.6800, '', 'N/A', 0.0426, 0.1800, 'Analyst Classic', 1.7400, 'ng/mL', 'N/A', 96400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0406, 0.6020, 'Analyst Classic', 1.6800, 0, 9.0517, 'N/A', 1.0100, 0.0000, 8245),
	(931529, 'B3-1.09', 'OCT', 'Unknown', '001-3324\\069.wiff', 1.0000, 877693, 'OCT-d8', 200068, 0.0000, 'pg/mL', 18153.0200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 67, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:18:10', 'N/A', 314000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 353, 2.4100, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 4.1800, '', 'N/A', 0.0432, 0.2310, 'Analyst Classic', 1.8400, 'ng/mL', 'N/A', 75200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 343, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0415, 0.9390, 'Analyst Classic', 1.3000, 0, 4.3870, 'N/A', 1.0100, 0.0000, 8245),
	(931530, 'B3-1.10', 'OCT', 'Unknown', '001-3324\\070.wiff', 1.0000, 243353, 'OCT-d8', 270112, 0.0000, 'pg/mL', 3718.5700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 68, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:23:42', 'N/A', 88500.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 348, 2.3700, 'Base To Base', 'N/A', 0.2120, 'N/A', '510.300/120.200 Da', 'N/A', 0.8800, '', 'N/A', 0.0424, 0.3680, 'Analyst Classic', 1.5700, 'ng/mL', 'N/A', 101000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0416, 0.7650, 'Analyst Classic', 1.4700, 0, 0.9009, 'N/A', 1.0100, 0.0000, 8245),
	(931531, 'B4-1.02', 'OCT', 'Unknown', '001-3324\\071.wiff', 20.0000, 989779, 'OCT-d8', 249142, 0.0000, 'pg/mL', 328756.9100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 69, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:29:15', 'N/A', 362000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 350, 2.3900, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 3.8200, '', 'N/A', 0.0424, 0.1790, 'Analyst Classic', 1.7000, 'ng/mL', 'N/A', 94700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 0.0127, 'Analyst Classic', 1.5400, 0, 3.9727, 'N/A', 1.0100, 0.0000, 8245),
	(931532, 'QC2-2', 'OCT', 'Quality Control', '001-3324\\072.wiff', 1.0000, 1515879, 'OCT-d8', 237354, 25000.0000, 'pg/mL', 26432.6600, 'pg/mL', 105.7300, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 70, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:34:46', 'N/A', 548000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 350, 2.3900, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 6.0300, '', 'N/A', 0.0429, 0.0014, 'Analyst Classic', 1.9000, 'ng/mL', 'N/A', 90800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 1.0700, 'Analyst Classic', 1.2300, 0, 6.3866, 'N/A', 1.0100, 0.0003, 8245),
	(931533, 'B4-1.04', 'OCT', 'Unknown', '001-3324\\073.wiff', 20.0000, 217610, 'OCT-d8', 217731, 0.0000, 'pg/mL', 82529.2500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 71, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:40:18', 'N/A', 79800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 346, 2.3600, 'Base To Base', 'N/A', 0.1780, 'N/A', '510.300/120.200 Da', 'N/A', 0.9780, '', 'N/A', 0.0420, -1.2500, 'Analyst Classic', 1.8600, 'ng/mL', 'N/A', 81600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 346, 2.3600, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0415, -0.2010, 'Analyst Classic', 1.9800, 0, 0.9994, 'N/A', 1.0100, 0.0000, 8245),
	(931534, 'B4-1.06', 'OCT', 'Unknown', '001-3324\\074.wiff', 1.0000, 1684608, 'OCT-d8', 249969, 0.0000, 'pg/mL', 27893.0700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 72, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:45:50', 'N/A', 610000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 353, 2.4100, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 6.3900, '', 'N/A', 0.0436, 0.1060, 'Analyst Classic', 1.8900, 'ng/mL', 'N/A', 95500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.7540, 'Analyst Classic', 1.6800, 0, 6.7393, 'N/A', 1.0100, 0.0000, 8245),
	(931535, 'B4-1.08', 'OCT', 'Unknown', '001-3324\\075.wiff', 1.0000, 1991161, 'OCT-d8', 267604, 0.0000, 'pg/mL', 30797.4200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 73, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:51:22', 'N/A', 727000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 360, 2.4500, 'Base To Base', 'N/A', 0.3010, 'N/A', '510.300/120.200 Da', 'N/A', 7.1500, '', 'N/A', 0.0423, 0.0266, 'Analyst Classic', 2.3400, 'ng/mL', 'N/A', 102000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 0.7750, 'Analyst Classic', 1.4600, 0, 7.4407, 'N/A', 1.0100, 0.0000, 8245),
	(931536, 'B4-1.09', 'OCT', 'Unknown', '001-3324\\076.wiff', 1.0000, 1532201, 'OCT-d8', 245735, 0.0000, 'pg/mL', 25805.7600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 74, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 22:56:54', 'N/A', 549000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 349, 2.3800, 'Base To Base', 'N/A', 0.2320, 'N/A', '510.300/120.200 Da', 'N/A', 5.9300, '', 'N/A', 0.0432, 0.4080, 'Analyst Classic', 1.4400, 'ng/mL', 'N/A', 92500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 313, 2.1300, 347, 2.3600, 'Base To Base', 'N/A', 0.2320, '514.300/120.200 Da', 'N/A', 'N/A', 0.0416, 0.4590, 'Analyst Classic', 1.5000, 0, 6.2352, 'N/A', 1.0100, 0.0000, 8245),
	(931537, 'B4-1.10', 'OCT', 'Unknown', '001-3324\\077.wiff', 1.0000, 531430, 'OCT-d8', 268142, 0.0000, 'pg/mL', 8194.4400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 75, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:02:25', 'N/A', 192000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 350, 2.3900, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 1.8700, '', 'N/A', 0.0433, 0.2470, 'Analyst Classic', 1.6800, 'ng/mL', 'N/A', 102000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 1.1700, 'Analyst Classic', 1.1600, 0, 1.9819, 'N/A', 1.0100, 0.0000, 8245),
	(931538, 'B5-1.02', 'OCT', 'Unknown', '001-3324\\078.wiff', 20.0000, 737333, 'OCT-d8', 226711, 0.0000, 'pg/mL', 269094.5600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 76, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:07:56', 'N/A', 266000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 296.0000, 2.0200, 351, 2.3900, 'Base To Base', 'N/A', 0.3760, 'N/A', '510.300/120.200 Da', 'N/A', 3.1000, '', 'N/A', 0.0426, 0.7090, 'Analyst Classic', 0.6650, 'ng/mL', 'N/A', 86000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0408, 1.5700, 'Analyst Classic', 1.3400, 0, 3.2523, 'N/A', 1.0100, 0.0000, 8245),
	(931539, 'B5-1.04', 'OCT', 'Unknown', '001-3324\\079.wiff', 20.0000, 744956, 'OCT-d8', 259087, 0.0000, 'pg/mL', 237875.1200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 77, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:13:27', 'N/A', 268000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 298.0000, 2.0300, 347, 2.3600, 'Base To Base', 'N/A', 0.3350, 'N/A', '510.300/120.200 Da', 'N/A', 2.7300, '', 'N/A', 0.0428, 0.8410, 'Analyst Classic', 0.5730, 'ng/mL', 'N/A', 98200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0408, 0.5870, 'Analyst Classic', 1.7700, 0, 2.8753, 'N/A', 1.0100, 0.0000, 8245),
	(931540, 'B5-1.06', 'OCT', 'Unknown', '001-3324\\080.wiff', 1.0000, 2282785, 'OCT-d8', 262325, 0.0000, 'pg/mL', 36020.4800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 78, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:19:00', 'N/A', 826000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 362, 2.4700, 'Base To Base', 'N/A', 0.3140, 'N/A', '510.300/120.200 Da', 'N/A', 8.1700, '', 'N/A', 0.0435, -0.0346, 'Analyst Classic', 2.4300, 'ng/mL', 'N/A', 101000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.8180, 'Analyst Classic', 1.4400, 0, 8.7021, 'N/A', 1.0100, 0.0000, 8245),
	(931541, 'B5-1.08', 'OCT', 'Unknown', '001-3324\\081.wiff', 1.0000, 1707957, 'OCT-d8', 234797, 0.0000, 'pg/mL', 30107.9300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 79, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:24:33', 'N/A', 620000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 6.9900, '', 'N/A', 0.0425, 0.2300, 'Analyst Classic', 1.7700, 'ng/mL', 'N/A', 88600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 343, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0414, 0.9250, 'Analyst Classic', 1.3000, 0, 7.2742, 'N/A', 1.0100, 0.0000, 8245),
	(931542, 'B5-1.09', 'OCT', 'Unknown', '001-3324\\082.wiff', 1.0000, 1506170, 'OCT-d8', 274461, 0.0000, 'pg/mL', 22710.8900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 80, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:30:04', 'N/A', 541000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 5.1900, '', 'N/A', 0.0430, 0.2640, 'Analyst Classic', 1.7600, 'ng/mL', 'N/A', 104000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 353, 2.4100, 'Base To Base', 'N/A', 0.2600, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 0.4530, 'Analyst Classic', 2.2600, 0, 5.4877, 'N/A', 1.0100, 0.0000, 8245),
	(931543, 'B5-1.10', 'OCT', 'Unknown', '001-3324\\083.wiff', 1.0000, 410331, 'OCT-d8', 274786, 0.0000, 'pg/mL', 6171.2500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 81, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:35:36', 'N/A', 150000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 348, 2.3700, 'Base To Base', 'N/A', 0.2120, 'N/A', '510.300/120.200 Da', 'N/A', 1.4400, '', 'N/A', 0.0425, 0.4390, 'Analyst Classic', 1.5300, 'ng/mL', 'N/A', 105000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 313, 2.1300, 347, 2.3600, 'Base To Base', 'N/A', 0.2320, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.3390, 'Analyst Classic', 1.4300, 0, 1.4933, 'N/A', 1.0100, 0.0000, 8245),
	(931544, 'B6-1.02', 'OCT', 'Unknown', '001-3324\\084.wiff', 20.0000, 561949, 'OCT-d8', 203505, 0.0000, 'pg/mL', 228438.5300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 82, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:41:07', 'N/A', 203000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 308.0000, 2.1000, 353, 2.4100, 'Base To Base', 'N/A', 0.3080, 'N/A', '510.300/120.200 Da', 'N/A', 2.6300, '', 'N/A', 0.0427, 0.1620, 'Analyst Classic', 1.1300, 'ng/mL', 'N/A', 77000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0413, 0.8320, 'Analyst Classic', 1.4200, 0, 2.7614, 'N/A', 1.0100, 0.0000, 8245),
	(931545, 'B6-1.04', 'OCT', 'Unknown', '001-3324\\085.wiff', 20.0000, 863693, 'OCT-d8', 221781, 0.0000, 'pg/mL', 322265.6000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 83, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:46:39', 'N/A', 311000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 297.0000, 2.0200, 352, 2.4000, 'Base To Base', 'N/A', 0.3760, 'N/A', '510.300/120.200 Da', 'N/A', 3.7300, '', 'N/A', 0.0427, 0.3900, 'Analyst Classic', 0.7130, 'ng/mL', 'N/A', 83400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 343, 2.3400, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0413, 0.4640, 'Analyst Classic', 1.6600, 0, 3.8944, 'N/A', 1.0100, 0.0000, 8245),
	(931546, 'B6-1.06', 'OCT', 'Unknown', '001-3324\\086.wiff', 1.0000, 2371722, 'OCT-d8', 230385, 0.0000, 'pg/mL', 42614.3400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 84, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:52:10', 'N/A', 860000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 361, 2.4600, 'Base To Base', 'N/A', 0.3080, 'N/A', '510.300/120.200 Da', 'N/A', 9.7800, '', 'N/A', 0.0429, -0.0449, 'Analyst Classic', 2.3800, 'ng/mL', 'N/A', 87900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 349, 2.3800, 'Base To Base', 'N/A', 0.2320, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.7100, 'Analyst Classic', 1.8400, 0, 10.2946, 'N/A', 1.0100, 0.0000, 8245),
	(931547, 'QC1-2', 'OCT', 'Quality Control', '001-3324\\087.wiff', 1.0000, 8799, 'OCT-d8', 174131, 150.0000, 'pg/mL', 197.3400, 'pg/mL', 131.5600, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 85, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-21 23:57:43', 'N/A', 2950.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 344, 2.3400, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0451, '', 'N/A', 0.0443, -21.8000, 'Analyst Classic', 2.0500, 'ng/mL', 'N/A', 65400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0416, 0.9420, 'Analyst Classic', 1.5900, 0, 0.0505, 'N/A', 1.0100, 0.0003, 8245),
	(931548, 'B6-1.08', 'OCT', 'Unknown', '001-3324\\088.wiff', 1.0000, 2418679, 'OCT-d8', 260976, 0.0000, 'pg/mL', 38362.8500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 86, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:03:14', 'N/A', 870000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 363, 2.4700, 'Base To Base', 'N/A', 0.3280, 'N/A', '510.300/120.200 Da', 'N/A', 8.7300, '', 'N/A', 0.0429, -0.0272, 'Analyst Classic', 2.4300, 'ng/mL', 'N/A', 99700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 350, 2.3900, 'Base To Base', 'N/A', 0.2390, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 0.3730, 'Analyst Classic', 2.0200, 0, 9.2678, 'N/A', 1.0100, 0.0000, 8245),
	(931549, 'B6-1.09', 'OCT', 'Unknown', '001-3324\\089.wiff', 1.0000, 1708744, 'OCT-d8', 245658, 0.0000, 'pg/mL', 28789.5800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 87, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:08:46', 'N/A', 625000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 357, 2.4300, 'Base To Base', 'N/A', 0.2800, 'N/A', '510.300/120.200 Da', 'N/A', 6.5500, '', 'N/A', 0.0425, 0.0700, 'Analyst Classic', 2.0900, 'ng/mL', 'N/A', 95400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0396, 1.4500, 'Analyst Classic', 1.2900, 0, 6.9558, 'N/A', 1.0100, 0.0000, 8245),
	(931550, 'B6-1.10', 'OCT', 'Unknown', '001-3324\\090.wiff', 1.0000, 473047, 'OCT-d8', 269629, 0.0000, 'pg/mL', 7252.6100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 88, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:14:17', 'N/A', 171000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 315.0000, 2.1500, 352, 2.4000, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 1.6800, '', 'N/A', 0.0427, 0.5360, 'Analyst Classic', 1.6600, 'ng/mL', 'N/A', 102000.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0414, 0.6470, 'Analyst Classic', 1.5900, 0, 1.7544, 'N/A', 1.0100, 0.0000, 8245),
	(931551, 'C1-1.01', 'OCT', 'Unknown', '001-3324\\091.wiff', 1.0000, 425114, 'OCT-d8', 244742, 0.0000, 'pg/mL', 7180.3600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 89, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:19:47', 'N/A', 155000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 347, 2.3600, 'Base To Base', 'N/A', 0.2050, 'N/A', '510.300/120.200 Da', 'N/A', 1.6500, '', 'N/A', 0.0426, 0.3550, 'Analyst Classic', 1.4600, 'ng/mL', 'N/A', 93900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.5030, 'Analyst Classic', 1.8600, 0, 1.7370, 'N/A', 1.0100, 0.0000, 8245),
	(931552, 'C1-1.03', 'OCT', 'Unknown', '001-3324\\092.wiff', 1.0000, 36543, 'OCT-d8', 241431, 0.0000, 'pg/mL', 614.8500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 90, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:25:21', 'N/A', 13400.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 344, 2.3400, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.1450, '', 'N/A', 0.0426, -1.0600, 'Analyst Classic', 1.5800, 'ng/mL', 'N/A', 92600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 1.3000, 'Analyst Classic', 1.4700, 0, 0.1514, 'N/A', 1.0100, 0.0000, 8245),
	(931553, 'C1-1.05', 'OCT', 'Unknown', '001-3324\\093.wiff', 1.0000, 40424, 'OCT-d8', 269037, 0.0000, 'pg/mL', 610.2600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 91, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:30:54', 'N/A', 14500.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 341, 2.3200, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.1430, '', 'N/A', 0.0430, 2.5500, 'Analyst Classic', 1.2000, 'ng/mL', 'N/A', 102000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0410, 1.2000, 'Analyst Classic', 1.5400, 0, 0.1503, 'N/A', 1.0100, 0.0000, 8245),
	(931554, 'C1-1.07', 'OCT', 'Unknown', '001-3324\\094.wiff', 1.0000, 6153, 'OCT-d8', 279597, 0.0000, 'pg/mL', 79.2300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 92, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:36:25', 'N/A', 2280.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 342, 2.3300, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0214, '', 'N/A', 0.0401, -5.4600, 'Analyst Classic', 1.4300, 'ng/mL', 'N/A', 107000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 351, 2.3900, 'Base To Base', 'N/A', 0.2460, '514.300/120.200 Da', 'N/A', 'N/A', 0.0400, 0.5520, 'Analyst Classic', 2.0500, 0, 0.0220, 'N/A', 1.0100, 0.0000, 8245),
	(931555, 'C1-1.09', 'OCT', 'Unknown', '001-3324\\095.wiff', 1.0000, 11164, 'OCT-d8', 260896, 0.0000, 'pg/mL', 165.3100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 93, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:41:58', 'N/A', 4000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2600, 321.0000, 2.1900, 344, 2.3400, 'Base To Base', 'N/A', 0.1570, 'N/A', '510.300/120.200 Da', 'N/A', 0.0396, '', 'N/A', 0.0430, 11.8000, 'Analyst Classic', 1.6500, 'ng/mL', 'N/A', 101000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.9820, 'Analyst Classic', 1.5000, 0, 0.0428, 'N/A', 1.0100, 0.0000, 8245),
	(931556, 'C1-1.10', 'OCT', 'Unknown', '001-3324\\096.wiff', 1.0000, 5850, 'OCT-d8', 277045, 0.0000, 'pg/mL', 75.5500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 94, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:47:30', 'N/A', 2100.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0200, '', 'N/A', 0.0447, 5.7400, 'Analyst Classic', 1.3000, 'ng/mL', 'N/A', 105000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 0.8020, 'Analyst Classic', 1.7100, 0, 0.0211, 'N/A', 1.0100, 0.0000, 8245),
	(931557, 'C2-1.01', 'OCT', 'Unknown', '001-3324\\097.wiff', 1.0000, 495083, 'OCT-d8', 265150, 0.0000, 'pg/mL', 7719.4600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 95, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:53:03', 'N/A', 181000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 351, 2.3900, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 1.7900, '', 'N/A', 0.0423, 0.4760, 'Analyst Classic', 1.9500, 'ng/mL', 'N/A', 101000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 1.0600, 'Analyst Classic', 1.3800, 0, 1.8672, 'N/A', 1.0100, 0.0000, 8245),
	(931558, 'C2-1.03', 'OCT', 'Unknown', '001-3324\\098.wiff', 1.0000, 65861, 'OCT-d8', 262070, 0.0000, 'pg/mL', 1028.7100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 96, 'ANSI-96well2mL', 4, 0.0000, '', '', 'pg/mL', '2019-10-22 00:58:34', 'N/A', 24400.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, 'N/A', '510.300/120.200 Da', 'N/A', 0.2410, '', 'N/A', 0.0419, 0.4270, 'Analyst Classic', 1.1200, 'ng/mL', 'N/A', 102000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0396, 0.8400, 'Analyst Classic', 1.7700, 0, 0.2513, 'N/A', 1.0100, 0.0000, 8245),
	(931559, 'C2-1.05', 'OCT', 'Unknown', '001-3324\\099.wiff', 1.0000, 80048, 'OCT-d8', 244971, 0.0000, 'pg/mL', 1341.1400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 1, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:04:07', 'N/A', 29600.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1980, 'N/A', '510.300/120.200 Da', 'N/A', 0.3190, '', 'N/A', 0.0415, 2.4000, 'Analyst Classic', 1.6400, 'ng/mL', 'N/A', 92700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0412, 0.8780, 'Analyst Classic', 1.9300, 0, 0.3268, 'N/A', 1.0100, 0.0000, 8245),
	(931560, 'C2-1.07', 'OCT', 'Unknown', '001-3324\\100.wiff', 1.0000, 7386, 'OCT-d8', 242586, 0.0000, 'pg/mL', 114.1900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 2, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:09:38', 'N/A', 2770.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 342, 2.3300, 'Base To Base', 'N/A', 0.1430, 'N/A', '510.300/120.200 Da', 'N/A', 0.0298, '', 'N/A', 0.0422, 13.1000, 'Analyst Classic', 1.4600, 'ng/mL', 'N/A', 92700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 1.7600, 'Analyst Classic', 1.3200, 0, 0.0304, 'N/A', 1.0100, 0.0000, 8245),
	(931561, 'C2-1.09', 'OCT', 'Unknown', '001-3324\\101.wiff', 1.0000, 41782, 'OCT-d8', 236444, 0.0000, 'pg/mL', 719.8100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 3, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:15:10', 'N/A', 15400.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 342, 2.3300, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.1690, '', 'N/A', 0.0423, 2.9300, 'Analyst Classic', 1.3700, 'ng/mL', 'N/A', 90800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 344, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 1.0300, 'Analyst Classic', 1.3200, 0, 0.1767, 'N/A', 1.0100, 0.0000, 8245),
	(931562, 'C2-1.10', 'OCT', 'Unknown', '001-3324\\102.wiff', 1.0000, 4200, 'OCT-d8', 251319, 0.0000, 'pg/mL', 57.3200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 4, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:20:42', 'N/A', 1590.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 340, 2.3200, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0169, '', 'N/A', 0.0404, 4.7300, 'Analyst Classic', 1.3100, 'ng/mL', 'N/A', 94600.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 315, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2260, '514.300/120.200 Da', 'N/A', 'N/A', 0.0417, 0.4750, 'Analyst Classic', 1.8600, 0, 0.0167, 'N/A', 1.0100, 0.0000, 8245),
	(931563, 'C3-1.01', 'OCT', 'Unknown', '001-3324\\103.wiff', 1.0000, 363958, 'OCT-d8', 253741, 0.0000, 'pg/mL', 5927.3500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 5, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:26:13', 'N/A', 132000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 353, 2.4100, 'Base To Base', 'N/A', 0.2460, 'N/A', '510.300/120.200 Da', 'N/A', 1.3700, '', 'N/A', 0.0426, 0.2150, 'Analyst Classic', 1.9400, 'ng/mL', 'N/A', 96800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 312, 2.1300, 342, 2.3300, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 1.0300, 'Analyst Classic', 1.0100, 0, 1.4344, 'N/A', 1.0100, 0.0000, 8245),
	(931564, 'C3-1.03', 'OCT', 'Unknown', '001-3324\\104.wiff', 1.0000, 48138, 'OCT-d8', 241598, 0.0000, 'pg/mL', 813.1300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 6, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:31:45', 'N/A', 17800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 343, 2.3400, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.1930, '', 'N/A', 0.0423, 0.6980, 'Analyst Classic', 1.2200, 'ng/mL', 'N/A', 92100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 348, 2.3700, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 0.4740, 'Analyst Classic', 2.1200, 0, 0.1992, 'N/A', 1.0100, 0.0000, 8245),
	(931565, 'QC3-3', 'OCT', 'Quality Control', '001-3324\\105.wiff', 1.0000, 1659266, 'OCT-d8', 196410, 37500.0000, 'pg/mL', 34968.2000, 'pg/mL', 93.2500, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 7, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:37:18', 'N/A', 606000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 363, 2.4700, 'Base To Base', 'N/A', 0.3080, 'N/A', '510.300/120.200 Da', 'N/A', 8.0700, '', 'N/A', 0.0421, -0.1930, 'Analyst Classic', 3.0900, 'ng/mL', 'N/A', 75100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 0.2810, 'Analyst Classic', 1.7400, 0, 8.4480, 'N/A', 1.0100, 0.0002, 8245),
	(931566, 'C3-1.05', 'OCT', 'Unknown', '001-3324\\106.wiff', 1.0000, 75361, 'OCT-d8', 243384, 0.0000, 'pg/mL', 1270.2100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 8, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:42:50', 'N/A', 27800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 351, 2.3900, 'Base To Base', 'N/A', 0.2260, 'N/A', '510.300/120.200 Da', 'N/A', 0.2990, '', 'N/A', 0.0420, 0.1800, 'Analyst Classic', 1.9100, 'ng/mL', 'N/A', 93000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 345, 2.3500, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.6400, 'Analyst Classic', 1.3900, 0, 0.3096, 'N/A', 1.0100, 0.0000, 8245),
	(931567, 'C3-1.07', 'OCT', 'Unknown', '001-3324\\107.wiff', 1.0000, 3173, 'OCT-d8', 261828, 0.0000, 'pg/mL', 38.2900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 9, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:48:22', 'N/A', 1110.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 339, 2.3100, 'Base To Base', 'N/A', 0.1160, 'N/A', '510.300/120.200 Da', 'N/A', 0.0110, '', 'N/A', 0.0476, 80.3000, 'Analyst Classic', 1.2200, 'ng/mL', 'N/A', 100000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2260, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.6200, 'Analyst Classic', 1.7200, 0, 0.0121, 'N/A', 1.0100, 0.0000, 8245),
	(931568, 'C3-1.09', 'OCT', 'Unknown', '001-3324\\108.wiff', 1.0000, 13617, 'OCT-d8', 279570, 0.0000, 'pg/mL', 189.8000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 10, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:53:55', 'N/A', 4910.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 344, 2.3400, 'Base To Base', 'N/A', 0.1850, 'N/A', '510.300/120.200 Da', 'N/A', 0.0459, '', 'N/A', 0.0419, 4.2400, 'Analyst Classic', 1.2500, 'ng/mL', 'N/A', 107000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 340, 2.3200, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0410, 1.9200, 'Analyst Classic', 1.2700, 0, 0.0487, 'N/A', 1.0100, 0.0000, 8245),
	(931569, 'C3-1.10', 'OCT', 'Unknown', '001-3324\\109.wiff', 1.0000, 3874, 'OCT-d8', 274915, 0.0000, 'pg/mL', 46.4700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 11, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 01:59:27', 'N/A', 1460.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 339, 2.3100, 'Base To Base', 'N/A', 0.1430, 'N/A', '510.300/120.200 Da', 'N/A', 0.0139, '', 'N/A', 0.0409, 27.8000, 'Analyst Classic', 0.7850, 'ng/mL', 'N/A', 105000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 315, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0410, 0.8430, 'Analyst Classic', 1.5100, 0, 0.0141, 'N/A', 1.0100, 0.0000, 8245),
	(931570, 'C4-1.02', 'OCT', 'Unknown', '001-3324\\110.wiff', 1.0000, 321226, 'OCT-d8', 261944, 0.0000, 'pg/mL', 5065.8500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 12, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:05:00', 'N/A', 119000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1980, 'N/A', '510.300/120.200 Da', 'N/A', 1.1800, '', 'N/A', 0.0424, 0.5360, 'Analyst Classic', 1.5700, 'ng/mL', 'N/A', 101000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.7200, 'Analyst Classic', 1.6700, 0, 1.2263, 'N/A', 1.0100, 0.0000, 8245),
	(931571, 'C4-1.04', 'OCT', 'Unknown', '001-3324\\111.wiff', 1.0000, 32766, 'OCT-d8', 244446, 0.0000, 'pg/mL', 543.1400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 13, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:10:32', 'N/A', 11900.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 342, 2.3300, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.1280, '', 'N/A', 0.0427, 2.5000, 'Analyst Classic', 1.0900, 'ng/mL', 'N/A', 93000.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 314, 2.1400, 341, 2.3200, 'Base To Base', 'N/A', 0.1840, '514.300/120.200 Da', 'N/A', 'N/A', 0.0411, 1.0200, 'Analyst Classic', 1.1500, 0, 0.1340, 'N/A', 1.0100, 0.0000, 8245),
	(931572, 'C4-1.06', 'OCT', 'Unknown', '001-3324\\112.wiff', 1.0000, 14982, 'OCT-d8', 263907, 0.0000, 'pg/mL', 223.1900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 14, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:16:03', 'N/A', 5490.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 342, 2.3300, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0539, '', 'N/A', 0.0432, -6.4600, 'Analyst Classic', 1.6800, 'ng/mL', 'N/A', 102000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 344, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.9050, 'Analyst Classic', 1.3000, 0, 0.0568, 'N/A', 1.0100, 0.0000, 8245),
	(931573, 'C4-1.08', 'OCT', 'Unknown', '001-3324\\113.wiff', 1.0000, 10699, 'OCT-d8', 235888, 0.0000, 'pg/mL', 175.9300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 15, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:21:35', 'N/A', 3960.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 341, 2.3200, 'Base To Base', 'N/A', 0.1440, 'N/A', '510.300/120.200 Da', 'N/A', 0.0436, '', 'N/A', 0.0417, 9.5600, 'Analyst Classic', 1.1200, 'ng/mL', 'N/A', 91000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 1.5800, 'Analyst Classic', 1.2900, 0, 0.0454, 'N/A', 1.0100, 0.0000, 8245),
	(931574, 'C4-1.09', 'OCT', 'Unknown', '001-3324\\114.wiff', 1.0000, 55734, 'OCT-d8', 255711, 0.0000, 'pg/mL', 890.6000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 16, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:27:07', 'N/A', 20300.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 343, 2.3400, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.2070, '', 'N/A', 0.0425, 4.1000, 'Analyst Classic', 1.2700, 'ng/mL', 'N/A', 98100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 1.3400, 'Analyst Classic', 1.2300, 0, 0.2180, 'N/A', 1.0100, 0.0000, 8245),
	(931575, 'C4-1.10', 'OCT', 'Unknown', '001-3324\\115.wiff', 1.0000, 46233, 'OCT-d8', 245951, 0.0000, 'pg/mL', 766.4700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 17, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:32:39', 'N/A', 16700.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 345, 2.3500, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.1760, '', 'N/A', 0.0432, 0.8210, 'Analyst Classic', 1.5800, 'ng/mL', 'N/A', 95000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 344, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.5520, 'Analyst Classic', 1.2700, 0, 0.1880, 'N/A', 1.0100, 0.0000, 8245),
	(931576, 'QC2-3', 'OCT', 'Quality Control', '001-3324\\116.wiff', 1.0000, 1223063, 'OCT-d8', 197110, 25000.0000, 'pg/mL', 25680.7200, 'pg/mL', 102.7200, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 18, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:38:11', 'N/A', 451000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 351, 2.3900, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 5.8800, '', 'N/A', 0.0421, -0.0908, 'Analyst Classic', 2.1300, 'ng/mL', 'N/A', 76600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 340, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0395, 1.6100, 'Analyst Classic', 1.1000, 0, 6.2050, 'N/A', 1.0100, 0.0002, 8245),
	(931577, 'C5-1.02', 'OCT', 'Unknown', '001-3324\\117.wiff', 1.0000, 385041, 'OCT-d8', 246676, 0.0000, 'pg/mL', 6451.3300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:11', '2019-11-02 07:52:11', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 19, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:43:44', 'N/A', 141000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 350, 2.3900, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 1.5200, '', 'N/A', 0.0418, 0.2410, 'Analyst Classic', 1.9300, 'ng/mL', 'N/A', 93100.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0417, 1.1900, 'Analyst Classic', 1.2500, 0, 1.5609, 'N/A', 1.0100, 0.0000, 8245),
	(931578, 'C5-1.04', 'OCT', 'Unknown', '001-3324\\118.wiff', 1.0000, 32978, 'OCT-d8', 236363, 0.0000, 'pg/mL', 565.8300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 20, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:49:17', 'N/A', 12300.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 342, 2.3300, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.1360, '', 'N/A', 0.0422, 4.7700, 'Analyst Classic', 1.1200, 'ng/mL', 'N/A', 89800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0406, 1.0300, 'Analyst Classic', 1.6400, 0, 0.1395, 'N/A', 1.0100, 0.0000, 8245),
	(931579, 'C5-1.06', 'OCT', 'Unknown', '001-3324\\119.wiff', 1.0000, 12803, 'OCT-d8', 261228, 0.0000, 'pg/mL', 191.0600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 21, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 02:54:49', 'N/A', 4800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 344, 2.3400, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.0480, '', 'N/A', 0.0403, 4.5200, 'Analyst Classic', 1.6700, 'ng/mL', 'N/A', 100000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 344, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0402, 1.0900, 'Analyst Classic', 1.3400, 0, 0.0490, 'N/A', 1.0100, 0.0000, 8245),
	(931580, 'C5-1.08', 'OCT', 'Unknown', '001-3324\\120.wiff', 1.0000, 8097, 'OCT-d8', 231712, 0.0000, 'pg/mL', 132.8100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 22, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:00:22', 'N/A', 2980.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 341, 2.3200, 'Base To Base', 'N/A', 0.1440, 'N/A', '510.300/120.200 Da', 'N/A', 0.0335, '', 'N/A', 0.0408, 8.3400, 'Analyst Classic', 1.3300, 'ng/mL', 'N/A', 88800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.7700, 'Analyst Classic', 1.9100, 0, 0.0349, 'N/A', 1.0100, 0.0000, 8245),
	(931581, 'C5-1.09', 'OCT', 'Unknown', '001-3324\\121.wiff', 1.0000, 30574, 'OCT-d8', 243520, 0.0000, 'pg/mL', 507.9900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 23, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:05:55', 'N/A', 11200.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 345, 2.3500, 'Base To Base', 'N/A', 0.1780, 'N/A', '510.300/120.200 Da', 'N/A', 0.1190, '', 'N/A', 0.0423, 3.1300, 'Analyst Classic', 1.5300, 'ng/mL', 'N/A', 93800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0397, 0.2620, 'Analyst Classic', 1.9200, 0, 0.1256, 'N/A', 1.0100, 0.0000, 8245),
	(931582, 'C5-1.10', 'OCT', 'Unknown', '001-3324\\122.wiff', 1.0000, 32338, 'OCT-d8', 240737, 0.0000, 'pg/mL', 544.3200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 24, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:11:27', 'N/A', 12000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, 'N/A', '510.300/120.200 Da', 'N/A', 0.1310, '', 'N/A', 0.0416, 1.8400, 'Analyst Classic', 1.0900, 'ng/mL', 'N/A', 91500.0000, 'N/A', 1.0000, 2.2200, 2.2500, 30.0000, 2.2300, 317, 2.1600, 343, 2.3400, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0412, 0.8150, 'Analyst Classic', 1.7200, 0, 0.1343, 'N/A', 1.0100, 0.0000, 8245),
	(931583, 'C6-1.02', 'OCT', 'Unknown', '001-3324\\123.wiff', 1.0000, 288166, 'OCT-d8', 249633, 0.0000, 'pg/mL', 4767.9100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 25, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:16:59', 'N/A', 105000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1910, 'N/A', '510.300/120.200 Da', 'N/A', 1.1100, '', 'N/A', 0.0424, 0.6370, 'Analyst Classic', 1.7800, 'ng/mL', 'N/A', 94800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.4730, 'Analyst Classic', 1.8800, 0, 1.1544, 'N/A', 1.0100, 0.0000, 8245),
	(931584, 'C6-1.04', 'OCT', 'Unknown', '001-3324\\124.wiff', 1.0000, 14929, 'OCT-d8', 217901, 0.0000, 'pg/mL', 271.8100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 26, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:22:32', 'N/A', 5460.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 344, 2.3400, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.0648, '', 'N/A', 0.0429, 7.2600, 'Analyst Classic', 1.4800, 'ng/mL', 'N/A', 84100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 313, 2.1300, 343, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0400, 0.8620, 'Analyst Classic', 1.1100, 0, 0.0685, 'N/A', 1.0100, 0.0000, 8245),
	(931585, 'C6-1.06', 'OCT', 'Unknown', '001-3324\\125.wiff', 1.0000, 7902, 'OCT-d8', 229507, 0.0000, 'pg/mL', 130.6700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 27, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:28:05', 'N/A', 3080.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2400, 318.0000, 2.1700, 340, 2.3200, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0350, '', 'N/A', 0.0405, -2.1600, 'Analyst Classic', 0.9600, 'ng/mL', 'N/A', 88000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.7230, 'Analyst Classic', 1.5000, 0, 0.0344, 'N/A', 1.0100, 0.0000, 8245),
	(931586, 'C6-1.08', 'OCT', 'Unknown', '001-3324\\126.wiff', 1.0000, 5325, 'OCT-d8', 244897, 0.0000, 'pg/mL', 78.1600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 28, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:33:36', 'N/A', 1870.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0201, '', 'N/A', 0.0435, 23.8000, 'Analyst Classic', 1.3700, 'ng/mL', 'N/A', 93000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 353, 2.4100, 'Base To Base', 'N/A', 0.2530, '514.300/120.200 Da', 'N/A', 'N/A', 0.0409, 0.2070, 'Analyst Classic', 2.4900, 0, 0.0217, 'N/A', 1.0100, 0.0000, 8245),
	(931587, 'QC1-3', 'OCT', 'Quality Control', '001-3324\\127.wiff', 1.0000, 8424, 'OCT-d8', 229632, 150.0000, 'pg/mL', 140.0200, 'pg/mL', 93.3500, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 29, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:39:08', 'N/A', 2960.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 342, 2.3300, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0334, '', 'N/A', 0.0443, -20.1000, 'Analyst Classic', 1.6000, 'ng/mL', 'N/A', 88800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.9200, 'Analyst Classic', 1.4800, 0, 0.0367, 'N/A', 1.0100, 0.0002, 8245),
	(931588, 'C6-1.09', 'OCT', 'Unknown', '001-3324\\128.wiff', 1.0000, 21572, 'OCT-d8', 210703, 0.0000, 'pg/mL', 412.0400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 30, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:44:40', 'N/A', 7870.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, 'N/A', '510.300/120.200 Da', 'N/A', 0.0980, '', 'N/A', 0.0422, 3.2400, 'Analyst Classic', 0.9670, 'ng/mL', 'N/A', 80300.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 1.6900, 'Analyst Classic', 1.2100, 0, 0.1024, 'N/A', 1.0100, 0.0000, 8245),
	(931589, 'C6-1.10', 'OCT', 'Unknown', '001-3324\\129.wiff', 1.0000, 18196, 'OCT-d8', 233449, 0.0000, 'pg/mL', 310.8500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 31, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:50:12', 'N/A', 6770.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 341, 2.3200, 'Base To Base', 'N/A', 0.1570, 'N/A', '510.300/120.200 Da', 'N/A', 0.0762, '', 'N/A', 0.0414, 6.1400, 'Analyst Classic', 1.0500, 'ng/mL', 'N/A', 88900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.9340, 'Analyst Classic', 1.5700, 0, 0.0779, 'N/A', 1.0100, 0.0000, 8245),
	(931590, 'D1-1.01', 'OCT', 'Unknown', '001-3324\\130.wiff', 1.0000, 351066, 'OCT-d8', 202772, 0.0000, 'pg/mL', 7156.9800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 32, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 03:55:44', 'N/A', 129000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1910, 'N/A', '510.300/120.200 Da', 'N/A', 1.6500, '', 'N/A', 0.0426, 0.3520, 'Analyst Classic', 1.7100, 'ng/mL', 'N/A', 77900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 1.4100, 'Analyst Classic', 1.3600, 0, 1.7313, 'N/A', 1.0100, 0.0000, 8245),
	(931591, 'D1-1.03', 'OCT', 'Unknown', '001-3324\\131.wiff', 1.0000, 93985, 'OCT-d8', 222928, 0.0000, 'pg/mL', 1733.7800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 33, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:01:17', 'N/A', 34600.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 344, 2.3400, 'Base To Base', 'N/A', 0.1780, 'N/A', '510.300/120.200 Da', 'N/A', 0.4070, '', 'N/A', 0.0418, 1.9700, 'Analyst Classic', 1.3800, 'ng/mL', 'N/A', 85200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 344, 2.3400, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0409, 0.7230, 'Analyst Classic', 1.3800, 0, 0.4216, 'N/A', 1.0100, 0.0000, 8245),
	(931592, 'D1-1.05', 'OCT', 'Unknown', '001-3324\\132.wiff', 1.0000, 20135, 'OCT-d8', 256610, 0.0000, 'pg/mL', 313.0100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 34, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:06:49', 'N/A', 7340.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 342, 2.3300, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.0749, '', 'N/A', 0.0425, 6.4900, 'Analyst Classic', 1.1600, 'ng/mL', 'N/A', 98000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 1.5100, 'Analyst Classic', 1.3200, 0, 0.0785, 'N/A', 1.0100, 0.0000, 8245),
	(931593, 'D1-1.07', 'OCT', 'Unknown', '001-3324\\133.wiff', 1.0000, 3481, 'OCT-d8', 237912, 0.0000, 'pg/mL', 48.7000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 35, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:12:22', 'N/A', 1350.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 339, 2.3100, 'Base To Base', 'N/A', 0.1160, 'N/A', '510.300/120.200 Da', 'N/A', 0.0146, '', 'N/A', 0.0411, 59.8000, 'Analyst Classic', 1.3000, 'ng/mL', 'N/A', 92900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 341, 2.3200, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0395, 1.2100, 'Analyst Classic', 1.3900, 0, 0.0146, 'N/A', 1.0100, 0.0000, 8245),
	(931594, 'D1-1.09', 'OCT', 'Unknown', '001-3324\\134.wiff', 1.0000, 41548, 'OCT-d8', 239552, 0.0000, 'pg/mL', 706.2800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 36, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:17:54', 'N/A', 15200.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 343, 2.3400, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.1660, '', 'N/A', 0.0423, 2.5700, 'Analyst Classic', 1.2400, 'ng/mL', 'N/A', 91500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 313, 2.1300, 342, 2.3300, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 1.0900, 'Analyst Classic', 1.1100, 0, 0.1734, 'N/A', 1.0100, 0.0000, 8245),
	(931595, 'D1-1.10', 'OCT', 'Unknown', '001-3324\\135.wiff', 1.0000, 32301, 'OCT-d8', 255093, 0.0000, 'pg/mL', 512.4200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 37, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:23:26', 'N/A', 11900.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 343, 2.3400, 'Base To Base', 'N/A', 0.1570, 'N/A', '510.300/120.200 Da', 'N/A', 0.1220, '', 'N/A', 0.0419, 2.4700, 'Analyst Classic', 1.5400, 'ng/mL', 'N/A', 97600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0400, 1.0600, 'Analyst Classic', 1.5500, 0, 0.1266, 'N/A', 1.0100, 0.0000, 8245),
	(931596, 'D2-1.01', 'OCT', 'Unknown', '001-3324\\136.wiff', 1.0000, 278943, 'OCT-d8', 234365, 0.0000, 'pg/mL', 4916.3500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 38, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:28:57', 'N/A', 103000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 348, 2.3700, 'Base To Base', 'N/A', 0.2050, 'N/A', '510.300/120.200 Da', 'N/A', 1.1300, '', 'N/A', 0.0430, 0.4310, 'Analyst Classic', 1.6100, 'ng/mL', 'N/A', 90800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0400, 0.8750, 'Analyst Classic', 1.6100, 0, 1.1902, 'N/A', 1.0100, 0.0000, 8245),
	(931597, 'D2-1.03', 'OCT', 'Unknown', '001-3324\\137.wiff', 1.0000, 66956, 'OCT-d8', 241058, 0.0000, 'pg/mL', 1138.2200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 39, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:34:29', 'N/A', 24700.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 343, 2.3400, 'Base To Base', 'N/A', 0.1570, 'N/A', '510.300/120.200 Da', 'N/A', 0.2670, '', 'N/A', 0.0420, 1.9000, 'Analyst Classic', 1.5500, 'ng/mL', 'N/A', 92700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.5380, 'Analyst Classic', 1.7200, 0, 0.2778, 'N/A', 1.0100, 0.0000, 8245),
	(931598, 'QC3-4', 'OCT', 'Quality Control', '001-3324\\138.wiff', 1.0000, 1734494, 'OCT-d8', 197628, 37500.0000, 'pg/mL', 36328.6800, 'pg/mL', 96.8800, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 40, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:40:00', 'N/A', 638000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 353, 2.4100, 'Base To Base', 'N/A', 0.2390, 'N/A', '510.300/120.200 Da', 'N/A', 8.4200, '', 'N/A', 0.0419, -0.0984, 'Analyst Classic', 2.1700, 'ng/mL', 'N/A', 75800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.2490, 'Analyst Classic', 1.7400, 0, 8.7765, 'N/A', 1.0100, 0.0002, 8245),
	(931599, 'D2-1.05', 'OCT', 'Unknown', '001-3324\\139.wiff', 1.0000, 7453, 'OCT-d8', 240953, 0.0000, 'pg/mL', 116.1900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 41, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:45:32', 'N/A', 2910.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 340, 2.3200, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0311, '', 'N/A', 0.0398, 12.4000, 'Analyst Classic', 1.1900, 'ng/mL', 'N/A', 93500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 346, 2.3600, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0397, 1.0800, 'Analyst Classic', 1.9100, 0, 0.0309, 'N/A', 1.0100, 0.0000, 8245),
	(931600, 'D2-1.07', 'OCT', 'Unknown', '001-3324\\140.wiff', 1.0000, 3638, 'OCT-d8', 253047, 0.0000, 'pg/mL', 47.6400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 42, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:51:03', 'N/A', 1320.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2400, 317.0000, 2.1600, 339, 2.3100, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0134, '', 'N/A', 0.0396, 11.2000, 'Analyst Classic', 0.8420, 'ng/mL', 'N/A', 98300.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0396, 0.6820, 'Analyst Classic', 1.5500, 0, 0.0144, 'N/A', 1.0100, 0.0000, 8245),
	(931601, 'D2-1.09', 'OCT', 'Unknown', '001-3324\\141.wiff', 1.0000, 2241, 'OCT-d8', 235274, 0.0000, 'pg/mL', 27.5500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 43, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 04:56:35', 'N/A', 858.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2400, 318.0000, 2.1700, 338, 2.3000, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0095, '', 'N/A', 0.0402, 14.7000, 'Analyst Classic', 0.8450, 'ng/mL', 'N/A', 90000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 342, 2.3300, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0408, 1.3300, 'Analyst Classic', 1.6000, 0, 0.0095, 'N/A', 1.0100, 0.0000, 8245),
	(931602, 'D2-1.10', 'OCT', 'Unknown', '001-3324\\142.wiff', 1.0000, 4224, 'OCT-d8', 254167, 0.0000, 'pg/mL', 56.9300, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 44, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:02:07', 'N/A', 1660.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 339, 2.3100, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0171, '', 'N/A', 0.0406, 32.5000, 'Analyst Classic', 1.0700, 'ng/mL', 'N/A', 97000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 348, 2.3700, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.3360, 'Analyst Classic', 1.9100, 0, 0.0166, 'N/A', 1.0100, 0.0000, 8245),
	(931603, 'D3-1.01', 'OCT', 'Unknown', '001-3324\\143.wiff', 1.0000, 378696, 'OCT-d8', 253956, 0.0000, 'pg/mL', 6162.5900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 45, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:07:39', 'N/A', 140000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 346, 2.3600, 'Base To Base', 'N/A', 0.1910, 'N/A', '510.300/120.200 Da', 'N/A', 1.4300, '', 'N/A', 0.0418, 0.8250, 'Analyst Classic', 1.5400, 'ng/mL', 'N/A', 98200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0402, 1.9100, 'Analyst Classic', 1.3400, 0, 1.4912, 'N/A', 1.0100, 0.0000, 8245),
	(931604, 'D3-1.03', 'OCT', 'Unknown', '001-3324\\144.wiff', 1.0000, 80810, 'OCT-d8', 256278, 0.0000, 'pg/mL', 1293.7500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 46, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:13:10', 'N/A', 30000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 344, 2.3400, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.3050, '', 'N/A', 0.0417, 1.0300, 'Analyst Classic', 1.4600, 'ng/mL', 'N/A', 98400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 346, 2.3600, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.6320, 'Analyst Classic', 1.7800, 0, 0.3153, 'N/A', 1.0100, 0.0000, 8245),
	(931605, 'D3-1.05', 'OCT', 'Unknown', '001-3324\\145.wiff', 1.0000, 6799, 'OCT-d8', 247488, 0.0000, 'pg/mL', 101.8700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 47, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:18:43', 'N/A', 2510.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 342, 2.3300, 'Base To Base', 'N/A', 0.1570, 'N/A', '510.300/120.200 Da', 'N/A', 0.0262, '', 'N/A', 0.0419, 0.7940, 'Analyst Classic', 1.2100, 'ng/mL', 'N/A', 95500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0398, 0.7930, 'Analyst Classic', 1.6300, 0, 0.0275, 'N/A', 1.0100, 0.0000, 8245),
	(931606, 'D3-1.07', 'OCT', 'Unknown', '001-3324\\146.wiff', 1.0000, 1803, 'OCT-d8', 188380, 0.0000, 'pg/mL', 27.7400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 48, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:24:15', 'N/A', 625.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2400, 318.0000, 2.1700, 337, 2.3000, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0086, '', 'N/A', 0.0480, 107.0000, 'Analyst Classic', 0.7950, 'ng/mL', 'N/A', 72400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 343, 2.3400, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.8250, 'Analyst Classic', 1.6700, 0, 0.0096, 'N/A', 1.0100, 0.0000, 8245),
	(931607, 'D3-1.09', 'OCT', 'Unknown', '001-3324\\147.wiff', 1.0000, 10564, 'OCT-d8', 228324, 0.0000, 'pg/mL', 179.6900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 49, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:29:47', 'N/A', 3920.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 341, 2.3200, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.0453, '', 'N/A', 0.0415, 4.7700, 'Analyst Classic', 0.9660, 'ng/mL', 'N/A', 86500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 1.0100, 'Analyst Classic', 1.3700, 0, 0.0463, 'N/A', 1.0100, 0.0000, 8245),
	(931608, 'D3-1.10', 'OCT', 'Unknown', '001-3324\\148.wiff', 1.0000, 7430, 'OCT-d8', 231049, 0.0000, 'pg/mL', 121.2700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 50, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:35:19', 'N/A', 2860.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0320, '', 'N/A', 0.0409, 13.2000, 'Analyst Classic', 1.2700, 'ng/mL', 'N/A', 89500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0398, 0.5620, 'Analyst Classic', 1.6600, 0, 0.0322, 'N/A', 1.0100, 0.0000, 8245),
	(931609, 'QC2-4', 'OCT', 'Quality Control', '001-3324\\149.wiff', 1.0000, 1446344, 'OCT-d8', 221591, 25000.0000, 'pg/mL', 27014.5500, 'pg/mL', 108.0600, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 51, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:40:51', 'N/A', 536000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 359, 2.4500, 'Base To Base', 'N/A', 0.2800, 'N/A', '510.300/120.200 Da', 'N/A', 6.2300, '', 'N/A', 0.0419, -0.1770, 'Analyst Classic', 2.6400, 'ng/mL', 'N/A', 86000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0395, 0.9740, 'Analyst Classic', 1.1700, 0, 6.5271, 'N/A', 1.0100, 0.0003, 8245),
	(931610, 'D4-1.02', 'OCT', 'Unknown', '001-3324\\150.wiff', 1.0000, 352940, 'OCT-d8', 264165, 0.0000, 'pg/mL', 5520.2700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 52, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:46:22', 'N/A', 129000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 347, 2.3600, 'Base To Base', 'N/A', 0.2050, 'N/A', '510.300/120.200 Da', 'N/A', 1.2800, '', 'N/A', 0.0423, 0.4850, 'Analyst Classic', 1.4800, 'ng/mL', 'N/A', 101000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0406, 1.0600, 'Analyst Classic', 1.4200, 0, 1.3361, 'N/A', 1.0100, 0.0000, 8245),
	(931611, 'D4-1.04', 'OCT', 'Unknown', '001-3324\\151.wiff', 1.0000, 26887, 'OCT-d8', 198068, 0.0000, 'pg/mL', 550.2000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 53, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:51:53', 'N/A', 10000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, 'N/A', '510.300/120.200 Da', 'N/A', 0.1300, '', 'N/A', 0.0420, 2.3500, 'Analyst Classic', 1.0100, 'ng/mL', 'N/A', 77200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0396, 0.3130, 'Analyst Classic', 1.5400, 0, 0.1357, 'N/A', 1.0100, 0.0000, 8245),
	(931612, 'D4-1.06', 'OCT', 'Unknown', '001-3324\\152.wiff', 1.0000, 9646, 'OCT-d8', 247331, 0.0000, 'pg/mL', 149.6000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 54, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 05:57:26', 'N/A', 3540.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 343, 2.3400, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.0370, '', 'N/A', 0.0418, 13.4000, 'Analyst Classic', 1.3900, 'ng/mL', 'N/A', 95700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 343, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0400, 1.0900, 'Analyst Classic', 1.2900, 0, 0.0390, 'N/A', 1.0100, 0.0000, 8245),
	(931613, 'D4-1.08', 'OCT', 'Unknown', '001-3324\\153.wiff', 1.0000, 7140, 'OCT-d8', 257368, 0.0000, 'pg/mL', 102.9800, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 55, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:02:57', 'N/A', 2620.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 340, 2.3200, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0268, '', 'N/A', 0.0428, 17.1000, 'Analyst Classic', 1.2300, 'ng/mL', 'N/A', 97800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 345, 2.3500, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0410, 0.6520, 'Analyst Classic', 1.4500, 0, 0.0277, 'N/A', 1.0100, 0.0000, 8245),
	(931614, 'D4-1.09', 'OCT', 'Unknown', '001-3324\\154.wiff', 1.0000, 35930, 'OCT-d8', 190973, 0.0000, 'pg/mL', 767.1500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 56, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:08:29', 'N/A', 13500.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 341, 2.3200, 'Base To Base', 'N/A', 0.1640, 'N/A', '510.300/120.200 Da', 'N/A', 0.1830, '', 'N/A', 0.0415, 1.1300, 'Analyst Classic', 0.9590, 'ng/mL', 'N/A', 73600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.6760, 'Analyst Classic', 1.6800, 0, 0.1881, 'N/A', 1.0100, 0.0000, 8245),
	(931615, 'D4-1.10', 'OCT', 'Unknown', '001-3324\\155.wiff', 1.0000, 46020, 'OCT-d8', 196621, 0.0000, 'pg/mL', 957.2600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:12', '2019-11-02 07:52:12', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 57, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:14:01', 'N/A', 16800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 316.0000, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1850, 'N/A', '510.300/120.200 Da', 'N/A', 0.2220, '', 'N/A', 0.0422, 2.2500, 'Analyst Classic', 1.0800, 'ng/mL', 'N/A', 76000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 342, 2.3300, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 0.7570, 'Analyst Classic', 1.2200, 0, 0.2341, 'N/A', 1.0100, 0.0000, 8245),
	(931616, 'D5-1.02', 'OCT', 'Unknown', '001-3324\\156.wiff', 1.0000, 292391, 'OCT-d8', 244727, 0.0000, 'pg/mL', 4935.2200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 58, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:19:34', 'N/A', 107000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1980, 'N/A', '510.300/120.200 Da', 'N/A', 1.1500, '', 'N/A', 0.0420, 0.8030, 'Analyst Classic', 1.6300, 'ng/mL', 'N/A', 92900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 345, 2.3500, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0406, 0.7880, 'Analyst Classic', 1.8900, 0, 1.1948, 'N/A', 1.0100, 0.0000, 8245),
	(931617, 'D5-1.04', 'OCT', 'Unknown', '001-3324\\157.wiff', 1.0000, 22665, 'OCT-d8', 216538, 0.0000, 'pg/mL', 421.5100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 59, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:25:06', 'N/A', 8210.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 342, 2.3300, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0989, '', 'N/A', 0.0437, 1.4700, 'Analyst Classic', 1.3400, 'ng/mL', 'N/A', 83000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 343, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.7370, 'Analyst Classic', 1.2400, 0, 0.1047, 'N/A', 1.0100, 0.0000, 8245),
	(931618, 'D5-1.06', 'OCT', 'Unknown', '001-3324\\158.wiff', 1.0000, 5451, 'OCT-d8', 253823, 0.0000, 'pg/mL', 77.0400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 60, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:30:39', 'N/A', 2010.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 340, 2.3200, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0207, '', 'N/A', 0.0416, -1.6800, 'Analyst Classic', 1.3700, 'ng/mL', 'N/A', 97000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 0.6860, 'Analyst Classic', 1.5600, 0, 0.0215, 'N/A', 1.0100, 0.0000, 8245),
	(931619, 'D5-1.08', 'OCT', 'Unknown', '001-3324\\159.wiff', 1.0000, 4017, 'OCT-d8', 237281, 0.0000, 'pg/mL', 58.2200, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 61, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:36:11', 'N/A', 1440.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 342, 2.3300, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.0158, '', 'N/A', 0.0430, 31.7000, 'Analyst Classic', 1.4000, 'ng/mL', 'N/A', 91000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0406, 1.1500, 'Analyst Classic', 1.4400, 0, 0.0169, 'N/A', 1.0100, 0.0000, 8245),
	(931620, 'QC1-4', 'OCT', 'Quality Control', '001-3324\\160.wiff', 1.0000, 6956, 'OCT-d8', 174894, 150.0000, 'pg/mL', 152.8100, 'pg/mL', 101.8800, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 62, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:41:43', 'N/A', 2460.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 323.0000, 2.2000, 342, 2.3300, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0361, '', 'N/A', 0.0447, -13.4000, 'Analyst Classic', 1.9000, 'ng/mL', 'N/A', 68100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 317, 2.1600, 341, 2.3200, 'Base To Base', 'N/A', 0.1640, '514.300/120.200 Da', 'N/A', 'N/A', 0.0396, 1.3800, 'Analyst Classic', 1.3800, 0, 0.0398, 'N/A', 1.0100, 0.0003, 8245),
	(931621, 'D5-1.09', 'OCT', 'Unknown', '001-3324\\161.wiff', 1.0000, 29515, 'OCT-d8', 246678, 0.0000, 'pg/mL', 483.5400, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 63, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:47:15', 'N/A', 10800.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 342, 2.3300, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.1140, '', 'N/A', 0.0428, 6.0600, 'Analyst Classic', 1.4500, 'ng/mL', 'N/A', 94700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 1.3500, 'Analyst Classic', 1.2200, 0, 0.1196, 'N/A', 1.0100, 0.0000, 8245),
	(931622, 'D5-1.10', 'OCT', 'Unknown', '001-3324\\162.wiff', 1.0000, 28800, 'OCT-d8', 237467, 0.0000, 'pg/mL', 490.2900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 64, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:52:46', 'N/A', 10400.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 343, 2.3400, 'Base To Base', 'N/A', 0.1570, 'N/A', '510.300/120.200 Da', 'N/A', 0.1140, '', 'N/A', 0.0434, 3.7400, 'Analyst Classic', 1.4900, 'ng/mL', 'N/A', 90700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1980, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 0.6750, 'Analyst Classic', 1.4600, 0, 0.1213, 'N/A', 1.0100, 0.0000, 8245),
	(931623, 'D6-1.02', 'OCT', 'Unknown', '001-3324\\163.wiff', 1.0000, 264333, 'OCT-d8', 223865, 0.0000, 'pg/mL', 4877.2700, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 65, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 06:58:18', 'N/A', 99300.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 345, 2.3500, 'Base To Base', 'N/A', 0.1780, 'N/A', '510.300/120.200 Da', 'N/A', 1.1400, '', 'N/A', 0.0417, -1.3800, 'Analyst Classic', 1.5200, 'ng/mL', 'N/A', 86900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 346, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0396, 0.2300, 'Analyst Classic', 1.4600, 0, 1.1808, 'N/A', 1.0100, 0.0000, 8245),
	(931624, 'D6-1.04', 'OCT', 'Unknown', '001-3324\\164.wiff', 1.0000, 17870, 'OCT-d8', 241469, 0.0000, 'pg/mL', 294.5500, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 66, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:03:50', 'N/A', 6630.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 342, 2.3300, 'Base To Base', 'N/A', 0.1710, 'N/A', '510.300/120.200 Da', 'N/A', 0.0715, '', 'N/A', 0.0412, -0.8830, 'Analyst Classic', 1.0600, 'ng/mL', 'N/A', 92800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 314, 2.1400, 342, 2.3300, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0404, 1.0200, 'Analyst Classic', 1.2000, 0, 0.0740, 'N/A', 1.0100, 0.0000, 8245),
	(931625, 'D6-1.06', 'OCT', 'Unknown', '001-3324\\165.wiff', 1.0000, 4601, 'OCT-d8', 255055, 0.0000, 'pg/mL', 62.8100, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 67, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:09:23', 'N/A', 1710.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 339, 2.3100, 'Base To Base', 'N/A', 0.1230, 'N/A', '510.300/120.200 Da', 'N/A', 0.0175, '', 'N/A', 0.0428, -2.8300, 'Analyst Classic', 1.1200, 'ng/mL', 'N/A', 97700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 350, 2.3900, 'Base To Base', 'N/A', 0.2390, '514.300/120.200 Da', 'N/A', 'N/A', 0.0402, 0.3590, 'Analyst Classic', 1.9300, 0, 0.0180, 'N/A', 1.0100, 0.0000, 8245),
	(931626, 'D6-1.08', 'OCT', 'Unknown', '001-3324\\166.wiff', 1.0000, 3657, 'OCT-d8', 220833, 0.0000, 'pg/mL', 56.6900, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 68, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:14:56', 'N/A', 1350.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 339, 2.3100, 'Base To Base', 'N/A', 0.1300, 'N/A', '510.300/120.200 Da', 'N/A', 0.0159, '', 'N/A', 0.0427, 63.0000, 'Analyst Classic', 1.0100, 'ng/mL', 'N/A', 84800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 313, 2.1300, 347, 2.3600, 'Base To Base', 'N/A', 0.2320, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.9000, 'Analyst Classic', 1.4300, 0, 0.0166, 'N/A', 1.0100, 0.0000, 8245),
	(931627, 'D6-1.09', 'OCT', 'Unknown', '001-3324\\167.wiff', 1.0000, 30180, 'OCT-d8', 259888, 0.0000, 'pg/mL', 468.9600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 69, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:20:27', 'N/A', 11000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 317.0000, 2.1600, 346, 2.3600, 'Base To Base', 'N/A', 0.1980, 'N/A', '510.300/120.200 Da', 'N/A', 0.1100, '', 'N/A', 0.0431, 3.1900, 'Analyst Classic', 1.3300, 'ng/mL', 'N/A', 100000.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 350, 2.3900, 'Base To Base', 'N/A', 0.2320, '514.300/120.200 Da', 'N/A', 'N/A', 0.0398, 0.5790, 'Analyst Classic', 2.0300, 0, 0.1161, 'N/A', 1.0100, 0.0000, 8245),
	(931628, 'D6-1.10', 'OCT', 'Unknown', '001-3324\\168.wiff', 1.0000, 52668, 'OCT-d8', 253863, 0.0000, 'pg/mL', 847.1600, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 70, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:25:59', 'N/A', 19300.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 320.0000, 2.1800, 342, 2.3300, 'Base To Base', 'N/A', 0.1500, 'N/A', '510.300/120.200 Da', 'N/A', 0.1990, '', 'N/A', 0.0434, 6.9500, 'Analyst Classic', 1.3100, 'ng/mL', 'N/A', 96600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0407, 0.7840, 'Analyst Classic', 1.4900, 0, 0.2075, 'N/A', 1.0100, 0.0000, 8245),
	(931629, 'HDQC20-1', 'OCT', 'Quality Control', '001-3324\\169.wiff', 20.0000, 1257717, 'OCT-d8', 252494, 500000.0000, 'pg/mL', 412268.3800, 'pg/mL', 82.4500, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 71, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:31:31', 'N/A', 461000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 361, 2.4600, 'Base To Base', 'N/A', 0.2870, 'N/A', '510.300/120.200 Da', 'N/A', 4.7200, '', 'N/A', 0.0420, -0.2200, 'Analyst Classic', 2.8000, 'ng/mL', 'N/A', 97800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 317, 2.1600, 348, 2.3700, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0399, 0.4040, 'Analyst Classic', 1.8900, 0, 4.9812, 'N/A', 1.0100, 0.0002, 8245),
	(931630, 'HDQC20-2', 'OCT', 'Quality Control', '001-3324\\170.wiff', 20.0000, 1526033, 'OCT-d8', 250932, 500000.0000, 'pg/mL', 503386.7400, 'pg/mL', 100.6800, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 72, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:37:03', 'N/A', 560000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 354, 2.4100, 'Base To Base', 'N/A', 0.2390, 'N/A', '510.300/120.200 Da', 'N/A', 5.7100, '', 'N/A', 0.0428, 0.0000, 'Analyst Classic', 2.3200, 'ng/mL', 'N/A', 98100.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 351, 2.3900, 'Base To Base', 'N/A', 0.2460, '514.300/120.200 Da', 'N/A', 'N/A', 0.0394, -0.0309, 'Analyst Classic', 1.9500, 0, 6.0815, 'N/A', 1.0100, 0.0002, 8245),
	(931631, 'HDQC20-3', 'OCT', 'Quality Control', '001-3324\\171.wiff', 20.0000, 1541859, 'OCT-d8', 243887, 500000.0000, 'pg/mL', 523306.9200, 'pg/mL', 104.6600, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 73, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:42:35', 'N/A', 566000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 355, 2.4200, 'Base To Base', 'N/A', 0.2530, 'N/A', '510.300/120.200 Da', 'N/A', 5.9800, '', 'N/A', 0.0422, -0.1180, 'Analyst Classic', 2.3000, 'ng/mL', 'N/A', 94600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0397, 1.1100, 'Analyst Classic', 1.1900, 0, 6.3220, 'N/A', 1.0100, 0.0003, 8245),
	(931632, 'BLK-2', 'OCT', 'Blank', '001-3324\\172.wiff', 1.0000, 742, 'OCT-d8', 92, 0.0000, 'pg/mL', 0.0000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 74, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:48:07', 'N/A', 302.0000, 'N/A', 2.2700, 2.2600, 30.0000, 2.2600, 325.0000, 2.2100, 338, 2.3000, 'Base To Base', 'N/A', 0.0888, 'N/A', '510.300/120.200 Da', 'N/A', 3.5200, '', 'N/A', 0.0365, 310.0000, 'Analyst Classic', 0.6630, 'ng/mL', 'N/A', 85.8000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 324, 2.2100, 330, 2.2500, 'Base To Base', 'N/A', 0.0410, '514.300/120.200 Da', 'N/A', 'N/A', 0.0172, 569.0000, 'Analyst Classic', 0.6250, 0, 8.0458, 'N/A', 1.0200, 0.0000, 8245),
	(931633, 'ZS-2', 'OCT', 'Blank', '001-3324\\173.wiff', 1.0000, 923, 'OCT-d8', 239813, 0.0000, 'pg/mL', 0.0000, 'pg/mL', 0.0000, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 75, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:53:39', 'N/A', 318.0000, 'N/A', 2.2700, 2.2600, 30.0000, 2.2700, 325.0000, 2.2100, 341, 2.3200, 'Base To Base', 'N/A', 0.1090, 'N/A', '510.300/120.200 Da', 'N/A', 0.0034, '', 'N/A', 0.0472, 18.9000, 'Analyst Classic', 0.9540, 'ng/mL', 'N/A', 93200.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 345, 2.3500, 'Base To Base', 'N/A', 0.2050, '514.300/120.200 Da', 'N/A', 'N/A', 0.0397, 0.6480, 'Analyst Classic', 1.5000, 0, 0.0038, 'N/A', 1.0200, 0.0000, 8245),
	(931634, 'CS1-2', 'OCT', 'Standard', '001-3324\\174.wiff', 1.0000, 3136, 'OCT-d8', 216359, 50.0000, 'pg/mL', 48.1300, 'pg/mL', 96.2600, 0, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 76, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 07:59:10', 'N/A', 995.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2600, 323.0000, 2.2000, 341, 2.3200, 'Base To Base', 'N/A', 0.1230, 'N/A', '510.300/120.200 Da', 'N/A', 0.0119, '', 'N/A', 0.0514, -43.7000, 'Analyst Classic', 1.7900, 'ng/mL', 'N/A', 83600.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 343, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.8670, 'Analyst Classic', 1.3000, 0, 0.0145, 'N/A', 1.0100, 0.0003, 8245),
	(931635, 'CS2-2', 'OCT', 'Standard', '001-3324\\175.wiff', 1.0000, 5969, 'OCT-d8', 212668, 100.0000, 'pg/mL', 104.3300, 'pg/mL', 104.3300, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 77, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:04:41', 'N/A', 1960.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 322.0000, 2.1900, 342, 2.3300, 'Base To Base', 'N/A', 0.1370, 'N/A', '510.300/120.200 Da', 'N/A', 0.0240, '', 'N/A', 0.0477, -44.4000, 'Analyst Classic', 1.6300, 'ng/mL', 'N/A', 81500.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 344, 2.3400, 'Base To Base', 'N/A', 0.1910, '514.300/120.200 Da', 'N/A', 'N/A', 0.0402, 0.6260, 'Analyst Classic', 1.5700, 0, 0.0281, 'N/A', 1.0100, 0.0003, 8245),
	(931636, 'CS3-2', 'OCT', 'Standard', '001-3324\\176.wiff', 1.0000, 52293, 'OCT-d8', 223092, 1000.0000, 'pg/mL', 958.6900, 'pg/mL', 95.8700, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 78, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:10:13', 'N/A', 19400.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 321.0000, 2.1900, 342, 2.3300, 'Base To Base', 'N/A', 0.1430, 'N/A', '510.300/120.200 Da', 'N/A', 0.2260, '', 'N/A', 0.0417, -4.2500, 'Analyst Classic', 1.6200, 'ng/mL', 'N/A', 85900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2190, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 0.2400, 'Analyst Classic', 1.7500, 0, 0.2344, 'N/A', 1.0100, 0.0002, 8245),
	(931637, 'CS4-2', 'OCT', 'Standard', '001-3324\\177.wiff', 1.0000, 500669, 'OCT-d8', 204651, 10000.0000, 'pg/mL', 10118.0000, 'pg/mL', 101.1800, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 79, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:15:43', 'N/A', 185000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 347, 2.3600, 'Base To Base', 'N/A', 0.1910, 'N/A', '510.300/120.200 Da', 'N/A', 2.3500, '', 'N/A', 0.0421, -0.0026, 'Analyst Classic', 1.7300, 'ng/mL', 'N/A', 78800.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1780, '514.300/120.200 Da', 'N/A', 'N/A', 0.0400, 1.1900, 'Analyst Classic', 1.1700, 0, 2.4464, 'N/A', 1.0100, 0.0002, 8245),
	(931638, 'CS5-2', 'OCT', 'Standard', '001-3324\\178.wiff', 1.0000, 1055400, 'OCT-d8', 211062, 20000.0000, 'pg/mL', 20693.0800, 'pg/mL', 103.4700, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 80, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:21:15', 'N/A', 387000.0000, 'N/A', 2.2400, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 351, 2.3900, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 4.7800, '', 'N/A', 0.0427, -0.1700, 'Analyst Classic', 2.0900, 'ng/mL', 'N/A', 80900.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0401, 0.6950, 'Analyst Classic', 1.2500, 0, 5.0004, 'N/A', 1.0100, 0.0003, 8245),
	(931639, 'CS6-2', 'OCT', 'Standard', '001-3324\\179.wiff', 1.0000, 1256816, 'OCT-d8', 164137, 30000.0000, 'pg/mL', 31693.5700, 'pg/mL', 105.6500, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 81, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:26:47', 'N/A', 457000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 350, 2.3900, 'Base To Base', 'N/A', 0.2190, 'N/A', '510.300/120.200 Da', 'N/A', 7.2100, '', 'N/A', 0.0431, 0.0475, 'Analyst Classic', 1.7700, 'ng/mL', 'N/A', 63400.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 315, 2.1500, 342, 2.3300, 'Base To Base', 'N/A', 0.1850, '514.300/120.200 Da', 'N/A', 'N/A', 0.0403, 1.0800, 'Analyst Classic', 1.2100, 0, 7.6571, 'N/A', 1.0100, 0.0003, 8245),
	(931640, 'CS7-2', 'OCT', 'Standard', '001-3324\\180.wiff', 1.0000, 2163075, 'OCT-d8', 228733, 40000.0000, 'pg/mL', 39145.3400, 'pg/mL', 97.8600, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 82, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:32:19', 'N/A', 794000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 319.0000, 2.1700, 353, 2.4100, 'Base To Base', 'N/A', 0.2320, 'N/A', '510.300/120.200 Da', 'N/A', 8.9500, '', 'N/A', 0.0420, 0.0155, 'Analyst Classic', 2.1400, 'ng/mL', 'N/A', 88700.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2400, 316, 2.1500, 341, 2.3200, 'Base To Base', 'N/A', 0.1710, '514.300/120.200 Da', 'N/A', 'N/A', 0.0405, 1.5300, 'Analyst Classic', 1.1900, 0, 9.4568, 'N/A', 1.0100, 0.0002, 8245),
	(931641, 'CS8-2', 'OCT', 'Standard', '001-3324\\181.wiff', 1.0000, 2942753, 'OCT-d8', 237552, 50000.0000, 'pg/mL', 51281.6400, 'pg/mL', 102.5600, 1, 1, 1, NULL, NULL, '2019-11-02 07:52:13', '2019-11-02 07:52:13', 0, '', 0, 'MS13-OCT-00_LC01.dam', 'Sample Manager w/ SO', 1, 83, 'ANSI-96well2mL', 5, 0.0000, '', '', 'pg/mL', '2019-10-22 08:37:52', 'N/A', 1080000.0000, 'N/A', 2.2500, 2.2600, 30.0000, 2.2500, 318.0000, 2.1700, 360, 2.4500, 'Base To Base', 'N/A', 0.2870, 'N/A', '510.300/120.200 Da', 'N/A', 11.7000, '', 'N/A', 0.0427, -0.0956, 'Analyst Classic', 2.6400, 'ng/mL', 'N/A', 92300.0000, 'N/A', 1.0000, 2.2300, 2.2500, 30.0000, 2.2300, 316, 2.1500, 347, 2.3600, 'Base To Base', 'N/A', 0.2120, '514.300/120.200 Da', 'N/A', 'N/A', 0.0398, 0.9340, 'Analyst Classic', 1.7600, 0, 12.3878, 'N/A', 1.0100, 0.0002, 8245);
/*!40000 ALTER TABLE `alae_sample_batch` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_study
CREATE TABLE IF NOT EXISTS `alae_study` (
  `pk_study` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `approved_at` timestamp NULL DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `observation` text COLLATE utf8_bin,
  `close_flag` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `approve` tinyint(1) NOT NULL DEFAULT '0',
  `duplicate` tinyint(1) NOT NULL DEFAULT '0',
  `fk_user` bigint(20) unsigned NOT NULL,
  `fk_user_approve` bigint(20) unsigned DEFAULT NULL,
  `fk_user_close` bigint(20) unsigned DEFAULT NULL,
  `fk_dilution_tree` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`pk_study`),
  KEY `fk_user` (`fk_user`),
  KEY `fk_user_approve` (`fk_user_approve`),
  KEY `fk_user_close` (`fk_user_close`),
  CONSTRAINT `alae_study_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `alae_study_ibfk_2` FOREIGN KEY (`fk_user_approve`) REFERENCES `alae_user` (`pk_user`),
  CONSTRAINT `alae_study_ibfk_3` FOREIGN KEY (`fk_user_close`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_study: ~1 rows (aproximadamente)
DELETE FROM `alae_study`;
/*!40000 ALTER TABLE `alae_study` DISABLE KEYS */;
INSERT INTO `alae_study` (`pk_study`, `code`, `created_at`, `updated_at`, `approved_at`, `description`, `observation`, `close_flag`, `status`, `approve`, `duplicate`, `fk_user`, `fk_user_approve`, `fk_user_close`, `fk_dilution_tree`) VALUES
	(348, '19ANE-3324', '2019-10-28 00:00:00', '2019-10-28 06:52:32', '2019-10-28 07:07:03', 'TEST', 'TEST', 0, 1, 1, 0, 15, 15, NULL, 1);
/*!40000 ALTER TABLE `alae_study` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_unit
CREATE TABLE IF NOT EXISTS `alae_unit` (
  `pk_unit` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`pk_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_unit: ~6 rows (aproximadamente)
DELETE FROM `alae_unit`;
/*!40000 ALTER TABLE `alae_unit` DISABLE KEYS */;
INSERT INTO `alae_unit` (`pk_unit`, `name`) VALUES
	(1, 'ng/mL'),
	(2, 'pg/mL'),
	(3, 'µg/mL'),
	(4, 'fg/mL'),
	(5, 'mg/mL'),
	(6, 'g/mL');
/*!40000 ALTER TABLE `alae_unit` ENABLE KEYS */;

-- Volcando estructura para tabla alae.alae_user
CREATE TABLE IF NOT EXISTS `alae_user` (
  `pk_user` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(25) COLLATE utf8_bin NOT NULL,
  `email` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(50) COLLATE utf8_bin NOT NULL,
  `active_code` varchar(50) COLLATE utf8_bin NOT NULL,
  `verification` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `active_flag` tinyint(1) NOT NULL DEFAULT '0',
  `fk_profile` int(11) DEFAULT NULL,
  PRIMARY KEY (`pk_user`),
  KEY `fk_profile` (`fk_profile`),
  CONSTRAINT `alae_user_ibfk_1` FOREIGN KEY (`fk_profile`) REFERENCES `alae_profile` (`pk_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla alae.alae_user: ~43 rows (aproximadamente)
DELETE FROM `alae_user`;
/*!40000 ALTER TABLE `alae_user` DISABLE KEYS */;
INSERT INTO `alae_user` (`pk_user`, `name`, `username`, `email`, `password`, `active_code`, `verification`, `active_flag`, `fk_profile`) VALUES
	(1, 'ALAE System', 'alae_system', 'alae@cilantroit.com', 'c360723e2f01ccc2a7bd08176ac62d14', '1', NULL, 0, 6),
	(2, 'Jordi Ortuño', 'jortunoad', 'jortuno@anapharmeurope.com', 'bdb35069966dd1b311f36b2a00b3b9f0', 'kyF9fcId', 'rF8nNgE7', 1, 5),
	(4, 'Raquel Asensio', 'rasensio', 'rasensio@anapharmeurope.com', '75b09862a29b02e0c07343c9577c903d', 'T0aifyD7', 'hJyVXoE4', 1, 3),
	(5, 'C. Jiménez', 'cjimenez', 'cjimenez@anapharmeurope.com', '24a3b22b84f95ebdd0275657ca4a64db', 'HFVN1X5L', 'QkoeR1rl', 1, 3),
	(6, 'Cintia Jiménez', 'cjimenezad', 'cjimenezad@anapharmeurope.com', '59280375e1bcc1a7dea73e8b2eefe5f4', 'YwsgDeab', 'Qu4ytqIZ', 1, 5),
	(7, 'Mireia Viñas', 'mvinas', 'mvinas@anapharmeurope.com', 'd42a2ee74af338083dbce54c7b553a6b', 'TlbU16Iq', NULL, 1, 2),
	(8, 'Mireia Martínez Sus', 'mmartinezsus', 'mmartinezsus@anapharmeurope.com', 'd2056d6e22eb65d3416c13214d71fa16', 'QOgIL0ql', NULL, 1, 1),
	(9, 'Mireia Martínez', 'mmartinez', 'mmartinez@anapharmeurope.com', 'a3bb4b555ade5bd680cf4d4b02dbef36', '8k7INHW8', 'S3O8RX7m', 1, 3),
	(10, 'Araceli Castillo AD', 'acastilload', 'acastilload@anapharmeurope.com', '09a8f05d30c719059169a425907c78e5', 'DBhzi28c', 'hVLFf0UM', 1, 5),
	(11, 'Araceli Castillo', 'acastillo', 'acastillo@anapharmeurope.com', '09a8f05d30c719059169a425907c78e5', 'MlrW3B0H', '88vAjow3', 1, 3),
	(12, 'Natalia Caparrós', 'ncaparros', 'ncaparros@anapharmeurope.com', 'e7025efba509bd14be941d54980c0fc5', '9BwTzx8e', 'oGvRaLX2', 1, 4),
	(13, 'Javier Leonís', 'jleonis', 'jleonis@anapharmeurope.com', '9319d72ec163be6fa8afea0c6d0dfcff', 'vrAYGtPe', '691jqJ4p', 1, 3),
	(14, 'V. Juanilla', 'vjuanilla', 'vjuanilla@anapharmeurope.com', '3696b93fa8ac1e8514f62f5a67a8fd2d', 'guwqILNi', NULL, 1, 2),
	(15, 'toni jurado Test', 'toni', 'tonijurado@cilantroit.com', 'c72d8d3aaac76423d12dcf28962b6269', 'ZFlX78Cm', 'dxSaGrg8', 1, 5),
	(16, 'Keren Cerdán', 'kcerdan', 'kcerdan@anapharmeurope.com', '6b137db6d32fe809c32e20979238e812', 'qyjWw8rA', NULL, 1, 4),
	(17, 'Sabina Gelardo ', 'sgelardo', 'sgelardo@anapharmeurope.com', 'b4b7dea3c342ca47b5593af4f3b9564b', 'hIx2tplv', NULL, 1, 4),
	(18, 'Ernest Diaz', 'ediaz', 'ediaz@anapharmeurope.com', 'ced0a028d3180859f5396de2c52cb5ae', 'VisW6B8R', NULL, 0, 7),
	(19, 'Cristina García', 'cgarcia', 'cgarcia@anapharmeurope.com', 'd7b1fd0baf6ff7628ee274d729107bff', 'P9Ah8RMw', '8VyAvUFI', 1, 3),
	(20, 'Beatriz Morata', 'bmorata', 'bmorata@anapharmeurope.com', 'fac72bc257c2d911f2991cab3c76f42f', 'gC04QjwV', NULL, 0, 7),
	(21, NULL, 'aartime', 'aartime@anapharmeurope.com', '6fe1695221719487554ce73c13d2c614', 'T73zwZf9', NULL, 0, 7),
	(22, 'Mercedes Yritia', 'myritia', 'myritia@anapharmeurope.com', '3f536bb858522f99ceeb304a1ae8f385', 'IUd4AnsK', 'eJ0SnHsD', 1, 3),
	(23, 'Celia', 'CSANCHEZ', 'csanchez@anapharmeurope.com', 'd4e2f8f4d4627f823e78f0b821514c81', 'pnWLqa9C', NULL, 1, 2),
	(24, 'Laia Pina ', 'lpina', 'lpina@anapharmeurope.com', '6017f18bbdd1b96a80da04feb4312603', '2E9gtHMW', NULL, 1, 4),
	(25, 'Marta Rios', 'mrios', 'mrios@anapharmeurope.com', '6c2bc5a785b46e2b63be95c40e186fbd', 'lx75a4YE', NULL, 0, 7),
	(26, 'Elsie Vico', 'evico', 'evico@anapharmeurope.com', '8aeba9d1507f35c9915500978d251e5b', 'xyB8Tuft', NULL, 0, 7),
	(27, 'Silvia Berruezo', 'sberruezo', 'sberruezo@anapharmeurope.com', '4e9a781cb6d84fb92a7f8d7d50d185f2', 'Kyn2s1hb', '87OEJqkF', 1, 3),
	(28, 'Alba Porras Guerra', 'aporrassus', 'aporras@anapharmeurope.com', '1de0f7f03ca61a878215cd2c7b40eeca', 'bep7ZiQK', NULL, 1, 1),
	(29, 'Anna Domenech', 'adomenechsus', 'adomenechsus@anapharmeurope.com', '579add0a0ebab5f516636bed307a52e3', 'DVpI5ZXU', NULL, 1, 1),
	(30, 'Claudia Maria Olteanu', 'colteanu', 'colteanu@anapharmeurope.com', '76df7264bfa52ad3bd5bd9157f9ea23e', 'fNDWnMxE', NULL, 1, 2),
	(31, 'Meritxell Mallen', 'mmallen', 'mmallen@anapharmeurope.com', 'f0f1ba5bbb46912880b048baf66fad65', 'PmpnFAuM', NULL, 1, 2),
	(32, 'Alexandra Muñoz', 'amunoz', 'amunoz@anapharmeurope.com', 'bf61716588814d1b55570340672a0852', 'AHTyi9KY', NULL, 1, 4),
	(33, 'Xavier Esparza', 'xesparza', 'xesparza@anapharmeurope.com', '251b2321ab4704c8362dbb57c4d84310', 'xMbZ7np9', '7GC8ZYLi', 1, 3),
	(34, 'Cristina Ruiz ', 'cruiz', 'cruiz@anapharmeurope.com', 'c5db26d139d17bf93d0eacee9179296c', '4uxUleCh', NULL, 0, 7),
	(35, 'Anna Busquet', 'Anna Busquet', 'abusquet@anapharmeurope.com', '8e4bb49db577e968b6def6425ac440ca', 'YTeC9K7G', NULL, 1, 2),
	(36, 'Aida Márquez', 'amarquez', 'amarquez@anapharmeurope.com', 'bc2016ab8b5f7f069d291e63485fe093', 'hgJfUZ7I', NULL, 1, 4),
	(37, 'Elena Lorenzo', 'elorenzo', 'elorenzo@anapharmeurope.com', '2fdf1f9c78dcef2b57624d972fbdec47', 'KE4UhLTC', NULL, 1, 4),
	(38, 'Carla Mura', 'cmura', 'cmura@anapharmeurope.com', '88e0ab91fa7b2e3babd1f0f7383cf5bf', 'cgSkZVKN', 'QRJo86kZ', 1, 3),
	(39, 'Maria Guiral', 'mguiral', 'mguiral@anapharmeurope.com', '19645436078ea249f12b440f7b15e06f', 'jm0MLauJ', NULL, 1, 2),
	(40, 'Arantxa Chicharro', 'achicharro', 'achicharro@anapharmeurope.com', '0b3a6d6c6173cd3995a75fb4e512c7c1', 'sUFqv5kg', NULL, 1, 2),
	(41, 'Angélica Asensio Calvo', 'aasensio', 'aasensio@anapharmeurope.com', 'dde4393cfee6018c18f3474f5f035fd9', '9cq1jnGU', NULL, 1, 2),
	(42, 'Maria Gonzalez', 'mgonzalez', 'mgonzalez@anapharmeurope.com', 'e7229dff2b3320002b70724a14371017', 'xS7b9j3T', NULL, 1, 2),
	(46, 'Silvia Medina', 'smedina', 'smedina@anapharmbiotech.com', '802d475ce9a9920ceb73077e92b549a0', 'z8tCPOWy', 'c9V3KHyn', 1, 3),
	(47, 'Anna Domenech', 'adomenech', 'adomenech@anapharmeurope.com', '579add0a0ebab5f516636bed307a52e3', 'MucpHjrI', NULL, 1, 3);
/*!40000 ALTER TABLE `alae_user` ENABLE KEYS */;

-- Volcando estructura para procedimiento alae.proc_alae_sample_errors
DELIMITER //
CREATE DEFINER=`alae`@`localhost` PROCEDURE `proc_alae_sample_errors`(IN `batch_num` INT)
BEGIN





/*


 select * from qry_alae_sample_errors where `pk_batch`=batch_num 


   and (`sample_type`='Unknown' or left(`rule`,3)='V12' ) and is_used =1


   group by sample_name;


*/





 select * from qry_alae_sample_errors where `pk_batch`=batch_num 


   and `sample_type`='Unknown' and code_error IS NOT NULL


   group by sample_name, code_error;


   


END//
DELIMITER ;

-- Volcando estructura para vista alae.qry_alae_control_v9
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `qry_alae_control_v9` (
	`pk_sample_batch` BIGINT(20) UNSIGNED NOT NULL,
	`sample_name` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`accuracy` DECIMAL(19,4) NULL,
	`use_record` INT(11) NULL,
	`tipo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`ok_accuracy` INT(1) NOT NULL,
	`use_record_ok` INT(1) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista alae.qry_alae_sample_batch
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `qry_alae_sample_batch` (
	`pk_study` BIGINT(20) UNSIGNED NOT NULL,
	`code` VARCHAR(20) NULL COLLATE 'utf8_bin',
	`pk_analyte` BIGINT(20) UNSIGNED NOT NULL,
	`name` VARCHAR(30) NULL COLLATE 'utf8_bin',
	`pk_batch` BIGINT(20) UNSIGNED NOT NULL,
	`batch` VARCHAR(100) NULL COLLATE 'utf8_bin',
	`created_at` TIMESTAMP NOT NULL,
	`valid_flag` TINYINT(1) NULL,
	`user_name` VARCHAR(25) NULL COLLATE 'utf8_bin',
	`validation_date` TIMESTAMP NULL,
	`intercept` FLOAT NULL,
	`slope` FLOAT NULL,
	`correlation_coefficient` DECIMAL(19,4) NOT NULL,
	`code_error` VARCHAR(10) NULL COLLATE 'utf8_bin',
	`sample_name` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`analyte_peak_name` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`sample_type` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`file_name` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`analyte_peak_area` INT(11) NOT NULL,
	`is_peak_area` INT(11) NOT NULL,
	`area_ratio` DECIMAL(19,4) NULL,
	`analyte_concentration` DECIMAL(19,4) NULL,
	`calculated_concentration` DECIMAL(19,4) NULL,
	`dilution_factor` DECIMAL(19,4) NOT NULL,
	`accuracy` DECIMAL(19,4) NULL,
	`use_record` INT(11) NULL,
	`acquisition_date` TIMESTAMP NOT NULL,
	`analyte_integration_type` VARCHAR(50) NULL COLLATE 'utf8_bin',
	`is_integration_type` VARCHAR(50) NULL COLLATE 'utf8_bin',
	`record_modified` INT(11) NULL,
	`fk_parameter` INT(11) NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla alae.qry_alae_sample_errors
CREATE TABLE IF NOT EXISTS `qry_alae_sample_errors` (
  `serial` int(11) DEFAULT NULL,
  `pk_batch` bigint(20) unsigned NOT NULL,
  `analyte_peak_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sample_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sample_type` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `fk_parameter` int(11) NOT NULL,
  `rule` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `verification` text CHARACTER SET utf8 COLLATE utf8_bin,
  `min_value` int(11) NOT NULL,
  `max_value` int(11) NOT NULL,
  `code_error` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `message_error` text CHARACTER SET utf8 COLLATE utf8_bin,
  `is_used` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla alae.qry_alae_sample_errors: 0 rows
DELETE FROM `qry_alae_sample_errors`;
/*!40000 ALTER TABLE `qry_alae_sample_errors` DISABLE KEYS */;
/*!40000 ALTER TABLE `qry_alae_sample_errors` ENABLE KEYS */;

-- Volcando estructura para disparador alae.analitos_AFTERDelete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `analitos_AFTERDelete` AFTER DELETE ON `alae_analyte` FOR EACH ROW DELETE FROM validaciones.alae_analyte 
	WHERE validaciones.alae_analyte.pk_analyte = old.pk_analyte//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae.analitos_AfterInsert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `analitos_AfterInsert` AFTER INSERT ON `alae_analyte` FOR EACH ROW INSERT INTO validaciones.alae_analyte /* (idUsuario, nomUsuario)  */
	VALUES (new.pk_analyte, new.NAME, new.shortening, new.updated_at, new.STATUS, new.fk_user)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae.analitos_AfterUpdate
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `analitos_AfterUpdate` AFTER UPDATE ON `alae_analyte` FOR EACH ROW UPDATE validaciones.alae_analyte 
		SET /*bbdddestino.tblusuarios.idUsuario = new.idUsuario,*/
		validaciones.alae_analyte.pk_analyte = new.pk_analyte,
		validaciones.alae_analyte.NAME = new.NAME,
		validaciones.alae_analyte.shortening = new.shortening,
		validaciones.alae_analyte.updated_at = new.updated_at,
		validaciones.alae_analyte.`status` = new.`status`,
		validaciones.alae_analyte.fk_user = new.fk_user
		
		WHERE validaciones.alae_analyte.pk_analyte = new.pk_analyte//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae.user_AFTERDelete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `user_AFTERDelete` AFTER DELETE ON `alae_user` FOR EACH ROW DELETE FROM validaciones.alae_user
	WHERE validaciones.alae_user.pk_user = old.pk_user//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae.user_AfterInsert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `user_AfterInsert` AFTER INSERT ON `alae_user` FOR EACH ROW INSERT INTO validaciones.alae_user /* (idUsuario, nomUsuario)  */
	VALUES (
		new.pk_user, 
		new.NAME, 
		new.username, 
		new.email, 
		new.password, 
		new.active_code,
		new.verification,
		new.active_flag,
		new.fk_profile
		)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae.user_AfterUpdate
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `user_AfterUpdate` AFTER UPDATE ON `alae_user` FOR EACH ROW UPDATE validaciones.alae_user 
		SET /*bbdddestino.tblusuarios.idUsuario = new.idUsuario,*/
		validaciones.alae_user.pk_user = new.pk_user,
		validaciones.alae_user.NAME = new.NAME,
		validaciones.alae_user.username = new.username,
		validaciones.alae_user.email = new.email,
		validaciones.alae_user.password = new.password,
		validaciones.alae_user.active_code = new.active_code,
		validaciones.alae_user.verification = new.verification,
		validaciones.alae_user.active_flag = new.active_flag,
		validaciones.alae_user.fk_profile = new.fk_profile
	
		WHERE validaciones.alae_user.pk_user = new.pk_user//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para vista alae.qry_alae_control_v9
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_control_v9`;
CREATE ALGORITHM=UNDEFINED DEFINER=`alae`@`localhost` SQL SECURITY DEFINER VIEW `qry_alae_control_v9` AS select `alae_sample_batch`.`pk_sample_batch` AS `pk_sample_batch`,`alae_sample_batch`.`sample_name` AS `sample_name`,`alae_sample_batch`.`accuracy` AS `accuracy`,`alae_sample_batch`.`use_record` AS `use_record`,if((right(`alae_sample_batch`.`sample_name`,1) = '*'),'R','C') AS `tipo`,if(((`alae_sample_batch`.`accuracy` >= 85) and (`alae_sample_batch`.`accuracy` <= 115)),1,0) AS `ok_accuracy`,if(((right(`alae_sample_batch`.`sample_name`,1) <> '*') and (`alae_sample_batch`.`use_record` = 1)),1,if(((right(`alae_sample_batch`.`sample_name`,1) = '*') and (`alae_sample_batch`.`use_record` = 0)),1,0)) AS `use_record_ok` from `alae_sample_batch` where (`alae_sample_batch`.`sample_type` = 'Quality Control') ;

-- Volcando estructura para vista alae.qry_alae_sample_batch
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_sample_batch`;
CREATE ALGORITHM=UNDEFINED DEFINER=`alae`@`localhost` SQL SECURITY DEFINER VIEW `qry_alae_sample_batch` AS select `s`.`pk_study` AS `pk_study`,`s`.`code` AS `code`,`a`.`pk_analyte` AS `pk_analyte`,`a`.`name` AS `name`,`b`.`pk_batch` AS `pk_batch`,`b`.`file_name` AS `batch`,`b`.`created_at` AS `created_at`,`b`.`valid_flag` AS `valid_flag`,`u`.`name` AS `user_name`,`b`.`validation_date` AS `validation_date`,`b`.`intercept` AS `intercept`,`b`.`slope` AS `slope`,`b`.`correlation_coefficient` AS `correlation_coefficient`,`b`.`code_error` AS `code_error`,`m`.`sample_name` AS `sample_name`,`m`.`analyte_peak_name` AS `analyte_peak_name`,`m`.`sample_type` AS `sample_type`,`m`.`file_name` AS `file_name`,`m`.`analyte_peak_area` AS `analyte_peak_area`,`m`.`is_peak_area` AS `is_peak_area`,`m`.`area_ratio` AS `area_ratio`,`m`.`analyte_concentration` AS `analyte_concentration`,`m`.`calculated_concentration` AS `calculated_concentration`,`m`.`dilution_factor` AS `dilution_factor`,`m`.`accuracy` AS `accuracy`,`m`.`use_record` AS `use_record`,`m`.`acquisition_date` AS `acquisition_date`,`m`.`analyte_integration_type` AS `analyte_integration_type`,`m`.`is_integration_type` AS `is_integration_type`,`m`.`record_modified` AS `record_modified`,`e`.`fk_parameter` AS `fk_parameter` from ((`alae_study` `s` join ((`alae_user` `u` join (`alae_analyte` `a` join `alae_batch` `b` on((`a`.`pk_analyte` = `b`.`fk_analyte`))) on((`u`.`pk_user` = `b`.`fk_user`))) join `alae_sample_batch` `m` on((`b`.`pk_batch` = `m`.`fk_batch`))) on((`s`.`pk_study` = `b`.`fk_study`))) left join `alae_error` `e` on((`e`.`fk_sample_batch` = `m`.`pk_sample_batch`))) ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
