CREATE TRIGGER analitos_AfterInsert 
AFTER INSERT ON alae.alae_analyte
FOR EACH ROW 
	INSERT INTO validaciones.alae_analyte /* (idUsuario, nomUsuario)  */
	VALUES (new.pk_analyte, new.NAME, new.shortening, new.updated_at, new.STATUS, new.fk_user)