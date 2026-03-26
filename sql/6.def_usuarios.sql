--
-- USUARIOS
--
INSERT INTO ide.def_usuarios(correo_electronico, contrasena, estado, cnd, idep, geoperu, pnda, cnm, id_documento, id_perfil, id_persona, id_institucion, usuario_registro, fecha_registro) VALUES
('dquispe@pcm.gob.pe', 'scrypt:32768:8:1$R2VwxaFFqhLMZ2GZ$a87e56342ff475edd0d064fd6545100bcf88bbe062ae04a4be937db5cb236b3dba9d12c75e1e5a489e3bb9dd26cd5e37e85109f588792f4776e6d7ee61ecb21a', True, True, True, True, True, True, null, 2, 2, 45, 1, '01-08-2025'),
('lvaler@pcm.gob.pe', 'scrypt:32768:8:1$aDkj3nFyaBU1xCpz$ebd75029e7932c1569e351ebed1910af7fe47cbc2fcd89d7238557fc5845c7625e14754f373704d004e9675a196d6b020bb488fca456009b828fb0db28fb9bd4', True, True, True, True, True, True, null, 3, 6, 45, 1, '01-08-2025'),
('mfloresh@pcm.gob.pe', 'scrypt:32768:8:1$RhEjqzN2dHk7Zn4e$ee7402882ca399c5a24b818cab9c86d427a5e20d59b844f88457838597f79266c9ed253568e25c999653efa6c101c9fff4e0f70f8d02940be1cd5800de1f6ad4', True, False, True, True, False, False, null, 3, 3, 45, 1, '01-08-2025'),
('lrodriguez@pcm.gob.pe', 'scrypt:32768:8:1$R2VwxaFFqhLMZ2GZ$a87e56342ff475edd0d064fd6545100bcf88bbe062ae04a4be937db5cb236b3dba9d12c75e1e5a489e3bb9dd26cd5e37e85109f588792f4776e6d7ee61ecb21a', True, True, True, True, True, True, null, 3, 5, 45, 1, '21-11-2025');

SELECT * FROM ide.def_usuarios;

SELECT * FROM ide.dom_roles WHERE id > 5;

INSERT INTO ide.aso_usuarios_roles(id_usuario, id_rol, usuario_registro, fecha_registro) VALUES
(2, 6, 1, '20-03-2026'),
(2, 7, 1, '20-03-2026'),
(2, 8, 1, '20-03-2026'),
(2, 9, 1, '20-03-2026'),
(2, 10, 1, '20-03-2026'),
(2, 11, 1, '20-03-2026'),
(2, 12, 1, '20-03-2026'),
(2, 13, 1, '20-03-2026'),
(2, 14, 1, '20-03-2026'),
(2, 15, 1, '20-03-2026');



