alter table SOAP_CONTEXT_VAR drop column stringValue;
update SOAP_OPTIONS_VAR set mode_param='in' where mode_param is null;
update soap_context set testRun=0 where testRun is null;
update soap_context set complete=0 where complete is null;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_soap_timer_period', 'Таймер обработки soap-запросов', '30', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'send_soap_timer_period', 'Таймер обработки soap-запросов', '30', hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.crypto.keyStoreType', 'Тип хранилища', 'HDImageStore', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.crypto.keyStoreType','Тип хранилища','HDImageStore',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.crypto.alias', 'Алиас ключа', 'test', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.crypto.alias','Алиас ключа','test',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.crypto.password', 'Пароль на хранилище', '123456', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.crypto.password','Пароль на хранилище','123456',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.wss4j.actor', 'actor', 'http://smev.gosuslugi.ru/actors/smev', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.wss4j.actor','actor','http://smev.gosuslugi.ru/actors/smev',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Sender_Code', 'Sender Code', 'a1', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Sender_Code','Sender Code','a2',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Sender_Name', 'Sender Name', 'b1', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Sender_Name','Sender Name','b2',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Originator_Code', 'Originator Code', 'c1', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Originator_Code','Originator Code','c2',hibernate_sequence.nextval,owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap.smev.Originator_Name', 'Originator Name', 'd1', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap.smev.Originator_Name','Originator Name','d2',hibernate_sequence.nextval,owner from org_unit;