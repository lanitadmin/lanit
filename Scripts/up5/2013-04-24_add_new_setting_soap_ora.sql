INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_type_sign_mode', 'Подпись автоматическая/ручная (1 - по умолчанию, 2 - автоматическая, 3 - ручная)', '1', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_type_sign_mode', 'Подпись автоматическая/ручная (1 - по умолчанию, 2 - автоматическая, 3 - ручная)', '1', hibernate_sequence.nextval, owner FROM org_unit;