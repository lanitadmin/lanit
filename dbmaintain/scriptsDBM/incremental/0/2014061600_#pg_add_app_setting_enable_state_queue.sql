insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
values(nextval('hibernate_sequence'), null,'enable_state_queue','Отображать состояние электронной очереди (1-да, 0-нет)', '0', false);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'enable_state_queue', 'Отображать состояние электронной очереди (1-да, 0-нет)', '0', nextval('hibernate_sequence'), owner from org_unit;