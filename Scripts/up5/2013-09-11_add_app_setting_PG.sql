insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'field_value_not_choose','В поле "Отображать в инфокиоске" присутствует значение "Не выбрано": 1-видно, 0-скрыто', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'field_value_not_choose','В поле "Отображать в инфокиоске" присутствует значение "Не выбрано": 1-видно, 0-скрыто', '1', false  from org_unit ou;