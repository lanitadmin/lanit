insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'allow_auto_collect_data','Разрешить сбор данных отчетности через планировку', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'allow_auto_collect_data','Разрешить сбор данных отчетности через планировку', '0', 0  from org_unit ou;