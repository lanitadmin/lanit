insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'is_rebuild_request_list','Пересоздавать список запросов, 0-да, 1-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'is_rebuild_request_list','Пересоздавать список запросов, 0-да, 1-нет', '0', false  from org_unit ou;