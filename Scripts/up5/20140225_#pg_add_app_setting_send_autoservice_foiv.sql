insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'send_auto_service_start_time','Время начала сбора информации для ФОИВ (с 0 до 24 ч)', '19', null);


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'send_auto_service_end_time','Время окончания сбора информации для ФОИВ (с 0 до 24 ч)', '6', null);