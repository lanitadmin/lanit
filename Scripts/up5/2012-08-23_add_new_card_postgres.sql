INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SRegDoc', 'Нормативные документы', 'Услуги', NULL);
INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SRelDocMFC', 'Нормативные документы МФЦ', 'Услуги', NULL);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'), 'docAttach', 'attachment', true, 'Приложение', 2048, NULL, 'SRegDoc', NULL);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'), 'docAttach', 'attachment', true, 'Приложение', 2048, NULL, 'SRelDocMFC', NULL);


INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'docDesc','string',true,'Описание',2000,null,'SRegDoc', NULL);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'docDesc','string',true,'Описание',2000,null,'SRelDocMFC', NULL);