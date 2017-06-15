INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('view_test_doc_pack', 'Видимость чекбокса "Показать тестовые пакеты документов" (0 - выключить, 1 - включить)', '1', hibernate_sequence.NEXTVAL, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'view_test_doc_pack', 'Видимость чекбокса "Показать тестовые пакеты документов" (0 - выключить, 1 - включить)', '1', hibernate_sequence.NEXTVAL, owner from org_unit;