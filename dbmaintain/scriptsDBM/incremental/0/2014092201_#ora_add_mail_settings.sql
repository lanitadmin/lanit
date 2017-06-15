insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'smtp_type_authentication','Тип авторизации: TLS, SSL или пусто', '', 0);
insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'smtp_type_authentication','Тип авторизации: TLS, SSL или пусто', '', 0 from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'smtp_ssl_port','Порт для SSL авторизации. Если не задан, то берется из smtp_server_port', '', 0);
insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'smtp_ssl_port','Порт для SSL авторизации. Если не задан, то берется из smtp_server_port', '', 0 from org_unit ou;