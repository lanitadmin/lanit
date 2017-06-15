INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_use', 'Включить авторизацию прокси сервера', '0', gen_id(hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_user', 'Авторизация прокси сервера: логин', '', gen_id(hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('proxy_password', 'Авторизация прокси сервера: пароль', '', gen_id(hibernate_sequence, 1), NULL);
