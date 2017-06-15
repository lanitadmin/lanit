INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
VALUES (hibernate_sequence.nextval, null, 'number_request_provider', 'Нумерация запросов, вызванных через поставщика (0 - нет, 1 - да)', '1', 0, '');

INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner, 'number_request_provider','Нумерация запросов, вызванных через поставщика (0 - нет, 1 - да)', '1', 0, ''  from org_unit ou;