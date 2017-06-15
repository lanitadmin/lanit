INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('smtp_starttls_enable', 'Использовать протокол TLS', '0', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'smtp_starttls_enable', 'Использовать протокол TLS', '0', nextval('hibernate_sequence'), owner FROM org_unit;


