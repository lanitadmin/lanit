--Добавление поля description для картотеки "категории заявителей"
INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED) 
VALUES (gen_id( hibernate_sequence, 1 ), 'description', 'string', 1, 'Описание', 1000, NULL, 'SZType', NULL);