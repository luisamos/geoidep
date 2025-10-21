--
-- USUARIOS
--
INSERT INTO ide.def_usuarios(correo_electronico, contrasena, estado, geoidep, geoperu, metadatos, id_perfil, id_persona, id_institucion, usuario_crea, fecha_crea) VALUES
('dquispe@pcm.gob.pe', 'scrypt:32768:8:1$R2VwxaFFqhLMZ2GZ$a87e56342ff475edd0d064fd6545100bcf88bbe062ae04a4be937db5cb236b3dba9d12c75e1e5a489e3bb9dd26cd5e37e85109f588792f4776e6d7ee61ecb21a', True, True, True, True, 1, 2, 45, 1, '01-08-2025'),
('lvaler@pcm.gob.pe', 'scrypt:32768:8:1$aDkj3nFyaBU1xCpz$ebd75029e7932c1569e351ebed1910af7fe47cbc2fcd89d7238557fc5845c7625e14754f373704d004e9675a196d6b020bb488fca456009b828fb0db28fb9bd4', True, True, True, False, 2, 6, 45, 1, '01-08-2025'),
('mfloresh@pcm.gob.pe', 'scrypt:32768:8:1$RhEjqzN2dHk7Zn4e$ee7402882ca399c5a24b818cab9c86d427a5e20d59b844f88457838597f79266c9ed253568e25c999653efa6c101c9fff4e0f70f8d02940be1cd5800de1f6ad4', True, True, True, False, 2, 3, 45, 1, '01-08-2025');

SELECT * FROM ide.def_usuarios;