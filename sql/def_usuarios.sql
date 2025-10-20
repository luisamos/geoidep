--
-- USUARIOS
--
INSERT INTO ide.def_usuarios(correo_electronico, contrasena, estado, geoidep, geoperu, metadatos, id_perfil, id_persona, id_institucion, usuario_crea, fecha_crea) VALUES
('dquispe@pcm.gob.pe', 'scrypt:32768:8:1$EnUOwxP7EvUc0ZNm$74bc6b57b2adfaf722cbfbb9886194bf8f82f02232facd4620256e444412f2c78992eb9fde7b2c501c08e08bc0b17852d0d34075fced48811ca5b1cbde2f5fb7', True, True, True, True, 1, 1, 45, 1, '01-08-2025'),
('lvaler@pcm.gob.pe', 'scrypt:32768:8:1$aDkj3nFyaBU1xCpz$ebd75029e7932c1569e351ebed1910af7fe47cbc2fcd89d7238557fc5845c7625e14754f373704d004e9675a196d6b020bb488fca456009b828fb0db28fb9bd4', True, True, True, False, 2, 6, 45, 1, '01-08-2025');