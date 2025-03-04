-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.32 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para validaciones
CREATE DATABASE IF NOT EXISTS `validaciones` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `validaciones`;

-- Volcando estructura para tabla validaciones.alae_analyte
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
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_analyte: ~231 rows (aproximadamente)
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
	(256, 'Octreotide-d8', 'OCT-d8', '2019-10-28 06:59:41', 1, 15),
	(257, 'Furosemide', 'FUR', '2019-12-13 18:52:46', 1, 15),
	(258, 'Furosemide-d5', 'FUR-d5', '2019-12-13 18:53:15', 1, 15),
	(259, 'Hydroxy Memantine', 'OH-MEM', '2020-03-26 10:00:00', 1, 8),
	(260, 'Hydroxy Memantine d-6', 'OH-MEM-d6', '2020-03-24 09:00:00', 1, 8);
/*!40000 ALTER TABLE `alae_analyte` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_analyte_study
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
  `llqc_values` decimal(19,2) DEFAULT NULL,
  `ulqc_values` decimal(19,2) DEFAULT NULL,
  `retention` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `acceptance` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `retention_is` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `acceptance_is` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `associated_at` timestamp NULL DEFAULT NULL,
  `fk_user_associated` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`pk_analyte_study`),
  KEY `fk_study` (`fk_study`),
  KEY `fk_analyte` (`fk_analyte`),
  KEY `fk_analyte_is` (`fk_analyte_is`),
  KEY `fk_unit` (`fk_unit`),
  KEY `fk_user` (`fk_user`),
  KEY `fk_user_associated` (`fk_user_associated`),
  CONSTRAINT `alae_analyte_study_ibfk_1` FOREIGN KEY (`fk_study`) REFERENCES `alae_study` (`pk_study`),
  CONSTRAINT `alae_analyte_study_ibfk_2` FOREIGN KEY (`fk_analyte`) REFERENCES `alae_analyte` (`pk_analyte`),
  CONSTRAINT `alae_analyte_study_ibfk_3` FOREIGN KEY (`fk_analyte_is`) REFERENCES `alae_analyte` (`pk_analyte`),
  CONSTRAINT `alae_analyte_study_ibfk_4` FOREIGN KEY (`fk_unit`) REFERENCES `alae_unit` (`pk_unit`),
  CONSTRAINT `alae_analyte_study_ibfk_5` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`),
  CONSTRAINT `FK_alae_analyte_study_ibfk_6` FOREIGN KEY (`fk_user_associated`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_analyte_study: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_analyte_study` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_analyte_study` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_audit_session
CREATE TABLE IF NOT EXISTS `alae_audit_session` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_session_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla validaciones.alae_audit_session: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_audit_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_audit_session` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_audit_session_error
CREATE TABLE IF NOT EXISTS `alae_audit_session_error` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(25) NOT NULL,
  `message` varchar(500) NOT NULL,
  PRIMARY KEY (`pk_audit_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla validaciones.alae_audit_session_error: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_audit_session_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_audit_session_error` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_audit_transaction
CREATE TABLE IF NOT EXISTS `alae_audit_transaction` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `section` varchar(250) NOT NULL,
  `description` varchar(500) NOT NULL,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_transaction_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=15412 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla validaciones.alae_audit_transaction: ~530 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_audit_transaction` DISABLE KEYS */;
INSERT INTO `alae_audit_transaction` (`pk_audit_session`, `created_at`, `section`, `description`, `fk_user`) VALUES

	(15411, '2020-04-03 07:42:04', 'Inicio de sesión', 'El usuario toni ha iniciado sesión', 15);
