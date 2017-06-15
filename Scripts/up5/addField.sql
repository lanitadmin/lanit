--1)добавление дополнительного поля      'тип услуги' в картотеку услуга, поле не обязательно для заполения, если тип услуги =1 то используется старый механизм, если 0 или null то новый
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (gen_id( hibernate_sequence, 1 ),'ServiceType','integer',1,'Тип услуги',2,null,'SService');
--2)наполение
INSERT INTO CARD_ELEMENT_FIELD_VALUE (ID, FIELD_STRING_VALUE,FIELD_DATE_VALUE,FIELD_INTEGER_VALUE,FIELD_ID,CARD_ELEMENT_ID, VERSION)
SELECT gen_id( hibernate_sequence, 1 ), null, null, 1, (select field_id from CARD_FIELD where  card_code = 'SService' and field_name = 'ServiceType'), c.id,
null  FROM CARD_ELEMENT c WHERE c.CARD_CODE = 'SService'