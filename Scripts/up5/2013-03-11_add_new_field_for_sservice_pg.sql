INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'ProcedureId', 'string',true,'Идентификатор процедуры в ФРГУ',20,null,'SService');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rating_okato', 'Код окато', '36401000000', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'rating_okato', 'Код окато', '36401000000', nextval('hibernate_sequence'), owner FROM org_unit;
