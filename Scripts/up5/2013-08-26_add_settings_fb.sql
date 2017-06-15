INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('ogv_boss_name_dative', 'Инициалы и фамилия начальника ОГВ в дательном падеже', '',gen_id(hibernate_sequence, 1), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'ogv_boss_name_dative', 'Инициалы и фамилия начальника ОГВ в дательном падеже', '',gen_id(hibernate_sequence, 1),owner from org_unit;
