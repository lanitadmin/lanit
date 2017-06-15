insert into setting_table_field (id,caption,name,table_def_id)
select nextval('hibernate_sequence'), 'Тест', 'test', id from setting_table_def where name='worklistSearch';

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id)
select nextval('hibernate_sequence'),true,0,true,(select id from setting_table_field where name='test'),id from setting_table;
