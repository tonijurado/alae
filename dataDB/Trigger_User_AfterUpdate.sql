CREATE TRIGGER user_AfterUpdate
AFTER UPDATE ON alae.alae_user
FOR EACH ROW 
	UPDATE validaciones.alae_user 
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
	
		WHERE validaciones.alae_user.pk_user = new.pk_user
		
		