INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'check_owner_home', 'проверка на редактирование элементов своей орг. единицы', '1', hibernate_sequence.nextval, owner from org_unit;


INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('check_owner_home', 'проверка на редактирование элементов своей орг. единицы', '1', hibernate_sequence.nextval, null);