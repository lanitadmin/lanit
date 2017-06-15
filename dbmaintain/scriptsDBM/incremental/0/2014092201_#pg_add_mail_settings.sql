insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'smtp_type_authentication','Тип авторизации: TLS, SSL или пусто', '', false);
insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'smtp_type_authentication','Тип авторизации: TLS, SSL или пусто', '', false  from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'smtp_ssl_port','Порт для SSL авторизации. Если не задан, то берется из smtp_server_port', '', false);
insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'smtp_ssl_port','Порт для SSL авторизации. Если не задан, то берется из smtp_server_port', '', false  from org_unit ou;