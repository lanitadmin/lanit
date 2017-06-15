insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(hibernate_sequence.nextval, null,'check_certificate','Проверка сертификата посредством веб-сервиса (1 - да, 0 - нет)', '0', null, 'Общие');

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'check_certificate','Проверка сертификата посредством веб-сервиса (1 - да, 0 - нет)', '0', hibernate_sequence.nextval, owner, 'Общие' FROM org_unit;