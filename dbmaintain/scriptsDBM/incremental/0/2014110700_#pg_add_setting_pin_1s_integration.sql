insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'pin_1s_timer_period','Период срабатывания таймера (сек)', '10', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'pin_1s_timer_period','Период срабатывания таймера (сек)', '10', false  from org_unit ou;





insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'pin_1s_timer_directory','Путь к общедоступному каталогу', '', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'pin_1s_timer_directory','Путь к общедоступному каталогу', '', false  from org_unit ou;
