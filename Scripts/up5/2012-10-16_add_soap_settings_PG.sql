delete from app_setting where SETTING_ID like 'soap.%';

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_keyStoreType', 'Тип хранилища', 'HDImageStore', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_crypto_keyStoreType','Тип хранилища','HDImageStore',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_alias', 'Алиас ключа', 'test', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_crypto_alias','Алиас ключа','test',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_password', 'Пароль на хранилище', '123456', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_crypto_password','Пароль на хранилище','123456',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_wss4j_actor', 'actor', 'http://smev.gosuslugi.ru/actors/smev', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_wss4j_actor','actor','http://smev.gosuslugi.ru/actors/smev',nextval('hibernate_sequence'),owner from org_unit;



INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_keyStoreType2', 'Тип хранилища (XML, ZIP)', 'HDImageStore', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_crypto_keyStoreType2','Тип хранилища (XML, ZIP)','HDImageStore',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_alias2', 'Алиас ключа (XML, ZIP)', 'test', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_crypto_alias2','Алиас ключа (XML, ZIP)','test',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_password2', 'Пароль на хранилище (XML, ZIP)', '123456', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_crypto_password2','Пароль на хранилище (XML, ZIP)','123456',nextval('hibernate_sequence'),owner from org_unit;



INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_SenderCode', 'Sender Code', '', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_smev_SenderCode','Sender Code','',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_SenderName', 'Sender Name', '', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_smev_SenderName','Sender Name','',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_OriginatorCode', 'Originator Code', '', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_smev_OriginatorCode','Originator Code','',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_OriginatorName', 'Originator Name', '', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_smev_OriginatorName','Originator Name','',nextval('hibernate_sequence'),owner from org_unit;



INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_provider', 'Криптопровайдер (JCP, ViPNetJCP)', 'JCP', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_provider_vipnet_path', 'Путь к хранилищу контейнеров для ViPNetJCP', '', nextval('hibernate_sequence'), NULL);
