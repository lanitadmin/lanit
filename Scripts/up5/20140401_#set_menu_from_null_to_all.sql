update app_setting
set setting_value=(select setting_value from app_setting where setting_id='application_menu_name' and owner is null)
where setting_id='application_menu_name' and owner is not null;