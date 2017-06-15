
insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_timer_every_min','Периодичность запуска таймера в минутах', '5', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_timer_allowed_week_days','Разрешенные дни недели для запуска таймера, формат "1;1;1;1;1;0;0"', '1; 1; 1; 1; 1; 0; 0', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_timer_startTime','Время начала работы таймера', '09:00', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_timer_endTime','Время окончания работы таймера', '18:00', null, 'Интеграция с СМС сервисом');



insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_enabled','Разрешить интеграцию с СМС (Kannel)', '0', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_url','HTTP адрес Kannel для отправки СМС (http://localhost:13003/cgi-bin/sendsms)', 'http://localhost:13003/cgi-bin/sendsms', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_send_timeout','Время таймаута отсылки запроса к Kannel', '6000', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_from','Имя отправителя smsc', '', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_login','Логин пользователя Kannel', 'foo', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_password','Пароль пользователя Kannel', 'foo', 1, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_id','Имя сервиса smsc в Kannel', '', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_callback_url','Адрес для отправки отчета о доставке (http://localhost/delivery_report)', 'http://localhost/delivery_report', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_callback_mask','Маска типов отчета о доставке', '7', null, 'Интеграция с СМС сервисом');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'smsc_message_coding','Кодировка сообщения (0-2)', '1', null, 'Интеграция с СМС сервисом');



insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_enabled','Разрешить интеграцию с СМС (Kannel)', '0', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_url','HTTP адрес Kannel для отправки СМС (http://localhost:13003/cgi-bin/sendsms)', 'http://localhost:13003/cgi-bin/sendsms', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_send_timeout','Время таймаута отсылки запроса к Kannel', '6000', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_from','Имя отправителя smsc', '', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_login','Логин пользователя Kannel', 'foo', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_password','Пароль пользователя Kannel', 'foo', 1, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_id','Имя сервиса smsc в Kannel', '', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_callback_url','Адрес для отправки отчета о доставке (http://localhost/delivery_report)', 'http://localhost/delivery_report', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_callback_mask','Маска типов отчета о доставке', '7', null, 'Интеграция с СМС сервисом' from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, owner,'smsc_message_coding','Кодировка сообщения (0-2)', '1', null, 'Интеграция с СМС сервисом' from org_unit;