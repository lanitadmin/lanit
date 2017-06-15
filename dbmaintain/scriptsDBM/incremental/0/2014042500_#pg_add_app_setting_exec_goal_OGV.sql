insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'send_auto_service_start_time','Время начала сбора информации для ФОИВ (с 0 до 24 ч)', '19', null);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'allow_exec_goal_in_OGV','Разрешить запрос за результатом в ОГВ', '1', nextval('hibernate_sequence'), owner FROM org_unit;