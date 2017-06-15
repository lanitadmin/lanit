insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
values ('person_check_valid_snils', '0-не проверять,1-проверять по контрольной сумме', '1', nextval('hibernate_sequence'), null, 'Физ. лица');
