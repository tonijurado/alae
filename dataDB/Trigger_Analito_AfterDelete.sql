CREATE TRIGGER analitos_AFTERDelete
AFTER DELETE ON alae.alae_analyte
FOR EACH ROW

	DELETE FROM validaciones.alae_analyte 
	WHERE validaciones.alae_analyte.pk_analyte = old.pk_analyte
