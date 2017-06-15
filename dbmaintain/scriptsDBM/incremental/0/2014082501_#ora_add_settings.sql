insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'is_rebuild_request_list','Пересоздавать список запросов, 0-да, 1-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'is_rebuild_request_list','Пересоздавать список запросов, 0-да, 1-нет', '0', 0  from org_unit ou;