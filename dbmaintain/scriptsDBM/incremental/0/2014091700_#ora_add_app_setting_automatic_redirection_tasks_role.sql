insert into app_setting (id, owner,setting_id,setting_name, setting_value, setting_group) values(hibernate_sequence.nextval, null,'automatic_redirection_tasks_role','Роль для контролера при автоматическом распределении дел', 'Director', 'Общие');


INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'automatic_redirection_tasks_role','Роль для контролера при автоматическом распределении дел', 'Director', hibernate_sequence.nextval, owner, 'Общие' FROM org_unit;