/*!40000 ALTER TABLE `alae_audit_transaction` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_audit_transaction_error
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

-- Volcando datos para la tabla validaciones.alae_audit_transaction_error: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_audit_transaction_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_audit_transaction_error` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_batch
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_batch: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_batch` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_batch_nominal
CREATE TABLE IF NOT EXISTS `alae_batch_nominal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fk_batch` bigint(20) unsigned NOT NULL,
  `sample_name` varchar(250) NOT NULL,
  `value` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch` (`fk_batch`),
  CONSTRAINT `FK_nominal_batch` FOREIGN KEY (`fk_batch`) REFERENCES `alae_batch` (`pk_batch`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla validaciones.alae_batch_nominal: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_batch_nominal` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_batch_nominal` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_error
CREATE TABLE IF NOT EXISTS `alae_error` (
  `pk_error` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fk_parameter` int(11) NOT NULL,
  `fk_sample_batch` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_error`),
  KEY `fk_parameter` (`fk_parameter`),
  KEY `fk_sample_batch` (`fk_sample_batch`),
  CONSTRAINT `alae_error_ibfk_1` FOREIGN KEY (`fk_parameter`) REFERENCES `alae_parameter` (`pk_parameter`),
  CONSTRAINT `alae_error_ibfk_2` FOREIGN KEY (`fk_sample_batch`) REFERENCES `alae_sample_batch` (`pk_sample_batch`)
) ENGINE=InnoDB AUTO_INCREMENT=1285 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_error: ~151 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_error` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_parameter
CREATE TABLE IF NOT EXISTS `alae_parameter` (
  `pk_parameter` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `verification` text COLLATE utf8_bin,
  `min_value` int(11) NOT NULL DEFAULT '0',
  `max_value` int(11) NOT NULL DEFAULT '0',
  `code_error` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `message_error` text COLLATE utf8_bin,
  `type_param` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL,
  `fk_user` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`pk_parameter`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_parameter_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_parameter: ~49 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_parameter` DISABLE KEYS */;
