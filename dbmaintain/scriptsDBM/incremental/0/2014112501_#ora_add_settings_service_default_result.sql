insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'service_code_result_transfer','Код универсальной услуги для выдачи результата', '', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'service_code_result_transfer','Код универсальной услуги для выдачи результата', '', 0  from org_unit ou;
