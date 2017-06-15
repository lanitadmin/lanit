INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
	VALUES (nextval('hibernate_sequence'), null, 'number_request_provider', 'Нумерация запросов, вызванных через поставщика (0 - нет, 1 - да)', '1', false, '');

INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner, 'number_request_provider','Нумерация запросов, вызванных через поставщика (0 - нет, 1 - да)', '1', false, ''  from org_unit ou;