insert into app_setting(id,owner,setting_id, setting_name,setting_value,is_pass) 
select gen_id(hibernate_sequence, 1),ou.owner, 'phone_cell_pattern', 'Шаблон заполнения полей Мобильный телефон', '8-XXX-XXX-XX-XX',null from org_unit ou