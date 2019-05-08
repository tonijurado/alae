CREATE TRIGGER tblProductos_AfterInsert 
AFTER INSERT ON bbddorigen.tblusuarios
FOR EACH ROW 
	INSERT INTO bbdddestino.tblusuarios /* (idUsuario, nomUsuario)  */
	VALUES (new.IdUsuario, new.nomUsuario)