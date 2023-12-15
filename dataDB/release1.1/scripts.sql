INSERT INTO `alae`.`alae_profile` (`name`) VALUES ('Administrador Usuarios');
SET @last_id_alae = LAST_INSERT_ID();
INSERT INTO `alae`.`alae_user` 
(`name`, `username`, `email`, `password`, `active_code`, `verification`, `active_flag`, `fk_profile`) 
SELECT 'test admin users', 'adminusers', 'test@gmail.com', `password`, `active_code`, `verification`, `active_flag`, @last_id_alae
FROM `alae`.`alae_user` 
WHERE `username` = 'toni';

INSERT INTO `validaciones`.`alae_profile` (`name`) VALUES ('Administrador Usuarios');
SET @last_id_validaciones = LAST_INSERT_ID();
INSERT INTO `validaciones`.`alae_user` 
(`name`, `username`, `email`, `password`, `active_code`, `verification`, `active_flag`, `fk_profile`) 
SELECT 'test admin users', 'adminusers', 'test@gmail.com', `password`, `active_code`, `verification`, `active_flag`, @last_id_validaciones
FROM `validaciones`.`alae_user` 
WHERE `username` = 'toni';