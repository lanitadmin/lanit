--Добавление права на удаление  вложения из репозитария
INSERT INTO PERMISSION_REF (ID, AOBJECT, AACTION, ADD_CHECK) 
VALUES (hibernate_sequence.nextval, 'МФЦ хранилище', 'удалять файл', NULL);