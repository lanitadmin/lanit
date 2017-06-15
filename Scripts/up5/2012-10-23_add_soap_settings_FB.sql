INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_auto_keyStoreType', 'Автоподпись. Тип хранилища', 'HDImageStore', gen_id( hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_crypto_auto_alias', 'Автоподпись. Алиас ключа', 'test', gen_id( hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
VALUES ('soap_crypto_auto_password', 'Автоподпись. Пароль на хранилище', '', gen_id( hibernate_sequence, 1), NULL, 1);