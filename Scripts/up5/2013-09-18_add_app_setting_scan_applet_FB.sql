insert into app_setting (id, owner,setting_id,setting_name, setting_value) values(gen_id( hibernate_sequence, 1), null,'scan_into_file','Настройка видимости кнопки "В файл": 1-видна, 0-скрыта', '1');

insert into app_setting (id, owner,setting_id,setting_name, setting_value) 
select gen_id( hibernate_sequence, 1), ou.owner,'scan_into_file','Настройка видимости кнопки "В файл": 1-видна, 0-скрыта', '1'  from org_unit ou;