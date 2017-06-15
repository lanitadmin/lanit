insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values (nextval('hibernate_sequence'), null,'allow_auto_collect_data','Разрешить сбор данных отчетности через планировку', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select  nextval('hibernate_sequence'), ou.owner,'allow_auto_collect_data','Разрешить сбор данных отчетности через планировку', '0', false  from org_unit ou;