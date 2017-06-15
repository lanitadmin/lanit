insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'field_type_value_not_choose','В поле "Тип услуги" присутствует значение "Не выбрано": 1-видно, 0-скрыто', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'field_type_value_not_choose','В поле "Тип услуги" присутствует значение "Не выбрано": 1-видно, 0-скрыто', '1', false  from org_unit ou;