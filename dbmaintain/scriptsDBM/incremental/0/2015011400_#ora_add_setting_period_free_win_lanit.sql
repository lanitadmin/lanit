insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
values(hibernate_sequence.nextval, null,'period_state_free_window','Период опроса функции «Свободное окно» (в сек.)', '30', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select hibernate_sequence.nextval, ou.owner,'period_state_free_window','Период опроса функции «Свободное окно» (в сек.)', '30', 0  from org_unit ou;