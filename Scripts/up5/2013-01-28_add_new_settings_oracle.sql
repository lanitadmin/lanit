INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_snils_adapter_code', 'Код адаптера для получения СНИЛС', 'SID0003619', hibernate_sequence.nextval, NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_snils_adapter_code', 'Код адаптера для получения СНИЛС', 'SID0003619', hibernate_sequence.nextval, owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_snils_code', 'Код аттрибута СНИЛС', 'SNILS', hibernate_sequence.nextval, NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_snils_code', 'Код аттрибута СНИЛС', 'SNILS', hibernate_sequence.nextval, owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_snils_adapter_attr_code_complience', 'Соответствие аттрибутов кодов', 'FirstName,FirstName;MiddleName,SecondName;LastName,Patronymic;Sex,Gender;BirthDate,BirthDate;', hibernate_sequence.nextval, NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'soap_snils_adapter_attr_code_complience', 'Соответствие аттрибутов кодов', 'FirstName,FirstName;MiddleName,SecondName;LastName,Patronymic;Sex,Gender;BirthDate,BirthDate;', hibernate_sequence.nextval, owner from org_unit;