insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'integration_queue_ext_service_webserver_host','IP вебсервиса получения услуг ВИС', '', 0, 'Интеграция с электронной очередью'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'integration_queue_ext_owner','код орг. единицы ВИС', '', 0, 'Интеграция с электронной очередью'  from org_unit ou;


