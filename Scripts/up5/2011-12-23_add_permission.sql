--Добавление права на удаление  вложения из репозитария
INSERT INTO PERMISSION_REF (ID, AOBJECT, AACTION, ADD_CHECK) VALUES (gen_id(hibernate_sequence, 1), 'МФЦ хранилище', 'удалять файл', NULL);