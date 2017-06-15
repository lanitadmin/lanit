INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'app_enternal_url', 'Адрес по которому приложение доступно для внешних систем', '', hibernate_sequence.nextval, owner from org_unit;


INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('app_enternal_url', 'Адрес по которому приложение доступно для внешних систем', '', hibernate_sequence.nextval, null);