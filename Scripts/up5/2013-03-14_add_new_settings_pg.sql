INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_adapter_code', 'Код адаптера для проверки статуса паспорта', 'sid0003418', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_adapter_code', 'Код адаптера для проверки статуса паспорта', 'sid0003418', nextval('hibernate_sequence'), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_status_code', 'Код аттрибута статуса паспорта', 'passportStatus', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_status_code', 'Код аттрибута статуса паспорта', 'passportStatus', nextval('hibernate_sequence'), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_adapter_attr_code_complience', 'Соответствие аттрибутов кодов', 'passSeria,DOC_SERIE;passNo,DOC_NUMBER;passDate,DOC_ISSUEDATE;isCheckPassport,isCheckPassport;', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_adapter_attr_code_complience', 'Соответствие аттрибутов кодов', 'passSeria,DOC_SERIE;passNo,DOC_NUMBER;passDate,DOC_ISSUEDATE;isCheckPassport,isCheckPassport;', nextval('hibernate_sequence'), owner FROM org_unit;



