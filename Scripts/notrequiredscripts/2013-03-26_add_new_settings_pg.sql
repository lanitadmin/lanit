INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('welcomePage', 'Страница приветствия', 'public/login.seam', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'welcomePage', 'Страница приветствия', 'public/login.seam', nextval('hibernate_sequence'), owner FROM org_unit;


