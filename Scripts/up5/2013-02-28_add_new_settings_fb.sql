INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_rating_timer_period', 'Таймер оценок в МКГУ', null, gen_id( hibernate_sequence, 1), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'send_rating_timer_period', 'Таймер оценок в МКГУ', null, gen_id( hibernate_sequence, 1), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_mkgu_id', 'Идентификатор в ИАС МКГУ', null, gen_id( hibernate_sequence, 1), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_mkgu_id', 'Идентификатор в ИАС МКГУ', null, gen_id( hibernate_sequence, 1), owner FROM org_unit;