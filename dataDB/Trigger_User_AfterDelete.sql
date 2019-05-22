CREATE TRIGGER user_AFTERDelete
AFTER DELETE ON alae.alae_user
FOR EACH ROW

	DELETE FROM validaciones.alae_user
	WHERE validaciones.alae_user.pk_user = old.pk_user
