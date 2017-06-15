insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (hibernate_sequence.nextval, 'characteristic_result', 'Характеристика результата', '1');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'characteristic_result','Характеристика результата', '1', false  from org_unit ou;