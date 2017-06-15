INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rep_charge_list_file_name', 'Имя файла выгрузки реестра начислений в .xls', 'Реестр начислений.xls', nextval('hibernate_sequence'), NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'rep_charge_list_file_name', 'Имя файла выгрузки реестра начислений в .xls', 'Реестр начислений.xls',  nextval('hibernate_sequence'),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rep_payment_list_file_name', 'Имя файла при выгрузке реестра платежей .xls', 'Реестр платежей.xls', nextval('hibernate_sequence'), NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'rep_payment_list_file_name', 'Имя файла при выгрузке реестра платежей .xls', 'Реестр платежей.xls',  nextval('hibernate_sequence'),owner from org_unit;
