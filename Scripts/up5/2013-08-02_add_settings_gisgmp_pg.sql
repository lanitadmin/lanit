INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('integration_gisgmp', 'Интеграция с ГИС ГМП (0-выкл, 1-вкл)', '0', nextval('hibernate_sequence'), null);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'integration_gisgmp', 'Интеграция с ГИС ГМП (0-выкл, 1-вкл)', '0', nextval('hibernate_sequence'), OWNER FROM ORG_UNIT;