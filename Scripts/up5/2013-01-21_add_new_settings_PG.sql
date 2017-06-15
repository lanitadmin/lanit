INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('eds_login_use', 'Использовать авторизацию через ЭЦП (1-да/0-нет)', '0', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_send_response_adapter_default', 'Адаптер (по умолчанию) для отправки ответа', NULL, nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_send_response_adapter', 'Адаптер для отправки ответа', NULL, nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_send_response_adapter', 'Адаптер для отправки ответа', NULL,nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_send_response_pack_id', 'Пакет XPDL через который идет отправка ответа', NULL , nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_send_response_pack_id', 'Пакет XPDL через который идет отправка ответа', NULL,nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_send_response_process_id', 'Процесс XPDL через который идет отправка ответа', NULL , nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_send_response_process_id', 'Процесс XPDL через который идет отправка ответа', NULL,nextval('hibernate_sequence'),owner from org_unit;
