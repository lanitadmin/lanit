INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rep_url_charge_list', 'Путь к печатной форме журнала реестра начислений (через ; имя шаблона)', '&__locale=ru_RU&__format=XLS&__report=gisgmp/charge_list.rptdesign;Реестр начислений', nextval('hibernate_sequence'), NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'rep_url_charge_list', 'Путь к печатной форме журнала реестра начислений (через ; имя шаблона)', '&__locale=ru_RU&__format=XLS&__report=gisgmp/charge_list.rptdesign;Реестр начислений', nextval('hibernate_sequence'),owner from org_unit;
