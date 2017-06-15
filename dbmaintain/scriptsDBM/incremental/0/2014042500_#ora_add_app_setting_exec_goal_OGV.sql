insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'allow_exec_goal_in_OGV','Разрешить запрос за результатом в ОГВ', '1', null);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'allow_exec_goal_in_OGV','Разрешить запрос за результатом в ОГВ', '1', hibernate_sequence.nextval, owner FROM org_unit;