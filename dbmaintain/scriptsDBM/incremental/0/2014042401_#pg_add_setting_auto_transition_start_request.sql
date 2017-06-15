insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'auto_transition_start_request','Настройка автоматического перехода с шага запуска запросов, 1-есть, 0-нет', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'auto_transition_start_request','Настройка автоматического перехода с шага запуска запросов, 1-есть, 0-нет', '0', false  from org_unit ou;