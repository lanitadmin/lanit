--Добавление права на предварительную запись
INSERT INTO PERMISSION_REF (ID, AOBJECT, AACTION, ADD_CHECK)
VALUES (hibernate_sequence.nextval, 'Предвар.Запись', 'разрешена', NULL);