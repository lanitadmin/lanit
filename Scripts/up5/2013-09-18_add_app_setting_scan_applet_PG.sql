insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'scan_into_file','Настройка видимости кнопки "В файл": 1-видна, 0-скрыта', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'scan_into_file','Настройка видимости кнопки "В файл": 1-видна, 0-скрыта', '1', false  from org_unit ou;