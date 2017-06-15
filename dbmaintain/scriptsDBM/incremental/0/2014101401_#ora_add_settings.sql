insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'allow_inn_request','Разрешить запрос ИНН в карточке заявителя', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'allow_inn_request','Разрешить запрос ИНН в карточке заявителя', '0', 0  from org_unit ou;
