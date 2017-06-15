insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
values(nextval('hibernate_sequence'), null,'period_state_free_window','Период опроса функции «Свободное окно» (в сек.)', '30', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select nextval('hibernate_sequence'), ou.owner,'period_state_free_window','Период опроса функции «Свободное окно» (в сек.)', '30', false  from org_unit ou;