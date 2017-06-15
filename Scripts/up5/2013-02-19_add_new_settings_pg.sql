INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('inquirer_quality_service', 'Опросник качества услуг', null, nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'inquirer_quality_service', 'Опросник качества услуг', null, nextval('hibernate_sequence'), owner FROM org_unit;