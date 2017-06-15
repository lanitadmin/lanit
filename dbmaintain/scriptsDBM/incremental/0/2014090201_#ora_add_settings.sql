insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'is_turn_on_check_busy_window','Проверка на то, свободно ли окно, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'is_turn_on_check_busy_window','Проверка на то, свободно ли окно, 1-да, 0-нет', '0', 0  from org_unit ou;