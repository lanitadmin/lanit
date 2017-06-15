--Добавление права на удаление  вложения из репозитария
INSERT INTO PERMISSION_REF (ID, AOBJECT, AACTION, ADD_CHECK) 
VALUES (nextval('hibernate_sequence'), 'МФЦ хранилище', 'удалять файл', NULL);