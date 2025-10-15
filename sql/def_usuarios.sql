--
-- USUARIOS
--
SELECT * FROM ide.def_usuarios;

SELECT * FROM ide.def_rol;

UPDATE ide.def_usuarios SET confirmed=True;

UPDATE ide.def_usuarios SET id_perfil=1 WHERE id= 1;


