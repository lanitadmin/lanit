insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'is_turn_on_check_busy_window','Проверка на то, свободно ли окно, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'is_turn_on_check_busy_window','Проверка на то, свободно ли окно, 1-да, 0-нет', '0', false  from org_unit ou;