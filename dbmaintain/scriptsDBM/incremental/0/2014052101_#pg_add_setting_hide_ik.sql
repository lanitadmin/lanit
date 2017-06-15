insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'ik_hide_main_buttons','Скрывает кнопки по их названию, перечислять через ;', '', null, 'Инфокиоск');

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'ik_hide_main_buttons','Скрывает кнопки по их названию, перечислять через ;', '', nextval('hibernate_sequence'), owner, 'Инфокиоск' FROM org_unit;