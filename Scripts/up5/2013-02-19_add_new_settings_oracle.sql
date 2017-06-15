INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('inquirer_quality_service', 'Опросник качества услуг', null, hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'inquirer_quality_service', 'Опросник качества услуг', null, hibernate_sequence.nextval, owner FROM org_unit;