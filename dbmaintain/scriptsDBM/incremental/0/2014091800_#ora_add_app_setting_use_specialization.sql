insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(hibernate_sequence.nextval, null,'automatic_redirection_tasks_use_specialization','Использовать специализацию контроллеров при автоматическом распределении дел с приема на контроль  (0-выкл, 1-вкл.)', '0', null, 'Общие');
INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'automatic_redirection_tasks_use_specialization','Использовать специализацию контроллеров при автоматическом распределении дел с приема на контроль (0-выкл, 1-вкл.)', '0', hibernate_sequence.nextval, owner, 'Общие' FROM org_unit;