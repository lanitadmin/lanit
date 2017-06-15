insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
values(hibernate_sequence.nextval, null,'enable_state_queue','Отображать состояние электронной очереди (1-да, 0-нет)', '0', 0);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'enable_state_queue', 'Отображать состояние электронной очереди (1-да, 0-нет)', '0', hibernate_sequence.nextval, owner from org_unit;