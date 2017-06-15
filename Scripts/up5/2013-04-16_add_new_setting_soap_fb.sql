INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_get_data_for_sign_from', 'Брать данные для подписи (1 - по умолчанию, 2-адаптер, 3-настройки)', '1', gen_id(hibernate_sequence, 1), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_get_data_for_sign_from', 'Брать данные для подписи (1 - по умолчанию, 2-адаптер, 3-настройки)', '1', gen_id(hibernate_sequence, 1), owner FROM org_unit;