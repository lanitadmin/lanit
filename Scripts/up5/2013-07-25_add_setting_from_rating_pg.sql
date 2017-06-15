INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_rating_mode', 'Режим передачи оценок(0 - в МКГУ, 1 - в УМФЦ)', '0', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_rating_umfc_host', 'IP хоста УМФЦ', '', nextval('hibernate_sequence'), NULL);