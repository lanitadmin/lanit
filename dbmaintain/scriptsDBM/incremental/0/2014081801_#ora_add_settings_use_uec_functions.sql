insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'use_uec_functions','Использовать возможности УЭК в системе)', '1', null, null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select nextval('hibernate_sequence'), owner,'use_uec_functions','Использовать возможности УЭК в системе)', '1', null, null from org_unit;