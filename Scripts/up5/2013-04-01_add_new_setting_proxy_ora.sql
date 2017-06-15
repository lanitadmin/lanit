INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_use', 'Включить авторизацию прокси сервера', '0', hibernate_sequence.nextval, NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_user', 'Авторизация прокси сервера: логин', '', hibernate_sequence.nextval, NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_password', 'Авторизация прокси сервера: пароль', '', hibernate_sequence.nextval, NULL);
