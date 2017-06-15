insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'scan_into_file','Настройка видимости кнопки "В файл": 1-видна, 0-скрыта', '1', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'scan_into_file','Настройка видимости кнопки "В файл": 1-видна, 0-скрыта', '1', 0  from org_unit ou;