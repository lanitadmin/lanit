insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (gen_id( hibernate_sequence, 1), 'characteristic_result', 'Характеристика результата', '1');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'characteristic_result','Характеристика результата', '1', false  from org_unit ou;