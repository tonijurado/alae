CREATE TRIGGER user_AfterInsert 
AFTER INSERT ON alae.alae_user
FOR EACH ROW 
	INSERT INTO validaciones.alae_user /* (idUsuario, nomUsuario)  */
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
		)