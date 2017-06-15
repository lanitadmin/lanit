insert into app_setting (id, owner, setting_id, setting_name, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'integration_queue_role_admin_code','Роль администратора зала', false, 'Интеграция с электронной очередью');

insert into app_setting (id, owner, setting_id, setting_name, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'integration_queue_role_admin_code','Роль администратора зала' , false ,'Интеграция с электронной очередью' from org_unit ou;