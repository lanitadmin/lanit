INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
VALUES ('integration_fias', 'Интеграция с ФИАС', '1', nextval('hibernate_sequence'), NULL, false);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
VALUES ('fias_working_dir', 'рабочая директория при работе с ФИАС', '', nextval('hibernate_sequence'), NULL, false);
