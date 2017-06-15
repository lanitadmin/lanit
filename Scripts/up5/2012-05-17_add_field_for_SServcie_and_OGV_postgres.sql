--1)добавление дополнительного поля  'IkShow' в картотеку услуга, поле не обязательно для заполения
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'IkShow', 'list:integer=0,да;1,нет',true,'Отображать в инфокиоске',2,null,'SService');
--2)добавление дополнительного поля  'IkShow' в картотеку органы госудастрвенный власти, поле не обязательно для заполения
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'IkShow', 'list:integer=0,да;1,нет',true,'Отображать в инфокиоске',2,null,'SGosOrg');