INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('integration_gisgmp', 'Интеграция с ГИС ГМП (0-выкл, 1-вкл)', '0', gen_id(hibernate_sequence, 1), null);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'integration_gisgmp', 'Интеграция с ГИС ГМП (0-выкл, 1-вкл)', '0', gen_id(hibernate_sequence, 1), OWNER FROM ORG_UNIT;