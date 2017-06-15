INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('idp_server_use', 'IdP сервер. Использовать IdP сервер для идентификации', '0', gen_id( hibernate_sequence, 1), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('idp_server_attr_login', 'IdP сервер. Свойство, в котором находится СНИЛС', NULL, gen_id( hibernate_sequence, 1), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('idp_server_attr_show', 'IdP сервер. Показывать атрибуты пользователя', '0', gen_id( hibernate_sequence, 1), NULL);

commit;
