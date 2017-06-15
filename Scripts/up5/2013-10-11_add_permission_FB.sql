--Добавление права на предварительную запись
INSERT INTO PERMISSION_REF (ID, AOBJECT, AACTION, ADD_CHECK) VALUES (gen_id(hibernate_sequence, 1), 'Предвар.Запись', 'разрешена', NULL);