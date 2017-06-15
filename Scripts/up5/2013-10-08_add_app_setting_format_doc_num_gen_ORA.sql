insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'key_doc_num_gen','Ключи для генерации номера документов', '[OGV],[YEAR],[COUNTER],[MONTH],[DAY]', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'key_doc_num_gen','Ключи для генерации номера документов', '[OGV],[YEAR],[COUNTER],[MONTH],[DAY]', 0  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'can_edit_doc_num_gen','Возможность редактирования номера документов', '0', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'can_edit_doc_num_gen','Возможность редактирования номера документов', '0', 0  from org_unit ou;