-- Сброс настроек таблицы "Мои задачи" для всех пользователей и ролей

-- Удаление настроек колонок
delete from setting_table_field_value;
-- Удаление настроек для ролей и пользователей
delete from setting_table where role_code is not null or user_name is not null;

-- Видимые поля
insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,0,true,
(select id from setting_table_field where name = 'statusicon'),
(select id from setting_table where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,1,true,
(select id from setting_table_field where name = 'proc_ident.Komplekt_doc'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,2,true,
(select id from setting_table_field where name = 'create'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,3,true,
(select id from setting_table_field where name = 'started'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,4,true,
(select id from setting_table_field where name = 'limit'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,5,true,
(select id from setting_table_field where name = 'proc_ident.Zayavitel'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,6,true,
(select id from setting_table_field where name = 'act'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,7,true,
(select id from setting_table_field where name = 'proc_ident.Service'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,8,true,
(select id from setting_table_field where name = 'proc_ident.Gos_Org'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,9,true,
(select id from setting_table_field where name = 'proc_ident.lastSendSoap'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,10,true,
(select id from setting_table_field where name = 'proc_ident.docWait'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,11,true,
(select id from setting_table_field where name = 'do'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

-- Скрытые поля
insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,12,false,
(select id from setting_table_field where name = 'process'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,13,false,
(select id from setting_table_field where name = 'proc_ident.Registr_part'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,14,false,
(select id from setting_table_field where name = 'proc_ident.Kontr_part'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,15,false,
(select id from setting_table_field where name = 'proc_ident.komment'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),true,16,false,
(select id from setting_table_field where name = 'proc_ident.dateServEnd'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

-- Недоступные поля
insert into setting_table_field_value (id,enable,priority,visible,field_id,table_rule_id) 
values (nextval('hibernate_sequence'),false,17,false,
(select id from setting_table_field where name = 'status'),
(select id from SETTING_TABLE where role_code is null and user_name is null));

