-- Добавляет дополнительное поле "Шапка заявлений" для всех элементов справочника ОГВ
INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'), 'Header', 'string', true, 'Шапка заявлений', 1024, NULL, 'SGosOrg', NULL);