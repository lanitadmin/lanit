alter table SOAP_CONTEXT_VAR drop column stringValue;
update SOAP_OPTIONS_VAR set mode_param='in' where mode_param is null;
update soap_context set testRun=false where testRun is null;
update soap_context set complete=false where complete is null;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_soap_timer_period', 'Таймер обработки soap-запросов', '30', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'send_soap_timer_period', 'Таймер обработки soap-запросов', '30', nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.crypto.keyStoreType', 'Тип хранилища', 'HDImageStore', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.crypto.keyStoreType','Тип хранилища','HDImageStore',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.crypto.alias', 'Алиас ключа', 'test', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.crypto.alias','Алиас ключа','test',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.crypto.password', 'Пароль на хранилище', '123456', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.crypto.password','Пароль на хранилище','123456',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.wss4j.actor', 'actor', 'http://smev.gosuslugi.ru/actors/smev', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.wss4j.actor','actor','http://smev.gosuslugi.ru/actors/smev',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Sender_Code', 'Sender Code', 'a1', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Sender_Code','Sender Code','a2',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Sender_Name', 'Sender Name', 'b1', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Sender_Name','Sender Name','b2',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Originator_Code', 'Originator Code', 'c1', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Originator_Code','Originator Code','c2',nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Originator_Name', 'Originator Name', 'd1', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Originator_Name','Originator Name','d2',nextval('hibernate_sequence'),owner from org_unit;