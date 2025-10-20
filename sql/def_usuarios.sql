--
-- USUARIOS
--
INSERT INTO ide.def_usuarios(correo_electronico, contrasena, estado, geoidep, geoperu, metadatos, id_perfil, id_persona, id_institucion, usuario_crea, fecha_crea) VALUES
('dquispe@pcm.gob.pe', 'scrypt:32768:8:1$R2VwxaFFqhLMZ2GZ$a87e56342ff475edd0d064fd6545100bcf88bbe062ae04a4be937db5cb236b3dba9d12c75e1e5a489e3bb9dd26cd5e37e85109f588792f4776e6d7ee61ecb21a', True, True, True, True, 1, 1, 45, 1, '01-08-2025'),
('lvaler@pcm.gob.pe', 'scrypt:32768:8:1$aDkj3nFyaBU1xCpz$ebd75029e7932c1569e351ebed1910af7fe47cbc2fcd89d7238557fc5845c7625e14754f373704d004e9675a196d6b020bb488fca456009b828fb0db28fb9bd4', True, True, True, False, 2, 6, 45, 1, '01-08-2025');

SELECT * FROM ide.def_usuarios;