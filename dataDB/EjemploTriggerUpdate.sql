CREATE TRIGGER tblProductos_AfterUpdate
AFTER UPDATE ON bbddorigen.tblusuarios
FOR EACH ROW 
	UPDATE bbdddestino.tblusuarios 
		SET /*bbdddestino.tblusuarios.idUsuario = new.idUsuario,*/
		bbdddestino.tblusuarios.nomUsuario = new.nomUsuario
		
		WHERE bbdddestino.tblusuarios.idUsuario = new.idUsuario
		
		