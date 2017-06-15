insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'service_code_result_transfer','Код универсальной услуги для выдачи результата', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'service_code_result_transfer','Код универсальной услуги для выдачи результата', '', false  from org_unit ou;
