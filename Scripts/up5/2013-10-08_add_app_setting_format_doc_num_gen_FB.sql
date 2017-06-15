

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'key_doc_num_gen','Ключи для генерации номера документов', '[OGV],[YEAR],[COUNTER],[MONTH],[DAY]', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'key_doc_num_gen','Ключи для генерации номера документов', '[OGV],[YEAR],[COUNTER],[MONTH],[DAY]', false  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'can_edit_doc_num_gen','Возможность редактирования номера документов', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'can_edit_doc_num_gen','Возможность редактирования номера документов', '0', false  from org_unit ou;