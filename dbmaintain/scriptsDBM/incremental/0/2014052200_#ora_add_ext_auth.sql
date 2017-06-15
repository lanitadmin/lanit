insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(hibernate_sequence.nextval, null,'integration_queue_allow_ext_auth','Включить авторизацию на внешнем сервисе', '0', 0, 'Интеграция с электронной очередью');

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'integration_queue_allow_ext_auth','Включить авторизацию на внешнем сервисе', '0', hibernate_sequence.nextval, owner, 'Интеграция с электронной очередью' FROM org_unit;