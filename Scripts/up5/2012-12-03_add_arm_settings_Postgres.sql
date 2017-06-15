INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
 VALUES ('arm_webservice_timeout', 'Время обработки запроса', '180000', nextval('hibernate_sequence'), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
 VALUES ('arm_webservice_timeout_min', 'Время обработки запроса, кроме процесса синхронизации', '60000', nextval('hibernate_sequence'), NULL);


