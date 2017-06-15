INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_uri_current_form', 'URI текущей формы МКГУ', 'http://dev.vashkontrol.ru/hershel/current-form', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_prefixCodeInquirer', 'Префикс опросника МКГУ', 'mkgu_', nextval('hibernate_sequence'), NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_prefixNameInquirer', 'Префикс названия опросника МКГУ', 'МКГУ', nextval('hibernate_sequence'), NULL);
