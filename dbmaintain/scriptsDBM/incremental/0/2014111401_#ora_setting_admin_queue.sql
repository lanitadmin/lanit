insert into app_setting (id, owner, setting_id, setting_name, is_pass, setting_group)
values hibernate_sequence.nextval, null,'integration_queue_role_admin_code','Роль администратора зала', 0, 'Интеграция с электронной очередью');

insert into app_setting (id, owner, setting_id, setting_name, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'integration_queue_role_admin_code','Роль администратора зала' , 0 ,'Интеграция с электронной очередью' from org_unit ou;