INSERT INTO `alae_parameter` (`pk_parameter`, `rule`, `verification`, `min_value`, `max_value`, `code_error`, `message_error`, `type_param`, `status`, `fk_user`) VALUES
	(1, 'V1', 'Revisión del tamaño del archivo exportado', 20000, 30000, NULL, 'V1 - FALLO EXPORT TAMAÑO', 1, 1, 1),
	(2, 'V2', 'Revisión del archivo exportado (código de estudio)', 0, 0, NULL, 'V2 - EXPORT ERRÓNEO', 1, 1, 1),
	(3, 'V3', 'Revisión del archivo exportado (abreviatura analito)', 0, 0, NULL, 'V3 -  ANALITO ERRÓNEO', 1, 1, 1),
	(4, 'V4', 'Revisión del archivo exportado  (nº de lote)', 0, 0, NULL, 'V4 - EXPORT ERRÓNEO', 1, 1, 1),
	(5, 'V5', 'Sample Type', 0, 0, NULL, 'V5 - SAMPLE TYPE ERRÓNEO', 1, 1, 1),
	(6, 'V6', 'Concentración nominal de CS/QC', 2, 0, NULL, 'V6 - CONCENTRACIÓN NOMINAL ERRÓNEA', 1, 1, 1),
	(7, 'V7.1', 'Replicados CS (mínimo)', 2, 0, NULL, 'V7.1 - REPLICADOS INSUFICIENTES', 1, 1, 1),
	(8, 'V7.2', 'Replicados QC (mínimo)', 2, 0, NULL, 'V7.2 - REPLICADOS INSUFICIENTES', 1, 1, 1),
	(9, 'V8', 'Sample Name repetido', 0, 0, NULL, 'V8 - SAMPLE NAME REPETIDO', 1, 1, 1),
	(10, 'V9', 'Búsqueda de Muestras reinyectadas', 0, 0, NULL, NULL, 1, 1, 1),
	(11, 'V9.1', 'Accuracy (Sample Name + Rx*)', -15, 15, 'O', 'V9.1 - (Sample Name + Rx*) ACCURACY FUERA DE RANGO', 1, 1, 1),
	(12, 'V9.2', 'Use record = 0 ( Sample Name + Rx* )', 0, 0, 'O', 'V9.2 - Sample Name + Rx*  USE RECORD NO VALIDO', 1, 1, 1),
	(13, 'V9.3', 'Que tanto V 9.1 como V 9.2 se cumplan', 0, 0, 'O', 'V9.3 - QRC NO VÁLIDO', 1, 1, 1),
	(14, 'V10.1', 'Accuracy (CS1)', 80, 120, 'O', 'V10.1 - NO CUMPLE ACCURACY', 1, 0, 1),
	(15, 'V10.1.1', 'Accuracy (CS1) UseRecord Erroneo', 80, 120, '', 'V10.1.1 - Use Record Erroneo', 1, 1, 1),
	(16, 'V10.2', 'Accuracy (CS2-CSx)', 85, 115, 'O', 'V10.2 - NO CUMPLE ACCURACY', 1, 0, 1),
	(17, 'V10.2.1', 'Accuracy (CS2-CSx) UseRecord Erroneo', 85, 115, '', 'V10.2.1 - Use Record Erroneo', 1, 1, 1),
	(18, 'V10.3', 'Accuracy (QC)', 85, 115, 'O', 'V10.3 - NO CUMPLE ACCURACY', 1, 0, 1),
	(19, 'V10.3.1', 'Accuracy (QC) UseRecord Erroneo', 85, 115, '', 'V10.3.1 - Use Record Erroneo', 1, 1, 1),
	(20, 'V10.4', 'Accuracy (TZ)', 90, 110, 'O', 'V10.4 - NO CUMPLE ACCURACY', 1, 0, 1),
	(21, 'V10.4.1', 'Accuracy (TZ)', 90, 110, 'O', 'V10.4.1 - Use Record Erroneo', 1, 1, 1),
	(22, 'V10.5', 'Accuracy DQC (LDQC y HDQC)', 85, 115, 'O', 'V10.5 - NO CUMPLE ACCURACY', 1, 0, 1),
	(23, 'V10.5.1', 'Accuracy DQC (LDQC y HDQC) Use Record Erroneo', 85, 115, '', 'V10.5.1 - Use Record Erroneo', 1, 1, 1),
	(24, 'V11', 'Revisión del dilution factor en HDQC / LDQC', 0, 0, 'O', 'V11- FACTOR DILUCIÓN ERRÓNEO', 1, 1, 1),
	(25, 'V12', 'Use record (CS/QC/DQC)', 0, 0, NULL, NULL, 1, 1, 1),
	(26, 'V12.1', NULL, 0, 0, 'O', 'V12 - No cumple S/N', 0, 1, 1),
	(27, 'V12.2', NULL, 0, 0, 'A', 'V12 - Muestra perdida durante la extracción', 0, 1, 1),
	(28, 'V12.3', NULL, 0, 0, 'B', 'V12 - Error de extracción', 0, 1, 1),
	(29, 'V12.4', NULL, 0, 0, 'B', 'V12 - Respuesta IS inferior al 5%', 0, 1, 1),
	(30, 'V12.5', NULL, 0, 0, 'C1', 'V12 - Problemas de cromatografía', 0, 1, 1),
	(31, 'V12.6', NULL, 0, 0, 'C2', 'V12 - Tiempo de retención inaceptable', 0, 1, 1),
	(32, 'V12.7', NULL, 0, 0, 'D', 'V12 - Fallo técnico de equipo / software', 0, 1, 1),
	(33, 'V12.8', NULL, 0, 0, NULL, 'V12 - Use Record Erróneo', 0, 1, 1),
	(34, 'V13.1', 'Tiempo de retención (C2)', 0, 0, 'C2', 'V13.1 - Tiempo de retención inaceptable', 1, 1, 1),
	(35, 'V13.2', 'LOTE NO VÁLIDO Use Record Erróneo CS/QC (C2)', 0, 0, 'C2', 'V13.2- LOTE NO VÁLIDO Use record Erróneo', 1, 1, 1),
	(36, 'V14.1', '5% IS', 5, 0, 'B2', 'V14.1 - 5% IS', 1, 0, NULL),
	(37, 'V14.2', 'CS y QC (Sample Type=Standard o Quality Control) rechazadas por el motivo B2', 5, 0, NULL, 'V14.2 - LOTE NO VÁLIDO + USE RECORD ERRÓNEO', 1, 1, 1),
	(38, 'V15.1', 'Selección manual de los CS válidos', 0, 0, NULL, NULL, 1, 1, 1),
	(39, 'V15.2', 'Interf. Analito en BLK', 20, 0, 'O', 'V15.2 - BLK NO CUMPLE', 1, 1, 1),
	(40, 'V15.3', 'Interf. IS en BLK', 5, 0, 'O', 'V15.3 - BLK NO CUMPLE', 1, 1, 1),
	(41, 'V15.4', 'Interf. Analito en ZS', 20, 0, 'O', 'V15.4 - ZS NO CUMPLE', 1, 1, 1),
	(42, 'V17', '75% CS', 75, 0, NULL, 'V17 - LOTE RECHAZADO (75% CS)', 1, 1, 1),
	(43, 'V18', 'CS consecutivos', 0, 0, NULL, 'V18 - LOTE RECHAZADO (CS CONSECUTIVOS)', 1, 1, 1),
	(44, 'V19.1', '>=50% de los CS1', 50, 0, NULL, 'V19.1 - LOTE RECHAZADO (50% CS1)', 1, 1, 1),
	(45, 'V19.2', '>=50% de los CS8 o superior', 50, 0, NULL, 'V19.2 - LOTE RECHAZADO (50% CS8 o superior)', 1, 1, 1),
	(46, 'V20', 'r < 0.99', 99, 0, NULL, 'V20 - LOTE RECHAZADO (r< 0.99)', 1, 1, 1),
	(47, 'V21', '67% QC', 67, 0, NULL, 'V21 - LOTE RECHAZADO (67% QC)', 1, 1, 1),
	(48, 'V21???', 'Conc. (unknown) > ULOQ ( E )', 0, 0, 'E', 'V21 - CONC. SUPERIOR AL ULOQ', 1, 1, 1),
	(49, 'V22???', 'Variabilidad IS (unknown) ( H )', 0, 0, 'H', 'V22 - VARIABILIDAD IS', 1, 1, 1),
	(50, 'V22', '50% de cada nivel de QC', 50, 0, NULL, 'V22 - LOTE RECHAZADO (50% QCx)', 1, 1, 1),
	(51, 'V23.1', '50% BLK', 50, 0, NULL, 'V23.1 - LOTE RECHAZADO (INTERF. BLK)', 1, 1, 1),
	(52, 'V23.2', '50% ZS', 50, 0, '', 'V23.2 - LOTE RECHAZADO (INTERF. ZS)', 1, 1, 1),
	(53, 'V24', 'Fuera rango recta truncada ( F )', 0, 0, 'F', 'V24 - FUERA DE RANGO/RECTA TRUNCADA', 1, 1, 1),
	(54, 'V25', 'Basal cuantificable (Unknown) (J)', 0, 0, 'J', 'V25 - Basal cuantificable', 1, 1, 1);
