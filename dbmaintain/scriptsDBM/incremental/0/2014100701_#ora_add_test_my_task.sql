insert into setting_table_field (id,caption,name,table_def_id)
select hibernate_sequence.nextval, 'Тест', 'test', id from setting_table_def where name='worklistSearch';

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id)
select hibernate_sequence.nextval,1,0,1,(select id from setting_table_field where name='test'),id from setting_table;
