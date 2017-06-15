insert into app_setting (id, owner, setting_id, setting_name, setting_value)
values(nextval('hibernate_sequence'), null,'saiku_rest_url','Адрес Saiku REST API', 'http://localhost/saiku-webapp-2.6');

insert into app_setting (id, owner, setting_id, setting_name, setting_value)
values(nextval('hibernate_sequence'), null,'saiku_username','Логин Saiku', 'admin');

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'saiku_password','Пароль Saiku', 'admin', true);
