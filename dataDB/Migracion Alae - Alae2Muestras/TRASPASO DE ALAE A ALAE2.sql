-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.32 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             11.0.0.5919
--
-- PROCESO DE MIGRACION DE ALAE hasta ALAE2Muestras. El NOMBRE DE LA BBDD DE DESTINO SERÁ "MUESTRAS"
--
--
--
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para alae2test
DROP DATABASE IF EXISTS `muestras`;
CREATE DATABASE IF NOT EXISTS `muestras` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `muestras`;

-- Volcando estructura para tabla alae2test.alae_analyte
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_analyte_study
CREATE TABLE IF NOT EXISTS `alae_analyte_study` (
  `pk_analyte_study` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cs_number` int(11) NOT NULL DEFAULT '8',
  `qc_number` int(11) NOT NULL DEFAULT '4',
  `cs_values` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `qc_values` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `internal_standard` decimal(19,2) DEFAULT '0.00',
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
  `retention` decimal(19,2) DEFAULT '0.00',
  `acceptance` decimal(19,2) DEFAULT '0.00',
  `retention_is` decimal(19,2) DEFAULT '0.00',
  `acceptance_is` decimal(19,2) DEFAULT '0.00',
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_audit_session
CREATE TABLE IF NOT EXISTS `alae_audit_session` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_session_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_audit_session_error
CREATE TABLE IF NOT EXISTS `alae_audit_session_error` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(25) NOT NULL,
  `message` varchar(500) NOT NULL,
  PRIMARY KEY (`pk_audit_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_audit_transaction
CREATE TABLE IF NOT EXISTS `alae_audit_transaction` (
  `pk_audit_session` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `section` varchar(250) NOT NULL,
  `description` varchar(500) NOT NULL,
  `fk_user` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_audit_session`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_audit_transaction_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_audit_transaction_error
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

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_batch
CREATE TABLE IF NOT EXISTS `alae_batch` (
  `pk_batch` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `serial` int(11) DEFAULT NULL,
  `file_name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `file_size` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `valid_flag` tinyint(1) DEFAULT NULL,
  `accepted_flag` tinyint(1) DEFAULT NULL,
  `curve_flag` tinyint(4) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=1799 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_error
CREATE TABLE IF NOT EXISTS `alae_error` (
  `pk_error` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fk_parameter` int(11) NOT NULL,
  `fk_sample_batch` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`pk_error`),
  KEY `fk_parameter` (`fk_parameter`),
  KEY `fk_sample_batch` (`fk_sample_batch`),
  CONSTRAINT `alae_error_ibfk_1` FOREIGN KEY (`fk_parameter`) REFERENCES `alae_parameter` (`pk_parameter`),
  CONSTRAINT `alae_error_ibfk_2` FOREIGN KEY (`fk_sample_batch`) REFERENCES `alae_sample_batch` (`pk_sample_batch`)
) ENGINE=InnoDB AUTO_INCREMENT=1567 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_parameter
CREATE TABLE IF NOT EXISTS `alae_parameter` (
  `pk_parameter` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `verification` text COLLATE utf8_bin,
  `min_value` int(11) NOT NULL DEFAULT '0',
  `max_value` int(11) NOT NULL DEFAULT '0',
  `code_error` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `message_error` text COLLATE utf8_bin,
  `type_param` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(4) NOT NULL,
  `fk_user` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`pk_parameter`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `alae_parameter_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `alae_user` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_profile
CREATE TABLE IF NOT EXISTS `alae_profile` (
  `pk_profile` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`pk_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_sample_batch
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
) ENGINE=InnoDB AUTO_INCREMENT=101061 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_study
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_unit
CREATE TABLE IF NOT EXISTS `alae_unit` (
  `pk_unit` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`pk_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla alae2test.alae_user
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
) ENGINE=InnoDB
 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para procedimiento alae2test.proc_alae_sample_errors
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

-- Volcando estructura para vista alae2test.qry_alae_control_v9
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

-- Volcando estructura para vista alae2test.qry_alae_sample_batch
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

-- Volcando estructura para vista alae2test.qry_alae_sample_errors
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `qry_alae_sample_errors` (
	`serial` INT(11) NULL,
	`pk_batch` BIGINT(20) UNSIGNED NOT NULL,
	`analyte_peak_name` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`sample_name` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`sample_type` VARCHAR(250) NOT NULL COLLATE 'utf8_bin',
	`file_name` VARCHAR(100) NULL COLLATE 'utf8_bin',
	`fk_parameter` INT(11) NOT NULL,
	`rule` VARCHAR(10) NULL COLLATE 'utf8_bin',
	`verification` TEXT(65535) NULL COLLATE 'utf8_bin',
	`min_value` INT(11) NOT NULL,
	`max_value` INT(11) NOT NULL,
	`code_error` VARCHAR(10) NULL COLLATE 'utf8_bin',
	`message_error` TEXT(65535) NULL COLLATE 'utf8_bin',
	`is_used` TINYINT(1) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla alae2test.qry_alae_sample_errors1
CREATE TABLE IF NOT EXISTS `qry_alae_sample_errors1` (
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

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para vista alae2test.qry_alae_control_v9
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_control_v9`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `qry_alae_control_v9` AS select `alae_sample_batch`.`pk_sample_batch` AS `pk_sample_batch`,`alae_sample_batch`.`sample_name` AS `sample_name`,`alae_sample_batch`.`accuracy` AS `accuracy`,`alae_sample_batch`.`use_record` AS `use_record`,if((right(`alae_sample_batch`.`sample_name`,1) = '*'),'R','C') AS `tipo`,if(((`alae_sample_batch`.`accuracy` >= 85) and (`alae_sample_batch`.`accuracy` <= 115)),1,0) AS `ok_accuracy`,if(((right(`alae_sample_batch`.`sample_name`,1) <> '*') and (`alae_sample_batch`.`use_record` = 1)),1,if(((right(`alae_sample_batch`.`sample_name`,1) = '*') and (`alae_sample_batch`.`use_record` = 0)),1,0)) AS `use_record_ok` from `alae_sample_batch` where (`alae_sample_batch`.`sample_type` = 'Quality Control') ;

-- Volcando estructura para vista alae2test.qry_alae_sample_batch
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_sample_batch`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `qry_alae_sample_batch` AS select `s`.`pk_study` AS `pk_study`,`s`.`code` AS `code`,`a`.`pk_analyte` AS `pk_analyte`,`a`.`name` AS `name`,`b`.`pk_batch` AS `pk_batch`,`b`.`file_name` AS `batch`,`b`.`created_at` AS `created_at`,`b`.`valid_flag` AS `valid_flag`,`u`.`name` AS `user_name`,`b`.`validation_date` AS `validation_date`,`b`.`intercept` AS `intercept`,`b`.`slope` AS `slope`,`b`.`correlation_coefficient` AS `correlation_coefficient`,`b`.`code_error` AS `code_error`,`m`.`sample_name` AS `sample_name`,`m`.`analyte_peak_name` AS `analyte_peak_name`,`m`.`sample_type` AS `sample_type`,`m`.`file_name` AS `file_name`,`m`.`analyte_peak_area` AS `analyte_peak_area`,`m`.`is_peak_area` AS `is_peak_area`,`m`.`area_ratio` AS `area_ratio`,`m`.`analyte_concentration` AS `analyte_concentration`,`m`.`calculated_concentration` AS `calculated_concentration`,`m`.`dilution_factor` AS `dilution_factor`,`m`.`accuracy` AS `accuracy`,`m`.`use_record` AS `use_record`,`m`.`acquisition_date` AS `acquisition_date`,`m`.`analyte_integration_type` AS `analyte_integration_type`,`m`.`is_integration_type` AS `is_integration_type`,`m`.`record_modified` AS `record_modified`,`e`.`fk_parameter` AS `fk_parameter` from ((`alae_study` `s` join ((`alae_user` `u` join (`alae_analyte` `a` join `alae_batch` `b` on((`a`.`pk_analyte` = `b`.`fk_analyte`))) on((`u`.`pk_user` = `b`.`fk_user`))) join `alae_sample_batch` `m` on((`b`.`pk_batch` = `m`.`fk_batch`))) on((`s`.`pk_study` = `b`.`fk_study`))) left join `alae_error` `e` on((`e`.`fk_sample_batch` = `m`.`pk_sample_batch`))) ;

-- Volcando estructura para vista alae2test.qry_alae_sample_errors
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `qry_alae_sample_errors`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `qry_alae_sample_errors` AS select `b`.`serial` AS `serial`,`b`.`pk_batch` AS `pk_batch`,`sb`.`analyte_peak_name` AS `analyte_peak_name`,`sb`.`sample_name` AS `sample_name`,`sb`.`sample_type` AS `sample_type`,`b`.`file_name` AS `file_name`,`e`.`fk_parameter` AS `fk_parameter`,`p`.`rule` AS `rule`,`p`.`verification` AS `verification`,`p`.`min_value` AS `min_value`,`p`.`max_value` AS `max_value`,`p`.`code_error` AS `code_error`,`p`.`message_error` AS `message_error`,`sb`.`is_used` AS `is_used` from (`alae_batch` `b` join ((`alae_sample_batch` `sb` join `alae_error` `e` on((`sb`.`pk_sample_batch` = `e`.`fk_sample_batch`))) join `alae_parameter` `p` on((`e`.`fk_parameter` = `p`.`pk_parameter`))) on((`b`.`pk_batch` = `sb`.`fk_batch`))) ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;


-- INSERTAMOS la tabla alae_profile -- OK

INSERT INTO muestras.alae_profile
	(SELECT * FROM alae.alae_profile);

-- 2º insertamos alae_user -- OK 
INSERT INTO muestras.alae_user
	(SELECT * FROM alae.alae_user);

-- 3º insertamos alae_audit_transaction 

-- DELETE FROM muestras.alae_audit_transaction WHERE 1;
-- ALTER TABLE muestras.alae_audit_transaction AUTO_INCREMENT = 481;
INSERT INTO muestras.alae_audit_transaction 
	(SELECT * FROM alae.alae_audit_transaction);


-- 4º Insertamos alae_error
INSERT INTO muestras.alae_error
	(SELECT * FROM alae.alae_error);

-- 5º Insertamos alae_sample_batch
INSERT INTO muestras.alae_sample_batch
	(SELECT * FROM alae.alae_sample_batch);
	
-- 6º Insertamos alae_analyte
INSERT INTO muestras.alae_analyte
	(SELECT * FROM alae.alae_analyte);

-- 7º Insertamos alae_analyte_study
INSERT INTO muestras.alae_analyte_study (pk_analyte_study, cs_number, qc_number, cs_values,qc_values,internal_standard,`status`,is_used,updated_at,fk_study,fk_analyte,fk_analyte_is,fk_unit,fk_user,fk_user_approve,hdqc_values,ldqc_values)  
	(SELECT pk_analyte_study, cs_number, qc_number , cs_values,qc_values,internal_standard,`status`,is_used,updated_at,fk_study,fk_analyte,fk_analyte_is,fk_unit,fk_user,fk_user_approve,hdqc_values,ldqc_values FROM alae.alae_analyte_study);

-- 8º Insertamos alae_batch
INSERT INTO muestras.alae_batch (pk_batch,`serial`, file_name,created_at,updated_at,valid_flag,accepted_flag, curve_flag, justification,validation_date,code_error,intercept,slope,correlation_coefficient,cs_total,qc_total,ldqc_total,hdqc_total,cs_accepted_total,qc_accepted_total,ldqc_accepted_total,hdqc_accepted_total,is_cs_qc_accepted_avg,analyte_concentration_units,calculated_concentration_units,fk_parameter,fk_analyte,fk_user,fk_study)
	(SELECT pk_batch,`serial`, file_name,created_at,updated_at,valid_flag,accepted_flag, 0,justification,validation_date,code_error,intercept,slope,correlation_coefficient,cs_total,qc_total,ldqc_total,hdqc_total,cs_accepted_total,qc_accepted_total,ldqc_accepted_total,hdqc_accepted_total,is_cs_qc_accepted_avg,analyte_concentration_units,calculated_concentration_units,fk_parameter,fk_analyte,fk_user,fk_study FROM alae.alae_batch);

-- 9º Insertamos alae_study
-- Colocamos como fecha en muestras de approved_at el valor de updated_at

INSERT INTO muestras.alae_study (pk_study,`code`,created_at,updated_at,approved_at, description,observation,close_flag,`status`,approve,`duplicate`,fk_user,fk_user_approve,fk_user_close,fk_dilution_tree)
	(SELECT pk_study,`code`,created_at,updated_at, updated_at, description,observation,close_flag,`status`,approve,`duplicate`,fk_user,fk_user_approve,fk_user_close,fk_dilution_tree FROM alae.alae_study);
	
-- 10º Insertamos alae_unit
	
INSERT INTO muestras.alae_unit
	(SELECT * FROM alae.alae_unit);
	
	
-- 11º TRASPASAMOS PARAMETERS DESDE ALAE2TEST porque es quien tiene correctamente los datos hasta ALAEFINAL

INSERT INTO muestras.alae_parameter
	(SELECT * FROM alae2test.alae_parameter);


-- AGREGRAMOS AHORA LOS TRIGGRES
/*TRIGGERS*/

USE muestras;

-- Volcando estructura para disparador alae2test.analitos_AFTERDelete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `analitos_AFTERDelete` AFTER DELETE ON `alae_analyte` FOR EACH ROW DELETE FROM validacionestest.alae_analyte 
	WHERE validacionestest.alae_analyte.pk_analyte = old.pk_analyte//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae2test.analitos_AfterInsert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `analitos_AfterInsert` AFTER INSERT ON `alae_analyte` FOR EACH ROW INSERT INTO validacionestest.alae_analyte /* (idUsuario, nomUsuario)  */
	VALUES (new.pk_analyte, new.NAME, new.shortening, new.updated_at, new.STATUS, new.fk_user)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae2test.analitos_AfterUpdate
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `analitos_AfterUpdate` AFTER UPDATE ON `alae_analyte` FOR EACH ROW UPDATE validacionestest.alae_analyte 

		SET /*bbdddestino.tblusuarios.idUsuario = new.idUsuario,*/
		validacionestest.alae_analyte.pk_analyte = new.pk_analyte,
		validacionestest.alae_analyte.NAME = new.NAME,
		validacionestest.alae_analyte.shortening = new.shortening,
		validacionestest.alae_analyte.updated_at = new.updated_at,
		validacionestest.alae_analyte.`status` = new.`status`,
		validacionestest.alae_analyte.fk_user = new.fk_user
		WHERE validacionestest.alae_analyte.pk_analyte = new.pk_analyte//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae2test.user_AFTERDelete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `user_AFTERDelete` AFTER DELETE ON `alae_user` FOR EACH ROW DELETE FROM validacionestest.alae_user

	WHERE validacionestest.alae_user.pk_user = old.pk_user//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador alae2test.user_AfterInsert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `user_AfterInsert` AFTER INSERT ON `alae_user` FOR EACH ROW INSERT INTO validacionestest.alae_user /* (idUsuario, nomUsuario)  */

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

-- Volcando estructura para disparador alae2test.user_AfterUpdate
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `user_AfterUpdate` AFTER UPDATE ON `alae_user` FOR EACH ROW UPDATE validacionestest.alae_user 

		SET /*bbdddestino.tblusuarios.idUsuario = new.idUsuario,*/
		validacionestest.alae_user.pk_user = new.pk_user,
		validacionestest.alae_user.NAME = new.NAME,
		validacionestest.alae_user.username = new.username,
		validacionestest.alae_user.email = new.email,
		validacionestest.alae_user.password = new.password,
		validacionestest.alae_user.active_code = new.active_code,
		validacionestest.alae_user.verification = new.verification,
		validacionestest.alae_user.active_flag = new.active_flag,
		validacionestest.alae_user.fk_profile = new.fk_profile
		WHERE validacionestest.alae_user.pk_user = new.pk_user//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