/*!40000 ALTER TABLE `alae_parameter` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_profile
CREATE TABLE IF NOT EXISTS `alae_profile` (
  `pk_profile` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`pk_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_profile: ~7 rows (aproximadamente)
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

-- Volcando estructura para tabla validaciones.alae_sample_batch
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
) ENGINE=InnoDB AUTO_INCREMENT=7957 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_sample_batch: ~452 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_sample_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_sample_batch` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_sample_verification
CREATE TABLE IF NOT EXISTS `alae_sample_verification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `associated` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_sample_verification: ~24 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_sample_verification` DISABLE KEYS */;
INSERT INTO `alae_sample_verification` (`id`, `name`, `associated`) VALUES
	(27, 'ST1', 'QC1'),
	(28, 'LT1', 'QC1'),
	(29, 'PP1', 'QC1'),
	(30, 'SLP1', 'QC1'),
	(31, 'TZ1_FC', 'QC1'),
	(32, 'FT1_FC', 'QC1'),
	(33, 'ST1_FC', 'QC1'),
	(34, 'LT1_FC', 'QC1'),
	(35, 'PP1_FC', 'QC1'),
	(36, 'SLP1_FC', 'QC1'),
	(37, 'PID', 'LLQC'),
	(38, 'LLOQ', 'CS1'),
	(39, 'TZ3', 'QC3'),
	(40, 'FT3', 'QC3'),
	(41, 'ST3', 'QC3'),
	(42, 'LT3', 'QC3'),
	(43, 'PP3', 'QC3'),
	(44, 'SLP3', 'QC3'),
	(45, 'TZ3_FC', 'QC3'),
	(46, 'FT3_FC', 'QC3'),
	(47, 'ST3_FC', 'QC3'),
	(48, 'LT3_FC', 'QC3'),
	(49, 'PP3_FC', 'QC3'),
	(50, 'SLP3_FC', 'QC3');
/*!40000 ALTER TABLE `alae_sample_verification` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_sample_verification_study
CREATE TABLE IF NOT EXISTS `alae_sample_verification_study` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_analyte_study` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `associated` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_analyte_study` (`fk_analyte_study`),
  CONSTRAINT `FK_verifiationStudy_AnalyteStudy` FOREIGN KEY (`fk_analyte_study`) REFERENCES `alae_analyte_study` (`pk_analyte_study`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_sample_verification_study: ~48 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_sample_verification_study` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_sample_verification_study` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_study
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
  `validation` tinyint(1) NOT NULL DEFAULT '0',
  `verification` tinyint(1) DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_study: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_study` DISABLE KEYS */;
/*!40000 ALTER TABLE `alae_study` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_unit
CREATE TABLE IF NOT EXISTS `alae_unit` (
  `pk_unit` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`pk_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Volcando datos para la tabla validaciones.alae_unit: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `alae_unit` DISABLE KEYS */;
INSERT INTO `alae_unit` (`pk_unit`, `name`) VALUES
	(1, 'ng/mL'),
	(2, 'pg/mL'),
	(3, 'µg/mL'),
	(4, 'fg/mL'),
	(5, 'mg/mL'),
	(6, 'g/mL');
