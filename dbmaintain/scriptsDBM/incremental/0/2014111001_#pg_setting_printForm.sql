insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'dp_allow_printForm','Разрешить сканирование печатных форм в КД', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select nextval('hibernate_sequence'), ou.owner,'dp_allow_printForm','Разрешить сканирование печатных форм в КД', '0', false  from org_unit ou;