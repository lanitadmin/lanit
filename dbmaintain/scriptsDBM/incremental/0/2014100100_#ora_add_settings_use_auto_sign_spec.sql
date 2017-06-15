
insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'use_auto_sign_spec','Использовать возможности автоподписания ЭП-СП в системе', '0', null, null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'use_auto_sign_spec','Использовать возможности автоподписания ЭП-СП в системе', '0', null, null from org_unit;