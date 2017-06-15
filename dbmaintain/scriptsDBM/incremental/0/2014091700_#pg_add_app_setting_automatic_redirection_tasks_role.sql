insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'automatic_redirection_tasks_role','Роль для контролера при автоматическом распределении дел', 'Director', null, 'Общие');


INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'automatic_redirection_tasks_role','Роль для контролера при автоматическом распределении дел', 'Director', nextval('hibernate_sequence'), owner, 'Общие' FROM org_unit;