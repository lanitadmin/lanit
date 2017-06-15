INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_rating_mode', 'Режим передачи оценок(0 - в МКГУ, 1 - в УМФЦ)', '0', gen_id(hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_rating_umfc_host', 'IP хоста УМФЦ', '', gen_id(hibernate_sequence, 1), NULL);