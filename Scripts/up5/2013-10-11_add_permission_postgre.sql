--Добавление права на предварительную запись
INSERT INTO PERMISSION_REF (ID, AOBJECT, AACTION, ADD_CHECK)
VALUES (nextval('hibernate_sequence'), 'Предвар.Запись', 'разрешена', NULL);