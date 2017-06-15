insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select nextval('hibernate_sequence'), ou.owner,'integration_queue_ext_service_webserver_host','IP вебсервиса получения услуг ВИС', '', false, 'Интеграция с электронной очередью'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select nextval('hibernate_sequence'), ou.owner,'integration_queue_ext_owner','код орг. единицы ВИС', '', false, 'Интеграция с электронной очередью'  from org_unit ou;


