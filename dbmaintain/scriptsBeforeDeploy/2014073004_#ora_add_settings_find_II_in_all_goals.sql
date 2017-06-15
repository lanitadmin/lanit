insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'find_integration_info_in_all_goals','Искать информация об электронной интеграции во всех целях, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'find_integration_info_in_all_goals','Искать информация об электронной интеграции во всех целях, 1-да, 0-нет', '0', 0  from org_unit ou;
