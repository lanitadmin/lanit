-- Сброс настроек таблицы "Мои задачи" для всех пользователей и ролей

-- Удаление настроек колонок
delete from setting_table_field_value;
-- Удаление настроек для ролей и пользователей
delete from setting_table where role_code is not null or user_name is not null;

-- Видимые поля
insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,0,1,
(select id from setting_table_field where name = 'statusicon'),
(select id from setting_table where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,1,1,
(select id from setting_table_field where name = 'proc_ident.Komplekt_doc'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,2,1,
(select id from setting_table_field where name = 'create'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,3,1,
(select id from setting_table_field where name = 'started'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,4,1,
(select id from setting_table_field where name = 'limit'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,5,1,
(select id from setting_table_field where name = 'proc_ident.Zayavitel'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,6,1,
(select id from setting_table_field where name = 'act'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,7,1,
(select id from setting_table_field where name = 'proc_ident.Service'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,8,1,
(select id from setting_table_field where name = 'proc_ident.Gos_Org'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,9,1,
(select id from setting_table_field where name = 'proc_ident.lastSendSoap'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,10,1,
(select id from setting_table_field where name = 'proc_ident.docWait'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,11,1,
(select id from setting_table_field where name = 'do'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

-- Скрытые поля
insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,12,0,
(select id from setting_table_field where name = 'process'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,13,0,
(select id from setting_table_field where name = 'proc_ident.Registr_part'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,14,0,
(select id from setting_table_field where name = 'proc_ident.Kontr_part'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,15,0,
(select id from setting_table_field where name = 'proc_ident.komment'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,1,16,0,
(select id from setting_table_field where name = 'proc_ident.dateServEnd'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

-- Недоступные поля
insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (hibernate_sequence.nextval,0,17,0,
(select id from setting_table_field where name = 'status'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

