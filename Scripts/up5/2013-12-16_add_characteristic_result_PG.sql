insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (nextval('hibernate_sequence'), 'characteristic_result', 'Характеристика результата', '1');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'characteristic_result','Характеристика результата', '1', false  from org_unit ou;