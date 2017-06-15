insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'auto_transition_start_request','Настройка автоматического перехода с шага запуска запросов, 1-есть, 0-нет', '0', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'auto_transition_start_request','Настройка автоматического перехода с шага запуска запросов, 1-есть, 0-нет', '0', 0  from org_unit ou;