insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'mkgu.wssecurity.keyStore','Наименование хранилища ключа', '', 0, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'mkgu.wssecurity.keyStore','Наименование хранилища ключа', '', 0, 'МКГУ'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'mkgu.wssecurity.keyStoreType','Тип хранилища ключа', '', 0, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'mkgu.wssecurity.keyStoreType','Тип хранилища ключа', '', 0, 'МКГУ'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'mkgu.wssecurity.keyStoreAlias','Алиас ключа в хранилище', '', 0, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'mkgu.wssecurity.keyStoreAlias','Алиас ключа в хранилище', '', 0, 'МКГУ'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'mkgu.wssecurity.keyStorePassword','Пароль ключа в хранилище', '', 0, 'МКГУ');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'mkgu.wssecurity.keyStorePassword','Пароль ключа в хранилище', '', 0, 'МКГУ'  from org_unit ou;