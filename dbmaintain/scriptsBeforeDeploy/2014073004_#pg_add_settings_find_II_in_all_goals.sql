insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'find_integration_info_in_all_goals','Искать информация об электронной интеграции во всех целях, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'find_integration_info_in_all_goals','Искать информация об электронной интеграции во всех целях, 1-да, 0-нет', '0', false  from org_unit ou;