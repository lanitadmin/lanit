insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'use_auto_sign_spec','Использовать возможности автоподписания ЭП-СП в системе', '0', null, null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select nextval('hibernate_sequence'), owner,'use_auto_sign_spec','Использовать возможности автоподписания ЭП-СП в системе', '0', null, null from org_unit;