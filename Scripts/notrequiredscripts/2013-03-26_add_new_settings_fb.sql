INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('welcomePage', 'Страница приветствия', 'public/infoportal.seam', gen_id( hibernate_sequence, 1), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'welcomePage', 'Страница приветствия', 'public/infoportal.seam', gen_id( hibernate_sequence, 1), owner FROM org_unit;