/*!40000 ALTER TABLE `alae_unit` ENABLE KEYS */;

-- Volcando estructura para tabla validaciones.alae_user
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

-- Volcando datos para la tabla validaciones.alae_user: ~43 rows (aproximadamente)
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

-- Volcando estructura para procedimiento validaciones.proc_alae_sample_errors
DELIMITER //
CREATE PROCEDURE `proc_alae_sample_errors`(IN `batch_num` INT)
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

-- Volcando estructura para vista validaciones.qry_alae_control_v9
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

-- Volcando estructura para vista validaciones.qry_alae_sample_batch
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
	`intercept` FLOAT(12) NULL,
	`slope` FLOAT(12) NULL,
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

-- Volcando estructura para tabla validaciones.qry_alae_sample_errors
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

-- Volcando datos para la tabla validaciones.qry_alae_sample_errors: 0 rows
/*!40000 ALTER TABLE `qry_alae_sample_errors` DISABLE KEYS */;
/*!40000 ALTER TABLE `qry_alae_sample_errors` ENABLE KEYS */;

-- Volcando estructura para vista validaciones.qry_alae_control_v9
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_control_v9`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `qry_alae_control_v9` AS select `alae_sample_batch`.`pk_sample_batch` AS `pk_sample_batch`,`alae_sample_batch`.`sample_name` AS `sample_name`,`alae_sample_batch`.`accuracy` AS `accuracy`,`alae_sample_batch`.`use_record` AS `use_record`,if((right(`alae_sample_batch`.`sample_name`,1) = '*'),'R','C') AS `tipo`,if(((`alae_sample_batch`.`accuracy` >= 85) and (`alae_sample_batch`.`accuracy` <= 115)),1,0) AS `ok_accuracy`,if(((right(`alae_sample_batch`.`sample_name`,1) <> '*') and (`alae_sample_batch`.`use_record` = 1)),1,if(((right(`alae_sample_batch`.`sample_name`,1) = '*') and (`alae_sample_batch`.`use_record` = 0)),1,0)) AS `use_record_ok` from `alae_sample_batch` where (`alae_sample_batch`.`sample_type` = 'Quality Control') ;

-- Volcando estructura para vista validaciones.qry_alae_sample_batch
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_sample_batch`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `qry_alae_sample_batch` AS select `s`.`pk_study` AS `pk_study`,`s`.`code` AS `code`,`a`.`pk_analyte` AS `pk_analyte`,`a`.`name` AS `name`,`b`.`pk_batch` AS `pk_batch`,`b`.`file_name` AS `batch`,`b`.`created_at` AS `created_at`,`b`.`valid_flag` AS `valid_flag`,`u`.`name` AS `user_name`,`b`.`validation_date` AS `validation_date`,`b`.`intercept` AS `intercept`,`b`.`slope` AS `slope`,`b`.`correlation_coefficient` AS `correlation_coefficient`,`b`.`code_error` AS `code_error`,`m`.`sample_name` AS `sample_name`,`m`.`analyte_peak_name` AS `analyte_peak_name`,`m`.`sample_type` AS `sample_type`,`m`.`file_name` AS `file_name`,`m`.`analyte_peak_area` AS `analyte_peak_area`,`m`.`is_peak_area` AS `is_peak_area`,`m`.`area_ratio` AS `area_ratio`,`m`.`analyte_concentration` AS `analyte_concentration`,`m`.`calculated_concentration` AS `calculated_concentration`,`m`.`dilution_factor` AS `dilution_factor`,`m`.`accuracy` AS `accuracy`,`m`.`use_record` AS `use_record`,`m`.`acquisition_date` AS `acquisition_date`,`m`.`analyte_integration_type` AS `analyte_integration_type`,`m`.`is_integration_type` AS `is_integration_type`,`m`.`record_modified` AS `record_modified`,`e`.`fk_parameter` AS `fk_parameter` from ((`alae_study` `s` join ((`alae_user` `u` join (`alae_analyte` `a` join `alae_batch` `b` on((`a`.`pk_analyte` = `b`.`fk_analyte`))) on((`u`.`pk_user` = `b`.`fk_user`))) join `alae_sample_batch` `m` on((`b`.`pk_batch` = `m`.`fk_batch`))) on((`s`.`pk_study` = `b`.`fk_study`))) left join `alae_error` `e` on((`e`.`fk_sample_batch` = `m`.`pk_sample_batch`))) ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
