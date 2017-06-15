insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'check_certificate','Проверка сертификата посредством веб-сервиса (1 - да, 0 - нет)', '0', false, 'Общие');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'check_certificate','Проверка сертификата посредством веб-сервиса (1 - да, 0 - нет)', '0', false, 'Общие'  from org_unit ou;