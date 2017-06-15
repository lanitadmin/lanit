--1)добавление дополнительного поля  'regex_series' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'regex_series', 'string',true,'Валидация серии документа (Regex)',0,1,'STypeDocUL');

--2)добавление дополнительного поля  'mess_validator_series' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'mess_validator_series', 'string',true,'Текст сообщения при неправильном вводе серии',0,2,'STypeDocUL');

--3)добавление дополнительного поля  'regex_number' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'regex_number', 'string',true,'Валидация номера документа (Regex)',0,3,'STypeDocUL');

--4)добавление дополнительного поля  'mess_validator_num' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'mess_validator_num', 'string',true,'Текст сообщения при неправильном вводе номера',0,4,'STypeDocUL');