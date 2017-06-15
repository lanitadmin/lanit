insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'allow_inn_request','Разрешить запрос ИНН в карточке заявителя', '1', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'allow_inn_request','Разрешить запрос ИНН в карточке заявителя', '1', false  from org_unit ou;
