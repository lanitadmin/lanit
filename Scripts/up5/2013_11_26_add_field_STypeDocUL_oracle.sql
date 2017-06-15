--1)добавление дополнительного поля  'regex_series' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'regex_series', 'string',1,'Валидация серии документа (Regex)',0,1,'STypeDocUL');

--2)добавление дополнительного поля  'mess_validator_series' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'mess_validator_series', 'string',1,'Текст сообщения при неправильном вводе серии',0,2,'STypeDocUL');

--3)добавление дополнительного поля  'regex_number' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'regex_number', 'string',1,'Валидация номера документа (Regex)',0,3,'STypeDocUL');

--4)добавление дополнительного поля  'mess_validator_num' в справочник  STypeDocUL (тип док-а, удост личность)
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'mess_validator_num', 'string',1,'Текст сообщения при неправильном вводе номера',0,4,'STypeDocUL');