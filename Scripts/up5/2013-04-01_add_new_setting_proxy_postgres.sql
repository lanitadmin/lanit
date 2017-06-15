INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_use', 'Включить авторизацию прокси сервера', '0', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_user', 'Авторизация прокси сервера: логин', '', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_password', 'Авторизация прокси сервера: пароль', '', nextval('hibernate_sequence'), NULL);
