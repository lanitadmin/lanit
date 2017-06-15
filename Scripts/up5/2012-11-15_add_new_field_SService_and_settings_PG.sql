--1)добавление дополнительного поля      'тип услуги' в картотеку услуга, поле не обязательно для заполения, если тип услуги =1 то используется старый механизм, если 0 или null то новый
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED,FIELD_READONLY)
VALUES (nextval('hibernate_sequence'),'repoServiceId','string',true,'Код в репозитарии',31,null,'SService',false,true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED,FIELD_READONLY)
VALUES (nextval('hibernate_sequence'),'repoUrl','string',true,'Адрес репозитария',255,null,'SService',false,true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED,FIELD_READONLY)
VALUES (nextval('hibernate_sequence'),'repoServiceVer','integer',true,'Версия в репозитарии',0,null,'SService',false,true);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('wssecurity.keyStoreAlias', 'wssecurity.keyStoreAlias', 'test1', nextval('hibernate_sequence'), NULL, false);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('repo_service_is_reestr', 'Признак реестра услуг', '', nextval('hibernate_sequence'), NULL, false);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('repo_service_url', 'Адрес реестра услуг', '', nextval('hibernate_sequence'), NULL, false);

update APP_SETTING
set is_pass=true
where SETTING_ID in ('wssecurity.keyStorePassword','wssecurity.trustStoreType');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, is_pass)
VALUES ('repo_service_report_email', 'Адрес почты на который отправлять отчет', '', nextval('hibernate_sequence'), NULL, false);
