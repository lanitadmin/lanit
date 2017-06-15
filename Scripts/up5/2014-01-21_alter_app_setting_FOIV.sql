INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_group_adapter_attr_code_complience','Соответствие атрибутов кодов', 'passSeria,DOC_SERIE;passNo,DOC_NUMBER;passDate,DOC_ISSUEDATE;birthdate,CITIZEN_BIRTHDAY;firstName,CITIZEN_FIRSTNAME;givenName,CITIZEN_GIVENNAME;lastName,CITIZEN_LASTNAME;snils,CITIZEN_SNILS', nextval('hibernate_sequence'), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_group_adapter_attr_code_complience', 'Соответствие атрибутов кодов', 'passSeria,DOC_SERIE;passNo,DOC_NUMBER;passDate,DOC_ISSUEDATE;birthdate,CITIZEN_BIRTHDAY;firstName,CITIZEN_FIRSTNAME;givenName,CITIZEN_GIVENNAME;lastName,CITIZEN_LASTNAME;snils,CITIZEN_SNILS', nextval('hibernate_sequence'), NULL);




INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_status_group_registration','Код атрибута регистрации', 'registration', nextval('hibernate_sequence'), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_status_group_registration', 'Код атрибута регистрации', 'registration', nextval('hibernate_sequence'), NULL);


update APP_SETTING set SETTING_VALUE = 'Срок актуальности персональных даных при автоматическом сборе информации (дней)' where SETTING_ID = 'send_auto_service_timer_period'

update APP_SETTING set SETTING_VALUE = 'Интервал вызовов адатеров при автомматическом сборе (мин)' where SETTING_ID = 'auto_collect_timer_period'
