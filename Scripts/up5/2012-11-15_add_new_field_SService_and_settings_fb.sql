INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED,FIELD_READONLY)
VALUES (gen_id( hibernate_sequence, 1 ),'repoServiceId','string',1,'Код в репозитарии',31,null,'SService',0,1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED,FIELD_READONLY)
VALUES (gen_id( hibernate_sequence, 1 ),'repoUrl','string',1,'Адрес репозитария',255,null,'SService',0,1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED,FIELD_READONLY)
VALUES (gen_id( hibernate_sequence, 1 ),'repoServiceVer','integer',1,'Версия в репозитарии',0,null,'SService',0,1);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('wssecurity.keyStoreAlias', 'wssecurity.keyStoreAlias', 'test1', gen_id( hibernate_sequence, 1 ), NULL, 0);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('repo_service_is_reestr', 'Признак реестра услуг', '', gen_id( hibernate_sequence, 1 ), NULL, 0);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('repo_service_url', 'Адрес реестра услуг', '', gen_id( hibernate_sequence, 1 ), NULL, 0);

update APP_SETTING
set is_pass=1
where SETTING_ID in ('wssecurity.keyStorePassword','wssecurity.trustStoreType');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('repo_service_report_email', 'Адрес почты на который отправлять отчет', '', gen_id( hibernate_sequence, 1 ), NULL, 0);
