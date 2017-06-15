insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(gen_id( hibernate_sequence, 1 ), null,'mkgu.wssecurity.keyStore','Наименование хранилища ключа', '', false, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select gen_id( hibernate_sequence, 1 ), ou.owner,'mkgu.wssecurity.keyStore','Наименование хранилища ключа', '', false, 'МКГУ'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(gen_id( hibernate_sequence, 1 ), null,'mkgu.wssecurity.keyStoreType','Тип хранилища ключа', '', false, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select gen_id( hibernate_sequence, 1 ), ou.owner,'mkgu.wssecurity.keyStoreType','Тип хранилища ключа', '', false, 'МКГУ'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(gen_id( hibernate_sequence, 1 ), null,'mkgu.wssecurity.keyStoreAlias','Алиас ключа в хранилище', '', false, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select gen_id( hibernate_sequence, 1 ), ou.owner,'mkgu.wssecurity.keyStoreAlias','Алиас ключа в хранилище', '', false, 'МКГУ'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(gen_id( hibernate_sequence, 1 ), null,'mkgu.wssecurity.keyStorePassword','Пароль ключа в хранилище', '', false, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select gen_id( hibernate_sequence, 1 ), ou.owner,'mkgu.wssecurity.keyStorePassword','Пароль ключа в хранилище', '', false, 'МКГУ'  from org_unit ou;