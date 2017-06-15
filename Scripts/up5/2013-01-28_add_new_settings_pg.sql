INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_snils_adapter_code', 'Код адаптера для получения СНИЛС', 'SID0003619', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_snils_adapter_code', 'Код адаптера для получения СНИЛС', 'SID0003619', nextval('hibernate_sequence'), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_snils_code', 'Код аттрибута СНИЛС', 'SNILS', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_snils_code', 'Код аттрибута СНИЛС', 'SNILS', nextval('hibernate_sequence'), owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_snils_adapter_attr_code_complience', 'Соответствие аттрибутов кодов', 'FirstName,FirstName;MiddleName,SecondName;LastName,Patronymic;Sex,Gender;BirthDate,BirthDate;', nextval('hibernate_sequence'), NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_snils_adapter_attr_code_complience', 'Соответствие аттрибутов кодов', 'FirstName,FirstName;MiddleName,SecondName;LastName,Patronymic;Sex,Gender;BirthDate,BirthDate;', nextval('hibernate_sequence'), owner FROM org_unit;
