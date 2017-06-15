INSERT INTO CARD_FIELD (FIELD_ID, FIELD_CAPTION, FIELD_NAME, FIELD_SIZE, FIELD_TYPE, FIELD_VISIBLE, CARD_CODE)
VALUES (nextval('hibernate_sequence'), 'Отображать услугу в ЕЦУ', 'ecuShow', '2', 'list:integer=0,да;1,нет', 'true', 'SService');

UPDATE CARD_FIELD
SET FIELD_CAPTION='Отображать услугу в ИК и на портале', FIELD_TYPE='list:integer=1,нет;0,да'
WHERE FIELD_NAME='IkShow' AND CARD_CODE = 'SService';