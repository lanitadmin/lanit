insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_message_charset','Кодировка символов', 'UTF-8', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_message_charset','Кодировка символов', 'UTF-8', null, 'Интеграция с СМС сервисом' from org_unit;
