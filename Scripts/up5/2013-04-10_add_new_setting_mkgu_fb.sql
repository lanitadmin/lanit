INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_uri_current_form', 'URI текущей формы МКГУ', 'http://dev.vashkontrol.ru/hershel/current-form', gen_id(hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_prefixCodeInquirer', 'Префикс опросника МКГУ', 'mkgu_', gen_id(hibernate_sequence, 1), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_prefixNameInquirer', 'Префикс названия опросника МКГУ', 'МКГУ', gen_id(hibernate_sequence, 1), NULL);
