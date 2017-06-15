
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('can_start_auto_service', 'Возможность использовать автоматический сбор информации ФОИВ', '0', hibernate_sequence.nextval, NULL);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_group_adapter_code', 'Код адаптера для проверки статуса паспорта', 'SID0003418group', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_group_adapter_code', 'Код адаптера для проверки статуса паспорта', 'SID0003418group', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_status_group_code', 'Код аттрибута статуса паспорта', 'passportStatus', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_status_group_code', 'Код аттрибута статуса паспорта', 'passportStatus', hibernate_sequence.nextval, owner FROM org_unit;



INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('auto_collect_timer_period', 'Интервал вызово адатеров при автомматическом сборе', '4', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'auto_collect_timer_period','Интервал вызовов адатеров при автомматическом сборе', '4', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'send_auto_service_timer_period','Срок актуальности персональных даных при автоматическом сборе информации', '180', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_auto_service_timer_period', 'Срок актуальности персональных даных при автоматическом сборе информации', '180', hibernate_sequence.nextval, NULL);




INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_group_adapter_attr_code_complience','Соответствие атрибутов кодов', 'passSeria,DOC_SERIE;passNo,DOC_NUMBER;passDate,DOC_ISSUEDATE;birthdate,CITIZEN_BIRTHDAY;firstName,CITIZEN_FIRSTNAME;givenName,CITIZEN_GIVENNAME;lastName,CITIZEN_LASTNAME;snils,CITIZEN_SNILS', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_group_adapter_attr_code_complience', 'Соответствие атрибутов кодов', 'passSeria,DOC_SERIE;passNo,DOC_NUMBER;passDate,DOC_ISSUEDATE;birthdate,CITIZEN_BIRTHDAY;firstName,CITIZEN_FIRSTNAME;givenName,CITIZEN_GIVENNAME;lastName,CITIZEN_LASTNAME;snils,CITIZEN_SNILS', hibernate_sequence.nextval);




INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_check_passport_status_group_registration','Код атрибута регистрации', 'registration', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_check_passport_status_group_registration', 'Код атрибута регистрации', 'registration', hibernate_sequence.nextval, NULL);