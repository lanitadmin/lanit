insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'integration_queue_allow_ext_auth','Включить авторизацию на внешнем сервисе', '0', false, 'Интеграция с электронной очередью');

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'integration_queue_allow_ext_auth','Включить авторизацию на внешнем сервисе', '0', nextval('hibernate_sequence'), owner, 'Интеграция с электронной очередью' FROM org_unit;