insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'field_type_value_not_choose','В поле "Тип услуги" присутствует значение "Не выбрано": 1-видно, 0-скрыто', '1', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'field_type_value_not_choose','В поле "Тип услуги" присутствует значение "Не выбрано": 1-видно, 0-скрыто', '1', 0  from org_unit ou;