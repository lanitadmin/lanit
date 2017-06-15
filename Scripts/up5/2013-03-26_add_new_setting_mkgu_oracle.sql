INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_uri_send_rating', 'URI сервиса отправки оценок в МКГУ', 'http://dev.vashkontrol.ru/hershel/rates', hibernate_sequence.nextval, NULL);


INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('mkgu_uri_status_rating', 'URI сервиса получения статуса заявки в МКГУ', 'http://dev.vashkontrol.ru/hershel/check-packet/', hibernate_sequence.nextval, NULL);


INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('theme_rt', 'Тема оформления планшета', null, hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'theme_rt', 'Тема оформления планшета', null, hibernate_sequence.nextval, owner FROM org_unit;
