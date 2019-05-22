CREATE TRIGGER analitos_AfterUpdate
AFTER UPDATE ON alae.alae_analyte
FOR EACH ROW 
	UPDATE validaciones.alae_analyte 
		SET /*bbdddestino.tblusuarios.idUsuario = new.idUsuario,*/
		validaciones.alae_analyte.pk_analyte = new.pk_analyte,
		validaciones.alae_analyte.NAME = new.NAME,
		validaciones.alae_analyte.shortening = new.shortening,
		validaciones.alae_analyte.updated_at = new.updated_at,
		validaciones.alae_analyte.`status` = new.`status`,
		validaciones.alae_analyte.fk_user = new.fk_user
		
		WHERE validaciones.alae_analyte.pk_analyte = new.pk_analyte
		
		