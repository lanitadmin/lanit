
--insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'format_doc_num_gen','Формат номера документов (допустимые значения: [YEAR], [MONTH], [DAY], [COUNTER], [OGV])', '[YEAR]/[COUNTER]', false);

--insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
--select nextval('hibernate_sequence'), ou.owner,'format_doc_num_gen','Формат номера документов (допустимые значения: [YEAR], [MONTH], [DAY], [COUNTER], [OGV])', '[YEAR]/[COUNTER]', false  from org_unit ou;



insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'key_doc_num_gen','Ключи для генерации номера документов', '[OGV],[YEAR],[COUNTER],[MONTH],[DAY]', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'key_doc_num_gen','Ключи для генерации номера документов', '[OGV],[YEAR],[COUNTER],[MONTH],[DAY]', false  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'can_edit_doc_num_gen','Возможность редактирования номера документов', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'can_edit_doc_num_gen','Возможность редактирования номера документов', '0', false  from org_unit ou;