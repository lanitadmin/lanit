INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('require_gen_id_element', 'Автоматическая генерация Id элементов справочника (0 - выключить, 1 - включить)', '1', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'require_gen_id_element', 'Автоматическая генерация Id элементов справочника (0 - выключить, 1 - включить)', '1', nextval('hibernate_sequence'), owner from org_unit;
