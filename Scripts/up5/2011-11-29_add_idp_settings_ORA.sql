INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('idp_server_use', 'IdP сервер. Использовать IdP сервер для идентификации', '1', hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('idp_server_attr_login', 'IdP сервер. Свойство, в котором находится СНИЛС', NULL, hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('idp_server_attr_show', 'IdP сервер. Показывать атрибуты пользователя', '0', hibernate_sequence.nextval, NULL);

commit;
